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

class CateterTenckhoff extends StatefulWidget {
  const CateterTenckhoff({Key? key}) : super(key: key);

  @override
  State<CateterTenckhoff> createState() => _CateterTenckhoffState();
}

class _CateterTenckhoffState extends State<CateterTenckhoff> {
  var carouselController = CarouselController();
  //
  var motivoTextController = TextEditingController();
  var complicacionesTextController = TextEditingController();
  var pendientesTextController = TextEditingController();
  //

  @override
  void initState() {
    Valores.sitiosCateterTenckhoff = Items.sitiosCateterTenckhoff[0];
    motivoTextController.text =
        "Ministración de solución dializante en cavidad peritoneal.  ";
    complicacionesTextController.text = 'Ninguna. ';
    pendientesTextController.text =
        'Iniciar diálisis peritoneal ccon solución dializante al 1.5%.\n'
        'Administrar tres recambios de enttrada por salida del liquido, y proseguir con 32 recambios '
        'de solución dializante al 1.5% con estancia de 30 minutos, realizando balances negativos. \n'
        'Posteriormente realizar recambios con solución dializante al 1.5% con estancia en cavidad de '
        '4 horas, realizando balances neutros. ';

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
      Reportes.reportes['Procedimiento_Realizado'] = Formatos.cateterTenckhoff;
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
                        const CrossLine(),
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
                              Valores.sitiosCateterTenckhoff = value;
                              reInit();
                            });
                          },
                          items: Items.sitiosCateterTenckhoff,
                          initialValue: Valores.sitiosCateterTenckhoff,
                        ),
                        const CrossLine(),
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
                            }),
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
