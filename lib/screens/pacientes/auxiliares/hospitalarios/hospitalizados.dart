import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/actividades/pdfGenerete/PdfApi.dart';
import 'package:assistant/conexiones/actividades/pdfGenerete/pdfGenereteFormats/formatosReportes.dart';
import 'package:assistant/conexiones/actividades/wordGenerate/DocApi.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/home.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/screens/pacientes/auxiliares/hospitalarios/info/Hospitalizado.dart';
import 'package:assistant/screens/pacientes/auxiliares/hospitalarios/info/auxliarHospitalizados.dart';
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
          // title: AppBarText(appTittle),
          actions: <Widget>[
            GrandIcon(
                labelButton: 'Nuevos Hospitalizados . . . ',
                iconData: Icons.format_indent_decrease,
                iconColor: Colors.white,
                onPress: () => Cambios.toNextActivity(context,
                    chyld: Paneles.HospitalaryNewbies())),
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

      // ignore: use_build_context_synchronously
      if (response == true)
        Cambios.toNextPage(context, VisualPacientes(actualPage: 0));
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
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Paneles.fichaIdentificacion(snapshot, index),
                          Expanded(
                              child:
                                  Paneles.padesView(context, snapshot, index)),
                        ],
                      ),
                    ),
                    CrossLine(),
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
                      onChangeValue: () async {
                        await snapshot.data![index]
                            .getParaclinicosHistorial()
                            .then((response) async => setState(
                                () => // Terminal.printNotice(message: response.toString());
                                    Pacientes.Paraclinicos = snapshot
                                        .data![index].paraclinicos = response));
                      },
                    ),
                  ),
                  CrossLine(thickness: 3, color: Colors.grey),
                  ValuePanel(
                    onLongPress: () async {
                      await foundedItems![index]
                          .getBalancesHistorial()
                          .whenComplete(() {
                        Datos.portapapeles(
                            context: context,
                            text: HospitalaryStrings.balancesString(
                                foundedItems![index].balances.last,
                                foundedItems,
                                index));
                      });
                    },
                    firstText: foundedItems![index].balances.isNotEmpty
                        ? foundedItems![index].balances.last[0] != null
                            ? foundedItems![index]
                                .balances
                                .last[0]['Pace_bala_Fecha']
                                .toString()
                            : foundedItems![index].balances.last != null
                                ? foundedItems![index]
                                    .balances
                                    .last['Pace_bala_Fecha']
                                    .toString()
                                : 'Sin Balance Hídrico'
                        : 'Sin Balance Hídrico',
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
                    onLongPress: () => Datos.portapapeles(
                        context: context,
                        text: HospitalaryStrings.ventilacionesString(
                            foundedItems![index].ventilaciones.last,
                            foundedItems)),
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
              flex: 5,
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
                            tittle: 'Recargar Registro . . . ',
                            iconed: Icons.recent_actors_rounded,
                            onChangeValue: () => _refreshActualList(index))),
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
                                      .getPendientesHistorial(reload: true);
// *********************************
                          String penden = "";
                          // *********************************
                          for (var i in Pacientes.Pendiente!) {
                            if (i['Pace_PEN'] !='Procedimientos') {
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
                                  "${foundedItems![index].hospitalizedData['Id_Cama']} - $penden \n"
                                      "${        Internado.getCultivos(
                                      listadoFrom: foundedItems![index].paraclinicos)}");
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
                      onChangeValue: () => _refreshActualList(index)),
                GrandIcon(
                    iconData: Icons.hourglass_bottom,
                    labelButton: 'Cutivos y Hemocultivos . . . ',
                    onPress: () => Datos.portapapeles(
                        context: context,
                        text: Internado.getCultivos(
                            listadoFrom: foundedItems![index].paraclinicos))),
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
                              flex: 8,
                              child:
                                  Paneles.fichaIdentificacion(snapshot, index)),
                          Expanded(
                              flex: 20,
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
                                    onLongPress: () => Datos.portapapeles(
                                        context: context,
                                        text: HospitalaryStrings
                                            .ventilacionesString(
                                          foundedItems![index]
                                              .ventilaciones
                                              .last,
                                          foundedItems,
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
                                          .whenComplete(() {
                                        Datos.portapapeles(
                                            context: context,
                                            text: HospitalaryStrings
                                                .balancesString(
                                                    foundedItems![index]
                                                        .balances
                                                        .last,
                                                    foundedItems,
                                                    index));
                                      });
                                    },
                                    tittle:
                                        foundedItems![index].balances.isNotEmpty
                                            ? foundedItems![index]
                                                .balances
                                                .last['Pace_bala_Fecha']
                                                .toString()
                                            : "Sin BI's",
                                  ),
                                ),
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
                          child: Paneles.paraclinicosPanel(
                              context, snapshot, index)),
                      Expanded(
                        flex: 1,
                        child: CircleIcon(
                          tittle: 'Recargar laboratorios . . . ',
                          iconed: Icons.receipt_long,
                          difRadios: 7,
                          onChangeValue: () async {
                            await snapshot.data![index]
                                .getParaclinicosHistorial()
                                .then((response) async => setState(
                                    () => // Terminal.printNotice(message: response.toString());
                                Pacientes.Paraclinicos = snapshot
                                    .data![index].paraclinicos = response));
                          },
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
                                          if (i['Pace_PEN'] !='Procedimientos') {
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
                                                "${        Internado.getCultivos(
                                                listadoFrom: foundedItems![index].paraclinicos)}");
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
                                    Pacientes.ID_Hospitalizacion =
                                        foundedItems![index]
                                            .hospitalizedData['ID_Hosp'];
                                    Operadores.openDialog(
                                        context: context,
                                        chyldrim: isMobile(context)
                                            ? const SituacionesHospitalizacion()
                                            : SingleChildScrollView(
                                                controller: ScrollController(),
                                                child:
                                                    const SituacionesHospitalizacion(),
                                              ),
                                        onAction: () {
                                          // Repositorios.actualizarRegistro();
                                        });
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
                      labelButton: "Primeros Encontrados",
                      iconData: Icons.file_present,
                      onPress: () => _reiniciar()),
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
      await hospitalized[i].getLicenciasHistorial();
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
      HospitalaryMethods.orderByCamas(foundedItems!);
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
      HospitalaryMethods.orderByCamas(foundedItems!);
      // Cerrar Operaciones.loadingActivity . . .
      Navigator.of(context).pop();
    });
  }

  //

  //
  _drawerForm(BuildContext context) {
    return Container(
      width: widget.actualLateralPage != 0
          ? isMobile(context)
              ? 270
              : 430
          : 50,
      height: isMobile(context)
          ? 850
          : 1000,
      color: Colors.black54,
      child: widget.actualLateralPage == 0
          ? Wrap(
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
            )
          : Paneles.HospitalaryPendientes(context, foundedItems),
    );
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
}
