import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/ThreeLabelText.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';

class EstadisticasVitales extends StatefulWidget {
  const EstadisticasVitales({Key? key}) : super(key: key);

  @override
  State<EstadisticasVitales> createState() => _EstadisticasVitalesState();
}

class _EstadisticasVitalesState extends State<EstadisticasVitales> {
  Map<String, dynamic> data = {
    "Promedio_TAS": '0',
    "Promedio_TAD": '0',
    "Promedio_FC": '0',
    "Promedio_FR": '0',
    "Total_Registros": '0'
  };
  var statScrollController = ScrollController();

  @override
  void initState() {
    Actividades.detallesById(Databases.siteground_database_regpace,
        Vitales.vitales['vitalesStadistics'], Pacientes.ID_Paciente,
        emulated: true)
        .then((value) {
      setState(() {
        data = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TittlePanel(
          textPanel: 'Estadisticas de signos vitales del Paciente',
        ),
        ThreeLabelTextAline(
          padding: 8.0,
          firstText: 'Total de Registros',
          secondText: data['Total_Registros'],
        ),
        const CrossLine(),
        SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              ThreeLabelTextAline(
                padding: 2.0,
                firstText: Vitales.Categorias[0],
                secondText:
                double.parse(data['Promedio_TAS']).toStringAsFixed(0),
                thirdText: 'mmHg',
              ),
              ThreeLabelTextAline(
                padding: 2.0,
                firstText: Vitales.Categorias[1],
                secondText:
                double.parse(data['Promedio_TAD']).toStringAsFixed(0),
                thirdText: 'mmHg',
              ),
              ThreeLabelTextAline(
                padding: 2.0,
                firstText: Vitales.Categorias[2],
                secondText:
                double.parse(data['Promedio_FC']).toStringAsFixed(0),
                thirdText: 'L/min',
              ),
              ThreeLabelTextAline(
                padding: 2.0,
                firstText: Vitales.Categorias[3],
                secondText:
                double.parse(data['Promedio_FR']).toStringAsFixed(0),
                thirdText: 'Resp/min',
              ),
            ],
          ),
        )
      ],
    );
  }
}
