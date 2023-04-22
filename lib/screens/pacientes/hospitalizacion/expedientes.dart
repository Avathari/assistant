import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/Switched.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';

class ExpedientesClinicos extends StatefulWidget {
  const ExpedientesClinicos({Key? key}) : super(key: key);

  @override
  State<ExpedientesClinicos> createState() =>
      _ExpedientesClinicosState();
}

class _ExpedientesClinicosState
    extends State<ExpedientesClinicos> {

  @override
  void initState() {
    Actividades.consultarId(Databases.siteground_database_reghosp,
            Expedientes.expedientes['consultQuery'], Pacientes.ID_Hospitalizacion)
        .then((response) {
      print("RESPUESTA $response");
      setState(() {
        // *********** ********* *********
        Valores.isPortada = Dicotomicos.fromInt(response['POR'], toBoolean: true) as bool?;
        Valores.isHistoriaClinica = Dicotomicos.fromInt(response['HIS'], toBoolean: true) as bool?;
        Valores.isNotaIngreso = Dicotomicos.fromInt(response['ING'], toBoolean: true) as bool?;
        Valores.isEvaluacionInicial = Dicotomicos.fromInt(response['EVA'], toBoolean: true) as bool?;
          Valores.isValoracionVademecum = Dicotomicos.fromInt(response['VAL'], toBoolean: true) as bool?;
        Valores.isConsentimientos = Dicotomicos.fromInt(response['CON'], toBoolean: true) as bool?;
        Valores.isOrdenado = Dicotomicos.fromInt(response['ORD'], toBoolean: true) as bool?;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isMobile(context) ? mobileView() : otherView();
  }

  otherView() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TittlePanel(textPanel: 'Cumplimiento del Expediente Clínico'),
          CrossLine(),
          Switched(
              tittle: 'Hoja Frontal',
              onChangeValue: (value) {
                setState(() {
                  Valores.isPortada = value;
                });
              },
              isSwitched: Valores.isPortada),
          Switched(
            tittle: 'Historia Clínica',
            onChangeValue: (value) {
              setState(() {
                Valores.isHistoriaClinica = value;
              });
            },
            isSwitched: Valores.isHistoriaClinica,
          ),
          Switched(
              tittle: 'Nota de Ingreso',
              onChangeValue: (value) {
                setState(() {
                  Valores.isNotaIngreso = value;
                });
              },
              isSwitched: Valores.isNotaIngreso),
          CrossLine(),
          Switched(
              tittle: 'Consentimientos Informados',
              onChangeValue: (value) {
                setState(() {
                  Valores.isConsentimientos = value;

                });
              },
              isSwitched: Valores.isConsentimientos),
          Switched(
            tittle: 'Valoración Vademecum',
            onChangeValue: (value) {
              setState(() {
                Valores.isValoracionVademecum = value;
              });
            },
            isSwitched: Valores.isValoracionVademecum,
          ),
          Switched(
              tittle: 'Evaluación Inicial',
              onChangeValue: (value) {
                setState(() {
                  Valores.isEvaluacionInicial = value;

                });
              },
              isSwitched: Valores.isEvaluacionInicial),
          CrossLine(),
          Switched(
              tittle: 'Expediente Ordenado',
              onChangeValue: (value) {
                setState(() {
                  Valores.isOrdenado = value;
                });
              },
              isSwitched: Valores.isOrdenado),
        ],
      ),
    );
  }

  mobileView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      controller: ScrollController(),
      child: Column(
        children: [
          TittlePanel(textPanel: 'Cumplimiento del Expediente Clínico'),
          CrossLine(),
          Switched(
              tittle: 'Hoja Frontal',
              onChangeValue: (value) {
                setState(() {
                  Valores.isPortada = value;
                });
              },
              isSwitched: Valores.isPortada),
          Switched(
            tittle: 'Historia Clínica',
            onChangeValue: (value) {
              setState(() {
                Valores.isHistoriaClinica = value;
              });
            },
            isSwitched: Valores.isHistoriaClinica,
          ),
          Switched(
              tittle: 'Nota de Ingreso',
              onChangeValue: (value) {
                setState(() {
                  Valores.isNotaIngreso = value;
                });
              },
              isSwitched: Valores.isNotaIngreso),
          CrossLine(),
          Switched(
              tittle: 'Consentimientos',
              onChangeValue: (value) {
                setState(() {
                  Valores.isConsentimientos = value;

                });
              },
              isSwitched: Valores.isConsentimientos),
          Switched(
            tittle: 'Valoración Vademecum',
            onChangeValue: (value) {
              setState(() {
                Valores.isValoracionVademecum = value;
              });
            },
            isSwitched: Valores.isValoracionVademecum,
          ),
          Switched(
              tittle: 'Evaluación Inicial',
              onChangeValue: (value) {
                setState(() {
                  Valores.isEvaluacionInicial = value;

                });
              },
              isSwitched: Valores.isEvaluacionInicial),
          CrossLine(),
          Switched(
              tittle: 'Expediente Ordenado',
              onChangeValue: (value) {
                setState(() {
                  Valores.isOrdenado = value;
                });
              },
              isSwitched: Valores.isOrdenado),
        ],
      ),
    );
  }
}
