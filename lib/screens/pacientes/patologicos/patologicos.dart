import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/screens/pacientes/patologicos/auxiliares/antecedentes.dart';
import 'package:assistant/screens/pacientes/reportes/reportes.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CircleSwitched.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/DialogSelector.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/WidgetsModels.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../conexiones/conexiones.dart';

class OperacionesPatologicos extends StatefulWidget {
  String? operationActivity;
  String _operationButton = 'Nulo';
  late bool? actualized, withReturnOption;

  OperacionesPatologicos({
    super.key,
    this.operationActivity = Constantes.Nulo,
    this.actualized = false,
    this.withReturnOption = false,
  });

  @override
  State<OperacionesPatologicos> createState() => _OperacionesPatologicosState();
}

class _OperacionesPatologicosState extends State<OperacionesPatologicos> {
  @override
  void initState() {
    Terminal.printExpected(
        message:
            "OperacionesPatologicos : : : widget.withReturnOption! : : ${widget.withReturnOption!}");
    //
    switch (widget.operationActivity) {
      case Constantes.Nulo:
        break;
      case Constantes.Consult:
        break;
      case Constantes.Register:
        widget._operationButton = 'Registrar';

        break;
      case Constantes.Update:
        setState(() {
          widget._operationButton = 'Actualizar';
          idOperation = Patologicos.Degenerativos['ID_PACE_APP_DEG'];

          isActualDiagoValue = Dicotomicos.fromInt(
                  Patologicos.Degenerativos['Pace_APP_DEG_SINO'])
              .toString();
          if (Patologicos.selectedDiagnosis == "") {
            cieDiagnoTextController.text =
                Patologicos.Degenerativos['Pace_APP_DEG'];
          } else {
            cieDiagnoTextController.text = Patologicos.selectedDiagnosis;
          }
          comenDiagnoTextController.text =
              Patologicos.Degenerativos['Pace_APP_DEG_com'];
          ayoDiagoTextController.text =
              Patologicos.Degenerativos['Pace_APP_DEG_dia'].toString();
          //
          isTratamientoDiagoValue = Dicotomicos.fromInt(
                  Patologicos.Degenerativos['Pace_APP_DEG_tra_SINO'])
              .toString();
          tratamientoTextController.text =
              Patologicos.Degenerativos['Pace_APP_DEG_tra'];
          isSuspendTratoValue = Dicotomicos.fromInt(
                  Patologicos.Degenerativos['Pace_APP_DEG_sus_SINO'])
              .toString();
          suspensionesTextController.text =
              Patologicos.Degenerativos['Pace_APP_DEG_sus'];
        });
        super.initState();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: isMobile(context) || isTablet(context)
          ? AppBar(
              foregroundColor: Colors.white,
              backgroundColor: Theming.primaryColor,
              title: AppBarText(appBarTitile),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
                tooltip: Sentences.regresar,
                onPressed: () {
                  onClose(context);
                },
              ),
              actions: [
                GrandIcon(
                    iconData: Icons.line_weight_sharp,
                    onPress: () {
                      Operadores.editActivity(
                          context: context,
                          keyBoardType: TextInputType.multiline,
                          numOfLines: 15,
                          tittle: "Antecedente Patológico por Prosa . . . ",
                          message: "Prosa del antecedente . . . ",
                          onAcept: (value) {
                            // Terminal.printExpected(message: "$value : ${value.length}");
                            List splitedDiagon = value.split("\n");
                            //
                            if (splitedDiagon.length <=3) {
                              comenDiagnoTextController.text =
                                  splitedDiagon[0].toString();
                              tratamientoTextController.text =
                                  splitedDiagon[1].toString();
                              suspensionesTextController.text =
                                  splitedDiagon[2].toString();
                            }
                            //
                            Navigator.of(context).pop();
                          });
                    }),
                SizedBox(width: 15),
              ],
            )
          : null,
      body: Container(
        decoration: ContainerDecoration.roundedDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                  controller: patologicosScroller,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: component(context),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            GrandButton(
                weigth: 2000,
                labelButton: widget._operationButton,
                onPress: () {
                  operationMethod(context);
                })
          ],
        ),
      ),
    );
  }

  Future<void> reiniciar() async {
    Terminal.printExpected(message: "Reinicio de los valores . . .");

    Pacientes.Patologicos!.clear();
    Actividades.consultarAllById(
            Databases.siteground_database_regpace,
            Patologicos.patologicos['consultByIdPrimaryQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      setState(() {
        Pacientes.Patologicos = value;
        Terminal.printSuccess(
            message:
                "Actualizando Repositorio de Patologías del Paciente . . . ${Pacientes.Patologicos}");

        Archivos.createJsonFromMap(Pacientes.Patologicos!,
            filePath: Patologicos.fileAssocieted);
      });
    });
  }

  List<Widget> component(BuildContext context) {
    return [
      CrossLine(
        height: 20,
        color: Colors.black,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: isMobile(context) ? 2 : 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CircleSwitched(
                  tittle: "¿Diagnóstico actual?",
                  onChangeValue: (value) {
                    setState(() {
                      isActualDiagoValue =
                          Dicotomicos.fromBoolean(value) as String;
                    });
                  },
                  isSwitched: Dicotomicos.fromString(isActualDiagoValue)),
            ),
          ),
          Expanded(
            flex: 5,
            child: EditTextArea(
              keyBoardType: TextInputType.text,
              inputFormat: MaskTextInputFormatter(),
              numOfLines: 3,
              labelEditText: 'Diagnóstico (CIE)',
              textController: cieDiagnoTextController,
              selection: true,
              withShowOption: true,
              iconData: Icons.line_style,
              onSelected: () {
                Operadores.openDialog(
                    context: context,
                    chyldrim: DialogSelector(
                      onSelected: ((value) {
                        setState(() {
                          Diagnosticos.selectedDiagnosis = value;
                          cieDiagnoTextController.text =
                              Diagnosticos.selectedDiagnosis;
                        });
                      }),
                    ));
              },
            ),
          ),
        ],
      ),
      CrossLine(
        height: 10,
        color: Colors.black,
      ),
      EditTextArea(
          keyBoardType: TextInputType.text,
          limitOfChars: 700,
          inputFormat: MaskTextInputFormatter(),
          labelEditText: 'Comentario de diagnóstico',
          textController: comenDiagnoTextController,
          numOfLines: 1,
          selection: true,
          withShowOption: true,
          iconData: Icons.compress_outlined,
          onSelected: () {
            setState(() {
              comenDiagnoTextController.text = cieDiagnoTextController.text;
            });
          }),
      // Row(
      //   children: [
      //     Expanded(
      //       flex: 2,
      //       child: EditTextArea(
      //         keyBoardType: TextInputType.number,
      //         inputFormat: MaskTextInputFormatter(
      //             mask: '##',
      //             filter: {"#": RegExp(r'[0-9]')},
      //             type: MaskAutoCompletionType.lazy),
      //         labelEditText: 'Años de diagnóstico',
      //         textController: ayoDiagoTextController,
      //         numOfLines: 1,
      //       ),
      //     ),
      //     Expanded(
      //       flex: 3,
      //       child: Spinner(
      //           tittle: "¿Tratamiento actual?",
      //           onChangeValue: (String value) {
      //             setState(() {
      //               isTratamientoDiagoValue = value;
      //               if (value == Dicotomicos.dicotomicos()[0]) {
      //                 tratamientoTextController.text = "";
      //               } else {
      //                 tratamientoTextController.text = "Sin tratamiento actual";
      //               }
      //             });
      //           },
      //           items: Dicotomicos.dicotomicos(),
      //           initialValue: isTratamientoDiagoValue),
      //     ),
      //   ],
      // ),
      CrossLine(
        height: 1,
        thickness: 3,
        color: Colors.black,
      ),
      EditTextArea(
        keyBoardType: TextInputType.multiline,
        limitOfChars: 1000,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Comentario del tratamiento',
        textController: tratamientoTextController,
        numOfLines: 10,
      ),
      CrossLine(),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  // CircleIcon(
                  //   tittle: 'Suspensiones . . . ',
                  //   difRadios: 15,
                  //   externalCircleColor: Colors.grey,
                  //   iconed: Icons.surround_sound_outlined,
                  //   onChangeValue: () {
                  //     Operadores.openDialog(
                  //         context: context,
                  //         chyldrim: Container(
                  //             decoration: ContainerDecoration.roundedDecoration(),
                  //             child: const Antecedentes()),
                  //         onAction: () {
                  //           setState(() {
                  //             suspensionesTextController.text = '';
                  //           });
                  //         });
                  //   },
                  // ),
                  // CrossLine(thickness: 2),
                  CircleIcon(
                    tittle: 'Previstos . . . ',
                    radios: 30,
                    difRadios: 20,
                    externalCircleColor: Colors.grey,
                    iconed: Icons.surround_sound_outlined,
                    onChangeValue: () {
                      Operadores.selectOptionsActivity(
                          context: context,
                          options: Items.previstos
                              .map((e) => e['Diagnostico'])
                              .toList(),
                          onClose: (valar) {
                            Terminal.printWarning(message: valar);

                            for (var e in Items.previstos) {
                              //
                              if (e['Diagnostico'] == valar) {
                                comenDiagnoTextController.text =
                                    e['Diagnostico']!;
                                tratamientoTextController.text =
                                    e['Tratamiento']!;
                                suspensionesTextController.text =
                                    e['Antecedentes']!;
                              }
                            }
                            Navigator.of(context).pop();
                          });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: EditTextArea(
                limitOfChars: 1000,
                keyBoardType: TextInputType.multiline,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Antecedentes del Diagnóstico',
                textController: suspensionesTextController,
                numOfLines: 15,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  void operationMethod(BuildContext context) {
    try {
      listOfValues = [
        idOperation,
        Pacientes.ID_Paciente,
        Dicotomicos.toInt(isActualDiagoValue),
        cieDiagnoTextController.text,
        comenDiagnoTextController.text,
        ayoDiagoTextController.text,
        Dicotomicos.toInt(isTratamientoDiagoValue),
        tratamientoTextController.text,
        Dicotomicos.toInt(isSuspendTratoValue),
        suspensionesTextController.text,
        idOperation
      ];
      print(
          "${widget.operationActivity} listOfValues $listOfValues ${listOfValues!.length}");

      switch (widget.operationActivity) {
        case Constantes.Nulo:
          // ******************************************** *** *
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(Databases.siteground_database_regpace,
              registerQuery!, listOfValues!.removeLast());
          break;
        case Constantes.Consult:
          break;
        case Constantes.Register:
          // ******************************************** *** *
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(Databases.siteground_database_regpace,
                  registerQuery!, listOfValues!)
              .then((value) {
            Archivos.deleteFile(filePath: Patologicos.fileAssocieted);
            reiniciar().then((value) => Operadores.alertActivity(
                context: context,
                tittle: "Anexión de registros",
                message: "Registros Agregados",
                onAcept: () => onClose(context)));
          });
          break;
        case Constantes.Update:
          Actividades.actualizar(Databases.siteground_database_regpace,
                  updateQuery!, listOfValues!, idOperation)
              .then((value) {
            Archivos.deleteFile(filePath: Patologicos.fileAssocieted);
            reiniciar().then((value) => Operadores.alertActivity(
                context: context,
                tittle: "Actualización de registros",
                message: "Registros Actualizados",
                onAcept: () => onClose(context)));
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

  void onClose(BuildContext context) {
    Terminal.printExpected(
        message: "widget.withReturnOption! : : ${widget.withReturnOption!}");
    if (widget.withReturnOption!) {
      Navigator.push(
          context,
          MaterialPageRoute(
              // maintainState: false,
              builder: (context) => GestionPatologicos()));
    } else {
      Cambios.toNextPage(context, ReportesMedicos(analysis: 1));
    }
  }

  // VARIABLES DE LA INTERFAZ ******** ******* * * *  *
  String appBarTitile = "Gestión de Antecedentes Patológicos";
  String? consultIdQuery = Patologicos.patologicos['consultI  dQuery'];
  String? registerQuery = Patologicos.patologicos['registerQuery'];
  String? updateQuery = Patologicos.patologicos['updateQuery'];

  int idOperation = 0;

  List<dynamic>? listOfValues;

  var isActualDiagoValue = Patologicos.actualDiagno[0];
  var cieDiagnoTextController = TextEditingController();
  var comenDiagnoTextController = TextEditingController();
  var ayoDiagoTextController = TextEditingController();
  //
  var isTratamientoDiagoValue = Patologicos.actualTratamiento[0];
  var tratamientoTextController = TextEditingController();
  var isSuspendTratoValue = Patologicos.actualSuspendido[0];
  var suspensionesTextController = TextEditingController();

  //
  var patologicosScroller = ScrollController();
}

class GestionPatologicos extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Pace_APP_DEG";
  bool? actualized, withReturnOption;
  // ****************** *** ****** **************

  GestionPatologicos(
      {super.key,
      this.actualSidePage,
      this.actualized = false,
      this.withReturnOption = true});

  @override
  State<GestionPatologicos> createState() => _GestionPatologicosState();
}

class _GestionPatologicosState extends State<GestionPatologicos> {
  var fileAssocieted = Patologicos.fileAssocieted;

  @override
  void initState() {
    if (widget.actualized!) {
      reiniciar();
    } else {
      iniciar();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Theming.primaryColor,
          leading: widget.withReturnOption!
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  tooltip: Sentences.regresar,
                  onPressed: () {
                    Constantes.reinit();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => VisualPacientes(actualPage: 2)));
                  },
                )
              : null,
          title: AppBarText(appTittle),
          actions: <Widget>[
            GrandIcon(
                labelButton: 'Agregar Listado de Patologías . . . ',
                iconData: Icons.line_style,
                onPress: () {
                  Cambios.toNextActivity(context,
                      chyld: const VariasPatologias());
                }),
            CrossLine(
              isHorizontal: false,
              thickness: 3,
            ),
            IconButton(
              icon: const Icon(
                Icons.replay_outlined,
              ),
              tooltip: Sentences.reload,
              onPressed: () {
                reiniciar();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.add_card,
              ),
              tooltip: Sentences.add_vitales,
              onPressed: () {
                toOperaciones(context, Constantes.Register);
              },
            ),
          ]),
      body: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      onChanged: (value) {
                        _runFilterSearch(value);
                      },
                      controller: searchTextController,
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      autocorrect: true,
                      obscureText: false,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        helperStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        labelText: searchCriteria,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        contentPadding: const EdgeInsets.all(20),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        focusColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.replay_outlined,
                            color: Colors.white,
                          ),
                          tooltip: Sentences.reload,
                          onPressed: () {
                            reiniciar(); // _pullListRefresh();
                          },
                        ),
                      )),
                ),
              ),
              Expanded(
                flex: 9,
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
        isDesktop(context) || isLargeDesktop(context)
            ? widget.actualSidePage != null
                ? Expanded(flex: 1, child: widget.actualSidePage!)
                : Expanded(flex: 1, child: Container())
            : Container()
      ]),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    reiniciar().whenComplete(() {
      // foundedItems = [];
      gestionScrollController.dispose();
      searchTextController.dispose();
    });
    super.dispose();
  }

  //

  void iniciar() {
    Terminal.printWarning(
        message:
            " . . . Iniciando Actividad - Repositorio Patologías del Pacientes");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {

      setState(() {
        if (value['Error'] != "No se encontraron datos") {
          foundedItems = value;
        }
        Terminal.printSuccess(
            message: 'Repositorio Patologías del Pacientes Obtenido');
      });
    }).onError((error, stackTrace) {
      reiniciar();
    });
    Terminal.printOther(message: " . . . Actividad Iniciada");
  }

  Future<void> reiniciar() async {
    Terminal.printExpected(message: "Reinicio de los valores . . .");
    Actividades.consultarAllById(
            Databases.siteground_database_regpace,
            Patologicos.patologicos['consultByIdPrimaryQuery'],
            Pacientes.ID_Paciente)
        .then((value) {

      setState(() {
        if (value[0]['Error'] != "No se encontraron datos") {
          foundedItems = value;
        }
        Archivos.createJsonFromMap(foundedItems!, filePath: fileAssocieted);
      });
    });
  }

  //
  Container itemListView(
      AsyncSnapshot snapshot, int posicion, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          onSelected(snapshot, posicion, context, Constantes.Update);
        },
        child: Container(
          decoration: ContainerDecoration.roundedDecoration(),
          padding:
              const EdgeInsets.only(left: 0, right: 10, bottom: 20, top: 20),
          margin: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 40,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 30,
                          child: Text(
                            snapshot.data[posicion]['ID_PACE_APP_DEG']
                                .toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${snapshot.data[posicion]['Pace_APP_DEG']}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 14),
                        ),
                        Text(
                          "${snapshot.data[posicion]['Pace_APP_DEG_com']}",
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                              fontSize: 14),
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
                          //
                          onSelected(
                              snapshot, posicion, context, Constantes.Update);
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
                                    deleteRegister(snapshot, posicion, context);
                                    Navigator.of(context).pop();
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
    );
  }

  void onSelected(AsyncSnapshot<dynamic> snapshot, int posicion,
      BuildContext context, String operaciones) {
    Patologicos.Degenerativos = snapshot.data[posicion];
    Patologicos.selectedDiagnosis = Patologicos.Degenerativos['Pace_APP_DEG'] ?? "";
    Pacientes.Patologicos = snapshot.data;
    //
    toOperaciones(context, operaciones);
  }

  void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void deleteRegister(
      AsyncSnapshot<dynamic> snapshot, int posicion, BuildContext context) {
    Actividades.eliminar(
            Databases.siteground_database_regpace,
            Patologicos.patologicos['deleteQuery'],
            snapshot.data[posicion]['ID_PACE_APP_DEG'])
        .then((value) {
      setState(() {
        snapshot.data.removeAt(posicion);
        Archivos.deleteFile(filePath: fileAssocieted).then((value) {
          Operadores.alertActivity(
              context: context,
              tittle: "Eliminación de Registros",
              message: "Registro eliminado",
              onAcept: () {
                Navigator.of(context).pop();
              });
        });
      });
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR - Hubo un error : $error");
    });
  }

  void toOperaciones(BuildContext context, String operationActivity) {
    if (isMobile(context) || isTablet(context)) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => OperacionesPatologicos(
                operationActivity: operationActivity,
                withReturnOption: widget.withReturnOption!,
              )));
    } else {
      Constantes.operationsActividad = operationActivity;
      Constantes.reinit(value: foundedItems!);
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (a, b, c) => GestionPatologicos(
                    actualSidePage: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OperacionesPatologicos(
                        operationActivity: Constantes.operationsActividad,
                        withReturnOption: widget.withReturnOption!,
                      ),
                    ),
                  ),
              transitionDuration: const Duration(seconds: 0)));
    }
  }

  void _runFilterSearch(String enteredKeyword) {
    List? results = [];

    if (enteredKeyword.isEmpty) {
      _pullListRefresh();
    } else {
      results = Listas.listFromMap(
          lista: foundedItems!,
          keySearched: widget.keySearch,
          elementSearched: enteredKeyword);

      setState(() {
        foundedItems = results;
      });
    }
  }

  Future<Null> _pullListRefresh() async {
    iniciar();
  }

  // VARIABLES DE LA INTERFAZ ********* **** ********* ******
  String appTittle = "Gestion de patologías del paciente";
  String searchCriteria = "Buscar por Fecha";
  String? consultQuery = Patologicos.patologicos['consultIdQuery'];

  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();
}

// **************************************************************
class VariasPatologias extends StatefulWidget {
  const VariasPatologias({super.key});

  @override
  State<VariasPatologias> createState() => _VariasPatologiasState();
}

class _VariasPatologiasState extends State<VariasPatologias> {
  var carouselController = CarouselSliderController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isMobile(context) || isTablet(context)) {
      return mobileView();
    } else {
      return desktopView();
    }
  }

  List<List<dynamic>> listOfValues() {
    return [
      [
        Pacientes.ID_Paciente,
        Dicotomicos.toInt(isActualDiagoAValue),
        cieDiagnoATextController.text,
        comenDiagnoATextController.text,
        ayoDiagoATextController.text,
        Dicotomicos.toInt(isTratamientoDiagoAValue),
        tratamientoATextController.text,
        Dicotomicos.toInt(isSuspendTratoAValue),
        suspensionesATextController.text,
      ],
      [
        Pacientes.ID_Paciente,
        Dicotomicos.toInt(isActualDiagoBValue),
        cieDiagnoBTextController.text,
        comenDiagnoBTextController.text,
        ayoDiagoBTextController.text,
        Dicotomicos.toInt(isTratamientoDiagoBValue),
        tratamientoBTextController.text,
        Dicotomicos.toInt(isSuspendTratoBValue),
        suspensionesBTextController.text,
      ],
      [
        Pacientes.ID_Paciente,
        Dicotomicos.toInt(isActualDiagoCValue),
        cieDiagnoCTextController.text,
        comenDiagnoCTextController.text,
        ayoDiagoCTextController.text,
        Dicotomicos.toInt(isTratamientoDiagoCValue),
        tratamientoCTextController.text,
        Dicotomicos.toInt(isSuspendTratoCValue),
        suspensionesCTextController.text,
      ],
    ];
  }

  // OPERACIONES DE LA INTERFAZ ****************** ********
  void cerrar() {
    Navigator.of(context).pop();
  }

  operationMethod() async {
    Operadores.loadingActivity(
        context: context,
        tittle: "Registrando información . . .",
        message: "Información registrada",
        onCloss: () {
          // Navigator.of(context).pop();
          // cerrar();
        });
    //
    Future.forEach(listOfValues(), (element) async {
      var aux = element as List<dynamic>;

      if (aux[2] != '' && aux[2] != '' && aux[2] != null) {
        await Actividades.registrar(
          Databases.siteground_database_regpace,
          registerQuery!,
          element,
        );
      }
    }).whenComplete(() {
      Navigator.of(context).pop(); // Cierre del LoadActivity
      Operadores.alertActivity(
          context: context,
          tittle: "Registrando información . . .",
          message: "Información registrada",
          onAcept: () {
            // Se emplean 3 Navigator.of(context).pop(); para cerrar cada una de
            //    las ventanas emergentes y la interfaz inicial.

            Navigator.of(context).pop(); // Cierre de la Interfaz Inicial
            Navigator.of(context).pop(); // Cierre del AlertActivity
          });
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR - $error : : : $stackTrace");
      Operadores.alertActivity(
          context: context,
          tittle: "Registrando información . . .",
          message: "$error",
          onAcept: () {
            Cambios.toNextPage(context, GestionPatologicos(actualized: true));
          });
    });
  }

  // VISTAS DE LA INTERFAZ *********************************
  desktopView() {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(children: [
                  CrossLine(
                    height: 20,
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: isMobile(context) ? 2 : 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CircleSwitched(
                              tittle: "¿Diagnóstico actual?",
                              onChangeValue: (value) {
                                setState(() {
                                  isActualDiagoAValue =
                                  Dicotomicos.fromBoolean(value) as String;
                                });
                              },
                              isSwitched: Dicotomicos.fromString(isActualDiagoAValue)),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: EditTextArea(
                          keyBoardType: TextInputType.text,
                          inputFormat: MaskTextInputFormatter(),
                          numOfLines: 3,
                          labelEditText: 'Diagnóstico (CIE)',
                          textController: cieDiagnoATextController,
                          selection: true,
                          withShowOption: true,
                          iconData: Icons.line_style,
                          onSelected: () {
                            Operadores.openDialog(
                                context: context,
                                chyldrim: DialogSelector(
                                  onSelected: ((value) {
                                    setState(() {
                                      Diagnosticos.selectedDiagnosis = value;
                                      cieDiagnoATextController.text =
                                          Diagnosticos.selectedDiagnosis;
                                    });
                                  }),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                  CrossLine(
                    height: 10,
                    color: Colors.black,
                  ),
                  EditTextArea(
                      keyBoardType: TextInputType.text,
                      limitOfChars: 700,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Comentario de diagnóstico',
                      textController: comenDiagnoATextController,
                      numOfLines: 1,
                      selection: true,
                      withShowOption: true,
                      iconData: Icons.compress_outlined,
                      onSelected: () {
                        setState(() {
                          comenDiagnoATextController.text = cieDiagnoATextController.text;
                        });
                      }),
                  CrossLine(
                    height: 5,
                    color: Colors.black,
                  ),
                  EditTextArea(
                    keyBoardType: TextInputType.text,
                    limitOfChars: 1000,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Comentario del tratamiento',
                    textController: tratamientoATextController,
                    numOfLines: 3,
                  ),
                  CrossLine(),
                  Row(
                    children: [
                      Expanded(
                        flex: isMobile(context) ? 2 : 1,
                        child: CircleIcon(
                          tittle: 'Previstos . . . ',
                          radios: 30,
                          difRadios: 20,
                          externalCircleColor: Colors.grey,
                          iconed: Icons.surround_sound_outlined,
                          onChangeValue: () {
                            Operadores.selectOptionsActivity(
                                context: context,
                                options: Items.previstos
                                    .map((e) => e['Diagnostico'])
                                    .toList(),
                                onClose: (valar) {
                                  Terminal.printWarning(message: valar);

                                  for (var e in Items.previstos) {
                                    //
                                    if (e['Diagnostico'] == valar) {
                                      comenDiagnoATextController.text =
                                      e['Diagnostico']!;
                                      tratamientoATextController.text =
                                      e['Tratamiento']!;
                                      suspensionesATextController.text =
                                      e['Antecedentes']!;
                                    }
                                  }
                                  Navigator.of(context).pop();
                                });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: EditTextArea(
                          limitOfChars: 1000,
                          keyBoardType: TextInputType.text,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Antecedentes del Diagnóstico',
                          textController: suspensionesATextController,
                          numOfLines: 6,
                        ),
                      ),
                    ],
                  ),
                  CrossLine(height: 15),
                  GrandIcon(
                      iconData: Icons.line_weight_sharp,
                      onPress: () {
                        Operadores.editActivity(
                            context: context,
                            keyBoardType: TextInputType.multiline,
                            numOfLines: 15,
                            tittle: "Antecedente Patológico por Prosa . . . ",
                            message: "Prosa del antecedente . . . ",
                            onAcept: (value) {
                              List splitedDiagon = value.split("\n");
                              //// Terminal.printExpected(message: "$splitedDiagon : ${splitedDiagon.length}");
                              if (splitedDiagon.length <=3) {
                                comenDiagnoATextController.text =
                                    splitedDiagon[0].toString();
                                tratamientoATextController.text =
                                    splitedDiagon[1].toString();
                                suspensionesATextController.text =
                                    splitedDiagon[2].toString();
                              }
                              //
                              Navigator.of(context).pop();
                            });
                      }),
                ]),
              ),
              Expanded(
                child: Column(children: [
                  CrossLine(
                    height: 20,
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: isMobile(context) ? 2 : 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CircleSwitched(
                              tittle: "¿Diagnóstico actual?",
                              onChangeValue: (value) {
                                setState(() {
                                  isActualDiagoBValue =
                                  Dicotomicos.fromBoolean(value) as String;
                                });
                              },
                              isSwitched: Dicotomicos.fromString(isActualDiagoBValue)),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: EditTextArea(
                          keyBoardType: TextInputType.text,
                          inputFormat: MaskTextInputFormatter(),
                          numOfLines: 3,
                          labelEditText: 'Diagnóstico (CIE)',
                          textController: cieDiagnoBTextController,
                          selection: true,
                          withShowOption: true,
                          iconData: Icons.line_style,
                          onSelected: () {
                            Operadores.openDialog(
                                context: context,
                                chyldrim: DialogSelector(
                                  onSelected: ((value) {
                                    setState(() {
                                      Diagnosticos.selectedDiagnosis = value;
                                      cieDiagnoBTextController.text =
                                          Diagnosticos.selectedDiagnosis;
                                    });
                                  }),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                  CrossLine(
                    height: 10,
                    color: Colors.black,
                  ),
                  EditTextArea(
                      keyBoardType: TextInputType.text,
                      limitOfChars: 700,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Comentario de diagnóstico',
                      textController: comenDiagnoBTextController,
                      numOfLines: 1,
                      selection: true,
                      withShowOption: true,
                      iconData: Icons.compress_outlined,
                      onSelected: () {
                        setState(() {
                          comenDiagnoBTextController.text = cieDiagnoBTextController.text;
                        });
                      }),
                  CrossLine(
                    height: 5,
                    color: Colors.black,
                  ),
                  EditTextArea(
                    keyBoardType: TextInputType.text,
                    limitOfChars: 1000,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Comentario del tratamiento',
                    textController: tratamientoBTextController,
                    numOfLines: 3,
                  ),
                  CrossLine(),
                  Row(
                    children: [
                      Expanded(
                        flex: isMobile(context) ? 2 : 1,
                        child: CircleIcon(
                          tittle: 'Previstos . . . ',
                          radios: 30,
                          difRadios: 20,
                          externalCircleColor: Colors.grey,
                          iconed: Icons.surround_sound_outlined,
                          onChangeValue: () {
                            Operadores.selectOptionsActivity(
                                context: context,
                                options: Items.previstos
                                    .map((e) => e['Diagnostico'])
                                    .toList(),
                                onClose: (valar) {
                                  Terminal.printWarning(message: valar);

                                  for (var e in Items.previstos) {
                                    //
                                    if (e['Diagnostico'] == valar) {
                                      comenDiagnoBTextController.text =
                                      e['Diagnostico']!;
                                      tratamientoBTextController.text =
                                      e['Tratamiento']!;
                                      suspensionesBTextController.text =
                                      e['Antecedentes']!;
                                    }
                                  }
                                  Navigator.of(context).pop();
                                });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: EditTextArea(
                          limitOfChars: 1000,
                          keyBoardType: TextInputType.text,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Antecedentes del Diagnóstico',
                          textController: suspensionesBTextController,
                          numOfLines: 6,
                        ),
                      ),
                    ],
                  ),
                  CrossLine(height: 15),
                  GrandIcon(
                      iconData: Icons.line_weight_sharp,
                      onPress: () {
                        Operadores.editActivity(
                            context: context,
                            keyBoardType: TextInputType.multiline,
                            numOfLines: 15,
                            tittle: "Antecedente Patológico por Prosa . . . ",
                            message: "Prosa del antecedente . . . ",
                            onAcept: (value) {
                              List splitedDiagon = value.split("\n");
                              //// Terminal.printExpected(message: "$splitedDiagon : ${splitedDiagon.length}");
                              if (splitedDiagon.length <=3) {
                                comenDiagnoBTextController.text =
                                    splitedDiagon[0].toString();
                                tratamientoBTextController.text =
                                    splitedDiagon[1].toString();
                                suspensionesBTextController.text =
                                    splitedDiagon[2].toString();
                              }
                              //
                              Navigator.of(context).pop();
                            });
                      }),
                ]),
              ),
              Expanded(
                child: Column(children: [
                  CrossLine(
                    height: 20,
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: isMobile(context) ? 2 : 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CircleSwitched(
                              tittle: "¿Diagnóstico actual?",
                              onChangeValue: (value) {
                                setState(() {
                                  isActualDiagoCValue =
                                  Dicotomicos.fromBoolean(value) as String;
                                });
                              },
                              isSwitched: Dicotomicos.fromString(isActualDiagoCValue)),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: EditTextArea(
                          keyBoardType: TextInputType.text,
                          inputFormat: MaskTextInputFormatter(),
                          numOfLines: 3,
                          labelEditText: 'Diagnóstico (CIE)',
                          textController: cieDiagnoCTextController,
                          selection: true,
                          withShowOption: true,
                          iconData: Icons.line_style,
                          onSelected: () {
                            Operadores.openDialog(
                                context: context,
                                chyldrim: DialogSelector(
                                  onSelected: ((value) {
                                    setState(() {
                                      Diagnosticos.selectedDiagnosis = value;
                                      cieDiagnoCTextController.text =
                                          Diagnosticos.selectedDiagnosis;
                                    });
                                  }),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                  CrossLine(
                    height: 10,
                    color: Colors.black,
                  ),
                  EditTextArea(
                      keyBoardType: TextInputType.text,
                      limitOfChars: 700,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Comentario de diagnóstico',
                      textController: comenDiagnoCTextController,
                      numOfLines: 1,
                      selection: true,
                      withShowOption: true,
                      iconData: Icons.compress_outlined,
                      onSelected: () {
                        setState(() {
                          comenDiagnoCTextController.text = cieDiagnoCTextController.text;
                        });
                      }),
                  CrossLine(
                    height: 5,
                    color: Colors.black,
                  ),
                  EditTextArea(
                    keyBoardType: TextInputType.text,
                    limitOfChars: 1000,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Comentario del tratamiento',
                    textController: tratamientoCTextController,
                    numOfLines: 3,
                  ),
                  CrossLine(),
                  Row(
                    children: [
                      Expanded(
                        flex: isMobile(context) ? 2 : 1,
                        child: CircleIcon(
                          tittle: 'Previstos . . . ',
                          radios: 30,
                          difRadios: 20,
                          externalCircleColor: Colors.grey,
                          iconed: Icons.surround_sound_outlined,
                          onChangeValue: () {
                            Operadores.selectOptionsActivity(
                                context: context,
                                options: Items.previstos
                                    .map((e) => e['Diagnostico'])
                                    .toList(),
                                onClose: (valar) {
                                  Terminal.printWarning(message: valar);

                                  for (var e in Items.previstos) {
                                    //
                                    if (e['Diagnostico'] == valar) {
                                      comenDiagnoCTextController.text =
                                      e['Diagnostico']!;
                                      tratamientoCTextController.text =
                                      e['Tratamiento']!;
                                      suspensionesCTextController.text =
                                      e['Antecedentes']!;
                                    }
                                  }
                                  Navigator.of(context).pop();
                                });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: EditTextArea(
                          limitOfChars: 1000,
                          keyBoardType: TextInputType.text,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Antecedentes del Diagnóstico',
                          textController: suspensionesCTextController,
                          numOfLines: 6,
                        ),
                      ),
                    ],
                  ),
                  CrossLine(height: 15),
                  GrandIcon(
                      iconData: Icons.line_weight_sharp,
                      onPress: () {
                        Operadores.editActivity(
                            context: context,
                            keyBoardType: TextInputType.multiline,
                            numOfLines: 15,
                            tittle: "Antecedente Patológico por Prosa . . . ",
                            message: "Prosa del antecedente . . . ",
                            onAcept: (value) {
                              List splitedDiagon = value.split("\n");
                              //// Terminal.printExpected(message: "$splitedDiagon : ${splitedDiagon.length}");
                              if (splitedDiagon.length <=3) {
                                comenDiagnoCTextController.text =
                                    splitedDiagon[0].toString();
                                tratamientoCTextController.text =
                                    splitedDiagon[1].toString();
                                suspensionesCTextController.text =
                                    splitedDiagon[2].toString();
                              }
                              //
                              Navigator.of(context).pop();
                            });
                      }),
                ]),
              ),
            ],
          ),
          GrandButton(
              labelButton: 'Agregar Listado de Patologías . . . ',
              onPress: () {
                operationMethod();
              })
        ],
      ),
    );
  }

  mobileView() {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          GrandIcon(
            iconData: Icons.skip_previous,
            onPress: () {
              carouselController.jumpToPage(0);
            },
          ),
          GrandIcon(
            iconData: Icons.stop_circle,
            onPress: () {
              carouselController.jumpToPage(1);
            },
          ),
          GrandIcon(
            iconData: Icons.skip_next,
            onPress: () {
              carouselController.jumpToPage(2);
            },
          ),
        ]),
        CrossLine(
          height: 10,
        ),
        Expanded(
          flex: 8,
          child: CarouselSlider(
            carouselController: carouselController,
            options: Carousel.carouselOptions(context: context),
            items: [
              SingleChildScrollView(
                controller: ScrollController(),
                child: Column(children: [
                  CrossLine(
                    height: 20,
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: isMobile(context) ? 2 : 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CircleSwitched(
                              tittle: "¿Diagnóstico actual?",
                              onChangeValue: (value) {
                                setState(() {
                                  isActualDiagoAValue =
                                  Dicotomicos.fromBoolean(value) as String;
                                });
                              },
                              isSwitched: Dicotomicos.fromString(isActualDiagoAValue)),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: EditTextArea(
                          keyBoardType: TextInputType.text,
                          inputFormat: MaskTextInputFormatter(),
                          numOfLines: 3,
                          labelEditText: 'Diagnóstico (CIE)',
                          textController: cieDiagnoATextController,
                          selection: true,
                          withShowOption: true,
                          iconData: Icons.line_style,
                          onSelected: () {
                            Operadores.openDialog(
                                context: context,
                                chyldrim: DialogSelector(
                                  onSelected: ((value) {
                                    setState(() {
                                      Diagnosticos.selectedDiagnosis = value;
                                      cieDiagnoATextController.text =
                                          Diagnosticos.selectedDiagnosis;
                                    });
                                  }),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                  CrossLine(
                    height: 10,
                    color: Colors.black,
                  ),
                  EditTextArea(
                      keyBoardType: TextInputType.text,
                      limitOfChars: 700,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Comentario de diagnóstico',
                      textController: comenDiagnoATextController,
                      numOfLines: 1,
                      selection: true,
                      withShowOption: true,
                      iconData: Icons.compress_outlined,
                      onSelected: () {
                        setState(() {
                          comenDiagnoATextController.text = cieDiagnoATextController.text;
                        });
                      }),
                  CrossLine(
                    height: 5,
                    color: Colors.black,
                  ),
                  EditTextArea(
                    keyBoardType: TextInputType.text,
                    limitOfChars: 1000,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Comentario del tratamiento',
                    textController: tratamientoATextController,
                    numOfLines: 3,
                  ),
                  CrossLine(),
                  Row(
                    children: [
                      Expanded(
                        flex: isMobile(context) ? 2 : 1,
                        child: CircleIcon(
                          tittle: 'Previstos . . . ',
                          radios: 30,
                          difRadios: 20,
                          externalCircleColor: Colors.grey,
                          iconed: Icons.surround_sound_outlined,
                          onChangeValue: () {
                            Operadores.selectOptionsActivity(
                                context: context,
                                options: Items.previstos
                                    .map((e) => e['Diagnostico'])
                                    .toList(),
                                onClose: (valar) {
                                  Terminal.printWarning(message: valar);

                                  for (var e in Items.previstos) {
                                    //
                                    if (e['Diagnostico'] == valar) {
                                      comenDiagnoATextController.text =
                                      e['Diagnostico']!;
                                      tratamientoATextController.text =
                                      e['Tratamiento']!;
                                      suspensionesATextController.text =
                                      e['Antecedentes']!;
                                    }
                                  }
                                  Navigator.of(context).pop();
                                });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: EditTextArea(
                          limitOfChars: 1000,
                          keyBoardType: TextInputType.text,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Antecedentes del Diagnóstico',
                          textController: suspensionesATextController,
                          numOfLines: 6,
                        ),
                      ),
                    ],
                  ),
                  CrossLine(height: 15),
                  GrandIcon(
                      iconData: Icons.line_weight_sharp,
                      onPress: () {
                        Operadores.editActivity(
                            context: context,
                            keyBoardType: TextInputType.multiline,
                            numOfLines: 15,
                            tittle: "Antecedente Patológico por Prosa . . . ",
                            message: "Prosa del antecedente . . . ",
                            onAcept: (value) {
                              List splitedDiagon = value.split("\n");
                              //// Terminal.printExpected(message: "$splitedDiagon : ${splitedDiagon.length}");
                              if (splitedDiagon.length <=3) {
                                comenDiagnoATextController.text =
                                    splitedDiagon[0].toString();
                                tratamientoATextController.text =
                                    splitedDiagon[1].toString();
                                suspensionesATextController.text =
                                    splitedDiagon[2].toString();
                              }
                              //
                              Navigator.of(context).pop();
                            });
                      }),
                ]),
              ),
              SingleChildScrollView(
                controller: ScrollController(),
                child: Column(children: [
                  CrossLine(
                    height: 20,
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: isMobile(context) ? 2 : 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CircleSwitched(
                              tittle: "¿Diagnóstico actual?",
                              onChangeValue: (value) {
                                setState(() {
                                  isActualDiagoBValue =
                                  Dicotomicos.fromBoolean(value) as String;
                                });
                              },
                              isSwitched: Dicotomicos.fromString(isActualDiagoBValue)),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: EditTextArea(
                          keyBoardType: TextInputType.text,
                          inputFormat: MaskTextInputFormatter(),
                          numOfLines: 3,
                          labelEditText: 'Diagnóstico (CIE)',
                          textController: cieDiagnoBTextController,
                          selection: true,
                          withShowOption: true,
                          iconData: Icons.line_style,
                          onSelected: () {
                            Operadores.openDialog(
                                context: context,
                                chyldrim: DialogSelector(
                                  onSelected: ((value) {
                                    setState(() {
                                      Diagnosticos.selectedDiagnosis = value;
                                      cieDiagnoBTextController.text =
                                          Diagnosticos.selectedDiagnosis;
                                    });
                                  }),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                  CrossLine(
                    height: 10,
                    color: Colors.black,
                  ),
                  EditTextArea(
                      keyBoardType: TextInputType.text,
                      limitOfChars: 700,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Comentario de diagnóstico',
                      textController: comenDiagnoBTextController,
                      numOfLines: 1,
                      selection: true,
                      withShowOption: true,
                      iconData: Icons.compress_outlined,
                      onSelected: () {
                        setState(() {
                          comenDiagnoBTextController.text = cieDiagnoBTextController.text;
                        });
                      }),
                  CrossLine(
                    height: 5,
                    color: Colors.black,
                  ),
                  EditTextArea(
                    keyBoardType: TextInputType.text,
                    limitOfChars: 1000,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Comentario del tratamiento',
                    textController: tratamientoBTextController,
                    numOfLines: 3,
                  ),
                  CrossLine(),
                  Row(
                    children: [
                      Expanded(
                        flex: isMobile(context) ? 2 : 1,
                        child: CircleIcon(
                          tittle: 'Previstos . . . ',
                          radios: 30,
                          difRadios: 20,
                          externalCircleColor: Colors.grey,
                          iconed: Icons.surround_sound_outlined,
                          onChangeValue: () {
                            Operadores.selectOptionsActivity(
                                context: context,
                                options: Items.previstos
                                    .map((e) => e['Diagnostico'])
                                    .toList(),
                                onClose: (valar) {
                                  Terminal.printWarning(message: valar);

                                  for (var e in Items.previstos) {
                                    //
                                    if (e['Diagnostico'] == valar) {
                                      comenDiagnoBTextController.text =
                                      e['Diagnostico']!;
                                      tratamientoBTextController.text =
                                      e['Tratamiento']!;
                                      suspensionesBTextController.text =
                                      e['Antecedentes']!;
                                    }
                                  }
                                  Navigator.of(context).pop();
                                });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: EditTextArea(
                          limitOfChars: 1000,
                          keyBoardType: TextInputType.text,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Antecedentes del Diagnóstico',
                          textController: suspensionesBTextController,
                          numOfLines: 6,
                        ),
                      ),
                    ],
                  ),
                  CrossLine(height: 15),
                  GrandIcon(
                      iconData: Icons.line_weight_sharp,
                      onPress: () {
                        Operadores.editActivity(
                            context: context,
                            keyBoardType: TextInputType.multiline,
                            numOfLines: 15,
                            tittle: "Antecedente Patológico por Prosa . . . ",
                            message: "Prosa del antecedente . . . ",
                            onAcept: (value) {
                              List splitedDiagon = value.split("\n");
                              //// Terminal.printExpected(message: "$splitedDiagon : ${splitedDiagon.length}");
                              if (splitedDiagon.length <=3) {
                                comenDiagnoBTextController.text =
                                    splitedDiagon[0].toString();
                                tratamientoBTextController.text =
                                    splitedDiagon[1].toString();
                                suspensionesBTextController.text =
                                    splitedDiagon[2].toString();
                              }
                              //
                              Navigator.of(context).pop();
                            });
                      }),
                ]),
              ),
              SingleChildScrollView(
                controller: ScrollController(),
                child: Column(children: [
                  CrossLine(
                    height: 20,
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: isMobile(context) ? 2 : 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CircleSwitched(
                              tittle: "¿Diagnóstico actual?",
                              onChangeValue: (value) {
                                setState(() {
                                  isActualDiagoCValue =
                                  Dicotomicos.fromBoolean(value) as String;
                                });
                              },
                              isSwitched: Dicotomicos.fromString(isActualDiagoCValue)),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: EditTextArea(
                          keyBoardType: TextInputType.text,
                          inputFormat: MaskTextInputFormatter(),
                          numOfLines: 3,
                          labelEditText: 'Diagnóstico (CIE)',
                          textController: cieDiagnoCTextController,
                          selection: true,
                          withShowOption: true,
                          iconData: Icons.line_style,
                          onSelected: () {
                            Operadores.openDialog(
                                context: context,
                                chyldrim: DialogSelector(
                                  onSelected: ((value) {
                                    setState(() {
                                      Diagnosticos.selectedDiagnosis = value;
                                      cieDiagnoCTextController.text =
                                          Diagnosticos.selectedDiagnosis;
                                    });
                                  }),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                  CrossLine(
                    height: 10,
                    color: Colors.black,
                  ),
                  EditTextArea(
                      keyBoardType: TextInputType.text,
                      limitOfChars: 700,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Comentario de diagnóstico',
                      textController: comenDiagnoCTextController,
                      numOfLines: 1,
                      selection: true,
                      withShowOption: true,
                      iconData: Icons.compress_outlined,
                      onSelected: () {
                        setState(() {
                          comenDiagnoCTextController.text = cieDiagnoCTextController.text;
                        });
                      }),
                  CrossLine(
                    height: 5,
                    color: Colors.black,
                  ),
                  EditTextArea(
                    keyBoardType: TextInputType.text,
                    limitOfChars: 1000,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Comentario del tratamiento',
                    textController: tratamientoCTextController,
                    numOfLines: 3,
                  ),
                  CrossLine(),
                  Row(
                    children: [
                      Expanded(
                        flex: isMobile(context) ? 2 : 1,
                        child: CircleIcon(
                          tittle: 'Previstos . . . ',
                          radios: 30,
                          difRadios: 20,
                          externalCircleColor: Colors.grey,
                          iconed: Icons.surround_sound_outlined,
                          onChangeValue: () {
                            Operadores.selectOptionsActivity(
                                context: context,
                                options: Items.previstos
                                    .map((e) => e['Diagnostico'])
                                    .toList(),
                                onClose: (valar) {
                                  Terminal.printWarning(message: valar);

                                  for (var e in Items.previstos) {
                                    //
                                    if (e['Diagnostico'] == valar) {
                                      comenDiagnoCTextController.text =
                                      e['Diagnostico']!;
                                      tratamientoCTextController.text =
                                      e['Tratamiento']!;
                                      suspensionesCTextController.text =
                                      e['Antecedentes']!;
                                    }
                                  }
                                  Navigator.of(context).pop();
                                });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: EditTextArea(
                          limitOfChars: 1000,
                          keyBoardType: TextInputType.text,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Antecedentes del Diagnóstico',
                          textController: suspensionesCTextController,
                          numOfLines: 6,
                        ),
                      ),
                    ],
                  ),
                  CrossLine(height: 15),
                  GrandIcon(
                      iconData: Icons.line_weight_sharp,
                      onPress: () {
                        Operadores.editActivity(
                            context: context,
                            keyBoardType: TextInputType.multiline,
                            numOfLines: 15,
                            tittle: "Antecedente Patológico por Prosa . . . ",
                            message: "Prosa del antecedente . . . ",
                            onAcept: (value) {
                              List splitedDiagon = value.split("\n");
                              //// Terminal.printExpected(message: "$splitedDiagon : ${splitedDiagon.length}");
                              if (splitedDiagon.length <=3) {
                                comenDiagnoCTextController.text =
                                    splitedDiagon[0].toString();
                                tratamientoCTextController.text =
                                    splitedDiagon[1].toString();
                                suspensionesCTextController.text =
                                    splitedDiagon[2].toString();
                              }
                              //
                              Navigator.of(context).pop();
                            });
                      }),
                ]),
              ),
            ],
          ),
        ),
        GrandButton(
            weigth: 1000,
            labelButton: 'Agregar Listado de Patologías . . . ',
            onPress: () {
              operationMethod();
            })
      ],
    );
  }

  // VARIABLES DE LA INTERFAZ ******** ******* * * *  *
  String appBarTitile = "Gestión de Patologicos";
  String? consultIdQuery = Patologicos.patologicos['consultIdQuery'];
  String? registerQuery = Patologicos.patologicos['registerQuery'];
  String? updateQuery = Patologicos.patologicos['updateQuery'];

  // VARIABLES DE OPERACIÓN  ******** ******* * * *  *
  var cieDiagnoATextController = TextEditingController(),
      comenDiagnoATextController = TextEditingController(),
      ayoDiagoATextController = TextEditingController(),
      tratamientoATextController = TextEditingController(),
      suspensionesATextController = TextEditingController();
  var isActualDiagoAValue = Patologicos.actualDiagno[0],
      isTratamientoDiagoAValue = Patologicos.actualTratamiento[0],
      isSuspendTratoAValue = Patologicos.actualSuspendido[0];
// ******************************************
  var cieDiagnoBTextController = TextEditingController(),
      comenDiagnoBTextController = TextEditingController(),
      ayoDiagoBTextController = TextEditingController(),
      tratamientoBTextController = TextEditingController(),
      suspensionesBTextController = TextEditingController();
  var isActualDiagoBValue = Patologicos.actualDiagno[0],
      isTratamientoDiagoBValue = Patologicos.actualTratamiento[0],
      isSuspendTratoBValue = Patologicos.actualSuspendido[0];
// ******************************************
  var cieDiagnoCTextController = TextEditingController(),
      comenDiagnoCTextController = TextEditingController(),
      ayoDiagoCTextController = TextEditingController(),
      tratamientoCTextController = TextEditingController(),
      suspensionesCTextController = TextEditingController();
  var isActualDiagoCValue = Patologicos.actualDiagno[0],
      isTratamientoDiagoCValue = Patologicos.actualTratamiento[0],
      isSuspendTratoCValue = Patologicos.actualSuspendido[0];
// ******************************************
}
