import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/info/conclusiones.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/ventometr%C3%ADas.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/trabajoCardiaco.dart';
import 'package:assistant/screens/pacientes/paraclinicos/auxiliares/conmutadorParaclinicos.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';

class Menus {
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
                  context: context, chyldrim: TrabajoCardiaco()),
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
}
