import 'package:assistant/operativity/pacientes/valores/Valores.dart';

import 'package:assistant/screens/pacientes/intensiva/contenidos/balances.dart';
import 'package:assistant/screens/pacientes/intensiva/contenidos/concentraciones.dart';
import 'package:assistant/screens/pacientes/intensiva/contenidos/ventilaciones.dart';

import 'package:assistant/screens/pacientes/intensiva/analisis/hidricos.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/metabolometrias.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandLabel.dart';
import 'package:assistant/widgets/RoundedPanel.dart';
import 'package:assistant/widgets/TittlePanel.dart';
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
                    labelButton: 'Balances Hidricos',
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GestionBalances()));
                    },
                  ),
                  GrandLabel(
                    labelButton: 'Ventilación Mecánica',
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GestionVentilaciones()));
                    },
                  ),
                  GrandLabel(
                    labelButton: 'Concentraciones y Diluciones',
                    onPress: () {
                      showDialog(
                          useSafeArea: true,
                          context: context,
                          builder: (context) {
                            return Dialog(
                                backgroundColor: Colors.black,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Expanded(
                                          flex: 5, child: Concentraciones()),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
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
                    },
                  ),
                  const CrossLine(),
                  GrandLabel(
                    labelButton: 'Análisis basado en Información',
                    onPress: () {
                      setState(() {
                        widget.numActivity = 1;
                      });
                    },
                  ),
                  GrandLabel(
                    labelButton: 'Valoraciones Prequirúrgicas',
                    onPress: () {
                      setState(() {
                        widget.numActivity = 2;
                      });
                    },
                  ),
                  GrandLabel(
                    labelButton: 'Procedimientos Médicos',
                    onPress: () {
                      setState(() {
                        widget.numActivity = 3;
                      });
                    },
                  ),
                  const CrossLine(),
                  GrandLabel(
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
                    labelButton: 'Análisis Antropométrico',
                    onPress: () {
                      setState(() {
                        widget.actualView = 3;
                      });
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
                    labelButton: 'Análisis Ventilatorio',
                    onPress: () {
                      setState(() {
                        widget.actualView = 5;
                      });
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GestionBalances()));
              },
            ),
            GrandLabel(
              labelButton: 'Valoración de Vía Aerea',
              onPress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GestionBalances()));
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GestionBalances()));
              },
            ),
            GrandLabel(
              labelButton: 'Intubación Endotraqueal',
              onPress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GestionBalances()));
              },
            ),
            GrandLabel(
              labelButton: 'Sonda Endopleural',
              onPress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GestionBalances()));
              },
            ),
            GrandLabel(
              labelButton: 'Catéter Tenckhoff',
              onPress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GestionBalances()));
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
      Metabolicos(),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
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
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 5, child: chyldrim),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(
                              Radius.circular(20)),
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

Widget Tittle({required String tittle}) {
  return RoundedPanel(
    child: TittlePanel(textPanel: tittle),
  );
}
