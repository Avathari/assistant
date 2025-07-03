import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/actividades/pdfGenerete/PdfApi.dart';
import 'package:assistant/conexiones/actividades/pdfGenerete/pdfGenereteFormats/formatosReportes.dart';
import 'package:assistant/conexiones/actividades/wordGenerate/DocApi.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/conexiones/controladores/pacientes/auxiliar/extractor.dart';
import 'package:assistant/conexiones/controladores/pacientes/cargadores/loading.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/home.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/screens/pacientes/auxiliares/detalles/menus.dart';
import 'package:assistant/screens/pacientes/auxiliares/hospitalarios/info/Hospitalizado.dart';
import 'package:assistant/screens/pacientes/auxiliares/hospitalarios/info/auxliarHospitalizados.dart';
import 'package:assistant/screens/pacientes/auxiliares/revisiones/auxiliares/auxiliaresRevisiones.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/padecimientoActual.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/situacionesHospitalizacion.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Hospitalizados extends StatefulWidget {
  Widget? actualSidePage = Container();
  int actualLateralPage = 0;
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
        foundedItems = firstFounded = HospitalaryMethods.descompose(value);
        //
        HospitalaryMethods.orderByCamas(foundedItems!);
      });
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "Error : $error");
      _pullListRefresh().catchError((e, stackTrace) {
        Operadores.alertActivity(
            context: context,
            tittle: "Error al Consultar registros de Hospitalizados . . . ",
            message: "$e : : $stackTrace",
            onAcept: () {
              Navigator.of(context).pop();
            });
      });
      // _pullListRefresh().onError((error, stackTrace) {
      //   Operadores.alertActivity(context: context,
      //   tittle: "$error",
      //       message: "$error");
      //   return errorLoggerSnackBar(context,
      //       error: error, stackTrace: stackTrace);
      // });
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
          // title: AppBarText(appTittle),
          actions: <Widget>[
            GrandIcon(
                labelButton: 'Nuevos Hospitalizados . . . ',
                iconData: Icons.format_indent_decrease,
                iconColor: Colors.white,
                onPress: () => Cambios.toNextActivity(context,
                    chyld: Paneles.HospitalaryNewbies(context, foundedItems!))),
            const SizedBox(width: 15),
            GrandIcon(
                labelButton: 'Estadísticas . . . ',
                iconData: Icons.pie_chart,
                iconColor: Colors.white,
                onPress: () => Cambios.toNextActivity(context,
                    chyld:
                        Paneles.HospitalaryStadystics(context, foundedItems!))),
            //     const SizedBox(width: 15),
            // GrandIcon(
            //     labelButton: 'Pendientes Recabados . . . ',
            //     iconData: Icons.list_alt_sharp,
            //     iconColor: Colors.white,
            //     onPress: () {
            //       setState(() {
            //         widget.actualLateralPage = 1;
            //         _key.currentState!.openEndDrawer();
            //       });
            //     }),
            CrossLine(
              thickness: 4,
              isHorizontal: false,
            ),
            GrandIcon(
              iconData: Icons.wordpress,
              labelButton: "Imprimir censo hospitalario",
              onPress: () async {
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
            const SizedBox(width: 15),
            GrandIcon(
              iconData: Icons.list,
              iconColor: Colors.white,
              labelButton: "Imprimir censo hospitalario",
              onPress: () async {
                Operadores.loadingActivity(
                  context: context,
                  tittle: "Generando censo hospitalario . ",
                  message: "Cargando información necesaria . . . ",
                );
                //
                try {
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
                  ).whenComplete(() => Navigator.of(context).pop());
                  //
                  PdfApi.openFile(pdfFile);
                } on Exception catch (onError, stackTrace) {
                  // TODO
                  Operadores.alertActivity(
                    context: context,
                    tittle: "ERROR : : $onError",
                    message: "$stackTrace",
                    onAcept: () => Navigator.of(context).pop(),
                  );
                }
                //
              },
            ),
            const SizedBox(width: 30),
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
                builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                      // return GridView.builder(
                      //   padding: const EdgeInsets.all(10.0),
                      //   gridDelegate: GridViewTools.gridDelegate(
                      //     crossAxisCount: isMobile(context) ? 1 : 1,
                      //     mainAxisExtent: isMobile(context) ? 625 : 350,
                      //   ),
                      //   controller: ScrollController(),
                      //   shrinkWrap: false,
                      //   itemCount:
                      //       snapshot.data == null ? 0 : snapshot.data.length,
                      //   itemBuilder: (context, index) {
                      //     return itemListView(snapshot, index, context);
                      //   },
                      // );
                      return PageView.builder(
                        controller: _pageController,
                        onPageChanged: (int page) => setState(() {
                          _activePage = page;
                        }),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          Terminal.printWhite(
                              message:
                                  "PageView.builder : : itemListView . . : : $index");
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
      bottomNavigationBar: bottomNavigationBar(
          context), // isMobile(context) ? bottomNavigationBar(context) : null,
      floatingActionButton: Wrap(spacing: 10, children: [
        if (!isMobile(context))
          CircleIcon(
            iconed: Icons.menu_open_outlined,
            // iconColor: Colors.grey,
            radios: isLargeDesktop(context) || isDesktop(context) ? 30 : 20,
            difRadios: 5,
            onChangeValue: () {
              setState(() {
                widget.actualLateralPage = 0;
              });
              _key.currentState!.openEndDrawer();
            },
          ),
        CircleIcon(
          iconed: Icons.refresh,
          // iconColor: Colors.grey,
          radios: isLargeDesktop(context) || isDesktop(context) ? 40 : 30,
          difRadios: 5,
          onChangeValue: _pullListRefresh,
        ),
        if (isTablet(context))
          CircleIcon(
              tittle: "Pendientes Recabados . . . ",
              iconed: Icons.list_alt_sharp,
              onChangeValue: () => setState(() {
                    widget.actualLateralPage = 1;
                    _key.currentState!.openEndDrawer();
                  })),
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

  // Reinicio con los Valores previamente obtenidos *************************
  void _reiniciar() => setState(() => foundedItems = firstFounded);

  // Operadores de Interfaz ********* ************ ******** *
  GestureDetector itemListView(
      AsyncSnapshot snapshot, int index, BuildContext context) {
    if (isMobile(context)) {
      // Terminal.printWhite(
      //     message: foundedItems![index].hospitalizedData.keys.toString());
      return mobileView(snapshot, index);
    } else {
      return desktopView(snapshot, index);
    }
  }

  void toVisual(BuildContext context, String operationActivity) async {
    Directrices.coordenada =
        true; // Variable Global para VisualPacientes devuelva a Hospitalizados.dart
    //
    CargadoresPacientes.loadingActivity(context: context).then((value) async {
      if (value == true) {
        Terminal.printAlert(
            message: 'Archivo ${Pacientes.localPath} Re-Creado $value');

        try {
          final dataVitales =
              await Archivos.readJsonToMap(filePath: Vitales.fileAssocieted)
                  .onError((onError, stackTrace) {});
          final dataHosp = await Archivos.readJsonToMap(
                  filePath: Hospitalizaciones.fileAssocieted)
              .onError((onError, stackTrace) {});

          if (dataVitales != null && dataVitales.isNotEmpty) {
            Vitales.fromJson(dataVitales.last);
          }

          if (dataHosp != null && dataHosp.isNotEmpty) {
            Hospitalizaciones.fromJson(dataHosp.first);
          }

          setState(() {});
          if (context.mounted)
            Cambios.toNextPage(context, VisualPacientes(actualPage: 0));
        } catch (e, stack) {
          Terminal.printAlert(
              message: "❌ Error al leer archivos JSON: $e\n$stack");
          Operadores.alertActivity(
            message: "Error al leer archivos: $e",
            context: context,
            tittle: "Error al Inicializar Visual",
            onAcept: () => Navigator.of(context).pop(),
          );
        }
      }
    }).onError((error, stackTrace) {
      Terminal.printAlert(
          message: "ERROR - toVisual : : $error : : Descripción : $stackTrace");
      Operadores.alertActivity(
        message: "ERROR - toVisual : : $error",
        context: context,
        tittle: 'Error al Inicial Visual',
        onAcept: () => Navigator.of(context).pop(),
      );
    });
    //
    // Terminal.printData(
    //     message: 'Nombre obtenido ${Pacientes.nombreCompleto}\n'
    //         '${Pacientes.localPath}');
    // Archivos.readJsonToMap(filePath: Pacientes.localPath).then((value) {
    //   Pacientes.Paciente = value[0];
    //   setState(() {
    //     Pacientes.imagenPaciente = value[0]['Pace_FIAT'];
    //   });
    //   Terminal.printSuccess(message: 'Archivo ${Pacientes.localPath} Obtenido');
    //   Valores.fromJson(value[0]);
    //
    //   Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (BuildContext context) => VisualPacientes(actualPage: 0),
    //     ),
    //   );
    // }).onError((error, stackTrace) async {
    //   Operadores.loadingActivity(
    //     context: context,
    //     tittle: "Iniciando interfaz . . . ",
    //     message: "Iniciando Interfaz",
    //   );
    //   Terminal.printAlert(
    //       message: 'Archivo ${Pacientes.localPath} No Encontrado');
    //   Terminal.printWarning(message: 'Iniciando busqueda en Valores . . . ');
    //   var response =
    //       await Valores().load(context); // print("response $response");
    //
    //   // ignore: use_build_context_synchronously
    //   if (response == true) {
    //     Cambios.toNextPage(context, VisualPacientes(actualPage: 0));
    //   }
    // });
  }

  // VISTAS *******************************************************
  GestureDetector desktopView(AsyncSnapshot snapshot, int index) {
    Pacientes.ID_Hospitalizacion =
        foundedItems![index].hospitalizedData['ID_Hosp'];
    //
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
        decoration: ContainerDecoration.roundedDecoration(
            colorBackground: Theming.cuaternaryColor),
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10.0),
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
                decoration: ContainerDecoration.roundedDecoration(
                    colorBackground: Theming.cuaternaryColor),
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 6, bottom: 8),
                margin: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 6, bottom: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Paneles.fichaIdentificacion(context, snapshot, index),
                          Expanded(
                              child:
                                  Paneles.padesView(context, snapshot, index)),
                        ],
                      ),
                    ),
                    CrossLine(),
                    Expanded(
                        flex: 6,
                        child: Row(
                          children: [
                            Expanded(child: RevisionDispositivos()),
                            CrossLine(thickness: 2, color: Colors.grey),
                            Expanded(child: RevisionPrevios())
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: isLargeDesktop(context) || isDesktop(context)
                  ? 2
                  : isTablet(context)
                      ? 3
                      : 1,
              child: Column(
                children: [
                  Expanded(
                      flex: 5,
                      child:
                          Paneles.paraclinicosPanel(context, snapshot, index)),
                  Expanded(
                    flex: 1,
                    child: CircleIcon(
                        tittle: 'Recargar laboratorios . . . ',
                        iconed: Icons.receipt_long,
                        difRadios: 5,
                        onLongChangeValue: () => Datos.portapapeles(
                            context: context,
                            text:
                                "${Internado.getUltimo(listadoFrom: foundedItems![index].paraclinicos, esAbreviado: true)}"
                                "${Internado.getGasometrico(listadoFrom: foundedItems![index].paraclinicos, esAbreviado: true)}"
                                "${Internado.getEspeciales(listadoFrom: foundedItems![index].paraclinicos) != "" ? "RELAVANTES\n" : ""}"
                                "${Internado.getEspeciales(listadoFrom: foundedItems![index].paraclinicos, esAbreviado: true)}\n"
                                "${Auxiliares.getCoagulacion()}\n"
                                "${Internado.getCultivos(listadoFrom: foundedItems![index].paraclinicos) != "" ? "MICROBIOLOGICOS\n" : ""}"
                                "${Internado.getCultivos(listadoFrom: foundedItems![index].paraclinicos)}"),
                        onChangeValue: () async {
                          final statusNotifier =
                              ValueNotifier<String>("Iniciando...");
                          final subStatusNotifier =
                              ValueNotifier<String>("Preparando módulo...");
                          final progressNotifier = ValueNotifier<double>(0.0);
                          bool cancelado = false;
                          final paciente = snapshot.data![index];

                          Operadores.showProgressDialog(
                            context: context,
                            tittle: "Historial de Paraclínicos",
                            statusNotifier: statusNotifier,
                            subStatusNotifier: subStatusNotifier,
                            progressNotifier: progressNotifier,
                            onCancel: () {
                              cancelado = true;
                              Navigator.of(context).pop();
                            },
                          );

                          try {
                            statusNotifier.value =
                                "Cargando historial de paraclínicos...";
                            subStatusNotifier.value =
                                "Solicitando información remota...";

                            final response =
                                await paciente.getParaclinicosHistorial();

                            if (cancelado) return;

                            statusNotifier.value =
                                "Procesando datos obtenidos...";
                            subStatusNotifier.value =
                                "Almacenando en memoria y disco";

                            // Guardar en memoria
                            Pacientes.Paraclinicos =
                                paciente.paraclinicos = response;

                            // Guardar en archivo
                            await Archivos.createJsonFromMap(
                              response,
                              filePath: paciente.paraclinicosRepositoryPath,
                            );

                            progressNotifier.value = 1.0;

                            await Future.delayed(const Duration(
                                milliseconds: 300)); // Suavizar cierre
                            if (context.mounted) Navigator.of(context).pop();

                            setState(() {});
                          } catch (e, stack) {
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              Operadores.alertActivity(
                                context: context,
                                tittle: "Error durante la carga",
                                message:
                                    "No se pudo obtener el historial de paraclínicos:\n$e",
                                onAcept: () => Navigator.of(context).pop(),
                              );
                            }
                            Terminal.printAlert(message: "❌ Error: $e\n$stack");
                          } finally {
                            statusNotifier.dispose();
                            subStatusNotifier.dispose();
                            progressNotifier.dispose();
                          }
                        }),
                  ),
                  CrossLine(thickness: 3, color: Colors.grey),
                  ValuePanel(
                    onLongPress: () async {
                      await foundedItems![index]
                          .getBalancesHistorial()
                          .whenComplete(() async {
                        Datos.portapapeles(
                            context: context,
                            text: await HospitalaryStrings.balancesString(
                                foundedItems![index].balances.last,
                                foundedItems,
                                index));
                      });
                    },
                    firstText: foundedItems![index].balances.isNotEmpty
                        ? foundedItems![index].balances.last[0].runtimeType
                                is List<dynamic>
                            ? foundedItems![index]
                                .balances
                                .last[0]['Pace_bala_Fecha']
                                .toString()
                            : foundedItems![index]
                                .balances
                                .last['Pace_bala_Fecha']
                                .toString()
                        : "Sin Balance Hídrico",
                  ),
                  ValuePanel(
                    onLongPress: () => Datos.portapapeles(
                        context: context,
                        text: HospitalaryStrings.vitalesString(
                            foundedItems![index].vitales.last)),
                    firstText: foundedItems![index].vitales.isNotEmpty
                        ? foundedItems![index]
                            .vitales
                            .last['Pace_Feca_SV']
                            .toString()
                        : 'Sin Signos Vitales',
                  ),
                  ValuePanel(
                    onLongPress: () async => Datos.portapapeles(
                        context: context,
                        text: await HospitalaryStrings.ventilacionesString(
                          foundedItems![index].ventilaciones.last,
                          foundedItems![index].vitales.last,
                        )),
                    firstText: foundedItems![index].ventilaciones.isNotEmpty
                        ? foundedItems![index]
                            .ventilaciones
                            .last['Feca_VEN']
                            .toString()
                        : 'Sin VMi',
                  ),
                ],
              ),
            ),
            if (isLargeDesktop(context))
              Expanded(
                  flex: 2,
                  child: Paneles.licenciasPanel(context, snapshot, index)),
            // if (isLargeDesktop(context))
            //   Expanded(child: _middlePanel(context, snapshot, index)),
            if (isLargeDesktop(context))
              Expanded(child: Paneles.middlePanel(context, snapshot, index)),
            Expanded(
              flex: 5, // 3
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 5,
                      child: Paneles.cronicosPanel(context, snapshot, index)),
                  // Expanded(flex: 5, child: diagnosticosPanel(snapshot, index)),
                  Expanded(
                      flex: 5,
                      child: Paneles.pendientesPanel(context, snapshot, index)),
                ],
              ),
            ),
            // Expanded(flex: 2, child: Row(
            //   children: [
            //     Expanded(child: RevisionDispositivos()),
            //     CrossLine(thickness: 2, color: Colors.grey),
            //     Expanded(child: RevisionPrevios())
            //   ],
            // )),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    // Expanded(
                    //     flex: 4,
                    //     child:
                    //         Paneles.pendientesPanel(context, snapshot, index)),
                    Expanded(
                      child: GrandIcon(
                          labelButton: "Pendientes . . . ",
                          iconData: Icons.list_alt,
                          onPress: () async {
                            await snapshot.data![index]
                                .getPendientesHistorial(reload: true)
                                .then((response) async {
                              setState(() {});
                            });
                            // ***************************************************
                          }),
                    ),

                    Expanded(
                        flex: 2,
                        child: Paneles.opcionesPanel(
                            context, foundedItems, index)),
                    Expanded(
                        child: CircleIcon(
                      tittle: "Revisión Hospitalaria",
                      iconed: Icons.history_edu,
                      onChangeValue: () {
                        Datos.portapapeles(
                            context: context,
                            text: snapshot.data![index].revisionHospitalaria?[
                                    'Hitos_Hospitalarios'] ??
                                'Sin Revisión Actual Registrada');
                        //
                      },
                    )),
                    Expanded(
                        child: CircleIcon(
                      tittle: 'Recargar Registro . . . ',
                      iconed: Icons.recent_actors_rounded,
                      onChangeValue: () => _refreshActualList(index),
                    )),
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
//                           Pacientes.ID_Hospitalizacion = foundedItems![index]
//                                   .idHospitalizado =
//                               foundedItems![index].hospitalizedData['ID_Hosp'];
//                           Pacientes.nombreCompleto =
//                               foundedItems![index].nombreCompleto;
//                           //
//                           Pacientes.Pendiente =
//                               foundedItems![index].pendientes =
//                                   await firstFounded![index]
//                                       .getPendientesHistorial(reload: true);
// // *********************************
//                           String penden = "";
//                           // *********************************
//                           for (var i in Pacientes.Pendiente!) {
//                             if (i['Pace_PEN'] != 'Procedimientos') {
//                               penden = "$penden"
//                                   "${i['Pace_PEN'].toUpperCase()} - \n"
//                                   "${i['Pace_Desc_PEN']}" //  - ${i['Pace_PEN_realized']}"
//                                   "\n";
//                             }
//                           }
                          Datos.portapapeles(
                              context: context,
                              text: Pendientes.getPendiente(
                                  foundedItems![index].pendientes));
                        }),
                    const SizedBox(height: 60),
                  ],
                )),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 10,
                ),
                GrandIcon(
                    iconData: Icons.medical_information_outlined,
                    labelButton: 'Padecimiento Actual',
                    onPress: () {
                      Pacientes.ID_Hospitalizacion =
                          foundedItems![index].hospitalizedData['ID_Hosp'];
                      Operadores.openDialog(
                          context: context,
                          chyldrim: PadecimientoActual(),
                          onAction: () {
                            // Repositorios.actualizarRegistro();
                          });
                    }),
                if (!isTablet(context))
                  CircleIcon(
                    tittle: 'Recargar Registro . . . ',
                    iconed: Icons.recent_actors_rounded,
                    onChangeValue: () => _refreshActualList(index),
                  ),
                GrandIcon(
                    iconData: Icons.hourglass_bottom,
                    labelButton: 'Cutivos y Hemocultivos . . . ',
                    onPress: () => Datos.portapapeles(
                        context: context,
                        text: Internado.getCultivos(
                            listadoFrom: foundedItems![index].paraclinicos))),
                CircleIcon(
                    tittle: "Relevantes . . . ",
                    iconed: Icons.import_contacts,
                    radios: 27,
                    difRadios: 6,
                    onChangeValue: () => Datos.portapapeles(
                        context: context,
                        text:
                            "${Internado.getUltimo(listadoFrom: foundedItems![index].paraclinicos, esAbreviado: true)}"
                            "${Internado.getGasometrico(listadoFrom: foundedItems![index].paraclinicos, esAbreviado: true)}"
                            "${Internado.getEspeciales(listadoFrom: foundedItems![index].paraclinicos) != "" ? "RELAVANTES\n" : ""}"
                            "${Internado.getEspeciales(listadoFrom: foundedItems![index].paraclinicos, esAbreviado: true)}\n"
                            "${Internado.getCultivos(listadoFrom: foundedItems![index].paraclinicos) != "" ? "MICROBIOLOGICOS\n" : ""}"
                            "${Internado.getCultivos(listadoFrom: foundedItems![index].paraclinicos)}")),
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
                const SizedBox(
                  height: 30,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  GestureDetector mobileView(AsyncSnapshot snapshot, int index) {
    // Terminal.printWarning(message: foundedItems![index].balances.toString());
    //
    return GestureDetector(
      onLongPress: () {
        Pacientes.ID_Paciente = foundedItems![index].idPaciente;
        Pacientes.Paciente = foundedItems![index].generales;

        Pacientes.fromJson(foundedItems![index].generales);

        toVisual(context, Constantes.Update);
      },
      child: Container(
        color: Theming.cuaternaryColor,
        padding:
            const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0),
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
                              flex: 13,
                              child: Paneles.fichaIdentificacion(
                                  context, snapshot, index)),
                          Expanded(
                              flex: 22,
                              child:
                                  Paneles.padesView(context, snapshot, index)),
                          CrossLine(),
                          Expanded(
                            flex: 4,
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
                                            text: HospitalaryStrings
                                                .vitalesString(
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
                                  flex: 2,
                                  child: ValuePanel(
                                    onLongPress: () async => Datos.portapapeles(
                                        context: context,
                                        text: await HospitalaryStrings
                                            .ventilacionesString(
                                          foundedItems![index]
                                              .ventilaciones
                                              .last,
                                          foundedItems![index].vitales.last,
                                        )),

                                    // Datos.portapapeles(
                                    // context: context,
                                    // text: foundedItems![index]
                                    //     .getVentilacionnesHistorial()
                                    //     .then((response) {
                                    //   return ventilacionesString(
                                    //       foundedItems![index]
                                    //           .ventilaciones
                                    //           .last);
                                    // })),
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
                                Expanded(
                                  child: CircleIcon(
                                    iconed: Icons.balance_sharp,
                                    onChangeValue: () async {
                                      await foundedItems![index]
                                          .getBalancesHistorial()
                                          .whenComplete(() async {
                                        Datos.portapapeles(
                                            context: context,
                                            text: await HospitalaryStrings
                                                .balancesString(
                                                    foundedItems![index]
                                                        .balances
                                                        .last,
                                                    foundedItems,
                                                    index));
                                      });
                                    },
                                    tittle: foundedItems![index]
                                            .balances
                                            .isNotEmpty
                                        ? foundedItems![index]
                                                .balances
                                                .last[0]
                                                .runtimeType is List<dynamic>
                                            ? foundedItems![index]
                                                .balances
                                                .last[0]['Pace_bala_Fecha']
                                                .toString()
                                            : foundedItems![index]
                                                .balances
                                                .last['Pace_bala_Fecha']
                                                .toString()
                                        : "Sin BI's",
                                  ),
                                ),
                                // Expanded(child: Menus.accionesMediciones(context),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(children: [
                      Expanded(
                          flex: 4,
                          child: snapshot.data!.isNotEmpty
                              ? Paneles.paraclinicosPanel(
                                  context, snapshot, index)
                              : Container()),
                      Expanded(
                        flex: 1,
                        child: CircleIcon(
                          tittle: 'Recargar laboratorios . . . ',
                          iconed: Icons.receipt_long,
                          difRadios: 7,
                          onLongChangeValue: () => Datos.portapapeles(
                              context: context,
                              text:
                                  "${Internado.getUltimo(listadoFrom: foundedItems![index].paraclinicos, esAbreviado: true)}"
                                  "${Internado.getGasometrico(listadoFrom: foundedItems![index].paraclinicos, esAbreviado: true)}"
                                  "${Internado.getEspeciales(listadoFrom: foundedItems![index].paraclinicos) != "" ? "RELAVANTES\n" : ""}"
                                  "${Internado.getEspeciales(listadoFrom: foundedItems![index].paraclinicos, esAbreviado: true)}\n"
                                  "${Auxiliares.getCoagulacion()}\n"
                                  "${Internado.getCultivos(listadoFrom: foundedItems![index].paraclinicos) != "" ? "MICROBIOLOGICOS\n" : ""}"
                                  "${Internado.getCultivos(listadoFrom: foundedItems![index].paraclinicos)}"),
                            onChangeValue: () async {
                              final statusNotifier = ValueNotifier<String>("Iniciando...");
                              final subStatusNotifier = ValueNotifier<String>("Preparando módulo...");
                              final progressNotifier = ValueNotifier<double>(0.0);
                              bool cancelado = false;
                              final paciente = snapshot.data![index];

                              Operadores.showProgressDialog(
                                context: context,
                                tittle: "Historial de Paraclínicos",
                                statusNotifier: statusNotifier,
                                subStatusNotifier: subStatusNotifier,
                                progressNotifier: progressNotifier,
                                onCancel: () {
                                  cancelado = true;
                                  Navigator.of(context).pop();
                                },
                              );

                              try {
                                statusNotifier.value = "Cargando historial de paraclínicos...";
                                subStatusNotifier.value = "Solicitando información remota...";

                                final response = await paciente.getParaclinicosHistorial();

                                if (cancelado) return;

                                statusNotifier.value = "Procesando datos obtenidos...";
                                subStatusNotifier.value = "Almacenando en memoria y disco";

                                // Guardar en memoria
                                Pacientes.Paraclinicos = paciente.paraclinicos = response;

                                // Guardar en archivo
                                await Archivos.createJsonFromMap(
                                  response,
                                  filePath: paciente.paraclinicosRepositoryPath,
                                );

                                progressNotifier.value = 1.0;

                                await Future.delayed(const Duration(milliseconds: 300)); // Suavizar cierre
                                if (context.mounted) Navigator.of(context).pop();

                                setState(() {});
                              } catch (e, stack) {
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                  Operadores.alertActivity(
                                    context: context,
                                    tittle: "Error durante la carga",
                                    message: "No se pudo obtener el historial de paraclínicos:\n$e",
                                    onAcept: () => Navigator.of(context).pop(),
                                  );
                                }
                                Terminal.printAlert(message: "❌ Error: $e\n$stack");
                              } finally {
                                statusNotifier.dispose();
                                subStatusNotifier.dispose();
                                progressNotifier.dispose();
                              }
                            }

                        ),
                      ),
                    ])),
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
                            flex: 5,
                            child: Paneles.cronicosPanel(
                                context, snapshot, index)),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  Datos.portapapeles(
                                      context: context,
                                      text: snapshot.data![index]
                                                  .revisionHospitalaria ==
                                              null
                                          ? 'Sin Revisión Actual Registrada'
                                          : " ${snapshot.data![index].revisionHospitalaria['Hitos_Hospitalarios'] ?? ''}");
                                  //
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black),
                                child: Text(
                                  "Revisión Hospitalaria",
                                  style: Styles.textSyleGrowth(fontSize: 8),
                                ))),
                        // Expanded(
                        //     flex: 5, child: diagnosticosPanel(snapshot, index)),
                        // Expanded(
                        //     flex: 5,
                        //     child: Paneles.licenciasPanel(
                        //         context, snapshot, index)),
                      ],
                    ),
                  ),
                  // Expanded(flex: 2, child: pendientesPanel(snapshot, index)),
                  Expanded(
                      flex: 2,
                      child:
                          Paneles.opcionesPanel(context, foundedItems, index)),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GrandIcon(
                                      iconData: Icons.receipt,
                                      labelButton: 'Antecedentes',
                                      onPress: () {
                                        Pacientes.ID_Hospitalizacion =
                                            foundedItems![index]
                                                .hospitalizedData['ID_Hosp'];
                                        String cronicos = "";

                                        if (foundedItems![index].patologicos ==
                                            []) {
                                          cronicos =
                                              'Sin Antecedentes Crónicos Documentados';
                                        } else {
                                          for (var i in foundedItems![index]
                                              .patologicos) {
                                            if (i['Pace_APP_DEG_com'] != null ||
                                                i['Pace_APP_DEG_com'] != '') {
                                              cronicos = "$cronicos"
                                                  "     "
                                                  "${i['Pace_APP_DEG_com'].toUpperCase()}, "
                                                  // "${i['Pace_APP_DEG_dia']} años, "
                                                  "${i['Pace_APP_DEG_tra']} "
                                                  "\n";
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
                                            foundedItems![index]
                                                .hospitalizedData['ID_Hosp'];
                                        String pades =
                                                "No hay padecimiento Descrito\n",
                                            diagos = "",
                                            previos = "";
                                        // ************************
                                        if (foundedItems![index]
                                                .padecimientoActual !=
                                            null) {
                                          if (foundedItems![
                                                              index]
                                                          .padecimientoActual[
                                                      'Padecimiento_Actual'] !=
                                                  null &&
                                              foundedItems![index]
                                                          .padecimientoActual[
                                                      'Padecimiento_Actual'] !=
                                                  [] &&
                                              foundedItems![index]
                                                          .padecimientoActual[
                                                      'Padecimiento_Actual'] !=
                                                  "") {
                                            pades =
                                                "${foundedItems![index].padecimientoActual['Padecimiento_Actual']}\n";
                                          } else {
                                            pades =
                                                "No hay padecimiento Descrito\n";
                                          }
                                        }
                                        for (var i in foundedItems![index]
                                            .diagnosticos) {
                                          diagos =
                                              "$diagos${i['Pace_APP_DEG'].toUpperCase()} -\n\t${i['Pace_APP_DEG_com']}\n";
                                        }
                                        for (var i in foundedItems![index]
                                            .patologicos) {
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
                                              text: Auxiliares.historial(
                                                  esAbreviado: true));
                                        });
                                      }),
                                  GrandIcon(
                                      labelButton:
                                          "Historial de Imagenologicos",
                                      iconData: Icons.recent_actors_outlined,
                                      onPress: () async {
                                        await foundedItems![index]
                                            .getImagenologicosHistorial()
                                            .whenComplete(() {
                                          Pacientes.Imagenologicos =
                                              foundedItems![index]
                                                  .imagenologicos;
                                          // ***************************************************
                                          Datos.portapapeles(
                                              context: context,
                                              text: Imagenologias.historial());
                                        });
                                      }),
                                  GrandIcon(
                                      labelButton:
                                          "Historial de Electrocardiogramas",
                                      iconData: Icons.monitor_heart_outlined,
                                      onPress: () async {
                                        await foundedItems![index]
                                            .getElectrocardiogramasHistorial()
                                            .whenComplete(() {
                                          Pacientes.Electros =
                                              foundedItems![index]
                                                  .electrocardiogramas;
                                          // ***************************************************
                                          Datos.portapapeles(
                                              context: context,
                                              text: Electrocardiogramas
                                                  .historial());
                                        });
                                      }),
                                  GrandIcon(
                                      labelButton: "Pendientes . . . ",
                                      iconData: Icons.list_alt,
                                      onPress: () async {
                                        Pacientes.ID_Hospitalizacion =
                                            foundedItems![index]
                                                    .idHospitalizado =
                                                foundedItems![index]
                                                        .hospitalizedData[
                                                    'ID_Hosp'];

                                        //
                                        Pacientes.nombreCompleto =
                                            foundedItems![index].nombreCompleto;
                                        //
                                        Pacientes.Pendiente =
                                            foundedItems![index].pendientes =
                                                await firstFounded![index]
                                                    .getPendientesHistorial(
                                                        reload: true);
                                        // *********************************
                                        String penden = "";
                                        // *********************************
                                        for (var i in Pacientes.Pendiente!) {
                                          if (i['Pace_PEN'] !=
                                              'Procedimientos') {
                                            penden = "$penden"
                                                "${i['Pace_PEN'].toUpperCase()} - \n"
                                                "${i['Pace_Desc_PEN']}" //  - ${i['Pace_PEN_realized']}"
                                                "\n";
                                          }
                                        }
                                        // ***************************************************
                                        Datos.portapapeles(
                                            context: context,
                                            text:
                                                "${foundedItems![index].hospitalizedData['Id_Cama']} - $penden \n "
                                                "${Internado.getCultivos(listadoFrom: foundedItems![index].paraclinicos)}");
                                      }),
                                ],
                              ),
                            )),
                        Expanded(child: CrossLine()),
                        Expanded(
                          child: Row(
                            children: [
                              GrandIcon(
                                  iconData: Icons.monitor_weight_outlined,
                                  labelButton: 'Estado General . . . ',
                                  onPress: () {
                                    // Pacientes.ID_Hospitalizacion =
                                    //     foundedItems![index]
                                    //         .hospitalizedData['ID_Hosp'];
                                    // Operadores.openDialog(
                                    //     context: context,
                                    //     chyldrim: isMobile(context)
                                    //         ? const SituacionesHospitalizacion()
                                    //         : SingleChildScrollView(
                                    //             controller: ScrollController(),
                                    //             child:
                                    //                 const SituacionesHospitalizacion(),
                                    //           ),
                                    //     onAction: () {
                                    //       // Repositorios.actualizarRegistro();
                                    //     });
                                  }),
                              const SizedBox(width: 30),
                              GrandIcon(
                                  iconData: Icons.hourglass_bottom,
                                  labelButton: 'Cutivos y Hemocultivos . . . ',
                                  onPress: () => Datos.portapapeles(
                                      context: context,
                                      text: Internado.getCultivos(
                                          listadoFrom: foundedItems![index]
                                              .paraclinicos))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: CircleIcon(
                        tittle: 'Recargar Registro . . . ',
                        iconed: Icons.recent_actors_rounded,
                        onChangeValue: () => _refreshActualList(index),
                        // .whenComplete(() => Navigator.of(context).pop()),
                      )),
                ],
              ),
            ),
            const Expanded(child: SizedBox(height: 10)),
          ],
        ),
      ),
    );
  }

  // AUXILIARES
  errorLoggerSnackBar(BuildContext context,
          {Object? error = "", StackTrace? stackTrace}) =>
      TittleContainer(
        tittle: "Error Ocurrido . . . ",
        centered: true,
        color: Theming.cuaternaryColor,
        child: ListView(
          controller: ScrollController(),
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
        child: isMobile(context)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GrandIcon(
                      labelButton: "Reiniciar . . . ",
                      iconData: Icons.replay,
                      onPress: () =>
                          _pullListRefresh().onError((error, stackTrace) {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Theming.cuaternaryColor,
                                builder: (BuildContext context) {
                                  return errorLoggerSnackBar(context,
                                      error: error, stackTrace: stackTrace);
                                });
                          })),
                  GrandIcon(
                    labelButton: "Indizar laboratorios de pacientes . . . ",
                    iconData: Icons.fact_check_outlined,
                    // onPress: () => _reiniciar(),
                    onPress: () => AuxiliarExtractor(context),
                  ),
                  const SizedBox(width: 25),
                  GrandIcon(
                      labelButton: 'Pendientes Recabados . . . ',
                      iconData: Icons.list_alt_sharp,
                      onPress: () async {
                        //
                        Operadores.loadingActivity(
                            context: context,
                            tittle: 'Consultando Pendientes Recabados . . . ',
                            message: 'Consultando . . . ',
                            onCloss: () {});
                        //
                        int index = -1;
                        Future.doWhile(() async {
                          index++;
                          Pacientes.ID_Hospitalizacion = foundedItems![index]
                                  .idHospitalizado =
                              foundedItems![index].hospitalizedData['ID_Hosp'];
                          //
                          await foundedItems![index]
                              .getPendientesHistorial(reload: true);
                          //
                          if (index < foundedItems!.length) return false;
                          //
                          return true;
                        })
                            .whenComplete(() => setState(() {
                                  Navigator.pop(context);
                                  widget.actualLateralPage = 1;
                                  _key.currentState!.openEndDrawer();
                                }))
                            .onError((error, stackTrace) {
                          Operadores.alertActivity(
                              context: context,
                              tittle: "ERROR Sucedido",
                              message: "ERROR al recolectar pendientes"
                                  "$error : : $stackTrace");
                        });
                      }),
                  GrandIcon(
                    labelButton: "Listado de Camas . . . ",
                    iconData: Icons.blur_linear_sharp,
                    onPress: () async {
                      setState(() {
                        widget.actualLateralPage = 0;
                      });
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
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: GrandIcon(
                      labelButton: "Indizar laboratorios de pacientes . . . ",
                      iconData: Icons.fact_check_outlined,
                      // onPress: () => _reiniciar(),
                      onPress: () => AuxiliarExtractor(context),
                    ),
                  ),
                  Expanded(
                    child: GrandIcon(
                        labelButton: "Reiniciar . . . ",
                        iconData: Icons.replay,
                        onPress: () =>
                            _pullListRefresh().onError((error, stackTrace) {
                              showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Theming.cuaternaryColor,
                                  builder: (BuildContext context) {
                                    return errorLoggerSnackBar(context,
                                        error: error, stackTrace: stackTrace);
                                  });
                            })),
                  ),
                  Expanded(
                    child: GrandIcon(
                        labelButton: "Primeros Encontrados",
                        iconData: Icons.file_present,
                        onPress: () => _reiniciar()),
                  ),
                  if (!isDesktop(context) || !isLargeDesktop(context))
                    const SizedBox(width: 100),
                  if (isDesktop(context) || isLargeDesktop(context))
                    Expanded(
                        child: GrandIcon(
                            labelButton: "Pendientes Recabados . . . ",
                            iconData: Icons.list_alt_sharp,
                            onPress: () async {
                              //
                              Operadores.loadingActivity(
                                  context: context,
                                  tittle:
                                      'Consultando Pendientes Recabados . . . ',
                                  message: 'Consultando . . . ',
                                  onCloss: () {});
                              //
                              int index = -1;
                              Future.doWhile(() async {
                                index++;
                                Pacientes.ID_Hospitalizacion =
                                    foundedItems![index].idHospitalizado =
                                        foundedItems![index]
                                            .hospitalizedData['ID_Hosp'];
                                //
                                await foundedItems![index]
                                    .getPendientesHistorial(reload: true);
                                //
                                if (index < foundedItems!.length) return false;
                                //
                                return true;
                              })
                                  .whenComplete(() => setState(() {
                                        Navigator.pop(context);
                                        widget.actualLateralPage = 1;
                                        _key.currentState!.openEndDrawer();
                                      }))
                                  .onError((error, stackTrace) {
                                Operadores.alertActivity(
                                    context: context,
                                    tittle: "ERROR Sucedido",
                                    message: "ERROR al recolectar pendientes"
                                        "$error : : $stackTrace");
                              });
                            })),
                  const SizedBox(width: 75),
                ],
              ),
      );

  // METHODS
  Future<void> _pullListRefresh() async {
    final statusNotifier = ValueNotifier<String>("Inicializando...");
    final subStatusNotifier = ValueNotifier<String>("Preparando módulo...");
    final progressNotifier = ValueNotifier<double>(0.0);
    final fallosPorPaciente = <Map<String, dynamic>>[];
    final DateTime inicio = DateTime.now();
    bool cancelado = false;

    Operadores.showProgressDialog(
      context: context,
      statusNotifier: statusNotifier,
      subStatusNotifier: subStatusNotifier,
      progressNotifier: progressNotifier,
      isLinear: false,
      onCancel: () {
        cancelado = true;
        Navigator.of(context).pop();
      },
    );

    List hospitalized = [];

    try {
      statusNotifier.value = "Consultando lista de pacientes hospitalizados...";
      var response = await Actividades.consultar(
        Databases.siteground_database_regpace,
        Pacientes.pacientes['consultHospitalized'],
      );

      int total = response.length;

      for (int i = 0; i < total; i++) {
        if (cancelado) break;

        final paciente = Internado(
            int.parse(response[i]["ID_Pace"].toString()), response[i]);
        hospitalized.add(paciente);

        final nombre = paciente.nombreCompleto;
        final progreso = ((i + 1) / total) * 100;
        statusNotifier.value =
            "Cargando a: $nombre (${i + 1}/$total)"; // (${progreso.toStringAsFixed(2)}%)
        progressNotifier.value = (i + 1) / total;
        final erroresPaciente = <String>[];

        // Función para capturar errores por módulo
        Future<void> runModulo(
            String nombreModulo, Future<void> Function() funcion) async {
          try {
            subStatusNotifier.value = nombreModulo;
            await funcion();
          } catch (e) {
            erroresPaciente.add(nombreModulo);
            Terminal.printAlert(
                message: "❌ Error en $nombreModulo del paciente $nombre");
          }
        }

        // Módulos secuenciales obligatorios
        await runModulo("Datos de hospitalización",
            () => paciente.getHospitalizationRegister());
        await runModulo(
            "Padecimiento actual", () => paciente.getPadecimientoActual());
        await runModulo(
            "Revisión hospitalaria", () => paciente.getRevisionHospitalaria());

        // Módulos pesados en paralelo
        await Future.wait([
          runModulo("Diagnósticos", () => paciente.getDiagnosticosHistorial()),
          runModulo("Pendientes", () => paciente.getPendientesHistorial()),
          runModulo("Licencias", () => paciente.getLicenciasHistorial()),
          runModulo("Signos vitales", () => paciente.getVitalesHistorial()),
          runModulo(
              "Balances", () => paciente.getBalancesHistorial(reload: true)),
          runModulo(
              "Ventilaciones", () => paciente.getVentilacionnesHistorial()),
          runModulo("Paraclínicos",
              () => paciente.getParaclinicosHistorial(reload: true)),
          runModulo(
              "Imagenología", () => paciente.getImagenologicosHistorial()),
          runModulo("Electrocardiogramas",
              () => paciente.getElectrocardiogramasHistorial()),
          runModulo(
              "Antecedentes crónicos", () => paciente.getCronicosHistorial()),
        ]);

        if (erroresPaciente.isNotEmpty) {
          fallosPorPaciente.add({
            "nombre": nombre,
            "id": paciente.idPaciente,
            "fallos": erroresPaciente,
          });
        }
      }

      if (!cancelado) {
        statusNotifier.value = "Guardando información local...";
        subStatusNotifier.value = "Escritura de archivo JSON";

        firstFounded = foundedItems = hospitalized;
        List listado = hospitalized.map((p) => p.toJson()).toList();
        Archivos.createJsonFromMap(listado, filePath: fileAssocieted);

        if (!mounted) return;
        Navigator.of(context).pop();

        setState(() {
          HospitalaryMethods.orderByCamas(foundedItems!);
          Terminal.printSuccess(message: "Actualización completa.");
        });

        final duracion = DateTime.now().difference(inicio);
        final totalExitosos = response.length - fallosPorPaciente.length;

        String resumen =
            "✅ $totalExitosos paciente(s) cargado(s) correctamente.\n";
        if (fallosPorPaciente.isNotEmpty) {
          resumen += "❌ ${fallosPorPaciente.length} con errores:\n";
          for (var entry in fallosPorPaciente) {
            resumen +=
                "\n• ${entry['nombre']} (ID ${entry['id']})\n  ↳ Falló en: ${entry['fallos'].join(", ")}";
          }
        }
        resumen += "\n\n🕒 Duración total: ${duracion.inSeconds} segundos.";

        // Guardar log detallado
        final logFilePath = fileAssocieted.replaceAll(".json",
            "_log_${DateTime.now().toIso8601String().substring(0, 10)}.json");
        await Archivos.createJsonFromMap([
          {
            "fecha": DateTime.now().toIso8601String(),
            "duracion_segundos": duracion.inSeconds,
            "pacientes_totales": response.length,
            "exitosos": totalExitosos,
            "con_errores": fallosPorPaciente.length,
            "errores_detallados": fallosPorPaciente,
          }
        ], filePath: logFilePath);

        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: Theming.secondaryColor,
            title: const Text("Resumen de carga",
                style: const TextStyle(color: Colors.white)),
            content: Text(resumen, style: const TextStyle(color: Colors.grey)),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Aceptar",
                    style: const TextStyle(color: Colors.grey)),
              )
            ],
          ),
        );
      }
    } catch (e, stack) {
      if (!cancelado && mounted) {
        Navigator.of(context).pop();
        Operadores.alertActivity(
          context: context,
          tittle: "Error durante la carga",
          message: e.toString(),
          onAcept: () => Navigator.of(context).pop(),
        );
      }
    } finally {
      statusNotifier.dispose();
      subStatusNotifier.dispose();
      progressNotifier.dispose();
    }
  }

  Future<void> _refreshActualList(int index) async {
    final statusNotifier = ValueNotifier<String>("Inicializando...");
    final subStatusNotifier = ValueNotifier<String>("Preparando módulo...");
    final progressNotifier = ValueNotifier<double>(0.0);
    bool cancelado = false;
    final erroresPaciente = <String>[];

    final DateTime inicio = DateTime.now();
    final pacienteAnterior = foundedItems![index];
    final String pacienteId = pacienteAnterior.idPaciente.toString();
    final String nombre = pacienteAnterior.nombreCompleto;
    final Map<String, dynamic> generales = pacienteAnterior.generales;

    Operadores.showProgressDialog(
      context: context,
      statusNotifier: statusNotifier,
      subStatusNotifier: subStatusNotifier,
      progressNotifier: progressNotifier,
      isLinear: false,
      onCancel: () {
        cancelado = true;
        Navigator.of(context).pop();
      },
    );

    final nuevoPaciente = Internado(int.parse(pacienteId), generales);
    foundedItems![index] = nuevoPaciente;

    try {
      statusNotifier.value = "Actualizando a: $nombre";

      Future<void> runModulo(
          String nombreModulo, Future<void> Function() funcion) async {
        if (cancelado) return;
        try {
          subStatusNotifier.value = nombreModulo;
          await funcion();
        } catch (e) {
          erroresPaciente.add(nombreModulo);
          Terminal.printAlert(
              message: "❌ Error en $nombreModulo del paciente $nombre");
        }
      }

      progressNotifier.value = 0.10;
      await runModulo("Datos de hospitalización",
          () => nuevoPaciente.getHospitalizationRegister());
      progressNotifier.value = 0.20;
      await runModulo(
          "Padecimiento actual", () => nuevoPaciente.getPadecimientoActual());
      progressNotifier.value = 0.30;
      await runModulo("Revisión hospitalaria",
          () => nuevoPaciente.getRevisionHospitalaria());

      progressNotifier.value = 0.45;

      await Future.wait([
        runModulo("Antecedentes crónicos",
            () => nuevoPaciente.getCronicosHistorial()),
        runModulo(
            "Diagnósticos", () => nuevoPaciente.getDiagnosticosHistorial()),
        runModulo("Signos vitales",
            () => nuevoPaciente.getVitalesHistorial(reload: true)),
        runModulo("Ventilaciones",
            () => nuevoPaciente.getVentilacionnesHistorial(reload: true)),
        runModulo(
            "Balances", () => nuevoPaciente.getBalancesHistorial(reload: true)),
        runModulo("Paraclínicos",
            () => nuevoPaciente.getParaclinicosHistorial(reload: true)),
        runModulo("Pendientes", () => nuevoPaciente.getPendientesHistorial()),
        // runModulo("Imagenología", () => nuevoPaciente.getImagenologicosHistorial()),
        // runModulo("Electrocardiogramas", () => nuevoPaciente.getElectrocardiogramasHistorial()),
      ]);

      progressNotifier.value = 0.65;

      statusNotifier.value = "Guardando datos localmente...";
      subStatusNotifier.value = "Archivo JSON";

      Archivos.createJsonFromMap(foundedItems!, filePath: fileAssocieted);

      if (!mounted) return;
      Navigator.of(context).pop();

      setState(() {
        HospitalaryMethods.orderByCamas(foundedItems!);
        Terminal.printSuccess(
            message: "✅ Registro de $nombre actualizado con éxito.");
      });

      if (erroresPaciente.isNotEmpty) {
        final duracion = DateTime.now().difference(inicio);
        final logFilePath = fileAssocieted.replaceAll(".json",
            "_refresh_log_${DateTime.now().toIso8601String().substring(0, 10)}.json");

        await Archivos.createJsonFromMap([
          {
            "fecha": DateTime.now().toIso8601String(),
            "id": pacienteId,
            "nombre": nombre,
            "duracion_segundos": duracion.inSeconds,
            "errores": erroresPaciente,
          }
        ], filePath: logFilePath);

        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Actualización parcial"),
            content: Text(
                "🔶 El paciente $nombre fue actualizado, pero se detectaron errores en los módulos:\n\n${erroresPaciente.join("\n")}"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Aceptar"),
              )
            ],
          ),
        );
      }
    } catch (e, stack) {
      if (!cancelado && mounted) {
        Navigator.of(context).pop();
        Operadores.alertActivity(
          context: context,
          tittle: "Error durante la actualización",
          message: e.toString(),
          onAcept: () => Navigator.of(context).pop(),
        );
      }
    } finally {
      statusNotifier.dispose();
      subStatusNotifier.dispose();
      progressNotifier.dispose();
    }
  }

  //
  Future<void> cargarHistoriales(Map<String, dynamic> args) async {
    final int id = args['id'];
    final Map<String, dynamic> data = args['data'];

    final paciente = Internado(id, data);

    await paciente.getDiagnosticosHistorial();
    await paciente.getVitalesHistorial(reload: true);
    await paciente.getVentilacionnesHistorial(reload: true);
    await paciente.getBalancesHistorial(reload: true);
    await paciente.getPendientesHistorial(reload: true);
    await paciente.getLicenciasHistorial();
    await paciente.getParaclinicosHistorial(reload: true);
  }

  //

  //
  _drawerForm(BuildContext context) {
    return widget.actualLateralPage == 0
        ? SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              // direction: Axis.vertical,
              // runSpacing: 10,
              // spacing: 10,
              // alignment: WrapAlignment.center,
              children: List<Widget>.generate(
                  foundedItems!.length,
                  (index) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.symmetric(vertical: 5),
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
                            backgroundColor: _activePage == index
                                ? Colors.amber
                                : Colors.grey,
                            child: Text(
                                foundedItems![index]
                                    .hospitalizedData['Id_Cama']
                                    .toString(),
                                style: Styles.textSyleGrowth(fontSize: 8)),
                          ),
                        ),
                      )),
            ),
          )
        : Paneles.HospitalaryPendientes(context, foundedItems);
  }

  // VARIABLES *******************************************************
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
  //
}
