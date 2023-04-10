import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Cardiovasculares extends StatefulWidget {
  const Cardiovasculares({Key? key}) : super(key: key);

  @override
  State<Cardiovasculares> createState() => _CardiovascularesState();
}

class _CardiovascularesState extends State<Cardiovasculares> {
  var carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TittlePanel(color: Colors.black, textPanel: 'Análisis Hemodinámico'),
        Expanded(
          child: SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GrandIcon(
                  iconData: Icons.dataset,
                  labelButton: 'Datos Iniciales',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(0);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.add_chart,
                  labelButton: 'Valores por Swan-Ganz',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(1);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.compress_outlined,
                  labelButton: 'Taller Gasométrico',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(2);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.settings_input_component_outlined,
                  labelButton: 'Taller Hemodinámico',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(3);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.data_array,
                  labelButton: 'Valores de Referencia',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(4);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CarouselSlider(
                items: [
                  Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: GridView(
                          controller: ScrollController(),
                          gridDelegate: GridViewTools.gridDelegate(
                              crossAxisCount: 5, mainAxisExtent: 66),
                          children: [
                            ValuePanel(
                              firstText: "P. Corporal",
                              secondText: Valores.pesoCorporalTotal.toString(),
                              thirdText: "Kg",
                              withEditMessage: true,
                              onEdit: (value) {
                                Operadores.editActivity(
                                    context: context,
                                    tittle: "Editar . . . ",
                                    message: "¿Peso corporal total? . . . ",
                                    onAcept: (value) {
                                      Terminal.printSuccess(
                                          message: "recieve $value");
                                      setState(() {
                                        Valores.pesoCorporalTotal =
                                            double.parse(value);
                                        Navigator.of(context).pop();
                                      });
                                    });
                              },
                            ),
                            ValuePanel(
                              firstText: "Estatura",
                              secondText: (Valores.alturaPaciente! * 100).toString(),
                              thirdText: "mts",
                              withEditMessage: true,
                              onEdit: (value) {
                                Operadores.editActivity(
                                    context: context,
                                    tittle: "Editar . . . ",
                                    message: "¿Altura del paciente? . . . ",
                                    onAcept: (value) {
                                      Terminal.printSuccess(
                                          message: "recieve $value");
                                      setState(() {
                                        Valores.alturaPaciente =
                                            double.parse(value);
                                        Navigator.of(context).pop();
                                      });
                                    });
                              },
                            ),
                            ValuePanel(
                              firstText: "Superficie Corporal",
                              secondText: Valores.SCE.toStringAsFixed(2),
                              thirdText: "m2",
                            ),
                            ValuePanel(
                              firstText: 'P.A.S.',
                              secondText: Valores.tensionArterialSystolica!
                                  .toStringAsFixed(0),
                              thirdText: 'mmHg',
                            ),
                            ValuePanel(
                              firstText: 'P.A.D.',
                              secondText: Valores.tensionArterialDyastolica!
                                  .toStringAsFixed(0),
                              thirdText: 'mmHg',
                            ),
                            ValuePanel(
                              firstText: 'P.A.M.',
                              secondText: Valores.presionArterialMedia.toStringAsFixed(0),
                              thirdText: 'mmHg',
                            ),
                            ValuePanel(
                              firstText: 'P.V.C.',
                              secondText: Valores.presionVenosaCentral!
                                  .toStringAsFixed(0),
                              thirdText: 'mmHg',
                            ),
                            ValuePanel(
                              firstText: 'Frecuencia Cardiaca',
                              secondText: Valores.frecuenciaCardiaca!
                                  .toStringAsFixed(0),
                              thirdText: 'L/min',
                            ),
                            Container(),
                            Container(),
                            ValuePanel(
                              firstText: 'PaO2',
                              secondText:
                                  Valores.poArteriales!.toStringAsFixed(2),
                              thirdText: 'mmHg',
                            ),
                            ValuePanel(
                              firstText: 'PvO2',
                              secondText: Valores.poVenosos!.toStringAsFixed(2),
                              thirdText: 'mmHg',
                            ),
                            ValuePanel(
                              firstText: 'PaCO2',
                              secondText:
                                  Valores.pcoArteriales!.toStringAsFixed(2),
                              thirdText: 'mmHg',
                            ),
                            ValuePanel(
                              firstText: 'PvCO2',
                              secondText:
                                  Valores.pcoVenosos!.toStringAsFixed(2),
                              thirdText: 'mmHg',
                            ),
                            ValuePanel(
                              firstText: 'SaO2',
                              secondText:
                                  Valores.soArteriales!.toStringAsFixed(2),
                              thirdText: '%',
                            ),
                            ValuePanel(
                              firstText: 'SvO2',
                              secondText: Valores.soVenosos!.toStringAsFixed(2),
                              thirdText: '%',
                            ),
                            Container(),
                            ValuePanel(
                              firstText: 'Hemoglobina',
                              secondText:
                                  Valores.hemoglobina!.toStringAsFixed(2),
                              thirdText: 'g/dL',
                            ),
                            Container(),
                            Container(),
                            ValuePanel(
                              firstText: 'Fecha Biometrías',
                              secondText:
                              Valores.fechaBiometria,
                            ),
                            ValuePanel(
                              firstText: 'Fecha Arteriales',
                              secondText:
                              Valores.fechaGasometriaArterial,
                            ),
                            ValuePanel(
                              firstText: 'Fecha Venosos',
                              secondText:
                              Valores.fechaGasometriaVenosa,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 5,
                    child: GridView(
                      controller: ScrollController(),
                      gridDelegate: GridViewTools.gridDelegate(
                          crossAxisCount: 5, mainAxisExtent: 66),
                      children: [
                        // Valores por Swan-Ganz
                        ValuePanel(
                          firstText: "Gasto Cardiaco",
                          secondText: Valores.gastoCardiaco.toStringAsFixed(2),
                          thirdText: "L/min",
                        ),
                        ValuePanel(
                          firstText: "PAPS", // Presión Arterial Pulmonar Sistólica
                          secondText: (Valores.presionArteriaPulmonarSistolica! * 100).toString(),
                          thirdText: "mmHg",
                        ),
                        ValuePanel(
                          firstText: "PAPD", // Presión Arterial Pulmonar Diastólica
                          secondText: Valores.presionArteriaPulmonarDiastolica!.toStringAsFixed(0),
                          thirdText: "mmHg",
                        ),
                        ValuePanel(
                          firstText: "PMAP", // Presión Media Arterial Pulmonar
                          secondText: Valores.presionMediaArteriaPulmonar!
                              .toStringAsFixed(0),
                          thirdText: 'mmHg',
                        ),
                        ValuePanel(
                          firstText: 'P.o.P.',
                          secondText: Valores.presionCunaPulmonar!
                              .toStringAsFixed(0),
                          thirdText: 'mmHg',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: GridView(
                      controller: ScrollController(),
                      gridDelegate: GridViewTools.gridDelegate(
                          crossAxisCount: 5, mainAxisExtent: 66),
                      children: [
                        ValuePanel(
                          firstText: 'PiO2',
                          secondText: Valores.PIO.toStringAsFixed(2),
                          thirdText: 'mmHg',
                        ),
                        ValuePanel(
                            firstText: 'PAO2',
                            secondText: Valores.PAO.toStringAsFixed(2),
                            thirdText: 'mmHg',
                        ),
                        ValuePanel(
                          firstText: 'GA-a O2',
                          secondText: Valores.GAA.toStringAsFixed(2),
                          thirdText: 'mmHg',
                        ),
                        ValuePanel(
                          firstText: 'VO2', // Consumo de Oxígeno
                          secondText: Valores.CO.toStringAsFixed(2),
                          thirdText: 'mL/min',
                        ),

                        ValuePanel(
                          firstText: 'CaO2', // Contenido Arterial de Oxígeno
                          secondText: Valores.CAO.toStringAsFixed(2),
                          thirdText: 'mL/O2%',
                        ),
                        ValuePanel(
                          firstText: 'CcO2', // Contenido Capilar de Oxígeno
                          secondText: Valores.CCO.toStringAsFixed(2),
                          thirdText: 'mL/O2%',
                        ),
                        ValuePanel(
                          firstText: 'CvO2', // Contenido Arterial de Oxígeno
                          secondText: Valores.CVO.toStringAsFixed(2),
                          thirdText: 'mL/O2%',
                        ),
                        ValuePanel(
                          firstText: 'Da-vO2', // Diferencia Arterio-venosa de Oxígeno
                          secondText: Valores.DAV.toStringAsFixed(2),
                          thirdText: 'mL',
                        ),
                        ValuePanel(
                          firstText: 'QS/QT', // Shunt Arterio-venoso
                          secondText: Valores.SF.toStringAsFixed(2),
                          thirdText: '%',
                        ),
                        ValuePanel(
                          firstText: 'I. V/P (Kirby)', // Shunt Arterio-venoso
                          secondText: Valores.PAFI.toStringAsFixed(0),
                        ),
                        ValuePanel(
                          firstText: '% Extracción Oxígeno',
                          secondText: Valores.IEO.toStringAsFixed(2),
                          thirdText: '%',
                        ),
                        ValuePanel(
                          firstText: 'Indice Respiratorio',
                          secondText: Valores.CI.toStringAsFixed(2),
                        ),
                        // ************************************

                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: GridView(
                      controller: ScrollController(),
                      gridDelegate: GridViewTools.gridDelegate(
                          crossAxisCount: 5, mainAxisExtent: 66),
                      children: [
                        ValuePanel(
                          firstText: 'Gasto Cardiaco (Fick)',
                          secondText: Valores.gastoCardiacoFick.toStringAsFixed(2),
                          thirdText: 'Lt/min',
                        ),
                        ValuePanel(
                          firstText: 'Indice Cardiaco',
                          secondText: Valores.indiceCardiaco.toStringAsFixed(2),
                          thirdText: 'Lt/min',
                        ),
                        ValuePanel(
                          firstText: 'Volumen Látido Sistólico',
                          secondText: Valores.VLS.toStringAsFixed(2),
                          thirdText: 'mL/Lt',
                        ),
                        ValuePanel(
                          firstText: 'I. Volumen Látido Sistólico',
                          secondText: Valores.IVL.toStringAsFixed(2),
                          thirdText: 'mL/Lt/m2',
                        ),
                        // **********************************
                        ValuePanel(
                          firstText: 'Resist. V. Sist.',
                          secondText: Valores.RVS.toStringAsFixed(2),
                          thirdText: 'dinas/seg/cm2',
                        ),
                        ValuePanel(
                          firstText: 'Trabajo Cardiaco Izquiedo',
                          secondText: Valores.TC.toStringAsFixed(2),
                          thirdText: 'Kg*m',
                        ),
                        ValuePanel(
                          firstText: 'TLVI',
                          secondText: Valores.TLVI.toStringAsFixed(2),
                          thirdText: 'g/Lat/m2',
                        ),
                        ValuePanel(
                          firstText: 'I. TLVI',
                          secondText: Valores.iTLVI.toStringAsFixed(2),
                          thirdText: 'g/Lat/m2',
                        ),


                        ValuePanel(
                          firstText: 'Disp. Oxígeno',
                          secondText: Valores.DO.toStringAsFixed(2),
                          thirdText: 'mL/min/m2',
                        ),
                        ValuePanel(
                          firstText: 'I. Disp. Oxígeno',
                          secondText: Valores.iDO.toStringAsFixed(2),
                          thirdText: 'mL/min/m2',
                        ),
                        ValuePanel(
                          firstText: 'Transporte Oxígeno',
                          secondText: Valores.TO.toStringAsFixed(2),
                          thirdText: 'mL/O2/m2',
                        ),

                        ValuePanel(
                          firstText: 'P. Fcard-TA',
                          secondText: Valores.productoFrecuenciaPresion
                              .toStringAsFixed(2),
                          thirdText: 'mmHg',
                        ),
                        ValuePanel(
                          firstText: 'P. Coloido-Osmótica',
                          secondText:
                          Valores.presionColoidoOsmotica.toStringAsFixed(2),
                          thirdText: 'mmHg',
                        ),

                        ValuePanel(
                          firstText: 'Cociente A. Oxígeno',
                          secondText: Valores.cAO.toStringAsFixed(2),
                          thirdText: '%',
                        ),
                        ValuePanel(
                          firstText: 'Cociente V. Oxígeno',
                          secondText: Valores.cVO.toStringAsFixed(2),
                          thirdText: '%',
                        ),
                      ],
                    ),
                  ),

                  GridView(
                    controller: ScrollController(),
                    gridDelegate: GridViewTools.gridDelegate(
                        crossAxisCount: 5, mainAxisExtent: 66),
                    children: [
                      ValuePanel(
                        firstText: 'Presión Barométrica',
                        secondText:
                            Valores.presionBarometrica.toStringAsFixed(0),
                        thirdText: 'mmHg',
                        withEditMessage: true,
                        onEdit: (value) {
                          Operadores.editActivity(
                              context: context,
                              keyBoardType: TextInputType.number,
                              tittle: "Editar . . . ",
                              message: "¿'Presión Barométrica? . . . ",
                              onAcept: (value) {
                                setState(() {
                                  Valores.presionBarometrica = int.parse(value);
                                  Navigator.of(context).pop();
                                });
                              });
                        },
                      ),
                      ValuePanel(
                        firstText: 'P. Vapor de Agua',
                        secondText: Valores.presionVaporAgua.toStringAsFixed(2),
                        thirdText: 'mmHg',
                        withEditMessage: true,
                        onEdit: (value) {
                          Operadores.editActivity(
                              context: context,
                              keyBoardType: TextInputType.number,
                              tittle: "Editar . . . ",
                              message: "¿P. Vapor de Agua? . . . ",
                              onAcept: (value) {
                                setState(() {
                                  Valores.presionVaporAgua = int.parse(value);
                                  Navigator.of(context).pop();
                                });
                              });
                        },
                      ),
                      ValuePanel(
                        firstText: 'FiO2 ',
                        secondText: Valores.fioArteriales!.toStringAsFixed(0),
                        thirdText: 'mmHg',
                        withEditMessage: true,
                        onEdit: (value) {
                          Operadores.editActivity(
                              context: context,
                              keyBoardType: TextInputType.number,
                              tittle: "Editar . . . ",
                              message: "¿Fracción Inspirada de Oxígeno? . . . ",
                              onAcept: (value) {
                                setState(() {
                                  Valores.fioArteriales = double.parse(value);
                                  Navigator.of(context).pop();
                                });
                              });
                        },
                      ),
                      ValuePanel(
                        firstText: 'P. Gas Seco',
                        secondText: Valores.presionGasSeco.toStringAsFixed(2),
                        thirdText: 'mmHg',
                        withEditMessage: true,
                        onEdit: (value) {
                          Operadores.editActivity(
                              context: context,
                              keyBoardType: TextInputType.number,
                              tittle: "Editar . . . ",
                              message: "¿P. Gas Seco? . . . ",
                              onAcept: (value) {
                                setState(() {
                                  Valores.presionGasSeco = int.parse(value);
                                  Navigator.of(context).pop();
                                });
                              });
                        },
                      ),
                    ],
                  ),
                ],
                carouselController: carouselController,
                options: Carousel.carouselOptions(context: context)),
          ),
        ),
        Expanded(
          child: GrandButton(
            weigth: 2000,
            labelButton: "Copiar en Portapapeles",
            onPress: () {
              Datos.portapapeles(
                  context: context, text: Valorados.cardiovasculares);
            },
          ),
        ),
      ],
    );
  }
}
