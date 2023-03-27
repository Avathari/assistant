import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart' as patients;
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/screens/pacientes/epidemiologicos/alimenticios.dart';
import 'package:assistant/screens/pacientes/epidemiologicos/diarios.dart';
import 'package:assistant/screens/pacientes/epidemiologicos/eticos.dart';
import 'package:assistant/screens/pacientes/epidemiologicos/exposiciones.dart';
import 'package:assistant/screens/pacientes/epidemiologicos/higienicos.dart';
import 'package:assistant/screens/pacientes/epidemiologicos/limitaciones.dart';
import 'package:assistant/screens/pacientes/epidemiologicos/viviendas.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandLabel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class GestionNoPatologicos extends StatefulWidget {
  const GestionNoPatologicos({Key? key}) : super(key: key);

  @override
  State<GestionNoPatologicos> createState() => _GestionNoPatologicosState();
}

class _GestionNoPatologicosState extends State<GestionNoPatologicos> {
  
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
        title: const Text('Antecedentes Personales No Patológicos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Expanded(
            flex: isTablet(context) ? 2 : 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              controller: ScrollController(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GrandLabel(
                    iconData: Icons.person,
                    labelButton: "Ética y Moral",
                    weigth: wieghtRow / index,
                    onPress: () {
                      carouselController.jumpToPage(0);
                    },
                  ),
                  GrandLabel(
                      iconData: Icons.explicit,
                      labelButton: "Vivienda",
                      weigth: wieghtRow / index,
                      onPress: () {
                        carouselController.jumpToPage(1);
                      }),
                  GrandLabel(
                      iconData: Icons.medical_information,
                      labelButton: "Habitos Alimenticios",
                      weigth: wieghtRow / index,
                      onPress: () {
                        carouselController.jumpToPage(2);
                      }),
                  GrandLabel(
                      iconData: Icons.explore,
                      labelButton: "Hábitos Diarios",
                      weigth: wieghtRow / index,
                      onPress: () {
                        carouselController.jumpToPage(3);
                      }),
                  GrandLabel(
                      iconData: Icons.next_plan,
                      labelButton: "Hábitos Higienicos",
                      weigth: wieghtRow / index,
                      onPress: () {
                        carouselController.jumpToPage(4);
                      }),
                  GrandLabel(
                      iconData: Icons.explore,
                      labelButton: "Limitaciones Físicas",
                      weigth: wieghtRow / index,
                      onPress: () {
                        carouselController.jumpToPage(5);
                      }),
                  GrandLabel(
                      iconData: Icons.next_plan,
                      labelButton: "Exposición a Sustancias Nocivas",
                      weigth: wieghtRow / index,
                      onPress: () {
                        carouselController.jumpToPage(6);
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
                        child: const Eticos(),
                      ),
                      SingleChildScrollView(
                        controller: ScrollController(),
                        child: const Viviendas(),
                      ),
                      SingleChildScrollView(
                        controller: ScrollController(),
                        child: const Alimenticios(),
                      ),
                      SingleChildScrollView(
                        controller: ScrollController(),
                        child: const Diarios(),
                      ),
                      SingleChildScrollView(
                        controller: ScrollController(),
                        child: const Higienicos(),
                      ),
                      SingleChildScrollView(
                        controller: ScrollController(),
                        child: const Limitaciones(),
                      ),
                      SingleChildScrollView(
                        controller: ScrollController(),
                        child: const Exposiciones(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  width: 1400,
                  decoration: ContainerDecoration.roundedDecoration(),
                  child: GrandButton(
                      labelButton: 'Actualizar / Registrar',
                      onPress: () {
                        onActionActivity();
                      }),
                ))
              ]),
            ),
          ),
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
  num index = 6;
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
      patients.Eticos.actualizarRegistro();
      patients.Viviendas.actualizarRegistro();
      patients.Higienes.actualizarRegistro();
      patients.Diarios.actualizarRegistro();
      patients.Alimenticios.actualizarRegistro();
      patients.Limitaciones.actualizarRegistro();
      patients.Sustancias.actualizarRegistro();
    } catch (ex) {
      Operadores.alertActivity(
          context: context,
          tittle: 'Error al actualizar los registros',
          message: '$ex');
    } finally {
      // Consulta de Antecedentes No Patológicos **** ***** ******* ****
      patients.Eticos.consultarRegistro();
      patients.Viviendas.consultarRegistro();
      patients.Higienes.consultarRegistro();
      patients.Diarios.consultarRegistro();
      patients.Alimenticios.consultarRegistro();
      patients.Limitaciones.consultarRegistro();
      patients.Sustancias.consultarRegistro();

      toNextScreen(context: context, screen: VisualPacientes(actualPage: 2));
    }
  }
}
