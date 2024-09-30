import 'dart:convert';
import 'dart:typed_data';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';

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
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/WidgetsModels.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:photo_view/photo_view.dart';

// # Clase .dart para la creación predeterminada de interfaces de registro, consulta y actualización.
// Contiene un botón que enn _OperacionesDocumentacionState.build que desplega una ventana emergente,
// de la cual es posible elegir desde un catálogo de opciones.
// # # INSTRUCCIONES DE USO
// # # # Reemplazar .Documentacion por el valor
// # # # Reemplazar Documentaciones. por la clase que contiene el mapa .pendiente con las claves
// # # # # consultIdQuery
// # # # # registerQuery
// # # # # updateQuery
// # # # Reemplazar .pendiente por el nombre del Map() correspondiente.
//
// ignore: must_be_immutable
class OperacionesDocumentacion extends StatefulWidget {
  String? operationActivity;

  String _operationButton = 'Nulo';
  bool? withAppBar;

  OperacionesDocumentacion(
      {Key? key,
      this.operationActivity = Constantes.Nulo,
      this.withAppBar = true})
      : super(key: key);

  @override
  State<OperacionesDocumentacion> createState() =>
      _OperacionesDocumentacionState();
}

class _OperacionesDocumentacionState extends State<OperacionesDocumentacion> {
  String appBarTitile = "Gestión de Documentaciones";
  String? consultIdQuery = Documentaciones.documentacion['consultIdQuery'];
  String? registerQuery = Documentaciones.documentacion['registerQuery'];
  String? updateQuery = Documentaciones.documentacion['updateQuery'];

  int idOperation = 0; // horaReporte = 0;
  //
  List<dynamic>? listOfValues;

  // VARIABLES OPERTATIVAS ............................... **************************
  var fechaRealizacionTextController = TextEditingController();
  var nombreReporteTextController = TextEditingController();
  //
  String? typeReporte;
  //
  var carouselController = CarouselSliderController();

  //

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

        final f = DateFormat('yyyy-MM-dd');
        fechaRealizacionTextController.text = f.format(DateTime.now());
        break;
      case Constantes.Update:

        setState(() {
          widget._operationButton = 'Actualizar';
          //
          idOperation = Documentaciones.Documentos['ID_Pace_Repo'];
          //
          fechaRealizacionTextController.text =
              Documentaciones.Documentos['FechaReporte'];
          //
          typeReporte = Documentaciones.Documentos['TipoReporte'];
          nombreReporteTextController.text =
              Documentaciones.Documentos['NombreReporte'];

          Terminal.printSuccess(
              message:
                  "Documentacion_FIAT : : ${Documentaciones.Documentos['Reporte_FIAT']}");
          setState(() {
            stringImage = Documentaciones.Documentos['Reporte_FIAT'];
          });

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
      appBar: widget.withAppBar == true
          ? isDesktop(context) || isTabletAndDesktop(context)
              ? null
              : AppBar(
                  backgroundColor: Theming.primaryColor,
                  title: AppBarText(appBarTitile),
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    tooltip: Sentences.regresar,
                    onPressed: () {
                      onClose(context);
                    },
                  ),
                  actions: isMobile(context)
                      ? [
                          CrossLine(isHorizontal: false, thickness: 4),
                          const SizedBox(width: 15),
                          GrandIcon(
                              onPress: () => Operadores.openDialog(
                                  context: context, chyldrim: _licenPhoto())),
                          const SizedBox(width: 15),
                        ]
                      : null,
                )
          : null,
      body: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: ContainerDecoration.roundedDecoration(),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(
                        mask: '####/##/##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    labelEditText: 'Fecha de realización',
                    textController: fechaRealizacionTextController,
                    numOfLines: 1,
                    iconData: Icons.calendar_month,
                    selection: true,
                    withShowOption: true,
                    onSelected: () => fechaRealizacionTextController.text =
                        Calendarios.today(format: "yyyy/MM/dd"),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: ContainerDecoration.roundedDecoration(),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(1.0),
                        controller: ScrollController(),
                        child: Column(
                          children: component(context),
                        ),
                      ),
                    ),

                  ),
                  if(isMobile(context))  Expanded(
                      flex:9, child: _licenPhoto()),
                  CrossLine(thickness: 4),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleIcon(
                          iconed: Icons.mobile_screen_share_rounded,
                          tittle: "Cargar desde Dispositivo",
                          onChangeValue: () async {
                            var bytes = await Directorios.choiseFromDirectory();
                            setState(() {
                              stringImage = base64Encode(bytes);
                            });
                          },
                        ),
                        Expanded(
                          child: GrandButton(
                              labelButton: widget._operationButton,
                              weigth: 2000,
                              onPress: () {
                                operationMethod(context);
                              }),
                        ),
                        CircleIcon(
                          iconed: Icons.camera_alt_outlined,
                          tittle: "Cargar desde Cámara",
                          onChangeValue: () async {
                            var bytes = await Directorios.choiseFromCamara();
                            setState(() {
                              stringImage = base64Encode(bytes);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  CrossLine(thickness: 2),
                  //
                ],
              ),
            ),
            if (isDesktop(context) ||
                isLargeDesktop(context) ||
                isTablet(context))
              Expanded(child: _licenPhoto()),
          ],
        ),
      ),
    );
  }

  List<Widget> component(BuildContext context) {
    return [
      Row(
        children: [
          Expanded(
            child: EditTextArea(
              keyBoardType: TextInputType.text,
              inputFormat: MaskTextInputFormatter(
                  // mask: '####',
                  // filter: {"#": RegExp(r'[0-9]')},
                  // type: MaskAutoCompletionType.lazy
                  ),
              labelEditText: 'Nombre del Documento',
              textController: nombreReporteTextController,
              numOfLines: 1,
            ),
          ),
        ],
      ),
      Spinner(
          width: isDesktop(context)
              ? 200
              : isTabletAndDesktop(context)
                  ? 130
                  : isTablet(context)
                      ? 200
                      : isMobile(context)
                          ? 100
                          : 200,
          tittle: "Tipo de Documentacion",
          onChangeValue: (String value) {
            setState(() {
              typeReporte = value;
            });
          },
          items: Documentaciones.typesDocumentaciones,
          initialValue: typeReporte),
      CrossLine(),
      CrossLine(),
    ];
  }

  void operationMethod(BuildContext context) {
    try {
      listOfValues = [
        idOperation,
        Pacientes.ID_Paciente,
        fechaRealizacionTextController.text,
        //
        stringImage,
        //
        typeReporte,
        nombreReporteTextController.text,
        //
        idOperation
      ];

      // print("${widget.operationActivity} listOfValues $listOfValues ${listOfValues!.length}");
      // print("realized! ${realized!} ${realized!.runtimeType} "
      //     "${ Dicotomicos.fromBoolean(realized!, toInt: true)} "
      //     "${ Dicotomicos.fromBoolean(realized!, toInt: true).runtimeType} ");

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
              .then((value) => Actividades.consultarAllById(
                          Databases.siteground_database_reghosp,
                          consultIdQuery!,
                          Pacientes.ID_Paciente) // idOperation)
                      .then((value) {
                    // ******************************************** *** *
                    Pacientes.Alergicos = value;
                    Constantes.reinit(value: value);
                    // ******************************************** *** *
                  }).then((value) => onClose(context)));
          break;
        case Constantes.Update:
          Actividades.actualizar(Databases.siteground_database_reghosp,
                  updateQuery!, listOfValues!, idOperation)
              .then((value) => Actividades.consultarAllById(
                          Databases.siteground_database_reghosp,
                          consultIdQuery!,
                          Pacientes.ID_Paciente) // idOperation)
                      .then((value) {
                    // ******************************************** *** *
                    Pacientes.Alergicos = value;
                    Constantes.reinit(value: value);
                    // ******************************************** *** *
                  }).then((value) => onClose(context)));
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
    Constantes.reinit();

    switch (isMobile(context)) {
      case true:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionDocumentacion()));
        break;
      case false:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => VisualPacientes(actualPage: 8)));
        break;
      default:
    }
  }

  Future<void> toBaseImage() async {
    ByteData bytes = await rootBundle.load('assets/images/person.png');
    var buffer = bytes.buffer;

    setState(() {
      stringImage = base64.encode(Uint8List.view(buffer));
    });
  }

  _licenPhoto() => TittleContainer(
        child: PhotoView(
          backgroundDecoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.grey,
              style: BorderStyle.solid,
              width: 1.0,
            ),
          ),
          imageProvider: MemoryImage(base64Decode(stringImage!)),
          loadingBuilder: (context, progress) => Center(
            child: SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: _progress == null
                    ? null
                    : _progress.cumulativeBytesLoaded /
                        _progress.expectedTotalBytes,
              ),
            )
          ),
        ),
      );

  //
  String? stringImage = '';
  var _progress;
}

// ignore: must_be_immutable
class GestionDocumentacion extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Feca_PEN";

  bool? withAppBar;
  // ****************** *** ****** **************

  GestionDocumentacion({Key? key, this.withAppBar = true, this.actualSidePage}) : super(key: key);

  @override
  State<GestionDocumentacion> createState() => _GestionDocumentacionState();
}

class _GestionDocumentacionState extends State<GestionDocumentacion> {
  String appTittle = "Gestion de vicencia del paciente";
  String searchCriteria = "Buscar por Fecha";
  String? consultQuery = Documentaciones.documentacion['consultIdQuery'];

  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  @override
  void initState() {
    print(" . . . Iniciando array ");
    if (Constantes.dummyArray!.isNotEmpty) {
      if (Constantes.dummyArray![0] == "Vacio") {
        Actividades.consultarAllById(Databases.siteground_database_reghosp,
                consultQuery!, Pacientes.ID_Paciente)
            .then((value) {
          setState(() {
            print(" . . . Buscando items \n $value");
            foundedItems = value;
          });
        });
      } else {
        print(" . . . Documentacion array iniciado");
        foundedItems = Constantes.dummyArray;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: widget.withAppBar! == true ? AppBar(
        backgroundColor: Theming.primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          tooltip: Sentences.regresar,
          onPressed: () {
            Constantes.reinit();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => VisualPacientes(actualPage: 8)));
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
              // _pullListRefresh();
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
        ],
      ) : null,
      body: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Expanded(
          flex: 1,
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
                        controller: gestionScrollController,
                        padding: const EdgeInsets.all(10),
                        shrinkWrap: true,
                        itemCount:
                            snapshot.data == null ? 0 : snapshot.data.length,
                        itemBuilder: (context, posicion) {
                          return itemListView(snapshot, posicion, context);
                        },
                        gridDelegate: GridViewTools.gridDelegate(
                            crossAxisCount: isMobile(context) ? 1 : isDesktop(context) ? 1 : 3),
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
        isDesktop(context) || isTablet(context)
            ?Expanded(
          flex: isDesktop(context) ? 2 : 1,
            child: OperacionesDocumentacion(operationActivity: Constantes.operationsActividad,))
            : Container()
      ]),
    );
  }

  Container itemListView(
      AsyncSnapshot snapshot, int posicion, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: ContainerDecoration.roundedDecoration(),
      child: GestureDetector(
        onTap: () {
          onSelected(snapshot, posicion, context, Constantes.Update);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Text(
                      snapshot.data[posicion]['ID_Pace_Repo'].toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 24),
                    ),
                  ),
                  GrandIcon(
                    labelButton: "Eliminar registro",
                    iconData: Icons.delete,
                    onPress: () {
                      Operadores.optionsActivity(
                        context: context,
                        tittle: "Eliminar registro . . .",
                        message: '¿Esta seguro de querer eliminar el registro?',
                        textOptionA: "No",
                        optionA: () {
                          Navigator.of(context).pop();
                        },
                        textOptionB: "Aceptar",
                        optionB: () {
                          deleteRegister(snapshot, posicion, context);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      snapshot.data[posicion]['FechaReporte'].toString(),
                      style: Styles.textSyleGrowth(fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      snapshot.data[posicion]['TipoReporte'].toString(),
                      maxLines: 3,
                      style: Styles.textSyleGrowth(fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      snapshot.data[posicion]['NombreReporte'].toString(),
                      maxLines: 1,
                      style: Styles.textSyle,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(child: CrossLine()),
                  Expanded(
                      flex: 6,
                      child: Image.memory(
                        base64Decode(snapshot.data[posicion]['Reporte_FIAT']),
                        fit: BoxFit.cover,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onSelected(AsyncSnapshot<dynamic> snapshot, int posicion,
      BuildContext context, String operaciones) {
    Documentaciones.Documentos = snapshot.data[posicion];
    // Documentaciones.ID_Documentaciones = snapshot.data[posicion]['ID_Licen_Med'];
    // Documentaciones.selectedDiagnosis = Documentaciones.vicencia['Pace_APP_ALE'];
    Pacientes.Documentaciones = snapshot.data;
    //
    toOperaciones(context, operaciones);
  }

  void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void deleteRegister(
      AsyncSnapshot<dynamic> snapshot, int posicion, BuildContext context) {
    try {
      Actividades.eliminar(
          Databases.siteground_database_reghosp,
          Documentaciones.documentacion['deleteQuery'],
          snapshot.data[posicion]['ID_Licen_Med']);
      setState(() {
        snapshot.data.removeAt(posicion);
      });
    } finally {
      Navigator.of(context).pop();
    }
  }

  void toOperaciones(BuildContext context, String operationActivity) {
    if (isDesktop(context) || isTablet(context)) {
      Constantes.operationsActividad = operationActivity;
      Constantes.reinit(value: foundedItems!);
      _pullListRefresh();
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => OperacionesDocumentacion(
                operationActivity: operationActivity,
              )));
    }
  }

  void _runFilterSearch(String enteredKeyword) {
    List? results = [];

    if (enteredKeyword.isEmpty) {
      _pullListRefresh();
    } else {
      Actividades.consultar(
              Databases.siteground_database_reghosp, consultQuery!)
          .then((value) {
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
            pageBuilder: (a, b, c) => VisualPacientes(
              actualPage: 8,
            ),
            transitionDuration: const Duration(seconds: 0)));
    // Navigator.pushReplacement(
    //     context,
    //     PageRouteBuilder(
    //         pageBuilder: (a, b, c) => GestionDocumentacion(
    //               actualSidePage: Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: OperacionesDocumentacion(
    //                   operationActivity: Constantes.operationsActividad,
    //                 ),
    //               ),
    //             ),
    //         transitionDuration: const Duration(seconds: 0)));
  }
}
