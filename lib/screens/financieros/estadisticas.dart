import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Financieros.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CircularChart.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
    //
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
  final PageController _pageController = PageController();
  int _currentPage = 2; // Balances Generales

  var carouselController = CarouselSliderController();

  @override
  void initState() {
    super.initState();

    _inicializarDatos();
  }

  Future<void> _inicializarDatos() async {
    try {
      // 🧩 1. Intentar cargar los datos en caché primero (rápido)
      final stats = await FinancierosRepo().cargarEstadisticasCache();

      // Si hay datos válidos, los usamos de inmediato
      if (stats.isNotEmpty) {
        Financieros.actualizarDesdeMapa(stats);
        setState(() => data = stats);
      }

      // 🕓 2. Luego intentar sincronizar en segundo plano (por si hay cambios remotos)
      await FinancierosRepo().reiniciar(remoto: true);

      // 🔁 3. Actualizar nuevamente las estadísticas
      final actualizados = FinancierosRepo().estadisticas;
      Financieros.actualizarDesdeMapa(actualizados);
      setState(() => data = actualizados);

      debugPrint("✅ Estadísticas cargadas y actualizadas correctamente");
    } catch (e, st) {
      debugPrint("❌ Error al inicializar estadísticas: $e");
      debugPrint(st.toString());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error al cargar estadísticas financieras."),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
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

  Widget viewTablet() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.all(8.0),
      decoration: ContainerDecoration.roundedDecoration(),
      child: Column(
        children: [
          // 🟢 Título
          TittlePanel(
            fontSize: 18,
            textPanel: '📈 Estadísticas Financieras del Usuario',
          ),
          const SizedBox(height: 8),

          // const Divider(color: Colors.white30, height: 10),
          // 🧮 Indicadores Financieros (KPIs)
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (i) => setState(() => _currentPage = i),
              children: [
                _buildIndicators(),
                _analisisPatrimonial(),
                _BalancesGenerales(),
                _proyeccionFinanciera(),
                _graficaProyeccion()
              ],
            ),
          ),
          Wrap(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _navButton("Indicadores", 0),
              const SizedBox(width: 4),
              _navButton("Patrimonio", 1),
              const SizedBox(width: 4),
              _navButton("Balances Generales", 2),
              const SizedBox(width: 4),
              _navButton("Proyección Financiera", 3),
              const SizedBox(width: 4),
              _navButton("Proyección Gráfica", 4),
            ],
          ),
          const Divider(color: Colors.white24, height: 10),
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
                              total: double.parse(
                                  data['Total_Mensual'].toString()),
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
                  secondText: double.parse(data['Balance_Parcial'].toString())
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
    FinancierosRepo()
        .reiniciar(remoto: true)
        .then((_) => setState(() => data = FinancierosRepo().estadisticas))
        .onError((onError, stackTrace) => Operadores.alertActivity(
              context: context,
              tittle: "ERROR al actualizar estadísticas",
              message: "ERROR : $onError : : $stackTrace",
              onAcept: () => Navigator.of(context).pop(),
            ));
  }

  // ##############################################################
  Widget _buildCircularCharts() {
    final List<Map<String, dynamic>> charts = [
      {
        'title': "Balance del Mes",
        'total': safeParse(data['Total_Mensual']),
        'values': {
          'Ingresos': safeParse(data['Ingreso_Mensual']),
          'Egresos': safeParse(data['Egreso_Mensual']),
        }
      },
//
      {
        'title': "Balance del Mes Previo",
        'total': safeParse(data['Total_Previo_Mes']),
        'values': {
          'Ingresos': safeParse(data['Ingreso_Mes_Previo']),
          'Egresos': safeParse(data['Egreso_Mes_Previo']),
        }
      },

      {
        'title': "Balance Anual",
        'total': safeParse(data['Total_Anual']),
        'values': {
          'Ingresos': safeParse(data['Ingreso_Anual']),
          'Egresos': safeParse(data['Egreso_Anual']),
        }
      },
      {
        'title': "Balance Año Previo",
        'total': safeParse(data['Total_Previo_Año']),
        'values': {
          'Ingresos': safeParse(data['Ingreso_Anual_Previo']),
          'Egresos': safeParse(data['Egreso_Anual_Previo']),
        }
      },
      {
        'title': "Balance del Año Previo",
        'total': safeParse(data['Total_Previo_Año']),
        'values': {
          'Ingresos': safeParse(data['Ingreso_Anual_Previo']),
          'Egresos': safeParse(data['Egreso_Anual_Previo']),
        }
      },

      {
        'title': "Balance Global",
        'total': safeParse(data['Total_Global']),
        'values': {
          'Ingresos': safeParse(data['Ingreso_Global']),
          'Egresos': safeParse(data['Egreso_Global']),
          'Pasivos': safeParse(data['Pasivos_Global']),
        }
      },
    ];

    return GridView.builder(
      gridDelegate: GridViewTools.gridDelegate(
        crossAxisCount: isTablet(context) ? 2 : 3,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        mainAxisExtent: 100.0,
      ),
      itemCount: charts.length,
      itemBuilder: (context, i) {
        final chart = charts[i];
        if (chart['total'] == 0) return const SizedBox();
        return CircularChart(
          tittle: chart['title'],
          total: chart['total'],
          values: Map<String, double>.from(chart['values']),
        );
      },
    );
  }

  //
  Widget _buildIndicators() {
    final indicadores = [
      {
        "titulo": "Margen Neto",
        "valor": Financieros.margenNeto,
        "unidad": "%",
        "descripcion":
            "Indica la proporción de beneficios netos sobre los ingresos totales. Un valor más alto significa mayor rentabilidad."
      },
      {
        "titulo": "Liquidez",
        "valor": Financieros.liquidez,
        "unidad": "x",
        "descripcion":
            "Mide la capacidad de la organización para cumplir con sus obligaciones a corto plazo."
      },
      {
        "titulo": "Crecimiento del Ingreso",
        "valor": Financieros.crecimientoIngreso,
        "unidad": "%",
        "descripcion":
            "Porcentaje de variación de los ingresos respecto al periodo anterior. Refleja el ritmo de expansión o contracción económica."
      },
      {
        "titulo": "Endeudamiento",
        "valor": Financieros.endeudamiento,
        "unidad": "%",
        "descripcion":
            "Proporción entre pasivos y activos totales. Un valor elevado indica dependencia de la deuda."
      },
      {
        "titulo": "Ratio Patrimonial",
        "valor": Financieros.ratioPatrimonial,
        "unidad": "%",
        "descripcion":
            "Relación entre el patrimonio y los activos totales. Un valor alto refleja mayor estabilidad financiera."
      },
      {
        "titulo": "Rentabilidad Patrimonial",
        "valor": Financieros.rentabilidadPatrimonial,
        "unidad": "%",
        "descripcion":
            "Mide la capacidad del patrimonio propio para generar beneficios netos."
      },
      {
        "titulo": "Variación Anual",
        "valor": Financieros.variacionAnual,
        "unidad": "%",
        "descripcion":
            "Diferencia porcentual anual de los resultados financieros. Permite observar tendencias generales de crecimiento o caída."
      },
    ];

    return GridView.builder(
      gridDelegate: GridViewTools.gridDelegate(
        crossAxisCount: isTablet(context) ? 1 : 2,
        mainAxisExtent: 50.0,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: indicadores.length,
      itemBuilder: (context, index) {
        final i = indicadores[index];
        return _indicatorTileConAyudaAuto(
          context,
          i['titulo'].toString(),
          safeParse(i['valor']),
          i['unidad'].toString(),
          i['descripcion'].toString(),
        );
      },
    );
  }

  Widget _analisisPatrimonial() {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("📈 Análisis Financiero",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          _indicatorTile(
              "Liquidez Real", FinancierosAnalisis.liquidezReal(), "\$"),
          _indicatorTile("Elasticidad Financiera",
              FinancierosAnalisis.elasticidadFinanciera(), "%"),
          _indicatorTile("Capacidad de Inversión",
              FinancierosAnalisis.capacidadInversion(), "\$"),
          _indicatorTile("Balance Patrimonial",
              FinancierosAnalisis.balancePatrimonial(), "\$"),
          const SizedBox(height: 10),
          const Text("📉 Riesgo y Tendencias",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          _indicatorTile(
              "Dependencia Vital", FinancierosAnalisis.dependenciaVital(), "%"),
          _indicatorTile(
              "Endeudamiento", FinancierosAnalisis.endeudamiento(), "%"),
          _indicatorTile("Crecimiento de Ingresos",
              FinancierosAnalisis.crecimientoIngresos(), "%"),
          _indicatorTile(
              "Riesgo de Liquidez", FinancierosAnalisis.riesgoLiquidez(), "\$"),
        ],
      ),
    );
  }

  Widget _BalancesGenerales() {
    return Column(
      children: [
        Expanded(child: _EstadisticasBasicas()),
        Expanded(
          child: GridView(
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
                  secondText: double.parse(data['Balance_Parcial'].toString())
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
        ),
      ],
    );
  }

  Widget _proyeccionFinanciera() {
    final repo = FinancierosRepo();
    final ingresos = repo.historialMensual('Ingresos');
    final egresos = repo.historialMensual('Egresos');

    if (ingresos.isEmpty || egresos.isEmpty) {
      return const Center(
        child: Text(
          "No hay datos suficientes para proyección.",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    // 🔹 Calcular proyección
    final proy = FinancierosPredictivo.proyectarFlujo(ingresos, egresos);
    final ind = FinancierosPredictivo.indicadores(
      ingresoProy: proy['ingresoProyectado']!,
      egresoProy: proy['egresoProyectado']!,
      pasivosActuales: Financieros.pasivosTotales ?? 0,
    );

    // 🔹 Determinar mes proyectado
    DateTime mesMasReciente = repo.obtenerUltimaFecha('Ingresos', 'Egresos');
    DateTime mesProyectado = DateTime(
      mesMasReciente.year,
      mesMasReciente.month + 1,
    );
    final mesProyectadoStr =
        "${_nombreMes(mesProyectado.month)} / ${mesProyectado.year}";

    // 🔹 Calcular tendencia global
    final ingreso = proy['ingresoProyectado'] ?? 0.0;
    final egreso = proy['egresoProyectado'] ?? 0.0;
    final balance = ingreso - egreso;

    IconData iconoTitulo;
    Color colorTitulo;
    String emoji;

    if (balance > 1000) {
      iconoTitulo = Icons.trending_up;
      colorTitulo = Colors.greenAccent;
      emoji = "🟢";
    } else if (balance < -1000) {
      iconoTitulo = Icons.trending_down;
      colorTitulo = Colors.redAccent;
      emoji = "🔴";
    } else {
      iconoTitulo = Icons.trending_flat;
      colorTitulo = Colors.amberAccent;
      emoji = "🟠";
    }

    // 🔹 Visual
    return TittleContainer(
      tittle: "$emoji Proyección Financiera ($mesProyectadoStr)",
      padding: 10,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tileStatConAyudaAuto(
              context,
              Icons.trending_up,
              "Ingreso Proyectado",
              ingreso,
              "Monto estimado de ingresos esperados según el comportamiento previo.",
            ),
            tileStatConAyudaAuto(
              context,
              Icons.trending_down,
              "Egreso Proyectado",
              egreso,
              "Gasto estimado del próximo periodo, basado en tendencias recientes.",
            ),
            tileStatConAyudaAuto(
              context,
              Icons.savings,
              "Liquidez Proyectada",
              proy['liquidezProyectada'] ?? 0,
              "Relación entre ingresos y egresos proyectados; indica tu margen de maniobra.",
            ),
            const Divider(color: Colors.grey, height: 20),
            tileStatConAyudaAuto(
              context,
              Icons.warning_amber_rounded,
              "Riesgo de Déficit",
              ind['riesgoDeficit'] ?? 0,
              "Probabilidad de que los egresos superen los ingresos el próximo mes.",
            ),
            tileStatConAyudaAuto(
              context,
              Icons.account_balance_wallet,
              "Capacidad de Endeudamiento",
              ind['capacidadEndeudamiento'] ?? 0,
              "Cantidad máxima que podrías destinar a deuda sin comprometer tu liquidez.",
            ),
            tileStatConAyudaAuto(
              context,
              Icons.trending_flat,
              "Liquidez Futura",
              ind['liquidezFutura'] ?? 0,
              "Proyección del dinero disponible tras cubrir gastos y pasivos.",
            ),
            tileStatConAyudaAuto(
              context,
              Icons.paid,
              "Margen Disponible",
              ind['margenDisponible'] ?? 0,
              "Dinero sobrante que podrías destinar a inversión, ahorro o amortización.",
            ),
          ],
        ),
      ),
    );
  }

  //
  Widget _graficaProyeccion() {
    final repo = FinancierosRepo();
    final ingresos = repo.historialMensual('Ingresos');
    final egresos = repo.historialMensual('Egresos');

    if (ingresos.isEmpty || egresos.isEmpty) {
      return const Center(
        child: Text("No hay datos suficientes para proyección.",
            style: TextStyle(color: Colors.grey)),
      );
    }

    // 🔹 Proyección
    final proy = FinancierosPredictivo.proyectarFlujo(ingresos, egresos);

    // 🔹 Obtener el último mes real
    final ultimaFecha = repo.obtenerUltimaFecha('Ingresos', 'Egresos');
    final siguienteMes = DateTime(ultimaFecha.year, ultimaFecha.month + 1);

    // 🔹 Etiquetas de meses
    List<String> etiquetas = [];

    for (int i = 0; i < ingresos.length; i++) {
      final fecha = DateTime(
          ultimaFecha.year, ultimaFecha.month - (ingresos.length - 1 - i));
      etiquetas.add("${_nombreMes(fecha.month)} ${fecha.year}");
    }

    etiquetas.add("${_nombreMes(siguienteMes.month)} ${siguienteMes.year}");

    // 🔹 Añadir datos proyectados al final
    final ingresosData = [...ingresos, proy['ingresoProyectado']!];
    final egresosData = [...egresos, proy['egresoProyectado']!];

    return Container(
      height: 220,
      padding: const EdgeInsets.all(8),
      child: LineChart(
        LineChartData(
          minY: 0,
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index < 0 || index >= etiquetas.length) {
                    return const SizedBox();
                  }
                  return Text(
                    etiquetas[index],
                    style: const TextStyle(color: Colors.white70, fontSize: 10),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: [
            // 🔹 Línea de ingresos
            LineChartBarData(
              isCurved: true,
              color: Colors.greenAccent,
              barWidth: 3,
              spots: List.generate(
                ingresosData.length,
                (i) => FlSpot(i.toDouble(), ingresosData[i]),
              ),
              dotData: FlDotData(show: false),
            ),

            // 🔹 Línea de egresos
            LineChartBarData(
              isCurved: true,
              color: Colors.redAccent,
              barWidth: 3,
              spots: List.generate(
                egresosData.length,
                (i) => FlSpot(i.toDouble(), egresosData[i]),
              ),
              dotData: FlDotData(show: false),
            ),

            // 🔵 Punto especial para la proyección
            LineChartBarData(
              isCurved: false,
              color: Colors.blueAccent,
              barWidth: 0,
              spots: [
                FlSpot((ingresosData.length - 1).toDouble(),
                    proy['ingresoProyectado']!),
              ],
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, _, __, ___) =>
                    FlDotCirclePainter(radius: 5, color: Colors.blueAccent),
              ),
            ),

            // 🔴 Punto especial para egreso proyectado
            LineChartBarData(
              isCurved: false,
              color: Colors.orangeAccent,
              barWidth: 0,
              spots: [
                FlSpot((egresosData.length - 1).toDouble(),
                    proy['egresoProyectado']!),
              ],
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, _, __, ___) =>
                    FlDotCirclePainter(radius: 5, color: Colors.orangeAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
  Widget tileStat(IconData? icon, String title, double stat) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 150,
          maxWidth: 300, // ajustable según tu layout
        ),
        child: ListTile(
          dense: true,
          visualDensity: const VisualDensity(vertical: -2),
          leading: Icon(icon, color: Colors.white),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            stat.toStringAsFixed(2),
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget tileStatConAyudaAuto(
    BuildContext context,
    IconData icon,
    String titulo,
    double valor,
    String descripcion,
  ) {
    // 🧠 Determinar color y rango máximo automático según el tipo
    Color colorIndicador;
    double maximoReferencia;

    if (titulo.toLowerCase().contains('riesgo')) {
      colorIndicador = valor > 60
          ? Colors.redAccent
          : (valor > 30 ? Colors.orangeAccent : Colors.greenAccent);
      maximoReferencia = 100; // porcentaje
    } else if (titulo.toLowerCase().contains('endeudamiento')) {
      colorIndicador = valor > 8000
          ? Colors.redAccent
          : (valor > 4000 ? Colors.orangeAccent : Colors.greenAccent);
      maximoReferencia = 10000;
    } else if (titulo.toLowerCase().contains('liquidez')) {
      colorIndicador = valor >= 0 ? Colors.cyanAccent : Colors.redAccent;
      maximoReferencia = 10000;
    } else if (titulo.toLowerCase().contains('margen')) {
      colorIndicador = valor >= 0 ? Colors.greenAccent : Colors.redAccent;
      maximoReferencia = 10000;
    } else if (titulo.toLowerCase().contains('egreso')) {
      colorIndicador = Colors.redAccent;
      maximoReferencia = 20000;
    } else if (titulo.toLowerCase().contains('ingreso')) {
      colorIndicador = Colors.greenAccent;
      maximoReferencia = 20000;
    } else {
      colorIndicador = Colors.amberAccent;
      maximoReferencia = 10000;
    }

    // Calcular porcentaje del indicador
    final progreso = (valor / maximoReferencia).clamp(0.0, 1.0);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24, width: 0.5),
      ),
      child: Row(
        children: [
          Tooltip(
            message: descripcion,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(color: Colors.white, fontSize: 11),
            preferBelow: false,
            child: Icon(icon, color: colorIndicador),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              titulo,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.grey, size: 18),
            tooltip: "Ver explicación",
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: const Color(0xFF1E1E1E),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  title: Row(
                    children: [
                      Icon(icon, color: colorIndicador),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          titulo,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        descripcion,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 13, height: 1.4),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nivel actual: ${valor.toStringAsFixed(2)} / ${maximoReferencia.toStringAsFixed(2)}",
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 12),
                          ),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: progreso,
                              minHeight: 8,
                              color: colorIndicador,
                              backgroundColor: Colors.white10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Cerrar",
                        style: TextStyle(color: Colors.amberAccent),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Text(
            valor.toStringAsFixed(2),
            style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _indicatorTileConAyudaAuto(
    BuildContext context,
    String titulo,
    double valor,
    String unidad,
    String descripcion,
  ) {
    // Color y escala automática según tipo
    Color colorIndicador;
    double maximoReferencia;

    if (titulo.toLowerCase().contains('endeudamiento')) {
      colorIndicador = valor > 60
          ? Colors.redAccent
          : (valor > 40 ? Colors.orangeAccent : Colors.greenAccent);
      maximoReferencia = 100;
    } else if (titulo.toLowerCase().contains('liquidez')) {
      colorIndicador = valor < 1.0
          ? Colors.redAccent
          : (valor < 1.5 ? Colors.orangeAccent : Colors.cyanAccent);
      maximoReferencia = 3.0;
    } else if (titulo.toLowerCase().contains('margen') ||
        titulo.toLowerCase().contains('rentabilidad')) {
      colorIndicador = valor < 0
          ? Colors.redAccent
          : (valor < 10 ? Colors.orangeAccent : Colors.greenAccent);
      maximoReferencia = 20;
    } else if (titulo.toLowerCase().contains('crecimiento') ||
        titulo.toLowerCase().contains('variación')) {
      colorIndicador = valor < 0
          ? Colors.redAccent
          : (valor < 5 ? Colors.orangeAccent : Colors.greenAccent);
      maximoReferencia = 20;
    } else {
      colorIndicador = Colors.amberAccent;
      maximoReferencia = 100;
    }

    final progreso = (valor / maximoReferencia).clamp(0.0, 1.0);
    String etiquetaNivel;

    if (progreso < 0.33) {
      etiquetaNivel = "Bajo";
    } else if (progreso < 0.66) {
      etiquetaNivel = "Moderado";
    } else {
      etiquetaNivel = "Alto";
    }

    return Tooltip(
      message: descripcion,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(color: Colors.white, fontSize: 11),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              backgroundColor: const Color(0xFF1E1E1E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                titulo,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(descripcion,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(height: 10),
                  Text(
                    "Nivel actual: ${valor.toStringAsFixed(2)} $unidad — $etiquetaNivel",
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: progreso,
                      minHeight: 8,
                      color: colorIndicador,
                      backgroundColor: Colors.white10,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cerrar",
                      style: TextStyle(color: Colors.amberAccent)),
                ),
              ],
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.25),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white12, width: 0.5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            children: [
              Icon(Icons.circle, size: 10, color: colorIndicador),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  titulo,
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
              Text(
                "${valor.toStringAsFixed(2)}$unidad",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tileStatConInfoDialog(
      IconData icon, String titulo, double valor, String descripcion) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              titulo,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.amber, size: 18),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: Colors.black87,
                  title: Text(titulo,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 14)),
                  content: Text(descripcion,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 13)),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cerrar",
                          style: TextStyle(color: Colors.amber)),
                    ),
                  ],
                ),
              );
            },
          ),
          Text(
            valor.toStringAsFixed(2),
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _indicatorTile(String name, double value, String unit) {
    final color = value >= 0 ? Colors.greenAccent : Colors.redAccent;
    return ListTile(
      dense: true,
      title: Text(name, style: const TextStyle(color: Colors.white)),
      trailing: Text(
        "${value.isNaN ? 0 : value.toStringAsFixed(1)} $unit",
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _navButton(String label, int index) {
    final bool selected = _currentPage == index;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? Colors.blueAccent : Colors.grey.shade800,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: () {
        _pageController.animateToPage(index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      },
      child: Text(label,
          style:
              TextStyle(color: selected ? Colors.white : Colors.grey.shade400)),
    );
  }
  // --------------------------

  double safeParse(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) {
      final cleaned = value.replaceAll(',', '').trim();
      return double.tryParse(cleaned) ?? 0.0;
    }
    return 0.0;
  }

  double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String)
      return double.tryParse(value.replaceAll(',', '').trim()) ?? 0.0;
    return 0.0;
  }

  String _nombreMes(int mes) {
    const meses = [
      "Enero",
      "Febrero",
      "Marzo",
      "Abril",
      "Mayo",
      "Junio",
      "Julio",
      "Agosto",
      "Septiembre",
      "Octubre",
      "Noviembre",
      "Diciembre"
    ];
    return meses[(mes - 1) % 12];
  }

  /// 🧭 Sección superior: Gráficos + Estadísticas básicas
  Widget _EstadisticasBasicas() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Panel de gráficos
        Expanded(
          flex: 2,
          child: _buildCircularCharts(),
        ),

        const SizedBox(width: 10),

        // 🔹 Panel de estadísticas globales
        if (isDesktop(context) || isLargeDesktop(context))
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tileStat(Icons.upgrade, "Ingresos Globales",
                      safeParse(data['Ingreso_Global'])),
                  tileStat(Icons.arrow_drop_down, "Egresos Globales",
                      safeParse(data['Egreso_Global'])),
                  tileStat(Icons.balance, "Balance Global",
                      safeParse(data['Balance_Global'])),
                  CrossLine(),
                  tileStat(Icons.home_filled, "Patrimonio",
                      safeParse(data['Patrimonio'])),
                  tileStat(Icons.account_balance_wallet, "Balance Parcial",
                      safeParse(data['Balance_Parcial'])),
                  CrossLine(),
                  tileStat(Icons.person, "Total de Registros",
                      safeParse(data['Total_Registrados'])),
                  tileStat(Icons.person_add_alt_1, "Activos",
                      safeParse(data['Activos_Registrados'])),
                  tileStat(Icons.person_off, "Pasivos",
                      safeParse(data['Pasivos_Registrados'])),
                ],
              ),
            ),
          ),
      ],
    );
  }

// void _reiniciar(BuildContext context) {
  //   Activos.getEstadisticasFinancieras()
  //       .then((value) => setState(() => data = value))
  //       .onError((onError, stackTrace) => Operadores.alertActivity(
  //           context: context,
  //           tittle: "ERROR al Cuantificar Estadísticas . . .",
  //           message: "ERROR : $onError : : $stackTrace",
  //           onAcept: () => Navigator.of(context).pop()))
  //       .whenComplete(() => Archivos.createJsonFromMap([data],
  //           filePath: Activos.fileStadistics));
  // }
}
