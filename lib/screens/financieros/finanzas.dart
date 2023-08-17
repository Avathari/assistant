import 'dart:convert';
import 'dart:typed_data';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Financieros.dart';
import 'package:assistant/screens/financieros/estadisticas.dart';
import 'package:assistant/screens/home.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CircleLabel.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/WidgetsModels.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:photo_view/photo_view.dart';

// # Clase .dart para la creación predeterminada de interfaces de registro, consulta y actualización.
// Contiene un botón que enn _OperacionesActivosState.build que desplega una ventana emergente,
// de la cual es posible elegir desde un catálogo de opciones.
// # # INSTRUCCIONES DE USO
// # # # Reemplazar .Activos por el valor
// # # # Reemplazar Activos. por la clase que contiene el mapa .activos con las claves
// # # # # consultIdQuery
// # # # # registerQuery
// # # # # updateQuery
// # # # Reemplazar .activos por el nombre del Map() correspondiente.
//
class OperacionesActivos extends StatefulWidget {
  String? operationActivity;

  String _operationButton = 'Nulo';

  OperacionesActivos({Key? key, this.operationActivity = Constantes.Nulo})
      : super(key: key);

  @override
  State<OperacionesActivos> createState() => _OperacionesActivosState();
}

class _OperacionesActivosState extends State<OperacionesActivos> {

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

        fechaProgramadaTextController.text =
            Calendarios.today(format: "yyyy/MM/dd");
        estadoActualTextController.text = Activos.estadoActual[0];
        toBaseImage();
        break;
      case Constantes.Update:
        setState(() {
          widget._operationButton = 'Actualizar';
          idOperation = Activos.Activo['ID_Registro'];

          conceptoRecursoTextController.text =
              Activos.Activo['Concepto_Recurso'];
          tipoRecursoTextController.text = Activos.Activo['Tipo_Recurso'];
          cuentaAsignadaTextController.text = Activos.Activo['Cuenta_Asignada'];

          fechaProgramadaTextController.text =
              Activos.Activo['Fecha_Pago_Programado'];
          intervaloProgramadoTextController.text =
              Activos.Activo['Intervalo_Programado'];

          montoProgramadoTextController.text =
              Activos.Activo['Monto_Programado'].toString();

          montoPagadoTextController.text =
              Activos.Activo['Monto_Pagado'].toString();
          interesAcordadoTextController.text =
              Activos.Activo['Interes_Acordado'].toString();
          montoRestanteTextController.text =
              Activos.Activo['Monto_Restante'].toString();

          estadoActualTextController.text = Activos.Activo['Estado_Actual'];
          fechaProximoTextController.text =
              Activos.Activo['Fecha_Proximo_Pago'];
          fechaBajaTextController.text = Activos.Activo['Fecha_Baja'];

          descripcionTextController.text = Activos.Activo['Descripcion'];
          stringImage = Activos.imagenActivo;
          Terminal.printExpected(message: "stringImage $stringImage");
        });
        super.initState();
        break;
      default:
        toBaseImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    var _progress;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: isMobile(context)
          ? AppBar(
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
              ))
          : null,
      body: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: ContainerDecoration.roundedDecoration(),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: CarouselSlider(
                carouselController: carouselController,
                options: Carousel.carouselOptions(context: context),
                items: [
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        TittlePanel(textPanel: 'Características del Registro'),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: ContainerDecoration.roundedDecoration(),
                          child: Row(
                            children: [
                              Expanded(
                                child: CircleIcon(
                                  iconed: tipoRecursoTextController.text ==
                                          'Ingresos'
                                      ? Icons.insights
                                      : tipoRecursoTextController.text ==
                                              'Egresos'
                                          ? Icons.leaderboard_sharp
                                          : tipoRecursoTextController.text ==
                                                  'Activos'
                                              ? Icons.ac_unit
                                              : tipoRecursoTextController
                                                          .text ==
                                                      'Pasivos'
                                                  ? Icons.pages_sharp
                                                  : tipoRecursoTextController
                                                              .text ==
                                                          'Patrimonio'
                                                      ? Icons.hdr_weak_sharp
                                                      : Icons.all_out,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: EditTextArea(
                                  labelEditText: 'Tipo de Recurso',
                                  textController: tipoRecursoTextController,
                                  keyBoardType: TextInputType.text,
                                  numOfLines: 1,
                                  iconData: Icons.account_balance,
                                  selection: true,
                                  withShowOption: true,
                                  inputFormat: MaskTextInputFormatter(),
                                  onSelected: () {
                                    Operadores.selectOptionsActivity(
                                        context: context,
                                        options: Activos.tipoRecurso,
                                        onClose: (value) {
                                          setState(() {
                                            cuentaAsignadaTextController.text =
                                                '';
                                            tipoRecursoTextController.text =
                                                value;
                                            Navigator.of(context).pop();
                                          });
                                        });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        CrossLine(height: 10),
                        EditTextArea(
                          labelEditText: 'Concepto de Recurso',
                          textController: conceptoRecursoTextController,
                          keyBoardType: TextInputType.text,
                          numOfLines: 1,
                          selection: true,
                          withShowOption: true,
                          inputFormat: MaskTextInputFormatter(),
                          iconData: Icons.account_tree_outlined,
                          onSelected: () {
                            Operadores.selectOptionsActivity(
                                context: context,
                                options: tipoRecursoTextController.text ==
                                        Activos.tipoRecurso[0]
                                    ? Activos.conceptoIngresos
                                    : tipoRecursoTextController.text ==
                                            Activos.tipoRecurso[1]
                                        ? Activos.conceptoEgresos
                                        : tipoRecursoTextController.text ==
                                                Activos.tipoRecurso[2]
                                            ? Activos.conceptoActivos
                                            : tipoRecursoTextController.text ==
                                                    Activos.tipoRecurso[3]
                                                ? Activos.conceptoPasivos
                                                : Activos.conceptoPatrimonio,
                                onClose: (value) {
                                  setState(() {
                                    conceptoRecursoTextController.text = value;
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                        EditTextArea(
                          labelEditText: 'Cuenta Asignada',
                          textController: cuentaAsignadaTextController,
                          keyBoardType: TextInputType.text,
                          iconData: Icons.line_weight,
                          numOfLines: 1,
                          selection: true,
                          withShowOption: true,
                          inputFormat: MaskTextInputFormatter(),
                          onSelected: () {
                            Operadores.selectOptionsActivity(
                                context: context,
                                options: tipoRecursoTextController.text ==
                                            Activos.tipoRecurso[1] ||
                                        tipoRecursoTextController.text ==
                                            Activos.tipoRecurso[3]
                                    ? Activos.cuentaAsignada
                                    : [],
                                onClose: (value) {
                                  setState(() {
                                    cuentaAsignadaTextController.text = value;
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                        EditTextArea(
                          labelEditText: 'Fecha de Pago Programada',
                          textController: fechaProgramadaTextController,
                          keyBoardType: TextInputType.text,
                          numOfLines: 1,
                          selection: true,
                          withShowOption: true,
                          inputFormat: MaskTextInputFormatter(),
                          onSelected: () {
                            setState(() {
                              fechaProgramadaTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            });
                          },
                        ),
                        EditTextArea(
                          labelEditText: 'Intervalo Programado',
                          textController: intervaloProgramadoTextController,
                          keyBoardType: TextInputType.text,
                          iconData: Icons.integration_instructions_outlined,
                          numOfLines: 1,
                          selection: true,
                          withShowOption: true,
                          inputFormat: MaskTextInputFormatter(),
                          onSelected: () {
                            Operadores.selectOptionsActivity(
                                context: context,
                                options: Activos.intervaloProgramado,
                                onClose: (value) {
                                  setState(() {
                                    intervaloProgramadoTextController.text =
                                        value;
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TittlePanel(textPanel: 'Montos del Registro'),
                        EditTextArea(
                          labelEditText: 'Monto Restante',
                          textController: montoRestanteTextController,
                          keyBoardType: TextInputType.number,
                          numOfLines: 1,
                          inputFormat: MaskTextInputFormatter(),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: ContainerDecoration.roundedDecoration(),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: EditTextArea(
                                  labelEditText: 'Monto Pagado',
                                  textController: montoPagadoTextController,
                                  keyBoardType: TextInputType.number,
                                  prefixIcon: true,
                                  iconData: Icons.attach_money,
                                  numOfLines: 1,
                                  inputFormat: MaskTextInputFormatter(),
                                ),
                              ),
                              Expanded(
                                child: CircleIcon(
                                  iconed: tipoRecursoTextController.text ==
                                          'Ingresos'
                                      ? Icons.insights
                                      : tipoRecursoTextController.text ==
                                              'Egresos'
                                          ? Icons.leaderboard_sharp
                                          : tipoRecursoTextController.text ==
                                                  'Activos'
                                              ? Icons.ac_unit
                                              : tipoRecursoTextController
                                                          .text ==
                                                      'Pasivos'
                                                  ? Icons.pages_sharp
                                                  : tipoRecursoTextController
                                                              .text ==
                                                          'Patrimonio'
                                                      ? Icons.hdr_weak_sharp
                                                      : Icons.all_out,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CrossLine(height: 10),
                        Container(
                          decoration: ContainerDecoration.roundedDecoration(),
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              EditTextArea(
                                labelEditText: 'Monto Programado',
                                textController: montoProgramadoTextController,
                                keyBoardType: TextInputType.number,
                                numOfLines: 1,
                                inputFormat: MaskTextInputFormatter(),
                              ),
                              EditTextArea(
                                labelEditText: 'Interes Acordado',
                                textController: interesAcordadoTextController,
                                keyBoardType: TextInputType.number,
                                numOfLines: 1,
                                inputFormat: MaskTextInputFormatter(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        TittlePanel(textPanel: 'Generalidades del Registro'),
                        EditTextArea(
                          labelEditText: 'Estado Actual',
                          textController: estadoActualTextController,
                          keyBoardType: TextInputType.text,
                          numOfLines: 1,
                          selection: true,
                          withShowOption: true,
                          inputFormat: MaskTextInputFormatter(),
                          onSelected: () {
                            Operadores.selectOptionsActivity(
                                context: context,
                                options: Activos.estadoActual,
                                onClose: (value) {
                                  setState(() {
                                    estadoActualTextController.text = value;
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                        EditTextArea(
                          labelEditText: 'Fecha de Proximo Pago',
                          textController: fechaProximoTextController,
                          keyBoardType: TextInputType.text,
                          numOfLines: 1,
                          selection: true,
                          withShowOption: true,
                          inputFormat: MaskTextInputFormatter(),
                          onSelected: () {
                            setState(() {
                              fechaProximoTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            });
                          },
                        ),
                        EditTextArea(
                          labelEditText: 'Fecha de Baja',
                          textController: fechaBajaTextController,
                          keyBoardType: TextInputType.text,
                          numOfLines: 1,
                          selection: true,
                          withShowOption: true,
                          inputFormat: MaskTextInputFormatter(),
                          onSelected: () {
                            setState(() {
                              fechaBajaTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            });
                          },
                        ),
                        EditTextArea(
                          labelEditText: 'Descripción',
                          textController: descripcionTextController,
                          keyBoardType: TextInputType.text,
                          numOfLines: 15,
                          inputFormat: MaskTextInputFormatter(),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GrandIcon(
                              iconData: Icons.photo_camera_back_outlined,
                              labelButton: 'Imagen del Activo',
                              onPress: () {
                                Operadores.optionsActivity(
                                  context: context,
                                  tittle:
                                      'Cargar imagen del Electrocardiograma',
                                  onClose: () {
                                    Navigator.of(context).pop();
                                  },
                                  textOptionA: 'Cargar desde Dispositivo',
                                  optionA: () async {
                                    var bytes =
                                        await Directorios.choiseFromDirectory();
                                    setState(() {
                                      stringImage = base64Encode(bytes);
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  textOptionB: 'Cargar desde Cámara',
                                  optionB: () async {
                                    var bytes =
                                        await Directorios.choiseFromCamara();
                                    setState(() {
                                      stringImage = base64Encode(bytes);
                                      Navigator.of(context).pop();
                                    });
                                  },
                                );
                              },
                            ),
                            GrandIcon(
                              iconData: Icons.new_releases_outlined,
                              labelButton: 'Recargar . . . ',
                              onPress: () {
                                setState(() {
                                  stringImage = Activos.imagenActivo;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          margin: const EdgeInsets.all(15.0),
                          decoration: ContainerDecoration.roundedDecoration(
                              colorBackground: Colors.grey),
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
                            imageProvider:
                                MemoryImage(base64Decode(stringImage!)),
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
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CrossLine(),
            Expanded(
              child: GrandButton(
                  labelButton: widget._operationButton,
                  weigth: 1000,
                  onPress: () {
                    operationMethod(context);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Future<void> toBaseImage() async {
    ByteData bytes = await rootBundle.load('assets/images/person.png');
    var buffer = bytes.buffer;

    setState(() {
      stringImage = base64.encode(Uint8List.view(buffer));
    });
  }

  // OPERACIONES *******************  *** ** * *****
  void operationMethod(BuildContext context) {
    // ********************************** * * * * * * * * *
    try {
      listOfValues = [
        idOperation,
        Financieros.ID_Financieros,
        conceptoRecursoTextController.text,
        tipoRecursoTextController.text,
        cuentaAsignadaTextController.text,
        //
        fechaProgramadaTextController.text,
        intervaloProgramadoTextController.text,
        //
        montoProgramadoTextController.text,
        interesAcordadoTextController.text,
        montoPagadoTextController.text,
        montoRestanteTextController.text,
        //
        estadoActualTextController.text,
        fechaProximoTextController.text,
        fechaBajaTextController.text,
        //
        descripcionTextController.text,
        stringImage!,
        idOperation
      ];

      Terminal.printExpected(message: "${widget.operationActivity} ");
      // )listOfValues $listOfValues ${listOfValues!.length}");
      switch (widget.operationActivity) {
        case Constantes.Nulo:
          // ******************************************** *** *
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(Databases.siteground_database_regfine,
              registerQuery!, listOfValues!.removeLast());
          break;
        case Constantes.Consult:
          break;
        case Constantes.Register:
          Operadores.loadingActivity(
              context: context,
              tittle: "Registrado Información",
              message: "Registrando información . . . ");
          // ******************************************** *** *
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(Databases.siteground_database_regfine,
                  registerQuery!, listOfValues!)
              .then((value) =>
                  Terminal.printExpected(message: "Registrado : : $value"))
              .whenComplete(() => onClose(context))
              .onError((error, stackTrace) => Operadores.alertActivity(
                  context: context,
                  tittle: "Error al Registrar . . .",
                  message: "ERROR - $error : $stackTrace"));
          break;
        case Constantes.Update:
          Operadores.loadingActivity(
              context: context,
              tittle: "Actualizando Información",
              message: "Actualizando información . . . ");
          Actividades.actualizar(Databases.siteground_database_regfine,
                  updateQuery!, listOfValues!, idOperation)
              .then((value) =>
                  Terminal.printSuccess(message: "Actualizado : : $value"))
              .whenComplete(() => onClose(context))
              .onError((error, stackTrace) => Operadores.alertActivity(
                  context: context,
                  tittle: "Error al Registrar . . .",
                  message: "ERROR - $error : $stackTrace"));
          break;
        default:
      }
    } catch (ex) {
      Operadores.alertActivity(
          context: context,
          tittle: "Error al operar con los valores",
          message: "ERROR - $ex",
          onAcept: () {
            Navigator.of(context).pop();
          },
          onClose: () {});
    }
  }

  void onClose(BuildContext context) {
    Activos.registros().whenComplete(() {
      switch (isMobile(context)) {
        case true:
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      GestionActivos(esActualized: true, reverse: true)));
          break;
        case false:
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GestionActivos(
                      esActualized: true,
                      reverse: true,
                      actualSidePage: const EstadisticasActivos())));
          break;
        default:
      }
    }).onError((error, stackTrace) => Operadores.alertActivity(
        context: context,
        tittle: "Error al en Activos.registros . . .",
        message: "ERROR - $error : $stackTrace"));
  }

  // OPERACIONALES *************** * * * *  ** *********
  String appBarTitile = "Gestión de Activos";
  String? consultIdQuery = Activos.activos['consultIdQuery'];
  String? registerQuery = Activos.activos['registerQuery'];
  String? updateQuery = Activos.activos['updateQuery'];

  int idOperation = 0;

  List<dynamic>? listOfValues;
  // VARIABLES *************** * * * *  ** *********
  String? stringImage = '';
  var conceptoRecursoTextController = TextEditingController();
  var tipoRecursoTextController = TextEditingController();
  var cuentaAsignadaTextController = TextEditingController();
  var fechaProgramadaTextController = TextEditingController();
  var intervaloProgramadoTextController = TextEditingController();
  var montoProgramadoTextController = TextEditingController();
  var descripcionTextController = TextEditingController();
  var interesAcordadoTextController = TextEditingController();
  var montoRestanteTextController = TextEditingController();
  var montoPagadoTextController = TextEditingController();
  var estadoActualTextController = TextEditingController();
  var fechaProximoTextController = TextEditingController();
  var fechaBajaTextController = TextEditingController();
  //
  var activosScroller = ScrollController();
  var carouselController = CarouselController();
}

class GestionActivos extends StatefulWidget {
  Widget? actualSidePage;

  bool? reverse, esActualized;
  // ****************** *** ****** **************
  GestionActivos(
      {Key? key,
      this.reverse = false,
      this.actualSidePage,
      this.esActualized = true})
      : super(key: key);

  @override
  State<GestionActivos> createState() => _GestionActivosState();
}

class _GestionActivosState extends State<GestionActivos> {

  @override
  void initState() {
    Activos.fileAssocieted = '${Financieros.localRepositoryPath}activos.json';
    // ****************************************** * *** ******* *** *
    if (widget.esActualized!) {
      Actividades.detalles(Databases.siteground_database_regfine,
              Activos.activos['activosStadistics'])
          .then((value) {
        // *************************************** * *** ******* *** *
        Terminal.printSuccess(
            message:
                "Actualizando repositorio de Activos y Estadisticas . . . ");
        // *************************************** * *** ******* *** *
        Archivos.createJsonFromMap([value], filePath: Activos.fileStadistics);
      }).whenComplete(() => iniciar());
    } else {
      iniciar();
    }
    super.initState();
  }
  // @override
  // void initState() {
  //   if (widget.esActualized!) {
  //     if (widget.reverse!) {
  //       reiniciar(withStats: false);
  //     } else {
  //       Operadores.loadingActivity(
  //           context: context,
  //           tittle: "Registrado Información",
  //           message: "Registrando información . . . ");
  //       reiniciar(withStats: true);
  //     }
  //   } else {
  //     if (widget.reverse!) {
  //       iniciar();
  //     } else {
  //       reiniciar(withStats: false);
  //     }
  //   }
  //   super.initState();
  // }

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
            GrandIcon(
              labelButton: 'Todo',
              iconData: Icons.all_out,
              onPress: () {
                _pullListRefresh();
              },
              onLongPress: () {
                _pullListRefresh(reload: true);
              },
            ),
            CrossLine(
              isHorizontal: false,
              thickness: 3,
            ),
            IconButton(
              icon: const Icon(
                Icons.waterfall_chart,
              ),
              tooltip: 'Estadísticas de los Activos . . . ',
              onPressed: () {
                if (isMobile(context)) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const EstadisticasActivos()));
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => GestionActivos(
                            actualSidePage: const EstadisticasActivos(),
                          )));
                }
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: GrandButton(
                          weigth: 1000,
                          labelButton: "Por Fecha",
                          onPress: () {
                            reiniciar(withStats: false);
                            Operadores.selectOptionsActivity(
                                context: context,
                                options: Listas.listWithoutRepitedValues(
                                    Listas.listFromMapWithOneKey(foundedItems!,
                                        keySearched: 'Fecha_Pago_Programado')),
                                onClose: (value) {
                                  Navigator.of(context).pop();
                                  Terminal.printSuccess(message: "$value");
                                  _runFilterSearch(
                                      enteredKeyword: value,
                                      keySearched: 'Fecha_Pago_Programado');
                                });
                          },
                        )),
                    Expanded(
                        child: GrandIcon(
                      iconData: Icons.select_all,
                      labelButton: 'Saldado',
                      onPress: () {
                        _runActiveSearch(
                            enteredKeyword: 'Saldado',
                            keySearched: 'Estado_Actual');
                      },
                    )),
                    Expanded(
                        child: GrandIcon(
                      labelButton: 'Vigente',
                      iconData: Icons.video_label,
                      onPress: () {
                        _runActiveSearch(
                            enteredKeyword: 'Vigente',
                            keySearched: 'Estado_Actual');
                      },
                    )),
                    // Expanded(child: CrossLine(isHorizontal: false, thickness: 6, color: Colors.grey,)),
                    Expanded(
                        child: GrandIcon(
                      labelButton: 'Al Final . . . ',
                      iconData: Icons.invert_colors_on,
                      onPress: () {
                        setState(() {
                          if (widget.reverse == true) {
                            widget.reverse = false;
                            gestionScrollController.jumpTo(
                                gestionScrollController
                                    .position.minScrollExtent);
                          } else {
                            widget.reverse = true;
                            gestionScrollController.jumpTo(
                                gestionScrollController
                                    .position.maxScrollExtent);
                          }
                        });
                      },
                    )),
                  ],
                ),
                Expanded(
                  flex: 9,
                  child: Row(
                    children: [
                      Expanded(
                        flex: isDesktop(context) ? 8 : 4,
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
                                      reverse: widget.reverse!,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const CircularProgressIndicator(),
                                          const SizedBox(height: 50),
                                          Text(
                                            snapshot.hasError
                                                ? snapshot.error.toString()
                                                : snapshot.error.toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                        margin: const EdgeInsets.only(left: 8.0),
                        decoration: ContainerDecoration.roundedDecoration(),
                        child: Column(
                          children: [
                            Expanded(
                                child: GrandIcon(
                              iconData: Icons.move_up_outlined,
                              labelButton: 'Al principio . . .',
                              onPress: () {
                                setState(() {
                                  gestionScrollController.jumpTo(
                                      gestionScrollController
                                          .position.minScrollExtent);
                                });
                              },
                            )),
                            CrossLine(),
                            Expanded(
                                child: GrandIcon(
                              iconData: Icons.insights,
                              labelButton: 'Ingresos',
                              onPress: () {
                                _runActiveSearch(enteredKeyword: 'Ingresos');
                              },
                            )),
                            Expanded(
                                child: GrandIcon(
                              labelButton: 'Egresos',
                              iconData: Icons.leaderboard_sharp,
                              onPress: () {
                                _runActiveSearch(enteredKeyword: 'Egresos');
                              },
                            )),
                            Expanded(
                                child: GrandIcon(
                              labelButton: 'Activos',
                              iconData: Icons.ac_unit,
                              onPress: () {
                                _runActiveSearch(enteredKeyword: 'Activos');
                              },
                            )),
                            Expanded(
                                child: GrandIcon(
                              iconData: Icons.pages_sharp,
                              labelButton: 'Pasivos',
                              onPress: () {
                                _runActiveSearch(enteredKeyword: 'Pasivos');
                              },
                            )),
                            Expanded(
                                child: GrandIcon(
                              labelButton: 'Patrimonio',
                              iconData: Icons.hdr_weak_sharp,
                              onPress: () {
                                _runActiveSearch(enteredKeyword: 'Patrimonio');
                              },
                            )),
                            Expanded(
                                child: GrandIcon(
                              labelButton: 'Todo',
                              iconData: Icons.all_out,
                              onPress: () {
                                _pullListRefresh();
                              },
                            )),
                            CrossLine(),
                            Expanded(
                                child: GrandIcon(
                              iconData: Icons.move_down_outlined,
                              labelButton: 'Al final . . .',
                              onPress: () {
                                setState(() {
                                  gestionScrollController.jumpTo(
                                      gestionScrollController
                                          .position.maxScrollExtent);
                                });
                              },
                            )),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        isDesktop(context) || isTablet(context)
            ? Expanded(flex: 1, child: widget.actualSidePage!)
            : Container()
      ]),
    );
  }

  // OPERACIONES DE LA INTERFAZ ****************** ******** * * * *
  void iniciar() {
    Terminal.printAlert(
        message:
            "INICIAR : Iniciando Actividad - Repositorio de Activos y Valores  \n"
            ": : : ${Activos.fileAssocieted}");
    Archivos.readJsonToMap(filePath: Activos.fileAssocieted).then((value) {
      setState(() {
        foundedItems = value;
      });
    }).onError((error, stackTrace) {
      Terminal.printOther(message: "ERROR - $error :  $stackTrace");
      reiniciar();
    });
  }

  void reiniciar({bool withStats = false}) {
    Operadores.loadingActivity(
        context: context,
        tittle: "Consultando Información",
        message: "Consultando información . . . ");
    Terminal.printOther(
        message: "REINICIAR : Iniciando actividad : : \n "
            "\tConsulta de Activos del Usuario . . .");
    // **************************************************************************
    Activos.registros().whenComplete(() {
      setState(() {
        Navigator.pop(context);
        foundedItems = Financieros.Activos;
      });
    })
        // **************************************************************************
        .onError((error, stackTrace) {
      Terminal.printAlert(
          message:
              ": : : Error al Conectar con la Base de Datos - $error : : $stackTrace");
      // **************************************************************************
      Operadores.alertActivity(
        context: context,
        tittle: "Error al Conectar con la Base de Datos",
        message: "ERROR - $error : : $stackTrace",
        onAcept: () {
          Navigator.pop(context);
        },
      );
    });
    // *****************************************************************
    // if (withStats) {
    //   Actividades.detalles(Databases.siteground_database_regfine,
    //           Activos.activos['activosStadistics'])
    //       .then((value) {
    //     Terminal.printSuccess(
    //         message:
    //             "Actualizando repositorio de Activos y Estadisticas . . . ");
    //     Archivos.createJsonFromMap([value], filePath: Activos.fileStadistics);
    //     //
    //     if (widget.esActualized!) {
    //       Actividades.consultarAllById(Databases.siteground_database_regfine,
    //               consultQuery!, Financieros.ID_Financieros)
    //           .then((value) {
    //         Archivos.createJsonFromMap(value, filePath: Activos.fileAssocieted);
    //         setState(() {
    //           foundedItems = value;
    //         });
    //       }).onError((error, stackTrace) {
    //         Operadores.alertActivity(
    //             context: context,
    //             tittle: "Error al Conectar con la Base de Datos",
    //             message: "ERROR - $error : : $stackTrace");
    //       });
    //     } else {
    //       setState(() {
    //         foundedItems = Financieros.Activos;
    //       });
    //     }
    //   });
    // } else {
    //   Actividades.consultarAllById(Databases.siteground_database_regfine,
    //           consultQuery!, Financieros.ID_Financieros)
    //       .then((value) {
    //     Terminal.printSuccess(message: "Value : : $value : REINICIAR ");
    //     Archivos.createJsonFromMap(value, filePath: Activos.fileAssocieted);
    //     Terminal.printSuccess(
    //         message: "Actualizando repositorio de Activos . . . ");
    //     setState(() {
    //       foundedItems = value;
    //     });
    //   }).whenComplete(() {
    //     iniciar();
    //   }).onError((error, stackTrace) {
    //     Operadores.alertActivity(
    //         context: context,
    //         tittle: "Error al Conectar con la Base de Datos",
    //         message: "ERROR - $error : : $stackTrace");
    //   });
    // }
  }

  // .whenComplete(() => Operadores.alertActivity(
  //     context: context,
  //     tittle: "Datos Recargados",
  //     message: "Registro Actualizado",
  //     onAcept: () {
  //       Navigator.of(context).push(
  //         MaterialPageRoute(
  //           builder: (BuildContext context) => GestionActivos(
  //             actualSidePage: const EstadisticasActivos(),
  //           ),
  //         ),
  //       );
  //     }));
  void deleteRegister(
      AsyncSnapshot<dynamic> snapshot, int posicion, BuildContext context) {
    try {
      Actividades.eliminar(
          Databases.siteground_database_regfine,
          Activos.activos['deleteQuery'],
          snapshot.data[posicion]['ID_Registro']);
      setState(() {
        snapshot.data.removeAt(posicion);
      });
    } catch (e) {
      Operadores.alertActivity(
          context: context,
          tittle: "Error al Eliminar Registro . . .",
          message: "ERROR - $e",
          onClose: () {
            Navigator.pop(context);
          },
          onAcept: () {
            Navigator.pop(context);
          });
    } finally {
      Navigator.of(context).pop();
    }
  }

  void toOperaciones(BuildContext context, String operationActivity) {
    if (isMobile(context)) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => OperacionesActivos(
                operationActivity: operationActivity,
              )));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => GestionActivos(
                esActualized: false,
                actualSidePage: OperacionesActivos(
                  operationActivity: operationActivity,
                ),
              )));
    }
  }

  GestureDetector itemListView(
      AsyncSnapshot snapshot, int posicion, BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelected(snapshot, posicion, context, Constantes.Update);
      },
      child: Container(
        decoration: ContainerDecoration.roundedDecoration(),
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  CircleLabel(
                    radios: 30,
                    tittle: snapshot.data[posicion]['ID_Registro'].toString(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CircleIcon(
                      tittle: "${snapshot.data[posicion]['Tipo_Recurso']}",
                      iconed: snapshot.data[posicion]['Tipo_Recurso'] ==
                              'Ingresos'
                          ? Icons.insights
                          : snapshot.data[posicion]['Tipo_Recurso'] == 'Egresos'
                              ? Icons.leaderboard_sharp
                              : snapshot.data[posicion]['Tipo_Recurso'] ==
                                      'Activos'
                                  ? Icons.ac_unit
                                  : snapshot.data[posicion]['Tipo_Recurso'] ==
                                          'Pasivos'
                                      ? Icons.pages_sharp
                                      : snapshot.data[posicion]
                                                  ['Tipo_Recurso'] ==
                                              'Patrimonio'
                                          ? Icons.hdr_weak_sharp
                                          : Icons.all_out),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  TittlePanel(
                    textPanel:
                        "${snapshot.data[posicion]['Fecha_Pago_Programado']}",
                  ),
                  Text(
                    "${snapshot.data[posicion]['Estado_Actual']}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 14),
                  ),
                  Text(
                    "\u0024 ${double.parse(snapshot.data[posicion]['Monto_Pagado'].toString()).toStringAsFixed(2)}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: snapshot.data[posicion]['Tipo_Recurso'] ==
                                'Ingresos'
                            ? Colors.green
                            : snapshot.data[posicion]['Tipo_Recurso'] ==
                                    'Egresos'
                                ? Colors.red
                                : snapshot.data[posicion]['Tipo_Recurso'] ==
                                        'Activos'
                                    ? Colors.yellow
                                    : snapshot.data[posicion]['Tipo_Recurso'] ==
                                            'Pasivos'
                                        ? Colors.purple
                                        : snapshot.data[posicion]
                                                    ['Tipo_Recurso'] ==
                                                'Patrimonio'
                                            ? Colors.blue
                                            : Colors.white,
                        fontSize: 14),
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                  ),
                  Row(
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
                                  },
                                );
                              });
                        },
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
    // **************************************************************
    Activos.Activo = snapshot.data[posicion];
    Financieros.Activos = snapshot.data;
    // **************************************************************
    Activos.ID_Financieros = snapshot.data[posicion]['ID_Registro'];
    // **************************************************************
    Operadores.loadingActivity(
        context: context,
        tittle: "Consultando Información",
        message:
            "Consultando información del Registro #${Activos.ID_Financieros} . . . ");
// **************************************************************
    Activos.getImage().then((value) {
      Activos.imagenActivo = value['Fine_IMG'];
      // **************************************************************
      Terminal.printSuccess(message: "Imagen :  ${Activos.imagenActivo}");
      Navigator.pop(context);
      // **************************************************************
      toOperaciones(context, operaciones);
    })
        // .whenComplete(() => toOperaciones(context, operaciones))
        .onError((error, stackTrace) {
      Operadores.notifyActivity(
          context: context,
          tittle: "Error - No Se pudo Consultar Imagen",
          message: "ERROR - $error : $stackTrace",
          onAcept: () {
            toOperaciones(context, operaciones);
          },
          onClose: () {
            Navigator.pop(context);
          });

      Terminal.printAlert(message: "ERROR - $error : $stackTrace");
    });
    //
  }

  void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  // ACTIVIDADES DE BÚSQUEDA ************ ********** ***** * ** *
  Future<Null> _pullListRefresh({bool reload = false}) async {
    if (reload) {
      Operadores.loadingActivity(
          context: context,
          tittle: "Registrado Información",
          message: "Registrando información . . . ");
      reiniciar(withStats: true);
    } else {
      iniciar();
    }
  }

  void _runFilterSearch(
      {required String enteredKeyword, String keySearched = 'Tipo_Recurso'}) {
    List? results = [];

    if (enteredKeyword.isEmpty) {
      _pullListRefresh();
    } else {
      results = Listas.listFromMap(
          lista: foundedItems!,
          keySearched: keySearched,
          elementSearched: enteredKeyword);

      setState(() {
        foundedItems = results;
      });
    }
  }

  void _runActiveSearch(
      {required String enteredKeyword, String keySearched = 'Tipo_Recurso'}) {
    Terminal.printWarning(
        message: " . . . Iniciando Actividad - Activos del Usuario");
    Archivos.readJsonToMap(filePath: Activos.fileAssocieted).then((value) {
      setState(() {
        foundedItems = value;
      });
    }).onError((error, stackTrace) {
      reiniciar();
    }).whenComplete(() {
      Terminal.printWarning(message: " . . . Actividad Iniciada");
      List? results = [];

      if (enteredKeyword.isEmpty) {
        _pullListRefresh();
      } else {
        results = Listas.listFromMap(
            lista: foundedItems!,
            keySearched: keySearched,
            elementSearched: Sentences.capitalize(enteredKeyword));

        // Terminal.printNotice(message: " . . . ${results.length} Pacientes Encontrados".toUpperCase());
        setState(() {
          foundedItems = results;
        });
      }
    });
  }

  // VARIABLES ************************************************
  String appTittle = "Gestion de Activos del Usuario";
  String searchCriteria = "Buscar por Fecha";
  String? consultQuery = Activos.activos['consultIdQuery'];

  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();
}
