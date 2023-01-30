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
    Valores.sitiosCateterTenckhoff = Escalas.sitiosCateterTenckhoff[0];
    Valores.motivoProcedimiento =
        "Ministración de solución dializante en cavidad peritoneal.  ";
    Valores.complicacionesProcedimiento = 'Ninguna. ';
    Valores.pendientesProcedimiento =
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
                          tittle: 'Acceso Venoso',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.sitiosCateterTenckhoff = value;
                              reInit();
                            });
                          },
                          items: Escalas.sitiosCateterTenckhoff,
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