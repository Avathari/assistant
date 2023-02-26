import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CateterVenosoCentral extends StatefulWidget {
  const CateterVenosoCentral({Key? key}) : super(key: key);

  @override
  State<CateterVenosoCentral> createState() => _CateterVenosoCentralState();
}

class _CateterVenosoCentralState extends State<CateterVenosoCentral> {
  var carouselController = CarouselController();
  //
  var motivoTextController = TextEditingController();
  var complicacionesTextController = TextEditingController();
  var pendientesTextController = TextEditingController();
  //

  @override
  void initState() {
    setState(() {
      Valores.sitiosCateterCentral = Items.sitiosCateterCentral[0];
      motivoTextController.text =
          "Ministración continua de líquidos parenterales.\nMinistración de fármacos intravenosos. ";
      complicacionesTextController.text = 'Ninguna. ';
      pendientesTextController.text =
          'Se deja solicitud para radiografía de tórax anteroposterior para corroborar la correcta instalación dentro del acceso vascular';
      //
      reInit();
    });
    super.initState();
  }

  void reInit() {
    setState(() {
      Valores.motivoProcedimiento = motivoTextController.text;
      Valores.complicacionesProcedimiento = complicacionesTextController.text;
      Valores.pendientesProcedimiento = pendientesTextController.text;
      // ********* *********** ********* **** ***
      Reportes.procedimientoRealizado = Formatos.cateterVenosoCentral;
    // ********* *********** ********* **** **
      Reportes.reportes['Motivo_Procedimiento'] = Valores.motivoProcedimiento;
      Reportes.reportes['Procedimiento_Realizado'] =
          Formatos.cateterVenosoCentral;
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
        TittlePanel(color: Colors.black, textPanel: 'Catéter Venoso Central'),
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
                          tittle: 'Acceso Venoso',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.sitiosCateterCentral = value;
                              reInit();
                            });
                          },
                          items: Items.sitiosCateterCentral,
                          initialValue: Valores.sitiosCateterCentral,
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
                          numOfLines: 1,
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
