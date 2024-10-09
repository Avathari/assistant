import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/info/conclusiones.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/ventometr%C3%ADas.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/detalles/pacientesListScreen.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/trabajoCardiaco.dart';
import 'package:assistant/screens/pacientes/pacientes.dart';
import 'package:assistant/screens/pacientes/paraclinicos/auxiliares/conmutadorParaclinicos.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:flutter/material.dart';

class Menus {

  static Widget accionesConPacientes(BuildContext context) {
    return PopupMenuButton<int>(
      tooltip: Sentences.add_usuario,
      icon: const Icon(Icons.person_add),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          onTap: () => Cambios.toNextPage(context, OperacionesPacientes(
            operationActivity: Constantes.Register,
          ),),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("Agregar un Nuevo Paciente . . . ",
                style: Styles.textSyleGrowth(fontSize: 8)),
          ),
        ),
        PopupMenuItem(
          value: 2,
          onTap: () => Cambios.toNextPage(context, PacientesListScreen()),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("Agregar Nuevo Listado de Pacientes . . . ",
                style: Styles.textSyleGrowth(fontSize: 8)),
          ),
        ),
        // PopupMenuItem(
        //   value: 3,
        //   onTap: () => Datos.portapapeles(
        //       context: context, text: Pacientes.numeroPaciente!),
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 10.0),
        //     child: Text("Numero del Paciente",
        //         style: Styles.textSyleGrowth(fontSize: 8)),
        //   ),
        // ),
        // PopupMenuItem(
        //   value: 4,
        //   onTap: () => Datos.portapapeles(
        //       context: context, text: Pacientes.datosIniciales!),
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 10.0),
        //     child: Text("Datos Iniciales",
        //         style: Styles.textSyleGrowth(fontSize: 8)),
        //   ),
        // ),
      ],
      offset: const Offset(0, 100),
      color: Theming.cuaternaryColor,
      elevation: 2,
    );
  }
  //
  static Widget popUpIdentificaciones(BuildContext context) {
    return PopupMenuButton<int>(
      tooltip: "Datos Generales",
      icon: const Icon(Icons.medical_information),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          onTap: () => Datos.portapapeles(
              context: context, text: Pacientes.nombreCompleto!),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("Nombre Completo",
                style: Styles.textSyleGrowth(fontSize: 8)),
          ),
        ),
        PopupMenuItem(
          value: 2,
          onTap: () => Datos.portapapeles(
              context: context, text: Pacientes.numeroAfiliacion!),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("Número de Afiliación",
                style: Styles.textSyleGrowth(fontSize: 8)),
          ),
        ),
        PopupMenuItem(
          value: 3,
          onTap: () => Datos.portapapeles(
              context: context, text: Pacientes.numeroPaciente!),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("Numero del Paciente",
                style: Styles.textSyleGrowth(fontSize: 8)),
          ),
        ),
        PopupMenuItem(
          value: 4,
          onTap: () => Datos.portapapeles(
              context: context, text: Pacientes.datosIniciales!),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("Datos Iniciales",
                style: Styles.textSyleGrowth(fontSize: 8)),
          ),
        ),
      ],
      offset: const Offset(0, 100),
      color: Theming.cuaternaryColor,
      elevation: 2,
    );
  }

  static Widget popUpVitales(BuildContext context) {
    return PopupMenuButton<int>(
      tooltip: "Vitales . . . ",
      icon: const Icon(Icons.medical_information),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          onTap: () => Datos.portapapeles(
              context: context, text: Antropometrias.vitalesAbreviado),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("Vitales abreviado",
                style: Styles.textSyleGrowth(fontSize: 8)),
          ),
        ),
      ],
      offset: const Offset(0, 100),
      color: Theming.cuaternaryColor,
      elevation: 2,
    );
  }

  static Widget popUpVentometrias(BuildContext context) {
    return PopupMenuButton<int>(
      tooltip: "Análisis Ventilatorio",
      icon: const Icon(Icons.wind_power_outlined),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          onTap: () => Datos.portapapeles(
              context: context, text: Ventometrias.ventilador),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("Análisis de Ventilador",
                style: Styles.textSyleGrowth(fontSize: 8)),
          ),
        ),
        PopupMenuItem(
          value: 2,
          onTap: () => Datos.portapapeles(
              context: context, text: Ventometrias.ventiladorCorto),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("Análisis Corto de Ventilador",
                style: Styles.textSyleGrowth(fontSize: 8)),
          ),
        ),
        PopupMenuItem(
          value: 3,
          onTap: () => Datos.portapapeles(
              context: context, text: Ventometrias.ventilatorios),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("Análisis de Ventilador",
                style: Styles.textSyleGrowth(fontSize: 8)),
          ),
        ),
      ],
      offset: const Offset(0, 100),
      color: Theming.cuaternaryColor,
      elevation: 2,
    );
  }

  static Widget popUpTerapia(BuildContext context) {
    return PopupMenuButton<int>(
      tooltip: "Exploración de Críticos",
      icon: const Icon(Icons.panorama_fish_eye),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          onTap: () => Datos.portapapeles(
              context: context, text: Formatos.exploracionTerapia),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("Exploración de Terapia",
                style: Styles.textSyleGrowth(fontSize: 8)),
          ),
        ),
        PopupMenuItem(
          value: 1,
          onTap: () => Datos.portapapeles(
              context: context, text: Formatos.exploracionTerapiaBreve),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("Exploración de Terapia Breve",
                style: Styles.textSyleGrowth(fontSize: 8)),
          ),
        ),
        PopupMenuItem(
          value: 1,
          onTap: () => Datos.portapapeles(
              context: context, text: Formatos.exploracionTerapiaCorta),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("Exploración de Terapia Corta",
                style: Styles.textSyleGrowth(fontSize: 8)),
          ),
        ),
        PopupMenuItem(
          value: 1,
          onTap: () => Datos.portapapeles(
              context: context, text: Formatos.exploracionTerapiaCortaSimplificada),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("Exploración de Terapia Simplificada",
                style: Styles.textSyleGrowth(fontSize: 8)),
          ),
        ),
      ],
      offset: const Offset(0, 100),
      color: Theming.cuaternaryColor,
      elevation: 1,
    );
  }

  //
  static Widget popUpLaboratorios(BuildContext context) {
    return PopupMenuButton<int>(
      tooltip: "Rutinas de Laboratorio",
      icon: const Icon(size: 28, Icons.ad_units, color: Colors.grey),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          onTap: () => Cambios.toNextActivity(context,
              tittle: 'Anexión de la Rutina ',
              onOption: () => Operadores.openDialog(
                  context: context, chyldrim: const Conclusiones()),
              chyld: ConmutadorParaclinicos(categoriaEstudio: "Rutina")),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("Anexión de la Rutina",
                style: Styles.textSyleGrowth(fontSize: 8)),
          ),
        ),
        PopupMenuItem(
          value: 2,
          onTap: () => Cambios.toNextActivity(context,
              tittle: 'Taller Gasométrico ',
              onOption: () => Operadores.openDialog(
                  context: context, chyldrim: const TrabajoCardiaco()),
              chyld: ConmutadorParaclinicos(categoriaEstudio: "Taller Gasométrico")),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("Taller Gasométrico ",
                style: Styles.textSyleGrowth(fontSize: 8)),
          ),
        ),
        //
      ],
      offset: const Offset(0, 100),
      color: Theming.cuaternaryColor,
      elevation: 1,
    );
  }

  static Widget popUpLaboratoriosAuxiliar(BuildContext context) {
    return PopupMenuButton<int>(
      tooltip: "Revisión de Laboratorios",
      icon: const Icon(Icons.video_label_outlined),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          onTap: () => Operadores.selectOptionsActivity(
            context: context,
            tittle: "Elija la fecha de los estudios . . . ",
            options: Listas.listWithoutRepitedValues(
              Listas.listFromMapWithOneKey(
                Pacientes.Paraclinicos!,
                keySearched: 'Fecha_Registro',
              ),
            ),
            onClose: (value) {
              Datos.portapapeles(
                  context: context,
                  text: Auxiliares.porFecha(fechaActual: value));
            },
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: GrandIcon(
              iconData: Icons.checklist_rtl,
              labelButton: "Laboratorios",
              onPress: () {
                Operadores.selectOptionsActivity(
                  context: context,
                  tittle: "Elija la fecha de los estudios . . . ",
                  options: Listas.listWithoutRepitedValues(
                    Listas.listFromMapWithOneKey(
                      Pacientes.Paraclinicos!,
                      keySearched: 'Fecha_Registro',
                    ),
                  ),
                  onClose: (value) {
                      Datos.portapapeles(
                          context: context,
                          text: Auxiliares.porFecha(fechaActual: value));
                  },
                );
              },
            ),
          ),
        ),
        PopupMenuItem(
          value: 2,
          onTap: () => {},
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: GrandIcon(
              iconData: Icons.list_alt_sharp,
              labelButton: "Laboratorios",
              onPress: () {
                Datos.portapapeles(
                    context: context, text: Auxiliares.historial());
              },
              onLongPress: () {
                Datos.portapapeles(
                    context: context,
                    text: Auxiliares.historial(esAbreviado: true));
              },
            ),
          ),
        ),
        PopupMenuItem(
          value: 3,
          onTap: () => {},
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: GrandIcon(
              iconData: Icons.line_style,
              labelButton: "Laboratorios",
              onPress: () {
                Datos.portapapeles(
                    context: context, text: Auxiliares.getUltimo());
              },
              onLongPress: () {
                Datos.portapapeles(
                    context: context,
                    text: Auxiliares.getUltimo(esAbreviado: true));
              },
            ),
          ),
        ),
        PopupMenuItem(
          value: 4,
          onTap: () => {},
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: GrandIcon(
              iconData: Icons.linear_scale_rounded,
              labelButton: "Actual e Historial",
              onPress: () {
                Datos.portapapeles(
                    context: context,
                    text: Auxiliares.getUltimo(withoutInsighs: true));
              },
              onLongPress: () {
                Datos.portapapeles(
                    context: context,
                    text: Auxiliares.historial(withoutInsighs: true));
              },
            ),
          ),
        ),
      ],
      offset: const Offset(0, 100),
      color: Theming.cuaternaryColor,
      elevation: 2,
    );
  }
  static Widget popUpLaboratoriosEspeciales(BuildContext context) {
    return PopupMenuButton<int>(
      tooltip: "Revisión de Especiales",
      icon: const Icon(Icons.account_balance_wallet_sharp),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          onTap: () => {},
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: GrandIcon(
              iconData: Icons.speaker,
              labelButton: "Estudios Especiales . . . ",
              onPress: () {
                Datos.portapapeles(
                    context: context, text: Auxiliares.getEspeciales());
              },
              onLongPress: () {
                Datos.portapapeles(
                    context: context, text: Auxiliares.getEspeciales());
              },
            ),
          ),
        ),
        PopupMenuItem(
          value: 2,
          onTap: () => {},
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: GrandIcon(
              iconData: Icons.hourglass_bottom,
              labelButton: "Cultivos Recabados . . . ",
              onPress: () {
                Datos.portapapeles(
                    context: context, text: Auxiliares.getCultivos());
              },
              onLongPress: () {
                Datos.portapapeles(
                    context: context, text: Auxiliares.getCultivos());
              },
            ),
          ),
        ),

        PopupMenuItem(
          value: 3,
          onTap: () => {},
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: GrandIcon(
              iconData: Icons.linear_scale,
              labelButton: "Marcadores Cardiacos . . . ",
              onPress: () {
                Datos.portapapeles(
                    context: context, text: Auxiliares.getCurvaCardiaca());
              },
              onLongPress: () {
                Datos.portapapeles(
                    context: context, text: Auxiliares.getCurvaCardiaca());
              },
            ),
          ),
        ),
      ],
      offset: const Offset(0, 100),
      color: Theming.cuaternaryColor,
      elevation: 2,
    );
  }
}
