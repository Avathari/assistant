import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/screens/pacientes/auxiliares/detalles/estadisticasVitales.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/antropometricos.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/WidgetsModels.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class OperacionesVitales extends StatefulWidget {
  final String operationActivity;

  String _operationButton = 'Nulo';

  OperacionesVitales({super.key, required this.operationActivity});

  @override
  State<OperacionesVitales> createState() => _OperacionesVitalesState();
}

class _OperacionesVitalesState extends State<OperacionesVitales> {

  @override
  void initState() {
    Actividades.consultarId(Databases.siteground_database_regpace,
            Vitales.vitales['consultLastQuery'], Pacientes.ID_Paciente)
        .then((value) => Pacientes.Vital = value);

    switch (widget.operationActivity) {
      case Constantes.Nulo:
        break;
      case Constantes.Consult:
        break;
      case Constantes.Register:
        widget._operationButton = 'Registrar';

        fechaRealizacionTextController.text =
            Calendarios.today(format: "yyyy/MM/dd HH:mm:ss");
        // estTextController.text = Pacientes.Vital['Pace_SV_est'].toString();
        // pctTextController.text = Pacientes.Vital['Pace_SV_pct'].toString();
        estTextController.text = Valores.alturaPaciente!.toString();
        pctTextController.text = Valores.pesoCorporalTotal!.toString();
        fraccionInspiratoriaOxigenoTextController.text = 21.toString();
        break;
      case Constantes.Update:
        setState(() {
          widget._operationButton = 'Actualizar';
          idOperation = Vitales.ID_Vitales;

          fechaRealizacionTextController.text = Valores.fechaVitales!;
          // Variables Vitales ********* *************** **********
          tasTextController.text = Valores.tensionArterialSystolica!.toString();
          tadTextController.text =
              Valores.tensionArterialDyastolica!.toString();
          fcTextController.text = Valores.frecuenciaCardiaca!.toString();
          frTextController.text = Valores.frecuenciaRespiratoria!.toString();
          tcTextController.text = Valores.temperaturCorporal!.toString();
          //
          spoTextController.text =
              Valores.saturacionPerifericaOxigeno!.toString();
          //
          estTextController.text = Valores.alturaPaciente!.toString();
          pctTextController.text = Valores.pesoCorporalTotal!.toString();
          //
          gluTextController.text = Valores.glucemiaCapilar!.toString();
          gluAyuTextController.text = Valores.horasAyuno!.toString();
          insulinaTextController.text = Valores.insulinaGastada!.toString();
          //
          fraccionInspiratoriaOxigenoTextController.text =
              Valores.fraccionInspiratoriaOxigeno.toString();
          presionVenosaCentralTextController.text =
              Valores.presionVenosaCentral.toString();
          presionIntraCerebralTextController.text =
              Valores.presionIntraCerebral.toString();
          presionIntraabdominalTextController.text =
              Valores.presionIntraabdominal.toString();
          // Variables Antropométricas ********* *************** **********
          cueTextController.text = Valores.circunferenciaCuello!.toString();
          //
          cinTextController.text = Valores.circunferenciaCintura!.toString();
          //
          cadTextController.text = Valores.circunferenciaCadera!.toString();
          //
          cmbTextController.text =
              Valores.circunferenciaMesobraquial!.toString();
          //

          factorActividadValue = Valores.factorActividad!.toString();
          //
          factorEstresValue = Valores.factorEstres!.toString();
          //

          pectTextController.text =
              Valores.circunferenciaPectoral!.toString() ?? "";
          //
          pcbTextController.text = Valores.pliegueCutaneoBicipital!.toString();
          //
          pseTextController.text = Valores.pliegueCutaneoEscapular!.toString();
          //
          psiTextController.text = Valores.pliegueCutaneoIliaco!.toString();
          //
          pstTextController.text = Valores.pliegueCutaneoTricipital!.toString();
          //
          femIzqTextController.text =
              Valores.circunferenciaFemoralIzquierda!.toString();
          //
          femDerTextController.text =
              Valores.circunferenciaFemoralDerecha!.toString();
          //
          suroIzqTextController.text =
              Valores.circunferenciaSuralIzquierda!.toString();
          //
          suroDerTextController.text =
              Valores.circunferenciaSuralDerecha!.toString();
        });
        super.initState();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Theming.primaryColor,
        title: AppBarText(appBarTitile),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          tooltip: Sentences.regresar,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => isMobile(context) || isTablet(context)
                    ? const GestionVitales()
                    : VisualPacientes(actualPage: 3)));
          },
        ),
        actions: isMobile(context)
            ? <Widget>[
                GrandIcon(
                  iconData: Icons.medical_information_outlined,
                  labelButton: 'Signos Vitales',
                  onPress: () {
                    carouselController.jumpToPage(0);
                  },
                ),
                SizedBox(width: 10),
                GrandIcon(
                  iconData: Icons.volunteer_activism_outlined,
                  labelButton: 'Medidas Antropométricas',
                  onPress: () {
                    carouselController.jumpToPage(1);
                  },
                ),
                SizedBox(width: 5),
                // GrandIcon(
                //   iconData: Icons.candlestick_chart,
                //   labelButton: 'Análisis de Parámetros',
                //   onPress: () {
                //     Operadores.openActivity(
                //         context: context, chyldrim: const Antropometricos());
                //   },
                // ),
                SizedBox(width: 15),
              ]
            : null,
      ),
      body: Container(
        decoration: ContainerDecoration.roundedDecoration(),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: EditTextArea(
                      labelEditText: 'Fecha de realización',
                      keyBoardType: TextInputType.datetime,
                      numOfLines: 1,
                      inputFormat: MaskTextInputFormatter(
                          mask: '####/##/## ##:##:##', // 'yyyy-MM-dd HH:mm:ss'
                          filter: {"#": RegExp(r'[0-9]')},
                          type: MaskAutoCompletionType.lazy),
                      textController: fechaRealizacionTextController,
                      iconColor: Colors.white,
                      withShowOption: true,
                      selection: true,
                      onSelected: () {
                        fechaRealizacionTextController.text =
                            Calendarios.today(format: "yyyy/MM/dd HH:mm:ss");
                      },
                    ),
                  ),
                  // ),
                  isMobile(context)
                      ? Container()
                      : Expanded(
                          flex: 4,
                          child: GrandButton(
                              labelButton: "Signos Vitales",
                              onPress: () {
                                setState(() {
                                  carouselController.jumpToPage(0);
                                });
                              }),
                        ),
                  isMobile(context)
                      ? Container()
                      : Expanded(
                          flex: 4,
                          child: GrandButton(
                              labelButton: "Medidas Antropométricas",
                              onPress: () {
                                setState(() {
                                  carouselController.jumpToPage(1);
                                });
                              }),
                        )
                ],
              ),
            ),
            // Expanded(
            //   child: SingleChildScrollView(
            //     controller: ScrollController(),
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         GrandButton(
            //             labelButton: "Signos Vitales",
            //             onPress: () {
            //               setState(() {
            //                 carouselController.jumpToPage(0);
            //               });
            //             }),
            //         GrandButton(
            //             labelButton: "Medidas Antropométricas",
            //             onPress: () {
            //               setState(() {
            //                 carouselController.jumpToPage(1);
            //               });
            //             })
            //       ],
            //     ),
            //   ),
            // ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: ContainerDecoration.roundedDecoration(),
                        child: CarouselSlider(
                            items: [
                              GridView(
                                controller: ScrollController(),
                                padding: const EdgeInsets.all(8.0),
                                gridDelegate: GridViewTools.gridDelegate(
                                  crossAxisCount: isTablet(context)
                                      ? 1
                                      : isMobile(context)
                                          ? 2
                                          : 2,
                                  crossAxisSpacing: 1.0,
                                  mainAxisSpacing: 5.0,
                                  mainAxisExtent: isMobile(context) ? 60 : 50,
                                ),
                                children: component(context),
                              ),
                              GridView(
                                controller: ScrollController(),
                                padding: const EdgeInsets.all(8.0),
                                gridDelegate: GridViewTools.gridDelegate(
                                  crossAxisCount: isTablet(context)
                                      ? 1
                                      : isMobile(context)
                                          ? 2
                                          : 2,
                                  crossAxisSpacing: 1.0,
                                  mainAxisSpacing: 5.0,
                                  mainAxisExtent: isMobile(context) ? 60 : 70,
                                ),
                                children: secondComponent(context),
                              ),
                            ],
                            carouselController: carouselController,
                            options:
                                Carousel.carouselOptions(context: context)),
                      ),
                    ),
                    isMobile(context)
                        ? Container()
                        : Expanded(
                            flex: isTablet(context) ? 2 : 1,
                            child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: const Antropometricos()),
                          )
                  ],
                ),
              ),
            ),
            Expanded(
              child: GrandButton(
                  weigth: 2000,
                  labelButton: widget._operationButton,
                  onPress: () {
                    operationMethod(context);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Future<void> reiniciar() async {
    Terminal.printExpected(message: "Reinicio de los valores . . .");
    try {
      final vitalesData = await Actividades.consultarAllById(
        Databases.siteground_database_regpace,
        Vitales.vitales['consultByIdPrimaryQuery'],
        Pacientes.ID_Paciente,
      );

      if (vitalesData.isEmpty || vitalesData[0]['Error'] == "No se encontraron datos") return;

      final antropoData = await Actividades.consultarAllById(
        Databases.siteground_database_regpace,
        Vitales.antropo['consultByIdPrimaryQuery'],
        Pacientes.ID_Paciente,
      );

      // Crear un Map usando una combinación de claves únicas
      final Map<String, Map<String, dynamic>> vitalesMap = {
        for (var v in vitalesData)
          "${v['ID_Pace']}_${v['Pace_SV_Feca']}" : v
      };

      final List<Map<String, dynamic>> combinados = [];

      for (var antropo in antropoData) {
        final key = "${antropo['ID_Pace']}_${antropo['Pace_SV_Feca']}";
        final vital = vitalesMap[key] ?? {};
        final combinado = {...vital, ...antropo};
        combinados.add(combinado);
      }

      setState(() {
        Pacientes.Vitales = combinados;
        listOfFirstValues = combinados;
      });

      await Archivos.createJsonFromMap(combinados, filePath: Vitales.fileAssocieted);

      Terminal.printSuccess(
          message: "Actualizando Repositorio de Signos Vitales del Paciente...");
    } catch (e, stack) {
      Operadores.alertActivity(
        context: context,
        tittle: "$e",
        message: "$stack",
        onAcept: () => Navigator.of(context).pop(),
      );
    }
  }

/*
  analisisVitales() {
    return Expanded(
      child: SizedBox(
          height: 500,
          child: ListView(
            controller: ScrollController(),
            children: [
              labelText("Ecuaciones con Signos Vitales"),
              const ListTile(
                leading: Icon(Icons.abc),
                title: Text("Hola"),
              )
            ],
          )),
    );
  }
*/

  void returnGestion(BuildContext context) {
    switch (isMobile(context) || isTablet(context)) {
      case true:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const GestionVitales()));
        break;
      case false:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VisualPacientes(actualPage: 3)));
        break;
      default:
    }
  }

  List<Widget> component(BuildContext context) {
    return [
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '###',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Tensión arterial sistólica',
        textController: tasTextController,
        onChange: (value) =>
            Valores.tensionArterialSystolica = int.parse(value),
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '###',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Tensión arterial diastólica',
        textController: tadTextController,
        onChange: (value) =>
            Valores.tensionArterialDyastolica = int.parse(value),
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '###',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Frecuencia cardiaca',
        textController: fcTextController,
        onChange: (value) => Valores.frecuenciaCardiaca = int.parse(value),
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '##',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Frecuencia respiratoria',
        textController: frTextController,
        onChange: (value) => Valores.frecuenciaRespiratoria = int.parse(value),
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '##.#',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Temperatura corporal',
        textController: tcTextController,
        onChange: (value) => Valores.temperaturCorporal = double.parse(value),
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '##',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Saturación periférica de oxígeno',
        textController: spoTextController,
        onChange: (value) =>
            Valores.saturacionPerifericaOxigeno = int.parse(value),
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '###.##',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Peso corporal total',
        textController: pctTextController,
        onChange: (value) => Valores.pesoCorporalTotal = double.parse(value),
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '#.##',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Estatura (mts)',
        textController: estTextController,
        onChange: (value) => Valores.alturaPaciente = double.parse(value),
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '###',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Glucemia capilar',
        textController: gluTextController,
        onChange: (value) => Valores.glucemiaCapilar = int.parse(value),
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '##',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Horas de ayuno',
        textController: gluAyuTextController,
        onChange: (value) => Valores.horasAyuno = int.parse(value),
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '##',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Insulina Gastada (UI/Día)',
        textController: insulinaTextController,
        onChange: (value) => Valores.insulinaGastada = int.parse(value),
      ),
      if (!isMobile(context)) CrossLine(),
      if (!isMobile(context) && !isTablet(context)) CrossLine(),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        numOfLines: 1,
        labelEditText: 'Fracción Insp. O2',
        textController: fraccionInspiratoriaOxigenoTextController,
        onChange: (value) {
          setState(() {
            Valores.fraccionInspiratoriaOxigeno =
                Valores.fraccionInspiratoriaVentilatoria = int.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        numOfLines: 1,
        labelEditText: 'Presión Venosa Central',
        textController: presionVenosaCentralTextController,
        onChange: (value) {
          setState(() {
            Valores.presionVenosaCentral = int.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        numOfLines: 1,
        labelEditText: 'Presión Intracerebral',
        textController: presionIntraCerebralTextController,
        onChange: (value) {
          setState(() {
            Valores.presionIntraCerebral = int.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        numOfLines: 1,
        labelEditText: 'Presión Intraabdominal', // Presión Intraabdominal
        textController: presionIntraabdominalTextController,
        onChange: (value) {
          setState(() {
            Valores.presionIntraabdominal = int.parse(value);
          });
        },
      ),
    ];
  }

  List<Widget> secondComponent(BuildContext context) {
    return [
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '###',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Circunferencia cervical',
        textController: cueTextController,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '###',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Circunferencia cintura',
        textController: cinTextController,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '###',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Circunferencia cadera',
        textController: cadTextController,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '###',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Circunferencia medio braquial',
        textController: cmbTextController,
      ),
      Spinner(
          isRow: true,
          width: isMobile(context) ? 60 : 40,
          tittle: "Factor de actividad",
          initialValue: factorActividadValue,
          items: Vitales.factorActividad,
          onChangeValue: (String? newValue) {
            setState(() {
              factorActividadValue = newValue!;
            });
          }),
      Spinner(
          isRow: true,
          width: isMobile(context) ? 60 : 40,
          tittle: "Factor de estrés",
          initialValue: factorEstresValue,
          items: Vitales.factorEstres,
          onChangeValue: (String? newValue) {
            setState(() {
              factorEstresValue = newValue!;
            });
          }),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '##',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Pliegue subcutáneo escapular',
        textController: pseTextController,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '##',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Pliegue subcutáneo iliaco',
        textController: psiTextController,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '###',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Pliegue subcutáneo tricipital',
        textController: pstTextController,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '###',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Circunferencia pectoral',
        textController: pectTextController,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '###',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Circunferencia femoral izquierdo',
        textController: femIzqTextController,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '###',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Circunferencia femoral derecho',
        textController: femDerTextController,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '###',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Circunferencia sural izquierda',
        textController: suroIzqTextController,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '###',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Circunferencia sural derecho',
        textController: suroDerTextController,
      ),
    ];
  }

  // VARIABLES DE LA INTERFAZ *********** *********** **********
  String? consultIdQueryvitales = Vitales.vitales['consultIdQuery'];
  String? consultIdQueryantropo = Vitales.antropo['consultIdQuery'];
  //
  String? registerQueryvitales = Vitales.vitales['registerQuery'];
  String? registerQueryantropo = Vitales.antropo['registerQuery'];
  //
  String? updateQueryvitales = Vitales.vitales['updateQuery'];
  String? updateQueryantropo = Vitales.antropo['updateQuery'];

  int idOperation = 0;

  List<dynamic>? listOfFirstValues, listOfSecondValues;

  String appBarTitile = "Gestión de Vitales";
// CONTROLADORES *****************************************
  var fechaRealizacionTextController = TextEditingController();
  var tasTextController = TextEditingController();
  var tadTextController = TextEditingController();
  var fcTextController = TextEditingController();
  var frTextController = TextEditingController();
  var tcTextController = TextEditingController();
  var spoTextController = TextEditingController();
  var estTextController = TextEditingController();
  var pctTextController = TextEditingController();
  var gluTextController = TextEditingController();
  var gluAyuTextController = TextEditingController();
  var insulinaTextController = TextEditingController();
  //
  var fraccionInspiratoriaOxigenoTextController = TextEditingController();
  //
  var presionVenosaCentralTextController = TextEditingController();
  var presionIntraabdominalTextController = TextEditingController();
  var presionIntraCerebralTextController = TextEditingController();
  //
  var cueTextController = TextEditingController();
  var cinTextController = TextEditingController();
  var cadTextController = TextEditingController();
  var cmbTextController = TextEditingController();

  String? factorActividadValue = Vitales.factorActividad[0];
  String? factorEstresValue = Vitales.factorEstres[0];

  var pectTextController = TextEditingController();
  var pcbTextController = TextEditingController();
  var pseTextController = TextEditingController();
  var psiTextController = TextEditingController();
  var pstTextController = TextEditingController();

  var femIzqTextController = TextEditingController();
  var femDerTextController = TextEditingController();
  var suroIzqTextController = TextEditingController();
  var suroDerTextController = TextEditingController();

  var antropoScroller = ScrollController();
  var vitalesScroller = ScrollController();

  var carouselController = CarouselSliderController();

  Future<void> operationMethod(BuildContext context) async {
    try {
      listOfFirstValues = [
        idOperation,
        Pacientes.ID_Paciente,
        fechaRealizacionTextController.text,
        tasTextController.text,
        tadTextController.text,
        fcTextController.text,
        frTextController.text,
        tcTextController.text,
        spoTextController.text,
        estTextController.text,
        pctTextController.text,
        gluTextController.text,
        gluAyuTextController.text,
        //
        fraccionInspiratoriaOxigenoTextController.text,
        presionVenosaCentralTextController.text,
        presionIntraCerebralTextController.text,
        presionIntraabdominalTextController.text,
        //
        insulinaTextController.text,
        idOperation
      ];
      listOfSecondValues = [
        idOperation,
        Pacientes.ID_Paciente,
        fechaRealizacionTextController.text,
        cueTextController.text,
        cinTextController.text,
        cadTextController.text,
        cmbTextController.text,
        pctTextController.text,
        factorActividadValue,
        factorEstresValue,
        pectTextController.text,
        pcbTextController.text,
        pseTextController.text,
        psiTextController.text,
        pstTextController.text,
        femIzqTextController.text,
        femDerTextController.text,
        suroIzqTextController.text,
        suroDerTextController.text,
        idOperation
      ];
      //

      Terminal.printExpected(message: listOfFirstValues.toString());
      //
      switch (widget.operationActivity) {
        case Constantes.Nulo:
          break;
        case Constantes.Consult:
          break;
        case Constantes.Register:
          listOfFirstValues!.removeAt(0);
          listOfFirstValues!.removeLast();
          //
          listOfSecondValues!.removeAt(0);
          listOfSecondValues!.removeLast();

          Actividades.registrar(Databases.siteground_database_regpace,
                  registerQueryvitales!, listOfFirstValues!)
              .then((value) {
            Actividades.registrar(Databases.siteground_database_regpace,
                    registerQueryantropo!, listOfSecondValues!)
                .then((value) {
              Archivos.deleteFile(filePath: Vitales.fileAssocieted);
              reiniciar().then((value) => Operadores.alertActivity(
                  context: context,
                  tittle: "Anexión de registros",
                  message: "Registros Agregados",
                  onAcept: () {
                    returnGestion(context);
                  }));
            }); // );
          });
          break;
        case Constantes.Update:
            try {
              // Actualizar signos vitales
              await Actividades.actualizar(
                Databases.siteground_database_regpace,
                updateQueryvitales!,
                listOfFirstValues!,
                idOperation,
              );

              // Actualizar datos antropométricos
              await Actividades.actualizar(
                Databases.siteground_database_regpace,
                updateQueryantropo!,
                listOfSecondValues!,
                idOperation,
              );

              // Borrar archivo local
              Archivos.deleteFile(filePath: Vitales.fileAssocieted);

              // Reiniciar app o estado
              await reiniciar();

              // Mostrar alerta de éxito
              Operadores.alertActivity(
                context: context,
                tittle: "Actualización de registros",
                message: "Registros Actualizados",
                onAcept: () => returnGestion(context),
              );
            } catch (e, stack) {
              print("❌ Error al actualizar: $e\n$stack");
              // Aquí puedes agregar un alertActivity si quieres manejar errores
            }

          // Actividades.actualizar(Databases.siteground_database_regpace,
          //         updateQueryvitales!, listOfFirstValues!, idOperation)
          //     .then((value) {
          //   Actividades.actualizar(Databases.siteground_database_regpace,
          //           updateQueryantropo!, listOfSecondValues!, idOperation)
          //       // .then((value) => Actividades.consultarId(
          //       //         Databases.siteground_database_regpace,
          //       //         consultIdQueryvitales!,
          //       //         idOperation)
          //       //     .then((value) {
          //       //       Pacientes.Vital = value;
          //       //     })
          //       //     .then((value) => Actividades.consultarId(
          //       //                 Databases.siteground_database_regpace,
          //       //                 consultIdQueryantropo!,
          //       //                 idOperation)
          //       //             .then((value) {
          //       //           Pacientes.Vital.addAll(value);
          //       //           print("Pacientes.Vital ${Pacientes.Vital}");
          //       //         }))
          //       .then((value) {
          //     Archivos.deleteFile(filePath: Vitales.fileAssocieted);
          //     reiniciar()
          //         .then((value) => Operadores.alertActivity(
          //             context: context,
          //             tittle: "Actualización de registros",
          //             message: "Registros Actualizados",
          //             onAcept: () {
          //               returnGestion(context);
          //             }))
          //         .onError((error, stackTrace) => null);
          //   }); // );
          // });
          break;
        default:
      }
    } catch (ex, sta) {
      showDialog(
          context: context,
          builder: (context) {
            return alertDialog(
                "Error al operar con los valores : ", "$ex : $sta", () {
              Navigator.of(context).pop();
            }, () {});
          });
      Terminal.printAlert(
          message: "Error al operar con los valores : $ex : $sta");
    }
  }
}

class GestionVitales extends StatefulWidget {
  const GestionVitales({super.key});

  @override
  State<GestionVitales> createState() => _GestionVitalesState();
}

class _GestionVitalesState extends State<GestionVitales> {
  var fileAssocieted = Vitales.fileAssocieted;

  @override
  void initState() {
    iniciar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: isMobile(context) || isTablet(context)
          ? AppBar(
              foregroundColor: Colors.white,
              backgroundColor: Theming.primaryColor,
              leading: isMobile(context) || isTablet(context)
                  ? IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                      tooltip: Sentences.regresar,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                VisualPacientes(actualPage: 0)));
                      },
                    )
                  : null,
              title: AppBarText(appBarSentence),
              actions: [
                GrandIcon(
                  iconData: Icons.replay,
                  onPress: () {
                    reiniciar();
                  },
                ),
                SizedBox(width: 20),
              ],
            )
          : null,
      body: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: EditTextArea(
                  keyBoardType: TextInputType.number,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  labelEditText: "Buscar por Fecha",
                  textController: searchTextController,
                  numOfLines: 1,
                  selection: true,
                  withShowOption: true,
                  onSelected: () {
                    Operadores.selectOptionsActivity(
                        context: context,
                        options: Listas.listWithoutRepitedValues(
                          Listas.listFromMapWithOneKey(
                            foundedItems!,
                            keySearched: 'Pace_Feca_SV',
                          ),
                        ),
                        onClose: (value) {
                          setState(() {
                            searchTextController.text = value;
                            _runFilterSearch(value);
                            Navigator.of(context).pop();
                          });
                        });
                  },
                  onChange: (value) {
                    setState(
                      () {
                        _runFilterSearch(value);
                      },
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: IconButton(
                      icon: const Icon(
                        Icons.add_card,
                        color: Colors.grey,
                      ),
                      tooltip: Sentences.add_vitales,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => OperacionesVitales(
                            operationActivity: Constantes.Register,
                          ),
                        ));
                      },
                    ),
                  ),
                  isDesktop(context) == true
                      ? Expanded(
                          child: GrandIcon(
                            labelButton: 'Recargar',
                            iconData: Icons.replay,
                            onPress: () {
                              reiniciar();
                            },
                          ),
                        )
                      : Container()
                ],
              ),
              Expanded(
                flex: 12,
                child: RefreshIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.black,
                  onRefresh: _pullListRefresh,
                  child: FutureBuilder<List>(
                    initialData: foundedItems!,
                    future: Future.value(foundedItems!),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? ListView.builder(
                              controller: gestionScrollController,
                              shrinkWrap: true,
                              itemCount: snapshot.data == null
                                  ? 0
                                  : snapshot.data.length,
                              itemBuilder: (context, posicion) {
                                return itemListView(
                                    snapshot, posicion, context);
                              },
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircularProgressIndicator(),
                                  const SizedBox(height: 50),
                                  Text(
                                    snapshot.hasError
                                        ? snapshot.error.toString()
                                        : snapshot.error.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        isTabletAndDesktop(context) || isDesktop(context)
            ? const Expanded(flex: 1, child: EstadisticasVitales())
            : Container()
      ]),
    );
  }

  void iniciar() {
    Terminal.printWarning(
        message: " . . . Iniciando Actividad - Repositorio de Pacientes");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        // Terminal.printWarning(message: " . . . ${value}");

        if (value.isNotEmpty && value != []) {
          if (value[0]['Error'] != "No se encontraron datos") {
            foundedItems = value;
            Pacientes.Vitales = value;
          }
          // Vitales.fromJson(Pacientes.Vitales!.last);
          Terminal.printSuccess(
              message: "Repositorio de Signos Vitales del Paciente . . . ");
        } else {
          reiniciar();
        }
      });
    }).onError((error, stackTrace) {
      reiniciar();
    });

    Terminal.printWarning(message: " . . . Actividad Iniciada");
  }

    Future<void> reiniciar() async {
           try {
        final vitalesData = await Actividades.consultarAllById(
          Databases.siteground_database_regpace,
          Vitales.vitales['consultByIdPrimaryQuery'],
          Pacientes.ID_Paciente,
        );

        if (vitalesData.isEmpty || vitalesData[0]['Error'] == "No se encontraron datos") return;

        final antropoData = await Actividades.consultarAllById(
          Databases.siteground_database_regpace,
          Vitales.antropo['consultByIdPrimaryQuery'],
          Pacientes.ID_Paciente,
        );

        // Crear un Map usando una combinación de claves únicas
        final Map<String, Map<String, dynamic>> vitalesMap = {
          for (var v in vitalesData)
            "${v['ID_Pace']}_${v['Pace_Feca_SV']}" : v
        };

        final List<Map<String, dynamic>> combinados = [];

        for (var antropo in antropoData) {
          final key = "${antropo['ID_Pace']}_${antropo['Pace_Feca_SV']}";
          final vital = vitalesMap[key] ?? {};
          final combinado = {...vital, ...antropo};
          combinados.add(combinado);
        }

        combinados.sort((a, b) {
          final fechaA = DateTime.parse((a['Pace_Feca_SV']));
          final fechaB = DateTime.parse((b['Pace_Feca_SV']));
          return fechaB.compareTo(fechaA);
        });

        setState(() {
          Pacientes.Vitales = combinados;
          foundedItems = combinados;

          Terminal.printSuccess(
              message: "Repositorio de Signos Vitales del Paciente . . . ");
        });

        await Archivos.createJsonFromMap(combinados, filePath: fileAssocieted);

        Terminal.printSuccess(
            message: "Actualizando Repositorio de Signos Vitales del Paciente...");
      } catch (e, stack) {
        Operadores.alertActivity(
          context: context,
          tittle: "$e",
          message: "$stack",
          onAcept: () => Navigator.of(context).pop(),
        );
      }
      // Terminal.printAlert(
      //     message: "Re-iniciando actividad : : \n "
      //         "Repositorio de Signos Vitales del Paciente . . .");
      // List result = [];
      // //
      // Pacientes.Vitales!.clear();
      // Actividades.consultarAllById(Databases.siteground_database_regpace,
      //         Vitales.vitales['consultByIdPrimaryQuery'], Pacientes.ID_Paciente)
      //     .then((value) {
      //   // print(value.length);
      //   if (value[0]['Error'] != "No se encontraron datos") {
      //     result.addAll(value);
      //   }
      //   // Terminal.printExpected(
      //   //     message: value!.toString());
      //   Actividades.consultarAllById(Databases.siteground_database_regpace,
      //           Vitales.antropo['consultByIdPrimaryQuery'], Pacientes.ID_Paciente)
      //       .then((value) {
      //     // Terminal.printData(
      //     //     message: value!.toString());
      //     int index = 0;
      //     //
      //     try {
      //       for (var item in result) {
      //         if (index <= result.length) {
      //           //
      //           var thirdMap = {};
      //           //
      //           thirdMap.addAll(item);
      //           thirdMap.addAll(value[index]);
      //           Pacientes.Vitales!.add(
      //               thirdMap); // Adición a Vitales ********** ************ ************** ********
      //           //
      //           index++;
      //         }
      //       }
      //       setState(() {
      //         foundedItems = Pacientes.Vitales!;
      //       });
      //     } catch (error, stackTrace) {
      //       Operadores.alertActivity(
      //           context: context,
      //           tittle: "$error",
      //           message: "$stackTrace",
      //           onAcept: () => Navigator.of(context).pop());
      //     }
      //
      //     Archivos.createJsonFromMap(foundedItems!, filePath: fileAssocieted);
      //     //
      //     Terminal.printSuccess(
      //         message:
      //             "Actualizando Repositorio de Signos Vitales del Paciente . . . ");
      //   }).catchError((error, stackTrace) {
      //     Operadores.alertActivity(
      //         context: context,
      //         tittle: "$error",
      //         message: "$stackTrace",
      //         onAcept: () => Navigator.of(context).pop());
      //   });
      // }).catchError((error, stackTrace) {
      //   Operadores.alertActivity(
      //       context: context,
      //       tittle: "$error",
      //       message: "$stackTrace",
      //       onAcept: () => Navigator.of(context).pop());
      // });
    }

  Container itemListView(
      AsyncSnapshot snapshot, int posicion, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          // Vitales.ID_Vitales = snapshot.data[posicion]['ID_Pace_SV'];
          // Pacientes.Vital = snapshot.data[posicion];
          Vitales.fromJson(snapshot.data[posicion]);

          toOperaciones(context, Constantes.Update);
        },
        child: Card(
          color: const Color.fromARGB(255, 54, 50, 50),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ID : ${snapshot.data[posicion]['ID_Pace_SV'].toString()}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 12),
                          ),
                          Text(
                            "Fecha de Realización: ${snapshot.data[posicion]['Pace_Feca_SV'].toString()}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 14),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GridView.count(
                            childAspectRatio: isMobile(context) ? 7.5 : 14,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            shrinkWrap: true,
                            children: [
                              Text(
                                "TA: ${snapshot.data[posicion]['Pace_SV_tas'].toString()}/${snapshot.data[posicion]['Pace_SV_tad'].toString()} mmHg",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 12),
                              ),
                              Text(
                                "Fc ${snapshot.data[posicion]['Pace_SV_fc'].toString()} L/min",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 12),
                              ),
                              Text(
                                "Fr: ${snapshot.data[posicion]['Pace_SV_fr'].toString()} Resp/min",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 12),
                              ),
                              Text(
                                "TC ${snapshot.data[posicion]['Pace_SV_tc'].toString()}°C",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 12),
                              ),
                              Text(
                                "PCT: ${snapshot.data[posicion]['Pace_SV_pct'].toString()} Kg",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 12),
                              ),
                              Text(
                                "Est ${snapshot.data[posicion]['Pace_SV_est'].toString()} mts",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          color: Colors.grey,
                          icon: const Icon(Icons.update_rounded),
                          onPressed: () {
                            Pacientes.ID_Paciente =
                                snapshot.data[posicion]['ID_Pace_SV'];
                            Pacientes.Paciente = snapshot.data[posicion];
                            toOperaciones(context, Constantes.Update);
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          color: Colors.grey,
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alertDialog(
                                    'Eliminar registro',
                                    '¿Esta seguro de querer eliminar el registro?',
                                    () {
                                      closeDialog(context);
                                    },
                                    () {
                                      deleteRegister(
                                          snapshot, posicion, context);
                                    },
                                  );
                                });
                          },
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void deleteRegister(
      AsyncSnapshot<dynamic> snapshot, int posicion, BuildContext context) {
    try {
      Actividades.eliminar(
          Databases.siteground_database_regpace,
          Vitales.vitales['deleteQuery'].toString(),
          snapshot.data[posicion]['ID_Pace_SV']);
      Actividades.eliminar(
          Databases.siteground_database_regpace,
          Vitales.antropo['deleteQuery'].toString(),
          snapshot.data[posicion]['ID_Pace_SV']);
      setState(() {
        snapshot.data.removeAt(posicion);
      });
    } finally {
      Navigator.of(context).pop();
    }
  }

  void toOperaciones(BuildContext context, String operationActivity) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => OperacionesVitales(
        operationActivity: operationActivity,
      ),
    ));
  }

  Future<Null> _pullListRefresh() async {
    iniciar();
  }

  void _runFilterSearch(String enteredKeyword) {
    List? results = [];

    if (enteredKeyword.isEmpty) {
      _pullListRefresh();
    } else {
      results = Listas.listFromMap(
          lista: foundedItems!,
          keySearched: 'Pace_Feca_SV',
          elementSearched: enteredKeyword);

      setState(() {
        foundedItems = results;
      });
    }
  }

  // VARIABLES DE INICIO ****** ****** ********* ***********
  String? consultQuery = Vitales.vitales['consultIdQuery'].toString();
  String? consultInQuery =
      Vitales.vitales['consultByIdPrimaryQuery'].toString();

  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  String appBarSentence = 'Gestor de signos vitales';
}

// Actividades.consultarId(Databases.siteground_database_regpace,
//         consultIdQueryantropo!, Vitales.ID_Vitales)
//     .then((value) {
//   setState(() {
//     Pacientes.Vital.addAll(value);
//
//     widget._operationButton = 'Actualizar';
//     idOperation = Pacientes.Vital['ID_Pace_SV'];
//
//     fechaRealizacionTextController.text =
//         Pacientes.Vital['Pace_Feca_SV'].toString();
//     //
//     tasTextController.text = Pacientes.Vital['Pace_SV_tas'].toString();
//     Valores.tensionArterialSystolica =
//         int.parse(tasTextController.text);
//     //
//     tadTextController.text = Pacientes.Vital['Pace_SV_tad'].toString();
//     Valores.tensionArterialDyastolica =
//         int.parse(tadTextController.text);
//     //
//     fcTextController.text = Pacientes.Vital['Pace_SV_fc'].toString();
//     Valores.frecuenciaCardiaca = int.parse(fcTextController.text);
//     //
//     frTextController.text = Pacientes.Vital['Pace_SV_fr'].toString();
//     Valores.frecuenciaRespiratoria = int.parse(frTextController.text);
//     //
//     tcTextController.text = Pacientes.Vital['Pace_SV_tc'].toString();
//     Valores.temperaturCorporal = double.parse(tcTextController.text);
//     //
//     spoTextController.text = Pacientes.Vital['Pace_SV_spo'].toString();
//     Valores.saturacionPerifericaOxigeno =
//         int.parse(spoTextController.text);
//     //
//     estTextController.text = Pacientes.Vital['Pace_SV_est'].toString();
//     Valores.alturaPaciente = double.parse(estTextController.text);
//     //
//     pctTextController.text = Pacientes.Vital['Pace_SV_pct'].toString();
//     Valores.pesoCorporalTotal = double.parse(pctTextController.text);
//     //
//     gluTextController.text = Pacientes.Vital['Pace_SV_glu'].toString();
//     Valores.glucemiaCapilar = int.parse(gluTextController.text);
//     //
//     gluAyuTextController.text =
//         Pacientes.Vital['Pace_SV_glu_ayu'].toString();
//     Valores.horasAyuno = int.parse(gluAyuTextController.text);
//     //
//     //
//     cueTextController.text = Pacientes.Vital['Pace_SV_cue'].toString();
//     Valores.circunferenciaCuello = int.parse(cueTextController.text);
//     //
//     cinTextController.text = Pacientes.Vital['Pace_SV_cin'].toString();
//     Valores.circunferenciaCintura = int.parse(cinTextController.text);
//     //
//     cadTextController.text = Pacientes.Vital['Pace_SV_cad'].toString();
//     Valores.circunferenciaCadera = int.parse(cadTextController.text);
//     //
//     cmbTextController.text = Pacientes.Vital['Pace_SV_cmb'].toString();
//     Valores.circunferenciaMesobraquial =
//         int.parse(cmbTextController.text);
//     //
//
//     factorActividadValue = Pacientes.Vital['Pace_SV_fa'].toString();
//     Valores.factorActividad = double.parse(factorActividadValue);
//     //
//     factorEstresValue = Pacientes.Vital['Pace_SV_fe'].toString();
//     Valores.factorEstres = double.parse(factorEstresValue);
//     //
//
//     pectTextController.text =
//         Pacientes.Vital['Pace_SV_c_pect'].toString();
//     // Valores.pec = int.parse(pectTextController.text);
//     //
//     pcbTextController.text = Pacientes.Vital['Pace_SV_pcb'].toString();
//     Valores.pliegueCutaneoBicipital = int.parse(pcbTextController.text);
//     //
//     pseTextController.text = Pacientes.Vital['Pace_SV_pse'].toString();
//     Valores.pliegueCutaneoEscapular = int.parse(pseTextController.text);
//     //
//     psiTextController.text = Pacientes.Vital['Pace_SV_psi'].toString();
//     Valores.pliegueCutaneoIliaco = int.parse(psiTextController.text);
//     //
//     pstTextController.text = Pacientes.Vital['Pace_SV_pst'].toString();
//     Valores.pliegueCutaneoTricipital =
//         int.parse(pstTextController.text);
//     //
//
//     femIzqTextController.text =
//         Pacientes.Vital['Pace_SV_c_fem_izq'].toString();
//     Valores.circunferenciaFemoralIzquierda =
//         int.parse(femIzqTextController.text);
//     //
//     femDerTextController.text =
//         Pacientes.Vital['Pace_SV_c_fem_der'].toString();
//     Valores.circunferenciaFemoralDerecha =
//         int.parse(femDerTextController.text);
//     //
//     suroIzqTextController.text =
//         Pacientes.Vital['Pace_SV_c_suro_izq'].toString();
//     Valores.circunferenciaSuralIzquierda =
//         int.parse(suroIzqTextController.text);
//     //
//     suroDerTextController.text =
//         Pacientes.Vital['Pace_SV_c_suro_der'].toString();
//     Valores.circunferenciaSuralDerecha =
//         int.parse(suroDerTextController.text);
//     //
//   });
// });
