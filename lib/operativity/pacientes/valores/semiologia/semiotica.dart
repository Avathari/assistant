import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/Strings.dart';

class Exploracion {
  /// Variable Glasgow, por defecto es String cuyo valor es, de hecho, un entero, el cual es comprobado por Valorados.mSOFA para su puntaje.
  static String? glasgow = '15',
      inspeccionGeneral = 'Alerta',
      aperturaOcular = '4',
      respuestaMotora = '6',
      respuestaVerbal = '5';
  static String? coloracionTegumentaria = 'sin palidez tegumentaria',
      coloracionMucosas = 'sin deshidratación';

  // Variables de la situación hospitalaria
  static String? dispositivoOxigeno = Items.dispositivosOxigeno[0],
      dispositivoEmpleado = Items.dispositivosOxigeno[0],
      auxiliarVentilacion = Items.dispositivosOxigeno[0],
      rass = Escalas.RASS[0],
      ramsay = Escalas.ramsay[0],
      ashworth = Escalas.ashworth[0],
      daniels = Escalas.daniels[0],
      mrc = Escalas.MRC[0],
      faseVentilatoria = Items.ventilatorio[3],
      siedel = Escalas.siedel[0],
      tuboEndotraqueal = Items.tuboendotraqueal[0],
      haciaArcadaDentaria = Items.arcadaDentaria[0],
      antibioticoterapia = Items.antibioticoterapia[0],
      evaluacionNorton = Escalas.norton[0],
      evaluacionBraden = Escalas.braden[0],
      apoyoAminergico = Items.aminergico[0],
      alimentacion = Items.dieta[0],
      tipoSondaAlimentacion = Items.orogastrico[0],
      tipoSondaVesical = Items.foley[0],
      sedoanalgesia = Items.sedacion[0];

  static final Map<String, dynamic> semiotica = {
    // "Glasgow": Listas.listOfRange(maxNum: 15, withNull: false),
    "inspeccionGeneral": ['Alerta', 'Obnubilado', 'Somnoliento', 'Estuporoso'],
    "aperturaOcular": Listas.listOfRange(maxNum: 4, withNull: false),
    "respuestaVerbal": Listas.listOfRange(maxNum: 5, withNull: false),
    "respuestaMotora": Listas.listOfRange(maxNum: 6, withNull: false),
  };
  static final Map<String, dynamic> aspectuales = {
    "coloracionTegumentaria": [
      'Sin palidez tegumentaria',
      'Con palidez tegumentaria'
    ],
    "coloracionMucosas": ['Deshidratado', 'Hidratado'],
    "RASS": Escalas.RASS,
    "Ramsay": Escalas.ramsay,
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

  // Indices de Medidas Mandibulares
  static String aperturaMandibular = Escalas.aperturaMandibular[0];
  static String escalaMallampati = Escalas.escalaMallampati[0];
  static String escalaCormackLahane = Escalas.escalaCormackLahane[0];
  // Indices de Medidas Cervicales
  static String distanciaTiromentoniana = Escalas.distanciaTiromentoniana[0];
  static String distanciaEsternomentoniana =
      Escalas.distanciaEsternomentoniana[0];

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
  static String? amplexionTorax = Escalas.amplexionTorax[0],
      amplexacionTorax = Escalas.amplexacionTorax[0],
      ruidosCardiacos = Escalas.ruidosCardiacos[0],
      murmulloVesicular = Escalas.murmulloVesicular[0],
      estertoresPulmonar = Escalas.estertoresPulmonar[0],
      sibilanciasPulmonar = Escalas.sibilanciasPulmonar[0];
// ADBOMEN ****************
  static String? aspectoAbdomen = Escalas.aspectoAbdomen[0],
      peristalisisAbdomen = Escalas.peristalisisAbdomen[0],
      dolorosoAbdomen = Escalas.dolorosoAbdomen[0],
      irritacionPeritoneal = Escalas.irritacionPeritoneal[0];

  static final Map<String, dynamic> torax = {
    "amplexionTorax": Escalas.amplexionTorax,
    "amplexacionTorax": Escalas.amplexacionTorax,
    "ruidosCardiacos": Escalas.ruidosCardiacos,
    "murmulloVesicular": Escalas.murmulloVesicular,
    "estertoresPulmonar": Escalas.estertoresPulmonar,
    "sibilanciasPulmonar": Escalas.sibilanciasPulmonar,
  };

  static final Map<String, dynamic> abdomen = {
    "aspectoAbdomen": Escalas.aspectoAbdomen,
    "peristalisisAbdomen": Escalas.peristalisisAbdomen,
    "dolorosoAbdomen": Escalas.dolorosoAbdomen,
    "irritacionPeritoneal": Escalas.irritacionPeritoneal,
  };
  // FUNCIONES ************************************************************
  static void toJson(String elementAt, title) {
    Terminal.printExpected(message: "fromJson elementAt $elementAt : : $title");

    if (elementAt == 'inspeccionGeneral') inspeccionGeneral = title;
    if (elementAt == 'Glasgow') glasgow = title;
    if (elementAt == 'aperturaOcular') aperturaOcular = title;
    if (elementAt == 'respuestaVerbal') respuestaVerbal = title;
    if (elementAt == 'respuestaMotora') respuestaMotora = title;
//
    if (elementAt == 'coloracionTegumentaria') coloracionTegumentaria = title;
    if (elementAt == 'coloracionMucosas') coloracionMucosas = title;
    //
    if (elementAt == 'RASS') rass = title;
// CUELLO
    if (elementAt == 'movilidadTemporoMandibular')
      movilidadTemporoMandibular = title;
    if (elementAt == 'movilidadCervical') movilidadCervical = title;
    if (elementAt == 'ingurgitacionYugular') ingurgitacionYugular = title;
    if (elementAt == 'bocioCervical') bocioCervical = title;
    if (elementAt == 'desviacionTraqueal') desviacionTraqueal = title;
    if (elementAt == 'adenopatiaCervical') amplexacionTorax = title;
    if (elementAt == 'adenomegaliasCervical') amplexionTorax = title;
// TORAX
    if (elementAt == 'amplexionTorax') amplexionTorax = title;
    if (elementAt == 'amplexacionTorax') amplexacionTorax = title;
    if (elementAt == 'ruidosCardiacos') ruidosCardiacos = title;
    if (elementAt == 'murmulloVesicular') murmulloVesicular = title;
    if (elementAt == 'estertoresPulmonar') estertoresPulmonar = title;
    if (elementAt == 'sibilanciasPulmonar') sibilanciasPulmonar = title;
    // ABDOMEN
    if (elementAt == 'aspectoAbdomen') aspectoAbdomen = title;
    if (elementAt == 'peristalisisAbdomen') peristalisisAbdomen = title;
    if (elementAt == 'dolorosoAbdomen') dolorosoAbdomen = title;
    if (elementAt == 'irritacionPeritoneal') irritacionPeritoneal = title;
  }

  // CONCLUSIONES
  static String get exploracionGeneral {
    return '${Exploracion.inspeccionGeneral}, '
        'glasgow (E$aperturaOcular, V$respuestaVerbal, M$respuestaMotora)'
        '${compose(Exploracion.rass!, optionalString: "RASS ")}'
        '${compose(coloracionTegumentaria!)}'
        '${compose(coloracionMucosas!)}'
        '. '
        'Cuello '
        '${compose(ingurgitacionYugular!)}'
        '${compose(desviacionTraqueal!)}'
        '${compose(bocioCervical!)}'
        '${compose(adenopatiaCervical!)}'
        '${compose(adenomegaliasCervical!)}'
        '. '
        'Tórax '
        '${compose(amplexionTorax!)}'
        '${compose(amplexacionTorax!)}'
        '${compose(ruidosCardiacos!)}'
        '${compose(murmulloVesicular!)}'
        '${compose(estertoresPulmonar!)}'
        '${compose(sibilanciasPulmonar!)}'
        '. '
        'Tórax '
        '${compose(aspectoAbdomen!)}'
        '${compose(peristalisisAbdomen!)}'
        '${compose(dolorosoAbdomen!)}'
        '${compose(irritacionPeritoneal!)}'
        '. ';

  }


  static String get subjetivos {
    return
        // "El paciente se refiere ${Valores.estadoGeneral}. "
        "${Exploracion.referenciasHospitalizacion}. "
            "${Sentences.capitalize(Exploracion.estadoGeneral)}, "
            "${Exploracion.oxigenSuplementario}. "
            "${Exploracion.viaOral}, "
            "Uresis con frecuencia ${Exploracion.uresisCantidad}, "
            "excretas con frecuencia ${Exploracion.excretasCantidad}. "
            "bristol ${Exploracion.excretasBristol}. ";
  }

  static String compose(String value, {String optionalString = ""}) {
    return value != ""
        ? ", $optionalString$value".toLowerCase()
        : value.toLowerCase();
  }

  // BOOLEANOS
  static bool? isCateterPeriferico = false,
      isCateterLargoPeriferico = false,
      isCateterVenosoCentral = false,
      isCateterHemodialisis = false,
      isSondaFoley = false,
      isDrenajePenrose = false,
      isSondaNasogastrica = false,
      isSondaOrogastrica = false,
      isDrenajePenros = false,
      isPleuroVac = false,
      isColostomia = false,
      isGastrostomia = false,
      isDialisisPeritoneal = false;

  // Referencias del paciente
  static String estadoGeneral = Items.estadoGeneral[0],
      viaOral = Items.viaOralAlimentacion[0],
      uresisCantidad = Items.uresisCantidad[0],
      excretasCantidad = Items.excretasCantidad[0],
      oxigenSuplementario = Items.oxigenSuplementario[0],
      excretasBristol = Items.excretasBristol[0],
      referenciasHospitalizacion =
          "Sin referencias por parte del paciente o el familiar";
// Variables de Valoraciones
  static String? valoracionAsa, valoracionBromage, valoracionNyha;
}

//child: GridView(
//                 shrinkWrap: true,
//                 controller: ScrollController(),
//                 gridDelegate: GridViewTools.gridDelegate(
//                     crossAxisCount: isMobile(context) ? 3 : 5,
//                     mainAxisExtent: 60,
//                     childAspectRatio: 1.0,
//                     crossAxisSpacing: 1.0,
//                     mainAxisSpacing: 1.0),
//                 children: entries.values
//                     .elementAt(index)
//                     .map<Widget>((title) => InputChip(
//                           label: Text(title),
//                           onPressed: () {
//                             // Handle button press here
//                             Exploracion.toJson(
//                                 entries.keys.elementAt(index), title);
//                             //
//                             expoTextController.text = Exploracion.exploracionGeneral;
//                           },
//                           backgroundColor: Colors.black,
//                           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                           labelStyle: const TextStyle(color: Colors.white),
//                         ))
//                     .toList()),
