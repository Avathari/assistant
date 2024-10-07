import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/operativity/pacientes/valores/semiologia/semiotica.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class IntubacionEndotraqueal extends StatefulWidget {
  const IntubacionEndotraqueal({super.key});

  @override
  State<IntubacionEndotraqueal> createState() => _IntubacionEndotraquealState();
}

class _IntubacionEndotraquealState extends State<IntubacionEndotraqueal> {
  var carouselController = CarouselSliderController();
  //
  var motivoTextController = TextEditingController();
  var complicacionesTextController = TextEditingController();
  var pendientesTextController = TextEditingController();
  //

  @override
  void initState() {
    motivoTextController.text =
        "Protección de la vía aérea. \n Administración de oxígeno suplementario por falla respiratoria severa. ";
    complicacionesTextController.text = 'Ninguna. ';
    pendientesTextController.text =
        'Se deja solicitud para radiografía de tórax anteroposterior para corroborar la correcta instalación, por encima de la carina traqueal. ';

    //
    reInit();
    super.initState();
  }

  void reInit() {
    setState(() {
      Valores.motivoProcedimiento = motivoTextController.text;
      Valores.complicacionesProcedimiento = complicacionesTextController.text;
      Valores.pendientesProcedimiento = pendientesTextController.text;
      // ********* *********** ********* **** **
      Reportes.reportes['Motivo_Procedimiento'] = Valores.motivoProcedimiento;
      Reportes.reportes['Procedimiento_Realizado'] =
          Formatos.intubacionEndotraqueal;
      Reportes.reportes['Complicaciones_Procedimiento'] =
          Valores.complicacionesProcedimiento;
      Reportes.reportes['Pendientes_Procedimiento'] =
          Valores.pendientesProcedimiento;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        TittlePanel(color: Colors.black, textPanel: 'Intubación Endotraqueal'),
        // Expanded(
        //   child: SingleChildScrollView(
        //     controller: ScrollController(),
        //     scrollDirection: Axis.horizontal,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         GrandIcon(
        //           iconData: Icons.dataset,
        //           labelButton: 'Datos Iniciales',
        //           onPress: () {
        //             setState(() {
        //               carouselController.jumpToPage(0);
        //             });
        //           },
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CarouselSlider(
                items: [
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        EditTextArea(
                          labelEditText: 'Motivo del Procedimiento',
                          textController: motivoTextController,
                          keyBoardType: TextInputType.text,
                          numOfLines: 1,
                          inputFormat: MaskTextInputFormatter(),
                          onChange: (value) {
                            setState(() {
                              Valores.motivoProcedimiento = value;
                              reInit();
                            });
                          },
                        ),
                        CrossLine(),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                                  ? 200
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Movilidad Cervical',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.movilidadCervical = value;
                              reInit();
                            });
                          },
                          items: Escalas.movilidadCervical,
                          initialValue: Exploracion.movilidadCervical,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                                  ? 200
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Distancia Tiromentoniana',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.distanciaTiromentoniana = value;
                              reInit();
                            });
                          },
                          items: Escalas.distanciaTiromentoniana,
                          initialValue: Exploracion.distanciaTiromentoniana,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                                  ? 150
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Distancia Esternomentoniana',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.distanciaEsternomentoniana = value;
                              reInit();
                            });
                          },
                          items: Escalas.distanciaEsternomentoniana,
                          initialValue: Exploracion.distanciaEsternomentoniana,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                                  ? 200
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Apertura Mandibular',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.aperturaMandibular = value;
                              reInit();
                            });
                          },
                          items: Escalas.aperturaMandibular,
                          initialValue: Exploracion.aperturaMandibular,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                                  ? 200
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Protusión Mandibular',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.movilidadTemporoMandibular = value;
                              reInit();
                            });
                          },
                          items: Escalas.movilidadTemporoMandibular,
                          initialValue: Exploracion.movilidadTemporoMandibular,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                                  ? 200
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Valoración por Mallampati',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.escalaMallampati = value;
                              reInit();
                            });
                          },
                          items: Escalas.escalaMallampati,
                          initialValue: Exploracion.escalaMallampati,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                                  ? 150
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Valoración por Cormack-Lahane',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.escalaCormackLahane = value;
                              reInit();
                            });
                          },
                          items: Escalas.escalaCormackLahane,
                          initialValue: Exploracion.escalaCormackLahane,
                        ),
                        CrossLine(),
                        EditTextArea(
                          labelEditText:
                              'Complicaciones durante el Procedimiento',
                          textController: complicacionesTextController,
                          keyBoardType: TextInputType.text,
                          numOfLines: 1,
                          inputFormat: MaskTextInputFormatter(),
                          onChange: (value) {
                            setState(() {
                              Valores.complicacionesProcedimiento = value;
                              reInit();
                            });
                          },
                        ),
                        EditTextArea(
                          labelEditText:
                              'Pendientes derivados del Procedimiento',
                          textController: pendientesTextController,
                          keyBoardType: TextInputType.text,
                          numOfLines: 7,
                          inputFormat: MaskTextInputFormatter(),
                          onChange: (value) {
                            setState(() {
                              Valores.pendientesProcedimiento = value;
                              reInit();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
                carouselController: carouselController,
                options: CarouselOptions(
                    height:
                        isDesktop(context) || isTablet(context) ? 1000 : 500,
                    enableInfiniteScroll: false,
                    viewportFraction: 1.0)),
          ),
        ),
        Expanded(
            child: Row(
          children: [
            GrandButton(labelButton: 'Copiar en Portapapeles', onPress: () {})
          ],
        ))
      ],
    ));
  }
}
