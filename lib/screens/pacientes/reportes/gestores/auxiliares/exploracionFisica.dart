import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
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
      expoTextController.text = Reportes.exploracionFisica;
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
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: EditTextArea(
                            textController: vitalTextController,
                            labelEditText: "Signos Vitales",
                            keyBoardType: TextInputType.multiline,
                            numOfLines: isTablet(context) ? 12 : 10,
                            onChange: ((value) => setState(() {
                                  Reportes.signosVitales = value;
                                  Reportes.reportes['Signos_Vitales'] = value;
                                })),
                            inputFormat: MaskTextInputFormatter()),
                      ),
                      Expanded(
                        flex: 1,
                        child: SingleChildScrollView(
                          controller: scrollSignoController,
                          child: Column(
                            children: [
                              GrandButton(
                                labelButton: "Vitales",
                                onPress: () {
                                  asignarVitales(indice: 0);
                                },
                              ),
                              GrandButton(
                                labelButton: "Bioconstantes",
                                onPress: () {
                                  asignarVitales(indice: 1);
                                },
                              ),
                              GrandButton(
                                labelButton: "Signos vitales",
                                onPress: () {
                                  asignarVitales(indice: 2);
                                },
                              ),
                              GrandButton(
                                labelButton: "Medidas antropométricas",
                                onPress: () {
                                  asignarVitales(indice: 3);
                                },
                              ),
                              GrandButton(
                                labelButton: "Asociado a Riesgo",
                                onPress: () {
                                  asignarVitales(indice: 4);
                                },
                              ),
                              GrandButton(
                                labelButton: "Antropometría infantil",
                                onPress: () {
                                  asignarVitales(indice: 5);
                                },
                              ),
                              GrandButton(
                                labelButton: "Vitales Resumido",
                                onPress: () {
                                  asignarVitales(indice: 6);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          CrossLine(),
          Expanded(
            flex: widget.isTerapia! ? 8 : 4, // 6
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: EditTextArea(
                      textController: expoTextController,
                      labelEditText: "Exploración física",
                      keyBoardType: TextInputType.multiline,
                      numOfLines: widget.isTerapia!
                          ? 60
                          : isTablet(context)
                              ? 30
                              : 20,
                      onChange: ((value) => setState(() {
                            Reportes.exploracionFisica = value;
                            Reportes.reportes['Exploracion_Fisica'] = value;
                          })),
                      inputFormat: MaskTextInputFormatter()),
                ),
                widget.isTerapia!
                    ? Expanded(
                      child: Column(
                  children: [
                      Expanded(
                        flex: 1,
                        child: GrandButton(
                          labelButton: "Valores",
                          onPress: () {
                            if (!isMobile(context)) {
                              Operadores.openDialog(
                                  context: context,
                                  chyldrim: TerapiasItems(),
                                  onAction: () {
                                    setState(() {
                                      expoTextController.text =
                                          Reportes.exploracionFisica;
                                      Reportes.reportes['Exploracion_Fisica'] =
                                          Reportes.exploracionFisica;
                                    });
                                  });
                            } else {
                              setState(() {
                                expoTextController.text =
                                    Reportes.exploracionFisica;
                                Reportes.reportes['Exploracion_Fisica'] =
                                    Reportes.exploracionFisica;
                              });
                            }
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GrandButton(
                          labelButton: "Analisis Corto",
                          onPress: () {
                            if (!isMobile(context)) {
                              Operadores.openDialog(
                                  context: context,
                                  chyldrim: TerapiasItems(esCorto: true,),
                                  onAction: () {
                                    setState(() {
                                      expoTextController.text =
                                          Reportes.exploracionFisica;
                                      Reportes.reportes['Exploracion_Fisica'] =
                                          Reportes.exploracionFisica;
                                    });
                                  });
                            } else {
                              setState(() {
                                expoTextController.text =
                                    Reportes.exploracionFisica;
                                Reportes.reportes['Exploracion_Fisica'] =
                                    Reportes.exploracionFisica;
                              });
                            }
                          },
                        ),
                      ),
                      CrossLine(),
                      Expanded(child: GrandIcon(labelButton: 'Ver', iconData: Icons.view_in_ar, onPress: () {
                        Operadores.notifyActivity(context: context, tittle: "Análisis de Terapia . . . ",
                            message: expoTextController.text);
                      },))
                  ],
                ),
                    )
                    : Expanded(
                        flex: 1,
                        child: SingleChildScrollView(
                          controller: scrollExpoController,
                          child: Column(
                            children: [
                              GrandButton(
                                labelButton: "Exploración física",
                                onPress: () {
                                  asignarExploracion(indice: 1);
                                },
                                onLongPress: () {
                                  Operadores.openDialog(context: context, chyldrim: const Semiologicos(), onAction: () {
                                    setState(() {
                                      expoTextController.text = Exploracion.exploracionGeneral;
                                    });
                                  });
                                },
                              ),
                              GrandButton(
                                labelButton: "Exploración corta",
                                onPress: () {
                                  asignarExploracion(indice: 4);
                                },
                              ),
                              GrandButton(
                                labelButton: "Exploración física extensa",
                                onPress: () {
                                  asignarExploracion(indice: 2);
                                },
                              ),
                              GrandButton(
                                labelButton: "Exploración física extensa",
                                onPress: () {
                                  asignarExploracion(indice: 2);
                                },
                              ),
                              GrandButton(
                                labelButton: "Analisis de terapia intensiva",
                                onPress: () {
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
                                },
                              ),
                              GrandButton(
                                labelButton: "Sin hallazgos relevantes",
                                onPress: () {
                                  asignarExploracion(indice: 0);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ))
    ]);
  }

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
