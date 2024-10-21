import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Financieros.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CircularChart.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EstadisticasActivos extends StatefulWidget {
  const EstadisticasActivos({super.key});

  @override
  State<EstadisticasActivos> createState() => _EstadisticasActivosState();
}

class _EstadisticasActivosState extends State<EstadisticasActivos> {
  Map<String, dynamic> data = {
    'Total_Registrados': 0,
    'Ingresos_Registrados': 0,
    'Egresos_Registrados': 0,
    'Ingreso_Global': 0,
    'Egreso_Global': 0,
    'Balance_Global': 0,
    //
    'Total_Global': 0,
    'Ingreso_Anual': 0,
    'Egreso_Anual': 0,
    'Total_Anual': 0,
    'Balance_Anual': 0,
    //
    'Ingreso_Anual_Previo': 0,
    'Egreso_Anual_Previo': 0,
    'Balance_Previo_Año': 0,
    //
    'Ingreso_Mes_Previo': 0,
    'Egreso_Mes_Previo': 0,
    'Total_Previo_Mes': 0,
    //
    'Balance_Previo_Mes': 0,
    'Ingreso_Mensual': 0,
    'Egreso_Mensual': 0,
    'Total_Mensual': 0,
    'Balance_Mensual': 0,
    //
    'Balance_Actual': 0,
    'Balance_Parcial': 0.0,
    //
  };
  var statScrollController = ScrollController();
  var carouselController = CarouselSliderController();

  @override
  void initState() {
    Terminal.printWarning(
        message: " INICIAR : "
            "Iniciando Actividad - "
            "Estádisticas del Repositorio");

    Archivos.readJsonToMap(filePath: Activos.fileStadistics)
        .then((value) => setState(() => data = value[0]))
        .onError((onError, stackTrace) {
      Operadores.alertActivity(
          context: context,
          tittle: "ERROR al Cuantificar Estadísticas . . .",
          message: "ERROR : $onError : : $stackTrace",
          onAcept: () => _reiniciar(context));
    }).whenComplete(() =>
            Terminal.printWarning(message: " . . . DATOS OBTENIDOS . $data"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Terminal.printWarning(message: " . . . Data :  : :  $data");
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: isMobile(context)
          ? AppBar(
              foregroundColor: Colors.grey,
              backgroundColor: Colors.black,
              title: AppBarText('Estadísticas de los Activos del Usuario'),
              actions: [
                GrandIcon(
                    iconData: Icons.update, onPress: () => _reiniciar(context)),
                SizedBox(width: 15),
              ],
            )
          : null,
      body: isMobile(context) ? viewMobile() : viewTablet(),
      floatingActionButton: CircleIcon(
          iconed: Icons.update, onChangeValue: () => _reiniciar(context)),
    );
  }
  //
  // void reiniciar() {
  //   Actividades.detalles(Databases.siteground_database_regfine,
  //           Activos.activos['activosStadistics'])
  //       .then((value) {
  //     setState(() {
  //       data = value;
  //       // Terminal.printWarning(message: " . . . $value\n $data");
  //       Archivos.createJsonFromMap([data],
  //           filePath: Activos.fileStadistics);
  //     });
  //   });
  // }

  Padding tileStat(IconData? icon, String tittle, double stat) {
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
          stat.toStringAsFixed(2),
          style: const TextStyle(fontSize: 10, color: Colors.white),
        ),
      ),
    );
  }

  viewTablet() {
    return Container(
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 10.0, bottom: 5.0),
      margin: const EdgeInsets.all(8.0),
      decoration: ContainerDecoration.roundedDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: isMobile(context) ? 2 : 3,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                          child: TittlePanel(
                            fontSize: 16,
                            textPanel: 'Estadisticas de los Activos',
                          ),
                        ),
                        Expanded(
                          flex: isMobile(context) ? 5 : 3,
                          child: GridView(
                            gridDelegate: GridViewTools.gridDelegate(
                                crossAxisCount:
                                    isTablet(context) || isMobile(context)
                                        ? 2
                                        : 3,
                                crossAxisSpacing: 20.0,
                                mainAxisSpacing: 20.0,
                                mainAxisExtent: 90.0),
                            children: [
                              if (data['Total_Mensual'] != null &&
                                  data['Total_Mensual'] != 0)
                                CircularChart(
                                  tittle: "Balance del Mes",
                                  total: double.parse(
                                      data['Total_Mensual'].toString()),
                                  values: {
                                    'Ingresos': double.parse(
                                        data['Ingreso_Mensual'].toString()),
                                    'Egresos': double.parse(
                                        data['Egreso_Mensual'].toString()),
                                  },
                                ),
                              if (data['Total_Previo_Mes'] != null &&
                                  data['Total_Previo_Mes'] != 0)
                                CircularChart(
                                  tittle: "Balance del Mes Previo",
                                  total: double.parse(
                                      data['Total_Previo_Mes'].toString()),
                                  values: {
                                    'Ingresos': double.parse(
                                        data['Ingreso_Mes_Previo'].toString()),
                                    'Egresos': double.parse(
                                        data['Egreso_Mes_Previo'].toString()),
                                  },
                                ),
                              if (data['Balance_Previo_Año'] != null &&
                                  data['Balance_Previo_Año'] != 0)
                                CircularChart(
                                  tittle: "Balance del Año Previo",
                                  total: double.parse(
                                      data['Total_Previo_Año'].toString()),
                                  values: {
                                    'Ingresos': double.parse(
                                        data['Ingreso_Anual_Previo']
                                            .toString()),
                                    'Egresos': double.parse(
                                        data['Egreso_Anual_Previo'].toString()),
                                  },
                                ),
                              if (data['Total_Anual'] != null &&
                                  data['Total_Anual'] != 0)
                                CircularChart(
                                  tittle: "Balance Anual",
                                  total: double.parse(
                                      data['Total_Anual'].toString()),
                                  values: {
                                    'Ingresos': double.parse(
                                        data['Ingreso_Anual'].toString()),
                                    'Egresos': double.parse(
                                        data['Egreso_Anual'].toString()),
                                  },
                                ),
                              if (data['Total_Global'] != null &&
                                  data['Total_Global'] != 0)
                                CircularChart(
                                  tittle: "Balance Global",
                                  total: double.parse(
                                      data['Total_Global'].toString()),
                                  values: {
                                    'Ingresos': double.parse(
                                        data['Ingreso_Global'].toString()),
                                    'Egresos': double.parse(
                                        data['Egreso_Global'].toString()),
                                    'Pasivos': double.parse(
                                        data['Pasivos_Global'].toString()),
                                  },
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  isDesktop(context)
                      ? Expanded(
                          flex: 2,
                          child: SingleChildScrollView(
                            controller: ScrollController(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                tileStat(
                                    Icons.upgrade,
                                    "Ingresos Globales",
                                    double.parse(
                                        data['Ingreso_Global'].toString())),
                                tileStat(
                                    Icons.arrow_drop_down,
                                    "Egresos Globales",
                                    double.parse(
                                        data['Egreso_Global'].toString())),
                                tileStat(
                                    Icons.balcony,
                                    "Balance Parcial",
                                    double.parse(
                                        data['Balance_Parcial'].toString())),
                                CrossLine(),
                                tileStat(Icons.home_filled, "Patrimonio",
                                    data['Patrimonio'] ?? 0.0),
                                tileStat(
                                    Icons.balance,
                                    "Balance Total",
                                    double.parse(
                                        data['Balance_Global'].toString())),
                                CrossLine(),
                                tileStat(
                                    Icons.person,
                                    "Total de Registros",
                                    double.parse(
                                        data['Total_Registrados'].toString())),
                                CrossLine(),
                                tileStat(
                                    Icons.person_add_outlined,
                                    "Total de Ingresos",
                                    double.parse(data['Ingresos_Registrados']
                                        .toString())),
                                tileStat(
                                    Icons.person_off_outlined,
                                    "Total de Egresos",
                                    double.parse(data['Egresos_Registrados']
                                        .toString())),
                                tileStat(
                                    Icons.person_add_outlined,
                                    "Total de Activos",
                                    double.parse(data['Activos_Registrados'] !=
                                            null
                                        ? data['Activos_Registrados'].toString()
                                        : '0.0')),
                                tileStat(
                                    Icons.person_off_outlined,
                                    "Total de Pasivos",
                                    double.parse(data['Pasivos_Registrados'] !=
                                            null
                                        ? data['Pasivos_Registrados'].toString()
                                        : '0.0')),
                              ],
                            ),
                          ))
                      : Container(),
                ],
              )),
          const Divider(
            color: Colors.grey,
            height: 15,
          ),
          if (isTablet(context) || isDesktop(context))
            Expanded(
              child: Container(
                decoration: ContainerDecoration.roundedDecoration(),
                child: Row(
                  children: [
                    Expanded(
                      child: ValuePanel(
                          heigth: 70,
                          firstText: "Ingreso Mensual",
                          secondText:
                              double.parse(data['Ingreso_Mensual'].toString())
                                  .toStringAsFixed(2)),
                    ),
                    Expanded(
                      child: ValuePanel(
                          heigth: 70,
                          firstText: "Egreso Mensual",
                          secondText:
                              double.parse(data['Egreso_Mensual'].toString())
                                  .toStringAsFixed(2)),
                    ),
                    Expanded(
                      child: ValuePanel(
                          heigth: 70,
                          firstText: "Balance Mensual",
                          secondText:
                              double.parse(data['Balance_Mensual'].toString())
                                  .toStringAsFixed(2)),
                    ),
                  ],
                ),
              ),
            ),
          const Divider(
            color: Colors.grey,
            height: 15,
          ),
          Expanded(
              flex: 3,
              child: GridView(
                gridDelegate: GridViewTools.gridDelegate(
                    crossAxisCount: isDesktop(context) ? 7 : 3,
                    mainAxisExtent: 75.0),
                children: [
                  ValuePanel(
                      firstText: "Ingreso Global",
                      secondText:
                          double.parse(data['Ingreso_Global'].toString())
                              .toStringAsFixed(2)),
                  ValuePanel(
                      firstText: "Egreso Global",
                      secondText: double.parse(data['Egreso_Global'].toString())
                          .toStringAsFixed(2)),
                  ValuePanel(
                      firstText: "Balance Parcial",
                      secondText: double.parse(
                              data['Balance_Parcial'].toString())
                          .toStringAsFixed(2)),
                  if (isDesktop(context))
                    CrossLine(
                      isHorizontal: false,
                    ),
                  ValuePanel(
                      firstText: "Ingreso Anual",
                      secondText: double.parse(data['Ingreso_Anual'].toString())
                          .toStringAsFixed(2)),
                  ValuePanel(
                      firstText: "Egreso Anual",
                      secondText: double.parse(data['Egreso_Anual'].toString())
                          .toStringAsFixed(2)),
                  ValuePanel(
                      firstText: "Balance Anual",
                      secondText: double.parse(data['Balance_Anual'].toString())
                          .toStringAsFixed(2)),
// *******************************
                  ValuePanel(
                      firstText: "Ingreso Anual Previo",
                      secondText:
                          double.parse(data['Ingreso_Anual_Previo'].toString())
                              .toStringAsFixed(2)),
                  ValuePanel(
                      firstText: "Egreso Anual Previo",
                      secondText:
                          double.parse(data['Egreso_Anual_Previo'].toString())
                              .toStringAsFixed(2)),
                  ValuePanel(
                      firstText: "Balance Anual Previo",
                      secondText:
                          double.parse(data['Balance_Previo_Año'].toString())
                              .toStringAsFixed(2)),
                  if (isDesktop(context))
                    CrossLine(
                      isHorizontal: false,
                    ),
                  ValuePanel(
                      firstText: "Ingreso Mes Previo",
                      secondText:
                          double.parse(data['Ingreso_Mes_Previo'].toString())
                              .toStringAsFixed(2)),
                  ValuePanel(
                      firstText: "Egreso Mes Previo",
                      secondText:
                          double.parse(data['Egreso_Mes_Previo'].toString())
                              .toStringAsFixed(2)),
                  ValuePanel(
                      firstText: "Balance Mes Previo",
                      secondText:
                          double.parse(data['Total_Previo_Mes'].toString())
                              .toStringAsFixed(2)),
                  // *******************************
                  ValuePanel(
                      firstText: "Ingreso Mensual",
                      secondText:
                          double.parse(data['Ingreso_Mensual'].toString())
                              .toStringAsFixed(2)),
                  ValuePanel(
                      firstText: "Egreso Mensual",
                      secondText:
                          double.parse(data['Egreso_Mensual'].toString())
                              .toStringAsFixed(2)),
                  ValuePanel(
                      firstText: "Balance Mensual",
                      secondText:
                          double.parse(data['Balance_Mensual'].toString())
                              .toStringAsFixed(2)),
                  if (isDesktop(context))
                    CrossLine(
                      isHorizontal: false,
                    ),
                ],
              )),
          // Expanded(
          //     flex: 2,
          //     //fit: FlexFit.tight,
          //     child: ListView.builder(
          //         //shrinkWrap: true,
          //         controller: statScrollController,
          //         itemCount: Financieros.Categorias.length,
          //         itemBuilder: (BuildContext context, index) {
          //           //print("INDEX BUILDER $index ${Pacientes.Categorias[index]} ${data!.values.toList().elementAt(index).runtimeType}");
          //           //print("data data $data");
          //           if (index <= data.length) {
          //             return tileStat(
          //                 Icons.list,
          //                 Financieros.Categorias[index],
          //                 double.parse(data.values
          //                     .toList()
          //                     .elementAt(index)
          //                     .toString()));
          //           } else {
          //             return Container();
          //           }
          //         }))
        ],
      ),
    );
  }

  viewMobile() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: CarouselSlider(
        carouselController: carouselController,
        options: Carousel.carouselOptions(context: context),
        items: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    margin: const EdgeInsets.all(4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (data['Total_Mensual'] != null &&
                            data['Total_Mensual'] != 0)
                          Expanded(
                            child: CircularChart(
                              tittle: "Balance del Mes",
                              total: double.parse(data['Total_Mensual']
                                  .toString()),
                              values: {
                                'Ingresos': double.parse(
                                    data['Ingreso_Mensual'].toString()),
                                'Egresos': double.parse(
                                    data['Egreso_Mensual'].toString()),
                              },
                            ),
                          ),
                        if (data['Total_Previo_Mes'] != null &&
                            data['Total_Previo_Mes'] != 0)
                          Expanded(
                            child: CircularChart(
                              tittle: "Balance del Mes Previo",
                              total: double.parse(
                                  data['Total_Previo_Mes'].toString()),
                              values: {
                                'Ingresos': double.parse(
                                    data['Ingreso_Mes_Previo'].toString()),
                                'Egresos': double.parse(
                                    data['Egreso_Mes_Previo'].toString()),
                              },
                            ),
                          ),
                        if (data['Balance_Previo_Año'] != null &&
                            data['Balance_Previo_Año'] != 0)
                          Expanded(
                            child: CircularChart(
                              tittle: "Balance del Año Previo",
                              total: double.parse(
                                  data['Total_Previo_Año'].toString()),
                              values: {
                                'Ingresos': double.parse(
                                    data['Ingreso_Anual_Previo'].toString()),
                                'Egresos': double.parse(
                                    data['Egreso_Anual_Previo'].toString()),
                              },
                            ),
                          ),
                        if (data['Total_Anual'] != null &&
                            data['Total_Anual'] != 0)
                          Expanded(
                            child: CircularChart(
                              tittle: "Balance Anual",
                              total:
                                  double.parse(data['Total_Anual'].toString()),
                              values: {
                                'Ingresos': double.parse(
                                    data['Ingreso_Anual'].toString()),
                                'Egresos': double.parse(
                                    data['Egreso_Anual'].toString()),
                              },
                            ),
                          ),
                        if (data['Total_Global'] != null &&
                            data['Total_Global'] != 0)
                          Expanded(
                            child: CircularChart(
                              tittle: "Balance Global",
                              total:
                                  double.parse(data['Total_Global'].toString()),
                              values: {
                                'Ingresos': double.parse(
                                    data['Ingreso_Global'].toString()),
                                'Egresos': double.parse(
                                    data['Egreso_Global'].toString()),
                                'Pasivos': double.parse(
                                    data['Pasivos_Global'].toString()),
                              },
                            ),
                          ),
                      ],
                    ),
                  )),
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      tileStat(Icons.upgrade, "Ingresos Globales",
                          double.parse(data['Ingreso_Global'].toString())),
                      tileStat(Icons.arrow_drop_down, "Egresos Globales",
                          double.parse(data['Egreso_Global'].toString())),
                      tileStat(Icons.balcony, "Balance Parcial",
                          data['Balance_Parcial'] ?? 0.0),
                      CrossLine(),
                      tileStat(Icons.home_filled, "Patrimonio",
                          data['Patrimonio'] ?? 0.0),
                      tileStat(Icons.balance, "Balance Total",
                          double.parse(data['Balance_Global'].toString())),
                      CrossLine(),
                      tileStat(Icons.person, "Total de Registros",
                          double.parse(data['Total_Registrados'].toString())),
                      CrossLine(),
                      tileStat(
                          Icons.person_add_outlined,
                          "Total de Ingresos",
                          double.parse(
                              data['Ingresos_Registrados'].toString())),
                      tileStat(Icons.person_off_outlined, "Total de Egresos",
                          double.parse(data['Egresos_Registrados'].toString())),
                      tileStat(
                          Icons.person_add_outlined,
                          "Total de Activos",
                          double.parse(data['Activos_Registrados'] != null
                              ? data['Activos_Registrados'].toString()
                              : '0.0')),
                      tileStat(
                          Icons.person_off_outlined,
                          "Total de Pasivos",
                          double.parse(data['Pasivos_Registrados'] != null
                              ? data['Pasivos_Registrados'].toString()
                              : '0.0')),
                    ],
                  ),
                ),
              )
            ],
          ),
          GridView(
            gridDelegate: GridViewTools.gridDelegate(
                crossAxisCount: isDesktop(context) ? 7 : 3,
                mainAxisExtent: 75.0),
            children: [
              ValuePanel(
                  firstText: "Ingreso Global",
                  secondText: double.parse(data['Ingreso_Global'].toString())
                      .toStringAsFixed(2)),
              ValuePanel(
                  firstText: "Egreso Global",
                  secondText: double.parse(data['Egreso_Global'].toString())
                      .toStringAsFixed(2)),
              ValuePanel(
                  firstText: "Balance Parcial",
                  secondText:
                      double.parse(data['Balance_Parcial'].toString())
                          .toStringAsFixed(2)),
              if (isDesktop(context))
                CrossLine(
                  isHorizontal: false,
                ),
              ValuePanel(
                  firstText: "Ingreso Anual",
                  secondText: double.parse(data['Ingreso_Anual'].toString())
                      .toStringAsFixed(2)),
              ValuePanel(
                  firstText: "Egreso Anual",
                  secondText: double.parse(data['Egreso_Anual'].toString())
                      .toStringAsFixed(2)),
              ValuePanel(
                  firstText: "Balance Anual",
                  secondText: double.parse(data['Balance_Anual'].toString())
                      .toStringAsFixed(2)),
// *******************************
              ValuePanel(
                  firstText: "Ingreso Anual Previo",
                  secondText:
                      double.parse(data['Ingreso_Anual_Previo'].toString())
                          .toStringAsFixed(2)),
              ValuePanel(
                  firstText: "Egreso Anual Previo",
                  secondText:
                      double.parse(data['Egreso_Anual_Previo'].toString())
                          .toStringAsFixed(2)),
              ValuePanel(
                  firstText: "Balance Anual Previo",
                  secondText:
                      double.parse(data['Balance_Previo_Año'].toString())
                          .toStringAsFixed(2)),
              if (isDesktop(context))
                CrossLine(
                  isHorizontal: false,
                ),
              ValuePanel(
                  firstText: "Ingreso Mes Previo",
                  secondText:
                      double.parse(data['Ingreso_Mes_Previo'].toString())
                          .toStringAsFixed(2)),
              ValuePanel(
                  firstText: "Egreso Mes Previo",
                  secondText: double.parse(data['Egreso_Mes_Previo'].toString())
                      .toStringAsFixed(2)),
              ValuePanel(
                  firstText: "Balance Mes Previo",
                  secondText: double.parse(data['Total_Previo_Mes'].toString())
                      .toStringAsFixed(2)),
              // *******************************
              ValuePanel(
                  firstText: "Ingreso Mensual",
                  secondText: double.parse(data['Ingreso_Mensual'].toString())
                      .toStringAsFixed(2)),
              ValuePanel(
                  firstText: "Egreso Mensual",
                  secondText: double.parse(data['Egreso_Mensual'].toString())
                      .toStringAsFixed(2)),
              ValuePanel(
                  firstText: "Balance Mensual",
                  secondText: double.parse(data['Balance_Mensual'].toString())
                      .toStringAsFixed(2)),
              if (isDesktop(context))
                CrossLine(
                  isHorizontal: false,
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _reiniciar(BuildContext context) {
    Activos.getEstadisticasFinancieras()
        .then((value) => setState(() => data = value))
        .onError((onError, stackTrace) => Operadores.alertActivity(
            context: context,
            tittle: "ERROR al Cuantificar Estadísticas . . .",
            message: "ERROR : $onError : : $stackTrace",
            onAcept: () => Navigator.of(context).pop()))
        .whenComplete(() => Archivos.createJsonFromMap([data],
            filePath: Activos.fileStadistics));
  }
}
