import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/cardiometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/gasometricos.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/renometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/operativity/pacientes/valores/semiologia/semiotica.dart';
import 'package:assistant/screens/pacientes/auxiliares/revisiones/auxiliares/auxiliaresRevisiones.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/pendientes.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/analisisLaterales/analisisLaterales.dart';
import 'package:assistant/screens/pacientes/intensiva/contenidos/ventilaciones.dart';
import 'package:assistant/screens/pacientes/paraclinicos/auxiliares/conmutadorParaclinicos.dart';
import 'package:assistant/screens/pacientes/paraclinicos/info/historialParaclinicos.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/indicaciones.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Generales extends StatefulWidget {
  bool? analysis;

  /// Destinado a la Anexión de Vitales y Balance Hídrico del paciente de acuerdo a una fecha determinada.
  Generales({Key? key, this.analysis = false}) : super(key: key);

  @override
  State<Generales> createState() => _GeneralesState();
}

class _GeneralesState extends State<Generales> {
  int actualView = 0;

  var textMAHController = TextEditingController();

  @override
  void initState() {
    textDateEstudyController.text =
        Calendarios.today(format: 'yyyy-MM-dd HH:mm:ss');
    //

    if (Valores.alturaPaciente != null) {
      estTextController.text = Valores.alturaPaciente!.toString();
    } else {
      Valores.alturaPaciente = 0;
      estTextController.text = '0';
    }
    //
    if (Valores.pesoCorporalTotal != null) {
      pctTextController.text = Valores.pesoCorporalTotal!.toString();
    } else {
      Valores.pesoCorporalTotal = 0;
      pctTextController.text = '0';
    }
    //
    fraccionInspiratoriaOxigenoTextController.text = 21.toString();
    //
    setState(() => Valores.otrosIngresosBalances = Valores.aguaMetabolica);
    //
    viaOtrosIngresosTextController.text =
        Valores.otrosIngresosBalances!.toStringAsFixed(2);
    viaPerdidaTextController.text =
        Valores.perdidasInsensibles.toStringAsFixed(2);

    // Repositorio de Balances *****************************
    Archivos.readJsonToMap(
            filePath: "${Pacientes.localRepositoryPath}/balances.json")
        .then((value) {
      setState(() {
        Pacientes.Balances = value;
        // Balances.fromJson(value[value.lenght-1]);
      });
    });
    // Repositorio de Pendientes ****************************
    Archivos.readJsonToMap(
            filePath: "${Pacientes.localRepositoryPath}/pendientes.json")
        .then((value) {
      setState(() {
        Pacientes.Pendiente!.clear();
        // ***************************
        for (var map in value) {
          if (map?.containsKey("Pace_PEN_realized") ?? false) {
            if (map!["Pace_PEN_realized"] == 0) {
              // your list of map contains key "id" which has value 3
              Pacientes.Pendiente!.add(map);
            }
          }
        }
        // Pacientes.Pendiente = value; Terminal.printExpected(message: '${Pacientes.Pendiente!}');
      });
    });
    // Repositorio de Paraclínicos *****************************
    Archivos.readJsonToMap(
            filePath: "${Pacientes.localRepositoryPath}/paraclinicos.json")
        .then((value) {
      setState(() {
        Pacientes.Paraclinicos = value;
      });
    });
    super.initState();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Theming.quincuaryColor,
      endDrawer: _endDrawer(context),
      appBar: _appBar(context),
      body: isMobile(context) ? mobileView() : desktopView(),
      bottomNavigationBar: _bottomNavigationBar(context),
      floatingActionButtonLocation: isMobile(context)
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.endDocked,
      floatingActionButton: !isMobile(context)
          ? Wrap(children: [
              Column(
                children: [
                  GrandIcon(
                    // weigth: 25,
                    // heigth: 25,
                    size: 32,
                    labelButton: "Menu Lateral . . . ",
                    iconData: Icons.menu_open,
                    onPress: () => _key.currentState!.openEndDrawer(),
                  ),
                  const SizedBox(height: 20),
                  GrandIcon(
                      labelButton: "Rutina",
                      iconData: Icons.ad_units,
                      onPress: () {
                        Cambios.toNextActivity(context,
                            tittle: 'Anexión de la Rutina',
                            chyld: ConmutadorParaclinicos(
                                categoriaEstudio: "Rutina"));
                      }),
                ],
              ),
              const SizedBox(width: 20),
              CircleIcon(
                tittle: "Agregar Registro . . . ",
                iconed: Icons.app_registration_sharp,
                onChangeValue: () {
                  operationMethod(context);
                },
              ),
            ])
          : _floattingActionButton(context),
    );
  }

  // VARIABLES DE LA INTERFAZ ****************** ********
  var textDateEstudyController = TextEditingController();
  var carouselController = CarouselController();
  // **********************************************
  int idOperation = 0;
  List<dynamic>? listOfFirstValues, listOfSecondValues, listOfValues;
  // **********************************************
  String? registerQueryvitales = Vitales.vitales['registerQuery'];
  String? registerQueryantropo = Vitales.antropo['registerQuery'];
  // **********************************************
  var fechaCVPTextController = TextEditingController();
  // **********************************************
  var tasTextController = TextEditingController();
  var tadTextController = TextEditingController();
  var fcTextController = TextEditingController();
  var frTextController = TextEditingController();
  var tcTextController = TextEditingController();
  var spoTextController = TextEditingController();
  var estTextController = TextEditingController();
  var pctTextController = TextEditingController();
  //
  var circunferenciaCinturaTextController = TextEditingController();
  //
  var gluTextController = TextEditingController();
  var gluAyuTextController = TextEditingController();
  // **********************************************
  var fraccionInspiratoriaOxigenoTextController = TextEditingController();
  //
  var presionVenosaCentralTextController = TextEditingController();
  var presionIntraabdominalTextController = TextEditingController();
  var presionIntraCerebralTextController = TextEditingController();
  //
  var presionArteriaPulmonarSistolicaTextController = TextEditingController();
  var presionArteriaPulmonarDiastolicaTextController = TextEditingController();
  var presionMediaArteriaPulmonarTextController = TextEditingController();
  var presionCunaPulmonarTextController = TextEditingController();

// **********************************************
  var isHorarioValue = Balances.actualDiagno[6];
// **********************************************
  var viaOralTextController = TextEditingController();
  var viaOrogasTextController = TextEditingController();
  var viaHemosTextController = TextEditingController();
  var viaNutrianTextController = TextEditingController();
  var viaParesTextController = TextEditingController();
  var viaDilucionesTextController = TextEditingController();
  var viaOtrosIngresosTextController = TextEditingController();
  // **********************************************
  var viaUresisTextController = TextEditingController();
  var viaEvacTextController = TextEditingController();
  var viaSangTextController = TextEditingController();
  var viaSucciTextController = TextEditingController();
  var viaDreneTextController = TextEditingController();
  var viaPerdidaTextController = TextEditingController();
  var viaOtrosEgresosTextController = TextEditingController();
  //
  var disposValue;
  // **********************************************
  void operationMethod(BuildContext context) {
    try {
      listOfFirstValues = [
        idOperation,
        Pacientes.ID_Paciente,
        textDateEstudyController.text,
        tasTextController.text,
        tadTextController.text,
        fcTextController.text,
        frTextController.text,
        tcTextController.text,
        spoTextController.text,
        // FiO2
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
        idOperation
      ];
      listOfSecondValues = [
        idOperation,
        Pacientes.ID_Paciente,
        textDateEstudyController.text,
        '', // cueTextController.text,
        circunferenciaCinturaTextController.text,
        '', // cadTextController.text,
        '', // cmbTextController.text,
        pctTextController.text,
        '0.9', // factorActividadValue,
        '0.9', // factorEstresValue,
        '', // pectTextController.text,
        '', // pcbTextController.text,
        '', // pseTextController.text,
        '', // psiTextController.text,
        '', // pstTextController.text,
        '', // femIzqTextController.text,
        '', // femDerTextController.text,
        '', // suroIzqTextController.text,
        '', // suroDerTextController.text,
        idOperation
      ];
      listOfValues = [
        idOperation,
        Pacientes.ID_Paciente,
        textDateEstudyController.text,
        DateTime.now().toString(),
        // hora
        viaOralTextController.text,
        viaOrogasTextController.text,
        viaHemosTextController.text,
        viaNutrianTextController.text,
        viaParesTextController.text,
        viaDilucionesTextController.text,
        viaOtrosIngresosTextController.text,
        //
        viaUresisTextController.text,
        viaEvacTextController.text,
        viaSangTextController.text,
        viaSucciTextController.text,
        viaDreneTextController.text,
        viaPerdidaTextController.text,
        viaOtrosEgresosTextController.text,
        //
        isHorarioValue,
        //
        Exploracion.tipoSondaVesical,
        //
        idOperation
      ];

      Terminal.printExpected(
          message:
              " : : . . .  listOfValues $listOfFirstValues ${listOfFirstValues!.length}");

      listOfFirstValues!.removeAt(0);
      listOfFirstValues!.removeLast();
      //
      listOfSecondValues!.removeAt(0);
      listOfSecondValues!.removeLast();
      // ******************************************** *** *
      listOfValues!.removeAt(0);
      listOfValues!.removeLast();
      // ******************************************** *** *
      Actividades.registrar(Databases.siteground_database_regpace,
              registerQueryvitales!, listOfFirstValues!)
          .then((value) {
        Actividades.registrar(Databases.siteground_database_regpace,
                registerQueryantropo!, listOfSecondValues!)
            .then((value) {
          Actividades.registrar(Databases.siteground_database_reghosp,
                  Balances.balance['registerQuery'], listOfValues!)
              .then((value) => Actividades.consultarAllById(
                          Databases.siteground_database_reghosp,
                          Balances.balance['consultIdQuery'],
                          Pacientes.ID_Paciente) // idOperation)
                      .then((value) {
                    // ******************************************** *** *
                    Pacientes.Alergicos = value;
                    Constantes.reinit(value: value);
                    // ******************************************** *** *
                  }).then((value) {
                    Archivos.deleteFile(filePath: Balances.fileAssocieted);
                    Archivos.deleteFile(filePath: Vitales.fileAssocieted);

                    reiniciar().then((value) => Operadores.alertActivity(
                        context: context,
                        tittle: "Anexión de registros",
                        message: "Registros Agregados",
                        onAcept: () {
                          Navigator.of(context).pop();
                        }));
                  }));
        });
      });
    } catch (ex) {
      Operadores.alertActivity(
          context: context,
          tittle: 'ERROR Encontrado . . . ',
          message: 'Error al Operar con los Valores :  : $ex',
          onAcept: () {
            Navigator.of(context).pop();
          });
    }
  }

  Future<void> reiniciar() async {
    // ******************************** * * * *
    // Terminal.printExpected(message: "Reinicio de los valores . . .");
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

    // ******************************** * * * *
    Terminal.printExpected(message: "Reinicio de los valores . . .");
    Pacientes.Balances!.clear();
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            Balances.balance['consultByIdPrimaryQuery'], Pacientes.ID_Paciente)
        .then((value) {
      setState(() {
        Pacientes.Balances = value;
        Terminal.printSuccess(
            message:
                "Actualizando Repositorio de Patologías del Paciente . . . ${Pacientes.Balances}");

        Archivos.createJsonFromMap(Pacientes.Balances!,
            filePath: Balances.fileAssocieted);
      });
    });
  }

  // VISTAS *******************************************************
  Widget mobileView() {
    return CarouselSlider(
        items: [
          Wrap(
            runSpacing: 4.0,
            children: [
              EditTextArea(
                labelEditText: "Fecha de realización",
                numOfLines: 1,
                textController: textDateEstudyController,
                keyBoardType: TextInputType.datetime,
                withShowOption: true,
                selection: true,
                iconData: Icons.calculate_outlined,
                onSelected: () {
                  setState(() {
                    textDateEstudyController.text =
                        Calendarios.today(format: "yyyy/MM/dd HH:mm:ss");
                  });
                },
                inputFormat: MaskTextInputFormatter(
                    mask: '####/##/##',
                    filter: {"#": RegExp(r'[0-9]')},
                    type: MaskAutoCompletionType.lazy),
              ),
              CrossLine(thickness: 3, height: 15),
              Row(
                children: [
                  Expanded(
                    child: EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        numOfLines: 1,
                        labelEditText: 'Tensión arterial sistólica',
                        textController: tasTextController),
                  ),
                  Expanded(
                    child: EditTextArea(
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      numOfLines: 1,
                      labelEditText: 'Tensión arterial diastólica',
                      textController: tadTextController,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        numOfLines: 1,
                        labelEditText: 'Frecuencia cardiaca',
                        textController: fcTextController),
                  ),
                  Expanded(
                    child: EditTextArea(
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      numOfLines: 1,
                      labelEditText: 'Frecuencia respiratoria',
                      textController: frTextController,
                    ),
                  ),
                ],
              ),
              EditTextArea(
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(
                    mask: '##.#',
                    filter: {"#": RegExp(r'[0-9]')},
                    type: MaskAutoCompletionType.lazy),
                numOfLines: 1,
                labelEditText: 'Temperatura corporal',
                textController: tcTextController,
              ),
              EditTextArea(
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                numOfLines: 1,
                labelEditText: 'Saturación periférica de oxígeno',
                textController: spoTextController,
              ),
              Row(
                children: [
                  Expanded(
                    child: EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(
                            mask: '###.##',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy),
                        numOfLines: 1,
                        labelEditText: 'Peso corporal total',
                        textController: pctTextController,
                        onChange: (String value) {
                          Valores.pesoCorporalTotal =
                              double.parse(pctTextController.text);
                          viaPerdidaTextController.text =
                              Valores.perdidasInsensibles.toStringAsFixed(0);
                          viaOtrosIngresosTextController.text =
                              Valores.aguaMetabolica.toStringAsFixed(0);
                        }),
                  ),
                  Expanded(
                    child: EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(
                            mask: '#.##',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy),
                        numOfLines: 1,
                        labelEditText: 'Estatura (mts)',
                        textController: estTextController,
                        onChange: (String value) {
                          Valores.alturaPaciente =
                              double.parse(estTextController.text);
                        }),
                  ),
                ],
              ),
              //
              Row(
                children: [
                  Expanded(
                    child: EditTextArea(
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(
                          mask: '###',
                          filter: {"#": RegExp(r'[0-9]')},
                          type: MaskAutoCompletionType.lazy),
                      numOfLines: 1,
                      labelEditText: 'Glucemia capilar',
                      textController: gluTextController,
                    ),
                  ),
                  Expanded(
                    child: EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(
                            mask: '##',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy),
                        numOfLines: 1,
                        labelEditText: 'Horas de ayuno',
                        textController: gluAyuTextController),
                  ),
                ],
              ),
              CrossLine(thickness: 6, height: 15),
              Row(
                children: [
                  Expanded(
                    child: EditTextArea(
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      numOfLines: 1,
                      labelEditText: 'FiO2',
                      textController: fraccionInspiratoriaOxigenoTextController,
                      onChange: (value) {
                        setState(() {
                          Valores.fraccionInspiratoriaOxigeno =
                              Valores.fraccionInspiratoriaVentilatoria =
                                  int.parse(value);
                          Valores.fioArteriales = double.parse(value);
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: EditTextArea(
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      numOfLines: 1,
                      labelEditText: 'C. Abd. ',
                      textController: circunferenciaCinturaTextController,
                      onChange: (value) {
                        setState(() {
                          Valores.circunferenciaCintura = int.parse(value);
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: EditTextArea(
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      numOfLines: 1,
                      labelEditText: 'PVC',
                      textController: presionVenosaCentralTextController,
                      onChange: (value) {
                        setState(() {
                          Valores.presionVenosaCentral = int.parse(value);
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: EditTextArea(
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      numOfLines: 1,
                      labelEditText: 'PIC',
                      textController: presionIntraCerebralTextController,
                      onChange: (value) {
                        setState(() {
                          Valores.presionIntraCerebral = int.parse(value);
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: EditTextArea(
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      numOfLines: 1,
                      labelEditText: 'PIA', // Presión Intraabdominal
                      textController: presionIntraabdominalTextController,
                      onChange: (value) {
                        setState(() {
                          Valores.presionIntraabdominal = int.parse(value);
                        });
                      },
                    ),
                  ),
                ],
              ),
              CrossLine(thickness: 3, height: 15),
            ],
          ),
          SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.all(5.0),
                  decoration: ContainerDecoration.roundedDecoration(),
                  child: Row(
                    children: [
                      Expanded(
                        child: ValuePanel(
                          firstText: "ING",
                          secondText:
                              Valores.ingresosBalances.toStringAsFixed(2),
                          thirdText: "mL",
                        ),
                      ),
                      Expanded(
                        child: ValuePanel(
                          firstText: "ENG",
                          secondText:
                              Valores.egresosBalances.toStringAsFixed(2),
                          thirdText: "mL",
                        ),
                      ),
                      Expanded(
                        child: ValuePanel(
                          firstText: "BT",
                          secondText: Valores.balanceTotal.toStringAsFixed(2),
                          thirdText: "mL",
                        ),
                      ),
                    ],
                  ),
                ),
                CrossLine(color: Colors.grey),
                Row(
                  children: [
                    Expanded(
                      child: Spinner(
                          isRow: true,
                          tittle: "Intervalo de Horario",
                          onChangeValue: (String value) {
                            setState(() {
                              isHorarioValue = value;
                              Valores.horario = int.parse(value);
                            });
                          },
                          items: Opciones.horarios(),
                          width: isDesktop(context)
                              ? 300
                              : isTablet(context)
                                  ? 200
                                  : isMobile(context)
                                      ? 170
                                      : 200,
                          initialValue: isHorarioValue),
                    ),
                    Expanded(
                      child: Spinner(
                        isRow: true,
                        tittle: 'Sonda Vesical',
                        width: isDesktop(context)
                            ? 300
                            : isTablet(context)
                                ? 200
                                : isMobile(context)
                                    ? 170
                                    : 200,
                        items: Items.foley,
                        initialValue: Exploracion.tipoSondaVesical,
                        onChangeValue: (value) {
                          setState(() {
                            Exploracion.tipoSondaVesical = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                CrossLine(
                  color: Colors.grey,
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: 'Via Oral (mL)',
                        textController: viaOralTextController,
                        numOfLines: 1,
                        selection: true,
                        withShowOption: true,
                        onSelected: () {
                          Operadores.editTwoValuesDialog(
                              context: context,
                              onAcept: (value) {
                                Navigator.of(context).pop();
                                viaOralTextController.text = value;
                              });
                        },
                        onChange: (value) {
                          setState(() {
                            Valores.viaOralBalances = double.parse(value);
                          });
                        },
                      ),
                    ),
                    Expanded(
                        child: EditTextArea(
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Vía Uresis (mL)',
                      textController: viaUresisTextController,
                      numOfLines: 1,
                      selection: true,
                      withShowOption: true,
                      onSelected: () {
                        Operadores.editTwoValuesDialog(
                            context: context,
                            onAcept: (value) {
                              Navigator.of(context).pop();
                              viaUresisTextController.text = value;
                            });
                      },
                      onChange: (value) {
                        Valores.uresisBalances = double.parse(value);
                        setState(() {});
                      },
                    ))
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: 'Vía Sonda Orogástrica (mL)',
                        textController: viaOrogasTextController,
                        numOfLines: 1,
                        selection: true,
                        withShowOption: true,
                        onSelected: () {
                          Operadores.editTwoValuesDialog(
                              context: context,
                              onAcept: (value) {
                                Navigator.of(context).pop();
                                viaOrogasTextController.text = value;
                              });
                        },
                        onChange: (value) {
                          setState(() {
                            Valores.sondaOrogastricaBalances =
                                double.parse(value);
                          });
                        },
                      ),
                    ),
                    Expanded(
                        child: EditTextArea(
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Vía Evacuacionees. (mL)',
                      textController: viaEvacTextController,
                      numOfLines: 1,
                      selection: true,
                      withShowOption: true,
                      onSelected: () {
                        Operadores.editTwoValuesDialog(
                            context: context,
                            onAcept: (value) {
                              Navigator.of(context).pop();
                              viaEvacTextController.text = value;
                            });
                      },
                      onChange: (value) {
                        setState(() {
                          Valores.evacuacionesBalances = double.parse(value);
                        });
                      },
                    ))
                  ],
                ),
                // CrossLine(),
                //
                Row(
                  children: [
                    Expanded(
                      child: EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: 'Vía Hemoderivados (mL)',
                        textController: viaHemosTextController,
                        numOfLines: 1,
                        selection: true,
                        withShowOption: true,
                        onSelected: () {
                          Operadores.editTwoValuesDialog(
                              context: context,
                              onAcept: (value) {
                                Navigator.of(context).pop();
                                viaHemosTextController.text = value;
                              });
                        },
                        onChange: (value) {
                          setState(() {
                            Valores.hemoderivadosBalances = double.parse(value);
                          });
                        },
                      ),
                    ),
                    Expanded(
                        child: EditTextArea(
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Vía Sangrados (mL)',
                      textController: viaSangTextController,
                      numOfLines: 1,
                      selection: true,
                      withShowOption: true,
                      onSelected: () {
                        Operadores.editTwoValuesDialog(
                            context: context,
                            onAcept: (value) {
                              Navigator.of(context).pop();
                              viaSangTextController.text = value;
                            });
                      },
                      onChange: (value) {
                        setState(() {
                          Valores.sangradosBalances = double.parse(value);
                        });
                      },
                    ))
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: 'Vía N.P.T. (mL)',
                        textController: viaNutrianTextController,
                        numOfLines: 1,
                        selection: true,
                        withShowOption: true,
                        onSelected: () {
                          Operadores.editTwoValuesDialog(
                              context: context,
                              onAcept: (value) {
                                Navigator.of(context).pop();
                                viaNutrianTextController.text = value;
                              });
                        },
                        onChange: (value) {
                          setState(() {
                            Valores.nutricionParenteralBalances =
                                double.parse(value);
                          });
                        },
                      ),
                    ),
                    Expanded(
                        child: EditTextArea(
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Vía Succión (mL)',
                      textController: viaSucciTextController,
                      numOfLines: 1,
                      selection: true,
                      withShowOption: true,
                      onSelected: () {
                        Operadores.editTwoValuesDialog(
                            context: context,
                            onAcept: (value) {
                              Navigator.of(context).pop();
                              viaSucciTextController.text = value;
                            });
                      },
                      onChange: (value) {
                        setState(() {
                          Valores.succcionBalances = double.parse(value);
                        });
                      },
                    ))
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: 'Vía Sol. Parenterales (mL)',
                        textController: viaParesTextController,
                        numOfLines: 1,
                        selection: true,
                        withShowOption: true,
                        onSelected: () {
                          Operadores.editTwoValuesDialog(
                              context: context,
                              onAcept: (value) {
                                Navigator.of(context).pop();
                                viaParesTextController.text = value;
                              });
                        },
                        onChange: (value) {
                          setState(() {
                            Valores.parenteralesBalances = double.parse(value);
                          });
                        },
                      ),
                    ),
                    Expanded(
                        child: EditTextArea(
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Perdidas Insensibles (mL)',
                      textController: viaPerdidaTextController,
                      numOfLines: 1,
                    ))
                  ],
                ),
                //
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleIcon(
                        radios: 20,
                        tittle: '0.4',
                        onChangeValue: () {
                          Valores.constantePerdidasInsensibles = 0.2;
                          viaPerdidaTextController.text =
                              Valores.perdidasInsensibles.toStringAsFixed(2);
                        }),
                    CircleIcon(
                        radios: 20,
                        tittle: '0.5',
                        onChangeValue: () {
                          Valores.constantePerdidasInsensibles = 0.2;
                          viaPerdidaTextController.text =
                              Valores.perdidasInsensibles.toStringAsFixed(2);
                        }),
                    CircleIcon(
                        radios: 20,
                        tittle: '0.6',
                        onChangeValue: () {
                          Valores.constantePerdidasInsensibles = 0.6;
                          viaPerdidaTextController.text =
                              Valores.perdidasInsensibles.toStringAsFixed(2);
                        }),
                    CircleIcon(
                        radios: 20,
                        tittle: '0.5',
                        onChangeValue: () {
                          Valores.constantePerdidasInsensibles = 0.7;
                          viaPerdidaTextController.text =
                              Valores.perdidasInsensibles.toStringAsFixed(2);
                        }),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleIcon(
                        radios: 20,
                        tittle: '0.8',
                        onChangeValue: () {
                          Valores.constantePerdidasInsensibles = 0.8;
                          viaPerdidaTextController.text =
                              Valores.perdidasInsensibles.toStringAsFixed(2);
                        }),
                    CircleIcon(
                        radios: 20,
                        tittle: '0.9',
                        onChangeValue: () {
                          Valores.constantePerdidasInsensibles = 0.9;
                          viaPerdidaTextController.text =
                              Valores.perdidasInsensibles.toStringAsFixed(2);
                        }),
                    CircleIcon(
                        radios: 20,
                        tittle: '1.1',
                        onChangeValue: () {
                          Valores.constantePerdidasInsensibles = 1.1;
                          viaPerdidaTextController.text =
                              Valores.perdidasInsensibles.toStringAsFixed(2);
                        }),
                    CircleIcon(
                        radios: 20,
                        tittle: '1.2',
                        onChangeValue: () {
                          Valores.constantePerdidasInsensibles = 1.2;
                          viaPerdidaTextController.text =
                              Valores.perdidasInsensibles.toStringAsFixed(2);
                        }),
                  ],
                ),
                const SizedBox(height: 10),
                //
                Row(
                  children: [
                    Expanded(
                      child: EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: 'Vía Diluciones (mL)',
                        textController: viaDilucionesTextController,
                        numOfLines: 1,
                        selection: true,
                        withShowOption: true,
                        onSelected: () {
                          Operadores.editTwoValuesDialog(
                              context: context,
                              onAcept: (value) {
                                Navigator.of(context).pop();
                                viaDilucionesTextController.text = value;
                              });
                        },
                        onChange: (value) {
                          setState(() {
                            Valores.dilucionesBalances = double.parse(value);
                          });
                        },
                      ),
                    ),
                    Expanded(
                        child: EditTextArea(
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Otros Egresos (mL)',
                      textController: viaOtrosEgresosTextController,
                      numOfLines: 1,
                      selection: true,
                      withShowOption: true,
                      onSelected: () {
                        Operadores.editTwoValuesDialog(
                            context: context,
                            onAcept: (value) {
                              Navigator.of(context).pop();
                              viaOtrosEgresosTextController.text = value;
                            });
                      },
                      onChange: (value) {
                        setState(() {
                          Valores.otrosEgresosBalances = double.parse(value);
                        });
                      },
                    ))
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: 'Otros Ingresos (mL)',
                        textController: viaOtrosIngresosTextController,
                        numOfLines: 1,
                        selection: true,
                        withShowOption: true,
                        onSelected: () {
                          Operadores.editTwoValuesDialog(
                              context: context,
                              onAcept: (value) {
                                Navigator.of(context).pop();
                                viaOtrosIngresosTextController.text = value;
                              });
                        },
                        onChange: (value) {
                          setState(() {
                            Valores.otrosIngresosBalances = double.parse(value);
                          });
                        },
                      ),
                    ),
                    Expanded(child: Container(width: 200))
                  ],
                ),
                // Botton ***** ******* ****** * ***
                CrossLine(
                  color: Colors.grey,
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  decoration: ContainerDecoration.roundedDecoration(),
                  child: GrandButton(
                      labelButton: "Agregar Datos",
                      weigth: 2000,
                      onPress: () {
                        operationMethod(context);
                      }),
                )
              ],
            ),
          ),
          // REVISIONES . . .
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(flex: 2, child: RevisionPrevios()),
                    Expanded(child: RevisionInfusiones()),
                    // Expanded(child: RevisionCultivos(listado: Pacientes.getRevisionCultivos())),
                  ],
                ),
              ),
              Expanded(child: RevisionDispositivos()),
            ],
          ),
        ],
        carouselController: carouselController,
        options: Carousel.carouselOptions(context: context));
  }

  Widget desktopView() {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children: [
                  EditTextArea(
                    labelEditText: "Fecha de realización",
                    numOfLines: 1,
                    optionEqui: 5,
                    textController: textDateEstudyController,
                    keyBoardType: TextInputType.datetime,
                    withShowOption: true,
                    selection: true,
                    iconData: Icons.calculate_outlined,
                    onSelected: () {
                      setState(() {
                        textDateEstudyController.text =
                            Calendarios.today(format: "yyyy/MM/dd HH:mm:ss");
                      });
                    },
                    inputFormat: MaskTextInputFormatter(
                        mask: '####/##/##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                  ),
                  CrossLine(thickness: 3, height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          numOfLines: 1,
                          labelEditText: 'Tensión arterial sistólica',
                          textController: tasTextController,
                          onChange: (value) {
                            setState(() {
                              Valores.tensionArterialSystolica =
                                  int.parse(value);
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          numOfLines: 1,
                          labelEditText: 'Tensión arterial diastólica',
                          textController: tadTextController,
                          onChange: (value) {
                            setState(() {
                              Valores.tensionArterialDyastolica =
                                  int.parse(value);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                            keyBoardType: TextInputType.number,
                            inputFormat: MaskTextInputFormatter(),
                            numOfLines: 1,
                            labelEditText: 'Frecuencia cardiaca',
                            textController: fcTextController),
                      ),
                      Expanded(
                        child: EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          numOfLines: 1,
                          labelEditText: 'Frecuencia respiratoria',
                          textController: frTextController,
                        ),
                      ),
                    ],
                  ),
                  EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(
                        mask: '##.#',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    numOfLines: 1,
                    labelEditText: 'Temperatura corporal',
                    textController: tcTextController,
                  ),
                  EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    numOfLines: 1,
                    labelEditText: 'Saturación periférica de oxígeno',
                    textController: spoTextController,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                            keyBoardType: TextInputType.number,
                            inputFormat: MaskTextInputFormatter(
                                mask: '###.##',
                                filter: {"#": RegExp(r'[0-9]')},
                                type: MaskAutoCompletionType.lazy),
                            numOfLines: 1,
                            labelEditText: 'Peso corporal total',
                            textController: pctTextController,
                            onChange: (String value) {
                              Valores.pesoCorporalTotal =
                                  double.parse(pctTextController.text);
                              viaPerdidaTextController.text = Valores
                                  .perdidasInsensibles
                                  .toStringAsFixed(0);
                            }),
                      ),
                      Expanded(
                        child: EditTextArea(
                            keyBoardType: TextInputType.number,
                            inputFormat: MaskTextInputFormatter(
                                mask: '#.##',
                                filter: {"#": RegExp(r'[0-9]')},
                                type: MaskAutoCompletionType.lazy),
                            numOfLines: 1,
                            labelEditText: 'Estatura (mts)',
                            textController: estTextController,
                            onChange: (String value) {
                              Valores.alturaPaciente =
                                  double.parse(estTextController.text);
                            }),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(
                              mask: '###',
                              filter: {"#": RegExp(r'[0-9]')},
                              type: MaskAutoCompletionType.lazy),
                          numOfLines: 1,
                          labelEditText: 'Glucemia capilar',
                          textController: gluTextController,
                        ),
                      ),
                      Expanded(
                        child: EditTextArea(
                            keyBoardType: TextInputType.number,
                            inputFormat: MaskTextInputFormatter(
                                mask: '##',
                                filter: {"#": RegExp(r'[0-9]')},
                                type: MaskAutoCompletionType.lazy),
                            numOfLines: 1,
                            labelEditText: 'Horas de ayuno',
                            textController: gluAyuTextController),
                      ),
                    ],
                  ),
                  CrossLine(thickness: 6, height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          numOfLines: 1,
                          labelEditText: 'FiO2',
                          textController:
                              fraccionInspiratoriaOxigenoTextController,
                          onChange: (value) {
                            setState(() {
                              Valores.fraccionInspiratoriaOxigeno =
                                  Valores.fraccionInspiratoriaVentilatoria =
                                      int.parse(value);
                              Valores.fioArteriales = double.parse(value);
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          numOfLines: 1,
                          labelEditText: 'C. Abd. ',
                          textController: circunferenciaCinturaTextController,
                          onChange: (value) {
                            setState(() {
                              Valores.circunferenciaCintura = int.parse(value);
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          numOfLines: 1,
                          labelEditText: 'PVC',
                          textController: presionVenosaCentralTextController,
                          onChange: (value) {
                            setState(() {
                              Valores.presionVenosaCentral = int.parse(value);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          numOfLines: 1,
                          labelEditText: 'PIC',
                          textController: presionIntraCerebralTextController,
                          onChange: (value) {
                            setState(() {
                              Valores.presionIntraCerebral = int.parse(value);
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          numOfLines: 1,
                          labelEditText: 'PIA', // Presión Intraabdominal
                          textController: presionIntraabdominalTextController,
                          onChange: (value) {
                            setState(() {
                              Valores.presionIntraabdominal = int.parse(value);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  CrossLine(thickness: 3, height: 15),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(5.0),
                    decoration: ContainerDecoration.roundedDecoration(),
                    child: Row(
                      children: [
                        Expanded(
                          child: ValuePanel(
                            firstText: "ING",
                            secondText:
                                Valores.ingresosBalances.toStringAsFixed(2),
                            thirdText: "mL",
                          ),
                        ),
                        Expanded(
                          child: ValuePanel(
                            firstText: "ENG",
                            secondText:
                                Valores.egresosBalances.toStringAsFixed(2),
                            thirdText: "mL",
                          ),
                        ),
                        Expanded(
                          child: ValuePanel(
                            firstText: "BT",
                            secondText: Valores.balanceTotal.toStringAsFixed(2),
                            thirdText: "mL",
                          ),
                        ),
                      ],
                    ),
                  ),
                  CrossLine(color: Colors.grey),
                  //
                  Row(
                    children: [
                      Expanded(
                        child: Spinner(
                            isRow: true,
                            tittle: "Intervalo de Horario",
                            onChangeValue: (String value) {
                              setState(() {
                                isHorarioValue = value;
                                Valores.horario = int.parse(value);
                              });
                            },
                            items: Opciones.horarios(),
                            width: isDesktop(context)
                                ? 300
                                : isTablet(context)
                                    ? 200
                                    : isMobile(context)
                                        ? 170
                                        : 200,
                            initialValue: isHorarioValue),
                      ),
                      Expanded(
                        child: Spinner(
                          isRow: true,
                          tittle: 'Sonda Vesical',
                          width: isDesktop(context)
                              ? 300
                              : isTablet(context)
                                  ? 200
                                  : isMobile(context)
                                      ? 170
                                      : 200,
                          items: Items.foley,
                          initialValue: Exploracion.tipoSondaVesical,
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.tipoSondaVesical = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  CrossLine(
                    color: Colors.grey,
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Via Oral (mL)',
                          textController: viaOralTextController,
                          numOfLines: 1,
                          optionEqui: 4,
                          selection: true,
                          withShowOption: true,
                          onSelected: () {
                            Operadores.editTwoValuesDialog(
                                context: context,
                                onAcept: (value) {
                                  Navigator.of(context).pop();
                                  viaOralTextController.text = value;
                                });
                          },
                          onChange: (value) {
                            setState(() {
                              Valores.viaOralBalances = double.parse(value);
                            });
                          },
                        ),
                      ),
                      Expanded(
                          child: EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: 'Vía Uresis (mL)',
                        textController: viaUresisTextController,
                        numOfLines: 1,
                        optionEqui: 4,
                        selection: true,
                        withShowOption: true,
                        onSelected: () {
                          Operadores.editTwoValuesDialog(
                              context: context,
                              onAcept: (value) {
                                Navigator.of(context).pop();
                                viaUresisTextController.text = value;
                              });
                        },
                        onChange: (value) {
                          Valores.uresisBalances = double.parse(value);
                          setState(() {});
                        },
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Vía Sonda Orogástrica (mL)',
                          textController: viaOrogasTextController,
                          numOfLines: 1,
                          optionEqui: 4,
                          selection: true,
                          withShowOption: true,
                          onSelected: () {
                            Operadores.editTwoValuesDialog(
                                context: context,
                                onAcept: (value) {
                                  Navigator.of(context).pop();
                                  viaOrogasTextController.text = value;
                                });
                          },
                          onChange: (value) {
                            setState(() {
                              Valores.sondaOrogastricaBalances =
                                  double.parse(value);
                            });
                          },
                        ),
                      ),
                      Expanded(
                          child: EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: 'Vía Evacuacionees. (mL)',
                        textController: viaEvacTextController,
                        numOfLines: 1,
                        optionEqui: 4,
                        selection: true,
                        withShowOption: true,
                        onSelected: () {
                          Operadores.editTwoValuesDialog(
                              context: context,
                              onAcept: (value) {
                                Navigator.of(context).pop();
                                viaEvacTextController.text = value;
                              });
                        },
                        onChange: (value) {
                          setState(() {
                            Valores.evacuacionesBalances = double.parse(value);
                          });
                        },
                      ))
                    ],
                  ),
                  // CrossLine(),
                  //
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Vía Hemoderivados (mL)',
                          textController: viaHemosTextController,
                          numOfLines: 1,
                          optionEqui: 4,
                          selection: true,
                          withShowOption: true,
                          onSelected: () {
                            Operadores.editTwoValuesDialog(
                                context: context,
                                onAcept: (value) {
                                  Navigator.of(context).pop();
                                  viaHemosTextController.text = value;
                                });
                          },
                          onChange: (value) {
                            setState(() {
                              Valores.hemoderivadosBalances =
                                  double.parse(value);
                            });
                          },
                        ),
                      ),
                      Expanded(
                          child: EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: 'Vía Sangrados (mL)',
                        textController: viaSangTextController,
                        numOfLines: 1,
                        optionEqui: 4,
                        selection: true,
                        withShowOption: true,
                        onSelected: () {
                          Operadores.editTwoValuesDialog(
                              context: context,
                              onAcept: (value) {
                                Navigator.of(context).pop();
                                viaSangTextController.text = value;
                              });
                        },
                        onChange: (value) {
                          setState(() {
                            Valores.sangradosBalances = double.parse(value);
                          });
                        },
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Vía N.P.T. (mL)',
                          textController: viaNutrianTextController,
                          numOfLines: 1,
                          optionEqui: 4,
                          selection: true,
                          withShowOption: true,
                          onSelected: () {
                            Operadores.editTwoValuesDialog(
                                context: context,
                                onAcept: (value) {
                                  Navigator.of(context).pop();
                                  viaNutrianTextController.text = value;
                                });
                          },
                          onChange: (value) {
                            setState(() {
                              Valores.nutricionParenteralBalances =
                                  double.parse(value);
                            });
                          },
                        ),
                      ),
                      Expanded(
                          child: EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: 'Vía Succión (mL)',
                        textController: viaSucciTextController,
                        numOfLines: 1,
                        optionEqui: 4,
                        selection: true,
                        withShowOption: true,
                        onSelected: () {
                          Operadores.editTwoValuesDialog(
                              context: context,
                              onAcept: (value) {
                                Navigator.of(context).pop();
                                viaSucciTextController.text = value;
                              });
                        },
                        onChange: (value) {
                          setState(() {
                            Valores.succcionBalances = double.parse(value);
                          });
                        },
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Vía Sol. Parenterales (mL)',
                          textController: viaParesTextController,
                          numOfLines: 1,
                          optionEqui: 4,
                          selection: true,
                          withShowOption: true,
                          onSelected: () {
                            Operadores.editTwoValuesDialog(
                                context: context,
                                onAcept: (value) {
                                  Navigator.of(context).pop();
                                  viaParesTextController.text = value;
                                });
                          },
                          onChange: (value) {
                            setState(() {
                              Valores.parenteralesBalances =
                                  double.parse(value);
                            });
                          },
                        ),
                      ),
                      Expanded(
                          child: EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: 'Perdidas Insensibles (mL)',
                        textController: viaPerdidaTextController,
                        numOfLines: 1,
                        optionEqui: 4,
                      ))
                    ],
                  ),
                  // Perdidas Insensibles . . .
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleIcon(
                          radios: 20,
                          difRadios: 5,
                          tittle: '0.4',
                          onChangeValue: () {
                            Valores.constantePerdidasInsensibles = 0.2;
                            viaPerdidaTextController.text =
                                Valores.perdidasInsensibles.toStringAsFixed(2);
                          }),
                      CircleIcon(
                          radios: 20,
                          difRadios: 5,
                          tittle: '0.5',
                          onChangeValue: () {
                            Valores.constantePerdidasInsensibles = 0.2;
                            viaPerdidaTextController.text =
                                Valores.perdidasInsensibles.toStringAsFixed(2);
                          }),
                      CircleIcon(
                          radios: 20,
                          difRadios: 5,
                          tittle: '0.6',
                          onChangeValue: () {
                            Valores.constantePerdidasInsensibles = 0.6;
                            viaPerdidaTextController.text =
                                Valores.perdidasInsensibles.toStringAsFixed(2);
                          }),
                      CircleIcon(
                          radios: 20,
                          difRadios: 5,
                          tittle: '0.5',
                          onChangeValue: () {
                            Valores.constantePerdidasInsensibles = 0.7;
                            viaPerdidaTextController.text =
                                Valores.perdidasInsensibles.toStringAsFixed(2);
                          }),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleIcon(
                          radios: 20,
                          difRadios: 5,
                          tittle: '0.8',
                          onChangeValue: () {
                            Valores.constantePerdidasInsensibles = 0.8;
                            viaPerdidaTextController.text =
                                Valores.perdidasInsensibles.toStringAsFixed(2);
                          }),
                      CircleIcon(
                          radios: 20,
                          difRadios: 5,
                          tittle: '0.9',
                          onChangeValue: () {
                            Valores.constantePerdidasInsensibles = 0.9;
                            viaPerdidaTextController.text =
                                Valores.perdidasInsensibles.toStringAsFixed(2);
                          }),
                      CircleIcon(
                          radios: 20,
                          difRadios: 5,
                          tittle: '1.1',
                          onChangeValue: () {
                            Valores.constantePerdidasInsensibles = 1.1;
                            viaPerdidaTextController.text =
                                Valores.perdidasInsensibles.toStringAsFixed(2);
                          }),
                      CircleIcon(
                          radios: 20,
                          difRadios: 5,
                          tittle: '1.2',
                          onChangeValue: () {
                            Valores.constantePerdidasInsensibles = 1.2;
                            viaPerdidaTextController.text =
                                Valores.perdidasInsensibles.toStringAsFixed(2);
                          }),
                    ],
                  ),
                  const SizedBox(height: 10),
                  //
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Vía Diluciones (mL)',
                          textController: viaDilucionesTextController,
                          numOfLines: 1,
                          optionEqui: 4,
                          selection: true,
                          withShowOption: true,
                          onSelected: () {
                            Operadores.editTwoValuesDialog(
                                context: context,
                                onAcept: (value) {
                                  Navigator.of(context).pop();
                                  viaDilucionesTextController.text = value;
                                });
                          },
                          onChange: (value) {
                            setState(() {
                              Valores.dilucionesBalances = double.parse(value);
                            });
                          },
                        ),
                      ),
                      Expanded(
                          child: EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: 'Otros Egresos (mL)',
                        textController: viaOtrosEgresosTextController,
                        numOfLines: 1,
                        optionEqui: 4,
                        selection: true,
                        withShowOption: true,
                        onSelected: () {
                          Operadores.editTwoValuesDialog(
                              context: context,
                              onAcept: (value) {
                                Navigator.of(context).pop();
                                viaOtrosEgresosTextController.text = value;
                              });
                        },
                        onChange: (value) {
                          setState(() {
                            Valores.otrosEgresosBalances = double.parse(value);
                          });
                        },
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Otros Ingresos (mL)',
                          textController: viaOtrosIngresosTextController,
                          numOfLines: 1,
                          optionEqui: 4,
                          selection: true,
                          withShowOption: true,
                          onSelected: () {
                            Operadores.editTwoValuesDialog(
                                context: context,
                                onAcept: (value) {
                                  Navigator.of(context).pop();
                                  viaOtrosIngresosTextController.text = value;
                                });
                          },
                          onChange: (value) {
                            setState(() {
                              Valores.otrosIngresosBalances =
                                  double.parse(value);
                            });
                          },
                        ),
                      ),
                      Expanded(child: Container(width: 200))
                    ],
                  ),
                  // Botton ***** ******* ****** * ***
                  CrossLine(
                    color: Colors.grey,
                  ),
                  // Container(
                  //   margin: const EdgeInsets.all(5.0),
                  //   decoration: ContainerDecoration.roundedDecoration(),
                  //   child: GrandButton(
                  //       labelButton: "Agregar Datos",
                  //       weigth: 2000,
                  //       onPress: () {
                  //         operationMethod(context);
                  //       }),
                  // )
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: [
                    Spinner(
                      width: isDesktop(context)
                          ? 200
                          : isTablet(context)
                              ? 100
                              : isMobile(context)
                                  ? 65
                                  : 300,
                      tittle: 'Glasgow',
                      onChangeValue: (value) {
                        setState(() {
                          Exploracion.glasgow = value;
                        });
                      },
                      items: Escalas.glasgow,
                      initialValue: Exploracion.glasgow,
                    ),
                    Spinner(
                      width: isDesktop(context)
                          ? 200
                          : isTablet(context)
                              ? 100
                              : isMobile(context)
                                  ? 65
                                  : 300,
                      tittle: 'R.A.S.S.',
                      onChangeValue: (value) {
                        setState(() {
                          Exploracion.rass = value;
                        });
                      },
                      items: Escalas.RASS,
                      initialValue: Exploracion.rass,
                    ),
                    Spinner(
                      width: isDesktop(context)
                          ? 200
                          : isTablet(context)
                              ? 100
                              : isMobile(context)
                                  ? 65
                                  : 300,
                      tittle: 'Ramsay',
                      onChangeValue: (value) {
                        setState(() {
                          Exploracion.ramsay = value;
                        });
                      },
                      items: Escalas.ramsay,
                      initialValue: Exploracion.ramsay,
                    ),
                    //
                    CrossLine(),
                    Spinner(
                      width: isDesktop(context)
                          ? 200
                          : isTablet(context)
                              ? 200
                              : isMobile(context)
                                  ? 216
                                  : 300,
                      tittle: 'Riesgo por úlcera',
                      onChangeValue: (value) {
                        setState(() {
                          Exploracion.evaluacionBraden = value;
                        });
                      },
                      items: Escalas.braden,
                      initialValue: Exploracion.evaluacionBraden,
                    ),
                    Spinner(
                      width: isDesktop(context)
                          ? 200
                          : isTablet(context)
                              ? 200
                              : isMobile(context)
                                  ? 216
                                  : 300,
                      tittle: 'Riesgo por Inmovilidad',
                      onChangeValue: (value) {
                        setState(() {
                          Exploracion.evaluacionNorton = value;
                        });
                      },
                      items: Escalas.norton,
                      initialValue: Exploracion.evaluacionNorton,
                    ),
                    //
                    CrossLine(),
                    Spinner(
                      width: isDesktop(context)
                          ? 500
                          : isTablet(context)
                              ? 200
                              : isMobile(context)
                                  ? 216
                                  : 300,
                      tittle: 'Dieta Establecida',
                      onChangeValue: (value) {
                        setState(() {
                          Exploracion.alimentacion = value;
                        });
                      },
                      items: Items.dieta,
                      initialValue: Exploracion.alimentacion,
                    ),
                    Spinner(
                      width: isDesktop(context)
                          ? 170
                          : isTablet(context)
                              ? 200
                              : isMobile(context)
                                  ? 216
                                  : 300,
                      tittle: 'Sonda Oro/Nasogástrica',
                      onChangeValue: (value) {
                        setState(() {
                          Exploracion.tipoSondaAlimentacion = value;
                        });
                      },
                      items: Items.orogastrico,
                      initialValue: Exploracion.tipoSondaAlimentacion,
                    ),
                    CrossLine(),
                  ],
                ),
              )),
          const Expanded(flex: 2, child: RevisionDispositivos()),
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  const Expanded(child: RevisionPrevios()),
                  // Expanded(
                  //     child: RevisionCultivos(
                  //         listado: Pacientes.getRevisionCultivos())),
                ],
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: [
                    ValuePanel(
                      firstText: "TAM",
                      secondText:
                          Cardiometrias.presionArterialMedia.toStringAsFixed(2),
                      thirdText: "mmHg",
                    ),
                    ValuePanel(
                      firstText: "P. pulso",
                      secondText: Cardiometrias.presionPulso.toString(),
                      thirdText: "mmHg",
                    ),
                    CrossLine(),
                    ValuePanel(
                      firstText: "UKH",
                      secondText: Valores.diuresis.toStringAsFixed(2),
                      thirdText: "mL/Kg/${Valores.horario} Hr",
                    ),
                    ValuePanel(
                      firstText: "TFG (CKD-EPI)",
                      secondText:
                          Renometrias.tasaRenalCKDEPI.toStringAsFixed(2),
                      thirdText: "mL/min/1.72 m2",
                    ),
                    CrossLine(),
                    ValuePanel(
                      firstText: "P.P.",
                      secondText: Antropometrias.pesoCorporalPredicho
                          .toStringAsFixed(2),
                      thirdText: "kG",
                    ),
                    ValuePanel(
                      firstText: "S.C.",
                      secondText: Antropometrias.SC.toStringAsFixed(2),
                      thirdText: "m2",
                    ),
                    CrossLine(),
                    ValuePanel(
                      firstText: "SaFi",
                      secondText: Gasometricos.SAFI.toStringAsFixed(2),
                      thirdText: "%",
                    ),
                    ValuePanel(
                      firstText: "PaFi",
                      secondText: Gasometricos.PAFI.toStringAsFixed(2),
                      thirdText: "%",
                    ),
                    CrossLine(),
                    // Container(
                    //   margin: const EdgeInsets.all(5.0),
                    //   decoration: ContainerDecoration.roundedDecoration(),
                    //   child: GrandButton(
                    //       labelButton: "Agregar Datos",
                    //       weigth: 2000,
                    //       onPress: () {
                    //         operationMethod(context);
                    //       }),
                    // )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // VISTAS Y SEGMENTOS *******************************************

  _endDrawer(BuildContext context) {
    return Drawer(
        backgroundColor: Theming.cuaternaryColor,
        child: widget.analysis == true //isLargeDesktop(context)
            ? AnalisisLaterales()
            : _optionRevisiones(context));
  }

  _bottomNavigationBar(BuildContext context) => BottomAppBar(
        color: Colors.black,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(
                Icons.system_update_alt,
                color: Colors.white,
              ),
              tooltip: 'Cargando . . . ',
              onPressed: () async {
                Pacientes.loadingActivity(context: context).then((value) {
                  if (value == true) {
                    Terminal.printAlert(
                        message:
                        'Archivo ${Pacientes.localPath} Re-Creado $value');
                    Navigator.of(context).pop();
                  }
                }).onError((error, stackTrace) {
                  Terminal.printAlert(
                      message:
                      "ERROR - toVisual : : $error : : Descripción : $stackTrace");
                  Operadores.alertActivity(
                      message: "ERROR - toVisual : : $error",
                      context: context,
                      tittle: 'Error al Inicial Visual');
                }).whenComplete(() => setState(() {}));
              },
            ),
            IconButton(
                splashColor: Theming.terciaryColor,
                icon: const Icon(Icons.bed, color: Colors.grey),
                tooltip: "Semiologías",
                onPressed: () => setState(() {
                      // widget.actualPage = 18;
                    })),
            //
            const SizedBox(width: 40),
            IconButton(
                splashColor: Theming.terciaryColor,
                icon: const Icon(Icons.line_style_outlined, color: Colors.grey),
                tooltip: "Terapia Intensiva",
                onPressed: () => setState(() {
                      widget.analysis = true;
                      _key.currentState!.openEndDrawer();
                    })),
            CircleIcon(
                radios: 30,
                difRadios: 15,
                iconed: Icons.update,
                tittle: "Actualizar balances y vitales . . . ",
                onChangeValue: () => setState(() => operationMethod(context))),
          ],
        ),
      );

  _appBar(BuildContext context) => AppBar(
        elevation: 80,
        foregroundColor: Colors.grey,
        backgroundColor: Colors.black,
        title: AppBarText(""),
        actions: [
          GrandIcon(
            labelButton: "Menu Lateral . . . ",
            iconData: Icons.menu_open,
            onPress: () =>
              setState(() {
                widget.analysis = false;
                _key.currentState!.openEndDrawer();
              }),
          ),
          const SizedBox(width: 20),
        ],
      );

  _floattingActionButton(BuildContext context) => FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: Theming.cuaternaryColor,
                  border: Border(
                      top: BorderSide(color: Colors.grey),
                      right: BorderSide(color: Colors.grey),
                      left: BorderSide(color: Colors.grey)),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16)),
                ),
                child: Container(),
              );
            }),
        shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(100)),
        child: const Icon(
          Icons.hdr_strong,
          color: Colors.grey,
        ),
      );
  //
  Widget actualVista(BuildContext context, {required int actualView}) {
    return Container(
      child: actualView == 0
          ? AuxiliaresRevisiones.pendientesLaboratorios(context)
          : actualView == 1
              ? AuxiliaresRevisiones.biometrias(context)
              : actualView == 2
                  ? AuxiliaresRevisiones.quimicas(context)
                  : actualView == 3
                      ? AuxiliaresRevisiones.arteriales(context)
                      : actualView == 4
                          ? AuxiliaresRevisiones.hepaticos(context)
                          : actualView == 5
                              ? AuxiliaresRevisiones.arteriales(context)
                              : actualView == 6
                                  ? RevisionCultivos(
                                      listado: Pacientes.getRevisionCultivos())
                                  : actualView == 7
                                      ? RevisionIndicacioness()
                                      : actualView == 8
                                          ? AuxiliaresRevisiones.electrolitos(
                                              context)
                                          // : actualView == 9
                                          //     ? const BalanceHidrico()
                                          //     : actualView == 10
                                          //         ? AuxiliaresRevisiones
                                          //             .ventilaciones(context)
                                          //         : actualView == 11
                                          //             ? Hidricos()
                                          //             : actualView == 12
                                          //                 ? const Metabolicos()
                                          //                 : actualView ==
                                          //                         13
                                          //                     ? const Antropometricos()
                                          //                     : actualView ==
                                          //                             14
                                          //                         ? Cardiovasculares()
                                          //                         : actualView ==
                                          //                                 15
                                          //                             ? const Ventilatorios()
                                          //                             : actualView ==
                                          //                                     16
                                          //                                 ? Gasometricos()
                                          //                                 : actualView == 17
                                          //                                     ? Hidricos()
                                          //                                     : actualView == 18
                                          //                                         ? Hidricos()
                                          //                                         : actualView == 19
                                          //                                             ? Hidricos()
                                          //                                             : actualView == 20
                                          //                                                 ? Hidricos()
                                          //                                                 : actualView == 21
                                          //                                                     ? const Hemoderivados()
                                          : Container(),
    );
  }

  Widget _optionRevisiones(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 12,
          child: actualVista(context, actualView: actualView),
        ),
        Expanded(
          child: Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 8,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GrandIcon(onPress: () => setState(() => actualView = 0)),
              GrandIcon(onPress: () => setState(() => actualView = 1)),
              GrandIcon(onPress: () => setState(() => actualView = 2)),
              GrandIcon(onPress: () => setState(() => actualView = 3)),
              GrandIcon(onPress: () => setState(() => actualView = 4)),
              GrandIcon(onPress: () => setState(() => actualView = 5)),
              GrandIcon(
                  labelButton: "Historial de Cultivos",
                  iconData: Icons.hourglass_bottom,
                  onPress: () => setState(() => actualView = 6)),
              GrandIcon(
                  labelButton: "Revisión de Indicaciones",
                  iconData: Icons.line_style_outlined,
                  onPress: () => setState(() => actualView = 7)),
            ],
          ),
        ),
        Expanded(
          child: Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 8,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GrandIcon(
                  iconData: Icons.list_alt_sharp,
                  labelButton: "Pendientes . . . ",
                  onPress: () => Cambios.toNextPage(
                      context, GestionPendiente(withReturn: false))),
              GrandIcon(
                  iconData: Icons.vertical_split_outlined,
                  labelButton: "Ventilaciones . . . ",
                  onPress: () =>
                      Cambios.toNextPage(context, GestionVentilaciones())),
              GrandIcon(
                  iconData: Icons.lens_blur,
                  labelButton: "Indicaciones . . . ",
                  onPress: () => Cambios.toNextActivity(
                      tittle: "Indicaciones de la Hospitalización",
                      context,
                      chyld: const IndicacionesHospital())),
              // GrandIcon(
              //     iconData: Icons.view_array_outlined,
              //     onPress: () => Cambios.toNextActivity(context, chyld: SituacionesHospitalizacion())),
              const SizedBox(width: 30),
              GrandIcon(
                  iconData: Icons.list_alt_sharp,
                  labelButton: "Laboratorios Previos . . . ",
                  onPress: () => Cambios.toNextActivity(
                      backgroundColor: Theming.cuaternaryColor,
                      context,
                      chyld: HistorialParaclinicos())),
              GrandIcon(onPress: () => null),
              GrandIcon(onPress: () => null),
              GrandIcon(onPress: () => null),
            ],
          ),
        ),
      ],
    );
  }
}
