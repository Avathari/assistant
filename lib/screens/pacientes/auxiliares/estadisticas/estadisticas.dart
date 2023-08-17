import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:flutter/foundation.dart';
import 'package:assistant/conexiones/conexiones.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';

class EstadisticasPacientes extends StatefulWidget {
  const EstadisticasPacientes({Key? key}) : super(key: key);

  @override
  State<EstadisticasPacientes> createState() => _EstadisticasPacientesState();
}

class _EstadisticasPacientesState extends State<EstadisticasPacientes> {
  Map<String, dynamic> data = {
    // "Total_Pacientes": 0,
    "Total_Mujeres": 0,
    "Total_Hombres": 0,
    //
    "Total_Hospitalizacion": 0,
    "Total_Consulta": 0,
    "Total_Matutino": 0,
    "Total_Vespertino": 0,
    "Total_Vivos": 0,
    "Total_Fallecidos": 0,
    "Total_Indigenas": 0,
    "Total_No_Indigenas": 0,
    "Total_Hablantes": 0,
    "Total_No_Hablantes": 0,
    "Total_Pacientes": 0,
  };
  var statScrollController = ScrollController();

  var fileAssocieted = 'assets/vault/patientsStats.json';

  @override
  void initState() {
    Terminal.printWarning(message: " . . . Iniciando Actividad - Estádisticas del Repositorio de Pacientes");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        data = value[0];
      });
    }).onError((error, stackTrace) {
      Actividades.detalles(Databases.siteground_database_regpace,
          Pacientes.pacientes['pacientesStadistics'])
          .then((value) {
        setState(() {
          data = value;
          Archivos.createJsonFromMap([data], filePath: 'assets/vault/patientsStats.json');
        });
      });
    });
    Terminal.printWarning(message: " . . . Actividad Iniciada");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: ContainerDecoration.roundedDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(),
              child: const Text(
                'Estadisticas de Pacientes',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: isMobile(context) ? 2 : 1,
              child: isTablet(context) || isMobile(context)
                  ? Column(
                      children: [
                        Flexible(
                            flex: 2,
                            child: data['Total_Pacientes'] != 0
                                ? PieChart(PieChartData(
                                    sections: listChartSections(
                                        data['Total_Pacientes'])))
                                : Container()),
                        Flexible(
                            flex: 3,
                            child: SingleChildScrollView(
                              controller: ScrollController(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  tileStat(Icons.person, "Total de Pacientes",
                                      data['Total_Pacientes']),
                                  tileStat(Icons.person_add_outlined,
                                      "Total de Activos", data['Total_Vivos']),
                                  tileStat(
                                      Icons.person_off_outlined,
                                      "Total de Fallecidos",
                                      data['Total_Fallecidos'])
                                ],
                              ),
                            ))
                      ],
                    )
                  : Row(
                      children: [
                        Flexible(
                            flex: 2,
                            child: data['Total_Pacientes'] != 0
                                ? PieChart(PieChartData(
                                    sections: listChartSections(
                                        data['Total_Pacientes'])))
                                : Container()),
                        Flexible(
                            flex: 3,
                            child: SingleChildScrollView(
                              controller: ScrollController(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  tileStat(Icons.person, "Total de Pacientes",
                                      data['Total_Pacientes']),
                                  tileStat(Icons.person_add_outlined,
                                      "Total de Activos", data['Total_Vivos']),
                                  tileStat(
                                      Icons.person_off_outlined,
                                      "Total de Fallecidos",
                                      data['Total_Fallecidos'])
                                ],
                              ),
                            ))
                      ],
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
                flex: 2,
                //fit: FlexFit.tight,
                child: ListView.builder(
                    //shrinkWrap: true,
                    controller: statScrollController,
                    itemCount: Pacientes.Categorias.length,
                    itemBuilder: (BuildContext context, index) {
                      //print("INDEX BUILDER $index ${Pacientes.Categorias[index]} ${data!.values.toList().elementAt(index).runtimeType}");
                      //print("data data $data");
                      if (index <= data.length) {
                        return tileStat(Icons.list, Pacientes.Categorias[index],
                            data.values.toList().elementAt(index));
                      } else {
                        return Container();
                      }
                    }))
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> listChartSections(int total) {
    List<PieChartSectionData> list = [];
    Indices.indice = 0;

    data.forEach((key, value) {
      // # . . . # # # . . . #
      //print("total ${value!} $total ${total / value!}");
      double val = ((value! * 100) / total);
      // # . . . # # # . . . #
      list.add(PieChartSectionData(
        color: Colores.locales[Indices.indice],
        value: (val),
        title: "${val.toStringAsFixed(1)} %",
        radius: 20,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ));
      Indices.indice++;
    });
    return list;
  }

  Padding tileStat(IconData? icon, String tittle, int stat) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 0, top: 0),
      child: ListTile(
        leading: Icon(icon!, color: Colors.white),
        title: Text(
          tittle,
          style: const TextStyle(
              fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          "$stat Pacientes",
          style: const TextStyle(fontSize: 10, color: Colors.white),
        ),
      ),
    );
  }
}

