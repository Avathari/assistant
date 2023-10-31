import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';

class Exploracion {
  static String? glasgow = '15',
      inspeccionGeneral = 'Alerta',
      aperturaOcular = '4',
      respuestaMotora = '6',
      respuestaVerbal = '5';
  static String? coloracionTegumentaria = 'sin palidez tegumentaria',
      coloracionMucosas = 'sin deshidratación';

  static final Map<String, dynamic> semiotica = {
    "Glasgow": Listas.listOfRange(maxNum: 15, withNull: false),
    "inspeccionGeneral": ['Alerta', 'Obnubilado', 'Somnoliento', 'Estuporoso'],
    "RASS": Escalas.RASS,
    "aperturaOcular": Listas.listOfRange(maxNum: 4, withNull: false),
    "respuestaVerbal": Listas.listOfRange(maxNum: 5, withNull: false),
    "respuestaMotora": Listas.listOfRange(maxNum: 6, withNull: false),
  };
  static final Map<String, dynamic> hidritacion = {
    "coloracionTegumentaria": [
      'Sin palidez tegumentaria',
      'Con palidez tegumentaria'
    ],
    "coloracionMucosas": ['Deshidratado', 'Hidratado'],
  };

  // Valoración Motil de Cuello
  static String movilidadTemporoMandibular =
      Escalas.movilidadTemporoMandibular[0];
  static String movilidadCervical = Escalas.movilidadCervical[0];
  //
  static String? ingurgitacionYugular = '',
      bocioCervical = '',
      desviacionTraqueal = '',
      adenopatiaCervical = '',
      adenomegaliasCervical = '';

  static final Map<String, dynamic> cervical = {
    "movilidadTemporoMandibular": Escalas.movilidadTemporoMandibular,
    "movilidadCervical": Escalas.movilidadCervical,
    "ingurgitacionYugular": [
      'Sin ingurgitación yugular',
      'Ingurgitación yugular grado I',
      'Ingurgitación yugular grado II',
      'Ingurgitación yugular grado III'
    ],
    "bocioCervical": ['Sin Bocio', 'Con Bocio'],
    "desviacionTraqueal": [
      'Traquea desviada hacia la Izquierda',
      'Traquea Central',
      'Traquea desviada hacia la Derecha'
    ],
    "adenopatiaCervical": ['Deshidratado', 'Hidratado'],
    "adenomegaliasCervical": ['Deshidratado', 'Hidratado'],
  };

// TÓRAX ****************
  static String? amplexionTorax = '',
      amplexacionTorax = '',
      ruidosCardiacos = '',
      murmulloVesicular = '',
      estertoresPulmonar = '',
      sibilanciasPulmonar = '';

  static final Map<String, dynamic> torax = {
    "amplexionTorax": Escalas.movilidadTemporoMandibular,
    "amplexacionTorax": Escalas.movilidadCervical,
  };

  // FUNCIONES ************************************************************
  static void toJson(String elementAt, title) {
    Terminal.printExpected(
        message: "fromJson elementAt ${elementAt} : : $title");

    if (elementAt == 'inspeccionGeneral') inspeccionGeneral = title;
    if (elementAt == 'Glasgow') glasgow = title;
    if (elementAt == 'aperturaOcular') aperturaOcular = title;
    if (elementAt == 'respuestaVerbal') respuestaVerbal = title;
    if (elementAt == 'respuestaMotora') respuestaMotora = title;
//
    if (elementAt == 'coloracionTegumentaria') coloracionTegumentaria = title;
    if (elementAt == 'coloracionMucosas') coloracionMucosas = title;
// CUELLO
    if (elementAt == 'movilidadTemporoMandibular') movilidadTemporoMandibular = title;
    if (elementAt == 'movilidadCervical') movilidadCervical = title;
    if (elementAt == 'ingurgitacionYugular') ingurgitacionYugular = title;
    if (elementAt == 'bocioCervical') bocioCervical = title;
    if (elementAt == 'desviacionTraqueal') desviacionTraqueal = title;
    if (elementAt == 'adenopatiaCervical') amplexacionTorax = title;
    if (elementAt == 'adenomegaliasCervical') amplexionTorax = title;
// TORAX
    if (elementAt == 'amplexionTorax') amplexionTorax = title;
    if (elementAt == 'amplexacionTorax') amplexacionTorax = title;

  }

  // CONCLUSIONES
  static String get exploracionGeneral {
    return '${Exploracion.inspeccionGeneral}, '
        'glasgow (E$aperturaOcular, V$respuestaVerbal, M$respuestaMotora)'
        '$coloracionTegumentaria$coloracionMucosas'
        '. '
        'Cuello $ingurgitacionYugular$desviacionTraqueal$bocioCervical$adenopatiaCervical'
        '$adenomegaliasCervical'
        '. '
        'Tórax $amplexionTorax$amplexacionTorax'
        '. ';
  }
}

class Semiotica extends StatefulWidget {
  const Semiotica({super.key});

  @override
  State<Semiotica> createState() => _SemioticaState();
}

class _SemioticaState extends State<Semiotica> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: _getComponents(entries: Exploracion.semiotica),
                )),
          ),
          Expanded(
            child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: _getComponents(entries: Exploracion.hidritacion),
                )),
          ),
          Expanded(
            child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: _getComponents(entries: Exploracion.cervical),
                )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Variable : : ${Exploracion.exploracionGeneral}");
        },
      ),
    );
  }

  List<Widget> _getComponents({required Map<String, dynamic> entries}) {
    List<Widget> list = [];

    for (int index = 0; index < entries.length; index++) {
      list.add(Stack(
        children: [
          Container(
            width: double.infinity, // widget.width,
            height: 100,
            margin:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            padding:
                const EdgeInsets.only(left: 10, right: 8, top: 2, bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(20),
              shape: BoxShape.rectangle,
            ),
            child: GridView(
                shrinkWrap: true,
                controller: ScrollController(),
                gridDelegate: GridViewTools.gridDelegate(
                    crossAxisCount: isMobile(context) ? 3 : 5,
                    mainAxisExtent: 60,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0),
                children: entries.values
                    .elementAt(index)
                    .map<Widget>((title) => InputChip(
                          label: Text(title),
                          onPressed: () {
                            // Handle button press here
                            Exploracion.toJson(
                                entries.keys.elementAt(index), title);
                          },
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          labelStyle: const TextStyle(color: Colors.white),
                        ))
                    .toList()),
          ),
          Container(
            color: Theming.bdColor,
            margin: const EdgeInsets.only(left: 20, right: 10),
            padding: const EdgeInsets.only(left: 20, right: 10, top: 2),
            child: Positioned(
              left: 30,
              top: 10,
              child: Text(descompose(entries.keys.elementAt(index)),
                  style: const TextStyle(color: Colors.white, fontSize: 10)),
            ),
          ),
        ],
      ));
    }

    return list;
  }

  descompose(String value) {
    return value.contains(RegExp(r'[A-Z]'))
        ? Sentences.capitalize(value.replaceRange(
            value.indexOf(RegExp(r'[A-Z]')),
            value.indexOf(RegExp(r'[A-Z]')) + 1,
            " ${RegExp(r'[A-Z]').stringMatch(value).toString()}"))
        : value;
  }
}
