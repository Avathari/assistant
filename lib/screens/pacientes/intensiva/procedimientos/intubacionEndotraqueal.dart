import 'dart:typed_data';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/ShowText.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class IntubacionEndotraqueal extends StatefulWidget {
  const IntubacionEndotraqueal({Key? key}) : super(key: key);

  @override
  State<IntubacionEndotraqueal> createState() => _IntubacionEndotraquealState();
}

class _IntubacionEndotraquealState extends State<IntubacionEndotraqueal> {
  var carouselController = CarouselController();
  //
  var motivoTextController = TextEditingController();
  var complicacionesTextController = TextEditingController();
  var pendientesTextController = TextEditingController();
  //

  @override
  void initState() {
    Valores.motivoProcedimiento =
        "Protección de la vía aérea. \n Administración de oxígeno suplementario por falla respiratoria severa. ";
    Valores.complicacionesProcedimiento = 'Ninguna. ';
    Valores.pendientesProcedimiento =
    'Se deja solicitud para radiografía de tórax anteroposterior para corroborar la correcta instalación, por encima de la carina traqueal. ';

    //
    reInit();
    super.initState();
  }

  void reInit() {
    setState(() {
      motivoTextController.text = Valores.motivoProcedimiento!;
      complicacionesTextController.text = Valores.complicacionesProcedimiento!;
      pendientesTextController.text = Valores.pendientesProcedimiento!;
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
                          onChange: (value) {},
                        ),
                        const CrossLine(),
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
                              Valores.movilidadCervical = value;
                              reInit();
                            });
                          },
                          items: Escalas.movilidadCervical,
                          initialValue: Valores.movilidadCervical,
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
                              Valores.distanciaTiromentoniana = value;
                              reInit();
                            });
                          },
                          items: Escalas.distanciaTiromentoniana,
                          initialValue: Valores.distanciaTiromentoniana,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                              ? 200
                              : isMobile(context)
                              ? 100
                              : 300,
                          tittle: 'Distancia Esternomentoniana',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.distanciaEsternomentoniana = value;
                              reInit();
                            });
                          },
                          items: Escalas.distanciaEsternomentoniana,
                          initialValue: Valores.distanciaEsternomentoniana,
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
                              Valores.aperturaMandibular = value;
                              reInit();
                            });
                          },
                          items: Escalas.aperturaMandibular,
                          initialValue: Valores.aperturaMandibular,
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
                              Valores.movilidadTemporoMandibular = value;
                              reInit();
                            });
                          },
                          items: Escalas.movilidadTemporoMandibular,
                          initialValue: Valores.movilidadTemporoMandibular,
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
                              Valores.escalaMallampati = value;
                              reInit();
                            });
                          },
                          items: Escalas.escalaMallampati,
                          initialValue: Valores.escalaMallampati,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                              ? 200
                              : isMobile(context)
                              ? 100
                              : 300,
                          tittle: 'Valoración por Cormack-Lahane',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.escalaCormackLahane = value;
                              reInit();
                            });
                          },
                          items: Escalas.escalaCormackLahane,
                          initialValue: Valores.escalaCormackLahane,
                        ),
                        const CrossLine(),
                        EditTextArea(
                          labelEditText:
                              'Complicaciones durante el Procedimiento',
                          textController: complicacionesTextController,
                          keyBoardType: TextInputType.text,
                          numOfLines: 1,
                          inputFormat: MaskTextInputFormatter(),
                          onChange: (value) {},
                        ),
                        EditTextArea(
                          labelEditText:
                              'Pendientes derivados del Procedimiento',
                          textController: pendientesTextController,
                          keyBoardType: TextInputType.text,
                          numOfLines: 7,
                          inputFormat: MaskTextInputFormatter(),
                          onChange: (value) {},
                        ),
                      ],
                    ),
                  ),
                ],
                carouselController: carouselController,
                options: CarouselOptions(
                    height: isDesktop(context) ? 1000 : 500,
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
