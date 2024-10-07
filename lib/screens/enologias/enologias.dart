import 'dart:convert';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Enologias.dart';
import 'package:assistant/screens/home.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/WidgetsModels.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// class Enologias extends StatefulWidget {
//   const Enologias({super.key});
//
//   @override
//   State<Enologias> createState() => _EnologiasState();
// }
//
// class _EnologiasState extends State<Enologias> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

//
class OperacionesEnologias extends StatefulWidget {
  String? operationActivity;

  String _operationButton = 'Nulo';

  OperacionesEnologias({super.key, this.operationActivity = Constantes.Nulo});

  @override
  State<OperacionesEnologias> createState() => _OperacionesEnologiasState();
}

class _OperacionesEnologiasState extends State<OperacionesEnologias> {
  var _progress;

  @override
  void initState() {
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
          idOperation = Enologias.Enologia['ID_Ciru'];

          nombreVinoTextController.text = Enologias.Enologia['Feca_PRO_Ciru'];

          bodegaTextController.text = Enologias.Enologia['Tipo_Enologia'];
          volumenTextController.text =
              Enologias.Enologia['Enologia_Realizada'].toString();
          //
          zonaCrianzaTextController.text = Enologias.Enologia['Medi_Trat'];
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
              ))
          : null,
      body: Container(
          decoration: ContainerDecoration.roundedDecoration(),
          child: CarouselSlider(
              items: [
                _firstView(context),
                _secondView(context),
                _thirdView(context),
                _fourthView(context),
              ],
              carouselController: CarouselSliderController(),
              options: CarouselOptions(
                  height: isMobile(context) ? 600 : 500,
                  enableInfiniteScroll: false,
                  viewportFraction: 1.0))),
    );
  }


  Future<void> reiniciar() async {
    Terminal.printExpected(message: "Reinicio de los valores . . .");

    Actividades.consultarAllById(
            Databases.siteground_database_regenolo,
            Enologias.enologias['consultByIdPrimaryQuery'],
            Enologias.ID_Enologias)
        .then((value) {
      setState(() {
        Enologias.Enologicos = value;
        Terminal.printSuccess(
            message:
                "Actualizando Repositorio de Patologías del Paciente . . . ");

        Archivos.createJsonFromMap(Enologias.Enologicos,
            filePath: Enologias.fileAssocieted);
      });
    });
  }

  // Componentes de la Interfaz *******************************
  Container _firstView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 27, 32, 30),
                  radius: 150,
                  child: stringImage != ""
                      ? ClipOval(
                          child: Image.memory(
                          base64Decode(stringImage!),
                          width: 250,
                          height: 250,
                          fit: BoxFit.cover,
                        ))
                      : const ClipOval(child: Icon(Icons.person)),
                ),
                // PhotoView(
                //   backgroundDecoration: BoxDecoration(
                //     color: Colors.black,
                //     borderRadius: BorderRadius.circular(20.0),
                //     border: Border.all(
                //       color: Colors.grey,
                //       style: BorderStyle.solid,
                //       width: 1.0,
                //     ),
                //   ),
                //   imageProvider: MemoryImage(base64Decode(stringImage!)),
                //   loadingBuilder: (context, progress) => Center(
                //     child: SizedBox(
                //       width: 20.0,
                //       height: 20.0,
                //       child: CircularProgressIndicator(
                //         value: _progress == null
                //             ? null
                //             : _progress.cumulativeBytesLoaded /
                //             _progress.expectedTotalBytes,
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CircleIcon(
                            iconed: Icons.file_copy_rounded,
                            tittle: 'Cargar desde Dispositivo',
                            onChangeValue: () async {
                              var bytes =
                                  await Directorios.choiseFromDirectory();
                              setState(() {
                                stringImage = base64Encode(bytes);
                              });
                            }),
                      ),
                      Expanded(
                        child: GrandIcon(
                            iconColor: Colors.grey,
                            iconData: Icons.new_releases_outlined,
                            labelButton: 'Recargar . . . ',
                            onPress: () => setState(
                                () => stringImage = Enologias.imagenEnologia)),
                      ),
                      Expanded(
                        child: CircleIcon(
                            iconed: Icons.camera_alt_outlined,
                            tittle: 'Cargar desde Cámara',
                            onChangeValue: () async {
                              var bytes = await Directorios.choiseFromCamara();
                              setState(() {
                                stringImage = base64Encode(bytes);
                              });
                            }),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  EditTextArea(
                    keyBoardType: TextInputType.text,
                    limitOfChars: 700,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Nombre del Vino',
                    textController: nombreVinoTextController,
                    numOfLines: 1,
                  ),
                  EditTextArea(
                    keyBoardType: TextInputType.text,
                    inputFormat: MaskTextInputFormatter(),
                    numOfLines: 1,
                    labelEditText: 'Bodega',
                    textController: bodegaTextController,
                  ),
                  EditTextArea(
                    keyBoardType: TextInputType.text,
                    inputFormat: MaskTextInputFormatter(),
                    numOfLines: 1,
                    labelEditText: 'Volumen',
                    textController: volumenTextController,
                  ),
                  EditTextArea(
                    keyBoardType: TextInputType.text,
                    limitOfChars: 1000,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Zona de Crianza',
                    textController: zonaCrianzaTextController,
                    numOfLines: 3,
                  ),
                  CrossLine(),
                  GrandButton(
                      weigth: 2000,
                      labelButton: widget._operationButton,
                      onPress: () => operationMethod(context), ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _secondView(BuildContext context) {
    return Container(
child: Column(
  children: [
    Spinner(
        tittle: "Intensidad",
        initialValue: "hemotipoValue,",
        items: const ["hemotipoValue,"],
        width: isMobile(context)
            ? 216
            : isTablet(context)
            ? 140
            : 180,
        onChangeValue: (String? newValue) {
          setState(() {
            // hemotipoValue = newValue!;
          });
        }),
    Spinner(
        tittle: "Color",
        initialValue: "hemotipoValue,",
        items: const ["hemotipoValue,"],
        width: isMobile(context)
            ? 216
            : isTablet(context)
            ? 140
            : 180,
        onChangeValue: (String? newValue) {
          setState(() {
            // hemotipoValue = newValue!;
          });
        }),
    Spinner(
        tittle: "Tonalidad",
        initialValue: "hemotipoValue,",
        items: const ["hemotipoValue,"],
        width: isMobile(context)
            ? 216
            : isTablet(context)
            ? 140
            : 180,
        onChangeValue: (String? newValue) {
          setState(() {
            // hemotipoValue = newValue!;
          });
        }),
    Spinner(
        tittle: "Variación",
        initialValue: "hemotipoValue,",
        items: const ["hemotipoValue,"],
        width: isMobile(context)
            ? 216
            : isTablet(context)
            ? 140
            : 180,
        onChangeValue: (String? newValue) {
          setState(() {
            // hemotipoValue = newValue!;
          });
        }),
    Spinner(
        tittle: "Evolución",
        initialValue: "hemotipoValue,",
        items: const ["hemotipoValue,"],
        width: isMobile(context)
            ? 216
            : isTablet(context)
            ? 140
            : 180,
        onChangeValue: (String? newValue) {
          setState(() {
            // hemotipoValue = newValue!;
          });
        }),
    Spinner(
        tittle: "Aspecto",
        initialValue: "hemotipoValue,",
        items: const ["hemotipoValue,"],
        width: isMobile(context)
            ? 216
            : isTablet(context)
            ? 140
            : 180,
        onChangeValue: (String? newValue) {
          setState(() {
            // hemotipoValue = newValue!;
          });
        }),
  ],
),
    );
  }

  Container _thirdView(BuildContext context) {
    return Container(

    );
  }

  Container _fourthView(BuildContext context) {
    return Container(

    );
  }

  // Operación del Método ***********************************
  void operationMethod(BuildContext context) {
    try {
      listOfValues = [
        idOperation,
        Enologias.ID_Enologias,
        Enologias.ID_Enologias,
        nombreVinoTextController.text,
        bodegaTextController.text,
        volumenTextController.text,
        zonaCrianzaTextController.text,
        "",
        stringImage, // foto
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
          Actividades.registrar(Databases.siteground_database_regenolo,
              registerQuery!, listOfValues!.removeLast());
          break;
        case Constantes.Consult:
          break;
        case Constantes.Register:
          // ******************************************** *** *
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(Databases.siteground_database_regenolo,
                  registerQuery!, listOfValues!)
              .then((value) {
            Archivos.deleteFile(filePath: Enologias.fileAssocieted);
            reiniciar().then((value) => Operadores.alertActivity(
                context: context,
                tittle: "Anexión de registros",
                message: "Registros Agregados",
                onAcept: () {
                  onClose(context);
                }));
            // ******************************************** *** *
            // Enologias.ProcedimientosQuirurgicos = value;
            // Constantes.reinit(value: value);
            // ******************************************** *** *
          });
          break;
        case Constantes.Update:
          Actividades.actualizar(Databases.siteground_database_regenolo,
                  updateQuery!, listOfValues!, idOperation)
              .then((value) {
            Archivos.deleteFile(filePath: Enologias.fileAssocieted);
            reiniciar().then((value) => Operadores.alertActivity(
                context: context,
                tittle: "Actualización de registros",
                message: "Registros Actualizados",
                onAcept: () {
                  onClose(context);
                }));
            // // ******************************************** *** *
            // Enologias.ProcedimientosQuirurgicos = value;
            // Constantes.reinit(value: value);
            // ******************************************** *** *
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

  // Operación Final ******** *******************************
  void onClose(BuildContext context) {
    switch (isMobile(context)) {
      case true:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionEnologias()));
        break;
      case false:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionEnologias()));
        break;
      default:
    }
  }

  // VARIABLES DE LA INTERFAZ ******** ******* * * *  *
  String appBarTitile = "Gestión de Enologias";
  String? consultIdQuery = Enologias.enologias['consultIdQuery'];
  String? registerQuery = Enologias.enologias['registerQuery'];
  String? updateQuery = Enologias.enologias['updateQuery'];

  int idOperation = 0;

  List<dynamic>? listOfValues;

  var nombreVinoTextController = TextEditingController();
  var bodegaTextController = TextEditingController();
  var volumenTextController = TextEditingController();
  var zonaCrianzaTextController = TextEditingController();
  //
  String? stringImage = '';
}

class GestionEnologias extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Pace_APP_ALE";
  // ****************** *** ****** **************

  GestionEnologias({super.key, this.actualSidePage});

  @override
  State<GestionEnologias> createState() => _GestionEnologiasState();
}

class _GestionEnologiasState extends State<GestionEnologias> {
  @override
  void initState() {
    iniciar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Theming.primaryColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            tooltip: Sentences.regresar,
            onPressed: () {
              Constantes.reinit();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Home()));
            },
          ),
          title: AppBarText(appTittle),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.replay_outlined,
              ),
              tooltip: Sentences.reload,
              onPressed: () {
                reiniciar(); // _pullListRefresh();
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
                    child: EditTextArea(
                      labelEditText: searchCriteria,
                      textController: searchTextController,
                      inputFormat: MaskTextInputFormatter(),
                      keyBoardType: TextInputType.text,
                      withShowOption: true,
                      onChange: (value) {
                        _runFilterSearch(value);
                      },
                    )),
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
                          ? GridView.builder(
                              controller: ScrollController(),
                              padding: const EdgeInsets.all(4.0),
                              gridDelegate: GridViewTools.gridDelegate(
                                  crossAxisCount: isMobile(context) ? 1 : 2,
                                  mainAxisExtent:
                                      isMobile(context) ? 150 : 160),
                              shrinkWrap: false,
                              itemCount: snapshot.data == null
                                  ? 0
                                  : snapshot.data.length,
                              itemBuilder: (context, posicion) {
                                return itemListView(
                                    context: context,
                                    snapshot: snapshot,
                                    posicion: posicion);
                              })
                          : Container();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        isDesktop(context)
            ? widget.actualSidePage != null
                ? Expanded(
                    flex: 1,
                    child: Container(
                        decoration: ContainerDecoration.roundedDecoration(),
                        child: widget.actualSidePage!))
                : Expanded(flex: 1, child: Container())
            : Container()
      ]),
    );
  }

  // Funciones de Inicio  *****************************************
  void iniciar() {
    Terminal.printWarning(
        message:
            " . . . Iniciando Actividad - Repositorio Enologias del Enologias");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        foundedItems = value;
        Enologias.Enologicos = value;
        Terminal.printSuccess(
            message: 'Repositorio Enologias del Enologias Obtenido');
      });
    }).onError((error, stackTrace) {
      Terminal.printAlert(
          message:
              'ERROR : No se abrio repositorio local - $error : : $stackTrace');
      reiniciar();
    });
    Terminal.printOther(message: " . . . Actividad Iniciada");
  }

  Future<void> reiniciar() async {
    Terminal.printExpected(message: "Reinicio de los valores . . .");
    Actividades.consultar(
      databaseQuery,
      consultQuery,
    ).then((value) {
      Terminal.printOther(message: " . . . : : $value");
      //
      setState(() {
        foundedItems = value;
        Archivos.createJsonFromMap(foundedItems!, filePath: fileAssocieted);
      });
    }).onError((error, stackTrace) {
      Terminal.printAlert(
          message:
              'ERROR : No se realizó conexión con base de datos - $error : : $stackTrace');
      Operadores.alertActivity(
          context: context,
          tittle: "Error al Consultar Información",
          message: 'ERROR :  $error : : $stackTrace',
          onAcept: () {
            Navigator.of(context).pop();
          });
    });
  }

  // Funciones de Listado *****************************************
  GestureDetector itemListView(
      {required AsyncSnapshot snapshot,
      required int posicion,
      required BuildContext context}) {
    // print("posicion ${snapshot.data}");
    return GestureDetector(
      onTap: () {
        Enologias.fromJson(snapshot.data[posicion]);
/*        Operadores.openDialog(
            context: context, chyldrim: const AnalisisEnologias());*/
      },
      onDoubleTap: () {
        onSelected(snapshot, posicion, context, Constantes.Update);
      },
      child: Container(
        padding:
            const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 2.0, left: 2.0),
        margin:
            const EdgeInsets.only(top: 2.5, bottom: 2.5, right: 2.0, left: 2.0),
        decoration: ContainerDecoration.roundedDecoration(),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.all(5.0),
                decoration: ContainerDecoration.roundedDecoration(),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Text(
                    snapshot.data[posicion]["ID_Ciru"].toString(),
                    style: Styles.textSyle,
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: CrossLine(
                  isHorizontal: false,
                  thickness: 3,
                )),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    snapshot.data[posicion]["Tipo_Enologia"].toString(),
                    style: Styles.textSyle,
                  ),
                  Text(
                    snapshot.data[posicion]["Enologia_Realizada"].toString(),
                    style: Styles.textSyle,
                  ),
                  CrossLine(
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          color: Colors.grey,
                          icon: const Icon(Icons.update_rounded),
                          onPressed: () => onSelected(
                              snapshot, posicion, context, Constantes.Update)),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                          color: Colors.grey,
                          icon: const Icon(Icons.delete),
                          onPressed: () => showDialog(
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
                                  },
                                );
                              }))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSelected(AsyncSnapshot<dynamic> snapshot, int posicion,
      BuildContext context, String operaciones) {
    Enologias.Enologia = snapshot.data[posicion];
    // ProcedimientosQuirurgicos.selectedDiagnosis = ProcedimientosQuirurgicos.balance['Pace_APP_ALE'];
    Enologias.Enologicos = snapshot.data;
    //
    Enologias.fromJson(snapshot.data[posicion]);
    // ************** ********** ************
    toOperaciones(context, operaciones);
  }

  void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  // Funciones de Operación ****************************************
  void deleteRegister(
      AsyncSnapshot<dynamic> snapshot, int posicion, BuildContext context) {
    try {
      Actividades.eliminar(
          databaseQuery, deleteQuery, snapshot.data[posicion][idKey]);
      setState(() {
        snapshot.data.removeAt(posicion);
      });
    } finally {
      Navigator.of(context).pop();
    }
  }

  void toOperaciones(BuildContext context, String operationActivity) {
    init();
    // *********** ************* ********
    if (isDesktop(context)) {
      Constantes.operationsActividad = operationActivity;
      Constantes.reinit(value: foundedItems!);
      _pullListRefresh();
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => OperacionesEnologias(
                operationActivity: operationActivity,
              )));
    }
  }

  // Funciones de Búsqueda *****************************************
  void _runFilterSearch(String enteredKeyword) {
    List? results = [];

    if (enteredKeyword.isEmpty) {
      _pullListRefresh();
    } else {
      Actividades.consultar(databaseQuery, consultAllQuery).then((value) {
        results = value
            .where((user) => user[widget.keySearch].contains(enteredKeyword))
            .toList();

        setState(() {
          foundedItems = results;
        });
      });
    }
  }

  Future<Null> _pullListRefresh() async {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (a, b, c) => GestionEnologias(
                  actualSidePage: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OperacionesEnologias(
                      operationActivity: Constantes.operationsActividad,
                    ),
                  ),
                ),
            transitionDuration: const Duration(seconds: 0)));
  }

  // Reinicio de Valores de Operación **********************************
  init() {
// Reinicio de Valores para la Operación *******************************
  }

  // VARIABLES *************************************************
  String appTittle = "Gestion del Enologias";
  String searchCriteria = "Buscar por Fecha";
  String idKey = 'ID_Bala';

  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  // Variables de Conexión ******************************************
  String databaseQuery = Databases.siteground_database_regenolo;
  // ************************************************************
  String consultQuery = Enologias.enologias['consultQuery'];
  String deleteQuery = Enologias.enologias['deleteQuery'];
  String consultAllQuery = Enologias.enologias['consultByIdPrimaryQuery'];
  // Archivo Asociado **********************************************
  var fileAssocieted = Enologias.fileAssocieted;
}
