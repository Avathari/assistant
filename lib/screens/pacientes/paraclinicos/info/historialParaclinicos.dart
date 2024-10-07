
import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/ChartLine.dart';
import 'package:flutter/material.dart';

class HistorialParaclinicos extends StatefulWidget {
  List<DataColumn>? columns;
  List<DataRow>? rows;

  HistorialParaclinicos({super.key});

  @override
  State<HistorialParaclinicos> createState() => _HistorialParaclinicosState();
}

class _HistorialParaclinicosState extends State<HistorialParaclinicos> {
  @override
  void initState() {
    widget.columns = [];
    widget.rows = [];

    // COLUMNAS
    for (var parat in Pacientes.Paraclinicos![0].keys) {
      // Terminal.printData(message: parat.toString());
      setState(() => widget.columns!.add(DataColumn(
              label: Text(
            "$parat",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ))));
    }
    // CELDAS
    for (var parat in Pacientes.Paraclinicos!) {
      // Terminal.printData(message: parat.toString());
      setState(() => widget.rows!.add(DataRow(cells: [
            DataCell(Text(
              parat['ID_Laboratorio'].toString(),
              style: Styles.textSyleGrowth(fontSize: 8),
            )),
            DataCell(Text(
              parat['Fecha_Registro'],
              style: Styles.textSyleGrowth(fontSize: 8),
            )),
            DataCell(Text(
              parat['Tipo_Estudio'],
              style: Styles.textSyleGrowth(fontSize: 8),
            )),
            DataCell(Text(
              parat['Estudio'],
              style: Styles.textSyleGrowth(fontSize: 8),
            )),
            DataCell(Text(
              parat['Resultado'],
              style: Styles.textSyleGrowth(fontSize: 8),
            )),
            DataCell(Text(
              parat['Unidad_Medida'],
              style: Styles.textSyleGrowth(fontSize: 8),
            )),
          ])));
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: ChartLine(
                        chartTittle: "Niveles de Hemoglobina",
                        dymValues: [
                      Listas.listFromMapWithTwoKey(
                        Pacientes.Paraclinicos!,
                        firstKeySearched: "Estudio",
                        secondKeySearched: ["Hemoglobina", "Eritrocitos", "Leucocitos Totales"],
                      ),
                    ])),
                // Expanded(
                //     child: ChartLine(
                //       chartTittle: "Niveles de Leucocitos",
                //       dymValues:
                //       Listas.listFromMapWithTwoKey(Pacientes.Paraclinicos!,
                //         firstKeySearched: "Estudio",
                //         secondKeySearched: "Leucocitos Totales",
                //       ),
                //     )),
                // Expanded(
                //     child: ChartLine(
                //       chartTittle: "Niveles de Leucocitos",
                //       dymValues:
                //       Listas.listFromMapWithTwoKey(Pacientes.Paraclinicos!,
                //         firstKeySearched: "Estudio",
                //         secondKeySearched: "Leucocitos Totales",
                //       ),
                //     )),
                // Expanded(
                //     child: ChartLine(
                //       chartTittle: "Niveles de Plaquetas",
                //       dymValues:
                //       Listas.listFromMapWithTwoKey(Pacientes.Paraclinicos!,
                //         firstKeySearched: "Estudio",
                //         secondKeySearched: "Plaquetas",
                //       ),
                //     )),
              ],
            ),
          ),
          // CrossLine(height: 10),
          Expanded(
            child: SingleChildScrollView(
              controller: ScrollController(),
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                controller: ScrollController(),
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: widget.columns!, // datatable widget
                  rows: widget.rows!, //
                  decoration: BoxDecoration(
                    color: Theming.terciaryColor,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  dataRowColor: WidgetStateProperty.all(Theming.bdColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
