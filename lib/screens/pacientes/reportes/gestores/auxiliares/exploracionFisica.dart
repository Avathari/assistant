import 'dart:async';
import 'dart:io';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/operativity/pacientes/valores/semiologia/semiotica.dart';
import 'package:assistant/screens/pacientes/auxiliares/detalles/menus.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/semiologicos.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/terapias.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ExploracionFisica extends StatefulWidget {
  bool? isTerapia;
  String analisisTemporalFile =
      "${Pacientes.localReportsPath}exploracionFisica.txt";

  ExploracionFisica({super.key, this.isTerapia = false});

  @override
  State<ExploracionFisica> createState() => _ExploracionFisicaState();
}

class _ExploracionFisicaState extends State<ExploracionFisica> {
  Timer? _timer; // Definir un temporizador
  //
  var expoTextController = TextEditingController();
  var vitalTextController = TextEditingController();

  var scrollSignoController = ScrollController();
  var scrollExpoController = ScrollController();

  //

  // ######################### ### # ### ############################
  // INICIO DE LAS OPERACIONES STATE() Y BUILD().
  // ######################### ### # ### ############################

  @override
  void initState() {
    setState(() {
      expoTextController.text =
          Reportes.exploracionFisica = Reportes.reportes['Exploracion_Fisica'];
      vitalTextController.text = Reportes.signosVitales;
    });
    //
    _timer = Timer.periodic(
        Duration(seconds: 7), (timer) => _saveToFile(expoTextController.text));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Expanded(
          child: Column(
        children: [
          widget.isTerapia!
              ? Container()
              : Expanded(
                  flex: isDesktop(context)
                      ? 6
                      : isMobile(context)
                          ? 6
                          : 12,
                  child: isMobile(context)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: isDesktop(context) ? 4 : 3, //7
                              child: EditTextArea(
                                  textController: vitalTextController,
                                  labelEditText: "Signos Vitales",
                                  keyBoardType: TextInputType.multiline,
                                  fontSize: isTablet(context) ? 12 : 8,
                                  numOfLines: isTablet(context)
                                      ? 12
                                      : isMobile(context)
                                          ? 7
                                          : 10,
                                  onChange: ((value) => setState(() {
                                        Reportes.signosVitales = value;
                                        Reportes.reportes['Signos_Vitales'] =
                                            value;
                                      })),
                                  inputFormat: MaskTextInputFormatter()),
                            ),
                            isMobile(context)
                                ? mobileSignalOptions()
                                : mobileSignalOptions() // otherSignalOptions
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: isDesktop(context) ? 4 : 7,
                              child: EditTextArea(
                                  textController: vitalTextController,
                                  labelEditText: "Signos Vitales",
                                  keyBoardType: TextInputType.multiline,
                                  fontSize: isTablet(context) ? 12 : 8,
                                  numOfLines: isTablet(context)
                                      ? 12
                                      : isMobile(context)
                                          ? 16
                                          : 10,
                                  onChange: ((value) => setState(() {
                                        Reportes.signosVitales = value;
                                        Reportes.reportes['Signos_Vitales'] =
                                            value;
                                      })),
                                  inputFormat: MaskTextInputFormatter()),
                            ),
                            isMobile(context)
                                ? mobileSignalOptions()
                                : mobileSignalOptions() // otherSignalOptions
                          ],
                        ),
                ),
          CrossLine(),
          Expanded(
            flex: widget.isTerapia! ? 12 : 17, // 6, 8
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: isLargeDesktop(context)
                      ? 12
                      : isDesktop(context)
                          ? 7
                          : 7, // 12
                  child: EditTextArea(
                      textController: expoTextController,
                      labelEditText: "Exploración física",
                      keyBoardType: TextInputType.multiline,
                      fontSize: isTablet(context)
                          ? 12
                          : isMobile(context)
                              ? 8
                              : 8,
                      numOfLines: widget.isTerapia!
                          ? 60
                          : isTablet(context)
                              ? 30
                              : isMobile(context)
                                  ? 80
                                  : 20,
                      onChange: ((value) => setState(() {
                            // expoTextController.text =
                            Reportes.reportes['Exploracion_Fisica'] =
                                Reportes.exploracionFisica = value;
                          })),
                      inputFormat: MaskTextInputFormatter()),
                ),
                widget.isTerapia!
                    ? Expanded(
                        flex: !isTablet(context) ? 1 : 2,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Menus.popUpTerapia(context),
                            ),

                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GrandIcon(
                                      iconData: Icons.tire_repair_outlined,
                                      labelButton: "Análisis",
                                      onPress: () => setState(() {
                                            //
                                            expoTextController.text = Reportes
                                                    .exploracionFisica =
                                                Reportes.reportes[
                                                        'Exploracion_Fisica'] =
                                                    Formatos.exploracionTerapia;
                                          })),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GrandIcon(
                                      iconData:
                                          Icons.account_balance_wallet_outlined,
                                      labelButton: "Analisis Corto",
                                      onPress: () => setState(() {
                                            //
                                            expoTextController.text = Reportes
                                                .exploracionFisica = Reportes
                                                        .reportes[
                                                    'Exploracion_Fisica'] =
                                                Formatos
                                                    .exploracionTerapiaCorta;
                                          })),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GrandIcon(
                                      iconData: Icons.streetview,
                                      labelButton: "Analisis Corto",
                                      onPress: () => setState(() {
                                            //
                                            expoTextController.text = Reportes
                                                .exploracionFisica = Reportes
                                                        .reportes[
                                                    'Exploracion_Fisica'] =
                                                Formatos
                                                    .exploracionTerapiaBreve;
                                          })),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GrandIcon(
                                      iconData: Icons.self_improvement_sharp,
                                      labelButton: "Analisis Simplificado",
                                      onPress: () => setState(() {
                                            //
                                            expoTextController.text = Reportes
                                                .exploracionFisica = Reportes
                                                        .reportes[
                                                    'Exploracion_Fisica'] =
                                                Formatos
                                                    .exploracionTerapiaCortaSimplificada;
                                          })),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Menus.popUpVentometrias(context),
                            ),
                            CrossLine(),
                            Expanded(
                                child: GrandIcon(
                              labelButton: 'Ver',
                              iconData: Icons.view_in_ar,
                              onPress: () {
                                Datos.portapapeles(
                                    context: context,
                                    text: expoTextController.text);
                                // Operadores.notifyActivity(context: context, tittle: "Análisis de Terapia . . . ",
                                //     message: expoTextController.text);
                              },
                            )),
                            CrossLine(height: 5),
                            CircleIcon(
                              iconed: Icons.travel_explore_sharp,
                              tittle: "Analisis de terapia intensiva",
                              onChangeValue: () => setState(() {
                                Operadores.openDialog(
                                    context: context,
                                    chyldrim: TerapiasItems(),
                                    onAction: () {
                                      setState(() {
                                        expoTextController.text =
                                            Reportes.exploracionFisica;
                                        Reportes.reportes[
                                                'Exploracion_Fisica'] =
                                            Reportes.exploracionFisica;
                                      });
                                    });
                                // asignarExploracion(indice: 3);
                              }),
                            ),
                            //
                            const SizedBox(height: 7),
                            Expanded(
                              child: GrandIcon(
                                iconData: Icons.linear_scale_rounded,
                                labelButton: "Actual e Historial",
                                onPress: () => setState(() {
                                  expoTextController.text =
                                      expoTextController.text +
                                          Auxiliares.getUltimo(
                                              withoutInsighs: true);
                                }),
                                onLongPress: () => setState(() {
                                  Datos.portapapeles(
                                      context: context,
                                      text: Auxiliares.historial(
                                          withoutInsighs: true));
                                }),
                              ),
                            )
                          ],
                        ),
                      )
                    : isMobile(context) || isTablet(context)
                        ? mobileExploreOptions()
                        : mobileExploreOptions() // otherExploreOptions()
              ],
            ),
          ),
        ],
      ))
    ]);
  }


  mobileExploreOptions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleIcon(
            iconed: Icons.file_open_outlined,
            tittle: "Memoria temporal . . . ",
            onChangeValue: () => _readFromFile()
                .then((onValue) => Operadores.optionsActivity(context: context,
                tittle: "Memoria temporal . . . ",
                message: onValue.toString(),
                onClose: ()=>Navigator.of(context).pop(),
                textOptionA: "¿Sobre-escribier memoria?",
                optionA: (){
                  expoTextController.text = onValue;
                  Navigator.of(context).pop();
                }
            ))),
        otherExploreOptions(context),

      ],
    );
  }

  otherSignalOptions() {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        controller: scrollSignoController,
        child: Column(
          children: [
            GrandButton(
              labelButton: "Vitales",
              onPress: () => setState(() {
                asignarVitales(indice: 0);
              }),
            ),
            GrandButton(
              labelButton: "Bioconstantes",
              onPress: () => setState(() {
                asignarVitales(indice: 1);
              }),
            ),
            GrandButton(
              labelButton: "Signos vitales",
              onPress: () => setState(() {
                asignarVitales(indice: 2);
              }),
            ),
            GrandButton(
              labelButton: "Medidas antropométricas",
              onPress: () => setState(() {
                asignarVitales(indice: 3);
              }),
            ),
            GrandButton(
              labelButton: "Asociado a Riesgo",
              onPress: () => setState(() {
                asignarVitales(indice: 4);
              }),
            ),
            GrandButton(
              labelButton: "Antropometría infantil",
              onPress: () => setState(() {
                asignarVitales(indice: 5);
              }),
            ),
            GrandButton(
              labelButton: "Vitales Resumido",
              onPress: () => setState(() {
                asignarVitales(indice: 6);
              }),
            ),
          ],
        ),
      ),
    );
  }

  mobileSignalOptions() {
    return Expanded(
      flex: isLargeDesktop(context)
          ? 3
          : isMobile(context)
              ? 2
              : 1,
      child: Wrap(
        direction: isLargeDesktop(context) ? Axis.horizontal : Axis.horizontal,
        alignment: WrapAlignment.spaceBetween,
        spacing: 10,
        runSpacing: 6,
        children: [
          GrandIcon(
            iconData: Icons.safety_divider,
            labelButton: "Vitales",
            onPress: () => setState(() {
              asignarVitales(indice: 0);
            }),
          ),
          GrandIcon(
            iconData: Icons.monitor_weight_outlined,
            labelButton: "Bioconstantes",
            onPress: () => setState(() {
              asignarVitales(indice: 1);
            }),
          ),
          GrandIcon(
            iconData: Icons.monitor_heart_outlined,
            labelButton: "Signos vitales",
            onPress: () => setState(() {
              asignarVitales(indice: 2);
            }),
          ),
          GrandIcon(
            iconData: Icons.mic_external_on,
            labelButton: "Medidas antropométricas",
            onPress: () => setState(() {
              asignarVitales(indice: 3);
            }),
          ),
          GrandIcon(
            iconData: Icons.align_horizontal_right_sharp,
            labelButton: "Asociado a Riesgo",
            onPress: () => setState(() {
              asignarVitales(indice: 4);
            }),
          ),
          GrandIcon(
            iconData: Icons.line_weight,
            labelButton: "Antropometría infantil",
            onPress: () => setState(() {
              asignarVitales(indice: 5);
            }),
          ),
          GrandIcon(
            iconData: Icons.accessibility,
            labelButton: "Vitales Resumido",
            onPress: () => setState(() {
              asignarVitales(indice: 6);
            }),
          ),
        ],
      ),
    );
  }

  //
  Widget otherExploreOptions(BuildContext context) {
    return PopupMenuButton<int>(
      tooltip: "Exploración física basado en Estructuras . . . ",
      icon: const Icon(Icons.panorama_fish_eye),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          onTap: () => asignarExploracion(indice: 1),
          child: Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: ListTile(
                leading: Icon(
                  Icons.explore,
                ),
                title: Text(
                  "Exploración física",
                  style: Styles.textSyleGrowth(fontSize: 8),
                )),
          ),
        ),
        PopupMenuItem(
          value: 1,
          onTap: () => asignarExploracion(indice: 4),
          child: Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: ListTile(
                leading: Icon(
                  Icons.data_exploration,
                ),
                title: Text(
                  "Exploración corta",
                  style: Styles.textSyleGrowth(fontSize: 8),
                )),
          ),
        ),
        PopupMenuItem(
          value: 1,
          onTap: () => asignarExploracion(indice: 1),
          child: Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: ListTile(
                leading: Icon(
                  Icons.explore_outlined,
                ),
                title: Text(
                  "Exploración física extensa",
                  style: Styles.textSyleGrowth(fontSize: 8),
                )),
          ),
        ),
        PopupMenuItem(
          value: 1,
          onTap: () => setState(() {
            Operadores.openDialog(
                context: context,
                chyldrim: TerapiasItems(),
                onAction: () {
                  setState(() {
                    expoTextController.text = Reportes.exploracionFisica;
                    Reportes.reportes['Exploracion_Fisica'] =
                        Reportes.exploracionFisica;
                  });
                });
            // asignarExploracion(indice: 3);
          }),
          child: Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: ListTile(
                leading: Icon(
                  Icons.travel_explore_sharp,
                ),
                title: Text(
                  "Analisis de terapia intensiva",
                  style: Styles.textSyleGrowth(fontSize: 8),
                )),
          ),
        ),
        PopupMenuItem(
          value: 1,
          onTap: () => setState(() {
            asignarExploracion(indice: 5);
          }),
          child: Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: ListTile(
                leading: Icon(
                  Icons.brightness_1_outlined,
                ),
                title: Text(
                  "Patrón Neurológico",
                  style: Styles.textSyleGrowth(fontSize: 8),
                )),
          ),
        ),
        PopupMenuItem(
          value: 1,
          onTap: () => asignarExploracion(indice: 1),
          child: Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: ListTile(
                leading: Icon(
                  Icons.explore,
                ),
                title: Text(
                  "Exploración",
                  style: Styles.textSyleGrowth(fontSize: 8),
                )),
          ),
        ),
        PopupMenuItem(
          value: 1,
          onTap: () => setState(() {
            asignarExploracion(indice: 0);
          }),
          child: Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: ListTile(
                leading: Icon(
                  Icons.explore,
                ),
                title: Text(
                  "Sin hallazgos relevantes",
                  style: Styles.textSyleGrowth(fontSize: 8),
                )),
          ),
        ),
      ],
      offset: const Offset(0, 100),
      color: Theming.cuaternaryColor,
      elevation: 1,
    );
  }

  // Función para guardar el texto en un archivo
  Future<void> _saveToFile(String text) async {
    // final path = await _getFilePath();
    if (text.isNotEmpty) {
      Archivos.writeInFile(text, filePath: widget.analisisTemporalFile);

      // final file = File(widget.analisisTemporalFile);
      // await file.writeAsString(text).whenComplete(
      //     () => null); // print("Texto guardado automáticamente cada 10 segundos"));
    }
  }

  // Función opcional para leer el contenido del archivo (si quieres cargarlo después)
  Future<String> _readFromFile() async {
    return Archivos.readFromFile(filePath: widget.analisisTemporalFile);
    // return await File(widget.analisisTemporalFile).readAsString();
  }

  //
  void asignarVitales({required int indice}) {
    setState(() {
      vitalTextController.text = Pacientes.signosVitales(indice: indice);
      Reportes.reportes['Signos_Vitales'] = "${vitalTextController.text}.";
      Reportes.signosVitales = vitalTextController.text;
    });
  }

  void asignarExploracion({required int indice}) {
    setState(() {
      expoTextController.text = Pacientes.exploracionFisica(indice: indice);
      Reportes.reportes['Exploracion_Fisica'] = "${expoTextController.text}.";
      Reportes.exploracionFisica = expoTextController.text;
    });
  }
}

void showActivity() {}
