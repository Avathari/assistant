import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/DialogSelector.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/WidgetsModels.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// # Clase .dart para la creación predeterminada de interfaces de registro, consulta y actualización.
// Contiene un botón que enn _OperacionesCirugiasState.build que desplega una ventana emergente,
// de la cual es posible elegir desde un catálogo de opciones.
// # # INSTRUCCIONES DE USO
// # # # Reemplazar .Cirugias por el valor
// # # # Reemplazar Alergicos. por la clase que contiene el mapa .alergias con las claves
// # # # # consultIdQuery
// # # # # registerQuery
// # # # # updateQuery
// # # # Reemplazar .alergias por el nombre del Map() correspondiente.
//
class OperacionesCirugias extends StatefulWidget {
  String? operationActivity;

  String _operationButton = 'Nulo';

  OperacionesCirugias({Key? key, this.operationActivity = Constantes.Nulo})
      : super(key: key);

  @override
  State<OperacionesCirugias> createState() => _OperacionesCirugiasState();
}

class _OperacionesCirugiasState extends State<OperacionesCirugias> {
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
          idOperation = Cirugias.Cirugia['ID_Ciru'];
          
            fechaCirugiaTextController.text =
            Cirugias.Cirugia['Feca_PRO_Ciru'];

          cirugiaProspectadaTextController.text =
          Cirugias.Cirugia['Tipo_Cirugia'];
          cirugiaRealizadaTextController.text =
              Cirugias.Cirugia['Cirugia_Realizada'].toString();
          //
          medicoCirujanoTextController.text =
          Cirugias.Cirugia['Medi_Trat'];
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                  controller: ScrollController(),
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

    Pacientes.ProcedimientosQuirurgicos!.clear();
    Actividades.consultarAllById(
        Databases.siteground_database_reghosp,
        Cirugias.cirugias['consultByIdPrimaryQuery'],
        Pacientes.ID_Paciente)
        .then((value) {
      setState(() {
        Pacientes.ProcedimientosQuirurgicos = value;
        Terminal.printSuccess(
            message:
            "Actualizando Repositorio de Patologías del Paciente . . . ${Pacientes.ProcedimientosQuirurgicos}");

        Archivos.createJsonFromMap(Pacientes.ProcedimientosQuirurgicos!,
            filePath: Cirugias.fileAssocieted);
      });
    });
  }

  // Componentes de la Interfaz *******************************
  List<Widget> component(BuildContext context) {
    return [

      EditTextArea(
        keyBoardType: TextInputType.text,
        limitOfChars: 700,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Fecha de la Cirugía',
        textController: fechaCirugiaTextController,
        numOfLines: 1,
        selection: true,
        withShowOption: true,
        onSelected: () async {
          final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2055),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                    data: ThemeData.dark().copyWith(
                        dialogBackgroundColor: Theming.cuaternaryColor),
                    child: child!);
              });
              setState(() {
                fechaCirugiaTextController.text = DateFormat("yyyy/MM/dd").format(picked!);
              });
        },
      ),
      CrossLine(
          height: 5
      ),
      EditTextArea(
          keyBoardType: TextInputType.text,
          inputFormat: MaskTextInputFormatter(),
          numOfLines: 3,
          labelEditText: 'Cirugía Prospectada',
          textController: cirugiaProspectadaTextController,
          selection: true,
          withShowOption: true,
          iconData: Icons.line_style,
          onSelected: () =>
            Operadores.openDialog(
                context: context,
                chyldrim: DialogSelector(
                  tittle: 'Elemento quirúrgico',
                  searchCriteria: 'Buscar por',
                  typeOfDocument: 'txt',
                  pathForFileSource: 'assets/diccionarios/Cirugias.txt',
                  onSelected: ((value) {
                    setState(() {
                      Quirurgicos.selectedDiagnosis = value;
                      cirugiaProspectadaTextController.text = Quirurgicos.selectedDiagnosis;
                    });
                  }),
                ))
          ),
      EditTextArea(
          keyBoardType: TextInputType.text,
          inputFormat: MaskTextInputFormatter(),
          numOfLines: 3,
          labelEditText: 'Cirugía Realizada',
          textController: cirugiaRealizadaTextController,
          selection: true,
          withShowOption: true,
          iconData: Icons.line_style,
          onSelected: () =>
            Operadores.openDialog(
                context: context,
                chyldrim: DialogSelector(
                  tittle: 'Elemento quirúrgico',
                  searchCriteria: 'Buscar por',
                  typeOfDocument: 'txt',
                  pathForFileSource: 'assets/diccionarios/Cirugias.txt',
                  onSelected: ((value) {
                    setState(() {
                      cirugiaRealizadaTextController.text = Quirurgicos.selectedDiagnosis = value;
                    });
                  }),
                ))
          ),
      CrossLine(
        height: 5
      ),
      EditTextArea(
        keyBoardType: TextInputType.text,
        limitOfChars: 1000,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Medico Cirujano',
        textController: medicoCirujanoTextController,
        numOfLines: 3,
      ),
      CrossLine(),
    ];
  }

  // Operación del Método ***********************************
  void operationMethod(BuildContext context) {
    try {
      listOfValues = [
        idOperation,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        fechaCirugiaTextController.text,
        cirugiaProspectadaTextController.text,
        cirugiaRealizadaTextController.text,
        medicoCirujanoTextController.text,
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
          Actividades.registrar(Databases.siteground_database_reghosp,
              registerQuery!, listOfValues!.removeLast());
          break;
        case Constantes.Consult:
          break;
        case Constantes.Register:
        // ******************************************** *** *
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(Databases.siteground_database_reghosp,
              registerQuery!, listOfValues!)
              .then((value) {
            Archivos.deleteFile(filePath: Cirugias.fileAssocieted);
            reiniciar().then((value) => Operadores.alertActivity(
                context: context,
                tittle: "Anexión de registros",
                message: "Registros Agregados",
                onAcept: () {
                  onClose(context);
                }));
            // ******************************************** *** *
            // Pacientes.ProcedimientosQuirurgicos = value;
            // Constantes.reinit(value: value);
            // ******************************************** *** *
          });
          break;
        case Constantes.Update:
          Actividades.actualizar(Databases.siteground_database_reghosp,
              updateQuery!, listOfValues!, idOperation)
              .then((value) {
            Archivos.deleteFile(filePath: Cirugias.fileAssocieted);
            reiniciar().then((value) => Operadores.alertActivity(
                context: context,
                tittle: "Actualización de registros",
                message: "Registros Actualizados",
                onAcept: () {
                  onClose(context);
                }));
            // // ******************************************** *** *
            // Pacientes.ProcedimientosQuirurgicos = value;
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
                builder: (context) => GestionCirugias()));
        break;
      case false:
        Navigator.push(
            context,
            MaterialPageRoute(
              // maintainState: false,
                builder: (context) => GestionCirugias()));
        break;
      default:
    }
  }

  // VARIABLES DE LA INTERFAZ ******** ******* * * *  *
  String appBarTitile = "Gestión de Cirugias";
  String? consultIdQuery = Cirugias.cirugias['consultIdQuery'];
  String? registerQuery = Cirugias.cirugias['registerQuery'];
  String? updateQuery = Cirugias.cirugias['updateQuery'];

  int idOperation = 0;

  List<dynamic>? listOfValues;
  
  var fechaCirugiaTextController = TextEditingController();
  var cirugiaProspectadaTextController = TextEditingController();
  var cirugiaRealizadaTextController = TextEditingController();
  //
  var medicoCirujanoTextController = TextEditingController();

}

class GestionCirugias extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Pace_APP_ALE";
  // ****************** *** ****** **************

  GestionCirugias({Key? key, this.actualSidePage}) : super(key: key);

  @override
  State<GestionCirugias> createState() => _GestionCirugiasState();
}

class _GestionCirugiasState extends State<GestionCirugias> {
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => VisualPacientes(actualPage: 0)));
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
        " . . . Iniciando Actividad - Repositorio Cirugias del Pacientes");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        foundedItems = value;
        Pacientes.ProcedimientosQuirurgicos = value;
        Terminal.printSuccess(
            message: 'Repositorio Cirugias del Pacientes Obtenido');
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
    Actividades.consultarAllById(
      databaseQuery,
      consultQuery,
      Pacientes.ID_Paciente,
    ).then((value) {
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
        Cirugias.fromJson(snapshot.data[posicion]);
/*        Operadores.openDialog(
            context: context, chyldrim: const AnalisisCirugias());*/
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
                    snapshot.data[posicion]["Tipo_Cirugia"].toString(),
                    style: Styles.textSyle,
                  ),
                  Text(
                    snapshot.data[posicion]["Cirugia_Realizada"].toString(),
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
                        onPressed: () =>onSelected(
                              snapshot, posicion, context, Constantes.Update)

                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        color: Colors.grey,
                        icon: const Icon(Icons.delete),
                        onPressed: () =>
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
                                  },
                                );
                              })

                      )
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
    Cirugias.Cirugia = snapshot.data[posicion];
    // ProcedimientosQuirurgicos.selectedDiagnosis = ProcedimientosQuirurgicos.balance['Pace_APP_ALE'];
    Pacientes.ProcedimientosQuirurgicos = snapshot.data;
    //
    Cirugias.fromJson(snapshot.data[posicion]);
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
          builder: (BuildContext context) => OperacionesCirugias(
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
            pageBuilder: (a, b, c) => GestionCirugias(
              actualSidePage: Padding(
                padding: const EdgeInsets.all(8.0),
                child: OperacionesCirugias(
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
  String appTittle = "Gestion del Cirugias";
  String searchCriteria = "Buscar por Fecha";
  String idKey = 'ID_Bala';

  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  // Variables de Conexión ******************************************
  String databaseQuery = Databases.siteground_database_reghosp;
  // ************************************************************
  String consultQuery = Cirugias.cirugias['consultIdQuery'];
  String deleteQuery = Cirugias.cirugias['deleteQuery'];
  String consultAllQuery = Cirugias.cirugias['consultByIdPrimaryQuery'];
  // Archivo Asociado **********************************************
  var fileAssocieted = Cirugias.fileAssocieted;
}

