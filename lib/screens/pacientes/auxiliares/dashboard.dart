import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/auxiliares/detalles/detalles.dart';
import 'package:assistant/screens/pacientes/auxiliares/detalles/estadisticasVitales.dart';
import 'package:assistant/screens/pacientes/auxiliares/diagnosticos/degenerativos.dart';
import 'package:assistant/screens/pacientes/auxiliares/diagnosticos/diagnosticos.dart';
import 'package:assistant/screens/pacientes/auxiliares/revisiones/revisiones.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/hospitalizacion.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/hospitalizado.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/pendientes.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/ChartLine.dart';

import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandLabel.dart';
import 'package:assistant/widgets/RoundedPanel.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  List<List> dymValues = [
    ["0000/00/00", 0, 0, 0, 0, 0, 0],
    ["0000/00/00", 0, 0, 0, 0, 0, 0],
    ["0000/00/00", 0, 0, 0, 0, 0, 0],
    ["0000/00/00", 0, 0, 0, 0, 0, 0],
    ["0000/00/00", 0, 0, 0, 0, 0, 0],
    ["0000/00/00", 0, 0, 0, 0, 0, 0],
  ];
  List tittles = [
    'T. Sistólica',
    'T. Diastólica',
    'F. Cardiaca',
    'F. Respiratoria',
    'T. Corporal',
    'SPO2 %',
  ];

  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var fileAssocieted = '${Pacientes.localRepositoryPath}vitales.json';

  @override
  void initState() {
    //
    List list = [];
    widget.dymValues.clear();
    if (Pacientes.Vitales!.isNotEmpty) {
      for (var i = 0; i < Pacientes.Vitales!.length; i++) {
        list.clear();
        //
        widget.dymValues.insert(i, [
          Pacientes.Vitales![i]['Pace_Feca_SV'],
          Pacientes.Vitales![i]['Pace_SV_tas'],
          Pacientes.Vitales![i]['Pace_SV_tad'],
          Pacientes.Vitales![i]['Pace_SV_fc'],
          Pacientes.Vitales![i]['Pace_SV_fr'],
          Pacientes.Vitales![i]['Pace_SV_tc'],
          Pacientes.Vitales![i]['Pace_SV_spo']
        ]);
      }
    } else {
      Archivos.readJsonToMap(filePath: Vitales.fileAssocieted).then((value) {
        // // Terminal.printData(message: "Value $value");
        Pacientes.Vitales = value;
        for (var i = 0; i < Pacientes.Vitales!.length; i++) {
          list.clear();
          //
          widget.dymValues.insert(i, [
            Pacientes.Vitales![i]['Pace_Feca_SV'],
            Pacientes.Vitales![i]['Pace_SV_tas'],
            Pacientes.Vitales![i]['Pace_SV_tad'],
            Pacientes.Vitales![i]['Pace_SV_fc'],
            Pacientes.Vitales![i]['Pace_SV_fr'],
            Pacientes.Vitales![i]['Pace_SV_tc'],
            Pacientes.Vitales![i]['Pace_SV_spo']
          ]);
        }
      }).onError((error, stackTrace) {
        // Terminal.printAlert(message: "ERROR - $error : : $stackTrace");
      }).whenComplete(() {
        setState(() {
          widget.dymValues;
        });
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return desktopView();
    return isMobile(context)
        ? mobileView()
        : isTablet(context)
            ? tabletView()
            : desktopView();
  }

  void iniciar() {
    // Terminal.printWarning(message: " . . . Iniciando Actividad - Repositorio de Pacientes");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        Pacientes.Vitales = value;
      });
    }).onError((error, stackTrace) {
      // Terminal.printAlert(message: "Iniciando actividad : : \n "Consulta de pacientes hospitalizados . . .");
      Actividades.consultarAllById(Databases.siteground_database_regpace,
              Vitales.vitales['consultIdQuery'], Pacientes.ID_Paciente)
          .then((value) {
        setState(() {
          // Terminal.printSuccess(message: "Actualizando repositorio de pacientes . . . ");
          Pacientes.Vitales = value;
          Archivos.createJsonFromMap(Pacientes.Vitales!,
              filePath: fileAssocieted);
        });
      });
    });
    // Terminal.printWarning(message: " . . . Actividad Iniciada");
  }

  // Visores ******** ****** ******* ***** ** *
  Container mobileView() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.all(5.0),
      child: CarouselSlider(
        options: Carousel.carouselOptions(context: context),
        items: [
          Revisiones(),
          Column(
            children: [
              RoundedPanel(
                child: TittlePanel(
                  textPanel: 'Diagnóstico(s)'
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: RoundedPanel(
                  child: const Degenerativos(),
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: RoundedPanel(
                  child: const Diagnosis(),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  Container tabletView() {
    return Container(
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.all(5.0),
        child: CarouselSlider(
          options: Carousel.carouselOptions(context: context),
          items: [
            Revisiones(),
            Column(
              children: [

                const SizedBox(height: 6),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          child: RoundedPanel(child: const Degenerativos())),
                      const SizedBox(width: 6),
                      Expanded(child: RoundedPanel(child: const Diagnosis())),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                const SizedBox(height: 6),
              ],
            ),

          ],
        ));

    // RoundedPanel(
    //   child: ChartLine(
    //     dymValues: widget.dymValues,
    //     withTittles: true,
    //     tittles: widget.tittles,
    //   ),
    // ),
    // RoundedPanel(
    //   child: const Degenerativos(),
    // ),
  }

  Padding desktopView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: RoundedPanel(
                      child: const Degenerativos(),
                    )),
                const SizedBox(height: 6),
                Expanded(
                    child: RoundedPanel(
                      child: const Diagnosis(),
                    )),
                const SizedBox(height: 6),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            flex: 3,
            child: Revisiones()),
        ],
      ),
    );
  }

  Padding bigDesktopView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: RoundedPanel(
                    child: Detalles(),
                  )),
                  const SizedBox(width: 6),
                  Expanded(
                    flex: 2,
                    child: RoundedPanel(
                      child: ChartLine(
                        dymValues: widget.dymValues,
                        withTittles: true,
                        tittles: widget.tittles,
                      ),
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 6),
          Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: RoundedPanel(
                    padding: 2,
                    child: Pacientes.esHospitalizado == true
                        ?  Hospitalizado()
                        : const EstadisticasVitales(),
                  )),
                  const SizedBox(width: 6),
                  Expanded(
                      child: RoundedPanel(
                    child: const Degenerativos(),
                  )),
                  const SizedBox(width: 6),
                  Expanded(
                      child: RoundedPanel(
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: Column(
                        children: [
                          GrandLabel(
                            iconData: Icons.padding,
                            fontSized: 14,
                            labelButton: 'Pendientes de la Atención',
                            onPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    GestionPendiente(),
                              ));
                            },
                          ),
                          TittlePanel(
                            textPanel: Pacientes.modoAtencion,
                          ),
                          GrandLabel(
                            iconData: Icons.local_hospital,
                            fontSized: 14,
                            labelButton: Pacientes.esHospitalizado == true
                                ? 'Egresar paciente'
                                : 'Hospitalizar paciente',
                            onPress: () async {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (BuildContext context) =>
                              //       GestionPendiente(),
                              // ));
                              // final respo = await Pacientes.hospitalizar();
                              // // Actualizar vista.
                              // setState(() {
                              //   if (respo) {
                              //     Valores.modoAtencion = 'Hospitalización';
                              //     Pacientes.modoAtencion = 'Hospitalización';
                              //     // Actualizar valores de Hospitalización.
                              //     Valores.isHospitalizado = respo;
                              //     Pacientes.esHospitalizado = respo;
                              //
                              //     // asyncHospitalizar(context);
                              //     Operadores.openActivity(
                              //       context: context,
                              //       chyldrim: const OpcionesHospitalizacion(),
                              //       onAction: () {},
                              //     );
                              //   } else {
                              //     Valores.modoAtencion = 'Consulta Externa';
                              //     Pacientes.modoAtencion = 'Consulta Externa';
                              //     // Actualizar valores de Hospitalización.
                              //     Valores.isHospitalizado = respo;
                              //     Pacientes.esHospitalizado = respo;
                              //   }
                              // });
                              //
                            },
                          ),
                          CrossLine(),
                          GrandLabel(
                            iconData: Icons.padding,
                            fontSized: 14,
                            labelButton: 'Registro de Hospitalizaciones',
                            onPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    GestionHospitalizaciones(),
                              ));
                            },
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ))
        ],
      ),
    );
  }
  // **************************************

}
