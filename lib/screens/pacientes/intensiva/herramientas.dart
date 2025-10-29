import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/antropometricos.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/cardiovasculares.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/gasometricos.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/ventilatorios.dart';

import 'package:assistant/screens/pacientes/intensiva/contenidos/balances.dart';
import 'package:assistant/screens/pacientes/intensiva/contenidos/concentraciones.dart';
import 'package:assistant/screens/pacientes/intensiva/contenidos/ventilaciones.dart';

import 'package:assistant/screens/pacientes/intensiva/analisis/hidricos.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/metabolometricos.dart';
import 'package:assistant/screens/pacientes/intensiva/procedimientos/cateterTenckhoff.dart';
import 'package:assistant/screens/pacientes/intensiva/procedimientos/cateterVenosoCentral.dart';
import 'package:assistant/screens/pacientes/intensiva/procedimientos/intubacionEndotraqueal.dart';
import 'package:assistant/screens/pacientes/intensiva/procedimientos/sondaEndopleural.dart';
import 'package:assistant/screens/pacientes/intensiva/valoraciones/aereos.dart';
import 'package:assistant/screens/pacientes/intensiva/valoraciones/prequirurgicos.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandLabel.dart';
import 'package:assistant/widgets/RoundedPanel.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:flutter/material.dart';

class Intensiva extends StatefulWidget {
  int? numActivity = 0;
  int? actualView = 0;

  Intensiva({super.key});

  @override
  State<Intensiva> createState() => _IntensivaState();
}

class _IntensivaState extends State<Intensiva> {
  @override
  Widget build(BuildContext context) {
    return TittleContainer(
      tittle: 'Herramientas de Análisis',
      padding: 8.0,
      child: isMobile(context)
          ? desktopView()
          : isTablet(context)
              ? desktopView()
              : desktopView(),
    );
  }

  Row desktopView() {
    return Row(
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
                child: RoundedPanel(child: getView(widget.actualView!))),
      ],
    );
  }

  //
  TittleContainer firstContent() {
    return TittleContainer(
      tittle: 'Operaciones',
      padding: 8.0,
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
                Operadores.openDialog(
                  context: context,
                  chyldrim: const Concentraciones(),
                );
              },
            ),
            CrossLine(),
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
            CrossLine(),
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
    );
  }

  Widget listOfActivities({int numActivity = 0}) {
    List acts = [Container(), analisis(), valoraciones(), procedimiento()];
    return acts[numActivity];
  }

  TittleContainer analisis() {
    return TittleContainer(
        tittle: 'Análisis basado en Información',
        padding: 8.0,
      child:
        SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              GrandLabel(
                iconData: Icons.water_drop,
                labelButton: 'Análisis Hidrico',
                onPress: () {
                  if (isMobile(context)) {
                    Operadores.openDialog(
                        context: context, chyldrim:  Hidricos());
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
                    Operadores.openDialog(
                        context: context, chyldrim: const Metabolicos());
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
                    Operadores.openDialog(
                        context: context,
                        chyldrim: const Antropometricos());
                  } else {
                    setState(() {
                      widget.actualView = 3;
                    });
                  }
                },
              ),
              GrandLabel(
                iconData: Icons.monitor_heart_outlined,
                labelButton: 'Análisis Cardiovascular',
                onPress: () {
                  if (isMobile(context)) {
                    Operadores.openDialog(
                        context: context,
                        chyldrim: Cardiovasculares());
                  } else {
                    setState(() {
                      widget.actualView = 4;
                    });
                  }
                },
              ),
              GrandLabel(
                iconData: Icons.all_inclusive_rounded,
                labelButton: 'Análisis Ventilatorio',
                onPress: () {
                  if (isMobile(context)) {
                    Operadores.openDialog(
                        context: context, chyldrim: const Ventilatorios());
                  } else {
                    setState(() {
                      widget.actualView = 5;
                    });
                  }
                },
              ),
              GrandLabel(
                iconData: Icons.g_mobiledata,
                labelButton: 'Análisis Gasométrico',
                onPress: () {
                  if (isMobile(context)) {
                    Operadores.openDialog(
                        context: context, chyldrim: const Gasometricos());
                  } else {
                    setState(() {
                      widget.actualView = 6;
                    });
                  }
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
                iconData: Icons.water,
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
    );
  }

  TittleContainer valoraciones() {
    return TittleContainer(
      tittle: 'Valoraciones Prequirúrgicas',
      padding: 8.0,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            GrandLabel(
              labelButton: 'Valoración Prequirúrgica',
              onPress: () {
                if (isMobile(context)) {
                  Operadores.openDialog(
                      context: context, chyldrim: const Prequirurgicos());
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
                  Operadores.openDialog(
                      context: context, chyldrim: const Aereas());
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

  TittleContainer procedimiento() {
    return TittleContainer(
      tittle: 'Procedimientos Médicos',
      padding: 8.0,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            GrandLabel(
              labelButton: 'Catéter Venoso Central',
              onPress: () {
                if (isMobile(context)) {
                  Operadores.openDialog(
                      context: context, chyldrim: const CateterVenosoCentral());
                } else {
                  setState(() {
                    widget.actualView = 13;
                  });
                }
              },
            ),
            GrandLabel(
              labelButton: 'Intubación Endotraqueal',
              onPress: () {
                if (isMobile(context)) {
                  Operadores.openDialog(
                      context: context,
                      chyldrim: const IntubacionEndotraqueal());
                } else {
                  setState(() {
                    widget.actualView = 14;
                  });
                }
              },
            ),
            GrandLabel(
              labelButton: 'Sonda Endopleural',
              onPress: () {
                if (isMobile(context)) {
                  Operadores.openDialog(
                      context: context,
                      chyldrim: const SondaEndopleural());
                } else {
                  setState(() {
                    widget.actualView = 15;
                  });
                }
              },
            ),
            GrandLabel(
              labelButton: 'Catéter Tenckhoff',
              onPress: () {
                if (isMobile(context)) {
                  Operadores.openDialog(
                      context: context,
                      chyldrim: const CateterTenckhoff());
                } else {
                  setState(() {
                    widget.actualView = 16;
                  });
                }
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
      Hidricos(),
      const Metabolicos(),
      const Antropometricos(),
      Cardiovasculares(),
      const Ventilatorios(),
      const Gasometricos(),
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

}
