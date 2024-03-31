import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/operativity/pacientes/valores/semiologia/semiotica.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/semiologicos.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/terapias.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ExploracionFisica extends StatefulWidget {
  bool? isTerapia;

  ExploracionFisica({super.key, this.isTerapia = false});

  @override
  State<ExploracionFisica> createState() => _ExploracionFisicaState();
}

class _ExploracionFisicaState extends State<ExploracionFisica> {
  var expoTextController = TextEditingController();
  var vitalTextController = TextEditingController();

  var scrollSignoController = ScrollController();
  var scrollExpoController = ScrollController();

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
                          ? 16
                          : 7,
                  child: isMobile(context)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: isDesktop(context) ? 4 : 7,
                              child: EditTextArea(
                                  textController: vitalTextController,
                                  labelEditText: "Signos Vitales",
                                  keyBoardType: TextInputType.multiline,
                                  fontSize: isTablet(context) ? 12 : 8,
                                  numOfLines: isTablet(context) ? 12 : 10,
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
            flex: widget.isTerapia! ? 8 : 17, // 6
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: isLargeDesktop(context) ? 12 : 7,
                  child: EditTextArea(
                      textController: expoTextController,
                      labelEditText: "Exploración física",
                      keyBoardType: TextInputType.multiline,
                      fontSize: isTablet(context) ? 12 : 8,
                      numOfLines: widget.isTerapia!
                          ? 60
                          : isTablet(context)
                              ? 30
                              : 20,
                      onChange: ((value) => setState(() {
                        expoTextController.text = Reportes.reportes['Exploracion_Fisica'] =
                                Reportes.exploracionFisica = value;
                          })),
                      inputFormat: MaskTextInputFormatter()),
                ),
                widget.isTerapia!
                    ? Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: GrandIcon(
                                iconData: Icons.tire_repair_outlined,
                                labelButton: "Análisis",
                                onPress: () => setState(() {
                                  //
                                  expoTextController.text =
                                      Reportes.exploracionFisica =
                                  Reportes.reportes['Exploracion_Fisica'] =
                                      Formatos.exploracionTerapia;
                                })),
                            ),
                            Expanded(
                              flex: 1,
                              child: GrandIcon(
                                iconData: Icons.account_balance_wallet_outlined,
                                labelButton: "Analisis Corto",
                                  onPress: () => setState(() {
                                    //
                                    expoTextController.text =
                                        Reportes.exploracionFisica =
                                    Reportes.reportes['Exploracion_Fisica'] = Formatos.exploracionTerapiaCorta;
                                  })),
                              ),
                            Expanded(
                              flex: 1,
                              child: GrandIcon(
                                iconData: Icons.streetview,
                                labelButton: "Analisis Corto",
                                  onPress: () => setState(() {
                                    //
                                    expoTextController.text =
                                        Reportes.exploracionFisica =
                                    Reportes.reportes['Exploracion_Fisica'] =
                                        Formatos.exploracionTerapiaBreve;
                                  })),
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
                            CrossLine(),
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

  otherExploreOptions() {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        controller: scrollExpoController,
        child: Column(
          children: [
            GrandButton(
              labelButton: "Exploración física",
              onPress: () => setState(() {
                asignarExploracion(indice: 1);
              }),
              onLongPress: () => setState(() {
                Operadores.openDialog(
                    context: context,
                    chyldrim: Semiologicos(),
                    onAction: () {
                      setState(() {
                        expoTextController.text =
                            Exploracion.exploracionGeneral;
                      });
                    });
              }),
            ),
            GrandButton(
              labelButton: "Exploración corta",
              onPress: () => setState(() {
                asignarExploracion(indice: 4);
              }),
            ),
            GrandButton(
              labelButton: "Exploración física extensa",
              onPress: () => setState(() {
                asignarExploracion(indice: 2);
              }),
            ),
            GrandButton(
              labelButton: "Exploración física extensa",
              onPress: () => setState(() {
                asignarExploracion(indice: 2);
              }),
            ),
            GrandButton(
              labelButton: "Analisis de terapia intensiva",
              onPress: () => setState(() {
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
            ),
            GrandButton(
              labelButton: "Patrón Neurológico",
              onPress: () => setState(() {
                asignarExploracion(indice: 5);
              }),
            ),
            //
            GrandButton(
              labelButton: "Sin hallazgos relevantes",
              onPress: () => setState(() {
                asignarExploracion(indice: 0);
              }),
            ),
          ],
        ),
      ),
    );
  }

  mobileExploreOptions() {
    return Expanded(
      flex: 1,
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 25,
        runSpacing: 15,
        children: [
          GrandIcon(
            iconData: Icons.explore,
            labelButton: "Exploración física",
            onPress: () => setState(() {
              asignarExploracion(indice: 1);
            }),
            onLongPress: () => setState(() {              Operadores.openDialog(
                context: context,
                chyldrim: Semiologicos(),
                onAction: () {
                  setState(() {
                    expoTextController.text = Exploracion.exploracionGeneral;
                  });
                });

            }),
          ),
          GrandIcon(
            iconData: Icons.data_exploration,
            labelButton: "Exploración corta",
            onPress: () => setState(() {
              asignarExploracion(indice: 4);
            }),
          ),
          GrandIcon(
            iconData: Icons.explore_outlined,
            labelButton: "Exploración física extensa",
            onPress: () => setState(() {
              asignarExploracion(indice: 2);
            }),

          ),
          GrandIcon(
            iconData: Icons.travel_explore,
            labelButton: "Exploración física extensa",
            onPress: () => setState(() {
              asignarExploracion(indice: 2);
            }),
          ),
          GrandIcon(
            iconData: Icons.travel_explore_sharp,
            labelButton: "Analisis de terapia intensiva",
            onPress: () => setState(() {
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

          ),
          GrandIcon(
            iconData: Icons.brightness_1_outlined,
            labelButton: "Patrón Neurológico",
            onPress: () => setState(() {
              asignarExploracion(indice: 5);
            }),
          ),
          GrandIcon(
            labelButton: "Sin hallazgos relevantes",
            onPress: () => setState(() {
              asignarExploracion(indice: 0);
            }),
          ),
        ],
      ),
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
              ? 4
              : 1,
      child: Wrap(
        direction: isLargeDesktop(context) ? Axis.horizontal : Axis.horizontal,
        alignment: WrapAlignment.spaceBetween,
        spacing: 8,
        runSpacing: 8,
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
}

void showActivity() {}
