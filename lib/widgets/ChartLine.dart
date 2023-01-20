import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/RoundedPanel.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartLine extends StatefulWidget {
  //
  bool withTittles;
  List? tittles;
  //
  List<List> dymValues = [];
  //
  List<LineChartBarData>? spotsVals = [];
  List<dynamic>? bottomTittles = [];
  List<List>? values = [];
  //
  double? maxY, minY;

  ChartLine({
    super.key,
    this.minY = 0,
    this.maxY = 200,
    this.tittles,
    this.withTittles = false,
    required this.dymValues,
  });

  @override
  State<ChartLine> createState() => _ChartLineState();
}

class _ChartLineState extends State<ChartLine> {
  @override
  void initState() {
    getValues();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TittlePanel(textPanel: 'Estadísticas de signos vitales'),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                flex: widget.withTittles ? 6 : 1,
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
              Expanded(
                  flex: 2,
                  child: widget.withTittles
                      ? RoundedPanel(
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
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                );
                              }),
                        )
                      : Container())
            ],
          ),
        ),
      ],
    );
  }

  getValues() {
    // Se preestablecen el número de Listados en Values.
    for (var i = 0; i < widget.dymValues[0].length - 1; i++) {
      widget.values!.add([]);
    }
    //
    for (var element in widget.dymValues) {
      // Se agregan como bottomTittles el primer elemento de la lista.
      widget.bottomTittles!.add(element[0]);
      // Se agregan los valores de dymValues de la posición 1, ..., n
      for (var i = 0; i < element.length - 1; i++) {
        widget.values![i].add(double.parse(element[i + 1].toString()));
      }
    }

    //print("widget.values ${widget.values!.length} ${widget.values}");
    for (var i = 0; i < widget.values!.length; i++) {
      widget.spotsVals!.add(getSpots(Colores.locales[i]!, widget.values![i]));
    }
  }

  getSpots(Color color, List values) {
    return LineChartBarData(
        color: color,
        isCurved: false,
        dotData: FlDotData(show: true),
        spots: toSpots(values));
  }

  List<FlSpot> toSpots(List values) {
    List<FlSpot> spots = [];
    double indice = 0;
    //
    for (var value in values) {
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
        interval: 6,
        reservedSize: 60,
        showTitles: true,
        getTitlesWidget: (value, meta) {
          return RotatedBox(
            quarterTurns: -1,
            child: Text(
              widget.bottomTittles!.elementAt(value.toInt()),
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          );
        },
      )),
      leftTitles: AxisTitles(
          sideTitles: SideTitles(
        interval: 1,
        reservedSize: 60,
        showTitles: true,
        getTitlesWidget: (value, meta) {
          switch (value.toInt()) {
            case 20:
              return Text(
                value.toStringAsFixed(0),
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              );
            case 40:
              return Text(
                value.toStringAsFixed(0),
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              );
            case 50:
              return Text(
                value.toStringAsFixed(0),
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              );
            case 60:
              return Text(
                value.toStringAsFixed(0),
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              );
            case 80:
              return Text(
                value.toStringAsFixed(0),
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              );
            case 100:
              return Text(
                value.toStringAsFixed(0),
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              );
            case 120:
              return Text(
                value.toStringAsFixed(0),
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              );
            case 140:
              return Text(
                value.toStringAsFixed(0),
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              );
            case 160:
              return Text(
                value.toStringAsFixed(0),
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              );
            case 180:
              return Text(
                value.toStringAsFixed(0),
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              );
            case 200:
              return Text(
                value.toStringAsFixed(0),
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              );
          }
          return const Text("");
        },
      )));
}
