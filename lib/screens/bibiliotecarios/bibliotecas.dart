import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Bibliotecarios.dart';
import 'package:assistant/screens/bibiliotecarios/fragmentos.dart';
import 'package:assistant/screens/home.dart';

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
import 'package:assistant/widgets/ViewDocument.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


// # Clase .dart para la creación predeterminada de interfaces de registro, consulta y actualización.
// Contiene un botón que enn _OperacionesBibliotecasState.build que desplega una ventana emergente,
// de la cual es posible elegir desde un catálogo de opciones.
// # # INSTRUCCIONES DE USO
// # # # Reemplazar .Bibliotecas por el valor
// # # # Reemplazar Bibliotecas. por la clase que contiene el mapa .pendiente con las claves
// # # # # consultQuery
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
  String appBarTitile = "Operación del Recurso Bibliográfico";

  String? consultQuery = Bibliotecas.bibliotecas['consultQuery'];
  String? registerQuery = Bibliotecas.bibliotecas['registerQuery'];
  String? updateQuery = Bibliotecas.bibliotecas['updateQuery'];

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
        // ******** ********** ******** *******
        setState(() {
          widget._operationButton = 'Actualizar';
          // ******** ********** ******** *******
          idOperation = Bibliotecas.biblioteca['ID_Lyben'];
          Bibliotecas.ID_Bibliografia = idOperation;
          // ******** ********** ******** *******
          fechaRealizacionTextController.text =
              Bibliotecas.biblioteca['Feca_Lyben_REG'];
          tyttleBibliotecasTextController.text =
              Bibliotecas.biblioteca['Lyben_Tyttle'];
          autoresBibliotecasTextController.text =
              Bibliotecas.biblioteca['Lyben_Autores'];
          nameRevTextController.text =
              Bibliotecas.biblioteca['Lyben_Rev_Journal'];
          idDataRevTextController.text =
              Bibliotecas.biblioteca['Lyben_Database_Id'];
          doiRevTextController.text = Bibliotecas.biblioteca['Lyben_DOI'];
          annoPubRevTextController.text =
              Bibliotecas.biblioteca['Lyben_Anno_Pub'];
          keyWordsBibliotecasTextController.text =
          Bibliotecas.biblioteca['Lyben_Keyword'];

          remBibliotecasTextController.text =
              Bibliotecas.biblioteca['Lyben_Absctract'];
          matemBibliotecasTextController.text =
              Bibliotecas.biblioteca['Lyben_Methods'];
          conclusionesBibliotecasTextController.text =
              Bibliotecas.biblioteca['Lyben_Conclusiones'];
          observacionesBibliotecasTextController.text =
              Bibliotecas.biblioteca['Lyben_Obs'];
          //
          typesArteValue = Bibliotecas.biblioteca['Lyben_Type_Rev'];
        });
        getImage();
        super.initState();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
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
        body: isTablet(context) || isMobile(context)
            ? Column(
                children: [
                  Expanded(
                      child: ViewDocument(
                    isFromMemory: widget.operationActivity == Constantes.Update
                        ? true
                        : false,
                    filePath: widget.operationActivity == Constantes.Update
                        ? Bibliotecas.documentoBibliografia
                        : filePath,
                  )),
                  Expanded(child: operativity()),
                ],
              )
            : Row(
                children: [
                  Expanded(
                      child: ViewDocument(
                    isFromMemory: widget.operationActivity == Constantes.Update
                        ? true
                        : false,
                    filePath: widget.operationActivity == Constantes.Update
                        ? Bibliotecas.documentoBibliografia
                        : filePath,
                  )),
                  Expanded(child: operativity()),
                ],
              ));
  }

  Container operativity() {
    return Container(
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
                                textController: tyttleBibliotecasTextController,
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
                                      textController: annoPubRevTextController,
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
                              EditTextArea(
                                keyBoardType: TextInputType.text,
                                inputFormat: MaskTextInputFormatter(),
                                labelEditText: 'Palabras Claves del Recurso',
                                textController: keyWordsBibliotecasTextController,
                                numOfLines: 1,
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
                                textController: matemBibliotecasTextController,
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
                            Row(
                              children: [
                                Expanded(
                                    child: TittlePanel(
                                  textPanel: 'Subir archivo PDF',
                                )),
                                Expanded(
                                  child: Container(
                                    decoration:
                                        ContainerDecoration.roundedDecoration(),
                                    child: GrandLabel(
                                      iconData: Icons.pageview_outlined,
                                      fontSized: 12,
                                      labelButton: "Desde Dispositivo",
                                      onPress: () async {
                                        final result =
                                            await FilePicker.platform.pickFiles(
                                          withReadStream: true,
                                          allowMultiple: false,
                                          type: FileType.custom,
                                          allowedExtensions: ['pdf'],
                                        );

                                        try {
                                          setState(() {
                                            filePath = result!.paths[0];
                                          });
                                          toBase();
                                          // print("paths ${result!.paths}");
                                          // print("names ${result.names}");
                                          // print("count ${result.count}");
                                          // print("isSingle ${result.isSinglePick}");
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
                                  Operadores.openDialog(
                                    context: context,
                                    chyldrim: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      margin: const EdgeInsets.all(10.0),
                                      decoration: ContainerDecoration
                                          .roundedDecoration(),
                                      child: ViewDocument(
                                        filePath: filePath,
                                      ),
                                    ),
                                  );
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
    );
  }

  void operationMethod(BuildContext context) {
    try {
      Operadores.alertActivity(
          context: context,
          tittle: "Operación . . . ",
          message: "Operado registro");

      listOfValues = [
        idOperation,
        fechaRealizacionTextController.text,
        //
        tyttleBibliotecasTextController.text,
        autoresBibliotecasTextController.text,
        nameRevTextController.text,
        typesArteValue,
        annoPubRevTextController.text,
        doiRevTextController.text,
        idDataRevTextController.text,
        keyWordsBibliotecasTextController.text,
//
        remBibliotecasTextController.text,
        matemBibliotecasTextController.text,
        conclusionesBibliotecasTextController.text,
        observacionesBibliotecasTextController.text,
        //
        Bibliotecas.documentoBibliografia,
        //
        idOperation
      ];

      print(
          "${widget.operationActivity} listOfValues ${listOfValues!.length} $listOfValues");

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
              .then((value) => Actividades.consultar(
                    Databases.siteground_database_regasca,
                    consultQuery!,
                  ).then((value) {
                    // ******************************************** *** *
                    Bibliotecas.librerias = value;
                    Constantes.reinit(value: value);
                    // ******************************************** *** *
                  }).then((value) => onClose(context)));
          break;
        case Constantes.Update:
          Actividades.actualizar(Databases.siteground_database_regasca,
                  updateQuery!, listOfValues!, idOperation)
              .then((value) => Actividades.consultar(
                    Databases.siteground_database_regasca,
                    consultQuery!,
                  ).then((value) {
                    // ******************************************** *** *
                    Bibliotecas.librerias = value;
                    Constantes.reinit(value: value);
                    // ******************************************** *** *
                  }).then((value) => onClose(context)));
          break;
        default:
      }
    } catch (ex) {
      Operadores.alertActivity(
          context: context,
          tittle: "Error al Actualizar registro",
          message: "$ex");
    }
  }

  void onClose(BuildContext context) {
    Constantes.reinit();
    Navigator.push(
      context,
      MaterialPageRoute(
        // maintainState: false,
        builder: (context) => GestionBibliotecas(),
      ),
    );
  }

  // ****************************************
  toBase() async {
    if (filePath != null || filePath != "") {
      Uint8List bytes = await File(filePath!).readAsBytes();
      setState(() {
        Bibliotecas.documentoBibliografia = base64.encode(bytes);
        print("fileStringBaseEncode $Bibliotecas.documentoBibliografia");
      });
    }
  }

  Future<void> fromBase() async {
    String name = tyttleBibliotecasTextController.text.isEmpty
        ? "name"
        : tyttleBibliotecasTextController.text;
    File decodedimgfile = await File("${name}.pdf")
        .writeAsBytes(base64.decode(Bibliotecas.biblioteca['Lyben_File']!));

    setState(() {
      filePath = decodedimgfile.path;
    });
  }

  void getImage() {
    Actividades.consultarId(
            Databases.siteground_database_regasca,
            Bibliotecas.bibliotecas['consultDocument'],
            Bibliotecas.ID_Bibliografia)
        .then((value) {
      setState(() {
        print("consultImage ${Bibliotecas.ID_Bibliografia} $value");
        Bibliotecas.documentoBibliografia = value['Lyben_File'];
      });
    });
  }

  // ****************************************
  int idOperation = 0;

  List<dynamic>? listOfValues;

  var fechaRealizacionTextController = TextEditingController();
  var tyttleBibliotecasTextController = TextEditingController();
  var autoresBibliotecasTextController = TextEditingController();
  var nameRevTextController = TextEditingController();
  var idDataRevTextController = TextEditingController();
  var doiRevTextController = TextEditingController();
  var annoPubRevTextController = TextEditingController();
  var keyWordsBibliotecasTextController = TextEditingController();

  var remBibliotecasTextController = TextEditingController();
  var matemBibliotecasTextController = TextEditingController();
  var conclusionesBibliotecasTextController = TextEditingController();
  var observacionesBibliotecasTextController = TextEditingController();
  //
  var typesArteValue = Bibliotecas.typesBibliotecas[0];
  //
  var carouselController = CarouselController();

  String? filePath = ""; // , fileStringBaseEncode = "";
//
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
  String? consultQuery = Bibliotecas.bibliotecas['consultQuery'];

  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  @override
  void initState() {
    print(" . . . Iniciando array ");
    if (Constantes.dummyArray!.isNotEmpty) {
      if (Constantes.dummyArray![0] == "Vacio") {
        Actividades.consultar(
                Databases.siteground_database_regasca, consultQuery!)
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Home()));
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
                              gridDelegate: GridViewTools.gridDelegate(
                                crossAxisCount: 2,
                                mainAxisExtent: 320,
                              ),
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
          // onSelected(snapshot, posicion, context, Constantes.Update);
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
                      snapshot.data[posicion]['ID_Lyben'].toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 24),
                    ),
                  ),
                  GrandIcon(
                    labelButton: "Añadir fragmento",
                    iconData: Icons.add,
                    onPress: () {
                      onSelected(
                          snapshot, posicion, context, Constantes.Update, isFragment: true);
                    },
                  ),
                  GrandIcon(
                    labelButton: "Actualizar registro",
                    iconData: Icons.update,
                    onPress: () {
                      onSelected(
                          snapshot, posicion, context, Constantes.Update);
                    },
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
                children: [
                  Expanded(
                    child: Text(
                      snapshot.data[posicion]['Lyben_Tyttle'].toString(),
                      maxLines: 2,
                      style: Styles.textSyleGrowth(fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      snapshot.data[posicion]['Lyben_Autores'].toString(),
                      style: Styles.textSyleGrowth(fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const Expanded(child: CrossLine()),
                  Expanded(
                    flex: 4,
                    child: Text(
                      snapshot.data[posicion]['Lyben_Rev_Journal'].toString(),
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
      BuildContext context, String operaciones, {bool isFragment = false}) {
    Bibliotecas.fromJson(snapshot.data[posicion]);
    //
    Bibliotecas.biblioteca = snapshot.data[posicion];
    Bibliotecas.librerias = snapshot.data;
    //
    getImage();
    //
    if (isFragment) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => GestionFragmentos()));
    } else {
      toOperaciones(context, operaciones);
    }

  }

  void deleteRegister(
      AsyncSnapshot<dynamic> snapshot, int posicion, BuildContext context) {
    try {
      Actividades.eliminar(
          Databases.siteground_database_regasca,
          Bibliotecas.bibliotecas['deleteQuery'],
          snapshot.data[posicion]['ID_Lyben']);
      setState(() {
        snapshot.data.removeAt(posicion);
      });
    } finally {
      Navigator.of(context).pop();
    }
  }

  void toOperaciones(BuildContext context, String operationActivity) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => OperacionesBibliotecas(
              operationActivity: operationActivity,
            )));

    // if (isDesktop(context) || isTabletAndDesktop(context)) {
    //   Constantes.operationsActividad = operationActivity;
    //   Constantes.reinit(value: foundedItems!);
    //   _pullListRefresh();
    // } else {
    //   Navigator.of(context).push(MaterialPageRoute(
    //       builder: (BuildContext context) => OperacionesBibliotecas(
    //             operationActivity: operationActivity,
    //           )));
    // }
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

  getImage() {
    if (Bibliotecas.documentoBibliografia == "") {
      Actividades.consultarId(
              Databases.siteground_database_regasca,
              Bibliotecas.bibliotecas['consultDocument'],
              Bibliotecas.ID_Bibliografia)
          .then((value) {
        setState(() {
          print("consultImage ${Bibliotecas.ID_Bibliografia} $value");
          Bibliotecas.documentoBibliografia = value['Lyben_File'];
        });
      });
    } else {
      setState(() {
        Bibliotecas.documentoBibliografia;
      });
    }
  }

}

