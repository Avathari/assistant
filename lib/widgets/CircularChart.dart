import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CircularChart extends StatefulWidget {
  double? total;
  Map<String, double> values;
  String? tittle, chartPrefix, chartSuffix;

  CircularChart({
    super.key,
    this.tittle = '',
    this.chartPrefix = '\u0024',
    this.chartSuffix = '',
    required this.total,
    required this.values,
  });

  @override
  State<CircularChart> createState() => _CircularChartState();
}

class _CircularChartState extends State<CircularChart> {
  @override
  Widget build(BuildContext context) {
    // ************************* * * * * * * ***
    String tag = "${widget.tittle!}\n";
    widget.values.forEach((key, value) {
      tag = "$tag"
          "   $key : ${widget.chartPrefix} ${value.toStringAsFixed(2)} ${widget.chartSuffix}\n";
    });
    // ************************* * * * * * * ***
    return widget.total != 0
        ? Tooltip(
            message: tag,
            child: PieChart(PieChartData(
                sections: listChartSections(
                    Total: widget.total!, values: widget.values))),
          )
        : ValuePanel();
  }

  List<PieChartSectionData> listChartSections(
      {required double Total, required Map<String, double> values}) {
    List<PieChartSectionData> list = [];
    Indices.indice = 0;
// # . . . # # # . . . # ********* * ********************* * * *
    values.forEach((key, value) {
      double val = 0.0;
      if (value != 0.0 || value != null) {
        val = ((value * 100) / Total);
      } else {
        val = 0.0;
      }
      // # . . . # # # . . . # ********* * ********************* * * *
      // Terminal.printExpected(
      //     message: "VALUES $values \n"
      //         "$value ${value.runtimeType} \n"
      //         "$val %");

      // # . . . # # # . . . # ********* * ********************* * * *
      list.add(PieChartSectionData(
        color: Colores.locales[Indices.indice],
        value: (val),
        title: "${val.toStringAsFixed(1)} %",
        // "$value",
        radius: 10,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ));
      Indices.indice++;
    });
    return list;
  }
}
