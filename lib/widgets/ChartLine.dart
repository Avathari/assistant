import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/RoundedPanel.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartLine extends StatefulWidget {
  //
  String? chartTittle;
  bool? withTittles;
  List? tittles;
  //
  double? bottonTileInterval;
  //
  List<List> dymValues = [];
  //
  List<LineChartBarData>? spotsVals = [];
  List<dynamic>? bottomTittles = [];
  List<List<double>>? values = [];
  //
  double? maxY, minY;

  ChartLine({
    super.key,
    this.chartTittle = "",
    this.minY = 0,
    this.maxY = 30,
    this.tittles,
    this.withTittles = false,
    this.bottonTileInterval = 1.0,
    required this.dymValues,
  });

  @override
  State<ChartLine> createState() => _ChartLineState();
}

class _ChartLineState extends State<ChartLine> {
  @override
  void initState() {
    setState(() {
      if (widget.dymValues[0].isNotEmpty) {
        getValues();
      } else {
        widget.dymValues = [
          ["0000/00/00", 0, 0, 0, 0, 0, 0],
          ["0000/00/00", 0, 0, 0, 0, 0, 0],
          ["0000/00/00", 0, 0, 0, 0, 0, 0],
          ["0000/00/00", 0, 0, 0, 0, 0, 0],
          ["0000/00/00", 0, 0, 0, 0, 0, 0],
          ["0000/00/00", 0, 0, 0, 0, 0, 0],
        ];
        widget.tittles = [
          'T. Sistólica',
          'T. Diastólica',
          'F. Cardiaca',
          'F. Respiratoria',
          'T. Corporal',
          'SPO2 %',
        ];
        widget.bottomTittles = [
          "0000/00/00",
          "0000/00/00",
          "0000/00/00",
          "0000/00/00",
          "0000/00/00",
          "0000/00/00",
        ];
        getValues();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("widget.dymValues! : ${widget.dymValues}");
    // print("widget.spotsVals! : ${widget.spotsVals!}");
    // print("widget.tittles! : ${widget.tittles! ?? ""}");
    // print("widget.bottomTittles! : ${widget.bottomTittles!}");

    //TittlePanel(textPanel: widget.chartTittle!),
    return TittleContainer(
      centered: true,
      tittle: widget.chartTittle!,
      padding: 15.0,
      child: Row(
        children: [
          Expanded(
            flex: widget.withTittles! ? 6 : 1,
            child: LineChart(LineChartData(
                minY: widget.minY,
                maxY: widget.maxY,
                gridData: FlGridData(
                    show: true,
                    horizontalInterval: widget.maxY! / 5,
                    drawHorizontalLine: true,
                    drawVerticalLine: false),
                borderData: FlBorderData(show: false),
                titlesData: getTitleData(),
                lineBarsData: widget.spotsVals!)),
          ),
          widget.withTittles!
              ? Expanded(
                  flex: widget.withTittles! ? 1 : 2,
                  child: RoundedPanel(
                    padding: 2.0,
                    child: ListView.separated(
                        controller: ScrollController(),
                        itemCount: widget.tittles!.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 0.1);
                        },
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              setState(() {
                                widget.spotsVals!.removeAt(index);
                              });
                            },
                            leading: Container(
                                width: 10,
                                height: 10,
                                color: Colores.locales[index]),
                            title: Text(
                              widget.tittles![index],
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontSize: 6,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          );
                        }),
                  ))
              : Container(),
        ],
      ),
    );
  }

  getValues() {
    Terminal.printWarning(
        message: "_ChartLineState \n"
            " . : : getValues . . . widget.dymValues : : ${widget.dymValues} \n "
            "");
    // Se preestablecen el número de Listados en Values.
    for (var i = 0; i < widget.dymValues[0][0].length - 1; i++) {
      widget.values!.add([]);
    }
    //
    for (var element in widget.dymValues[0]) {
      // print("element Of $element");
      // Se agregan como bottomTittles el primer elemento de la lista.
      setState(() {
        widget.bottomTittles!.add(element[0]);
      });
      // Se agregan los valores de dymValues de la posición 1, ..., n
      for (var i = 0; i < element.length - 1; i++) {
        // Terminal.printExpected(message: "${element[i + 1].runtimeType} ${element[i + 1]}");
        // if (element[i + 1].runtimeType != String) {
        //   widget.values![i].add(double.parse(element[i + 1].toString()));
        // }
        if (element[i + 1]!= null) widget.values![i].add(double.parse(element[i + 1].toString()));
      }
    }

    // Terminal.printExpected(message: "widget.values ${widget.values!.length} ${widget.values}");
    for (var i = 0; i < widget.values!.length; i++) {
      // print("${Colores.locales[i]!}, ${widget.values![i]}");
      widget.spotsVals!.add(getSpots(
        Colores.locales[i]!,
        widget.values![i],
      ));
    }
  }

  getSpots(Color color, List<double> values) {
    return LineChartBarData(
        color: color,
        isCurved: false,
        dotData: const FlDotData(show: true),
        spots: toSpots(values));
  }

  List<FlSpot> toSpots(List<double> values) {
    // setState(() {
    //   widget.minY =
    //       values.reduce((current, next) => current < next ? current : next);
    //   widget.maxY =
    //       values.reduce((current, next) => current > next ? current : next);
    // });

    // Terminal.printExpected(message: values.toString());
    List<FlSpot> spots = [];
    double indice = 0;
    //
    for (var value in values) {
      // Terminal.printExpected(message: value.toString());
      spots.add(FlSpot(indice, double.parse(value.toString())));
      indice++;
    }
    //
    return spots;
  }

  getTitleData() => FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
          sideTitles: SideTitles(
        interval: widget.bottonTileInterval,
        // widget.bottomTittles!.isNotEmpty
        //     ? widget.bottomTittles!.length / 3
        //     : widget.dymValues[0].length / 3, // 2,
        reservedSize: 66,
        showTitles: true,
        getTitlesWidget: (value, meta) {
          return RotatedBox(
            quarterTurns: -1,
            child: Text(
              widget.bottomTittles!.isNotEmpty
                  ? widget.bottomTittles!.elementAt(value.toInt()) ?? ""
                  : "",
              style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          );
        },
      )),
      leftTitles: AxisTitles(
          sideTitles: SideTitles(
              interval: 5,
              reservedSize: isMobile(context)? 50: 70, // widget.maxY!,
              showTitles: true,
              getTitlesWidget: (value, meta) {
                // Terminal.printExpected(message: value.toString());
                return Text(
                  value.toDouble().toString(),
                  style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                );
              })));
}
