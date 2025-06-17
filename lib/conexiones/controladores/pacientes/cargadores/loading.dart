import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:flutter/material.dart';

class CargadoresPacientes {
  static Future<bool> loadingActivity({required BuildContext context}) async {
    final statusNotifier = ValueNotifier<String>("Inicializando . . .");
    final subStatusNotifier = ValueNotifier<String>("Preparando valores . . .");
    final progressNotifier = ValueNotifier<double>(0.0);
    bool cancelado = false;
    Map<String, dynamic> valores = {};

    Operadores.showProgressDialog(
      context: context,
      statusNotifier: statusNotifier,
      subStatusNotifier: subStatusNotifier,
      progressNotifier: progressNotifier,
      onCancel: () {
        cancelado = true;
        Navigator.of(context).pop();
      },
    );

    final totalModulos = 9;
    int modActual = 0;

    void updateProgress(String subStatus) {
      subStatusNotifier.value = subStatus;
      progressNotifier.value = (++modActual) / totalModulos;
    }

    try {
      statusNotifier.value = "Inicializando Valores del paciente...";

      Escalas.serviciosHospitalarios = await Archivos.listFromText(
        path: 'assets/diccionarios/Servicios.txt',
        splitChar: ',',
      );
      updateProgress("Diccionario de servicios cargado");

      valores.addAll(Pacientes.Paciente);

      // Llamadas en segundo plano
      updateProgress("Iniciando paquetes de datos . . . ");
      Future.microtask(() {
        Pacientes.getImage();
        Pacientes.getParaclinicosHistorial(reload: true);
        Pacientes.getLastParaclinicos(reload: true);
      });
      updateProgress("Consultando paquetes de datos de los antecedentes . . . ");
      Future.microtask(() {
        Patologicos.registros();
        Vitales.registros(context);
        Quirurgicos.registros();
        Alergicos.registros();
        Hospitalizaciones.ultimoRegistro();
      });
      updateProgress("Iniciando paquetes de datos de la hospitalización . . . ");
      Future.microtask(() {
        Ventilaciones.consultarRegistro();
        Ventilaciones.ultimoRegistro();
        Balances.consultarRegistro();
        Balances.ultimoRegistro();
        Auxiliares.registros();
      });

      // if (cancelado) return false;
      // final vento = await Actividades.consultarId(
      //   Databases.siteground_database_reghosp,
      //   Ventilaciones.ventilacion['consultLastQuery'],
      //   Pacientes.ID_Paciente,
      //   emulated: true,
      // );
      // valores.addAll(vento);
      // updateProgress("Ventilación consultada");

      // if (cancelado) return false;
      // final bala = await Actividades.consultarId(
      //   Databases.siteground_database_reghosp,
      //   Balances.balance['consultLastQuery'],
      //   Pacientes.ID_Paciente,
      //   emulated: true,
      // );
      // valores.addAll(bala);
      // updateProgress("Balances consultados");
      if (cancelado) return false;
      final aux = await Auxiliares.ultimoRegistro();
      valores.addAll(aux);
      updateProgress("Auxiliares consultados");

      if (cancelado) return false;
      final hosp = await Actividades.consultarId(
        Databases.siteground_database_reghosp,
        Hospitalizaciones.hospitalizacion['consultLastQuery'],
        Pacientes.ID_Paciente,
        emulated: true,
      );
      valores.addAll(hosp);
      updateProgress("Hospitalización consultada");

      Valores.fromJson(valores);

      // if (context.mounted) Navigator.of(context).pop();
      return true;
    } catch (e, stack) {
      if (!cancelado && context.mounted) {
        Navigator.of(context).pop();
        Operadores.alertActivity(
          message: "ERROR - Valores: $e",
          context: context,
          tittle: 'Error al Iniciar Valores . . .',
          onAcept: () => Navigator.of(context).pop(),
        );
      }
      Terminal.printAlert(message: "ERROR - Valores : : $e : $stack");
      Operadores.alertActivity(
        context: context,
        tittle: "Error al Consultar paquetes de Valores . . . ",
        message: "$e : : $stack",
        onAcept: () => Navigator.of(context).pop(),
      );
      return false;
    } finally {
      statusNotifier.dispose();
      subStatusNotifier.dispose();
      progressNotifier.dispose();
    }
  }
}
