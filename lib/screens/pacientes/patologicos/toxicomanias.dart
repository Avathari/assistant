import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/screens/pacientes/epidemiologicos/alcoholismo.dart';
import 'package:assistant/screens/pacientes/epidemiologicos/drogadismo.dart';
import 'package:assistant/screens/pacientes/epidemiologicos/tabaquismo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class GestionToxicomanias extends StatefulWidget {
  const GestionToxicomanias({Key? key}) : super(key: key);

  @override
  State<GestionToxicomanias> createState() => _GestionToxicomaniasState();
}

class _GestionToxicomaniasState extends State<GestionToxicomanias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          tooltip: 'Regresar al Panel del Paciente',
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            toNextScreen(
                context: context,
                screen: VisualPacientes(
                  actualPage: 2,
                ));
          },
        ),
        title: const Text('Antecedentes Toxicomanos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              controller: ScrollController(),
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GrandIcon(
                    iconData: Icons.wine_bar,
                    labelButton: "Alcoholismo",
                    heigth: 100,
                    weigth: wieghtRow / index,
                    onPress: () {
                      carouselController.jumpToPage(0);
                    },
                  ),
                  GrandIcon(
                      iconData: Icons.smoking_rooms_outlined,
                      labelButton: "Tabaquismo",
                      weigth: wieghtRow / index,
                      heigth: 100,
                      onPress: () {
                        carouselController.jumpToPage(1);
                      }),
                  GrandIcon(
                      iconData: Icons.arrow_drop_up,
                      labelButton: "Drogadicción",
                      weigth: wieghtRow / index,
                      heigth: 100,
                      onPress: () {
                        carouselController.jumpToPage(2);
                      }),

                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              decoration: ContainerDecoration.containerDecoration(),
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Expanded(
                  flex: 8,
                  child: CarouselSlider(
                    carouselController: carouselController,
                    options: Carousel.carouselOptions(context: context),
                    items: [
                      SingleChildScrollView(
                        controller: ScrollController(),
                        child: const Alcoholismo(),
                      ),
                      SingleChildScrollView(
                        controller: ScrollController(),
                        child: const Tabaquismo(),
                      ),
                      SingleChildScrollView(
                        controller: ScrollController(),
                        child: const Drogadismo(),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          CrossLine(),
          Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                width: 1400,
                decoration: ContainerDecoration.roundedDecoration(),
                child: GrandButton(
                    labelButton: 'Actualizar / Registrar', onPress: () {
                  onActionActivity();
                }),
              ))
        ]),
      ),
    );
  }

  // ######################### ### # ### ############################
  // Controladores de widgets en general.
  // ######################### ### # ### ############################
  var carouselController = CarouselController();
  // ######################### ### # ### ############################
  // Variables auxiliares de widget.
  // ######################### ### # ### ############################
  num index = 3;
  int wieghtRow = 50;

  void toNextScreen({context, screen}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
    // if (isMobile(context) || isTablet(context)) {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
    // } else {
    //   setState(() {
    //     // widget.actualPage = index!;
    //   });
    // }
  }

  void onActionActivity() {
    // Actualización de los Elementos Presentados.
    try {
      Toxicomanias.actualizarRegistro();
    } catch (ex) {
      Operadores.alertActivity(
          context: context,
          tittle: 'Error al actualizar los registros',
          message: '$ex');
    } finally {

      toNextScreen(context: context, screen: VisualPacientes(actualPage: 2));
    }
  }
}
