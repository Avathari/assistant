import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/actividades/pdfGenerete/PdfApi.dart';
import 'package:assistant/conexiones/actividades/pdfGenerete/pdfGenereteFormats/formatosReportes.dart';
import 'package:assistant/conexiones/actividades/wordGenerate/DocApi.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/ventometr%C3%ADas.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/home.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/screens/pacientes/auxiliares/hospitalarios/info/Hospitalizado.dart';
import 'package:assistant/screens/pacientes/auxiliares/hospitalarios/subjetivos.dart';
import 'package:assistant/screens/pacientes/auxiliares/revisiones/generales.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/padecimientoActual.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/pendientes.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/situacionesHospitalizacion.dart';
import 'package:assistant/screens/pacientes/pacientes.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CircleLabel.dart';
import 'package:assistant/widgets/CircularFloattingButton.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Hospitalizados extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Pace_APP_ALE";
  // ****************** *** ****** **************

  Hospitalizados({super.key, this.actualSidePage});

  @override
  State<Hospitalizados> createState() => _HospitalizadosState();

  static dummy(int idPace) {
    return {
      "ID_Hosp": 0,
      "ID_Pace": idPace,
      "Feca_INI_Hosp": "0000-00-00",
      "Id_Cama": 'N/A',
      "Dia_Estan": 0,
      "Medi_Trat": "",
      "Serve_Trat": "",
      "Serve_Trat_INI": "",
      "Feca_EGE_Hosp": "0000-00-00",
      "EGE_Motivo": "",
    };
  }
}

class _HospitalizadosState extends State<Hospitalizados> {
  String appTittle = "Gestion de pacientes hospitalizados";
  String searchCriteria = "Buscar por Fecha";
  String? consultQuery = Pacientes.pacientes['consultHospitalized'];

  late List? foundedItems = [], firstFounded = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  // PageView Variables
  final PageController _pageController = PageController(initialPage: 0);
  int _activePage = 0;

  var fileAssocieted = 'assets/vault/hospitalized.json';
  List<String> auxiliarServicios = [];

  @override
  void initState() {
    for (var element in Escalas.serviciosHospitalarios) {
      auxiliarServicios.add(element.toString());
    }
    //
    fileAssocieted = 'assets/vault/hospitalized.json';
    //
    Terminal.printWarning(message: " . . . Iniciando Actividad ");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      //
      setState(() {
        foundedItems = firstFounded = descompose(value);
        //
        orderByCamas(foundedItems!);
      });
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "Error : $error");
      _pullListRefresh().onError((error, stackTrace) {
        return errorLoggerSnackBar(context,
            error: error, stackTrace: stackTrace);
      });
    });
    Terminal.printWarning(
        message:
            " . . . Actividad Iniciada : : fileAssocieted $fileAssocieted");
    super.initState();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Contextos.contexto = context;

    /// ENFORCE DEVICE ORIENTATION PORTRAIT ONLY
    if (isMobile(context)) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    }

    return Scaffold(
      key: _key,
      backgroundColor: Theming.cuaternaryColor,
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            },
          ),
          title: AppBarText(appTittle),
          actions: <Widget>[
            CrossLine(
              thickness: 4,
              isHorizontal: false,
            ),
            IconButton(
              icon: const Icon(
                Icons.wordpress,
              ),
              tooltip: "Imprimir censo hospitalario",
              onPressed: () async {
                // final pdfFile = await PdfParagraphsApi.generateFromList(
                //   topMargin: 10,
                //   bottomMargin: 5,
                //   rightMargin: 10,
                //   leftMargin: 10,
                //   withIndicationReport: false,
                //   indexOfTypeReport: TypeReportes.censoHospitalario,
                //   paraph: foundedItems!!,
                //   content:  FormatosReportes.censoSimpleHospitalario(
                //       foundedItems!!),
                //   name: "(CEN) - (${Calendarios.today()}).docx",
                // );
                DocApi.openFileInWord();
                // PdfApi.openFile(pdfFile);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.list,
              ),
              tooltip: "Imprimir censo hospitalario",
              onPressed: () async {
                final pdfFile = await PdfParagraphsApi.generateFromList(
                  topMargin: 10,
                  bottomMargin: 5,
                  rightMargin: 10,
                  leftMargin: 10,
                  withIndicationReport: false,
                  indexOfTypeReport: TypeReportes.censoHospitalario,
                  paraph: foundedItems!,
                  content:
                      FormatosReportes.censoSimpleHospitalario(foundedItems!),
                  name: "(CEN) - (${Calendarios.today()}).pdf",
                );
                PdfApi.openFile(pdfFile);
              },
            ),
          ]),
      body: Column(
        children: [
          // Row(
          //   children: [
          //     Expanded(
          //       flex: 7,
          //       child: EditTextArea(
          //         labelEditText: 'Buscar por Servicio',
          //         textController: searchTextController,
          //         keyBoardType: TextInputType.text,
          //         inputFormat: MaskTextInputFormatter(),
          //         iconColor: Colors.grey,
          //         numOfLines: 1,
          //         selection: true,
          //         withShowOption: true,
          //         onSelected: () {
          //           Operadores.selectOptionsActivity(
          //               context: context,
          //               options: Listas.listWithoutRepitedValues(
          //                 Listas.listFromMapWithOneKey(foundedItems!,
          //                     keySearched: 'Serve_Trat'),
          //               ),
          //               onClose: (value) {
          //                 List results = [];
          //                 results = Listas.listFromMap(
          //                     lista: foundedItems!,
          //                     keySearched: 'Serve_Trat',
          //                     elementSearched: value);
          //                 setState(() {
          //                   foundedItems = results;
          //                 });
          //                 Navigator.of(context).pop();
          //               });
          //         },
          //       ),
          //     ),
          //     Expanded(
          //         child: GrandIcon(
          //       iconData: Icons.dataset,
          //       labelButton: "Primeros Encontrados",
          //       onPress: () {
          //         _reiniciar();
          //       },
          //     ))
          //   ],
          // ),
          Expanded(
            flex: isTablet(context)
                ? 18
                : isDesktop(context)
                    ? 9
                    : 2,
            child: RefreshIndicator(
              color: Colors.white,
              backgroundColor: Colors.black,
              onRefresh: _pullListRefresh,
              child: FutureBuilder<List>(
                initialData: foundedItems!,
                future: Future.value(foundedItems!),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  if (snapshot.hasData) {
                    if (isMobile(context)) {
                      return PageView.builder(
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _activePage = page;
                          });
                        },
                        itemCount: foundedItems!.length,
                        itemBuilder: (context, index) {
                          return itemListView(snapshot, index, context);
                        },
                      );
                    } else {
                      return GridView.builder(
                        padding: const EdgeInsets.all(10.0),
                        gridDelegate: GridViewTools.gridDelegate(
                          crossAxisCount: isMobile(context) ? 1 : 1,
                          mainAxisExtent: isMobile(context) ? 625 : 350,
                        ),
                        controller: ScrollController(),
                        shrinkWrap: false,
                        itemCount:
                            snapshot.data == null ? 0 : snapshot.data.length,
                        itemBuilder: (context, index) {
                          return itemListView(snapshot, index, context);
                        },
                      );
                    }
                  } else {
                    return Center(
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
                  }
                },
              ),
            ),
          ),
        ],
      ),
      endDrawer: _drawerForm(context),
      floatingActionButtonLocation: isMobile(context)
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.endDocked,
      bottomNavigationBar:
          isMobile(context) ? bottomNavigationBar(context) : null,
      floatingActionButton: Wrap(spacing: 10, children: [
        if (!isMobile(context))
          CircleIcon(
            iconed: Icons.menu_open_outlined,
            // iconColor: Colors.grey,
            radios: isLargeDesktop(context) || isDesktop(context) ? 30 : 20,
            difRadios: 5,
            onChangeValue: () => _key.currentState!.openEndDrawer(),
          ),
        CircleIcon(
          iconed: Icons.refresh,
          // iconColor: Colors.grey,
          radios: isLargeDesktop(context) || isDesktop(context) ? 40 : 30,
          difRadios: 5,
          onChangeValue: _pullListRefresh,
        ),
      ]),
    );
  }

  @override
  void dispose() {
    /// ENFORCE DEVICE ORIENTATION PORTRAIT ONLY
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  // Operadores de Interfaz ********* ************ ******** *
  GestureDetector itemListView(
      AsyncSnapshot snapshot, int index, BuildContext context) {
    if (isMobile(context)) {
      Terminal.printWhite(
          message: foundedItems![index].hospitalizedData.keys.toString());
      return mobileView(snapshot, index);
    } else {
      return desktopView(snapshot, index);
    }
  }

  void toVisual(BuildContext context, String operationActivity) async {
    Directrices.coordenada =
        true; // Variable Global para VisualPacientes devuelva a Hospitalizados.dart
    //
    Terminal.printData(
        message: 'Nombre obtenido ${Pacientes.nombreCompleto}\n'
            '${Pacientes.localPath}');
    Archivos.readJsonToMap(filePath: Pacientes.localPath).then((value) {
      Pacientes.Paciente = value[0];
      setState(() {
        Pacientes.imagenPaciente = value[0]['Pace_FIAT'];
      });
      Terminal.printSuccess(message: 'Archivo ${Pacientes.localPath} Obtenido');
      Valores.fromJson(value[0]);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => VisualPacientes(actualPage: 0),
        ),
      );
    }).onError((error, stackTrace) async {
      Operadores.loadingActivity(
        context: context,
        tittle: "Iniciando interfaz . . . ",
        message: "Iniciando Interfaz",
      );
      Terminal.printAlert(
          message: 'Archivo ${Pacientes.localPath} No Encontrado');
      Terminal.printWarning(message: 'Iniciando busqueda en Valores . . . ');
      var response = await Valores().load(); // print("response $response");
      //
      if (response == true) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => VisualPacientes(actualPage: 0),
          ),
        );
      }
    });
  }

  void toOperaciones(BuildContext context, int index,
      AsyncSnapshot<dynamic> snapshot, String operationActivity) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => OperacionesPacientes(
        operationActivity: operationActivity,
      ),
    ));
  }

  // Reinicio con los Valores previamente obtenidos *************************
  void _reiniciar() {
    setState(() {
      foundedItems = firstFounded;
    });
  }

  // VISTAS *******************************************************
  GestureDetector desktopView(AsyncSnapshot snapshot, int index) {
    return GestureDetector(
      // onTap: () {
      //   Terminal.printExpected(
      //       message: "${foundedItems![index].hospitalizedData['Pendientes']}");
      // },
      onDoubleTap: () {
        Pacientes.ID_Paciente = foundedItems![index].idPaciente;
        Pacientes.Paciente = foundedItems![index].generales;

        Pacientes.fromJson(foundedItems![index].generales);

        toVisual(context, Constantes.Update);
      },
      child: Container(
        decoration: ContainerDecoration.roundedDecoration(),
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 50,
                        child: Text(
                            foundedItems![index]
                                .hospitalizedData['Id_Cama']
                                .toString(),
                            style: Styles.textSyleGrowth(fontSize: 18)),
                      )),
                  Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 20,
                        child: Text(foundedItems![index].idPaciente.toString(),
                            style: Styles.textSyleGrowth(fontSize: 10)),
                      )),
                  Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 20,
                        child: Text(
                            foundedItems![index]
                                .hospitalizedData['ID_Hosp']
                                .toString(),
                            style: Styles.textSyleGrowth(fontSize: 10)),
                      )),
                  Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 10,
                        child: Text(
                            foundedItems![index]
                                .hospitalizedData['Id_Cama']
                                .toString(),
                            style: Styles.textSyleGrowth(fontSize: 10)),
                      )),
                  IconButton(
                    color: Colors.grey,
                    icon: const Icon(Icons.update_rounded),
                    onPressed: () {
                      Pacientes.ID_Paciente = foundedItems![index].idPaciente;
                      Pacientes.Paciente = foundedItems![index].generales;

                      Pacientes.fromJson(foundedItems![index].generales);

                      toVisual(context, Constantes.Update);
                    },
                  ),
                ],
              ),
            ),
            // const SizedBox(width: 4),
            Expanded(
              flex: isLargeDesktop(context) ? 3 : 5,
              child: Container(
                decoration: ContainerDecoration.roundedDecoration(),
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 6, bottom: 8),
                margin: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 6, bottom: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 5,
                              child: fichaIdentificacion(snapshot, index)),
                          Expanded(
                              flex: 5,
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                margin: const EdgeInsets.all(5.0),
                                decoration:
                                    ContainerDecoration.roundedDecoration(),
                                child: padesView(snapshot, index),
                              )),
                        ],
                      ),
                    ),
                    CrossLine(),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: isLargeDesktop(context) ||
                      isDesktop(context) ||
                      isTablet(context)
                  ? 2
                  : 1,
              child: Column(
                children: [
                  Expanded(
                      flex: 5,
                      child: _paraclinicosPanel(context, snapshot, index)),
                  Expanded(
                    child: ValuePanel(
                      onLongPress: () => Datos.portapapeles(
                          context: context,
                          text:
                              vitalesString(foundedItems![index].vitales.last)),
                      firstText: foundedItems![index].vitales.isNotEmpty
                          ? foundedItems![index]
                              .vitales
                              .last['Pace_Feca_SV']
                              .toString()
                          : 'Sin Signos Vitales',
                    ),
                  ),
                  Expanded(
                      child: ValuePanel(
                    onLongPress: () => Datos.portapapeles(
                        context: context,
                        text: ventilacionesString(
                            foundedItems![index].ventilaciones.last)),
                    firstText: foundedItems![index].ventilaciones.isNotEmpty
                        ? foundedItems![index]
                            .ventilaciones
                            .last['Feca_VEN']
                            .toString()
                        : 'Sin VMi',
                  )),
                ],
              ),
            ),
            if (isLargeDesktop(context))
              Expanded(child: _middlePanel(context, snapshot, index)),
            if (isLargeDesktop(context))
              Expanded(child: _middlePanel(context, snapshot, index)),
            if (isLargeDesktop(context))
              Expanded(child: _middlePanel(context, snapshot, index)),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Expanded(flex: 5, child: cronicosPanel(snapshot, index)),
                  Expanded(flex: 5, child: diagnosticosPanel(snapshot, index)),
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(flex: 2, child: pendientesPanel(snapshot, index)),
                    Expanded(flex: 2, child: opcionesPanel(context, index)),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GrandIcon(
                        iconData: Icons.receipt,
                        labelButton: 'Antecedentes',
                        onPress: () {
                          Pacientes.ID_Hospitalizacion =
                              foundedItems![index].hospitalizedData['ID_Hosp'];
                          String cronicos = "";

                          if (foundedItems![index].patologicos == []) {
                            cronicos = 'Sin Antecedentes Crónicos Documentados';
                          } else {
                            for (var i in foundedItems![index].patologicos) {
                              if (i['Pace_APP_DEG_com'] != null ||
                                  i['Pace_APP_DEG_com'] != '') {
                                cronicos =
                                    "$cronicos${i['Pace_APP_DEG_com'].toUpperCase()}, "
                                    "${i['Pace_APP_DEG_dia']} años, "
                                    "${i['Pace_APP_DEG_tra']} "
                                    "\n\n";
                              } else {
                                cronicos =
                                    'Sin Antecedentes Crónicos Documentados';
                              }
                            }
                          }
                          Datos.portapapeles(
                              context: context,
                              text:
                                  "${foundedItems![index].generales['Pace_NSS']} ${foundedItems![index].generales['Pace_AGRE']}\n"
                                  "${"${foundedItems![index].generales['Pace_Ape_Pat']} ${foundedItems![index].generales['Pace_Ape_Mat']} ${foundedItems![index].generales['Pace_Nome_PI']} ${foundedItems![index].generales['Pace_Nome_SE']}\n".toUpperCase()}"
                                  "Edad ${foundedItems![index].generales['Pace_Eda']} Años\n"
                                  "FN: ${foundedItems![index].hospitalizedData['Feca_INI_Hosp']} : "
                                  "${DateTime.now().difference(DateTime.parse(foundedItems![index].hospitalizedData['Feca_INI_Hosp'])).inDays} DEH"
                                  "\n____________________________\n\n"
                                  "$cronicos\n");
                        }),
                    GrandIcon(
                        iconData: Icons.medication_outlined,
                        labelButton: 'Padecimiento Actual',
                        onPress: () {
                          Pacientes.ID_Hospitalizacion =
                              foundedItems![index].hospitalizedData['ID_Hosp'];
                          String pades = "No hay padecimiento Descrito\n",
                              diagos = "",
                              previos = "";
                          // ************************
                          if (foundedItems![index].padecimientoActual != null) {
                            if (foundedItems![index]
                                        .padecimientoActual['Contexto'] !=
                                    null &&
                                foundedItems![index]
                                        .padecimientoActual['Contexto'] !=
                                    [] &&
                                foundedItems![index]
                                        .padecimientoActual['Contexto'] !=
                                    "") {
                              pades =
                                  "${foundedItems![index].padecimientoActual['Contexto']}\n";
                            } else {
                              pades = "No hay padecimiento Descrito\n";
                            }
                          }
                          for (var i in foundedItems![index].diagnosticos) {
                            diagos =
                                "$diagos${i['Pace_APP_DEG'].toUpperCase()} -\n\t${i['Pace_APP_DEG_com']}\n";
                          }
                          for (var i in foundedItems![index].patologicos) {
                            previos = "$previos"
                                // "${i['Pace_APP_DEG'].toUpperCase()} -\n"
                                "\t${i['Pace_APP_DEG_com']}\n";
                          }
                          Datos.portapapeles(
                              context: context,
                              text: "$pades"
                                  "___________________________________________\n"
                                  "\n$diagos"
                                  "$previos");
                        }),
                    GrandIcon(
                        labelButton: "Historial de Laboratorios",
                        iconData: Icons.checklist_sharp,
                        onPress: () async {
                          await foundedItems![index]
                              .getParaclinicosHistorial()
                              .whenComplete(() {
                            Pacientes.Paraclinicos =
                                foundedItems![index].paraclinicos;
                            // ***************************************************
                            Datos.portapapeles(
                                context: context,
                                text: Auxiliares.historial(esAbreviado: true));
                          });
                        }),
                    GrandIcon(
                        labelButton: "Historial de Imagenologicos",
                        iconData: Icons.recent_actors_outlined,
                        onPress: () async {
                          await foundedItems![index]
                              .getImagenologicosHistorial()
                              .whenComplete(() {
                            Pacientes.Imagenologicos =
                                foundedItems![index].imagenologicos;
                            // ***************************************************
                            Datos.portapapeles(
                                context: context,
                                text: Imagenologias.historial());
                          });
                        }),
                    GrandIcon(
                        labelButton: "Historial de Electrocardiogramas",
                        iconData: Icons.monitor_heart_outlined,
                        onPress: () async {
                          await foundedItems![index]
                              .getElectrocardiogramasHistorial()
                              .whenComplete(() {
                            Pacientes.Electros =
                                foundedItems![index].electrocardiogramas;
                            // ***************************************************
                            Datos.portapapeles(
                                context: context,
                                text: Electrocardiogramas.historial());
                          });
                        }),
                    GrandIcon(
                        labelButton: "Pendientes . . . ",
                        iconData: Icons.list_alt,
                        onPress: () async {
                          Pacientes.ID_Hospitalizacion = foundedItems![index]
                                  .idHospitalizado =
                              foundedItems![index].hospitalizedData['ID_Hosp'];
                          Pacientes.nombreCompleto =
                              foundedItems![index].nombreCompleto;
                          //
                          Pacientes.Pendiente =
                              foundedItems![index].pendientes =
                                  await firstFounded![index]
                                      .getPendientesHistorial();
// *********************************
                          String penden = "";
                          // *********************************
                          for (var i in Pacientes.Pendiente!) {
                            penden = "$penden"
                                "${i['Pace_PEN'].toUpperCase()} - \n"
                                "${i['Pace_Desc_PEN']}" //  - ${i['Pace_PEN_realized']}"
                                "\n";
                          }
                          // ***************************************************
                          Datos.portapapeles(
                              context: context,
                              text:
                                  "${foundedItems![index].hospitalizedData['Id_Cama']} - $penden");
                        }),
                  ],
                )),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GrandIcon(
                    iconData: Icons.medical_information_outlined,
                    labelButton: 'Padecimiento Actual',
                    onPress: () {
                      Pacientes.ID_Hospitalizacion =
                          foundedItems![index].hospitalizedData['ID_Hosp'];
                      Operadores.openDialog(
                          context: context,
                          chyldrim: const PadecimientoActual(),
                          onAction: () {
                            // Repositorios.actualizarRegistro();
                          });
                    }),
                CircleIcon(
                    tittle: 'Recargar Registro . . . ',
                    iconed: Icons.recent_actors_rounded,
                    onChangeValue: () => _refreshActualList(index)),
                GrandIcon(
                    iconData: Icons.monitor_weight_outlined,
                    labelButton: 'Estado General . . . ',
                    onPress: () {
                      Pacientes.ID_Hospitalizacion =
                          foundedItems![index].hospitalizedData['ID_Hosp'];
                      Operadores.openDialog(
                          context: context,
                          chyldrim: isMobile(context)
                              ? const SituacionesHospitalizacion()
                              : SingleChildScrollView(
                                  controller: ScrollController(),
                                  child: const SituacionesHospitalizacion(),
                                ),
                          onAction: () {
                            // Repositorios.actualizarRegistro();
                          });
                    }),
              ],
            ))
          ],
        ),
      ),
    );
  }

  GestureDetector mobileView(AsyncSnapshot snapshot, int index) {
    return GestureDetector(
      // onTap: () {
      //   // Terminal.printExpected(
      //   //     message: "${foundedItems![index].hospitalizedData['Pendientes']}");
      // },
      onDoubleTap: () {
        Pacientes.ID_Paciente = foundedItems![index].idPaciente;
        Pacientes.Paciente = foundedItems![index].generales;

        Pacientes.fromJson(foundedItems![index].generales);

        toVisual(context, Constantes.Update);
      },
      child: Container(
        color: Theming.cuaternaryColor,
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 50,
                        child: Text(
                            foundedItems![index]
                                .hospitalizedData['Id_Cama']
                                .toString(),
                            style: Styles.textSyleGrowth(fontSize: 18)),
                      )),
                  Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 20,
                        child: Text(foundedItems![index].idPaciente.toString(),
                            style: Styles.textSyleGrowth(fontSize: 10)),
                      )),
                  Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 20,
                        child: Text(
                            foundedItems![index]
                                .hospitalizedData['ID_Hosp']
                                .toString(),
                            style: Styles.textSyleGrowth(fontSize: 10)),
                      )),
                  Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 10,
                        child: Text(
                            foundedItems![index]
                                .hospitalizedData['Id_Cama']
                                .toString(),
                            style: Styles.textSyleGrowth(fontSize: 10)),
                      )),
                  IconButton(
                    color: Colors.grey,
                    icon: const Icon(Icons.update_rounded),
                    onPressed: () {
                      setState(() {
                        Pacientes.ID_Paciente = foundedItems![index].idPaciente;
                        Pacientes.Paciente = foundedItems![index].generales;
                        Pacientes.fromJson(foundedItems![index].generales);
                      });
                      toVisual(context, Constantes.Update);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              flex: 18,
              child: Container(
                decoration: ContainerDecoration.roundedDecoration(
                  colorBackground: Theming.cuaternaryColor,
                ),
                padding: const EdgeInsets.only(
                    left: 5.0, right: 5.0, top: 6, bottom: 8),
                margin: const EdgeInsets.only(
                    left: 7.0, right: 5.0, top: 6, bottom: 2),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 5,
                              child: fichaIdentificacion(snapshot, index)),
                          Expanded(
                              flex: 11,
                              child: padesView(snapshot, index)),
                          CrossLine(),
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                Expanded(
                                  child: CircleIcon(
                                    iconed: Icons.medical_information_outlined,
                                    onChangeValue: () async {
                                      await foundedItems![index]
                                          .getVitalesHistorial()
                                          .whenComplete(() {
                                        Datos.portapapeles(
                                            context: context,
                                            text: vitalesString(
                                                foundedItems![index]
                                                    .vitales
                                                    .last));
                                      });
                                    },
                                    tittle:
                                        foundedItems![index].vitales.isNotEmpty
                                            ? foundedItems![index]
                                                .vitales
                                                .last['Pace_Feca_SV']
                                                .toString()
                                            : "Sin SV's",
                                  ),
                                ),
                                Expanded(
                                  child: ValuePanel(
                                    onLongPress: () => Datos.portapapeles(
                                        context: context,
                                        text: foundedItems![index]
                                            .getVentilacionnesHistorial()
                                            .then((response) {
                                          return ventilacionesString(
                                              foundedItems![index]
                                                  .ventilaciones
                                                  .last);
                                        })),
                                    firstText: foundedItems![index]
                                            .ventilaciones
                                            .isNotEmpty
                                        ? foundedItems![index]
                                            .ventilaciones
                                            .last['Feca_VEN']
                                            .toString()
                                        : 'Sin VMi',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: _paraclinicosPanel(context, snapshot, index))
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Expanded(
                            flex: 5, child: cronicosPanel(snapshot, index)),
                        Expanded(
                            flex: 5, child: diagnosticosPanel(snapshot, index)),
                      ],
                    ),
                  ),
                  // Expanded(flex: 2, child: pendientesPanel(snapshot, index)),
                  Expanded(flex: 2, child: opcionesPanel(context, index)),
                ],
              ),
            ),
            // Expanded(flex: 2, child: Container()),
            // Container(
            //   margin: const EdgeInsets.all(5.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Pendientes(s) ",
            //         style: Styles.textSyleGrowth(fontSize: 12),
            //       ),
            //       CrossLine(),
            //       Expanded(
            //         child: ListView.builder(
            //             itemCount: foundedItems![index]
            //                 .hospitalizedData['Pendientes']
            //                 .length,
            //             itemBuilder: (BuildContext context, ind) {
            //               return Text(
            //                 foundedItems![index]
            //                         .hospitalizedData['Pendientes'][ind]
            //                     ['Pace_Desc_PEN'],
            //                 style: Styles.textSyleGrowth(fontSize: 9),
            //               );
            //             }),
            //       ),
            //       const SizedBox(height: 4),
            //       // Text(
            //       //   "Diagnóstico(s) ",
            //       //   style: Styles.textSyleGrowth(fontSize: 12),
            //       // ),
            //       // CrossLine(),
            //       // Expanded(
            //       //   child: ListView.builder(
            //       //       itemCount: foundedItems![index].hospitalizedData['Diagnosticos'].length,
            //       //       itemBuilder: (BuildContext context, ind) {
            //       //         return Text(foundedItems![index].hospitalizedData['Diagnosticos'][ind]
            //       //         ['Pace_APP_DEG'], style: Styles.textSyleGrowth(fontSize: 9),);
            //       //       }),
            //       // ),
            //     ],
            //   ),
            // )),
            CrossLine(height: 15, thickness: 4),
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 2,
                            child: SingleChildScrollView(
                              controller: ScrollController(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GrandIcon(
                                      iconData: Icons.receipt,
                                      labelButton: 'Antecedentes',
                                      onPress: () {
                                        Pacientes.ID_Hospitalizacion = foundedItems![index]
                                            .hospitalizedData['ID_Hosp'];
                                        String cronicos = "";
                    
                                        if (foundedItems![index].patologicos == []) {
                                          cronicos =
                                          'Sin Antecedentes Crónicos Documentados';
                                        } else {
                                          for (var i in foundedItems![index].patologicos) {
                                            if (i['Pace_APP_DEG_com'] != null ||
                                                i['Pace_APP_DEG_com'] != '') {
                                              cronicos =
                                              "$cronicos${i['Pace_APP_DEG_com'].toUpperCase()}, "
                                                  "${i['Pace_APP_DEG_dia']} años, "
                                                  "${i['Pace_APP_DEG_tra']} "
                                                  "\n\n";
                                            } else {
                                              cronicos =
                                              'Sin Antecedentes Crónicos Documentados';
                                            }
                                          }
                                        }
                                        Datos.portapapeles(
                                            context: context,
                                            text:
                                            "${foundedItems![index].generales['Pace_NSS']} ${foundedItems![index].generales['Pace_AGRE']}\n"
                                                "${"${foundedItems![index].generales['Pace_Ape_Pat']} ${foundedItems![index].generales['Pace_Ape_Mat']} ${foundedItems![index].generales['Pace_Nome_PI']} ${foundedItems![index].generales['Pace_Nome_SE']}\n".toUpperCase()}"
                                                "Edad ${foundedItems![index].generales['Pace_Eda']} Años\n"
                                                "FN: ${foundedItems![index].hospitalizedData['Feca_INI_Hosp']} : "
                                                "${DateTime.now().difference(DateTime.parse(foundedItems![index].hospitalizedData['Feca_INI_Hosp'])).inDays} DEH"
                                                "\n____________________________\n\n"
                                                "$cronicos\n");
                                      }),
                                  GrandIcon(
                                      iconData: Icons.medication_outlined,
                                      labelButton: 'Padecimiento Actual',
                                      onPress: () {
                                        Pacientes.ID_Hospitalizacion = foundedItems![index]
                                            .hospitalizedData['ID_Hosp'];
                                        String pades = "No hay padecimiento Descrito\n",
                                            diagos = "",
                                            previos = "";
                                        // ************************
                                        if (foundedItems![index].padecimientoActual !=
                                            null) {
                                          if (foundedItems![index]
                                              .padecimientoActual['Padecimiento_Actual'] !=
                                              null &&
                                              foundedItems![index]
                                                  .padecimientoActual['Padecimiento_Actual'] !=
                                                  [] &&
                                              foundedItems![index]
                                                  .padecimientoActual['Padecimiento_Actual'] !=
                                                  "") {
                                            pades =
                                            "${foundedItems![index].padecimientoActual['Padecimiento_Actual']}\n";
                                          } else {
                                            pades = "No hay padecimiento Descrito\n";
                                          }
                                        }
                                        for (var i in foundedItems![index].diagnosticos) {
                                          diagos =
                                          "$diagos${i['Pace_APP_DEG'].toUpperCase()} -\n\t${i['Pace_APP_DEG_com']}\n";
                                        }
                                        for (var i in foundedItems![index].patologicos) {
                                          previos = "$previos"
                                          // "${i['Pace_APP_DEG'].toUpperCase()} -\n"
                                              "\t${i['Pace_APP_DEG_com']}\n";
                                        }
                                        Datos.portapapeles(
                                            context: context,
                                            text: "$pades"
                                                "___________________________________________\n"
                                                "\n$diagos"
                                                "$previos");
                                      }),
                                  GrandIcon(
                                      labelButton: "Historial de Laboratorios",
                                      iconData: Icons.checklist_sharp,
                                      onPress: () async {
                                        await foundedItems![index]
                                            .getParaclinicosHistorial()
                                            .whenComplete(() {
                                          Pacientes.Paraclinicos =
                                              foundedItems![index].paraclinicos;
                                          // ***************************************************
                                          Datos.portapapeles(
                                              context: context,
                                              text:
                                              Auxiliares.historial(esAbreviado: true));
                                        });
                                      }),
                                  GrandIcon(
                                      labelButton: "Historial de Imagenologicos",
                                      iconData: Icons.recent_actors_outlined,
                                      onPress: () async {
                                        await foundedItems![index]
                                            .getImagenologicosHistorial()
                                            .whenComplete(() {
                                          Pacientes.Imagenologicos =
                                              foundedItems![index].imagenologicos;
                                          // ***************************************************
                                          Datos.portapapeles(
                                              context: context,
                                              text: Imagenologias.historial());
                                        });
                                      }),
                                  GrandIcon(
                                      labelButton: "Historial de Electrocardiogramas",
                                      iconData: Icons.monitor_heart_outlined,
                                      onPress: () async {
                                        await foundedItems![index]
                                            .getElectrocardiogramasHistorial()
                                            .whenComplete(() {
                                          Pacientes.Electros =
                                              foundedItems![index].electrocardiogramas;
                                          // ***************************************************
                                          Datos.portapapeles(
                                              context: context,
                                              text: Electrocardiogramas.historial());
                                        });
                                      }),
                                  GrandIcon(
                                      labelButton: "Pendientes . . . ",
                                      iconData: Icons.list_alt,
                                      onPress: () async {
                                        Pacientes.ID_Hospitalizacion =
                                            foundedItems![index].idHospitalizado =
                                        foundedItems![index]
                                            .hospitalizedData['ID_Hosp'];
                                        Pacientes.nombreCompleto =
                                            foundedItems![index].nombreCompleto;
                                        //
                                        Pacientes.Pendiente =
                                            foundedItems![index].pendientes =
                                        await firstFounded![index]
                                            .getPendientesHistorial();
                    // *********************************
                                        String penden = "";
                                        // *********************************
                                        for (var i in Pacientes.Pendiente!) {
                                          penden = "$penden"
                                              "${i['Pace_PEN'].toUpperCase()} - \n"
                                              "${i['Pace_Desc_PEN']}" //  - ${i['Pace_PEN_realized']}"
                                              "\n";
                                        }
                                        // ***************************************************
                                        Datos.portapapeles(
                                            context: context,
                                            text:
                                            "${foundedItems![index].hospitalizedData['Id_Cama']} - $penden");
                                      }),
                                ],
                              ),
                            )),
                        Expanded(child: CrossLine()),
                        Expanded(
                          child: GrandIcon(
                              iconData: Icons.monitor_weight_outlined,
                              labelButton: 'Estado General . . . ',
                              onPress: () {
                                Pacientes.ID_Hospitalizacion =
                                foundedItems![index].hospitalizedData['ID_Hosp'];
                                Operadores.openDialog(
                                    context: context,
                                    chyldrim: isMobile(context)
                                        ? const SituacionesHospitalizacion()
                                        : SingleChildScrollView(
                                      controller: ScrollController(),
                                      child: const SituacionesHospitalizacion(),
                                    ),
                                    onAction: () {
                                      // Repositorios.actualizarRegistro();
                                    });
                              }),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: CircleIcon(
                        tittle: 'Recargar Registro . . . ',
                        iconed: Icons.recent_actors_rounded,
                        onChangeValue: () => _refreshActualList(index)),
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox(height: 10)),
          ],
        ),
      ),
    );
  }

  // PANELES  *****************************************************
  Widget padesView(AsyncSnapshot snapshot, int index) {
    if (foundedItems![index].padecimientoActual.isEmpty) {
      return GestureDetector(
          onDoubleTap: () {
            Operadores.openWindow(
                context: context,
                chyldrim: Column(
                  children: [
                    Text(
                      foundedItems![index].padecimientoActual == null
                          ? 'Sin Padecimiento Actual'
                          : "Padecimiento Actual:\n ${foundedItems![index].padecimientoActual['Padecimiento_Actual'] ?? ''}",
                      maxLines: 10,
                      softWrap: true,
                      style: Styles.textSyleGrowth(fontSize: 10),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ));
          },
          child: Text(
            "PA: Sin padecimiento actual registrado . . . ",
            maxLines: 45,
            style: Styles.textSyleGrowth(fontSize: 8),
            textAlign: TextAlign.start,
          ));
    } else {
      return GestureDetector(
        onDoubleTap: () {
          Operadores.openWindow(
              context: context,
              chyldrim: Column(
                children: [
                  TittleContainer(
                    color: Colors.black,
                    tittle: 'Padecimiento Actual',
                    child: Text(
                      foundedItems![index].padecimientoActual == null
                          ? 'Sin Padecimiento Actual'
                          : " ${foundedItems![index].padecimientoActual['Padecimiento_Actual'] ?? ''}",
                      maxLines: 45,
                      softWrap: true,
                      style: Styles.textSyleGrowth(fontSize: 10),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
              onAction: () {});
        },
        child: TittleContainer(
          tittle: 'Padecimiento Actual',
          color: Theming.cuaternaryColor,
          child: Text(
            "${foundedItems![index].padecimientoActual['Padecimiento_Actual'] ?? 'Sin padecimiento actual registrado . . . '}",
            maxLines: 45,
            style: Styles.textSyleGrowth(fontSize: 8),
            textAlign: TextAlign.start,
          ),
        ),
      );
    }
  }

  Widget fichaIdentificacion(AsyncSnapshot snapshot, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "${snapshot.data[index].generales['Pace_Ape_Pat'] ?? ''} "
              "${snapshot.data[index].generales['Pace_Ape_Mat'] ?? ''} "
              "${snapshot.data[index].generales['Pace_Nome_PI'] ?? ''} "
              "${snapshot.data[index].generales['Pace_Nome_SE'] ?? ''}",
              maxLines: 2,
              style: Styles.textSyleGrowth(fontSize: 14)),
          // Text(
          //   "Hemotipo: ${snapshot.data[index].hospitalizedData['Pace_Hemo'] ?? ''}",
          //   maxLines: 2,
          //   style: Styles.textSyleGrowth(fontSize: 10),
          // ),
          // Text(
          //   "Servicio: ${snapshot.data[index].hospitalizedData['Serve_Trat'] ?? ''}",
          //   maxLines: 2,
          //   style: Styles.textSyleGrowth(fontSize: 10),
          // ),
          // Text(
          //   "${snapshot.data[index].hospitalizedData['Medi_Trat'] ?? ''}",
          //   maxLines: 2,
          //   overflow: TextOverflow.ellipsis,
          //   style: Styles.textSyleGrowth(fontSize: 10),
          // ),
          Text(
              "NG.: ${snapshot.data[index].hospitalizedData['Feca_INI_Hosp'] ?? ''} - "
              "D.E.H.: ${Calendarios.differenceInDaysToNow(snapshot.data[index].hospitalizedData['Feca_INI_Hosp'] ?? DateTime.now().toString())}",
              style: Styles.textSyleGrowth(fontSize: 12)),
          CrossLine()
        ],
      ),
    );
  }

  Widget auxiliarPanel(AsyncSnapshot snapshot, int index) {
    return GridView.builder(
        padding: const EdgeInsets.all(4),
        gridDelegate:
            GridViewTools.gridDelegate(crossAxisCount: 1, mainAxisExtent: 55),
        itemCount: Listas.listWithoutRepitedValues(
                Listas.listFromMapWithOneKey(snapshot.data[index].paraclinicos))
            .length,
        // snapshot.data[index].paraclinicos.length,
        itemBuilder: (BuildContext context, int posit) {
          var list = Listas.listWithoutRepitedValues(
              Listas.listFromMapWithOneKey(snapshot.data[index].paraclinicos));
          return ValuePanel(
            secondText: "${list[posit]}", // Resultado
            withEditMessage: false,
            onEdit: (value) {
              Pacientes.Paraclinicos = snapshot.data[index].paraclinicos;
              Terminal.printExpected(
                  message:
                      "snapshot.data[index].paraclinicos ${snapshot.data[index].paraclinicos}");

              Datos.portapapeles(
                  context: context,
                  text: Auxiliares.porFecha(fechaActual: value));
            },
          );
        });
  }

  Widget cronicosPanel(AsyncSnapshot snapshot, int index) {
    return TittleContainer(
        color: isMobile(context) ? Theming.cuaternaryColor : Colors.black,
        tittle: "Crónico(s) ",
        child: ListView.builder(
            itemCount: foundedItems![index].patologicos.length,
            itemBuilder: (BuildContext context, ind) {
              return Text(
                foundedItems![index].patologicos[ind]['Pace_APP_DEG'],
                style: Styles.textSyleGrowth(fontSize: 9),
              );
            }));
  }

  Widget diagnosticosPanel(AsyncSnapshot snapshot, int index) {
    return TittleContainer(
        color: isMobile(context) ? Theming.cuaternaryColor : Colors.black,
        tittle: "Diagnóstico(s) ",
        child: ListView.builder(
            itemCount: foundedItems![index].diagnosticos.length,
            itemBuilder: (BuildContext context, ind) {
              return Text(
                foundedItems![index].diagnosticos[ind]['Pace_APP_DEG'],
                style: Styles.textSyleGrowth(fontSize: 9),
              );
            }));
  }

  Widget pendientesPanel(AsyncSnapshot snapshot, int index) {
    return TittleContainer(
      tittle: 'Pendiente(s)',
      color: isMobile(context) ? Theming.cuaternaryColor : Colors.black,
      child: Expanded(
          flex: 5,
          child: ListView.builder(
              itemCount: foundedItems![index].pendientes.length,
              itemBuilder: (BuildContext context, int ind) {
                return Text(
                  foundedItems![index].pendientes[ind]['Pace_Desc_PEN'],
                  style: Styles.textSyleGrowth(fontSize: 9),
                );
              })),
    );
  }

  Widget signosVitales(AsyncSnapshot snapshot, int index) => TittleContainer(
      color: isMobile(context) ? Theming.cuaternaryColor : Colors.black,
      tittle: 'Signos Vitales . . . ',
      child: foundedItems![index].vitales.isNotEmpty
          ? Wrap(
              children: [
                ValuePanel(
                  firstText: foundedItems![index]
                      .vitales
                      .last['Pace_SV_tas']
                      .toString(),
                ),
                ValuePanel(
                  firstText: foundedItems![index]
                      .vitales
                      .last['Pace_SV_tad']
                      .toString(),
                ),
                ValuePanel(
                  firstText: foundedItems![index]
                      .vitales
                      .last['Pace_SV_fc']
                      .toString(),
                ),
                ValuePanel(
                  firstText: foundedItems![index]
                      .vitales
                      .last['Pace_SV_fr']
                      .toString(),
                ),
                ValuePanel(
                  firstText: foundedItems![index]
                      .vitales
                      .last['Pace_SV_tc']
                      .toString(),
                ),
                ValuePanel(
                  firstText: foundedItems![index]
                      .vitales
                      .last['Pace_SV_spo']
                      .toString(),
                ),
                ValuePanel(
                  firstText: foundedItems![index]
                      .vitales
                      .last['Pace_SV_est']
                      .toString(),
                ),
                ValuePanel(
                  firstText: foundedItems![index]
                      .vitales
                      .last['Pace_SV_pct']
                      .toString(),
                ),
                ValuePanel(
                  firstText: foundedItems![index]
                      .vitales
                      .last['Pace_SV_glu']
                      .toString(),
                ),
                ValuePanel(
                  firstText: foundedItems![index]
                      .vitales
                      .last['Pace_SV_glu_ayu']
                      .toString(),
                ),
              ],
            )
          : Container());

  // AUXILIARES
  errorLoggerSnackBar(BuildContext context,
          {Object? error = "", StackTrace? stackTrace}) =>
      TittleContainer(
        tittle: "Error Ocurrido . . . ",
        centered: true,
        color: Theming.cuaternaryColor,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            TittlePanel(
              textPanel: "$error",
              color: Theming.cuaternaryColor,
              fontSize: 14,
            ),
            Text(
              "$stackTrace",
              style: Styles.textSyleGrowth(fontSize: 8),
            ),
            CrossLine(height: 20, thickness: 3),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  "Cerrar",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                )),
          ],
        ),
      );

  bottomNavigationBar(BuildContext context) => BottomAppBar(
        color: Colors.black87,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GrandIcon(
                labelButton: "Reiniciar . . . ",
                iconData: Icons.replay,
                onPress: () => _pullListRefresh().onError((error, stackTrace) {
                      showModalBottomSheet(
                          context: context,
                          backgroundColor: Theming.cuaternaryColor,
                          builder: (BuildContext context) {
                            return errorLoggerSnackBar(context,
                                error: error, stackTrace: stackTrace);
                          });
                    })),
            GrandIcon(
                labelButton: "Primeros Encontrados",
                iconData: Icons.file_present,
                onPress: () => _reiniciar()),
            const SizedBox(width: 25),
            GrandIcon(onPress: () => null),
            GrandIcon(
              labelButton: "Listado de Camas . . . ",
              iconData: Icons.blur_linear_sharp,
              onPress: () async {
                _key.currentState!.openEndDrawer();
                // final pdfFile = await PdfParagraphsApi.generateFromList(
                //   topMargin: 10,
                //   bottomMargin: 5,
                //   rightMargin: 10,
                //   leftMargin: 10,
                //   withIndicationReport: false,
                //   indexOfTypeReport: TypeReportes.censoHospitalario,
                //   paraph: foundedItems!,
                //   content:
                //       FormatosReportes.censoSimpleHospitalario(foundedItems!),
                //   name: "(CEN) - (${Calendarios.today()}).pdf",
                // ).onError((error, stackTrace) => errorLoggerSnackBar(context,
                //     error: error, stackTrace: stackTrace));
                // // Abrir documento
                // PdfApi.openFile(pdfFile).onError((error, stackTrace) =>
                //     errorLoggerSnackBar(context,
                //         error: error, stackTrace: stackTrace));
              },
            ),
          ],
        ),
      );

  // METHODS
  Future<Null> _pullListRefresh() async {
    Terminal.printAlert(
        message: "Iniciando actividad : : \n "
            "Consulta de pacientes hospitalizados . . . NUEVA FUNCION");
    //
    Operadores.loadingActivity(
        context: context,
        tittle: 'Actualizando Valores . . . ',
        message: 'Actualizando . . . ',
        onCloss: () {
          Navigator.of(context).pop();
        });
    // CONSULTA DE VALORES ****************************************
    List hospitalized = []; // Lista de Pacientes Hospitalizados * * *

    var response = await Actividades.consultar(
      Databases.siteground_database_regpace,
      Pacientes.pacientes['consultHospitalized'],
    );
    //
    for (int i = 0; i < response.length; i++) {
      hospitalized.insert(i,
          Internado(int.parse(response[i]["ID_Pace"].toString()), response[i]));
      //
      await hospitalized[i].getHospitalizationRegister();
      await hospitalized[i].getPadecimientoActual();
      await hospitalized[i].getCronicosHistorial();
      await hospitalized[i].getDiagnosticosHistorial();
      await hospitalized[i].getVitalesHistorial();
      //
      await hospitalized[i].getVentilacionnesHistorial();
      //
      await hospitalized[i].getBalancesHistorial();
      //
      await hospitalized[i].getPendientesHistorial();
      //
      await hospitalized[i].getParaclinicosHistorial();
      // await hospitalized[i].getImagenologicosHistorial();
      // await hospitalized[i].getElectrocardiogramasHistorial();
      Terminal.printExpected(
          message:
              "     :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::     ");
      //
    }
    // ********** ************** ***********
    firstFounded = foundedItems = hospitalized;
    // ESCRIBIR EN JSON ***********************************************
    List listado = [];
    for (int i = 0; i < hospitalized.length; i++) {
      listado.addAll([hospitalized[i]!.toJson()]);
    }
    Archivos.createJsonFromMap(listado, filePath: fileAssocieted);
    //
    setState(() {
      // ACTUALIZAR . . .
      Terminal.printSuccess(
          message: "Actualizando pacientes hospitalizados . . . ");
      // Ordenar por No Cama || ***************** foundedItems!!.sort((a, b) => a["Id_Cama"].compareTo(b["Id_Cama"]));
      orderByCamas(foundedItems!);
      // Cerrar Operaciones.loadingActivity . . .
      Navigator.of(context).pop();
    });
  }

  Future<Null> _refreshActualList(int index) async {
    String _pacienteId = foundedItems![index].idPaciente.toString();
    Map<String, dynamic> generales = foundedItems![index].generales;
    //
    Terminal.printAlert(
        message: "Iniciando actividad : : \n "
            "Consulta de Valores del Hospitalizado . . . NUEVA FUNCION\n "
            "-------------------------------------------------------------------------------\n"
            "INDEX $index\n"
            "ID_Paaace ${foundedItems![index].idPaciente.toString()} : : $_pacienteId : . . . \n\n"
            "-------------------------------------------------------------------------------\n"
            "-------------------------------------------------------------------------------\n"
            "${foundedItems![index].toJson()}");
    //
    Operadores.loadingActivity(
        context: context,
        tittle: 'Actualizando Valores . . . ',
        message: 'Actualizando . . . ',
        onCloss: () {
          Navigator.of(context).pop();
        });
    // CONSULTA DE VALORES ****************************************
    foundedItems!.removeAt(index);
    // Lista de Pacientes Hospitalizados * * *
    foundedItems!.insert(index, Internado(int.parse(_pacienteId), generales));
    //
    await foundedItems![index].getHospitalizationRegister();
    await foundedItems![index].getPadecimientoActual();
    await foundedItems![index].getCronicosHistorial();
    await foundedItems![index].getDiagnosticosHistorial();
    await foundedItems![index].getVitalesHistorial();
    //
    await foundedItems![index].getVentilacionnesHistorial();
    //
    await foundedItems![index].getBalancesHistorial();
    //
    await foundedItems![index].getPendientesHistorial();
    //
    await foundedItems![index].getParaclinicosHistorial();
    // await hospitalized[i].getImagenologicosHistorial();
    // await hospitalized[i].getElectrocardiogramasHistorial();
    Terminal.printExpected(
        message:
            "     :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::     ");
    //

    // ********** ************** ***********
    // foundedItems!.insertAll(index, hospitalized);
    // // ESCRIBIR EN JSON ***********************************************
    // List listado = [];
    // for (int i = 0; i < hospitalized.length; i++) {
    //   listado.addAll([hospitalized[i]!.toJson()]);
    // }
    Archivos.createJsonFromMap(foundedItems!, filePath: fileAssocieted);
    //
    setState(() {
      // ACTUALIZAR . . .
      Terminal.printSuccess(
          message: "Actualizando pacientes hospitalizados . . . ");
      // Ordenar por No Cama || ***************** foundedItems!!.sort((a, b) => a["Id_Cama"].compareTo(b["Id_Cama"]));
      orderByCamas(foundedItems!);
      // Cerrar Operaciones.loadingActivity . . .
      Navigator.of(context).pop();
    });
  }

  //
  String vitalesString(last) {
    return "${last['Pace_Feca_SV']} : "
        "${last['Pace_SV_tas']}/"
        "${last['Pace_SV_tad']} mmHg, "
        "FC ${last['Pace_SV_fc']} Lat/min, "
        "FR ${last['Pace_SV_fr']} Resp/min, "
        "Temp ${last['Pace_SV_tc']}°C, "
        "SpO2 ${last['Pace_SV_spo']}%, "
        "PCT ${last['Pace_SV_pct']} Kg, "
        "EST ${last['Pace_SV_est']} mts, "
        "Glucemia ${last['Pace_SV_glu']} mg/dL "
        "(${last['Pace_SV_glu_ayu']} Horas)";
  }

  String ventilacionesString(last) {
    Terminal.printAlert(message: "${last.runtimeType}");
    Ventilaciones.fromJson(last);
    return "${Valores.fechaVentilaciones!} : : ${Ventometrias.ventiladorCorto}";
  }

  opcionesPanel(BuildContext context, int index) {
    return Wrap(
      alignment: WrapAlignment.center,
      runSpacing: 10,
      spacing: 5,
      children: [
        CircleIcon(
            radios: 30,
            difRadios: 5,
            iconed: Icons.medical_services_outlined,
            onChangeValue: () async {
              Pacientes.ID_Paciente = foundedItems![index].idPaciente;
              Terminal.printWarning(message: "ID : ${Pacientes.ID_Paciente}");
              //
              if (foundedItems![index].vitales.isNotEmpty) {
                Valores.alturaPaciente =
                    foundedItems![index].vitales.last['Pace_SV_est'];
                Valores.pesoCorporalTotal = double.parse(foundedItems![index]
                    .vitales
                    .last['Pace_SV_pct']
                    .toString());
              } else {
                Valores.alturaPaciente = 0;
                Valores.pesoCorporalTotal = 0;
              }

              //
              Cambios.toNextActivity(context, chyld: const Generales());
            }),
        CircleIcon(
            radios: 25,
            difRadios: 5,
            iconed: Icons.list_alt_sharp,
            onChangeValue: () {
              Pacientes.ID_Paciente = foundedItems![index].idPaciente;
              Pacientes.ID_Hospitalizacion =
                  foundedItems![index].idHospitalizado =
                      foundedItems![index].hospitalizedData['ID_Hosp'];
              //
              Cambios.toNextActivity(context,
                  chyld: OperacionesPendiente(
                      operationActivity: Constantes.Register));
            }),
        CircleIcon(
            radios: 25,
            difRadios: 5,
            onChangeValue: () {
              Pacientes.ID_Paciente = foundedItems![index].idPaciente;
              Pacientes.ID_Hospitalizacion =
                  foundedItems![index].idHospitalizado;
              //
              Cambios.toNextActivity(context, chyld: const Subjetivos());
            }),
      ],
    );
  }

  _drawerForm(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Wrap(
        direction: Axis.vertical,
        runSpacing: 10,
        spacing: 10,
        alignment: WrapAlignment.center,
        children: List<Widget>.generate(
            foundedItems!.length,
            (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: () {
                      _pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                      _key.currentState!.closeEndDrawer();
                    },
                    child: CircleAvatar(
                      radius: 14,
                      // check if a dot is connected to the current page
                      // if true, give it a different color
                      backgroundColor:
                          _activePage == index ? Colors.amber : Colors.grey,
                      child: Text(
                          foundedItems![index]
                              .hospitalizedData['Id_Cama']
                              .toString(),
                          style: Styles.textSyleGrowth(fontSize: 8)),
                    ),
                  ),
                )),
      ),
    );
  }

  _paraclinicosPanel(BuildContext context, AsyncSnapshot snapshot, int index) {
    return Column(
      children: [
        Expanded(
          flex: isMobile(context) ? 4 : 6,
          child: TittleContainer(
              centered: isMobile(context) ? true : false,
              tittle: isMobile(context) ? "LAB's" : 'Laboratorios',
              color: isMobile(context) ? Theming.cuaternaryColor : Colors.black,
              child: ListView.builder(
                  padding: const EdgeInsets.all(0.0),
                  itemCount: Listas.listWithoutRepitedValues(
                          Listas.listFromMapWithOneKey(
                              snapshot.data[index].paraclinicos))
                      .length,
                  itemBuilder: (BuildContext context, ind) {
                    var list = Listas.listWithoutRepitedValues(
                        Listas.listFromMapWithOneKey(
                            snapshot.data[index].paraclinicos));

                    return ValuePanel(
                      fontSize: 8,
                      secondText: "${list[ind]}", // Resultado
                      withEditMessage: true,
                      onEdit: (value) {
                        Pacientes.Paraclinicos =
                            foundedItems![index].paraclinicos;

                        Terminal.printExpected(
                            message:
                                "foundedItems![index].paraclinicos ${foundedItems![index].paraclinicos}");

                        Datos.portapapeles(
                            context: context,
                            text: Auxiliares.porFecha(fechaActual: value));
                      },
                    );
                  })),
        ),
        Expanded(
          flex: 1,
          child: CircleIcon(
            tittle: 'Recargar laboratorios . . . ',
            iconed: Icons.receipt_long,
            difRadios: 5,
            onChangeValue: () async {
              await foundedItems![index]
                  .getParaclinicosHistorial()
                  .then((response) async {
                setState(() {});
              });
            },
          ),
        ),
      ],
    );
  }

  _middlePanel(BuildContext context, AsyncSnapshot snapshot, int index) {
    return TittleContainer(child: Container());
  }
}

// OTHER METHODS
void orderByCamas(List? foundedItems) {
  foundedItems!.sort((alfa, betta) {
    return Items.orderOfCamas
            .indexOf(alfa.hospitalizedData['Id_Cama'].toString()) -
        Items.orderOfCamas
            .indexOf(betta.hospitalizedData['Id_Cama'].toString());
  });
}

List? descompose(value) {
  List auxiliar = [];
  for (int i = 0; i < value.length; i++) {
    Terminal.printWarning(message: " . . . Value ${value[i].keys}");
    //
    Internado atreidys =
        Internado(value[i]['generales']['ID_Pace'], value[i]['generales']);
    atreidys.hospitalizedData =
        value[i]['hospitalizedData']['Error'] == 'Hubo un error'
            ? Hospitalizados.dummy(value[i]['generales']['ID_Pace'])
            : value[i]['hospitalizedData'];
    atreidys.padecimientoActual = value[i]['padecimientoActual'];
    //
    atreidys.vitales = value[i]['vitales'];
    atreidys.patologicos = value[i]['patologicos'];
    atreidys.diagnosticos = value[i]['diagnosticos'];
    atreidys.paraclinicos = value[i]['paraclinicos'];
    atreidys.pendientes = value[i]['pendientes'];
    atreidys.ventilaciones = value[i]['ventilaciones'];
    // Otros valores . . .
    atreidys.imagenologicos = value[i]['imagenologicos'];
    atreidys.electrocardiogramas = value[i]['electrocardiogramas'];
    //
    auxiliar.add(atreidys);
  }
  return auxiliar;
}

//

// Actividad de Reinicio :  Consulta de todos los Valores *********************
// Future<Null> _ListRefresh() async {
//   Operadores.loadingActivity(
//       context: context,
//       tittle: 'Actualizando Valores . . . ',
//       message: 'Actualizando . . . ',
//       onCloss: () {
//         Navigator.of(context).pop();
//       });
//
//   // CONSULTA DE VALORES ****************************************
//   List foundedItems = []; // Lista de Pacientes Hospitalizados * * *
//
//   Actividades.consultar(
//     Databases.siteground_database_regpace,
//     Pacientes.pacientes['consultHospitalized'],
//   ).then((response) async {
//     var ids = Listas.listFromMapWithOneKey(response, keySearched: 'ID_Pace');
//     for (var item in ids) {
//       foundedItems.add(await Actividades.consultarId(
//         Databases.siteground_database_reghosp,
//         "SELECT * FROM pace_hosp WHERE ID_Pace = ? "
//         "ORDER BY ID_Hosp ASC",
//         item,
//       ));
//     }
//     // ********** ************** ***********
//     for (var v = 0; v < response.length; v++) {
//       if (foundedItems[v].keys.contains('Error')) {
//         response[v].addAll({
//           "ID_Hosp": 0,
//           "Feca_INI_Hosp": '0000-00-00',
//           "Id_Cama": 'NA',
//           "Dia_Estan": 0,
//           "Medi_Trat": 'N/A',
//           "Serve_Trat": 'N/A',
//           "Serve_Trat_INI": 'N/A',
//           "Feca_EGE_Hosp": '0000-00-00',
//           "EGE_Motivo": ""
//         });
//         response[v].addAll({
//           "Padecimiento": [],
//         });
//         response[v].addAll({
//           "Situaciones": [],
//         });
//         response[v].addAll({
//           "Ventilaciones": [],
//         });
//         response[v].addAll({
//           "Cronicos": [],
//         });
//         response[v].addAll({
//           "Diagnosticos": [],
//         });
//         response[v].addAll({
//           "Pendientes": [],
//         });
//
//         response[v].addAll({
//           "Auxiliares": [],
//         });
//         response[v].addAll({
//           "Imagenologicos": [],
//         });
//         response[v].addAll({
//           "Electrocardiogramas": [],
//         });
//       } else {
//         response[v].addAll(foundedItems[v]);
//         response[v].addAll({
//           "Padecimiento": [],
//         });
//         response[v].addAll({
//           "Situaciones": [],
//         });
//         response[v].addAll({
//           "Ventilaciones": [],
//         });
//         response[v].addAll({
//           "Cronicos": [],
//         });
//         response[v].addAll({
//           "Diagnosticos": [],
//         });
//         response[v].addAll({
//           "Pendientes": [],
//         });
//
//         response[v].addAll({
//           "Auxiliares": [],
//         });
//         response[v].addAll({
//           "Imagenologicos": [],
//         });
//         response[v].addAll({
//           "Electrocardiogramas": [],
//         });
//         //
//         // response[v].addAll({
//         //   "Padecimiento": await Actividades.consultarId(
//         //     Databases.siteground_database_reghosp,
//         //     Repositorios.repositorio['consultPadecimientoQuery'],
//         //     response[v]['ID_Hosp'],
//         //   ),
//         // });
//         // response[v].addAll({
//         //   "Situaciones": await Actividades.consultarId(
//         //       Databases.siteground_database_reghosp,
//         //       Situaciones.situacion['consultQuery'],
//         //       response[v]['ID_Hosp']),
//         // });
//         // response[v].addAll({
//         //   "Ventilaciones": await Actividades.consultarId(
//         //     Databases.siteground_database_reghosp,
//         //     Ventilaciones.ventilacion['consultLastQuery'],
//         //     response[v]['ID_Pace'],
//         //   ),
//         // });
//         // response[v].addAll({
//         //   "Cronicos": await Actividades.consultarAllById(
//         //     Databases.siteground_database_regpace,
//         //     "SELECT * FROM pace_app_deg WHERE ID_Pace = ? ",
//         //     response[v]['ID_Pace'],
//         //   ),
//         // });
//         // response[v].addAll({
//         //   "Diagnosticos": await Actividades.consultarAllById(
//         //     Databases.siteground_database_reghosp,
//         //     "SELECT * FROM pace_dia WHERE ID_Pace = ? "
//         //     "AND ID_Hosp = '${foundedItems![v]['ID_Hosp']}'",
//         //     response[v]['ID_Pace'],
//         //   ),
//         // });
//         // response[v].addAll({
//         //   "Pendientes": await Actividades.consultarAllById(
//         //     Databases.siteground_database_reghosp,
//         //     "SELECT * FROM pace_pen WHERE ID_Pace = ? "
//         //     "AND ID_Hosp = '${foundedItems![v]['ID_Hosp']}' "
//         //     "AND Pace_PEN_realized = '0'",
//         //     response[v]['ID_Pace'],
//         //   )
//         // });
//         // // ********** ************** ***********
//         // response[v].addAll({
//         //   "Auxiliares": await Actividades.consultarAllById(
//         //     Databases.siteground_database_reggabo,
//         //     Auxiliares.auxiliares['consultByIdPrimaryQuery'],
//         //     response[v]['ID_Pace'],
//         //   )
//         // });
//         // response[v].addAll({
//         //   "Imagenologicos": await Actividades.consultarAllById(
//         //     Databases.siteground_database_reggabo,
//         //     Imagenologias.imagenologias['consultByIdPrimaryQuery'],
//         //     response[v]['ID_Pace'],
//         //   )
//         // });
//         // response[v].addAll({
//         //   "Electrocardiogramas": await Actividades.consultarAllById(
//         //     Databases.siteground_database_reggabo,
//         //     Electrocardiogramas
//         //         .electrocardiogramas['consultByIdPrimaryQuery'],
//         //     response[v]['ID_Pace'],
//         //   )
//         // });
//       }
//     }
//     // ********** ************** ***********
//     foundedItems = response;
//     setState(() {
//       Terminal.printSuccess(
//           message: "Actualizando pacientes hospitalizados . . . ");
//       // Ordenar por No Cama || ***************** foundedItems!!.sort((a, b) => a["Id_Cama"].compareTo(b["Id_Cama"]));
//       foundedItems.sort((a, b) {
//         return Items.orderOfCamas.indexOf(a['Id_Cama'].toString()) -
//             Items.orderOfCamas.indexOf(b['Id_Cama'].toString());
//       });
//       Archivos.createJsonFromMap(foundedItems, filePath: fileAssocieted);
//       Navigator.of(context).pop();
//     });
//     // ********** ************** ***********
//   });
// }

// VISTAS *******************************************************
