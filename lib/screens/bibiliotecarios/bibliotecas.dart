import 'dart:io';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Bibliotecarios.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/GrandLabel.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/WidgetsModels.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// # Clase .dart para la creación predeterminada de interfaces de registro, consulta y actualización.
// Contiene un botón que enn _OperacionesBibliotecasState.build que desplega una ventana emergente,
// de la cual es posible elegir desde un catálogo de opciones.
// # # INSTRUCCIONES DE USO
// # # # Reemplazar .Bibliotecas por el valor
// # # # Reemplazar Bibliotecas. por la clase que contiene el mapa .pendiente con las claves
// # # # # consultIdQuery
// # # # # registerQuery
// # # # # updateQuery
// # # # Reemplazar .pendiente por el nombre del Map() correspondiente.
//
// ignore: must_be_immutable
class OperacionesBibliotecas extends StatefulWidget {
  String? operationActivity;

  String _operationButton = 'Nulo';

  OperacionesBibliotecas({Key? key, this.operationActivity = Constantes.Nulo})
      : super(key: key);

  @override
  State<OperacionesBibliotecas> createState() => _OperacionesBibliotecasState();
}

class _OperacionesBibliotecasState extends State<OperacionesBibliotecas> {
  String appBarTitile = "Gestión de Bibliotecas";

  String? consultIdQuery = Bibliotecas.bibliotecas['consultIdQuery'];
  String? registerQuery = Bibliotecas.bibliotecas['registerQuery'];
  String? updateQuery = Bibliotecas.bibliotecas['updateQuery'];

  int idOperation = 0;

  List<dynamic>? listOfValues;

  var fechaRealizacionTextController = TextEditingController();
  var tyttleBibliotecasTextController = TextEditingController();
  var autoresBibliotecasTextController = TextEditingController();
  var nameRevTextController = TextEditingController();
  var idDataRevTextController = TextEditingController();
  var doiRevTextController = TextEditingController();
  var annoPubRevTextController = TextEditingController();

  var remBibliotecasTextController = TextEditingController();
  var matemBibliotecasTextController = TextEditingController();
  var conclusionesBibliotecasTextController = TextEditingController();
  var observacionesBibliotecasTextController = TextEditingController();
  //
  var typesArteValue = Bibliotecas.typesBibliotecas[0];
  var catysAbaValue = Bibliotecas.catyeA[0];
  var catysEbeValue = Bibliotecas.catyeB[0];
  var catysIbyValue = Bibliotecas.catyeC[0];
  var conceptoBibliotecasTextController = TextEditingController();
  //
  var carouselController = CarouselController();

  String? filePath;
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
          idOperation = Bibliotecas.biblioteca['ID_Pace_Pen'];

          fechaRealizacionTextController.text =
              Bibliotecas.biblioteca['Feca_PEN'];
          catysAbaValue = Bibliotecas.biblioteca['Pace_PEN'];

          tyttleBibliotecasTextController.text =
              Bibliotecas.biblioteca['Pace_Desc_PEN'].toString();
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
      appBar: isDesktop(context) || isTabletAndDesktop(context)
          ? null
          : AppBar(
              backgroundColor: Theming.primaryColor,
              title: Text(appBarTitile),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
                tooltip: Sentences.regresar,
                onPressed: () {
                  onClose(context);
                },
              )),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: ContainerDecoration.roundedDecoration(),
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
            ),
            Expanded(
              flex: 11,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        decoration: ContainerDecoration.roundedDecoration(),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(10.0),
                          controller: ScrollController(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GrandIcon(
                                labelButton: "Datos Generales",
                                heigth: 4,
                                iconData: Icons.book,
                                onPress: () {
                                  setState(() {
                                    carouselController.jumpToPage(0);
                                  });
                                },
                              ),
                              GrandIcon(
                                labelButton: "Resumenes",
                                heigth: 4,
                                iconData: Icons.bookmark_outline,
                                onPress: () {
                                  setState(() {
                                    carouselController.jumpToPage(1);
                                  });
                                },
                              ),
                              GrandIcon(
                                labelButton: "Categorización General",
                                iconData: Icons.line_weight,
                                onPress: () {
                                  setState(() {
                                    carouselController.jumpToPage(2);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                    flex: 11,
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      decoration: ContainerDecoration.roundedDecoration(),
                      child: CarouselSlider(
                        carouselController: carouselController,
                        options: Carousel.carouselOptions(context: context),
                        items: [
                          SingleChildScrollView(
                            padding: const EdgeInsets.all(10.0),
                            controller: ScrollController(),
                            child: Column(
                              children: [
                                EditTextArea(
                                  keyBoardType: TextInputType.text,
                                  inputFormat: MaskTextInputFormatter(),
                                  labelEditText: 'Título del Recurso',
                                  textController:
                                      tyttleBibliotecasTextController,
                                  numOfLines: 1,
                                ),
                                EditTextArea(
                                  keyBoardType: TextInputType.text,
                                  inputFormat: MaskTextInputFormatter(),
                                  labelEditText: 'Autor(es)',
                                  textController:
                                      autoresBibliotecasTextController,
                                  numOfLines: 1,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: EditTextArea(
                                        keyBoardType: TextInputType.text,
                                        inputFormat: MaskTextInputFormatter(),
                                        labelEditText: 'Nombre de la Revista',
                                        textController: nameRevTextController,
                                        numOfLines: 1,
                                      ),
                                    ),
                                    Expanded(
                                      flex: isTabletAndDesktop(context) ? 3 : 2,
                                      child: Spinner(
                                          width: SpinnersValues.maximumWidth(
                                              context: context),
                                          tittle: "Tipo de Articulo",
                                          onChangeValue: (String value) {
                                            setState(() {
                                              typesArteValue = value;
                                            });
                                          },
                                          items: Bibliotecas.typesBibliotecas,
                                          initialValue: typesArteValue),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: EditTextArea(
                                        keyBoardType: TextInputType.text,
                                        inputFormat: MaskTextInputFormatter(),
                                        labelEditText: 'Año de Publicación',
                                        textController:
                                            annoPubRevTextController,
                                        numOfLines: 1,
                                      ),
                                    ),
                                    Expanded(
                                      child: EditTextArea(
                                        keyBoardType: TextInputType.text,
                                        inputFormat: MaskTextInputFormatter(),
                                        labelEditText: 'DOI de la Revista',
                                        textController: doiRevTextController,
                                        numOfLines: 1,
                                      ),
                                    ),
                                    Expanded(
                                      child: EditTextArea(
                                        keyBoardType: TextInputType.text,
                                        inputFormat: MaskTextInputFormatter(),
                                        labelEditText: 'ID de la Base de Datos',
                                        textController: idDataRevTextController,
                                        numOfLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const CrossLine(),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            padding: const EdgeInsets.all(10.0),
                            controller: ScrollController(),
                            child: Column(
                              children: [
                                EditTextArea(
                                  keyBoardType: TextInputType.text,
                                  inputFormat: MaskTextInputFormatter(),
                                  labelEditText: 'Abstract del Recurso',
                                  textController: remBibliotecasTextController,
                                  numOfLines: 7,
                                  withShowOption: true,
                                ),
                                EditTextArea(
                                  keyBoardType: TextInputType.text,
                                  inputFormat: MaskTextInputFormatter(),
                                  labelEditText:
                                      'Materiales y Métodos del Recurso',
                                  textController:
                                      matemBibliotecasTextController,
                                  numOfLines: 7,
                                  withShowOption: true,
                                ),
                                EditTextArea(
                                  keyBoardType: TextInputType.text,
                                  inputFormat: MaskTextInputFormatter(),
                                  labelEditText: 'Conclusiones del Recurso',
                                  textController:
                                      conclusionesBibliotecasTextController,
                                  numOfLines: 7,
                                  withShowOption: true,
                                ),
                                EditTextArea(
                                  keyBoardType: TextInputType.text,
                                  inputFormat: MaskTextInputFormatter(),
                                  labelEditText: 'Observaciones del Recurso',
                                  textController:
                                      observacionesBibliotecasTextController,
                                  numOfLines: 2,
                                  withShowOption: true,
                                ),
                                const CrossLine(),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            padding: const EdgeInsets.all(10.0),
                            controller: ScrollController(),
                            child: Column(children: [
                              Spinner(
                                  width: SpinnersValues.maximumWidth(
                                      context: context),
                                  tittle: "Familia de Categorias del Articulo",
                                  onChangeValue: (String value) {
                                    setState(() {
                                      catysAbaValue = value;
                                    });
                                  },
                                  items: Bibliotecas.catyeA,
                                  initialValue: catysAbaValue),
                              Spinner(
                                  width: SpinnersValues.maximumWidth(
                                      context: context),
                                  tittle: "Categoria del Articulo",
                                  onChangeValue: (String value) {
                                    setState(() {
                                      catysEbeValue = value;
                                    });
                                  },
                                  items: Bibliotecas.catyeB,
                                  initialValue: catysEbeValue),
                              Spinner(
                                  width: SpinnersValues.maximumWidth(
                                      context: context),
                                  tittle: "Sub-Categoria del Articulo",
                                  onChangeValue: (String value) {
                                    setState(() {
                                      catysIbyValue = value;
                                    });
                                  },
                                  items: Bibliotecas.catyeC,
                                  initialValue: catysIbyValue),
                              EditTextArea(
                                keyBoardType: TextInputType.text,
                                inputFormat: MaskTextInputFormatter(),
                                labelEditText: 'Concepto del Recurso',
                                textController:
                                    conceptoBibliotecasTextController,
                                numOfLines: 2,
                                withShowOption: true,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: TittlePanel(
                                    textPanel: 'Subir archivo PDF',
                                  )),
                                  Expanded(
                                    child: Container(
                                      decoration: ContainerDecoration
                                          .roundedDecoration(),
                                      child: GrandLabel(
                                        iconData: Icons.pageview_outlined,
                                        fontSized: 12,
                                        labelButton: "Desde Dispositivo",
                                        onPress: () async {
                                          final result = await FilePicker
                                              .platform
                                              .pickFiles(
                                            withReadStream: true,
                                            allowMultiple: false,
                                            allowedExtensions: ['pdf'],
                                          );

                                          try {
                                            setState(() {
                                              filePath = result!.paths[0];
                                            });

                                            print("paths ${result!.paths}");
                                            print("names ${result.names}");
                                            print("count ${result.count}");
                                            print(
                                                "isSingle ${result.isSinglePick}");
                                          } on Exception catch (e) {
                                            // TODO
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              GrandLabel(
                                iconData: Icons.view_quilt_outlined,
                                fontSized: 12,
                                labelButton: "Ver Archivo $filePath",
                                onPress: () {
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (BuildContext context) =>
                                  //         ViewDocument(
                                  //       filePath: filePath,
                                  //     ),
                                  //   ),
                                  // );
                                  try {
                                    // Operadores.openDialog(
                                    //   context: context,
                                    //   chyldrim: Container(
                                    //     padding: const EdgeInsets.all(10.0),
                                    //     margin: const EdgeInsets.all(10.0),
                                    //     decoration: ContainerDecoration
                                    //         .roundedDecoration(),
                                    //     child: ViewDocument(),
                                    //   ),
                                    // );
                                  } on Exception catch (e) {
                                    print("Error $e");
                                  }
                                },
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: ContainerDecoration.roundedDecoration(),
                child: GrandButton(
                    labelButton: widget._operationButton,
                    weigth: 2000,
                    onPress: () {
                      operationMethod(context);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  void operationMethod(BuildContext context) {
    try {
      listOfValues = [
        idOperation,
        fechaRealizacionTextController.text,
        //
        tyttleBibliotecasTextController.text,
        autoresBibliotecasTextController.text,
        nameRevTextController.text,
        idDataRevTextController.text,
        doiRevTextController.text,
        annoPubRevTextController.text,

        remBibliotecasTextController.text,
        matemBibliotecasTextController.text,
        conclusionesBibliotecasTextController.text,
        observacionesBibliotecasTextController.text,
        //
        typesArteValue,
        catysAbaValue,
        catysEbeValue,
        catysIbyValue,
        conceptoBibliotecasTextController.text,
// file
        //
        idOperation
      ];

      print(
          "${widget.operationActivity} listOfValues $listOfValues ${listOfValues!.length}");
      // print("realized! ${realized!} ${realized!.runtimeType} "
      //     "${ Dicotomicos.fromBoolean(realized!, toInt: true)} "
      //     "${ Dicotomicos.fromBoolean(realized!, toInt: true).runtimeType} ");

      switch (widget.operationActivity) {
        case Constantes.Nulo:
          // ******************************************** *** *
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(Databases.siteground_database_regasca,
              registerQuery!, listOfValues!.removeLast());
          break;
        case Constantes.Consult:
          break;
        case Constantes.Register:
          // ******************************************** *** *
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(Databases.siteground_database_regasca,
                  registerQuery!, listOfValues!)
              .then((value) => Actividades.consultarAllById(
                          Databases.siteground_database_regasca,
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
          Actividades.actualizar(Databases.siteground_database_regasca,
                  updateQuery!, listOfValues!, idOperation)
              .then((value) => Actividades.consultarAllById(
                          Databases.siteground_database_regasca,
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
                builder: (context) => GestionBibliotecas()));
        break;
      case false:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionBibliotecas()));
        break;
      default:
    }
  }
}

// ignore: must_be_immutable
class GestionBibliotecas extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Feca_PEN";
  // ****************** *** ****** **************

  GestionBibliotecas({Key? key, this.actualSidePage}) : super(key: key);

  @override
  State<GestionBibliotecas> createState() => _GestionBibliotecasState();
}

class _GestionBibliotecasState extends State<GestionBibliotecas> {
  String appTittle = "Gestion de recursos bibliográficos";
  String searchCriteria = "Buscar por Fecha";
  String? consultQuery = Bibliotecas.bibliotecas['consultIdQuery'];

  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  @override
  void initState() {
    print(" . . . Iniciando array ");
    if (Constantes.dummyArray!.isNotEmpty) {
      if (Constantes.dummyArray![0] == "Vacio") {
        Actividades.consultarAllById(Databases.siteground_database_regasca,
                consultQuery!, Pacientes.ID_Hospitalizacion)
            .then((value) {
          setState(() {
            print(" . . . Buscando items \n $value");
            foundedItems = value;
          });
        });
      } else {
        print(" . . . Bibliotecas array iniciado");
        foundedItems = Constantes.dummyArray;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
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
          title: Text(appTittle),
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
                            _pullListRefresh();
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
                          ? GridView.builder(
                              controller: gestionScrollController,
                              padding: const EdgeInsets.all(10),
                              shrinkWrap: true,
                              itemCount: snapshot.data == null
                                  ? 0
                                  : snapshot.data.length,
                              itemBuilder: (context, posicion) {
                                return itemListView(
                                    snapshot, posicion, context);
                              },
                              gridDelegate:
                                  GridViewTools.gridDelegate(crossAxisCount: 3),
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
        isDesktop(context) || isTabletAndDesktop(context)
            ? widget.actualSidePage != null
                ? Expanded(flex: 1, child: widget.actualSidePage!)
                : Expanded(flex: 1, child: Container())
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
                      snapshot.data[posicion]['ID_Pace_Pen'].toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 24),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  snapshot.data[posicion]['Pace_PEN_realized'] == 0
                      ? IconButton(
                          icon: const Icon(Icons.not_interested,
                              color: Colors.redAccent),
                          onPressed: () {
                            Actividades.actualizar(
                                    Databases.siteground_database_regasca,
                                    Bibliotecas.bibliotecas['updateDoQuery'],
                                    [
                                      Dicotomicos.fromBoolean(true,
                                          toInt: true),
                                      snapshot.data[posicion]['ID_Pace_Pen']
                                    ],
                                    snapshot.data[posicion]['ID_Pace_Pen'])
                                .then((value) => _pullListRefresh());
                          },
                        )
                      : IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () {
                            Actividades.actualizar(
                                    Databases.siteground_database_regasca,
                                    Bibliotecas.bibliotecas['updateDoQuery'],
                                    [
                                      Dicotomicos.fromBoolean(false,
                                          toInt: true),
                                      snapshot.data[posicion]['ID_Pace_Pen']
                                    ],
                                    snapshot.data[posicion]['ID_Pace_Pen'])
                                .then((value) => _pullListRefresh());
                          },
                        ),
                  // const SizedBox(
                  //   height: 30,
                  // ),
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
                children: [
                  Expanded(
                    child: Text(
                      snapshot.data[posicion]['Feca_PEN'].toString(),
                      style: Styles.textSyleGrowth(fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      snapshot.data[posicion]['Pace_PEN'].toString(),
                      style: Styles.textSyleGrowth(fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const Expanded(child: CrossLine()),
                  Expanded(
                    flex: 4,
                    child: Text(
                      snapshot.data[posicion]['Pace_Desc_PEN'].toString(),
                      maxLines: 7,
                      style: Styles.textSyle,
                      textAlign: TextAlign.start,
                    ),
                  ),
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
    Bibliotecas.biblioteca = snapshot.data[posicion];
    // Bibliotecas.selectedDiagnosis = Bibliotecas.bibliotecas['Pace_APP_ALE'];
    Bibliotecas.librerias = snapshot.data;
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
          Databases.siteground_database_regasca,
          Bibliotecas.bibliotecas['deleteQuery'],
          snapshot.data[posicion]['ID_Pace_Pen']);
      setState(() {
        snapshot.data.removeAt(posicion);
      });
    } finally {
      Navigator.of(context).pop();
    }
  }

  void toOperaciones(BuildContext context, String operationActivity) {
    if (isDesktop(context) || isTabletAndDesktop(context)) {
      Constantes.operationsActividad = operationActivity;
      Constantes.reinit(value: foundedItems!);
      _pullListRefresh();
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => OperacionesBibliotecas(
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
              Databases.siteground_database_regasca, consultQuery!)
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
            pageBuilder: (a, b, c) => GestionBibliotecas(
                  actualSidePage: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OperacionesBibliotecas(
                      operationActivity: Constantes.operationsActividad,
                    ),
                  ),
                ),
            transitionDuration: const Duration(seconds: 0)));
  }
}

// // ignore: must_be_immutable
// class ViewDocument extends StatefulWidget {
//   var filePath;
//
//   ViewDocument(
//       {Key? key,
//       this.filePath = "C:/Users/Luis%20Romero%20Pantoja/Documents/prueba.pdf"})
//       : super(key: key);
//
//   @override
//   State<ViewDocument> createState() => _ViewDocumentState();
// }
//
// class _ViewDocumentState extends State<ViewDocument> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//           backgroundColor: Theming.primaryColor,
//           leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back,
//             ),
//             tooltip: Sentences.regresar,
//             onPressed: () {
//               Constantes.reinit();
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => VisualPacientes(actualPage: 0)));
//             },
//           ),
//           title: Text("Ver documento"),
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(
//                 Icons.replay_outlined,
//               ),
//               tooltip: Sentences.reload,
//               onPressed: () {
//                 // _pullListRefresh();
//               },
//             ),
//             IconButton(
//               icon: const Icon(
//                 Icons.add_card,
//               ),
//               tooltip: Sentences.add_vitales,
//               onPressed: () {
//                 // toOperaciones(context, Constantes.Register);
//               },
//             ),
//           ]),
//       body: SafeArea(
//         child: SfPdfViewer.file(
//           File(widget.filePath!),
//         ),
//       ),
//     );
//   }
// }
