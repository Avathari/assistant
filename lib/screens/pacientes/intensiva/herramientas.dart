import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/antropometricos.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/ventilatorios.dart';

import 'package:assistant/screens/pacientes/intensiva/contenidos/balances.dart';
import 'package:assistant/screens/pacientes/intensiva/contenidos/concentraciones.dart';
import 'package:assistant/screens/pacientes/intensiva/contenidos/ventilaciones.dart';

import 'package:assistant/screens/pacientes/intensiva/analisis/hidricos.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/metabolometrias.dart';
import 'package:assistant/screens/pacientes/intensiva/procedimientos/cateterTenckhoff.dart';
import 'package:assistant/screens/pacientes/intensiva/procedimientos/cateterVenosoCentral.dart';
import 'package:assistant/screens/pacientes/intensiva/procedimientos/intubacionEndotraqueal.dart';
import 'package:assistant/screens/pacientes/intensiva/procedimientos/sondaEndopleural.dart';
import 'package:assistant/screens/pacientes/intensiva/valoraciones/aereos.dart';
import 'package:assistant/screens/pacientes/intensiva/valoraciones/prequirurgicos.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandLabel.dart';
import 'package:assistant/widgets/RoundedPanel.dart';
import 'package:assistant/widgets/Tittle.dart';
import 'package:flutter/material.dart';

class Intensiva extends StatefulWidget {
  int? numActivity = 0;
  int? actualView = 0;

  Intensiva({Key? key}) : super(key: key);

  @override
  State<Intensiva> createState() => _IntensivaState();
}

class _IntensivaState extends State<Intensiva> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Tittle(tittle: 'Herramientas de Análisis'),
          isMobile(context)
              ? desktopView()
              : isTablet(context)
                  ? desktopView()
                  : desktopView(),
        ],
      ),
    );
  }

  Expanded desktopView() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: firstContent()),
          Expanded(
              flex: 2,
              child: listOfActivities(numActivity: widget.numActivity!)),
          isMobile(context)
              ? Container()
              : Expanded(
                  flex: 9,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: RoundedPanel(child: getView(widget.actualView!)),
                  )),
        ],
      ),
    );
  }

  //
  Padding firstContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Tittle(tittle: 'Operaciones'),
          Expanded(
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children: [
                  GrandLabel(
                    iconData: Icons.waterfall_chart,
                    labelButton: 'Balances Hidricos',
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GestionBalances()));
                    },
                  ),
                  GrandLabel(
                    iconData: Icons.airline_stops,
                    labelButton: 'Ventilación Mecánica',
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GestionVentilaciones()));
                    },
                  ),
                  GrandLabel(
                    iconData: Icons.balance,
                    labelButton: 'Concentraciones y Diluciones',
                    onPress: () {
                      Operadores.openActivity(context: context, chyldrim: const Concentraciones());

                    },
                  ),
                  const CrossLine(),
                  GrandLabel(
                    iconData: Icons.analytics_outlined,
                    labelButton: 'Análisis basado en Información',
                    onPress: () {
                      setState(() {
                        widget.numActivity = 1;
                      });
                    },
                  ),
                  GrandLabel(
                    iconData: Icons.airline_seat_flat_outlined,
                    labelButton: 'Valoraciones Prequirúrgicas',
                    onPress: () {
                      setState(() {
                        widget.numActivity = 2;
                      });
                    },
                  ),
                  GrandLabel(
                    iconData: Icons.airline_seat_flat_angled_outlined,
                    labelButton: 'Procedimientos Médicos',
                    onPress: () {
                      setState(() {
                        widget.numActivity = 3;
                      });
                    },
                  ),
                  const CrossLine(),
                  GrandLabel(
                    iconData: Icons.multiline_chart,
                    labelButton: 'Destete de la Intubación Endotraqueal',
                    weigth: 8,
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GestionBalances()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listOfActivities({int numActivity = 0}) {
    List acts = [Container(), analisis(), valoraciones(), procedimiento()];
    return acts[numActivity];
  }

  Padding analisis() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Tittle(tittle: 'Análisis basado en Información'),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children: [
                  GrandLabel(
                    iconData: Icons.water_drop,
                    labelButton: 'Análisis Hidrico',
                    onPress: () {
                      if (isMobile(context)) {
                        openActivity(const Hidricos());
                      } else {
                        setState(() {
                          widget.actualView = 1;
                        });
                      }
                    },
                  ),
                  GrandLabel(
                    iconData: Icons.bubble_chart,
                    labelButton: 'Análisis Metabólico',
                    onPress: () {
                      if (isMobile(context)) {
                        openActivity(const Metabolicos());
                      } else {
                        setState(() {
                          widget.actualView = 2;
                        });
                      }
                    },
                  ),
                  GrandLabel(
                    iconData: Icons.horizontal_rule_sharp,
                    labelButton: 'Análisis Antropométrico',
                    onPress: () {
                      if (isMobile(context)) {
                        openActivity(const Antropometricos());
                      } else {
                        setState(() {
                          widget.actualView = 3;
                        });
                      }
                    },
                  ),
                  GrandLabel(
                    labelButton: 'Análisis Cardiovascular',
                    onPress: () {
                      setState(() {
                        widget.actualView = 4;
                      });
                    },
                  ),
                  GrandLabel(
                    iconData: Icons.all_inclusive_rounded,
                    labelButton: 'Análisis Ventilatorio',
                    onPress: () {
                      if (isMobile(context)) {
                        openActivity(const Ventilatorios());
                      } else {
                        setState(() {
                          widget.actualView = 5;
                        });
                      }
                    },
                  ),
                  GrandLabel(
                    labelButton: 'Análisis Gasométrico',
                    onPress: () {
                      setState(() {
                        widget.actualView = 5;
                      });
                    },
                  ),
                  GrandLabel(
                    labelButton: 'Análisis Cerebrovascular',
                    onPress: () {
                      setState(() {
                        widget.actualView = 6;
                      });
                    },
                  ),
                  GrandLabel(
                    labelButton: 'Análisis Renal',
                    onPress: () {
                      setState(() {
                        widget.actualView = 7;
                      });
                    },
                  ),
                  GrandLabel(
                    labelButton: 'Análisis Sanguíneo Circulante',
                    onPress: () {
                      setState(() {
                        widget.actualView = 8;
                      });
                    },
                  ),
                  GrandLabel(
                    labelButton: 'Análisis Pulmonar',
                    onPress: () {
                      setState(() {
                        widget.actualView = 9;
                      });
                    },
                  ),
                  GrandLabel(
                    labelButton: 'Edad Corregida',
                    onPress: () {
                      setState(() {
                        widget.actualView = 10;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding valoraciones() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            Tittle(tittle: 'Valoraciones Prequirúrgicas'),
            GrandLabel(
              labelButton: 'Valoración Prequirúrgica',
              onPress: () {
                if (isMobile(context)) {
                  openActivity(const Prequirurgicos());
                } else {
                  setState(() {
                    widget.actualView = 11;
                  });
                }
              },
            ),
            GrandLabel(
              labelButton: 'Valoración de Vía Aerea',
              onPress: () {
                if (isMobile(context)) {
                  openActivity(const Aereas());
                } else {
                  setState(() {
                    widget.actualView = 12;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Padding procedimiento() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            Tittle(tittle: 'Procedimientos Médicos'),
            GrandLabel(
              labelButton: 'Catéter Venoso Central',
              onPress: () {
                Operadores.openActivity(context: context, chyldrim: const CateterVenosoCentral());
              },
            ),
            GrandLabel(
              labelButton: 'Intubación Endotraqueal',
              onPress: () {
                Operadores.openActivity(context: context, chyldrim: const IntubacionEndotraqueal());
              },
            ),
            GrandLabel(
              labelButton: 'Sonda Endopleural',
              onPress: () {
                Operadores.openActivity(context: context, chyldrim: const SondaEndopleural());
              },
            ),
            GrandLabel(
              labelButton: 'Catéter Tenckhoff',
              onPress: () {
                Operadores.openActivity(context: context, chyldrim: const CateterTenckhoff());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget getView(int actualView) {
    List list = [
      Container(),
      const Hidricos(),
      const Metabolicos(),
      const Antropometricos(),
      Container(),
      const Ventilatorios(),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      const Prequirurgicos(),
      const Aereas(),
      const CateterVenosoCentral(),
      const IntubacionEndotraqueal(),
      const SondaEndopleural(),
      const CateterTenckhoff(),
    ];
    return list[actualView];
  }

  void openActivity(chyldrim) {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          return Dialog(
              backgroundColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: chyldrim),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: Colors.grey,
                          )),
                      child: GrandButton(
                        labelButton: 'Cerrar',
                        onPress: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
