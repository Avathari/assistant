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
                  isMobile(context)  ? mobileSignalOptions() : otherSignalOptions()

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
                        child: GrandIcon(
                          iconData: Icons.tire_repair_outlined,
                          labelButton: "Análisis",
                          onPress: () {
                            Reportes.exploracionFisica = Formatos.exploracionTerapia;
                            //
                            expoTextController.text =
                                Reportes.exploracionFisica;
                            Reportes.reportes['Exploracion_Fisica'] =
                                Reportes.exploracionFisica;
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GrandIcon(
                          iconData: Icons.account_balance_wallet_outlined,
                          labelButton: "Analisis Corto",
                          onPress: () {
                            Reportes.exploracionFisica = Formatos.exploracionTerapiaCorta;
                            //
                            expoTextController.text =
                                Reportes.exploracionFisica;
                            Reportes.reportes['Exploracion_Fisica'] =
                                Reportes.exploracionFisica;
                          },
                        ),
                      ),
                    Expanded(
                      flex: 1,
                      child: GrandIcon(
                        iconData: Icons.streetview,
                        labelButton: "Analisis Corto",
                        onPress: () {
                          Reportes.exploracionFisica = Formatos.exploracionTerapiaBreve;
                          //
                          expoTextController.text =
                              Reportes.exploracionFisica;
                          Reportes.reportes['Exploracion_Fisica'] =
                              Reportes.exploracionFisica;
                        },
                      ),
                    ),
                      CrossLine(),
                      Expanded(child: GrandIcon(labelButton: 'Ver', iconData: Icons.view_in_ar, onPress: () {
                        Datos.portapapeles(context: context, text: expoTextController.text);
                        // Operadores.notifyActivity(context: context, tittle: "Análisis de Terapia . . . ",
                        //     message: expoTextController.text);
                      },))
                  ],
                ),
                    )
                    : isMobile(context) || isTablet(context)? mobileExploreOptions() : otherExploreOptions()
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

  otherExploreOptions() {
    return Expanded(
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
    );
  }

  mobileExploreOptions() {
    return Expanded(
      flex: 1,
      child: isTablet(context) ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GrandIcon(
              iconData: Icons.explore,
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
          ),
          Expanded(
            child: GrandIcon(
              iconData: Icons.data_exploration,
              labelButton: "Exploración corta",
              onPress: () {
                asignarExploracion(indice: 4);
              },
            ),
          ),
          Expanded(
            child: GrandIcon(
              iconData: Icons.explore_outlined,
              labelButton: "Exploración física extensa",
              onPress: () {
                asignarExploracion(indice: 2);
              },
            ),
          ),
          Expanded(
            child: GrandIcon(
              iconData: Icons.travel_explore,
              labelButton: "Exploración física extensa",
              onPress: () {
                asignarExploracion(indice: 2);
              },
            ),
          ),
          Expanded(
            child: GrandIcon(
              iconData: Icons.travel_explore_sharp,
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
          ),
          Expanded(
            child: GrandIcon(
              labelButton: "Sin hallazgos relevantes",
              onPress: () {
                asignarExploracion(indice: 0);
              },
            ),
          ),
        ],
      ) : SingleChildScrollView(
        controller: scrollExpoController,
        child: Column(

          children: [
            GrandIcon(
              iconData: Icons.explore,
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
            GrandIcon(
              iconData: Icons.data_exploration,
              labelButton: "Exploración corta",
              onPress: () {
                asignarExploracion(indice: 4);
              },
            ),
            GrandIcon(
              iconData: Icons.explore_outlined,
              labelButton: "Exploración física extensa",
              onPress: () {
                asignarExploracion(indice: 2);
              },
            ),
            GrandIcon(
              iconData: Icons.travel_explore,
              labelButton: "Exploración física extensa",
              onPress: () {
                asignarExploracion(indice: 2);
              },
            ),
            GrandIcon(
              iconData: Icons.travel_explore_sharp,
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
            GrandIcon(
              labelButton: "Sin hallazgos relevantes",
              onPress: () {
                asignarExploracion(indice: 0);
              },
            ),
          ],
        ),
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
    );
  }

  mobileSignalOptions() {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        controller: scrollSignoController,
        child: Column(
          children: [
            GrandIcon(
              iconData: Icons.safety_divider,
              labelButton: "Vitales",
              onPress: () {
                asignarVitales(indice: 0);
              },
            ),
            GrandIcon(
              iconData: Icons.monitor_weight_outlined,
              labelButton: "Bioconstantes",
              onPress: () {
                asignarVitales(indice: 1);
              },
            ),
            GrandIcon(
              iconData: Icons.monitor_heart_outlined,
              labelButton: "Signos vitales",
              onPress: () {
                asignarVitales(indice: 2);
              },
            ),
            GrandIcon(
              iconData: Icons.mic_external_on,
              labelButton: "Medidas antropométricas",
              onPress: () {
                asignarVitales(indice: 3);
              },
            ),
            GrandIcon(
              iconData: Icons.align_horizontal_right_sharp,
              labelButton: "Asociado a Riesgo",
              onPress: () {
                asignarVitales(indice: 4);
              },
            ),
            GrandIcon(
              iconData: Icons.line_weight,
              labelButton: "Antropometría infantil",
              onPress: () {
                asignarVitales(indice: 5);
              },
            ),
            GrandIcon(
              iconData: Icons.accessibility,
              labelButton: "Vitales Resumido",
              onPress: () {
                asignarVitales(indice: 6);
              },
            ),
          ],
        ),
      ),
    );
  }
}


void showActivity() {}
