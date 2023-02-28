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
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/GridLayout.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/WidgetsModels.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class OperacionesVitales extends StatefulWidget {
  final String operationActivity;

  String _operationButton = 'Nulo';

  OperacionesVitales({Key? key, required this.operationActivity})
      : super(key: key);

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

        // estTextController.text = Pacientes.Vital['Pace_SV_est'].toString();
        // pctTextController.text = Pacientes.Vital['Pace_SV_pct'].toString();
        estTextController.text = Valores.alturaPaciente!.toString();
        pctTextController.text = Valores.pesoCorporalTotal!.toString();
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

          pectTextController.text = Valores.circunferenciaPectoral!.toString();
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
      appBar: AppBar(
        backgroundColor: Theming.primaryColor,
        title: Text(appBarTitile),
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
                  iconData: Icons.candlestick_chart,
                  labelButton: 'Análisis de Parámetros',
                  onPress: () {
                    Operadores.openActivity(
                        context: context, chyldrim: const Antropometricos());
                  },
                ),
              ]
            : null,
      ),
      body: Card(
        color: const Color.fromARGB(255, 61, 57, 57),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              editFormattedText(
                  TextInputType.number,
                  MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  false,
                  'Fecha de realización',
                  fechaRealizacionTextController,
                  false),
              SingleChildScrollView(
                controller: ScrollController(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GrandButton(
                        labelButton: "Signos Vitales",
                        onPress: () {
                          setState(() {
                            carouselController.jumpToPage(0);
                          });
                        }),
                    GrandButton(
                        labelButton: "Medidas Antropométricas",
                        onPress: () {
                          setState(() {
                            carouselController.jumpToPage(1);
                          });
                        })
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CarouselSlider(
                            items: [
                              SingleChildScrollView(
                                  controller: ScrollController(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GridLayout(
                                      childAspectRatio: isMobile(context)
                                          ? 4.0
                                          : isTablet(context)
                                              ? 5.0
                                              : 5.0,
                                      columnCount: isMobile(context)
                                          ? 1
                                          : isTablet(context)
                                              ? 1
                                              : 2,
                                      children: component(context),
                                    ),
                                  )),
                              SingleChildScrollView(
                                  controller: ScrollController(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GridLayout(
                                      childAspectRatio: isMobile(context)
                                          ? 3.2
                                          : isTablet(context)
                                              ? 5.0
                                              : 5.0,
                                      columnCount: isMobile(context)
                                          ? 1
                                          : isTablet(context)
                                              ? 1
                                              : 2,
                                      children: secondComponent(context),
                                    ),
                                  ))
                            ],
                            carouselController: carouselController,
                            options: CarouselOptions(
                                height: 500,
                                enableInfiniteScroll: false,
                                viewportFraction: 1.0)),
                      ),
                      isMobile(context)
                          ? Container()
                          : Expanded(
                              child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: const Antropometricos()),
                            )
                    ],
                  ),
                ),
              ),
              GrandButton(
                  labelButton: widget._operationButton,
                  onPress: () {
                    operationMethod(context);
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> reiniciar() async {
    Terminal.printExpected(message: "Reinicio de los valores . . .");
    List result = [];
    Pacientes.Vitales!.clear();
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            Vitales.vitales['consultByIdPrimaryQuery'], Pacientes.ID_Paciente)
        .then((value) {
      result.addAll(value);
      Actividades.consultarAllById(Databases.siteground_database_regpace,
              Vitales.antropo['consultByIdPrimaryQuery'], Pacientes.ID_Paciente)
          .then((value) {
        int index = 0;
        for (var item in result) {
          if (index <= result.length) {
            var thirdMap = {};
            // print("${value.length} ${result.length}");
            // print("${value[index]['ID_Pace_SV']} ${item['ID_Pace_SV']}");
            thirdMap.addAll(item);
            thirdMap.addAll(value[index]);
            // Adición a Vitales ********** ************ ************** ********
            Pacientes.Vitales!.add(thirdMap);
            index++;
          }
        }
        setState(() {
          Terminal.printSuccess(
              message:
                  "Actualizando Repositorio de Signos Vitales del Paciente . . . ${Pacientes.Vitales}");
          Pacientes.Vitales!;
          Archivos.createJsonFromMap(Pacientes.Vitales!,
              filePath: Vitales.fileAssocieted);
        });
      });
    });
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
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Tensión arterial sistólica',
          tasTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Tensión arterial diastólica',
          tadTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Frecuencia cardiaca',
          fcTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Frecuencia respiratoria',
          frTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '##.#',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Temperatura corporal',
          tcTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Saturación periférica de oxígeno',
          spoTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '##.##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Peso corporal total',
          pctTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '#.##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Estatura (mts)',
          estTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Glucemia capilar',
          gluTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Horas de ayuno',
          gluAyuTextController,
          false),
    ];
  }

  List<Widget> secondComponent(BuildContext context) {
    return [
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Circunferencia cervical',
          cueTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Circunferencia cintura',
          cinTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Circunferencia cadera',
          cadTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Circunferencia medio braquial',
          cmbTextController,
          false),
      Spinner(
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
          width: 40,
          tittle: "Factor de estrés",
          initialValue: factorEstresValue,
          items: Vitales.factorEstres,
          onChangeValue: (String? newValue) {
            setState(() {
              factorEstresValue = newValue!;
            });
          }),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Pliegue subcutáneo escapular',
          pseTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Pliegue subcutáneo iliaco',
          psiTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Pliegue subcutáneo tricipital',
          pstTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Circunferencia pectoral',
          pectTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Circunferencia femoral izquierdo',
          femIzqTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Circunferencia femoral derecho',
          femDerTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Circunferencia sural izquierda',
          suroIzqTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Circunferencia sural derecho',
          suroDerTextController,
          false),
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
  //
  var cueTextController = TextEditingController();
  var cinTextController = TextEditingController();
  var cadTextController = TextEditingController();
  var cmbTextController = TextEditingController();

  String factorActividadValue = Vitales.factorActividad[0];
  String factorEstresValue = Vitales.factorEstres[0];

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

  var carouselController = CarouselController();

  void operationMethod(BuildContext context) {
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

      Terminal.printExpected(
          message:
              "${widget.operationActivity} listOfValues $listOfFirstValues ${listOfFirstValues!.length}");

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
          Actividades.actualizar(Databases.siteground_database_regpace,
                  updateQueryvitales!, listOfFirstValues!, idOperation)
              .then((value) {
            Actividades.actualizar(Databases.siteground_database_regpace,
                    updateQueryantropo!, listOfSecondValues!, idOperation)
                // .then((value) => Actividades.consultarId(
                //         Databases.siteground_database_regpace,
                //         consultIdQueryvitales!,
                //         idOperation)
                //     .then((value) {
                //       Pacientes.Vital = value;
                //     })
                //     .then((value) => Actividades.consultarId(
                //                 Databases.siteground_database_regpace,
                //                 consultIdQueryantropo!,
                //                 idOperation)
                //             .then((value) {
                //           Pacientes.Vital.addAll(value);
                //           print("Pacientes.Vital ${Pacientes.Vital}");
                //         }))
                .then((value) {
              Archivos.deleteFile(filePath: Vitales.fileAssocieted);
              reiniciar().then((value) => Operadores.alertActivity(
                  context: context,
                  tittle: "Actualización de registros",
                  message: "Registros Actualizados",
                  onAcept: () {
                    returnGestion(context);
                  }));
            }); // );
          });
          break;
        default:
      }
    } catch (ex) {
      showDialog(
          context: context,
          builder: (context) {
            return alertDialog("Error al operar con los valores", "$ex", () {
              Navigator.of(context).pop();
            }, () {});
          });
    }
  }
}

class GestionVitales extends StatefulWidget {
  const GestionVitales({Key? key}) : super(key: key);

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
              title: Text(appBarSentence),
              actions: [
                GrandIcon(
                  iconData: Icons.replay,
                  onPress: () {
                    reiniciar();
                  },
                ),
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
        foundedItems = value;
        Pacientes.Vitales = value;
        Terminal.printSuccess(
            message: "Repositorio de Signos Vitales del Paciente . . . ");
      });
    }).onError((error, stackTrace) {
      reiniciar();
    });

    Terminal.printWarning(message: " . . . Actividad Iniciada");
  }

  void reiniciar() {
    Terminal.printAlert(
        message: "Iniciando actividad : : \n "
            "Repositorio de Signos Vitales del Paciente . . .");
    List result = [];
    Pacientes.Vitales!.clear();
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            Vitales.vitales['consultByIdPrimaryQuery'], Pacientes.ID_Paciente)
        .then((value) {
      result.addAll(value);
      Actividades.consultarAllById(Databases.siteground_database_regpace,
              Vitales.antropo['consultByIdPrimaryQuery'], Pacientes.ID_Paciente)
          .then((value) {
        int index = 0;
        for (var item in result) {
          if (index <= result.length) {
            var thirdMap = {};
            print("${value.length} ${result.length}");
            print("${value[index]['ID_Pace_SV']} ${item['ID_Pace_SV']}");
            thirdMap.addAll(item);
            thirdMap.addAll(value[index]);
            // Adición a Vitales ********** ************ ************** ********
            Pacientes.Vitales!.add(thirdMap);
            index++;
          }
        }
        setState(() {
          Terminal.printSuccess(
              message:
                  "Actualizando Repositorio de Signos Vitales del Paciente . . . ");
          foundedItems = Pacientes.Vitales!;
          Archivos.createJsonFromMap(foundedItems!, filePath: fileAssocieted);
        });
      });
    });
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
