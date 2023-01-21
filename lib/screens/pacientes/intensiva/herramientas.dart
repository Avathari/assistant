import 'package:assistant/screens/pacientes/intensiva/balances.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/RoundedPanel.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';

class Intensiva extends StatefulWidget {
  int? numActivity = 0;

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
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: firstContent()),
                Expanded(
                    flex: 2,
                    child: listOfActivities(numActivity: widget.numActivity!)),
                Expanded(flex: 9, child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RoundedPanel(),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding firstContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Tittle(tittle: 'Operaciones'),
          GrandIcon(
            labelButton: 'Balances Hidricos',
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GestionBalances()));
            },
          ),
          GrandIcon(
            labelButton: 'Ventilación Mecánica',
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GestionBalances()));
            },
          ),
          GrandIcon(
            labelButton: 'Concentraciones y Diluciones',
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GestionBalances()));
            },
          ),
          const CrossLine(),
          GrandIcon(
            labelButton: 'Análisis basado en Información',
            onPress: () {
              setState(() {
                widget.numActivity = 1;
              });
            },
          ),
          GrandIcon(
            labelButton: 'Valoraciones Prequirúrgicas',
            onPress: () {
              setState(() {
                widget.numActivity = 2;
              });
            },
          ),
          GrandIcon(
            labelButton: 'Procedimientos Médicos',
            onPress: () {
              setState(() {
                widget.numActivity = 3;
              });
            },
          ),
          const CrossLine(),
          GrandIcon(
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
                  GrandIcon(
                    labelButton: 'Análisis Hidrico',
                    onPress: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => GestionBalances()));
                    },
                  ),
                  GrandIcon(
                    labelButton: 'Análisis Metabólico',
                    onPress: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => GestionBalances()));
                    },
                  ),
                  GrandIcon(
                    labelButton: 'Análisis Antropométrico',
                    onPress: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => GestionBalances()));
                    },
                  ),
                  GrandIcon(
                    labelButton: 'Análisis Cardiovascular',
                    onPress: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => GestionBalances()));
                    },
                  ),
                  GrandIcon(
                    labelButton: 'Análisis Ventilatorio',
                    onPress: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => GestionBalances()));
                    },
                  ),
                  GrandIcon(
                    labelButton: 'Análisis Gasométrico',
                    onPress: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => GestionBalances()));
                    },
                  ),
                  GrandIcon(
                    labelButton: 'Análisis Cerebrovascular',
                    onPress: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => GestionBalances()));
                    },
                  ),
                  GrandIcon(
                    labelButton: 'Análisis Renal',
                    onPress: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => GestionBalances()));
                    },
                  ),
                  GrandIcon(
                    labelButton: 'Análisis Sanguíneo Circulante',
                    onPress: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => GestionBalances()));
                    },
                  ),
                  GrandIcon(
                    labelButton: 'Análisis Pulmonar',
                    onPress: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => GestionBalances()));
                    },
                  ),
                  GrandIcon(
                    labelButton: 'Edad Corregida',
                    onPress: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => GestionBalances()));
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
            GrandIcon(
              labelButton: 'Valoración Prequirúrgica',
              onPress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GestionBalances()));
              },
            ),
            GrandIcon(
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
            GrandIcon(
              labelButton: 'Catéter Venoso Central',
              onPress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GestionBalances()));
              },
            ),
            GrandIcon(
              labelButton: 'Intubación Endotraqueal',
              onPress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GestionBalances()));
              },
            ),
            GrandIcon(
              labelButton: 'Sonda Endopleural',
              onPress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GestionBalances()));
              },
            ),
            GrandIcon(
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
}

Tittle({required String tittle}) {
  return RoundedPanel(
    child: TittlePanel(textPanel: tittle),
  );
}
