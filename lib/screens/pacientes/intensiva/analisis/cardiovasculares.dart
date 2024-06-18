import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/cardiometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/gasometricos.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/ValuePanel.dart';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Cardiovasculares extends StatefulWidget {
  double? mainAxisExtent;

  Cardiovasculares({super.key, this.mainAxisExtent = 50.0});

  @override
  State<Cardiovasculares> createState() => _CardiovascularesState();
}

class _CardiovascularesState extends State<Cardiovasculares> {
  var carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return TittleContainer(
      tittle: 'Análisis Hemodinámico',
      color: Colors.black,
      centered: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ValuePanel(
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
                            Terminal.printSuccess(message: "recieve $value");
                            setState(() {
                              Valores.pesoCorporalTotal = double.parse(value);
                              Navigator.of(context).pop();
                            });
                          });
                    },
                  ),
                ),
                Expanded(
                  child: ValuePanel(
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
                            Terminal.printSuccess(message: "recieve $value");
                            setState(() {
                              Valores.alturaPaciente = double.parse(value);
                              Navigator.of(context).pop();
                            });
                          });
                    },
                  ),
                ),
                Expanded(
                  child: ValuePanel(
                    firstText: "SC",
                    secondText: Antropometrias.SCE.toStringAsFixed(2),
                    thirdText: "m2",
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ValuePanel(
                    firstText: 'P.A.S.',
                    secondText:
                        Valores.tensionArterialSystolica!.toStringAsFixed(0),
                    thirdText: 'mmHg',
                  ),
                ),
                Expanded(
                  child: ValuePanel(
                    firstText: 'P.A.D.',
                    secondText:
                        Valores.tensionArterialDyastolica!.toStringAsFixed(0),
                    thirdText: 'mmHg',
                  ),
                ),
                Expanded(
                  child: ValuePanel(
                    firstText: 'F. Card. ',
                    secondText: Valores.frecuenciaCardiaca!.toStringAsFixed(0),
                    thirdText: 'L/min',
                  ),
                ),
                Expanded(
                  child: ValuePanel(
                    firstText: 'P.A.M.',
                    secondText:
                        Cardiometrias.presionArterialMedia.toStringAsFixed(0),
                    thirdText: 'mmHg',
                  ),
                ),
                Expanded(
                  child: ValuePanel(
                    firstText: 'P.V.C.',
                    secondText:
                        Valores.presionVenosaCentral!.toStringAsFixed(0),
                    thirdText: 'mmHg',
                  ),
                ),
              ],
            ),
          ),
          CrossLine(thickness: 4),
          Expanded(
            flex: 8,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        CircleIcon(
                          iconed: Icons.copy_all_sharp,
                          tittle: "Copiar en Portapapeles",
                          onChangeValue: () {
                            Datos.portapapeles(
                                context: context,
                                text: Cardiometrias.cardiovasculares);
                          },
                        ),
                        CrossLine(thickness: 4),
                        ValuePanel(
                          firstText: 'PaO2',
                          secondText: Valores.poArteriales!.toStringAsFixed(2),
                          thirdText: 'mmHg',
                        ),
                        ValuePanel(
                          firstText: 'PvO2',
                          secondText: Valores.poVenosos!.toStringAsFixed(2),
                          thirdText: 'mmHg',
                        ),
                        ValuePanel(
                          firstText: 'PaCO2',
                          secondText: Valores.pcoArteriales!.toStringAsFixed(2),
                          thirdText: 'mmHg',
                        ),
                        ValuePanel(
                          firstText: 'PvCO2',
                          secondText: Valores.pcoVenosos!.toStringAsFixed(2),
                          thirdText: 'mmHg',
                        ),
                        ValuePanel(
                          firstText: 'SaO2',
                          secondText: Valores.soArteriales!.toStringAsFixed(2),
                          thirdText: '%',
                        ),
                        ValuePanel(
                          firstText: 'SvO2',
                          secondText: Valores.soVenosos!.toStringAsFixed(2),
                          thirdText: '%',
                        ),
                        ValuePanel(
                          firstText: 'Hemoglobina',
                          secondText: Valores.hemoglobina!.toStringAsFixed(2),
                          thirdText: 'g/dL',
                        ),
                        ValuePanel(
                          firstText: 'FiaO2',
                          secondText: Valores.fioArteriales!.toStringAsFixed(2),
                          thirdText: '%',
                        ),
                        ValuePanel(
                          firstText: 'FivO2',
                          secondText: Valores.fioVenosos!.toStringAsFixed(2),
                          thirdText: '%',
                        ),
                        ValuePanel(
                          firstText: 'Fecha Biometrías',
                          secondText: Valores.fechaBiometria,
                        ),
                        ValuePanel(
                          firstText: 'Fecha Arteriales',
                          secondText: Valores.fechaGasometriaArterial,
                        ),
                        ValuePanel(
                          firstText: 'Fecha Venosos',
                          secondText: Valores.fechaGasometriaVenosa,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: CarouselSlider(
                        items: [
                          TittleContainer(
                            tittle: "Taller Gasométrico",
                            color: Colors.black,
                            child: GridView(
                              padding: const EdgeInsets.all(8.0),
                              gridDelegate: GridViewTools.gridDelegate(
                                  crossAxisCount: 2,
                                  mainAxisExtent: widget.mainAxisExtent!),
                              children: [
                                ValuePanel(
                                  firstText: 'PiO2',
                                  secondText:
                                      Gasometricos.PIO.toStringAsFixed(2),
                                  thirdText: 'mmHg',
                                ),
                                ValuePanel(
                                  firstText: 'PAO2',
                                  secondText:
                                      Gasometricos.PAO.toStringAsFixed(2),
                                  thirdText: 'mmHg',
                                ),
                                ValuePanel(
                                  firstText: 'GA-a O2',
                                  secondText:
                                      Gasometricos.GAA.toStringAsFixed(2),
                                  thirdText: 'mmHg',
                                ),
                                // ** * * * * * * *
                                Container(),
                                ValuePanel(
                                  firstText:
                                      'CaO2', // Contenido Arterial de Oxígeno
                                  secondText: Valores.CAO.toStringAsFixed(2),
                                  thirdText: 'mL/O2%',
                                ),
                                ValuePanel(
                                  firstText:
                                      'CcO2', // Contenido Capilar de Oxígeno
                                  secondText: Valores.CCO.toStringAsFixed(2),
                                  thirdText: 'mL/O2%',
                                ),
                                ValuePanel(
                                  firstText:
                                      'CvO2', // Contenido Arterial de Oxígeno
                                  secondText: Valores.CVO.toStringAsFixed(2),
                                  thirdText: 'mL/O2%',
                                ),
                                Container(),
                                ValuePanel(
                                  firstText:
                                      'Da-vO2', // Diferencia Arterio-venosa de Oxígeno
                                  secondText: Valores.DAV.toStringAsFixed(2),
                                  thirdText: 'mL',
                                ),
                                Container(),
                                ValuePanel(
                                  firstText: 'G.C. (Fick)',
                                  secondText: Cardiometrias.gastoCardiacoFick
                                      .toStringAsFixed(2),
                                  thirdText: 'Lt/min',
                                ),
                                ValuePanel(
                                  firstText: 'I.C.',
                                  secondText:
                                  Cardiometrias.indiceCardiaco.toStringAsFixed(2),
                                  thirdText: 'Lt/min',
                                ),
                                ValuePanel(
                                  firstText: 'VO2', // Consumo de Oxígeno
                                  secondText: Valores.CO.toStringAsFixed(2),
                                  thirdText: 'mL/min',
                                ),
                                ValuePanel(
                                  firstText: 'DO2',
                                  secondText: Valores.DO.toStringAsFixed(2),
                                  thirdText: 'mL/min/m2',
                                ),
                                ValuePanel(
                                  firstText: 'iDO2',
                                  secondText: Valores.iDO.toStringAsFixed(2),
                                  thirdText: 'mL/min/m2',
                                ),
                                //
                                ValuePanel(
                                  firstText: 'QS/QT', // Shunt Arterio-venoso
                                  secondText: Valores.SF.toStringAsFixed(2),
                                  thirdText: '%',
                                ),
                                ValuePanel(
                                  firstText: 'PAFI', //
                                  secondText:
                                      Gasometricos.PAFI.toStringAsFixed(0),
                                ),
                                ValuePanel(
                                  firstText:
                                      'IEO2%', // Indice de Extracción Oxígeno
                                  secondText: Valores.IEO.toStringAsFixed(2),
                                  thirdText: '%',
                                ),
                                ValuePanel(
                                  firstText: 'I. Resp. ',
                                  secondText: Valores.CI.toStringAsFixed(2),
                                ),
                                ValuePanel(
                                  firstText:
                                      'RSV', // Resistencias Venosas Sistémicas
                                  secondText: Valores.RVS.toStringAsFixed(2),
                                  thirdText: 'dinas/seg/cm2',
                                ),
                                //
                                ValuePanel(
                                  firstText: 'ΔCO2',
                                  secondText: Gasometricos.DeltaCOS.toStringAsFixed(2),
                                  thirdText: 'mmHg',
                                ),
                                ValuePanel(
                                  firstText: 'ΔΔCO2',
                                  secondText: Valores.DavCO2.toStringAsFixed(2),
                                  thirdText: 'mmHg',
                                ),
                                ValuePanel(
                                  firstText: 'ΔPavCO2/\nΔPavO2',
                                  secondText:
                                      Valores.D_PavCO2D_PavO2.toStringAsFixed(
                                          2),
                                  thirdText: "", // 'mmHg/mL',
                                ),
                                ValuePanel(
                                  firstText: 'Indice \nMitocondrial',
                                  secondText: Valores.indiceMitocondrial
                                      .toStringAsFixed(2),
                                  thirdText: "", // 'mmHg/mL',
                                ),
                                Container(),
                                // **********************************
                                CrossLine(thickness: 3),
                                CrossLine(thickness: 2),
                                CircleIcon(
                                    radios: 20,
                                    difRadios: 3,
                                    iconed: Icons.copy_all_sharp,
                                    tittle: "Copiar en Portapapeles",
                                    onChangeValue: () => Datos.portapapeles(
                                        context: context,
                                        text: Cardiometrias.transporteOxigeno)),
                              ],
                            ),
                          ), // Taller Hemodinámico
                          TittleContainer(
                            tittle: "Taller Hemodinámico",
                            color: Colors.black,
                            child: GridView(
                              gridDelegate: GridViewTools.gridDelegate(
                                  crossAxisCount: 2,
                                  mainAxisExtent: widget.mainAxisExtent!),
                              children: [
                                ValuePanel(
                                  firstText: 'PiO2',
                                  secondText:
                                      Gasometricos.PIO.toStringAsFixed(2),
                                  thirdText: 'mmHg',
                                ),
                                ValuePanel(
                                  firstText: 'PAO2',
                                  secondText:
                                      Gasometricos.PAO.toStringAsFixed(2),
                                  thirdText: 'mmHg',
                                ),
                                ValuePanel(
                                  firstText: 'GA-a O2',
                                  secondText:
                                      Gasometricos.GAA.toStringAsFixed(2),
                                  thirdText: 'mmHg',
                                ),
                                // ** * * * * * * *
                                ValuePanel(
                                  firstText: 'G.C. (Fick)',
                                  secondText: Cardiometrias.gastoCardiacoFick
                                      .toStringAsFixed(2),
                                  thirdText: 'Lt/min',
                                ),
                                ValuePanel(
                                  firstText: 'I.C.',
                                  secondText:
                                  Cardiometrias.indiceCardiaco.toStringAsFixed(2),
                                  thirdText: 'Lt/min',
                                ),
                                ValuePanel(
                                  firstText: 'Vol. Lat. Sys. ',
                                  secondText: Cardiometrias.volumenSistolico.toStringAsFixed(2),
                                  thirdText: 'mL/Lt',
                                ),
                                ValuePanel(
                                  firstText: 'I, Vol. Lat. Sys. ',
                                  secondText: Cardiometrias.volumenSistolicoIndexado.toStringAsFixed(2),
                                  thirdText: 'mL/Lt/m2',
                                ),
                                // **********************************
                                ValuePanel(
                                  firstText: 'Rest. V. Sist.',
                                  secondText: Valores.RVS.toStringAsFixed(2),
                                  thirdText: 'dinas/seg/cm2',
                                ),
                                ValuePanel(
                                  firstText: 'T. Card. Izq. ',
                                  secondText: Cardiometrias.trabajoCardiacoIzquierdo.toStringAsFixed(2),
                                  thirdText: 'Kg*m',
                                ),
                                ValuePanel(
                                  firstText: 'TLVI',
                                  secondText:
                                      Cardiometrias.trabajoLatidoVentricularIzquierdo.toStringAsFixed(2),
                                  thirdText: 'g/Lat/m2',
                                ),
                                ValuePanel(
                                  firstText: 'I. TLVI',
                                  secondText:
                                      Cardiometrias.indiceTrabajoCardiacoIzquierdo.toStringAsFixed(2),
                                  thirdText: 'g/Lat/m2',
                                ),
                                //
                                ValuePanel(
                                  firstText: 'DO2',
                                  secondText: Valores.DO.toStringAsFixed(2),
                                  thirdText: 'mL/min/m2',
                                ),
                                ValuePanel(
                                  firstText: 'iDO2',
                                  secondText: Valores.iDO.toStringAsFixed(2),
                                  thirdText: 'mL/min/m2',
                                ),
                                ValuePanel(
                                  firstText: 'TO2',
                                  secondText: Valores.TO.toStringAsFixed(2),
                                  thirdText: 'mL/O2/m2',
                                ),
                                //
                                ValuePanel(
                                  firstText: 'P. Fcard-TA',
                                  secondText: Cardiometrias
                                      .productoFrecuenciaPresion
                                      .toStringAsFixed(2),
                                  thirdText: 'mmHg',
                                ),
                                ValuePanel(
                                  firstText: 'P. Coloido-Osmótica',
                                  secondText: Cardiometrias
                                      .presionColoidosmotica
                                      .toStringAsFixed(2),
                                  thirdText: 'mmHg',
                                ),
                                ValuePanel(
                                  firstText: 'I. Briones',
                                  secondText: Cardiometrias.indiceBriones
                                      .toStringAsFixed(2),
                                  thirdText: 'mmHg',
                                ),
                                Container(),
                                // Poder Cardiaco
                                ValuePanel(
                                  firstText: 'CW',
                                  secondText: Cardiometrias.poderCardiaco.toStringAsFixed(2),
                                  thirdText: 'Watts',
                                ),
                                ValuePanel(
                                  firstText: 'iCW',
                                  secondText: Cardiometrias.poderCardiacoIndexado.toStringAsFixed(2),
                                  thirdText: 'Watts',
                                ),
                                //
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
                                // **********************************
                                CrossLine(thickness: 3),
                                CrossLine(thickness: 2),
                                CircleIcon(
                                  iconed: Icons.copy_all_sharp,
                                  tittle: "Copiar en Portapapeles",
                                  onChangeValue: () {
                                    Datos.portapapeles(
                                        context: context,
                                        text: Cardiometrias.transporteOxigeno);
                                  },
                                ),
                              ],
                            ),
                          ), // Taller Hemodinámico
                          TittleContainer(
                            tittle: "Transporte de Oxígeno",
                            color: Colors.black,
                            child: GridView(
                              gridDelegate: GridViewTools.gridDelegate(
                                  crossAxisCount: 2,
                                  mainAxisExtent: widget.mainAxisExtent!),
                              children: [
                                ValuePanel(
                                  firstText: 'VO2', // Consumo de Oxígeno
                                  secondText: Valores.CO.toStringAsFixed(2),
                                  thirdText: 'mL/min',
                                ),
                                //
                                ValuePanel(
                                  firstText: 'QS/QT', // Shunt Arterio-venoso
                                  secondText: Valores.SF.toStringAsFixed(2),
                                  thirdText: '%',
                                ),
                                ValuePanel(
                                  firstText:
                                      'I. V/P (Kirby)', // Shunt Arterio-venoso
                                  secondText:
                                      Gasometricos.PAFI.toStringAsFixed(0),
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
                                // **********************************
                                CrossLine(thickness: 3),
                                CrossLine(thickness: 2),
                                CircleIcon(
                                  iconed: Icons.copy_all_sharp,
                                  tittle: "Copiar en Portapapeles",
                                  onChangeValue: () {
                                    Datos.portapapeles(
                                        context: context,
                                        text: Cardiometrias.transporteOxigeno);
                                  },
                                ),
                              ],
                            ),
                          ), // Transporte de Oxígeno
                          TittleContainer(
                            tittle: "Valores por Swan-Ganz",
                            color: Colors.black,
                            child: GridView(
                              gridDelegate: GridViewTools.gridDelegate(
                                  crossAxisCount: 2,
                                  mainAxisExtent: widget.mainAxisExtent!),
                              children: [
                                // Valores por Swan-Ganz
                                ValuePanel(
                                  firstText: "GC (Swan)",
                                  secondText:
                                      Valores.gastoCardiaco.toStringAsFixed(2),
                                  thirdText: "L/min",
                                ),
                                ValuePanel(
                                  firstText:
                                      "PAPS", // Presión Arterial Pulmonar Sistólica
                                  secondText:
                                      (Valores.presionArteriaPulmonarSistolica! *
                                              100)
                                          .toString(),
                                  thirdText: "mmHg",
                                ),
                                ValuePanel(
                                  firstText:
                                      "PAPD", // Presión Arterial Pulmonar Diastólica
                                  secondText: Valores
                                      .presionArteriaPulmonarDiastolica!
                                      .toStringAsFixed(0),
                                  thirdText: "mmHg",
                                ),
                                ValuePanel(
                                  firstText:
                                      "PMAP", // Presión Media Arterial Pulmonar
                                  secondText: Valores
                                      .presionMediaArteriaPulmonar!
                                      .toStringAsFixed(0),
                                  thirdText: 'mmHg',
                                ),
                                ValuePanel(
                                  firstText: 'P.o.P.',
                                  secondText: Valores.presionCunaPulmonar!
                                      .toStringAsFixed(0),
                                  thirdText: 'mmHg',
                                ),
                                // **********************************
                                CrossLine(thickness: 3),
                                CrossLine(thickness: 2),
                                CircleIcon(
                                  iconed: Icons.copy_all_sharp,
                                  tittle: "Copiar en Portapapeles",
                                  onChangeValue: () {
                                    Datos.portapapeles(
                                        context: context,
                                        text: Cardiometrias.hemodinamicos);
                                  },
                                ),
                              ],
                            ),
                          ), // Valores de Swan-Ganz
                        ],
                        carouselController: carouselController,
                        options: Carousel.carouselOptions(context: context)),
                  ),
                ),
              ],
            ),
          ),
          CrossLine(thickness: 3),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: ValuePanel(
                                firstText: 'P. Barr. ',
                                secondText: Valores.presionBarometrica
                                    .toStringAsFixed(0),
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
                                          Valores.presionBarometrica =
                                              int.parse(value);
                                          Navigator.of(context).pop();
                                        });
                                      });
                                },
                              ),
                            ),
                            Expanded(
                              child: ValuePanel(
                                firstText: 'P. H2O',
                                secondText:
                                    Valores.presionVaporAgua.toStringAsFixed(2),
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
                                          Valores.presionVaporAgua =
                                              int.parse(value);
                                          Navigator.of(context).pop();
                                        });
                                      });
                                },
                              ),
                            ),
                            Expanded(
                              child: ValuePanel(
                                firstText: 'FiO2 ',
                                secondText:
                                    Valores.fioArteriales!.toStringAsFixed(0),
                                thirdText: 'mmHg',
                                withEditMessage: true,
                                onEdit: (value) {
                                  Operadores.editActivity(
                                      context: context,
                                      keyBoardType: TextInputType.number,
                                      tittle: "Editar . . . ",
                                      message:
                                          "¿Fracción Inspirada de Oxígeno? . . . ",
                                      onAcept: (value) {
                                        setState(() {
                                          Valores.fioArteriales =
                                              double.parse(value);
                                          Navigator.of(context).pop();
                                        });
                                      });
                                },
                              ),
                            ),
                            Expanded(
                              child: ValuePanel(
                                firstText: 'Gas Seco',
                                secondText:
                                    Valores.presionGasSeco.toStringAsFixed(2),
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
                                          Valores.presionGasSeco =
                                              int.parse(value);
                                          Navigator.of(context).pop();
                                        });
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
                              // GrandIcon(
                              //   iconData: Icons.settings_input_component_outlined,
                              //   labelButton: 'Taller Hemodinámico',
                              //   onPress: () {
                              //     setState(() {
                              //       carouselController.jumpToPage(3);
                              //     });
                              //   },
                              // ),
                              // GrandIcon(
                              //   iconData: Icons.data_array,
                              //   labelButton: 'Valores de Referencia',
                              //   onPress: () {
                              //     setState(() {
                              //       carouselController.jumpToPage(4);
                              //     });
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CircleIcon(
                    iconed: Icons.copy_all_sharp,
                    tittle: "Copiar en Portapapeles",
                    onChangeValue: () {
                      Datos.portapapeles(
                          context: context, text: Cardiometrias.cardiometrias);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
