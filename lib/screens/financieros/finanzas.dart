import 'dart:convert';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Financieros.dart';

import 'package:assistant/screens/financieros/estadisticas.dart';
import 'package:assistant/screens/home.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';

import 'package:assistant/widgets/AppBarText.dart';
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
import 'package:data_table_2/data_table_2.dart';
import 'package:fl_chart/fl_chart.dart';

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
class operacionesActivos extends StatefulWidget {
  late String? operationActivity;
  late String _operationButton = 'Nulo';
  Uint8List? fileBytes;

  operacionesActivos({super.key, this.operationActivity = Constantes.Nulo});

  @override
  State<operacionesActivos> createState() => _operacionesActivosState();
}

class _operacionesActivosState extends State<operacionesActivos> {
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
    var progress;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: isMobile(context)
          ? AppBar(
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
                                  onChangeValue: () {},
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
                          keyBoardType: TextInputType.datetime,
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
                                  onChangeValue: () {},
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
                        flex: 10,
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          margin: const EdgeInsets.all(15.0),
                          decoration: ContainerDecoration.roundedDecoration(
                              colorBackground: Colors.grey),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 4,
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
                                        value: progress == null
                                            ? null
                                            : progress.cumulativeBytesLoaded /
                                                progress.expectedTotalBytes!,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CircleIcon(
                                      iconed: Icons.file_copy_rounded,
                                      tittle: 'Cargar desde Dispositivo',
                                      onChangeValue: () async {
                                        widget.fileBytes = await Directorios
                                            .choiseFromDirectory();
                                        setState(() {
                                          stringImage =
                                              base64Encode(widget.fileBytes!);
                                        });
                                      }),
                                  GrandIcon(
                                    iconColor: Colors.black,
                                    iconData: Icons.new_releases_outlined,
                                    labelButton: 'Recargar . . . ',
                                    onPress: () {
                                      setState(() {
                                        stringImage = Activos.imagenActivo;
                                      });
                                    },
                                  ),
                                  CircleIcon(
                                      iconed: Icons.camera_alt_outlined,
                                      tittle: 'Cargar desde Cámara',
                                      onChangeValue: () async {
                                        widget.fileBytes = await Directorios
                                            .choiseFromCamara();
                                        setState(() {
                                          stringImage =
                                              base64Encode(widget.fileBytes!);
                                        });
                                      }),
                                ],
                              ))
                            ],
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
              .then((value) => Operadores.alertActivity(
                  context: context,
                  tittle: "Registro de Información . . . ",
                  message: "$value",
                  onAcept: () => Navigator.of(context).pop()))
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
              .then((value) => Operadores.alertActivity(
                  context: context,
                  tittle: "Actualización de Información . . . ",
                  message: "$value",
                  onAcept: () => Navigator.of(context).pop()))
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
  var carouselController = CarouselSliderController();
}

class GestionActivos extends StatefulWidget {
  Widget? actualSidePage;
  late List registros;

  late bool? reverse, esActualized;
// ****************** *** ****** **************
  GestionActivos(
      {super.key,
      this.reverse = false,
      this.actualSidePage,
      required this.esActualized});

  @override
  State<GestionActivos> createState() => _GestionActivosState();
}

class _GestionActivosState extends State<GestionActivos> {
  bool cargando = true;
  // List<Map<String, dynamic>> registros = [];

  @override
  void initState() {
    super.initState();

    _cargarRegistros();
  }

  Future<void> _cargarRegistros() async {
    final data = await FinancierosRepo().cargarDesdeLocal();
    if (mounted) {
      setState(() {
        widget.registros = data; // List<Map<String, dynamic>>.from(data);
        cargando = false;
      });
    }
  }

  void _refrescar() async {
    await FinancierosRepo()
        .reiniciar(remoto: true)
        .onError((error, stackTrace) {
      Terminal.printAlert(
          message:
              ": : : Error al Conectar con la Base de Datos - $error : : $stackTrace");
    });
    await _cargarRegistros();
  }

  @override
  Widget build(BuildContext context) {
    if (cargando) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          foregroundColor: Colors.grey,
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
                            esActualized: false,
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
          flex:
              isDesktop(context) || isTablet(context) || isLargeDesktop(context)
                  ? 2
                  : 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                    child: GraficaFinanciera(
                        registros: widget.registros, esActualizado: false)),
                isLargeDesktop(context)
                    ? Expanded(
                        child: ListaFinanciera(registros: widget.registros))
                    : Expanded(
                        child: TablaFinanciera(
                            registros: widget.registros,
                            esActualizado: widget.esActualized!)),
                // Expanded(
                //   flex: 1,
                //   child: FutureBuilder(
                //     future: FinancierosRepo().cargarDesdeLocal(),
                //     builder: (context, snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return const Center(child: CircularProgressIndicator());
                //       }
                //       if (snapshot.hasError) {
                //         return Center(
                //             child: Text(
                //                 'Error al cargar datos: ${snapshot.error}'));
                //       }
                //
                //       widget.registros = FinancierosRepo().registros;
                //       if (widget.registros.isEmpty) {
                //         return const Center(
                //             child: Text('Sin registros disponibles'));
                //       }
                //
                //       return GraficaFinanciera(registros: widget.registros, esActualizado: false);
                //     },
                //   ),
                // ),
                // // Row(
                // //   children: [
                // //     Expanded(
                // //         flex: 4,
                // //         child: GrandButton(
                // //           weigth: 1000,
                // //           labelButton: "Por Fecha",
                // //           onPress: () {
                // //             reiniciar(withStats: false);
                // //             Operadores.selectOptionsActivity(
                // //                 context: context,
                // //                 options: Listas.listWithoutRepitedValues(
                // //                     Listas.listFromMapWithOneKey(foundedItems!,
                // //                         keySearched: 'Fecha_Pago_Programado')),
                // //                 onClose: (value) {
                // //                   Navigator.of(context).pop();
                // //                   Terminal.printSuccess(message: value);
                // //                   _runFilterSearch(
                // //                       enteredKeyword: value,
                // //                       keySearched: 'Fecha_Pago_Programado');
                // //                 });
                // //           },
                // //         )),
                // //     Expanded(
                // //         child: GrandIcon(
                // //       iconData: Icons.select_all,
                // //       labelButton: 'Saldado',
                // //       onPress: () {
                // //         _runActiveSearch(
                // //             enteredKeyword: 'Saldado',
                // //             keySearched: 'Estado_Actual');
                // //       },
                // //     )),
                // //     Expanded(
                // //         child: GrandIcon(
                // //       labelButton: 'Vigente',
                // //       iconData: Icons.video_label,
                // //       onPress: () {
                // //         _runActiveSearch(
                // //             enteredKeyword: 'Vigente',
                // //             keySearched: 'Estado_Actual');
                // //       },
                // //     )),
                // //     // Expanded(child: CrossLine(isHorizontal: false, thickness: 6, color: Colors.grey,)),
                // //     Expanded(
                // //         child: GrandIcon(
                // //       labelButton: 'Al Final . . . ',
                // //       iconData: Icons.invert_colors_on,
                // //       onPress: () {
                // //         setState(() {
                // //           if (widget.reverse == true) {
                // //             widget.reverse = false;
                // //             gestionScrollController.jumpTo(
                // //                 gestionScrollController
                // //                     .position.minScrollExtent);
                // //           } else {
                // //             widget.reverse = true;
                // //             gestionScrollController.jumpTo(
                // //                 gestionScrollController
                // //                     .position.maxScrollExtent);
                // //           }
                // //         });
                // //       },
                // //     )),
                // //   ],
                // // ),
                // // ##############################################################
                // Expanded(
                //   flex: 1,
                //   child: FutureBuilder(
                //     future: FinancierosRepo().cargarDesdeLocal(),
                //     builder: (context, snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return const Center(child: CircularProgressIndicator());
                //       }
                //       if (snapshot.hasError) {
                //         return Center(
                //             child: Text(
                //                 'Error al cargar datos: ${snapshot.error}'));
                //       }
                //
                //       widget.registros = FinancierosRepo().registros;
                //       if (widget.registros.isEmpty) {
                //         return const Center(
                //             child: Text('Sin registros disponibles'));
                //       }
                //
                //       if (isLargeDesktop(context)) {
                //         return ListaFinanciera(registros: widget.registros);
                //       } else {
                //         return TablaFinanciera(registros: widget.registros, esActualizado: widget.esActualized!);
                //       }
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
        isDesktop(context) || isTablet(context) || isLargeDesktop(context)
            ? Expanded(flex: 1, child: widget.actualSidePage!)
            : Container()
      ]),
    );
  }

  // OPERACIONES DE LA INTERFAZ ****************** ******** * * * *

  //
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
          builder: (BuildContext context) => operacionesActivos(
                operationActivity: operationActivity,
              )));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => GestionActivos(
                esActualized: false,
                actualSidePage: operacionesActivos(
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
        padding: const EdgeInsets.all(17.0),
        margin: EdgeInsets.all(6.0),
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
                                    : snapshot.data[posicion]['Tipo_Recurso'] ==
                                            'Patrimonio'
                                        ? Icons.hdr_weak_sharp
                                        : Icons.all_out,
                    onChangeValue: () {},
                  ),
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
      _refrescar();
    } else {
      _cargarRegistros();
    }
  }

  // VARIABLES ************************************************
  String appTittle = "Gestion de Activos del Usuario";
  String searchCriteria = "Buscar por Fecha";
  String? consultQuery = Activos.activos['consultIdQuery'];

  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();
}

// #########################################################
class TablaFinanciera extends StatefulWidget {
  late List registros;
  late bool esActualizado;

  TablaFinanciera({
    super.key,
    required this.registros,
    required this.esActualizado,
  });

  @override
  State<TablaFinanciera> createState() => _TablaFinancieraState();
}

class _TablaFinancieraState extends State<TablaFinanciera> {
  String filtroTipo = 'Todos';
  String filtroTexto = '';
  DateTime? fechaInicio;
  DateTime? fechaFin;
  bool cargando = true;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.esActualizado) {
  //     _cargarDatos();
  //   }
  // }
  //
  // Future<void> _cargarDatos() async {
  //   try {
  //     await FinancierosRepo().cargarDesdeLocal();
  //     setState(() {
  //       widget.registros = FinancierosRepo().registros;
  //       cargando = false;
  //     });
  //   } catch (e, s) {
  //     Terminal.printAlert(message: '❌ Error al cargar registros: $e\n$s');
  //     setState(() => cargando = false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (cargando) {
      return const Center(child: CircularProgressIndicator());
    }

    final filtrados = widget.registros.where((e) {
      final tipo = (e['Tipo_Recurso'] ?? '').toString().toLowerCase();
      final fechaStr = e['Fecha_Pago_Programado']?.toString() ?? '';
      final desc = (e['Concepto_Recurso'] ?? '').toString().toLowerCase();

      DateTime? fecha;
      try {
        fecha = DateTime.tryParse(fechaStr);
      } catch (_) {
        fecha = null;
      }

      final coincideTipo =
          filtroTipo == 'Todos' || tipo == filtroTipo.toLowerCase();
      final coincideTexto =
          filtroTexto.isEmpty || desc.contains(filtroTexto.toLowerCase());
      final coincideFecha = (fechaInicio == null && fechaFin == null) ||
          (fecha != null &&
              (fechaInicio == null || fecha.isAfter(fechaInicio!)) &&
              (fechaFin == null || fecha.isBefore(fechaFin!)));

      return coincideTipo && coincideTexto && coincideFecha;
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildFiltros(context),
          const SizedBox(height: 8),
          Expanded(
            child: DataTable2(
              columnSpacing: 10,
              horizontalMargin: 12,
              dividerThickness: 0.5,
              headingRowColor:
                  MaterialStateProperty.all(Colors.blueGrey.shade900),
              dataRowColor: MaterialStateProperty.all(Colors.grey.shade900),
              columns: const [
                DataColumn(
                    label: Text('Fecha',
                        style: TextStyle(color: Colors.white, fontSize: 13))),
                DataColumn(
                    label: Text('Tipo',
                        style: TextStyle(color: Colors.white, fontSize: 13))),
                DataColumn(
                    label: Text('Categoría',
                        style: TextStyle(color: Colors.white, fontSize: 13))),
                DataColumn(
                    label: Text('Monto',
                        style: TextStyle(color: Colors.white, fontSize: 13))),
                DataColumn(
                    label: Text('Acciones',
                        style: TextStyle(color: Colors.white, fontSize: 13))),
              ],
              rows: filtrados.map((item) {
                final tipo = (item['Tipo_Recurso'] ?? '').toString();
                final monto =
                    double.tryParse(item['Monto_Pagado'].toString()) ?? 0;
                final color = _colorPorTipo(tipo);

                return DataRow(cells: [
                  DataCell(Text(item['Fecha_Pago_Programado'] ?? '',
                      style: const TextStyle(color: Colors.white70))),
                  DataCell(
                      Text(tipo, style: const TextStyle(color: Colors.white))),
                  DataCell(Text(item['Concepto_Recurso'] ?? '',
                      style: const TextStyle(color: Colors.white70))),
                  DataCell(Text("\$${monto.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: color, fontWeight: FontWeight.bold))),
                  DataCell(Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.amber),
                          onPressed: () => _editar(item, context),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon:
                              const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => _borrar(item, context),
                        ),
                      ),
                    ],
                  )),
                ]);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // 🎨 Colores según tipo
  Color _colorPorTipo(String tipo) {
    final normalized = tipo.toLowerCase().trim();
    if (normalized.startsWith('ingreso')) return Colors.greenAccent;
    if (normalized.startsWith('egreso')) return Colors.redAccent;
    if (normalized.startsWith('activo')) return Colors.yellowAccent;
    if (normalized.startsWith('pasivo')) return Colors.lightBlueAccent;
    return Colors.white70;
  }

  // 🧭 Filtros superiores
  Widget _buildFiltros(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: 8,
          runSpacing: 8,
          children: [
            DropdownButton<String>(
              dropdownColor: Colors.grey.shade900,
              style: const TextStyle(color: Colors.white),
              value: filtroTipo,
              items: const [
                'Todos',
                'Ingresos',
                'Egresos',
                'Activos',
                'Pasivos'
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => filtroTipo = v!),
            ),
            _botonFecha(context, true),
            _botonFecha(context, false),
            SizedBox(
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Buscar categoría...',
                  labelStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.search, color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (t) => setState(() => filtroTexto = t),
              ),
            ),
          ],
        ),
      );

  Widget _botonFecha(BuildContext context, bool esInicio) {
    final fecha = esInicio ? fechaInicio : fechaFin;
    final label = esInicio ? "Desde" : "Hasta";
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey.shade800,
      ),
      icon: const Icon(Icons.date_range, size: 16),
      label: Text(
        fecha == null ? label : "$label: ${fecha.toString().split(' ')[0]}",
        style: const TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        final seleccion = await showDatePicker(
          context: context,
          initialDate: fecha ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Colors.blueAccent,
                onPrimary: Colors.white,
                surface: Colors.black,
                onSurface: Colors.white,
              ),
            ),
            child: child!,
          ),
        );
        if (seleccion != null) {
          setState(() {
            if (esInicio) {
              fechaInicio = seleccion;
            } else {
              fechaFin = seleccion;
            }
          });
        }
      },
    );
  }

  // ✏️ EDITAR → ejecuta flujo GestoresActivos.onSelected()

  void _editar(Map<String, dynamic> item, BuildContext context) {
    try {
      final int posicion = widget.registros.indexOf(item);

      // Asigna el activo actual y la lista completa
      Activos.Activo = widget.registros[posicion];
      Financieros.Activos = widget.registros;
      Activos.ID_Financieros = item['ID_Registro'];

      // Muestra indicador de carga
      Operadores.loadingActivity(
        context: context,
        tittle: "Consultando Información",
        message:
            "Consultando información del Registro #${Activos.ID_Financieros} . . . ",
      );

      // Obtiene la imagen asociada y continúa
      Activos.getImage().then((value) {
        Activos.imagenActivo = value['Fine_IMG'];

        Terminal.printSuccess(message: "Imagen : ${Activos.imagenActivo}");

        Navigator.pop(context); // Cierra el diálogo de carga

        // Abre la vista correspondiente
        toOperaciones(context, Constantes.Update);
      }).onError((error, stackTrace) {
        Operadores.notifyActivity(
          context: context,
          tittle: "Error - No Se pudo Consultar Imagen",
          message: "ERROR - $error : $stackTrace",
          onAcept: () => Navigator.pop(context),
          onClose: () => Navigator.pop(context),
        );

        Terminal.printAlert(message: "ERROR - $error : $stackTrace");
      });
    } catch (e, s) {
      Terminal.printAlert(message: "❌ Error al editar: $e\n$s");
    }
  }

  // 🗑 BORRAR → ejecuta flujo GestoresActivos.deleteRegister()
  void _borrar(Map<String, dynamic> item, BuildContext context) {
    try {
      Actividades.eliminar(Databases.siteground_database_regfine,
          Activos.activos['deleteQuery'], item['ID_Registro']);
      setState(() {
        widget.registros.remove(item);
      });
      Terminal.printWarning(
          message: "🗑 Registro eliminado: ${item['Concepto_Recurso']}");
    } catch (e) {
      Operadores.alertActivity(
        context: context,
        tittle: "Error al Eliminar Registro . . .",
        message: "ERROR - $e",
        onClose: () => Navigator.pop(context),
        onAcept: () => Navigator.pop(context),
      );
    }
  }

  // try {
  //   Actividades.eliminar(Databases.siteground_database_regfine,
  //       Activos.activos['deleteQuery'], item['ID_Registro']);
  //   setState(() {
  //     widget.registros.remove(item);
  //   });
  //   Terminal.printWarning(
  //       message: "🗑 Registro eliminado: ${item['Concepto_Recurso']}");
  // } catch (e) {
  //   Operadores.alertActivity(
  //     context: context,
  //     tittle: "Error al Eliminar Registro . . .",
  //     message: "ERROR - $e",
  //     onClose: () => Navigator.pop(context),
  //     onAcept: () => Navigator.pop(context),
  //   );
  // } finally {
  //   Navigator.of(context).pop();
  // }

  void toOperaciones(BuildContext context, String operationActivity) {
    if (isMobile(context)) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => operacionesActivos(
                operationActivity: operationActivity,
              )));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => GestionActivos(
                esActualized: false,
                actualSidePage: operacionesActivos(
                  operationActivity: operationActivity,
                ),
              )));
    }
  }
}

// #########################################################
class ListaFinanciera extends StatefulWidget {
  late List registros;
  late bool? reverse = false;

  ListaFinanciera({super.key, required this.registros});

  @override
  State<ListaFinanciera> createState() => _ListaFinancieraState();
}

class _ListaFinancieraState extends State<ListaFinanciera> {
  String filtroTipo = 'Todos';
  String filtroTexto = '';
  DateTime? fechaInicio;
  DateTime? fechaFin;
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    try {
      await FinancierosRepo().cargarDesdeLocal();
      setState(() {
        widget.registros = FinancierosRepo().registros;
        cargando = false;
      });
    } catch (e, s) {
      Terminal.printAlert(message: '❌ Error al cargar registros: $e\n$s');
      setState(() => cargando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cargando) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // 📋 PANEL PRINCIPAL DE REGISTROS
          Expanded(
            flex: isDesktop(context) || isLargeDesktop(context) ? 8 : 4,
            child: Column(
              children: [
                // 🔍 FILTROS SUPERIORES
                _buildFiltrosCompactos(context),

                // 🧾 LISTA DE ELEMENTOS
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(5.0),
                    reverse: widget.reverse!,
                    controller: gestionScrollController,
                    shrinkWrap: true,
                    itemCount: widget.registros.length,
                    itemBuilder: (context, posicion) {
                      final item = widget.registros[posicion];
                      final tipo = (item['Tipo_Recurso'] ?? '').toString();
                      final color = _colorPorTipo(tipo);
                      final fecha = item['Fecha_Pago_Programado'] ?? '';
                      final categoria = item['Concepto_Recurso'] ?? '';
                      final monto = item['Monto_Pagado']?.toString() ?? '0';

                      // Filtro activo
                      if (!_coincideFiltros(item))
                        return const SizedBox.shrink();

                      return Card(
                        color: Colors.grey.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: color.withOpacity(0.25),
                            child: Icon(
                              Icons.monetization_on,
                              color: color,
                            ),
                          ),
                          title: Text(
                            categoria,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            "$fecha — $tipo",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  "\$${monto.toString()}",
                                  style: TextStyle(
                                    color: color,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.amber, size: 20),
                                      onPressed: () => _editar(item, context),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.redAccent, size: 20),
                                      onPressed: () => _borrar(item, context),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // 📊 PANEL LATERAL DE ACCIONES RÁPIDAS
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              margin: const EdgeInsets.only(left: 8),
              decoration: ContainerDecoration.roundedDecoration(),
              child: Column(
                children: [
                  Expanded(
                    child: GrandIcon(
                      iconData: Icons.move_up_outlined,
                      labelButton: 'Al principio . . .',
                      onPress: () => gestionScrollController.jumpTo(
                        gestionScrollController.position.minScrollExtent,
                      ),
                    ),
                  ),
                  CrossLine(),
                  _buildQuickAction(
                      icon: Icons.insights,
                      label: 'Ingresos',
                      keyword: 'Ingresos'),
                  _buildQuickAction(
                      icon: Icons.leaderboard_sharp,
                      label: 'Egresos',
                      keyword: 'Egresos'),
                  _buildQuickAction(
                      icon: Icons.ac_unit,
                      label: 'Activos',
                      keyword: 'Activos'),
                  _buildQuickAction(
                      icon: Icons.pages_sharp,
                      label: 'Pasivos',
                      keyword: 'Pasivos'),
                  _buildQuickAction(
                      icon: Icons.hdr_weak_sharp,
                      label: 'Patrimonio',
                      keyword: 'Patrimonio'),
                  _buildQuickAction(
                      icon: Icons.all_out, label: 'Todo', keyword: ''),
                  CrossLine(),
                  Expanded(
                    child: GrandIcon(
                      iconData: Icons.move_down_outlined,
                      labelButton: 'Al final . . .',
                      onPress: () => gestionScrollController.jumpTo(
                        gestionScrollController.position.maxScrollExtent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltrosCompactos(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Wrap(
        spacing: 10,
        runSpacing: 6,
        alignment: WrapAlignment.spaceBetween,
        children: [
          DropdownButton<String>(
            dropdownColor: Colors.grey.shade900,
            style: const TextStyle(color: Colors.white),
            value: filtroTipo,
            items: const [
              'Todos',
              'Ingresos',
              'Egresos',
              'Activos',
              'Pasivos',
              'Patrimonio',
            ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => filtroTipo = v!),
          ),
          _botonFecha(context, true),
          _botonFecha(context, false),
          SizedBox(
            width: 180,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Buscar...',
                labelStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (t) => setState(() => filtroTexto = t),
            ),
          ),
        ],
      ),
    );
  }

  bool _coincideFiltros(Map<String, dynamic> e) {
    final tipo = (e['Tipo_Recurso'] ?? '').toString().toLowerCase();
    final desc = (e['Concepto_Recurso'] ?? '').toString().toLowerCase();
    final fechaStr = e['Fecha_Pago_Programado']?.toString() ?? '';
    DateTime? fecha = DateTime.tryParse(fechaStr);

    final coincideTipo =
        filtroTipo == 'Todos' || tipo == filtroTipo.toLowerCase();
    final coincideTexto =
        filtroTexto.isEmpty || desc.contains(filtroTexto.toLowerCase());
    final coincideFecha = (fechaInicio == null && fechaFin == null) ||
        (fecha != null &&
            (fechaInicio == null || !fecha.isBefore(fechaInicio!)) &&
            (fechaFin == null || !fecha.isAfter(fechaFin!)));

    return coincideTipo && coincideTexto && coincideFecha;
  }

  Widget _buildQuickAction(
      {required IconData icon,
      required String label,
      required String keyword}) {
    return Expanded(
      child: GrandIcon(
        iconData: icon,
        labelButton: label,
        onPress: () {
          setState(() {
            filtroTipo = keyword.isEmpty ? 'Todos' : keyword;
            // filtroTexto = keyword;
          });
        },
      ),
    );
  }

  Color _colorPorTipo(String tipo) {
    final normalized = tipo.toLowerCase().trim();
    if (normalized.startsWith('ingreso')) return Colors.greenAccent;
    if (normalized.startsWith('egreso')) return Colors.redAccent;
    if (normalized.startsWith('activo')) return Colors.yellowAccent;
    if (normalized.startsWith('pasivo')) return Colors.purple;
    if (normalized.startsWith('patrimonio')) return Colors.lightBlueAccent;
    return Colors.white70;
  }

  Widget _botonFecha(BuildContext context, bool esInicio) {
    final fecha = esInicio ? fechaInicio : fechaFin;
    final label = esInicio ? "Desde" : "Hasta";
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey.shade800,
      ),
      icon: const Icon(Icons.date_range, size: 16),
      label: Text(
        fecha == null ? label : "$label: ${fecha.toString().split(' ')[0]}",
        style: const TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        final seleccion = await showDatePicker(
          context: context,
          initialDate: fecha ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Colors.blueAccent,
                onPrimary: Colors.white,
                surface: Colors.black,
                onSurface: Colors.white,
              ),
            ),
            child: child!,
          ),
        );
        if (seleccion != null) {
          setState(() {
            if (esInicio) {
              fechaInicio = seleccion;
            } else {
              fechaFin = seleccion;
            }
          });
        }
      },
    );
  }

  // ✏️ EDITAR → ejecuta flujo GestoresActivos.onSelected()

  void _editar(Map<String, dynamic> item, BuildContext context) {
    try {
      final int posicion = widget.registros.indexOf(item);

      // Asigna el activo actual y la lista completa
      Activos.Activo = widget.registros[posicion];
      Financieros.Activos = widget.registros;
      Activos.ID_Financieros = item['ID_Registro'];

      // Muestra indicador de carga
      Operadores.loadingActivity(
        context: context,
        tittle: "Consultando Información",
        message:
            "Consultando información del Registro #${Activos.ID_Financieros} . . . ",
      );

      // Obtiene la imagen asociada y continúa
      Activos.getImage().then((value) {
        Activos.imagenActivo = value['Fine_IMG'];

        Terminal.printSuccess(message: "Imagen : ${Activos.imagenActivo}");

        Navigator.pop(context); // Cierra el diálogo de carga

        // Abre la vista correspondiente
        toOperaciones(context, Constantes.Update);
      }).onError((error, stackTrace) {
        Operadores.notifyActivity(
          context: context,
          tittle: "Error - No Se pudo Consultar Imagen",
          message: "ERROR - $error : $stackTrace",
          onAcept: () => Navigator.pop(context),
          onClose: () => Navigator.pop(context),
        );

        Terminal.printAlert(message: "ERROR - $error : $stackTrace");
      });
    } catch (e, s) {
      Terminal.printAlert(message: "❌ Error al editar: $e\n$s");
    }
  }

  // 🗑 BORRAR → ejecuta flujo GestoresActivos.deleteRegister()
  void _borrar(Map<String, dynamic> item, BuildContext context) {
    try {
      Actividades.eliminar(Databases.siteground_database_regfine,
          Activos.activos['deleteQuery'], item['ID_Registro']);
      setState(() {
        widget.registros.remove(item);
      });
      Terminal.printWarning(
          message: "🗑 Registro eliminado: ${item['Concepto_Recurso']}");
    } catch (e) {
      Operadores.alertActivity(
        context: context,
        tittle: "Error al Eliminar Registro . . .",
        message: "ERROR - $e",
        onClose: () => Navigator.pop(context),
        onAcept: () => Navigator.pop(context),
      );
    }
  }

  void toOperaciones(BuildContext context, String operationActivity) {
    if (isMobile(context)) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => operacionesActivos(
                operationActivity: operationActivity,
              )));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => GestionActivos(
                esActualized: false,
                actualSidePage: operacionesActivos(
                  operationActivity: operationActivity,
                ),
              )));
    }
  }

  var gestionScrollController = ScrollController();
}

// #########################################################
class GraficaFinanciera extends StatefulWidget {
  late List registros;
  final bool esActualizado;

  GraficaFinanciera({
    super.key,
    required this.registros,
    required this.esActualizado,
  });

  @override
  State<GraficaFinanciera> createState() => _GraficaFinancieraState();
}

class _GraficaFinancieraState extends State<GraficaFinanciera> {
  bool cargando = true;
  String periodo =
      "Meses"; // 🔹 ['Semanas', 'Meses', 'Últimos 12 Meses', 'Años', 'Lustros']
  List filtrados = [];

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    try {
      await FinancierosRepo().cargarDesdeLocal();
      setState(() {
        widget.registros = FinancierosRepo().registros;
        filtrados = widget.registros; // 🔹 Inicializa lista base
        cargando = false;
      });
    } catch (e, s) {
      Terminal.printAlert(message: '❌ Error al cargar registros: $e\n$s');
      setState(() => cargando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cargando) {
      return const Center(child: CircularProgressIndicator());
    }

    final registrosFiltrados = _filtrarPorPeriodo(widget.registros, periodo);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildSelectorPeriodo(),
          const SizedBox(height: 10),
          Expanded(
            flex: 4,
            child: _buildGraficoTendencias(registrosFiltrados),
          ),
          const Divider(color: Colors.white24),
          Text(
            "📅 Mostrando últimos ${_descripcionPeriodo(periodo)}",
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  }

  // 🔹 Selector de periodo
  Widget _buildSelectorPeriodo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Periodo:', style: TextStyle(color: Colors.white)),
        const SizedBox(width: 8),
        DropdownButton<String>(
          dropdownColor: Colors.black,
          value: periodo,
          style: const TextStyle(color: Colors.white),
          items: const [
            'Semanas',
            'Meses',
            'Últimos 12 Meses',
            'Años',
            'Lustros'
          ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) => setState(() => periodo = v!),
        ),
      ],
    );
  }

  // 🔹 Gráfico de barras
  Widget _buildGraficoTendencias(List registrosFiltrados) {
    if (registrosFiltrados.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Sin datos suficientes para graficar.',
            style: TextStyle(color: Colors.white70)),
      );
    }

    final ingresos =
        registrosFiltrados.map((e) => e['ingresos'] as double).toList();
    final egresos =
        registrosFiltrados.map((e) => e['egresos'] as double).toList();
    final etiquetas =
        registrosFiltrados.map((e) => e['etiqueta'] as String).toList();

    return SizedBox(
      height: 300,
      child: BarChart(
        key: ValueKey(
            periodo), // 👈 fuerza reconstrucción al cambiar "Semanas/Meses/Años/Lustros"
        BarChartData(
          backgroundColor: Colors.transparent,
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, _) => Text(
                  '\$${value.toInt()}',
                  style: const TextStyle(color: Colors.white70, fontSize: 10),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  final i = value.toInt();
                  if (i < 0 || i >= etiquetas.length) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      etiquetas[i],
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 10),
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(etiquetas.length, (i) {
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: ingresos[i],
                  color: Colors.greenAccent,
                  width: 6,
                ),
                BarChartRodData(
                  toY: egresos[i],
                  color: Colors.redAccent,
                  width: 6,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  // 🔹 Filtro maestro: semanas, meses, años, lustros
  List<Map<String, dynamic>> _filtrarPorPeriodo(
      List registros, String periodo) {
    switch (periodo) {
      case 'Semanas':
        return _agruparPorPeriodo(registros, 'semana', 12);
      case 'Meses':
        return _agruparPorPeriodo(registros, 'mes', 12);
      case 'Últimos 12 Meses':
        return _agruparPorPeriodo(registros, 'ultimos12', 5);
      case 'Años':
        return _agruparPorPeriodo(registros, 'año', 5);
      case 'Lustros':
        return _agruparPorPeriodo(registros, 'lustro', 3);
      default:
        return [];
    }
  }

  // 🔹 Agrupación genérica
  List<Map<String, dynamic>> _agruparPorPeriodo(
      List registros, String tipo, int cantidad) {
    final ahora = DateTime.now();
    late DateTime fechaInicio;

    switch (tipo) {
      case 'semana':
        fechaInicio = ahora.subtract(Duration(days: 7 * cantidad));
        break;
      case 'mes':
        fechaInicio = DateTime(ahora.year, ahora.month - cantidad, 1);
        break;
      case 'año':
        fechaInicio = DateTime(ahora.year - cantidad, 1, 1);
        break;
      case 'ultimos12':
        fechaInicio = DateTime(ahora.year, ahora.month - 11, 1);
        break;
      case 'lustro':
        // Muestra 3 lustros = 15 años
        fechaInicio = DateTime(ahora.year - 15, 1, 1);
        break;
      default:
        fechaInicio = DateTime(ahora.year - 1);
    }

    final Map<String, Map<String, double>> mapa = {};

    for (var e in registros) {
      final tipoRecurso = (e['Tipo_Recurso'] ?? '').toString().toLowerCase();
      final fechaStr = e['Fecha_Pago_Programado']?.toString() ?? '';
      final fecha = DateTime.tryParse(fechaStr);
      final monto = double.tryParse(e['Monto_Pagado'].toString()) ?? 0;
      if (fecha == null || fecha.isBefore(fechaInicio)) continue;

      late String etiqueta;
      if (tipo == 'semana') {
        final semana = ((fecha.day - 1) / 7).floor() + 1;
        etiqueta = 'Sem $semana ${_nombreMes(fecha.month)}';
      } else if (tipo == 'mes' || tipo == 'ultimos12') {
        etiqueta = '${_nombreMes(fecha.month)} ${fecha.year}';
      } else if (tipo == 'año') {
        etiqueta = fecha.year.toString();
      } else if (tipo == 'lustro') {
        // 🧭 Agrupa correctamente por lustros reales (2020–2024, 2025–2029, etc.)
        final lustroInicio = (fecha.year ~/ 5) * 5;
        final lustroFin = lustroInicio + 4;
        etiqueta = '$lustroInicio–$lustroFin';
      }

      mapa.putIfAbsent(etiqueta, () => {'ingresos': 0, 'egresos': 0});

      if (tipoRecurso.startsWith('ingreso')) {
        mapa[etiqueta]!['ingresos'] =
            (mapa[etiqueta]!['ingresos'] ?? 0) + monto;
      } else if (tipoRecurso.startsWith('egreso')) {
        mapa[etiqueta]!['egresos'] = (mapa[etiqueta]!['egresos'] ?? 0) + monto;
      }
    }

    final lista = mapa.entries.map((e) {
      return {
        'etiqueta': e.key,
        'ingresos': e.value['ingresos'] ?? 0,
        'egresos': e.value['egresos'] ?? 0,
      };
    }).toList();

    // 🔹 Orden cronológico real (por año y mes)
    lista.sort((a, b) {
      final partesA = (a['etiqueta'] as String).split(' ');
      final partesB = (b['etiqueta'] as String).split(' ');
      if (partesA.length < 2 || partesB.length < 2) {
        return (a['etiqueta'] as String).compareTo(b['etiqueta'] as String);
      }
      final mesA = _mesNumero(partesA[0]);
      final mesB = _mesNumero(partesB[0]);
      final anioA = int.tryParse(partesA[1]) ?? 0;
      final anioB = int.tryParse(partesB[1]) ?? 0;
      return anioA == anioB ? mesA.compareTo(mesB) : anioA.compareTo(anioB);
    });
    return lista;
  }

  // 🔹 Utilidades
  String _nombreMes(int m) {
    const meses = [
      '',
      'Ene',
      'Feb',
      'Mar',
      'Abr',
      'May',
      'Jun',
      'Jul',
      'Ago',
      'Sep',
      'Oct',
      'Nov',
      'Dic'
    ];
    return meses[m];
  }

  // 🔹 Auxiliar para ordenar los meses
  int _mesNumero(String mes) {
    const meses = {
      'Ene': 1,
      'Feb': 2,
      'Mar': 3,
      'Abr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Ago': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dic': 12
    };
    return meses[mes] ?? 0;
  }

  String _descripcionPeriodo(String p) {
    switch (p) {
      case 'Semanas':
        return '12 semanas';
      case 'Meses':
        return '12 meses';
      case 'Años':
        return '5 años';
      case 'Lustros':
        return '3 lustros (15 años)';
      default:
        return '';
    }
  }
}
