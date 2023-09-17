import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/actividades/pdfGenerete/PdfApi.dart';
import 'package:assistant/conexiones/actividades/pdfGenerete/pdfGenereteFormats/formatosReportes.dart';
import 'package:assistant/conexiones/actividades/wordGenerate/DocApi.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/home.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/padecimientoActual.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/situacionesHospitalizacion.dart';
import 'package:assistant/screens/pacientes/pacientes.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Hospitalizados extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Pace_APP_ALE";
  // ****************** *** ****** **************

  Hospitalizados({Key? key, this.actualSidePage}) : super(key: key);

  @override
  State<Hospitalizados> createState() => _HospitalizadosState();
}

class _HospitalizadosState extends State<Hospitalizados> {
  String appTittle = "Gestion de pacientes hospitalizados";
  String searchCriteria = "Buscar por Fecha";
  String? consultQuery = Pacientes.pacientes['consultHospitalized'];

  late List? foundedItems = [], firstFounded = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  var fileAssocieted = 'assets/vault/hospitalized.json';
  List<String> auxiliarServicios = [];

  @override
  void initState() {
    for (var element in Escalas.serviciosHospitalarios) {
      auxiliarServicios.add(element.toString());
    }

    Terminal.printWarning(message: " . . . Iniciando Actividad ");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        foundedItems = value;
        firstFounded = value;
      });
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "Error : $error");
      _pullListRefresh();
    });
    Terminal.printWarning(message: " . . . Actividad Iniciada");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Contextos.contexto = context;
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            },
          ),
          title: AppBarText(appTittle),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.dataset,
              ),
              tooltip: "Primeros Encontrados",
              onPressed: () {
                _reiniciar();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.replay_outlined,
              ),
              tooltip: Sentences.reload,
              onPressed: () {
                _pullListRefresh();
              },
            ),
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
                //   paraph: foundedItems!,
                //   content:  FormatosReportes.censoSimpleHospitalario(
                //       foundedItems!),
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
          Row(
            children: [
              Expanded(
                flex: 7,
                child: EditTextArea(
                  labelEditText: 'Buscar por Servicio',
                  textController: searchTextController,
                  keyBoardType: TextInputType.text,
                  inputFormat: MaskTextInputFormatter(),
                  iconColor: Colors.grey,
                  numOfLines: 1,
                  selection: true,
                  withShowOption: true,
                  onSelected: () {
                    Operadores.selectOptionsActivity(
                        context: context,
                        options: Listas.listWithoutRepitedValues(
                          Listas.listFromMapWithOneKey(foundedItems!,
                              keySearched: 'Serve_Trat'),
                        ),
                        onClose: (value) {
                          List results = [];
                          results = Listas.listFromMap(
                              lista: foundedItems!,
                              keySearched: 'Serve_Trat',
                              elementSearched: value);
                          setState(() {
                            foundedItems = results;
                          });
                          Navigator.of(context).pop();
                        });
                  },
                ),
              ),
              Expanded(
                  child: GrandIcon(
                iconData: Icons.dataset,
                labelButton: "Primeros Encontrados",
                onPress: () {
                  _reiniciar();
                },
              ))
            ],
          ),
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
                    return GridView.builder(
                      padding: const EdgeInsets.all(10.0),
                      gridDelegate: GridViewTools.gridDelegate(
                        crossAxisCount: isMobile(context) ? 1 : 1,
                        mainAxisExtent: isMobile(context) ? 600 : 290,
                      ),
                      controller: ScrollController(),
                      shrinkWrap: false,
                      itemCount:
                          snapshot.data == null ? 0 : snapshot.data.length,
                      itemBuilder: (context, posicion) {
                        return itemListView(snapshot, posicion, context);
                      },
                    );
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
    );
  }

  // Operadores de Interfaz ********* ************ ******** *
  GestureDetector itemListView(
      AsyncSnapshot snapshot, int posicion, BuildContext context) {
    if (isMobile(context)) {
      Terminal.printWhite(message: snapshot.data[
      posicion].keys.toString());
      return GestureDetector(
        onTap: () {
          // Terminal.printExpected(
          //     message: "${snapshot.data[posicion]['Pendientes']}");
        },
        onDoubleTap: () {
          Pacientes.ID_Paciente = snapshot.data[posicion]['ID_Pace'];
          Pacientes.Paciente = snapshot.data[posicion];

          Pacientes.fromJson(snapshot.data[posicion]);

          toVisual(context, Constantes.Update);
        },
        child: Container(
          decoration: ContainerDecoration.roundedDecoration(),
          padding: const EdgeInsets.all(10.0),
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
                              snapshot.data[posicion]['Id_Cama'].toString(),
                              style: Styles.textSyleGrowth(fontSize: 18)),
                        )),
                    Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 10,
                          child: Text(
                              snapshot.data[posicion]['Id_Cama'].toString(),
                              style: Styles.textSyleGrowth(fontSize: 10)),
                        )),
                    Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 10,
                          child: Text(
                              snapshot.data[posicion]['Id_Cama'].toString(),
                              style: Styles.textSyleGrowth(fontSize: 10)),
                        )),
                    Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 10,
                          child: Text(
                              snapshot.data[posicion]['Id_Cama'].toString(),
                              style: Styles.textSyleGrowth(fontSize: 10)),
                        )),
                    IconButton(
                      color: Colors.grey,
                      icon: const Icon(Icons.update_rounded),
                      onPressed: () {
                        Pacientes.ID_Paciente =
                            snapshot.data[posicion]['ID_Pace'];
                        Pacientes.Paciente = snapshot.data[posicion];

                        Pacientes.fromJson(snapshot.data[posicion]);

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
                  decoration: ContainerDecoration.roundedDecoration(),
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 6, bottom: 8),
                  margin: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 6, bottom: 2),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 17,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${snapshot.data[posicion]['Pace_Ape_Pat'] ?? ''} "
                                            "${snapshot.data[posicion]['Pace_Ape_Mat'] ?? ''} "
                                            "${snapshot.data[posicion]['Pace_Nome_PI']} "
                                            "${snapshot.data[posicion]['Pace_Nome_SE']}",
                                            maxLines: 2,
                                            style:
                                                Styles.textSyleGrowth(fontSize: 14)),
                                        // Text(
                                        //   "Hemotipo: ${snapshot.data[posicion]['Pace_Hemo'] ?? ''}",
                                        //   maxLines: 2,
                                        //   style: Styles.textSyleGrowth(fontSize: 10),
                                        // ),
                                        Text(
                                          "Servicio: ${snapshot.data[posicion]['Serve_Trat'] ?? ''}",
                                          maxLines: 2,
                                          style: Styles.textSyleGrowth(fontSize: 10),
                                        ),
                                        // Text(
                                        //   "${snapshot.data[posicion]['Medi_Trat'] ?? ''}",
                                        //   maxLines: 2,
                                        //   overflow: TextOverflow.ellipsis,
                                        //   style: Styles.textSyleGrowth(fontSize: 10),
                                        // ),
                                        Text(
                                            "D.E.H.: ${snapshot.data[posicion]['Dia_Estan'] ?? '0'}",
                                            style:
                                                Styles.textSyleGrowth(fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 6,
                                      child: Container(
                                        padding: const EdgeInsets.all(10.0),
                                        margin: const EdgeInsets.all(5.0),
                                        height: 550,
                                        decoration:
                                            ContainerDecoration.roundedDecoration(),
                                        child: SingleChildScrollView(
                                          controller: ScrollController(),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onDoubleTap: () {
                                                  Operadores.openWindow(
                                                      context: context,
                                                      chyldrim: Center(
                                                        child: Text(
                                                          snapshot.data[posicion][
                                                                      'Padecimiento'] ==
                                                                  null
                                                              ? 'Sin Padecimiento Actual'
                                                              : "PA: ${snapshot.data[posicion]['Padecimiento']['Padecimiento_Actual'] ?? ''}",
                                                          maxLines: 10,
                                                          softWrap: true,
                                                          style:
                                                              Styles.textSyleGrowth(
                                                                  fontSize: 14),
                                                          textAlign:
                                                              TextAlign.justify,
                                                        ),
                                                      ));
                                                },
                                                child: Text(
                                                  snapshot.data[posicion]
                                                              ['Padecimiento'] ==
                                                          null
                                                      ? 'Sin Padecimiento Actual'
                                                      : "PA: ${snapshot.data[posicion]['Padecimiento']['Padecimiento_Actual'] ?? ''}",
                                                  maxLines: 10,
                                                  style: Styles.textSyleGrowth(
                                                      fontSize: 10),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            CrossLine(),
                            // Expanded(
                            //   flex: 14,
                            //   child: Container(
                            //     padding: const EdgeInsets.only(
                            //         left: 2, right: 2, top: 2, bottom: 2),
                            //     margin: const EdgeInsets.only(
                            //         left: 2, right: 2, top: 2, bottom: 2),
                            //     decoration: ContainerDecoration.roundedDecoration(),
                            //     child: Column(
                            //       children: [
                            //         Expanded(
                            //           flex: 3,
                            //           child: ValuePanel(
                            //               secondText: snapshot.data[posicion]
                            //                           ['Situaciones']
                            //                       ['Disp_Oxigen'] ??
                            //                   ''),
                            //         ),
                            //         Expanded(
                            //           flex: 4,
                            //           child: GridView(
                            //             gridDelegate:
                            //                 GridViewTools.gridDelegate(
                            //                     crossAxisCount: 3,
                            //                     crossAxisSpacing: 5.0,
                            //                     mainAxisExtent: 65),
                            //             children: [
                            //               ValuePanel(
                            //                 firstText: 'CVP',
                            //                 secondText: Dicotomicos.fromInt(
                            //                         snapshot.data[posicion][
                            //                                     'Situaciones']
                            //                                 ['CVP'] ??
                            //                             0)
                            //                     .toString(),
                            //               ),
                            //               ValuePanel(
                            //                 firstText: 'CVLP',
                            //                 secondText: Dicotomicos.fromInt(
                            //                         snapshot.data[posicion][
                            //                                     'Situaciones']
                            //                                 ['CVLP'] ??
                            //                             0)
                            //                     .toString(),
                            //               ),
                            //               ValuePanel(
                            //                 firstText: 'CVC',
                            //                 secondText: Dicotomicos.fromInt(
                            //                         snapshot.data[posicion][
                            //                                     'Situaciones']
                            //                                 ['CVC'] ??
                            //                             0)
                            //                     .toString(),
                            //               ),
                            //               ValuePanel(
                            //                 firstText: 'MAH',
                            //                 secondText: Dicotomicos.fromInt(
                            //                         snapshot.data[posicion][
                            //                                     'Situaciones']
                            //                                 ['MAH'] ??
                            //                             0)
                            //                     .toString(),
                            //               ),
                            //               ValuePanel(
                            //                 firstText: 'FOL',
                            //                 secondText: Dicotomicos.fromInt(
                            //                         snapshot.data[posicion][
                            //                                     'Situaciones']
                            //                                 ['S_Foley'] ??
                            //                             0)
                            //                     .toString(),
                            //               ),
                            //               ValuePanel(
                            //                 firstText: 'SNG',
                            //                 secondText: Dicotomicos.fromInt(
                            //                         snapshot.data[posicion][
                            //                                     'Situaciones']
                            //                                 ['SNG'] ??
                            //                             0)
                            //                     .toString(),
                            //               ),
                            //               ValuePanel(
                            //                 firstText: 'SOG',
                            //                 secondText: Dicotomicos.fromInt(
                            //                         snapshot.data[posicion][
                            //                                     'Situaciones']
                            //                                 ['SOG'] ??
                            //                             0)
                            //                     .toString(),
                            //               ),
                            //               ValuePanel(
                            //                 firstText: 'DRE',
                            //                 secondText: Dicotomicos.fromInt(
                            //                         snapshot.data[posicion][
                            //                                     'Situaciones']
                            //                                 ['Drenaje'] ??
                            //                             0)
                            //                     .toString(),
                            //               ),
                            //               ValuePanel(
                            //                 firstText: 'SEP',
                            //                 secondText: Dicotomicos.fromInt(
                            //                         snapshot.data[posicion][
                            //                                     'Situaciones']
                            //                                 ['Pleuro_Vac'] ??
                            //                             0)
                            //                     .toString(),
                            //               ),
                            //               ValuePanel(
                            //                 firstText: 'COL',
                            //                 secondText: Dicotomicos.fromInt(
                            //                         snapshot.data[posicion][
                            //                                     'Situaciones']
                            //                                 ['Colostomia'] ??
                            //                             0)
                            //                     .toString(),
                            //               ),
                            //               ValuePanel(
                            //                 firstText: 'GAS',
                            //                 secondText: Dicotomicos.fromInt(
                            //                         snapshot.data[posicion][
                            //                                     'Situaciones']
                            //                                 [
                            //                                 'Gastrostomia'] ??
                            //                             0)
                            //                     .toString(),
                            //               ),
                            //               ValuePanel(
                            //                 firstText: 'TEN',
                            //                 secondText: Dicotomicos.fromInt(
                            //                         snapshot.data[posicion][
                            //                                     'Situaciones']
                            //                                 [
                            //                                 'Dialisis_Peritoneal'] ??
                            //                             0)
                            //                     .toString(),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: TittlePanel(
                                padding: 0,
                                textPanel: "LAB's",
                              ),
                            ),
                            Expanded(
                              flex: 10,
                              child: GridView.builder(
                                  padding: const EdgeInsets.all(2),
                                  gridDelegate:
                                  GridViewTools.gridDelegate(
                                      crossAxisCount: 1,
                                      mainAxisSpacing: 5.0,
                                      mainAxisExtent: 55),
                                  itemCount: Listas
                                      .listWithoutRepitedValues(Listas
                                      .listFromMapWithOneKey(
                                      snapshot.data[
                                      posicion]
                                      ['Auxiliares']))
                                      .length,
                                  // snapshot.data[posicion]['Auxiliares'].length,
                                  itemBuilder:
                                      (BuildContext context, index) {
                                    var list = Listas
                                        .listWithoutRepitedValues(Listas
                                        .listFromMapWithOneKey(
                                        snapshot.data[posicion]
                                        ['Auxiliares']));
                                    return ValuePanel(
                                      fontSize: 8,
                                      secondText:
                                      "${list[index]}", // Resultado
                                      withEditMessage: true,
                                      onEdit: (value) {
                                        Pacientes.Paraclinicos =
                                        snapshot.data[posicion]
                                        ['Auxiliares'];

                                        Terminal.printExpected(
                                            message:
                                            "snapshot.data[posicion]['Auxiliares'] ${snapshot.data[posicion]['Auxiliares']}");

                                        Datos.portapapeles(
                                            context: context,
                                            text: Auxiliares.porFecha(
                                                fechaActual: value));
                                      },
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],

                  ),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Crónico(s) ",
                                style: Styles.textSyleGrowth(fontSize: 12),
                              ),
                              CrossLine(),
                              Expanded(
                                flex: 2,
                                child: ListView.builder(
                                    itemCount:
                                        snapshot.data[posicion]['Cronicos'].length,
                                    itemBuilder: (BuildContext context, ind) {
                                      return Text(
                                        snapshot.data[posicion]['Cronicos'][ind]
                                            ['Pace_APP_DEG'],
                                        style: Styles.textSyleGrowth(fontSize: 9),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Diagnóstico(s) ",
                                style: Styles.textSyleGrowth(fontSize: 12),
                              ),
                              CrossLine(),
                              Expanded(
                                flex: 2,
                                child: ListView.builder(
                                    itemCount: snapshot
                                        .data[posicion]['Diagnosticos'].length,
                                    itemBuilder: (BuildContext context, ind) {
                                      return Text(
                                        snapshot.data[posicion]['Diagnosticos'][ind]
                                            ['Pace_APP_DEG'],
                                        style: Styles.textSyleGrowth(fontSize: 9),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pendientes(s) ",
                          style: Styles.textSyleGrowth(fontSize: 12),
                        ),
                        CrossLine(),
                        Expanded(
                          child: ListView.builder(
                              itemCount:
                                  snapshot.data[posicion]['Pendientes'].length,
                              itemBuilder: (BuildContext context, ind) {
                                return Text(
                                  snapshot.data[posicion]['Pendientes'][ind]
                                      ['Pace_Desc_PEN'],
                                  style: Styles.textSyleGrowth(fontSize: 9),
                                );
                              }),
                        ),
                        const SizedBox(height: 4),
                        // Text(
                        //   "Diagnóstico(s) ",
                        //   style: Styles.textSyleGrowth(fontSize: 12),
                        // ),
                        // CrossLine(),
                        // Expanded(
                        //   child: ListView.builder(
                        //       itemCount: snapshot.data[posicion]['Diagnosticos'].length,
                        //       itemBuilder: (BuildContext context, ind) {
                        //         return Text(snapshot.data[posicion]['Diagnosticos'][ind]
                        //         ['Pace_APP_DEG'], style: Styles.textSyleGrowth(fontSize: 9),);
                        //       }),
                        // ),
                      ],
                    ),
                  )),
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
                              Pacientes.ID_Hospitalizacion =
                              snapshot.data[posicion]['ID_Hosp'];
                              String cronicos = "";

                              if (snapshot.data[posicion]['Cronicos'] == []) {
                                cronicos =
                                'Sin Antecedentes Crónicos Documentados';
                              } else {
                                for (var i in snapshot.data[posicion]
                                ['Cronicos']) {
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
                                  "${snapshot.data[posicion]['Pace_NSS']} ${snapshot.data[posicion]['Pace_AGRE']}\n"
                                      "${"${snapshot.data[posicion]['Pace_Ape_Pat']} ${snapshot.data[posicion]['Pace_Ape_Mat']} ${snapshot.data[posicion]['Pace_Nome_PI']} ${snapshot.data[posicion]['Pace_Nome_SE']}\n".toUpperCase()}"
                                      "Edad ${snapshot.data[posicion]['Pace_Eda']} Años\n"
                                      "FN: ${snapshot.data[posicion]['Feca_INI_Hosp']} : "
                                      "${DateTime.now().difference(DateTime.parse(snapshot.data[posicion]['Feca_INI_Hosp'])).inDays} DEH"
                                      "\n____________________________\n\n"
                                      "$cronicos\n");
                            }),
                        GrandIcon(
                            iconData: Icons.medication_outlined,
                            labelButton: 'Padecimiento Actual',
                            onPress: () {
                              Pacientes.ID_Hospitalizacion =
                              snapshot.data[posicion]['ID_Hosp'];
                              String pades = "No hay padecimiento Descrito\n",
                                  diagos = "",
                                  previos = "";
                              // ************************
                              if (snapshot.data[posicion]['Padecimiento'] !=
                                  null) {
                                if (snapshot.data[posicion]['Padecimiento']
                                ['Contexto'] !=
                                    null &&
                                    snapshot.data[posicion]['Padecimiento']
                                    ['Contexto'] !=
                                        [] &&
                                    snapshot.data[posicion]['Padecimiento']
                                    ['Contexto'] !=
                                        "") {
                                  pades =
                                  "${snapshot.data[posicion]['Padecimiento']['Contexto']}\n";
                                } else {
                                  pades = "No hay padecimiento Descrito\n";
                                }
                              }
                              for (var i in snapshot.data[posicion]
                              ['Diagnosticos']) {
                                diagos =
                                "$diagos${i['Pace_APP_DEG'].toUpperCase()} -\n\t${i['Pace_APP_DEG_com']}\n";
                              }
                              for (var i in snapshot.data[posicion]
                              ['Cronicos']) {
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
                            onPress: () {
                              Pacientes.Paraclinicos =
                              snapshot.data[posicion]['Auxiliares'];
                              // ***************************************************
                              Datos.portapapeles(
                                  context: context,
                                  text:
                                  Auxiliares.historial(esAbreviado: true));
                            }),
                        GrandIcon(
                            labelButton: "Historial de Imagenologicos",
                            iconData: Icons.recent_actors_outlined,
                            onPress: () {
                              Pacientes.Imagenologicos =
                              snapshot.data[posicion]['Imagenologicos'];
                              // ***************************************************
                              Datos.portapapeles(
                                  context: context,
                                  text: Imagenologias.historial());
                            }),
                        GrandIcon(
                            labelButton: "Historial de Electrocardiogramas",
                            iconData: Icons.monitor_heart_outlined,
                            onPress: () {
                              Pacientes.Electros = snapshot.data[posicion]
                              ['Electrocardiogramas'];
                              // ***************************************************
                              Datos.portapapeles(
                                  context: context,
                                  text: Electrocardiogramas.historial());
                            }),
                        GrandIcon(
                            labelButton: "Pendientes . . . ",
                            iconData: Icons.list_alt,
                            onPress: () {
                              Pacientes.Pendiente =
                              snapshot.data[posicion]['Pendientes'];
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
                                  context: context, text: "${snapshot.data[posicion]['Id_Cama']} - $penden");
                            }),
                      ],
                    ),
                  )),
              Expanded(child: CrossLine()),
              Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GrandIcon(
                          iconData: Icons.medical_information_outlined,
                          labelButton: 'Padecimiento Actual',
                          onPress: () {
                            Pacientes.ID_Hospitalizacion =
                            snapshot.data[posicion]['ID_Hosp'];
                            Operadores.openDialog(
                                context: context,
                                chyldrim: const PadecimientoActual(),
                                onAction: () {
                                  // Repositorios.actualizarRegistro();
                                });
                          }),
                      GrandIcon(
                          iconData: Icons.medical_information_outlined,
                          labelButton: 'Pendientes . . . ',
                          onPress: () {
                            Pacientes.ID_Hospitalizacion =
                            snapshot.data[posicion]['ID_Hosp'];
                            Pacientes.Pendiente =
                            snapshot.data[posicion]['Pendientes'];
                            // Terminal.printData(message: "${Pacientes.Pendiente}");
                            // ************************************
                            Widget contet = ListView.separated(
                                controller: ScrollController(),
                                itemBuilder: ((context, index) {
                                  return ListTile(
                                    isThreeLine: false,
                                    title: Text(
                                      Pacientes.Pendiente![index]['Pace_PEN'],
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      Pacientes.Pendiente![index]['Pace_Desc_PEN'],
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  );
                                }),
                                separatorBuilder: (context, index) => const SizedBox(
                                  height: 0,
                                ),
                                itemCount: Pacientes.Pendiente!.length);
                            // ************************************
                            Operadores.openDialog(
                                context: context,
                                chyldrim: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: contet,
                                )
                                ,onAction: () {});
                          }),
                      GrandIcon(
                          iconData: Icons.monitor_weight_outlined,
                          labelButton: 'Estado General . . . ',
                          onPress: () {
                            Pacientes.ID_Hospitalizacion =
                            snapshot.data[posicion]['ID_Hosp'];
                            Operadores.openDialog(
                                context: context,
                                chyldrim: isMobile(context) ? const SituacionesHospitalizacion() : SingleChildScrollView(
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
    } else {
      return GestureDetector(
        onTap: () {
          Terminal.printExpected(
              message: "${snapshot.data[posicion]['Pendientes']}");
        },
        onDoubleTap: () {
          Pacientes.ID_Paciente = snapshot.data[posicion]['ID_Pace'];
          Pacientes.Paciente = snapshot.data[posicion];

          Pacientes.fromJson(snapshot.data[posicion]);

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
                        flex: 2,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 50,
                          child: Text(
                              snapshot.data[posicion]['Id_Cama'].toString(),
                              style: Styles.textSyleGrowth(fontSize: 18)),
                        )),
                    Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 15,
                          child: Text(
                              snapshot.data[posicion]['Id_Cama'].toString(),
                              style: Styles.textSyleGrowth(fontSize: 10)),
                        )),
                    Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 15,
                          child: Text(
                              snapshot.data[posicion]['Id_Cama'].toString(),
                              style: Styles.textSyleGrowth(fontSize: 10)),
                        )),                    Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 15,
                          child: Text(
                              snapshot.data[posicion]['Id_Cama'].toString(),
                              style: Styles.textSyleGrowth(fontSize: 10)),
                        )),
                    IconButton(
                      color: Colors.grey,
                      icon: const Icon(Icons.update_rounded),
                      onPressed: () {
                        Pacientes.ID_Paciente =
                            snapshot.data[posicion]['ID_Pace'];
                        Pacientes.Paciente = snapshot.data[posicion];

                        Pacientes.fromJson(snapshot.data[posicion]);

                        toVisual(context, Constantes.Update);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                flex: 5,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${snapshot.data[posicion]['Pace_Ape_Pat']} "
                                      "${snapshot.data[posicion]['Pace_Ape_Mat']} "
                                      "${snapshot.data[posicion]['Pace_Nome_PI']} "
                                      "${snapshot.data[posicion]['Pace_Nome_SE']}",
                                      maxLines: 2,
                                      style:
                                          Styles.textSyleGrowth(fontSize: 14)),
                                  // Text(
                                  //   "Hemotipo: ${snapshot.data[posicion]['Pace_Hemo'] ?? ''}",
                                  //   maxLines: 2,
                                  //   style: Styles.textSyleGrowth(fontSize: 10),
                                  // ),
                                  Text(
                                    "Servicio: ${snapshot.data[posicion]['Serve_Trat'] ?? ''}",
                                    maxLines: 2,
                                    style: Styles.textSyleGrowth(fontSize: 10),
                                  ),
                                  Text(
                                    "${snapshot.data[posicion]['Medi_Trat'] ?? ''}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Styles.textSyleGrowth(fontSize: 10),
                                  ),
                                  Text(
                                      "NG.: ${snapshot.data[posicion]['Feca_INI_Hosp'] ?? ''} - "
                                      "D.E.H.: ${snapshot.data[posicion]['Dia_Estan'] ?? ''}",
                                      style:
                                          Styles.textSyleGrowth(fontSize: 12)),
                                  CrossLine()
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 5,
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  margin: const EdgeInsets.all(5.0),
                                  height: 500,
                                  decoration:
                                      ContainerDecoration.roundedDecoration(),
                                  child: SingleChildScrollView(
                                    controller: ScrollController(),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onDoubleTap: () {
                                            Operadores.openWindow(
                                                context: context,
                                                chyldrim: Center(
                                                  child: Text(
                                                    snapshot.data[posicion][
                                                                'Padecimiento'] ==
                                                            null
                                                        ? 'Sin Padecimiento Actual'
                                                        : "Padecimiento Actual:\n ${snapshot.data[posicion]['Padecimiento']['Contexto'] ?? ''}",
                                                    maxLines: 10,
                                                    softWrap: true,
                                                    style:
                                                        Styles.textSyleGrowth(
                                                            fontSize: 14),
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                ));
                                          },
                                          child: Text(
                                            snapshot.data[posicion]
                                                        ['Padecimiento'] ==
                                                    null
                                                ? 'Sin Padecimiento Actual'
                                                : "PA: ${snapshot.data[posicion]['Padecimiento']['Contexto'] ?? ''}",
                                            maxLines: 10,
                                            style: Styles.textSyleGrowth(
                                                fontSize: 10),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      CrossLine(),
                      Expanded(
                        flex: 1,
                        child: snapshot.data[posicion]
                        ['Auxiliares'] !=
                            null
                            ? GridView.builder(
                            padding: const EdgeInsets.all(4),
                            gridDelegate:
                            GridViewTools.gridDelegate(
                                crossAxisCount: 1,
                                mainAxisExtent: 55),
                            itemCount:
                            Listas.listWithoutRepitedValues(
                                Listas.listFromMapWithOneKey(
                                    snapshot.data[
                                    posicion][
                                    'Auxiliares']))
                                .length,
                            // snapshot.data[posicion]['Auxiliares'].length,
                            itemBuilder:
                                (BuildContext context,
                                index) {
                              var list = Listas
                                  .listWithoutRepitedValues(Listas
                                  .listFromMapWithOneKey(
                                  snapshot.data[
                                  posicion][
                                  'Auxiliares']));
                              return ValuePanel(
                                secondText:
                                "${list[index]}", // Resultado
                                withEditMessage: true,
                                onEdit: (value) {
                                  Pacientes.Paraclinicos =
                                  snapshot.data[posicion]
                                  ['Auxiliares'];

                                  Terminal.printExpected(
                                      message:
                                      "snapshot.data[posicion]['Auxiliares'] ${snapshot.data[posicion]['Auxiliares']}");

                                  Datos.portapapeles(
                                      context: context,
                                      text:
                                      Auxiliares.porFecha(
                                          fechaActual:
                                          value));
                                },
                              );
                            })
                            : Container(),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 2, right: 2, top: 2, bottom: 2),
                  margin: const EdgeInsets.only(
                      left: 2, right: 2, top: 2, bottom: 2),
                  decoration: ContainerDecoration.roundedDecoration(),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ValuePanel(
                          secondText: snapshot.data[posicion]
                          ['Situaciones'] !=
                              null
                              ? snapshot.data[posicion]
                          ['Situaciones']
                          ['Disp_Oxigen'] ??
                              ''
                              : '',
                          heigth: 20,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: GridView(
                          gridDelegate:
                          GridViewTools.gridDelegate(
                              crossAxisCount: 2,
                              crossAxisSpacing: 3.0,
                              mainAxisExtent: 55),
                          children: [
                            ValuePanel(
                              firstText: 'CVP',
                              secondText: Dicotomicos.fromInt(snapshot
                                  .data[
                              posicion]
                              ['Situaciones'] !=
                                  null
                                  ? snapshot.data[posicion][
                              'Situaciones']
                              ['CVP'] ??
                                  0
                                  : 0)
                                  .toString(),
                            ),
                            ValuePanel(
                              firstText: 'CVLP',
                              secondText: Dicotomicos.fromInt(snapshot
                                  .data[
                              posicion]
                              ['Situaciones'] !=
                                  null
                                  ? snapshot.data[posicion][
                              'Situaciones']
                              ['CVLP'] ??
                                  0
                                  : 0)
                                  .toString(),
                            ),
                            ValuePanel(
                              firstText: 'CVC',
                              secondText: Dicotomicos.fromInt(snapshot
                                  .data[
                              posicion]
                              ['Situaciones'] !=
                                  null
                                  ? snapshot.data[posicion][
                              'Situaciones']
                              ['CVC'] ??
                                  0
                                  : 0)
                                  .toString(),
                            ),
                            ValuePanel(
                              firstText: 'MAH',
                              secondText: Dicotomicos.fromInt(snapshot
                                  .data[
                              posicion]
                              ['Situaciones'] !=
                                  null
                                  ? snapshot.data[posicion][
                              'Situaciones']
                              ['MAH'] ??
                                  0
                                  : 0)
                                  .toString(),
                            ),
                            ValuePanel(
                              firstText: 'FOL',
                              secondText: Dicotomicos.fromInt(snapshot
                                  .data[
                              posicion]
                              ['Situaciones'] !=
                                  null
                                  ? snapshot.data[posicion][
                              'Situaciones']
                              ['S_Foley'] ??
                                  0
                                  : 0)
                                  .toString(),
                            ),
                            ValuePanel(
                              firstText: 'SNG',
                              secondText: Dicotomicos.fromInt(snapshot
                                  .data[
                              posicion]
                              ['Situaciones'] !=
                                  null
                                  ? snapshot.data[posicion][
                              'Situaciones']
                              ['SNG'] ??
                                  0
                                  : 0)
                                  .toString(),
                            ),
                            ValuePanel(
                              firstText: 'SOG',
                              secondText: Dicotomicos.fromInt(snapshot
                                  .data[
                              posicion]
                              ['Situaciones'] !=
                                  null
                                  ? snapshot.data[posicion][
                              'Situaciones']
                              ['SOG'] ??
                                  0
                                  : 0)
                                  .toString(),
                            ),
                            ValuePanel(
                              firstText: 'DRE',
                              secondText: Dicotomicos.fromInt(snapshot
                                  .data[
                              posicion]
                              ['Situaciones'] !=
                                  null
                                  ? snapshot.data[posicion][
                              'Situaciones']
                              ['Drenaje'] ??
                                  0
                                  : 0)
                                  .toString(),
                            ),
                            ValuePanel(
                              firstText: 'SEP',
                              secondText: Dicotomicos.fromInt(snapshot
                                  .data[
                              posicion]
                              ['Situaciones'] !=
                                  null
                                  ? snapshot.data[posicion][
                              'Situaciones']
                              ['Pleuro_Vac'] ??
                                  0
                                  : 0)
                                  .toString(),
                            ),
                            ValuePanel(
                              firstText: 'COL',
                              secondText: Dicotomicos.fromInt(snapshot
                                  .data[
                              posicion]
                              ['Situaciones'] !=
                                  null
                                  ? snapshot.data[posicion][
                              'Situaciones']
                              ['Colostomia'] ??
                                  0
                                  : 0)
                                  .toString(),
                            ),
                            ValuePanel(
                              firstText: 'GAS',
                              secondText: Dicotomicos.fromInt(snapshot
                                  .data[
                              posicion]
                              ['Situaciones'] !=
                                  null
                                  ? snapshot.data[posicion][
                              'Situaciones']
                              [
                              'Gastrostomia'] ??
                                  0
                                  : 0)
                                  .toString(),
                            ),
                            ValuePanel(
                              firstText: 'TEN',
                              secondText: Dicotomicos.fromInt(snapshot
                                  .data[
                              posicion]
                              ['Situaciones'] !=
                                  null
                                  ? snapshot.data[posicion][
                              'Situaciones']
                              [
                              'Dialisis_Peritoneal'] ??
                                  0
                                  : 0)
                                  .toString(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Crónico(s) ",
                          style: Styles.textSyleGrowth(fontSize: 12),
                        ),
                        CrossLine(),
                        Expanded(
                          child: ListView.builder(
                              itemCount:
                                  snapshot.data[posicion]['Cronicos'].length,
                              itemBuilder: (BuildContext context, ind) {
                                return Text(
                                  snapshot.data[posicion]['Cronicos'][ind]
                                      ['Pace_APP_DEG'],
                                  style: Styles.textSyleGrowth(fontSize: 9),
                                );
                              }),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Diagnóstico(s) ",
                          style: Styles.textSyleGrowth(fontSize: 12),
                        ),
                        CrossLine(),
                        Expanded(
                          child: ListView.builder(
                              itemCount: snapshot
                                  .data[posicion]['Diagnosticos'].length,
                              itemBuilder: (BuildContext context, ind) {
                                return Text(
                                  snapshot.data[posicion]['Diagnosticos'][ind]
                                      ['Pace_APP_DEG'],
                                  style: Styles.textSyleGrowth(fontSize: 9),
                                );
                              }),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Pendientes(s) ",
                          style: Styles.textSyleGrowth(fontSize: 12),
                        ),
                        CrossLine(),
                        Expanded(
                          child: ListView.builder(
                              itemCount:
                              snapshot.data[posicion]['Pendientes'].length,
                              itemBuilder: (BuildContext context, ind) {
                                return Text(
                                  snapshot.data[posicion]['Pendientes'][ind]
                                  ['Pace_Desc_PEN'],
                                  style: Styles.textSyleGrowth(fontSize: 9),
                                );
                              }),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  )),
              // Expanded(
              //     flex: 2,
              //     child: Container(
              //       margin: const EdgeInsets.all(5.0),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             "Pendientes(s) ",
              //             style: Styles.textSyleGrowth(fontSize: 12),
              //           ),
              //           CrossLine(),
              //           Expanded(
              //             child: ListView.builder(
              //                 itemCount:
              //                     snapshot.data[posicion]['Pendientes'].length,
              //                 itemBuilder: (BuildContext context, ind) {
              //                   return Text(
              //                     snapshot.data[posicion]['Pendientes'][ind]
              //                         ['Pace_Desc_PEN'],
              //                     style: Styles.textSyleGrowth(fontSize: 9),
              //                   );
              //                 }),
              //           ),
              //           const SizedBox(height: 4),
              //           // Text(
              //           //   "Diagnóstico(s) ",
              //           //   style: Styles.textSyleGrowth(fontSize: 12),
              //           // ),
              //           // CrossLine(),
              //           // Expanded(
              //           //   child: ListView.builder(
              //           //       itemCount: snapshot.data[posicion]['Diagnosticos'].length,
              //           //       itemBuilder: (BuildContext context, ind) {
              //           //         return Text(snapshot.data[posicion]['Diagnosticos'][ind]
              //           //         ['Pace_APP_DEG'], style: Styles.textSyleGrowth(fontSize: 9),);
              //           //       }),
              //           // ),
              //         ],
              //       ),
              //     )),
              Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        GrandIcon(
                            iconData: Icons.receipt,
                            labelButton: 'Antecedentes',
                            onPress: () {
                              Pacientes.ID_Hospitalizacion =
                                  snapshot.data[posicion]['ID_Hosp'];
                              String cronicos = "";

                              if (snapshot.data[posicion]['Cronicos'] == []) {
                                cronicos =
                                    'Sin Antecedentes Crónicos Documentados';
                              } else {
                                for (var i in snapshot.data[posicion]
                                    ['Cronicos']) {
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
                                      "${snapshot.data[posicion]['Pace_NSS']} ${snapshot.data[posicion]['Pace_AGRE']}\n"
                                      "${"${snapshot.data[posicion]['Pace_Ape_Pat']} ${snapshot.data[posicion]['Pace_Ape_Mat']} ${snapshot.data[posicion]['Pace_Nome_PI']} ${snapshot.data[posicion]['Pace_Nome_SE']}\n".toUpperCase()}"
                                      "Edad ${snapshot.data[posicion]['Pace_Eda']} Años\n"
                                      "FN: ${snapshot.data[posicion]['Feca_INI_Hosp']} : "
                                      "${DateTime.now().difference(DateTime.parse(snapshot.data[posicion]['Feca_INI_Hosp'])).inDays} DEH"
                                      "\n____________________________\n\n"
                                      "$cronicos\n");
                            }),
                        GrandIcon(
                            iconData: Icons.medication_outlined,
                            labelButton: 'Padecimiento Actual',
                            onPress: () {
                              Pacientes.ID_Hospitalizacion =
                                  snapshot.data[posicion]['ID_Hosp'];
                              String pades = "No hay padecimiento Descrito\n",
                                  diagos = "",
                                  previos = "";
                              // ************************
                              if (snapshot.data[posicion]['Padecimiento'] !=
                                  null) {
                                if (snapshot.data[posicion]['Padecimiento']
                                            ['Contexto'] !=
                                        null &&
                                    snapshot.data[posicion]['Padecimiento']
                                            ['Contexto'] !=
                                        [] &&
                                    snapshot.data[posicion]['Padecimiento']
                                            ['Contexto'] !=
                                        "") {
                                  pades =
                                      "${snapshot.data[posicion]['Padecimiento']['Contexto']}\n";
                                } else {
                                  pades = "No hay padecimiento Descrito\n";
                                }
                              }
                              for (var i in snapshot.data[posicion]
                                  ['Diagnosticos']) {
                                diagos =
                                    "$diagos${i['Pace_APP_DEG'].toUpperCase()} -\n\t${i['Pace_APP_DEG_com']}\n";
                              }
                              for (var i in snapshot.data[posicion]
                                  ['Cronicos']) {
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
                            onPress: () {
                              Pacientes.Paraclinicos =
                                  snapshot.data[posicion]['Auxiliares'];
                              // ***************************************************
                              Datos.portapapeles(
                                  context: context,
                                  text:
                                      Auxiliares.historial(esAbreviado: true));
                            }),
                        GrandIcon(
                            labelButton: "Historial de Imagenologicos",
                            iconData: Icons.recent_actors_outlined,
                            onPress: () {
                              Pacientes.Imagenologicos =
                                  snapshot.data[posicion]['Imagenologicos'];
                              // ***************************************************
                              Datos.portapapeles(
                                  context: context,
                                  text: Imagenologias.historial());
                            }),
                        GrandIcon(
                            labelButton: "Historial de Electrocardiogramas",
                            iconData: Icons.monitor_heart_outlined,
                            onPress: () {
                              Pacientes.Electros = snapshot.data[posicion]
                                  ['Electrocardiogramas'];
                              // ***************************************************
                              Datos.portapapeles(
                                  context: context,
                                  text: Electrocardiogramas.historial());
                            }),
                        GrandIcon(
                            labelButton: "Pendientes . . . ",
                            iconData: Icons.list_alt,
                            onPress: () {
                              Pacientes.Pendiente =
                              snapshot.data[posicion]['Pendientes'];
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
                                  context: context, text: "${snapshot.data[posicion]['Id_Cama']} - $penden");
                            }),
                      ],
                    ),
                  )),
              Expanded(
                  child: Column(
                children: [
                  GrandIcon(
                      iconData: Icons.medical_information_outlined,
                      labelButton: 'Padecimiento Actual',
                      onPress: () {
                        Pacientes.ID_Hospitalizacion =
                            snapshot.data[posicion]['ID_Hosp'];
                        Operadores.openDialog(
                            context: context,
                            chyldrim: const PadecimientoActual(),
                            onAction: () {
                              // Repositorios.actualizarRegistro();
                            });
                      }),
                  GrandIcon(
                      iconData: Icons.medical_information_outlined,
                      labelButton: 'Pendientes . . . ',
                      onPress: () {
                        Pacientes.ID_Hospitalizacion =
                        snapshot.data[posicion]['ID_Hosp'];
                        Pacientes.Pendiente =
                        snapshot.data[posicion]['Pendientes'];
                        // Terminal.printData(message: "${Pacientes.Pendiente}");
                        // ************************************
                        Widget contet = ListView.separated(
                            controller: ScrollController(),
                            itemBuilder: ((context, index) {
                              return ListTile(
                                isThreeLine: false,
                                title: Text(
                                  Pacientes.Pendiente![index]['Pace_PEN'],
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  Pacientes.Pendiente![index]['Pace_Desc_PEN'],
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              );
                            }),
                            separatorBuilder: (context, index) => const SizedBox(
                              height: 0,
                            ),
                            itemCount: Pacientes.Pendiente!.length);
                        // ************************************
                        Operadores.openDialog(
                            context: context,
                            chyldrim: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: contet,
                            )
                        ,onAction: () {});
                      }),
                  GrandIcon(
                      iconData: Icons.monitor_weight_outlined,
                      labelButton: 'Estado General . . . ',
                      onPress: () {
                        Pacientes.ID_Hospitalizacion =
                        snapshot.data[posicion]['ID_Hosp'];
                        Operadores.openDialog(
                            context: context,
                            chyldrim: isMobile(context) ? const SituacionesHospitalizacion() : SingleChildScrollView(
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
  }

  void toVisual(BuildContext context, String operationActivity) async {
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

  void toOperaciones(BuildContext context, int posicion,
      AsyncSnapshot<dynamic> snapshot, String operationActivity) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => OperacionesPacientes(
        operationActivity: operationActivity,
      ),
    ));
  }

  void _reiniciar() {
    setState(() {
      foundedItems = firstFounded;
    });
  }

  // void _runFilterSearch(String enteredKeyword) {
  //   List? results = [];
  //
  //   if (enteredKeyword.isEmpty) {
  //     _pullListRefresh();
  //   } else {
  //     Actividades.consultar(
  //             Databases.siteground_database_reghosp, consultQuery!)
  //         .then((value) {
  //       results = value
  //           .where((user) => user[widget.keySearch].contains(enteredKeyword))
  //           .toList();
  //
  //       setState(() {
  //         foundedItems = results;
  //       });
  //     });
  //   }
  // }

  Future<Null> _pullListRefresh() async {
    Terminal.printAlert(
        message: "Iniciando actividad : : \n "
            "Consulta de pacientes hospitalizados . . .");
    Operadores.loadingActivity(
        context: context,
        tittle: 'Actualizando Valores . . . ',
        message: 'Actualizando . . . ',
        onCloss: () {
          Navigator.of(context).pop();
        });
    setState(() {
      // foundedItems!.clear();
    });

    List hospitalizaed = [];

    Actividades.consultar(
      Databases.siteground_database_regpace,
      Pacientes.pacientes['consultHospitalized'],
    ).then((response) async {
      var ids = Listas.listFromMapWithOneKey(response, keySearched: 'ID_Pace');
      for (var item in ids) {
        hospitalizaed.add(await Actividades.consultarId(
          Databases.siteground_database_reghosp,
          "SELECT * FROM pace_hosp WHERE ID_Pace = ? "
          "ORDER BY ID_Hosp ASC",
          item,
        ));
      }
      // ********** ************** ***********
      for (var v = 0; v < response.length; v++) {
        if (hospitalizaed[v].keys.contains('Error')) {
          response[v].addAll({
            "ID_Hosp": 0,
            "Feca_INI_Hosp": '0000-00-00',
            "Id_Cama": 'NA',
            "Dia_Estan": 0,
            "Medi_Trat": 'N/A',
            "Serve_Trat": 'N/A',
            "Serve_Trat_INI": 'N/A',
            "Feca_EGE_Hosp": '0000-00-00',
            "EGE_Motivo": ""
          });
          response[v].addAll({
            "Ventilaciones": [],
          });
          response[v].addAll({
            "Cronicos": [],
          });
          response[v].addAll({
            "Diagnosticos": [],
          });
          response[v].addAll({
            "Pendientes": [],
          });
        } else {
          response[v].addAll(hospitalizaed[v]);

          response[v].addAll({
            "Padecimiento": await Actividades.consultarId(
              Databases.siteground_database_reghosp,
              Repositorios.repositorio['consultPadecimientoQuery'],
              response[v]['ID_Hosp'],
            ),
          });
          response[v].addAll({
            "Situaciones": await Actividades.consultarId(
                Databases.siteground_database_reghosp,
                Situaciones.situacion['consultQuery'],
                response[v]['ID_Hosp']),
          });
          response[v].addAll({
            "Ventilaciones": await Actividades.consultarId(
              Databases.siteground_database_reghosp,
              Ventilaciones.ventilacion['consultLastQuery'],
              response[v]['ID_Pace'],
            ),
          });
          response[v].addAll({
            "Cronicos": await Actividades.consultarAllById(
              Databases.siteground_database_regpace,
              "SELECT * FROM pace_app_deg WHERE ID_Pace = ? ",
              response[v]['ID_Pace'],
            ),
          });
          response[v].addAll({
            "Diagnosticos": await Actividades.consultarAllById(
              Databases.siteground_database_reghosp,
              "SELECT * FROM pace_dia WHERE ID_Pace = ? "
              "AND ID_Hosp = '${hospitalizaed[v]['ID_Hosp']}'",
              response[v]['ID_Pace'],
            ),
          });
          response[v].addAll({
            "Pendientes": await Actividades.consultarAllById(
              Databases.siteground_database_reghosp,
              "SELECT * FROM pace_pen WHERE ID_Pace = ? "
              "AND ID_Hosp = '${hospitalizaed[v]['ID_Hosp']}' "
              "AND Pace_PEN_realized = '0'",
              response[v]['ID_Pace'],
            )
          });
          // ********** ************** ***********
          response[v].addAll({
            "Auxiliares": await Actividades.consultarAllById(
              Databases.siteground_database_reggabo,
              Auxiliares.auxiliares['consultByIdPrimaryQuery'],
              response[v]['ID_Pace'],
            )
          });
          response[v].addAll({
            "Imagenologicos": await Actividades.consultarAllById(
              Databases.siteground_database_reggabo,
              Imagenologias.imagenologias['consultByIdPrimaryQuery'],
              response[v]['ID_Pace'],
            )
          });
          response[v].addAll({
            "Electrocardiogramas": await Actividades.consultarAllById(
              Databases.siteground_database_reggabo,
              Electrocardiogramas
                  .electrocardiogramas['consultByIdPrimaryQuery'],
              response[v]['ID_Pace'],
            )
          });
        }
      }
      // ********** ************** ***********
      foundedItems = response;
      setState(() {
        Terminal.printSuccess(
            message: "Actualizando pacientes hospitalizados . . . ");
        // foundedItems!.sort((a, b) => a["Id_Cama"].compareTo(b["Id_Cama"]));
        foundedItems!.sort((a, b) {
          return Items.orderOfCamas.indexOf(a['Id_Cama'].toString()) -
              Items.orderOfCamas.indexOf(b['Id_Cama'].toString());
        });
        Archivos.createJsonFromMap(foundedItems!, filePath: fileAssocieted);
        Navigator.of(context).pop();
      });
      // ********** ************** ***********
    });
  }
}
