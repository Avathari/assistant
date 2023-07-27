import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/actividades/pdfGenerete/pdfGenereteFormats/formatosReportes.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/Strings.dart';
import 'package:flutter/material.dart';

class Pacientes {
  static int ID_Paciente = 0, ID_Hospitalizacion = 0;

  static String localPath = 'assets/vault/'
      '${Pacientes.nombreCompleto}/'
      '${Pacientes.nombreCompleto}.json';
  static String localRepositoryPath = 'assets/vault/'
      '${Pacientes.nombreCompleto}/';
  static String localReportsPath = 'assets/vault/'
      '${Pacientes.nombreCompleto}/'
      'reportes/';

  static String? modoAtencion = Valores.modoAtencion, nombreCompleto;
  static bool? esHospitalizado = Valores.isHospitalizado;
  static String imagenPaciente = "";

  // ####### ### ### ## ### ### ####### ####### ####### #######
  // Variables para la asignación del pronóstico médico.
  // ####### ### ### ## ### ### ####### ####### ####### #######
  static String? pronosticoTiempo = PronosticoTiempo[0],
      pronosticoEstado = PronosticoEstado[0],
      pronosticoFuncion = PronosticoFuncion[0],
      pronosticoVida = PronosticoVida[0];

  // Diccionarios por Actividades y gestores.
  static Map<String, dynamic> Paciente = {
    "ID_Pace": 0,
    "Pace_NSS": "",
    "Pace_AGRE": "",
    "Pace_Nome_PI": "",
    "Pace_Nome_SE": "",
    "Pace_Ape_Pat": "",
    "Pace_Ape_Mat": "",
    "Pace_FIAT": "",
    "Pace_UMF": "",
    "Pace_Hosp_Real": "",
    "Pace_Turo": "",
    "Pace_Feca_Hace": "",
    "Pace_Hora_Hace": "",
    "Pace_Tele": "",
    "Pace_Nace": "",
    "Pace_Ses": "",
    "Pace_Hosp": "",
    "Pace_Curp": "",
    "Pace_RFC": "",
    "Pace_Eda": "",
    "Pace_Stat": "",
    "Pace_Ocupa": "",
    "Pace_Edo_Civ": "",
    "Pace_Reli": "",
    "Pace_Esco": "",
    "Pace_Esco_COM": "",
    "Pace_Esco_ESPE": "",
    "Pace_Orig_Muni": "",
    "Pace_Orig_EntFed": "",
    "Pace_Resi_Loca": "",
    "Pace_Resi_Dur": "",
    "Pace_Domi": "",
    "Indi_Pace_SiNo": "",
    "IndiIdio_Pace_SiNo": "",
    "IndiIdio_Pace_Espe": ""
  };
  static Map<String, dynamic> Vital = {};
  static Map<String, dynamic> Auxiliar = {};

  static Map<String, dynamic> Electrocardiogramas = {
    "EC_sV1": 0,
    "EC_rV6": 0,
    "EC_rDI": 0,
    "EC_sDIII": 0,
    "EC_rDIII": 0,
    "EC_sDI": 0,
    "EC_rAVL": 0,
    "EC_sV3": 0,
  };
  static Map<String, dynamic> Imagenologias = {};

  //
  static List? Eticos = [],
      Viviendas = [],
      Alimenticios = [],
      Diarios = [],
      Higienes = [],
      Limitantes = [],
      Exposiciones = [],
      Toxicomanias = [];
  //
  static List? Heredofamiliares = [];
  //
  static List? Vitales = [];
  //
  static List? Sexualogicos = [];
  static List? Femeninologicos = [];
  static List? Masculinologicos = [];

  static List? Vihs = [];
  //
  static List? Alergicos = [];
  static List? Patologicos = [];
  static List? Quirurgicos = [];
  static List? Transfusionales = [];
  static List? Inmunizaciones = [];
  static List? Traumatologicos = [];
  static List? Vacunales = [];
  //
  static List? Licencias = [];
  static List? Balances = [];
  static List? Notas = []; // Registro de Análisis, Notas y Eventualidades.
  static List? Ventilaciones = [];
  //
  static List? Hospitalizaciones = [];
  static List? Diagnosticos = [];
  //
  static List? Sexuales = [];
  static List? Antirretrovirales = [];
  static List? Embarazos = [];
  //
  static List? Paraclinicos = [];
  static List? Imagenologicos = [];
  static List? Pendiente = [];

  static String get diasOrdinalesEstancia {
    return Items.ordinales[Valores.diasEstancia];
  }

  // static List? Imagenologias = [];
  static Future pacientesHospitalizados() async {
    List hospitalizaed = [];
    // ********** ************** ***********
    Actividades.consultar(
      Databases.siteground_database_regpace,
      Pacientes.pacientes['consultHospitalized'],
    ).then((response) async {
      var ids = Listas.listFromMapWithOneKey(response, keySearched: 'ID_Pace');
      for (var item in ids) {
        hospitalizaed.add(await Actividades.consultarId(
          Databases.siteground_database_reghosp,
          "SELECT * FROM pace_hosp WHERE ID_Pace = ? "
          "ORDER BY ID_Hosp ASC",
          item,
        ));
      }
      // ********** ************** ***********
      for (var v = 0; v < response.length; v++) {
        if (hospitalizaed[v].keys.contains('Error')) {
          response[v].addAll({
            "ID_Hosp": 0,
            "Feca_INI_Hosp": '0000-00-00',
            "Id_Cama": 'NA',
            "Dia_Estan": 0,
            "Medi_Trat": 'N/A',
            "Serve_Trat": 'N/A',
            "Serve_Trat_INI": 'N/A',
            "Feca_EGE_Hosp": '0000-00-00',
            "EGE_Motivo": ""
          });
          response[v].addAll({
            "Pendientes": [],
          });
        } else {
          response[v].addAll(hospitalizaed[v]);
          response[v].addAll({
            "Pendientes": await Actividades.consultarAllById(
              Databases.siteground_database_reghosp,
              "SELECT * FROM pace_pen WHERE ID_Pace = ? "
              "AND ID_Hosp = '${hospitalizaed[v]['ID_Hosp']}' "
              "AND Pace_PEN_realized = '1'",
              response[v]['ID_Pace'],
            )
          });
        }
      }
      // ********** ************** ***********
      return response;
      // ********** ************** ***********
    });
  }

  Pacientes(numeroPaciente, agregadoPaciente, primerNombre, segundoNombre,
      apellidoPaterno, apellidoMaterno, imagenUsuario) {
    Pacientes.nombreCompleto =
        "$apellidoPaterno $apellidoMaterno $primerNombre $segundoNombre";
    Pacientes.imagenPaciente = "$imagenUsuario";
  }

  static fromJson(Map<String, dynamic> json) {
    // numeroPaciente = json['Pace_NSS'];
    // agregadoPaciente = json['Pace_AGRE'];

    ID_Paciente = json['ID_Pace'];
    Paciente = json;

    if (json['Pace_Nome_SE'] == '' || json['Pace_Nome_SE'] == null) {
      nombreCompleto =
          "${json['Pace_Nome_PI']} ${json['Pace_Ape_Pat']} ${json['Pace_Ape_Mat']}";
    } else {
      nombreCompleto =
          "${json['Pace_Nome_PI']} ${json['Pace_Nome_SE']} ${json['Pace_Ape_Pat']} ${json['Pace_Ape_Mat']}";
    }

    localPath = 'assets/vault/'
        '$nombreCompleto/'
        '$nombreCompleto.json';
    localRepositoryPath = 'assets/vault/'
        '$nombreCompleto/';
    localReportsPath = 'assets/vault/'
        '$nombreCompleto/'
        'reportes/';
  }

  // Prosas y apartados literales en la formación de las Actividades.
  static String originario() {
    if (Valores.sexo == 'Masculino') {
      return "Originario de ${Pacientes.Paciente['Pace_Orig_Muni']}, ${Pacientes.Paciente['Pace_Orig_EntFed']}";
    } else if (Valores.sexo == 'Femenino') {
      return "Originaria ${Pacientes.Paciente['Pace_Orig_Muni']}, ${Pacientes.Paciente['Pace_Orig_EntFed']}";
    } else {
      return "${Pacientes.Paciente['Pace_Orig_Muni']}, ${Pacientes.Paciente['Pace_Orig_EntFed']}";
    }
  }

  static String residente() {
    return "la localidad de ${Pacientes.Paciente['Pace_Resi_Loca']}";
    // "por ${Pacientes.Paciente['Pace_Resi_Dur'].toString()} año(s)";
  }

  static String estadoCivil() {
    if (Valores.sexo == 'Masculino') {
      switch (Pacientes.Paciente['Pace_Edo_Civ']) {
        case "Soltero(a)":
          return "Soltero";
        case "Casado(a)":
          return "Casado";
        case "Union Libre":
          return "Unión Libre";
        case "Separado(a)":
          return "Separado";
        case "Viudo(a)":
          return "Viudo";
        default:
          return "";
      }
    } else if (Valores.sexo == 'Femenino') {
      switch (Pacientes.Paciente['Pace_Edo_Civ']) {
        case "Soltero(a)":
          return "Soltera";
        case "Casado(a)":
          return "Casada";
        case "Union Libre":
          return "Unión Libre";
        case "Separado(a)":
          return "Separada";
        case "Viudo(a)":
          return "Viuda";
        default:
          return "";
      }
    } else {
      return "";
    }
  }

  static String prosa({bool isTerapia = false}) {
    if (isTerapia == true) {
      // ************* *********** ************* ************ ********* ********
      return "${Pacientes.Paciente['Pace_Ses']} de ${Pacientes.Paciente['Pace_Eda']} años, "
          "en su ${Pacientes.diasOrdinalesEstancia.toLowerCase()} día de estancia intrahospitalaria, "
          "bajo los siguientes diagnósticos: \n";
    } else {
      String nacimiento = "";
      if (Valores.sexo == 'Masculino') {
        nacimiento = "nacido el ${Pacientes.Paciente['Pace_Nace']}. ";
      } else if (Valores.sexo == 'Femenino') {
        nacimiento = "nacida el ${Pacientes.Paciente['Pace_Nace']}. ";
      } else {
        return "";
      }

      // ************* *********** ************* ************ ********* ********
      return "${Pacientes.Paciente['Pace_Ses']} de ${Pacientes.Paciente['Pace_Eda']} años, "
          "$nacimiento"
          "${originario()}; residente de ${residente()}. "
          "Escolaridad hasta ${Pacientes.Paciente['Pace_Esco'].toLowerCase().trimRight()}, "
          "ocupación como ${Pacientes.Paciente['Pace_Ocupa'].toLowerCase().trimRight()}, "
          "religión ${Pacientes.Paciente['Pace_Reli'].toLowerCase().trimRight()}, "
          "estado civil ${estadoCivil().toLowerCase().trimRight()}. "
          "Hemotipo ${Pacientes.Paciente['Pace_Hemo'].trim()}. \n ";
    }
  }

  static String heredofamiliares() {
    return "Con desconocimiento de enfermedades preexistentes";
  }

  static String epidemiologicos() {
    return "Antecedentes epidemiológicos";
  }

  static String hospitalarios() {
    // Reportes.reportes['Antecedentes_Quirurgicos'] = ""; **** ********** **** ***
    // Reportes.antecedentesQuirurgicos = "";
    // print("Quirurgicos ${Quirurgicos!.length} $Quirurgicos \n "
    //     "Reportes.Antecedentes_Quirurgicos ${Reportes.antecedentesQuirurgicos}"
    //     "isEmpty ${Quirurgicos!.isEmpty}");
    // ************************ ************** ********** **** *** *
    if (Quirurgicos != []) {
      // || Quirurgicos!.isNotEmpty
      Reportes.antecedentesQuirurgicos = "";
      for (var element in Quirurgicos!) {
        if (Reportes.antecedentesQuirurgicos == "") {
          Reportes.antecedentesQuirurgicos =
              "${element['Pace_APP_QUI']} realizado hace ${element['Pace_APP_QUI_dia']} años, "
              "${element['Pace_APP_QUI_com'].toString().toLowerCase()}";
        } else {
          Reportes.antecedentesQuirurgicos =
              "${Reportes.antecedentesQuirurgicos}; ${element['Pace_APP_QUI']} realizado hace ${element['Pace_APP_QUI_dia']} años, "
              "${element['Pace_APP_QUI_com'].toString().toLowerCase()}";
        }
      }
    } else {
      Reportes.antecedentesQuirurgicos = "negados";
    }
    // ************************ ************** ********** **** *** *
    return Reportes.antecedentesQuirurgicos!;
    // return "negados";
  }

  static String traumaticos() {
    // ************************ ************** ********** **** *** *
    // Reportes.reportes['Antecedentes_Alergicos'] = "";
    // Reportes.antecedentesTraumatologicos = "";

    // // print("Traumatologicos ${Traumatologicos!.length} $Traumatologicos \n "
    //"Reportes.antecedentesTraumatologicos ${Reportes.antecedentesTraumatologicos}");
    // ************************ ************** ********** **** *** *
    if (Traumatologicos != []) {
      for (var element in Traumatologicos!) {
        if (Reportes.antecedentesTraumatologicos == "") {
          Reportes.antecedentesTraumatologicos =
              "${Reportes.antecedentesAlergicos}${element['Pace_APP_ALE']} diagnósticado hace ${element['Pace_APP_ALE_dia']} años. ";
        }
      }
    } else {
      Reportes.antecedentesTraumatologicos = "negados";
    }
    // ************************ ************** ********** **** *** *
    return Reportes.antecedentesTraumatologicos!;
    // return "negados";
  }

  static String alergicos() {
    // ************************ ************** ********** **** *** *
    // Reportes.reportes['Antecedentes_Alergicos'] = "";
    // Reportes.antecedentesAlergicos = "";

    // // print("Alergicos ${Alergicos!.length} $Alergicos \n "
    //"Reportes.Antecedentes_Alergicos ${Reportes.antecedentesAlergicos}");
    // ************************ ************** ********** **** *** *
    if (Alergicos != []) {
      for (var element in Alergicos!) {
        if (Reportes.antecedentesAlergicos == "") {
          Reportes.antecedentesAlergicos =
              "${Reportes.antecedentesAlergicos}${element['Pace_APP_ALE']} diagnósticado hace ${element['Pace_APP_ALE_dia']} años. ";
        }
      }
    } else {
      Reportes.antecedentesAlergicos = "negados";
    }
    // ************************ ************** ********** **** *** *
    return Reportes.antecedentesAlergicos!;
    // return "negados";
  }

  static String noPatologicos() {
    // return 'Sin información recabada';
    return "${Formatos.ideologias}\n"
        "${Formatos.viviendas}\n"
        "${Formatos.alimentarios}\n"
        "${Formatos.diarios}\n"
        "${Formatos.higienicos}\n"
        "${Formatos.limitaciones}\n"
        "${Formatos.exposiciones}\n"
        "${Formatos.toxicomanias}\n";
  }

  static String noPatologicosSimple() {
    return "${Formatos.viviendas}\n"
        "${Formatos.alimentarios}\n"
        "${Formatos.diarios}\n"
        "${Formatos.higienicos}\n"
        "${Formatos.exposiciones}\n"
        "${Formatos.toxicomanias}\n";
  }

  static String noPatologicosAnalisis() {
    return "${antecedentesPatologicos()}"
        "${Formatos.limitaciones}\n"
        "${Formatos.exposiciones}\n"
        "${Formatos.toxicomanias}";
  }

  static String motivoPrequirurgico() {
    return ""
        "Tipo de Cirugía: ${Valores.tipoCirugia}. \n"
        "Motivo de la Cirugía: ${Valores.motivoCirugia}. \n"
        "Tipo de Interrogatorio: ${Valores.tipoInterrogatorio}. "
        "";
  }

  static String antecedentesIngresosPatologicos() {
    return "Antecedentes patológicos: ${Pacientes.patologicos()}\n"
        "Antecedentes quirúrgicos: ${Pacientes.hospitalarios()}.\n"
        "Antecedentes alérgicos: ${Pacientes.alergicos()}\n";
    // "Antecedentes traumáticos: ${Pacientes.traumaticos()}\n";
  }

  static String antecedentesPatologicos() {
    return "Antecedentes heredofamiliares: ${Sentences.capitalize(Pacientes.heredofamiliares())}.\n"
        "Antecedentes quirúrgicos: ${Pacientes.hospitalarios()}.\n"
        "Antecedentes alérgicos: ${Pacientes.alergicos()}\n"
        "Antecedentes patológicos: ${Pacientes.patologicos()}\n";
  }

  static String patologicos() {
    // ************************ ************** ********** **** *** *
    // Reportes.reportes['Antecedentes_Patologicos'] = "";
    // Reportes.personalesPatologicos = "";
    // // print("Patologicos ${Patologicos!.length} $Patologicos \n ");
    //"Reportes.Antecedentes_Patologicos ${Reportes.personalesPatologicos}");
    // ************************ ************** ********** **** *** *
    if (Patologicos != []) {
      Reportes.personalesPatologicos = "";

      for (var element in Patologicos!) {
        if (Reportes.personalesPatologicos == "") {
          Reportes.personalesPatologicos = "${element['Pace_APP_DEG_com']} "
              "diagnósticado hace ${element['Pace_APP_DEG_dia']} años, "
              "actualmente ${element['Pace_APP_DEG_tra'].toString().toLowerCase()}. "
              "${element['Pace_APP_DEG_sus'].toString().toLowerCase()}";
        } else {
          Reportes.personalesPatologicos =
              "${Reportes.personalesPatologicos}\n:${element['Pace_APP_DEG_com']} "
              "diagnósticado hace ${element['Pace_APP_DEG_dia']} años, "
              "actualmente ${element['Pace_APP_DEG_tra'].toString().toLowerCase()}. "
              "${element['Pace_APP_DEG_sus'].toString().toLowerCase()}";
        }
      }
    } else {
      Reportes.personalesPatologicos = "negados";
    }
    // ************************ ************** ********** **** *** *
    // // // print("Reportes.impresionesDiagnosticas ${Reportes.impresionesDiagnosticas}");
    // Reportes.reportes['Antecedentes_Patologicos'] =
    //     Reportes.personalesPatologicos;
    // ************************ ************** ********** **** *** *
    return Reportes.personalesPatologicos!;
  }

  static String perinatales() {
    return "Antecedentes perinatales desconocidos";
  }

  static String sexuales() {
    return "Antecedentes sexuales no informados";
  }

  // static void ultimosVitales() {
  //   Actividades.consultarId(Databases.siteground_database_regpace,
  //           Vitales.vitales['consultLastQuery'], Pacientes.ID_Paciente)
  //       .then((value) {
  //     Pacientes.Vital = value;
  //   });
  // }

  static String signosVitales({int? indice = 0}) {
    switch (indice) {
      case 0:
        return Valorados.vitales;
      case 1:
        return Valorados.signosVitales;
      case 2:
        return Valorados.bioconstantes;
      case 3:
        return Valorados.antropometricos;
      case 4:
        // return "Asociados a riesgo";
        return Valorados.asociadosRiesgo;
      case 5:
        return "Antropometría infantil";
      default:
        return "Signos vitales registrados";
    }
  }

  static String exploracionFisica({int? indice = 0}) {
    switch (indice) {
      case 0:
        return "Sin hallazgos relevantes en la exploración física";
      case 1:
        // "Exploración acortada";
        return "Conciente, orientado y cooperador. Palidez mucotegumentaria, sin datos de deshidratación. "
            "Pupilas isocóricas normorreflectivas, con respuesta fotomotora adecuada. \n"
            "Tórax con movimientos de amplexión y amplexación sin restricciones. "
            "Ruidos pulmonares con murmullo vesicular audible, sin presencia a la exploración de "
            "estertores y/o sibilancias. "
            "Ruidos cardiacos consecuentes con pulso, de aspecto rimico sin sonidos agregados, descartándose "
            "ruidos adventicios e incluso tercer ruido. \n"
            "Abdomen con peristalsis normoaudible, timpánico a la percusión, sin evidencia de lesiones "
            "dermatológicas. A la palpación superficial sin datos de irritación peritoneal, con sensibilidad "
            "normal; a la palpación media sin dolor referido, puntos dolorosos negativos. \n"
            "Extremidades integras con movimiento activo y pasivo sin restricciones. Fuerza muscular 5/5 (Daniels), "
            "reflejos de estiramiento muscular ++/++++ (Siedel). \n"
            "Columna sin limitación a los movimientos, vertebras integras en lo que respecta a la apófisis espinosa";
      case 2:
        return "Exploración extensa";
      case 3:
        return "Análisis de terapia intensiva";
      case 4:
        return "Glasgow E4, V5, M6, hidratado, pálidez tegumentaria. "
            "Precordio rítmico, sin agregados. Murmullo vesicular audible, sin estertores ni sibilancias. "
            "Abdomen sin alteraciones, normoperistalsis, no doloroso, sin irritación peritoneal. "
            "Extremidades funcionales, fuerza conservada, reflejos osteotendinosos, no edema, llenado capilar normal. ";
      case 5:
        return "";
      default:
        return Reportes.exploracionFisica;
    }
  }

  static String analisisComplementarios({int? indice = 0}) {
    switch (indice) {
      case 1:
        return Valorados.antropometricos; // Antropométricos
      case 2:
        return Valorados.metabolometrias; // Metabólicos
      case 3:
        return Valorados.cardiovasculares; // Cardiovasculares
      case 4:
        return Valorados.hidricos; // Hídricos
      case 5:
        return "Análisis $indice"; // Hepáticos
      case 6:
        return "Análisis $indice"; // Hemáticos
      case 7:
        return Valorados.renales; // Renales
      case 8:
        return "Análisis $indice";
      case 9:
        return "Análisis $indice";
      default:
        return "Análisis complementarios";
    }
  }

  static String auxiliaresDiagnosticos(
      {int? indice = 0, String fechaActual = ""}) {
    if (indice! < 20) {
      return Auxiliares.porTipoEstudio(
          indice: indice, fechaActual: fechaActual);
    } else if (indice == 20) {
      return Auxiliares.electrocardiograma();
    } else {
      return "";
    }
  }

  static String diagnosticos() {
    // ************************ ************** ********** **** *** *
    Reportes.reportes['Impresiones_Diagnosticas'] = "";
    Reportes.impresionesDiagnosticas = "";

    // ************************ ************** ********** **** *** *
    if (Patologicos != []) {
      for (var element in Patologicos!) {
        if (Reportes.impresionesDiagnosticas == "") {
          Reportes.impresionesDiagnosticas =
              "${element['Pace_APP_DEG']} (${element['Pace_APP_DEG_com']}). ";
        } else {
          Reportes.impresionesDiagnosticas =
              "${Reportes.impresionesDiagnosticas}\n${element['Pace_APP_DEG']} (${element['Pace_APP_DEG_com']}). \n";
        }
      }
    }
    // ************************ ************** ********** **** *** *
    // // print("Diagnosticos $Diagnosticos");
    if (Diagnosticos != []) {
      for (var element in Diagnosticos!) {
        if (Reportes.impresionesDiagnosticas != "") {
          Reportes.impresionesDiagnosticas =
              "${Reportes.impresionesDiagnosticas.substring(0, Reportes.impresionesDiagnosticas.length - 1)} \n"
              // "${element['Pace_APP_DEG']} (${element['Pace_APP_DEG_com']}). ";
              "${element['Pace_APP_DEG_com']}. ";
        } else {
          Reportes.impresionesDiagnosticas = "${element['Pace_APP_DEG_com']}. ";
          // "${element['Pace_APP_DEG']} (${element['Pace_APP_DEG_com']}). ";
        }
      }
    }

    // // print("Reportes.impresionesDiagnosticas ${Reportes.impresionesDiagnosticas}");
    Reportes.reportes['Impresiones_Diagnosticas'] =
        Reportes.impresionesDiagnosticas;
    // ************************ ************** ********** **** *** *
    return Reportes.impresionesDiagnosticas;
  }

  static String diagnosticosCie() {
    // ************************ ************** ********** **** *** *
    Reportes.reportes['Impresiones_Diagnosticas'] = "";
    Reportes.impresionesDiagnosticas = "";

    // ************************ ************** ********** **** *** *
    if (Patologicos != []) {
      for (var element in Patologicos!) {
        if (Reportes.impresionesDiagnosticas == "") {
          Reportes.impresionesDiagnosticas = "${element['Pace_APP_DEG']}";
        } else {
          Reportes.impresionesDiagnosticas =
              "${Reportes.impresionesDiagnosticas}\n${element['Pace_APP_DEG']}\n";
        }
      }
    }
    // ************************ ************** ********** **** *** *
    // print("Diagnosticos $Diagnosticos");
    if (Diagnosticos != []) {
      for (var element in Diagnosticos!) {
        if (Reportes.impresionesDiagnosticas != "") {
          Reportes.impresionesDiagnosticas =
              "${Reportes.impresionesDiagnosticas.substring(0, Reportes.impresionesDiagnosticas.length - 1)} \n"
              "${element['Pace_APP_DEG']}";
        } else {
          Reportes.impresionesDiagnosticas = "${element['Pace_APP_DEG']}";
        }
      }
    }

    // // print("Reportes.impresionesDiagnosticas ${Reportes.impresionesDiagnosticas}");
    Reportes.reportes['Impresiones_Diagnosticas'] =
        Reportes.impresionesDiagnosticas;
    // ************************ ************** ********** **** *** *
    return Reportes.impresionesDiagnosticas;
  }

  static String subjetivos() {
    return Reportes.subjetivoHospitalizacion;
  }

  static String pronosticoMedico() {
    return "Estado actual: ${Pacientes.pronosticoEstado}. \n"
        "Pronóstico Médico: ${Pacientes.pronosticoFuncion}, ${Pacientes.pronosticoVida}, ${Pacientes.pronosticoTiempo}";
  }

  static final List<String> Municipios = [
    "Benito Juarez",
    "José Maria Morelos",
    "Solidaridad",
    "Cozumel",
    "Lazaro Cardenas",
    "Aculcalpan"
  ];
  static final List<String> EntidadesFederativas = [
    'Aguascalientes',
    'Baja California',
    'Baja California Sur',
    'Campeche',
    'Chiapas',
    'Chihuahua',
    'Ciudad de México',
    'Coahuila',
    'Colima',
    'Durango',
    'Guanajuato',
    'Guerrero',
    'Hidalgo',
    'Jalisco',
    'México',
    'Estado de México',
    'Michoacán',
    'Morelos',
    'Nayarit',
    'Nuevo León',
    'Oaxaca',
    'Puebla',
    'Querétaro',
    'Quintana Roo',
    'San Luis Potosí',
    'Sinaloa',
    'Sonora',
    'Tabasco',
    'Tamaulipas',
    'Tlaxcala',
    'Veracruz',
    'Yucatán',
    'Zacatecas'
  ];

  static final List<String> Sexo = ["Femenino", "Masculino"];
  static final List<String> EstadoCivil = [
    "Soltero(a)",
    "Casado(a)",
    "Union Libre",
    "Separado(a)",
    "Viudo(a)"
  ];
  static final List<String> Escolaridad = [
    'Analfabeta',
    'Primaria',
    'Secundaria',
    'Preparatoria',
    'Preparatoria Técnica',
    'Licenciatura',
    'Maestría',
    'Posgrado',
    'Doctorado'
  ];
  static final List<String> EscolaridadCompletud = [
    "Grado Escolar Completo",
    "Grado Escolar Incompleto",
  ];
  static final List<String> Unidades = [
    "H.G.R. 200",
    "H.G.Z. 18",
    "H.G.R. 17",
    'H.G.Z. 1',
    'INSABI No 27',
    "C.A.F. Bacalar",
    "Consulta Externa"
  ];
  static final List<String> Atencion = [
    'Hospitalización',
    'Otra Hospitalización',
    'Consulta Externa',
    'Privado'
  ];
  static final List<String> Turno = ["Matutino", "Vespertino"];
  static final List<String> Vivo = [
    'Vivo(a)',
    'Muerto(a)',
  ];
  static final List<String> Status = [
    'Vivo(a)',
    'Muerto(a)',
    'Perdió Vigencia'
  ];
  static final List<String> Indigena = [
    "Si",
    "No",
  ];
  static final List<String> lenguaIndigena = [
    "Niega hablar alguna Lengua Indigena",
    "Refiere hablar alguna Lengua Indigena"
  ];
  // ##################### #### ## ########
  static List<String> PronosticoFuncion = [
    "Bueno para la función",
    "Malo para la función"
  ];
  static List<String> PronosticoVida = [
    "Bueno para la vida",
    "Malo para la vida"
  ];
  static List<String> PronosticoTiempo = [
    "a corto plazo",
    "a mediano plazo",
    "a largo plazo",
  ];
  static List<String> PronosticoEstado = [
    "Muy delicado",
    "Delicado",
    "Mejorado",
    "Grave",
  ];

  static final Map<String, dynamic> pacientes = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_iden_iden;",
    "showColumns": "SHOW columns FROM pace_iden_iden",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_iden_iden'",
    "createQuery": """CREATE TABLE pace_iden_iden (
                  ID_Pace int(10) NOT NULL,
                  Pace_NSS varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_AGRE varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Nome_PI varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Nome_SE varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Ape_Pat varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Ape_Mat varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Hemo varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_FIAT longblob NOT NULL, 
                  Pace_UMF varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Hosp_Real varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Turo varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Feca_Hace date NOT NULL,
                  Pace_Hora_Hace time(6) NOT NULL,
                  Pace_Tele varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Nace date NOT NULL,
                  Pace_Ses varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Hosp varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Curp varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_RFC varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Eda int(11) NOT NULL,
                  Pace_Stat varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Ocupa varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Edo_Civ varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Reli varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Esco varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Esco_COM varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Esco_ESPE varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Orig_Muni varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Orig_EntFed varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Resi_Loca varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Resi_Dur int(11) NOT NULL,
                  Pace_Domi varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  Indi_Pace_SiNo varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  IndiIdio_Pace_SiNo varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  IndiIdio_Pace_Espe varchar(50) COLLATE utf8_unicode_ci NOT NULL 
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Esta Tabla es para Agregar Datos Generales de los Pacientes';""",
    "truncateQuery": "TRUNCATE pace_iden_iden",
    "dropQuery": "DROP TABLE pace_iden_iden",
    "consultQuery": "SELECT ID_Pace, Pace_NSS, Pace_AGRE, "
        "Pace_Nome_PI, Pace_Nome_SE, Pace_Ape_Pat, Pace_Ape_Mat, "
        "Pace_Hemo, " // Pace_FIAT, "
        "Pace_UMF, Pace_Hosp_Real, Pace_Turo, "
        "Pace_Feca_Hace, Pace_Hora_Hace, "
        "Pace_Tele, Pace_Nace, Pace_Ses, Pace_Hosp, "
        "Pace_Curp, Pace_RFC, Pace_Eda, Pace_Stat, "
        "Pace_Ocupa, Pace_Edo_Civ, Pace_Reli, "
        "Pace_Esco, Pace_Esco_COM, Pace_Esco_ESPE, "
        "Pace_Orig_Muni, Pace_Orig_EntFed, "
        "Pace_Resi_Loca, Pace_Resi_Dur, Pace_Domi, Indi_Pace_SiNo, "
        "IndiIdio_Pace_SiNo, IndiIdio_Pace_Espe "
        "FROM pace_iden_iden",
    "consultIdQuery": "SELECT ID_Pace, Pace_NSS, Pace_AGRE, "
        "Pace_Nome_PI, Pace_Nome_SE, Pace_Ape_Pat, "
        "Pace_Ape_Mat, Pace_Hemo, Pace_FIAT, "
        "Pace_UMF, Pace_Hosp_Real, Pace_Turo, Pace_Feca_Hace, Pace_Hora_Hace, "
        "Pace_Tele, Pace_Nace, Pace_Ses, Pace_Hosp, Pace_Curp, "
        "Pace_RFC, Pace_Eda, Pace_Stat, "
        "Pace_Ocupa, Pace_Edo_Civ, Pace_Reli, Pace_Esco, Pace_Esco_COM, Pace_Esco_ESPE, "
        "Pace_Orig_Muni, Pace_Orig_EntFed, Pace_Resi_Loca, Pace_Resi_Dur, "
        "Pace_Domi, Indi_Pace_SiNo, "
        "IndiIdio_Pace_SiNo, IndiIdio_Pace_Espe FROM pace_iden_iden WHERE ID_Pace = ?",
    "consultHospitalized": "SELECT "
        "ID_Pace, Pace_NSS, Pace_AGRE, "
        "Pace_Nome_PI, Pace_Nome_SE, Pace_Ape_Pat, Pace_Ape_Mat, "
        "Pace_Hemo, "
        "Pace_UMF, Pace_Hosp_Real, Pace_Turo, "
        "Pace_Feca_Hace, Pace_Hora_Hace, "
        "Pace_Tele, Pace_Nace, Pace_Ses, Pace_Hosp, "
        "Pace_Curp, Pace_RFC, Pace_Eda, Pace_Stat, "
        "Pace_Ocupa, Pace_Edo_Civ, Pace_Reli, "
        "Pace_Esco, Pace_Esco_COM, Pace_Esco_ESPE, "
        "Pace_Orig_Muni, Pace_Orig_EntFed, "
        "Pace_Resi_Loca, Pace_Resi_Dur, Pace_Domi, Indi_Pace_SiNo, "
        "IndiIdio_Pace_SiNo, IndiIdio_Pace_Espe "
        "FROM pace_iden_iden WHERE Pace_Hosp = '${Pacientes.Atencion[0]}' "
        "ORDER BY ID_Pace ASC",
    "consultConsulted":
        "SELECT ID_Pace FROM pace_iden_iden WHERE Pace_Hosp = '${Pacientes.Atencion[1]}'",
    "consultImage": "SELECT Pace_FIAT FROM pace_iden_iden WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_iden_iden",
    "consultLastQuery": "SELECT * FROM pace_iden_iden ORDER BY ID_Pace DESC",
    "consultByName":
        "SELECT Pace_Ape_Pat FROM pace_iden_iden WHERE Us_Nome LIKE '%",
    "registerQuery": "INSERT INTO pace_iden_iden ("
        "Pace_NSS, Pace_AGRE, "
        "Pace_Nome_PI, Pace_Nome_SE, Pace_Ape_Pat, Pace_Ape_Mat, "
        "Pace_Hemo, Pace_FIAT, "
        "Pace_UMF, Pace_Hosp_Real, Pace_Turo, Pace_Feca_Hace, Pace_Hora_Hace, "
        "Pace_Tele, Pace_Nace, Pace_Ses, Pace_Hosp, Pace_Curp, "
        "Pace_RFC, Pace_Eda, Pace_Stat, "
        "Pace_Ocupa, Pace_Edo_Civ, Pace_Reli, Pace_Esco, Pace_Esco_COM, Pace_Esco_ESPE, "
        "Pace_Orig_Muni, Pace_Orig_EntFed, Pace_Resi_Loca, Pace_Resi_Dur, Pace_Domi, "
        "Indi_Pace_SiNo, IndiIdio_Pace_SiNo, IndiIdio_Pace_Espe) "
        "VALUES (?,?,?,?,?,?,?, from_base64(?), "
        "?,?,?,?,?, "
        "?,?,?,?,?, "
        "?,?,?, "
        "?,?,?,?,?,?,?,?,?,?,?, "
        "?,?,?)",
    "updateQuery": "UPDATE pace_iden_iden "
        "SET ID_Pace = ?, Pace_NSS = ?, Pace_AGRE = ?, "
        "Pace_Nome_PI = ?, Pace_Nome_SE = ?, Pace_Ape_Pat = ?, Pace_Ape_Mat = ?, "
        "Pace_Hemo = ?, Pace_FIAT = from_base64(?), "
        "Pace_UMF = ?, Pace_Hosp_Real = ?, Pace_Turo = ?, Pace_Feca_Hace = ?, Pace_Hora_Hace = ?, "
        "Pace_Tele = ?, Pace_Nace = ?, Pace_Ses = ?, Pace_Hosp = ?, Pace_Curp = ?, "
        "Pace_RFC = ?, Pace_Eda = ?, Pace_Stat = ?, "
        "Pace_Ocupa = ?, Pace_Edo_Civ = ?, Pace_Reli = ?, Pace_Esco = ?, Pace_Esco_COM = ?, Pace_Esco_ESPE = ?, "
        "Pace_Orig_Muni = ?, Pace_Orig_EntFed = ?, Pace_Resi_Loca = ?, Pace_Resi_Dur = ?, Pace_Domi = ?, Indi_Pace_SiNo = ?, "
        "IndiIdio_Pace_SiNo = ?, IndiIdio_Pace_Espe = ? "
        "WHERE ID_Pace = ?",
    "deleteQuery": "DELETE FROM pace_iden_iden WHERE ID_Pace = ?",
    "updateHospitalizacionQuery": "UPDATE pace_iden_iden "
        "SET Pace_Hosp = ? "
        "WHERE ID_Pace = ?",
    "pacientesColumns": [
      "ID_Pace",
      "Us_Nome",
      "Us_Ape_Pat",
      "Us_Ape_Mat",
      "Us_Usuario",
      "Us_Passe",
      "Us_Permi",
      "Us_EspeL",
      "Us_Area",
      "Us_Stat",
      "Pace_FIAT",
      "Usu_ADAM_AGE"
    ],
    "pacientesItems": [
      "ID_Pace",
      "Nombre_Completo",
      "Apellido_Paterno",
      "Apellido_Materno",
      "Paciente",
      "Contraseña",
      "Permisos",
      "Especialización",
      "Area",
      "Estatus",
      "Anexado_por"
    ],
    "pacientesColums": [
      "ID Paciente",
      "Nombre Completo",
      "Apellido Paterno",
      "Apellido Materno",
      "Paciente",
      "Contraseña",
      "Permiso(s)",
      "Especialización",
      "Area",
      "Estatus",
      "Anexado Por"
    ],
    "pacientesStats": [
      "Total_Administradores",
      "Total_Mip",
      "Total_Mpss",
      "Total_Mg",
      "Total_Medesp",
      "Total_Tegra",
      "Total_Enfra",
      "Total_Enfesp",
      "Total_Tec",
      "Total_Secre",
      "Total_Captu",
      "Total_Inge",
      "Total_Directivos",
      "Total_Guardias",
      "Total_Logistica",
      "Total_Mantenimiento",
      "Total_Traslado_Intra",
      "otal_Traslado_Extra",
    ],
    "pacientesStadistics": "SELECT "
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE Pace_Ses = '${Pacientes.Sexo[0]}') as Total_Mujeres,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE Pace_Ses = '${Pacientes.Sexo[1]}') as Total_Hombres,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE Pace_Hosp = '${Pacientes.Atencion[0]}') as Total_Hospitalizacion,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE Pace_Hosp = '${Pacientes.Atencion[1]}') as Total_Consulta,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE Pace_Turo = '${Pacientes.Turno[0]}') as Total_Matutino,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE Pace_Turo = '${Pacientes.Turno[1]}') as Total_Vespertino,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE Pace_Stat = '${Pacientes.Vivo[0]}') as Total_Vivos,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE Pace_Stat = '${Pacientes.Vivo[1]}') as Total_Fallecidos,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE IndiIdio_Pace_SiNo = '${Pacientes.Indigena[0]}') as Total_Indigenas,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE IndiIdio_Pace_SiNo = '${Pacientes.Indigena[1]}') as Total_No_Indigenas,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE IndiIdio_Pace_SiNo = '${Pacientes.lenguaIndigena[0]}') as Total_Hablantes,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE IndiIdio_Pace_SiNo = '${Pacientes.lenguaIndigena[1]}') as Total_No_Hablantes,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden) as Total_Pacientes;"
  };

  static final List<String> Categorias = [
    "Total de Mujeres",
    "Total de Hombres",
    "Total de Hospitalizados",
    "Total en Consulta Externa",
    "Total del Turno Matutino",
    "Total del Turno Vespertino",
    "Total de Pacientes registrados Vivos",
    "Total de Pacientes registrados Fallecidos",
    "Total de Pacientes Considerados Indígenas",
    "Total de Pacientes Considerados No Indígenas",
    "Total de Pacientes Hablantes de Lenguas Indígenas",
    "Total de Pacientes Hablantes No de Lenguas Indígenas",
    "Total de Pacientes registrados"
  ];

  static Future<bool> hospitalizar() async {
    String modus = '';
    // Actualizar la variable en la base de datos.
    if (modoAtencion == 'Hospitalización') {
      modus = 'Consulta Externa';
      //
      final response = await Actividades.actualizar(
          Databases.siteground_database_regpace,
          pacientes['updateHospitalizacionQuery'],
          [modus, Pacientes.ID_Paciente],
          Pacientes.ID_Paciente);

      if (response == 'SUCCESS') {
        return false;
      } else {
        return true;
      }
    } else if (modoAtencion == 'Consulta Externa') {
      modus = 'Hospitalización';
      //
      await Actividades.actualizar(
              Databases.siteground_database_regpace,
              pacientes['updateHospitalizacionQuery'],
              [modus, Pacientes.ID_Paciente],
              Pacientes.ID_Paciente)
          .whenComplete(() => Actividades.registrar(
                  Databases.siteground_database_reghosp,
                  "INSERT INTO pace_hosp (ID_Pace, "
                  "Feca_INI_Hosp, Id_Cama, Dia_Estan, Medi_Trat, Serve_Trat, Serve_Trat_INI, "
                  "Feca_EGE_Hosp, EGE_Motivo) "
                  "VALUES (?,?,?,?,?,?,?,?,?)",
                  [
                    Pacientes.ID_Paciente,
                    Calendarios.today(format: 'yyyy/MM/dd'),
                    'N/A', // No Cama
                    0,
                    '',
                    Valores.servicioTratante,
                    Valores.servicioTratanteInicial,
                    '0000/00/00',
                    Escalas.motivosEgresos[0],
                  ]).whenComplete(() => Actividades.consultarId(
                          Databases.siteground_database_reghosp,
                          "SELECT * FROM pace_hosp WHERE ID_Pace = ? ORDER BY ID_Hosp ASC",
                          Pacientes.ID_Paciente)
                      .then((value) {
                    // ******************************************** *** *
                    // // print("IDDDD HOSP ${value}");
                    Pacientes.ID_Hospitalizacion = value['ID_Hosp'];
                    Pacientes.esHospitalizado = true;
                    Valores.isHospitalizado = true;
                    // // print("IDDDD HOSP ${Pacientes.ID_Hospitalizacion}");
                    // ******************************************** *** *
                    Valores.fechaIngresoHospitalario =
                        Calendarios.today(format: 'yyyy/MM/dd');
                    Valores.fechaIngresoHospitalario = '';
                    Valores.numeroCama = 'N/A';
                    Valores.medicoTratante = '';
                    Valores.motivoEgreso = Escalas.motivosEgresos[0];
                  }).whenComplete(() {
                    // ******************************************** *** *
                    // Registro de Actividades Iniciales de la Hospitalización
                    // ******************************************** *** *
                    Repositorios.registrarRegistro();
                    Situaciones.registrarRegistro();
                    Expedientes.registrarRegistro();
                  })));

      // ******************************************** *** *
      return true;
    } else {
      return false;
    }
  }

  static getImage() {
    Actividades.consultarId(Databases.siteground_database_regpace,
            pacientes['consultImage'], Pacientes.ID_Paciente)
        .then((value) {
      // // print("consultImage $value");
      Pacientes.imagenPaciente = value['Pace_FIAT'];
      Valores.imagenUsuario = value['Pace_FIAT'];
    });
  }

  static void close() {
    Pacientes.ID_Paciente = 0;
    Pacientes.ID_Hospitalizacion = 0;
    Situaciones.ID_Situaciones = 0;
    Expedientes.ID_Expedientes = 0;

    Pacientes.nombreCompleto = "";
    Pacientes.imagenPaciente = "";
// ******* *** *******
    localPath = '';
    localRepositoryPath = '';
    localReportsPath = '';
    // ******* *** *******
    Pacientes.esHospitalizado = false;
    // ******* *** *******
    Pacientes.Paciente = {};
    Pacientes.Vital = {};
    Pacientes.Vitales = [];
    // ******* *** *******
    Heredofamiliares = [];
    //
    Sexualogicos = [];
    Femeninologicos = [];
    Masculinologicos = [];
    Vihs = [];
    //
    Alergicos = [];
    Patologicos = [];
    Quirurgicos = [];
    Transfusionales = [];
    Traumatologicos = [];
    Inmunizaciones = [];
    //
    Licencias = [];
    Balances = [];
    Ventilaciones = [];
    //
    Hospitalizaciones = [];
    //
    Sexuales = [];
    Antirretrovirales = [];
    Embarazos = [];
    // ******* *** *******
    Valores.actividadesDiariasDescripcion = 'Labores Propias del Trabajo';
    Valores.pasatiemposDescripcion = 'No Comentados';
    Valores.horasSuenoDescripcion = Items.horasSueno[2];
    Valores.viajesRecientesDescripcion = '';
    Valores.viajesRecientes = false;
    Valores.problemasFamiliares = false;
    Valores.violenciaInfantil = false;
    Valores.abusoSustancias = false;
    Valores.problemasLaborales = false;
    Valores.estresLaboral = false;
    Valores.hostilidadLaboral = false;
    Valores.abusoLaboral = false;
    Valores.acosoLaboral = false;
    Valores.acosoSexual = false;
    Valores.abusoSexual = false;
    // ******* *** *******
    Constantes.reinit();
    Reportes.close();
  }

  static Future<bool> loadingActivity({required BuildContext context}) async {
    Operadores.loadingActivity(
      context: context,
      tittle: "Iniciando interfaz . . . ",
      message: "Iniciando Interfaz",
    );
    //
    Terminal.printWarning(message: 'Iniciando búsqueda en Valores . . . ');
    try {
      var response = await Valores().load();
      return response;
    } on Exception catch (error) {
      Terminal.printAlert(message: "ERROR - Valores : : $error");
      Operadores.alertActivity(
          message: "ERROR - Valores : : $error",
          context: context,
          tittle: 'Error al Iniciar Valores . . . ');
    }
    return false;
  }
}

class Heredofamiliares {
  static int ID_Heredofamiliares = 0;
  //
  static String selectedDiagnosis = "";
  //

  static Map<String, dynamic> Familiares = {};

  static List<String> actualDiagno = Dicotomicos.dicotomicos();
  static List<String> actualTratamiento = Dicotomicos.dicotomicos();
  static List<String> actualSuspendido = Dicotomicos.dicotomicos();

  static void ultimoRegistro() {
    Actividades.consultarId(
            Databases.siteground_database_regpace,
            Heredofamiliares.familiares['consultLastQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      Heredofamiliares.Familiares =
          value; // Enfermedades de base del paciente, asi como las Hospitalarias.
    });
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(
            Databases.siteground_database_regpace,
            Heredofamiliares.familiares['consultIdQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Heredofamiliares = value;
    });
  }

  static final Map<String, dynamic> familiares = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_ahf;",
    "showColumns": "SHOW columns FROM pace_ahf",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_ahf'",
    "createQuery": """CREATE TABLE pace_ahf (
                  ID_MEFAM int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  ID_Pace int(10) NOT NULL,
                  Pace_MEFAM varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  MEFAM_VFS varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  MEFAM_EdaL varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  AHF_INFO_APato varchar(50) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Esta Tabla se Agregan los Registro de AHF_Pace';
                """,
    "truncateQuery": "TRUNCATE pace_ahf",
    "dropQuery": "DROP TABLE pace_ahf",
    "consultQuery": "SELECT * FROM pace_ahf",
    "consultIdQuery": "SELECT * FROM pace_ahf WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_ahf WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_ahf",
    "consultLastQuery": "SELECT * FROM pace_ahf WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM pace_ahf WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO pace_ahf (ID_Pace, Pace_MEFAM, "
        "MEFAM_VFS, MEFAM_EdaL, AHF_INFO_APato) "
        "VALUES (?, ?, ?, ?, ?)",
    "updateQuery": "UPDATE pace_ahf SET ID_MEFAM = ?, ID_Pace = ?, "
        "Pace_MEFAM = ?, MEFAM_VFS = ?, MEFAM_EdaL = ?, "
        "AHF_INFO_APato = ? "
        "WHERE ID_MEFAM = ?",
    "deleteQuery": "DELETE FROM pace_ahf WHERE ID_pace_ahf = ?",
    "familiaresColumns": [
      "ID_Pace",
    ],
    "familiaresItems": [
      "ID_Pace",
    ],
    "familiaresColums": [
      "ID Paciente",
    ],
    "familiaresStats": [
      "Total_Administradores",
    ],
    "familiaresStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_ahf WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_ahf WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_ahf WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
}

// ********* ******** ******* ********* ***   // ********* ******** ******* ********* ***
class Eticos {
  static int ID_Eticos = 8;
  static var fileAssocieted = "${Pacientes.localRepositoryPath}eticos.json";
  // ********* ******** ******* ********* ***
  static Map<String, dynamic> Eticas = {};
  // ********* ******** ******* ********* ***
  static void consultarRegistro() {
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      Eticos.Eticas = value;

      Eticos.ID_Eticos = value['ID_PACE_EYM'];
      Valores.prejuiciosAtencion =
          Dicotomicos.fromInt(value['Pace_EYM_xise'], toBoolean: true) as bool?;
      Valores.creenciasPaciente = value['Pace_EYM_xise_CREE'];
      Valores.valoresPaciente = value['Pace_EYM_xise_VALO'];
      Valores.costumbresPaciente = value['Pace_EYM_xise_COSU'];

      Valores.redesApoyo =
          Dicotomicos.fromInt(value['Pace_EYM_REDE'], toBoolean: true) as bool?;
      Valores.apoyoMadre =
          Dicotomicos.fromInt(value['Pace_EYM_REDE_Ma'], toBoolean: true)
              as bool?;
      Valores.apoyoPadre =
          Dicotomicos.fromInt(value['Pace_EYM_REDE_Pa'], toBoolean: true)
              as bool?;
      Valores.apoyoHermanos =
          Dicotomicos.fromInt(value['Pace_EYM_REDE_He'], toBoolean: true)
              as bool?;
      Valores.apoyoHijosMayores =
          Dicotomicos.fromInt(value['Pace_EYM_REDE_Hi'], toBoolean: true)
              as bool?;
    }).onError((error, stackTrace) {
      Actividades.consultarId(Databases.siteground_database_regepi,
              Eticos.eticos['consultIdQuery'], Pacientes.ID_Paciente)
          .then((value) {
        if (value.containsKey('Error')) {
          Terminal.printExpected(message: "Eticos consultar registro - $value");
          registrarRegistro();
        } else {
          // Asignación de Valores ********* ******** ******* ********* ***
          Eticos.Eticas = value;

          Eticos.ID_Eticos = value['ID_PACE_EYM'];
          Valores.prejuiciosAtencion =
              Dicotomicos.fromInt(value['Pace_EYM_xise'], toBoolean: true)
                  as bool?;
          Valores.creenciasPaciente = value['Pace_EYM_xise_CREE'];
          Valores.valoresPaciente = value['Pace_EYM_xise_VALO'];
          Valores.costumbresPaciente = value['Pace_EYM_xise_COSU'];

          Valores.redesApoyo =
              Dicotomicos.fromInt(value['Pace_EYM_REDE'], toBoolean: true)
                  as bool?;
          Valores.apoyoMadre =
              Dicotomicos.fromInt(value['Pace_EYM_REDE_Ma'], toBoolean: true)
                  as bool?;
          Valores.apoyoPadre =
              Dicotomicos.fromInt(value['Pace_EYM_REDE_Pa'], toBoolean: true)
                  as bool?;
          Valores.apoyoHermanos =
              Dicotomicos.fromInt(value['Pace_EYM_REDE_He'], toBoolean: true)
                  as bool?;
          Valores.apoyoHijosMayores =
              Dicotomicos.fromInt(value['Pace_EYM_REDE_Hi'], toBoolean: true)
                  as bool?;

          Terminal.printSuccess(
              message: "Valores de Eticos asignado : : : value");
          // Terminal.printData(message: "\t$value");
          Archivos.createJsonFromMap([value], filePath: fileAssocieted);
        }
      });
    });
  }

  static void actualizarRegistro() {
    Actividades.actualizar(
      Databases.siteground_database_regepi,
      Eticos.eticos['updateQuery'],
      [
        Eticos.ID_Eticos,
        Pacientes.ID_Paciente,
        Valores.prejuiciosAtencion,
        Valores.creenciasPaciente,
        Valores.valoresPaciente,
        Valores.costumbresPaciente,
        Valores.redesApoyo,
        Valores.apoyoMadre,
        Valores.apoyoPadre,
        Valores.apoyoHermanos,
        Valores.apoyoHijosMayores,
        Eticos.ID_Eticos,
      ],
      Eticos.ID_Eticos,
    ).then((value) {
      Terminal.printAlert(
          message:
              "RESPUESTA al Actualizar Eticos - $value "); // ${listOfValues.length}
      if (value == "SUCCESS" || value == '"SUCCESS"') {
        Terminal.printOther(
            message: "Actualización $value - Eliminando $fileAssocieted");
        Archivos.deleteFile(filePath: fileAssocieted)
            .then((value) => consultarRegistro());
      }
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR al registrar Eticos - $error");
    });
  }

  static void registrarRegistro() {
    Actividades.registrar(
      Databases.siteground_database_regepi,
      Eticos.eticos['registerQuery'],
      [
        Pacientes.ID_Paciente,
        Valores.prejuiciosAtencion,
        Valores.creenciasPaciente,
        Valores.valoresPaciente,
        Valores.costumbresPaciente,
        Valores.redesApoyo,
        Valores.apoyoMadre,
        Valores.apoyoPadre,
        Valores.apoyoHermanos,
        Valores.apoyoHijosMayores,
      ],
    ).then((value) {
      Terminal.printAlert(
          message:
              "RESPUESTA al registrar Eticos - $value "); // ${listOfValues.length}
      if (value == "SUCCESS" || value == '"SUCCESS"') {
        consultarRegistro();
      }
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR al actualizar Eticos - $error");
    });
  }

// ********* ******** ******* ********* ***
  static final Map<String, dynamic> eticos = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_apnp_eym;",
    "showColumns": "SHOW columns FROM pace_apnp_eym",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_apnp_eym'",
    "createQuery": """CREATE TABLE pace_apnp_eym (
                                            ID_PACE_EYM int(11) PRIMARY_KEY AUTO_INCREMENT NOT NULL,
                                            ID_Pace int(10) NOT NULL,
                                            Pace_EYM_xise tinyint(1) NOT NULL,
                                            Pace_EYM_xise_CREE varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                                            Pace_EYM_xise_VALO varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                                            Pace_EYM_xise_COSU varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                                            Pace_EYM_REDE tinyint(1) NOT NULL,
                                            Pace_EYM_REDE_Ma tinyint(1) NOT NULL,
                                            Pace_EYM_REDE_Pa tinyint(1) NOT NULL,
                                            Pace_EYM_REDE_He tinyint(1) NOT NULL,
                                            Pace_EYM_REDE_Hi tinyint(1) NOT NULL
                                          ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
                                          COMMENT='Tabla para Agregar A.P.N.P.';
            """,
    "truncateQuery": "TRUNCATE pace_apnp_eym",
    "dropQuery": "DROP TABLE pace_apnp_eym",
    "consultQuery": "SELECT * FROM pace_apnp_eym",
    "consultIdQuery": "SELECT * FROM pace_apnp_eym WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_apnp_eym WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_apnp_eym",
    "consultLastQuery": "SELECT * FROM pace_apnp_eym WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM pace_apnp_eym WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO pace_apnp_eym "
        "(ID_Pace, Pace_EYM_xise, Pace_EYM_xise_CREE, "
        "Pace_EYM_xise_VALO, Pace_EYM_xise_COSU, Pace_EYM_REDE, Pace_EYM_REDE_Ma, "
        "Pace_EYM_REDE_Pa, Pace_EYM_REDE_He, Pace_EYM_REDE_Hi) "
        "VALUES (?,?,?,?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_apnp_eym "
        "SET ID_PACE_EYM = ?, ID_Pace = ?, Pace_EYM_xise = ?, Pace_EYM_xise_CREE = ?, "
        "Pace_EYM_xise_VALO = ?, Pace_EYM_xise_COSU = ?, Pace_EYM_REDE = ?, "
        "Pace_EYM_REDE_Ma = ?, "
        "Pace_EYM_REDE_Pa = ?, Pace_EYM_REDE_He = ?, Pace_EYM_REDE_Hi = ? "
        "WHERE ID_PACE_EYM = ?",
    "deleteQuery": "DELETE FROM pace_apnp_eym WHERE ID_pace_apnp_eym = ?",
    "eticosColumns": [
      "ID_Pace",
    ],
    "eticosItems": [
      "ID_Pace",
    ],
    "eticosColums": [
      "ID Paciente",
    ],
    "eticosStats": [
      "Total_Administradores",
    ],
    "eticosStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_apnp_eym WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_apnp_eym WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_apnp_eym  WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
// ********* ******** ******* ********* ***
}

class Viviendas {
  static int ID_Viviendas = 0;
  static var fileAssocieted = "${Pacientes.localRepositoryPath}viviendas.json";
  // ********* ******** ******* ********* ***
  static Map<String, dynamic> Vivienda = {};
  // ********* ******** ******* ********* ***
  static void consultarRegistro() {
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      // Asignación de Valores ********* ******** ******* ********* ***
      Viviendas.Vivienda = value;

      Viviendas.ID_Viviendas = value['ID_PACE_HYS'];

      // *********************************
      Valores.propiedadVivienda = value['Pace_APNP_HYS_Hab_'];
      // ******** ******** ******** ******** ******
      Valores.viviendaElectricidad =
          Dicotomicos.fromInt(value['Pace_APNP_HYS_Ser_ele'], toBoolean: true)
              as bool;
      Valores.viviendaAguaPotable =
          Dicotomicos.fromInt(value['Pace_APNP_HYS_Ser_agu'], toBoolean: true)
              as bool;
      Valores.viviendaAlcantarillado =
          Dicotomicos.fromInt(value['Pace_APNP_HYS_Ser_alc'], toBoolean: true)
              as bool;
      Valores.viviendaDrenaje =
          Dicotomicos.fromInt(value['Pace_APNP_HYS_Ser_dre'], toBoolean: true)
              as bool;
      Valores.viviendaHornoLena =
          Dicotomicos.fromInt(value['Pace_APNP_HYS_Sed_len'], toBoolean: true)
              as bool;
      Valores.viviendaEstufa =
          Dicotomicos.fromInt(value['Pace_APNP_HYS_Sed_est'], toBoolean: true)
              as bool;
      Valores.viviendaTelevision =
          Dicotomicos.fromInt(value['Pace_APNP_HYS_Sed_tel'], toBoolean: true)
              as bool;
// ******** ******** ******** ******** ******
      Valores.cohabitaPadre =
          Dicotomicos.fromInt(value['Pace_APNP_HYS_Tes_pa'], toBoolean: true)
              as bool;
      Valores.cohabitaMadre =
          Dicotomicos.fromInt(value['Pace_APNP_HYS_Tes_ma'], toBoolean: true)
              as bool;
      Valores.cohabitaHijos =
          Dicotomicos.fromInt(value['Pace_APNP_HYS_Tes_ho'], toBoolean: true)
              as bool;
      Valores.cohabitaFamiliares =
          Dicotomicos.fromInt(value['Pace_APNP_HYS_Tes_hi'], toBoolean: true)
              as bool;
      Valores.cohabitaOtros =
          Dicotomicos.fromInt(value['Pace_APNP_HYS_Tes_ot'], toBoolean: true)
              as bool;
      Valores.otrosCohabitantes = value['REGE_Pace_APNP_HYS_Tes_ot'];
      // ******** ******** ******** ******** ******
      Valores.materialPiso = value['Pace_APNP_HYS_Coh_pis'];
      Valores.materialTecho = value['Pace_APNP_HYS_Coh_tec'];
      Valores.materialParedes = value['Pace_APNP_HYS_Coh_pad'];
      // ******** ******** ******** ******** ******
      Valores.viviendaSala =
          Dicotomicos.fromInt(value['Pace_APNP_HYS_Coh_sal'], toBoolean: true)
              as bool;
      Valores.viviendaBano =
          Dicotomicos.fromInt(value['Pace_APNP_HYS_Coh_ban'], toBoolean: true)
              as bool;
      Valores.viviendaComedor =
          Dicotomicos.fromInt(value['Pace_APNP_HYS_Coh_sac'], toBoolean: true)
              as bool;
      Valores.viviendaHabitacionesSeparadas =
          Dicotomicos.fromInt(value['Pace_APNP_HYS_Coh_cua'], toBoolean: true)
              as bool;
      // ******** ******** ******** ******** ******
      // 'No', Pace_APNP_HYS_Coe_
      Valores.viviendaPatioDelantero =
          Dicotomicos.fromInt(value['Pace_APNP_HYS_Coe_pad'], toBoolean: true)
              as bool;
      Valores.viviendaPatioTrasero =
          Dicotomicos.fromInt(value['Pace_APNP_HYS_Coe_pat'], toBoolean: true)
              as bool;
      // *********************************
      Valores.viviendaAnimalesCorral =
          Dicotomicos.fromInt(value['Pace_APNP_HYS_Coe_core'], toBoolean: true)
              as bool;
      Valores.viviendaVacunos =
          Dicotomicos.fromString(value['Pace_APNP_HYS_vac']);
      Valores.viviendaCantidadVacunos =
          value['REGE_Pace_APNP_HYS_vac'].toString();
      Valores.viviendaOvinos =
          Dicotomicos.fromString(value['Pace_APNP_HYS_ovi']);
      Valores.viviendaCantidadOvinos =
          value['REGE_Pace_APNP_HYS_ovi'].toString();
      Valores.viviendaPorcinos =
          Dicotomicos.fromString(value['Pace_APNP_HYS_por']);
      Valores.viviendaCantidadPorcinos =
          value['REGE_Pace_APNP_HYS_por'].toString();
      Valores.viviendaAves = Dicotomicos.fromString(value['Pace_APNP_HYS_avi']);
      Valores.viviendaCantidadAves = value['REGE_Pace_APNP_HYS_avi'].toString();
      // ******** ******** ******** ******** ******
      Valores.viviendaAnimalesCompania =
          Dicotomicos.fromInt(value['Pace_APNP_HYS_Coe_coma'], toBoolean: true)
              as bool;
      Valores.viviendaCaninos =
          Dicotomicos.fromString(value['Pace_APNP_HYS_Coe_can']);
      Valores.viviendaCantidadCaninos =
          value['REGE_Pace_APNP_HYS_Coe_can'].toString();
      Valores.viviendaFelinos =
          Dicotomicos.fromString(value['Pace_APNP_HYS_Coe_fel']);
      Valores.viviendaCantidadFelinos =
          value['REGE_Pace_APNP_HYS_Coe_fel'].toString();
      Valores.viviendaReptiles =
          Dicotomicos.fromString(value['Pace_APNP_HYS_Coe_rep']);
      Valores.viviendaCantidadReptiles =
          value['REGE_Pace_APNP_HYS_Coe_rep'].toString();
      Valores.viviendaParvada =
          Dicotomicos.fromString(value['Pace_APNP_HYS_Coe_avi']);
      Valores.viviendaCantidadParvada =
          value['REGE_Pace_APNP_HYS_Coe_avi'].toString();
      // *********************************
    }).onError((error, stackTrace) {
      Actividades.consultarId(Databases.siteground_database_regepi,
              Viviendas.viviendas['consultIdQuery'], Pacientes.ID_Paciente)
          .then((value) {
        if (value.containsKey('Error')) {
          Terminal.printExpected(
              message: "Viviendas consultar registro - $value");
          registrarRegistro();
        } else {
          // Asignación de Valores ********* ******** ******* ********* ***
          Viviendas.Vivienda = value;

          Viviendas.ID_Viviendas = value['ID_PACE_HYS'];

          // *********************************
          Valores.propiedadVivienda = value['Pace_APNP_HYS_Hab_'];
          // ******** ******** ******** ******** ******
          Valores.viviendaElectricidad = Dicotomicos.fromInt(
              value['Pace_APNP_HYS_Ser_ele'],
              toBoolean: true) as bool;
          Valores.viviendaAguaPotable = Dicotomicos.fromInt(
              value['Pace_APNP_HYS_Ser_agu'],
              toBoolean: true) as bool;
          Valores.viviendaAlcantarillado = Dicotomicos.fromInt(
              value['Pace_APNP_HYS_Ser_alc'],
              toBoolean: true) as bool;
          Valores.viviendaDrenaje = Dicotomicos.fromInt(
              value['Pace_APNP_HYS_Ser_dre'],
              toBoolean: true) as bool;
          Valores.viviendaHornoLena = Dicotomicos.fromInt(
              value['Pace_APNP_HYS_Sed_len'],
              toBoolean: true) as bool;
          Valores.viviendaEstufa = Dicotomicos.fromInt(
              value['Pace_APNP_HYS_Sed_est'],
              toBoolean: true) as bool;
          Valores.viviendaTelevision = Dicotomicos.fromInt(
              value['Pace_APNP_HYS_Sed_tel'],
              toBoolean: true) as bool;
// ******** ******** ******** ******** ******
          Valores.cohabitaPadre = Dicotomicos.fromInt(
              value['Pace_APNP_HYS_Tes_pa'],
              toBoolean: true) as bool;
          Valores.cohabitaMadre = Dicotomicos.fromInt(
              value['Pace_APNP_HYS_Tes_ma'],
              toBoolean: true) as bool;
          Valores.cohabitaHijos = Dicotomicos.fromInt(
              value['Pace_APNP_HYS_Tes_ho'],
              toBoolean: true) as bool;
          Valores.cohabitaFamiliares = Dicotomicos.fromInt(
              value['Pace_APNP_HYS_Tes_hi'],
              toBoolean: true) as bool;
          Valores.cohabitaOtros = Dicotomicos.fromInt(
              value['Pace_APNP_HYS_Tes_ot'],
              toBoolean: true) as bool;
          Valores.otrosCohabitantes = value['REGE_Pace_APNP_HYS_Tes_ot'];
          // ******** ******** ******** ******** ******
          Valores.materialPiso = value['Pace_APNP_HYS_Coh_pis'];
          Valores.materialTecho = value['Pace_APNP_HYS_Coh_tec'];
          Valores.materialParedes = value['Pace_APNP_HYS_Coh_pad'];
          // ******** ******** ******** ******** ******
          Valores.viviendaSala = Dicotomicos.fromInt(
              value['Pace_APNP_HYS_Coh_sal'],
              toBoolean: true) as bool;
          Valores.viviendaBano = Dicotomicos.fromInt(
              value['Pace_APNP_HYS_Coh_ban'],
              toBoolean: true) as bool;
          Valores.viviendaComedor = Dicotomicos.fromInt(
              value['Pace_APNP_HYS_Coh_sac'],
              toBoolean: true) as bool;
          Valores.viviendaHabitacionesSeparadas = Dicotomicos.fromInt(
              value['Pace_APNP_HYS_Coh_cua'],
              toBoolean: true) as bool;
          // ******** ******** ******** ******** ******
          // 'No', Pace_APNP_HYS_Coe_
          Valores.viviendaPatioDelantero = Dicotomicos.fromInt(
              value['Pace_APNP_HYS_Coe_pad'],
              toBoolean: true) as bool;
          Valores.viviendaPatioTrasero = Dicotomicos.fromInt(
              value['Pace_APNP_HYS_Coe_pat'],
              toBoolean: true) as bool;
          // *********************************
          Valores.viviendaAnimalesCorral = Dicotomicos.fromInt(
              value['Pace_APNP_HYS_Coe_core'],
              toBoolean: true) as bool;
          Valores.viviendaVacunos =
              Dicotomicos.fromString(value['Pace_APNP_HYS_vac']);
          Valores.viviendaCantidadVacunos =
              value['REGE_Pace_APNP_HYS_vac'].toString();
          Valores.viviendaOvinos =
              Dicotomicos.fromString(value['Pace_APNP_HYS_ovi']);
          Valores.viviendaCantidadOvinos =
              value['REGE_Pace_APNP_HYS_ovi'].toString();
          Valores.viviendaPorcinos =
              Dicotomicos.fromString(value['Pace_APNP_HYS_por']);
          Valores.viviendaCantidadPorcinos =
              value['REGE_Pace_APNP_HYS_por'].toString();
          Valores.viviendaAves =
              Dicotomicos.fromString(value['Pace_APNP_HYS_avi']);
          Valores.viviendaCantidadAves =
              value['REGE_Pace_APNP_HYS_avi'].toString();
          // ******** ******** ******** ******** ******
          Valores.viviendaAnimalesCompania = Dicotomicos.fromInt(
              value['Pace_APNP_HYS_Coe_coma'],
              toBoolean: true) as bool;
          Valores.viviendaCaninos =
              Dicotomicos.fromString(value['Pace_APNP_HYS_Coe_can']);
          Valores.viviendaCantidadCaninos =
              value['REGE_Pace_APNP_HYS_Coe_can'].toString();
          Valores.viviendaFelinos =
              Dicotomicos.fromString(value['Pace_APNP_HYS_Coe_fel']);
          Valores.viviendaCantidadFelinos =
              value['REGE_Pace_APNP_HYS_Coe_fel'].toString();
          Valores.viviendaReptiles =
              Dicotomicos.fromString(value['Pace_APNP_HYS_Coe_rep']);
          Valores.viviendaCantidadReptiles =
              value['REGE_Pace_APNP_HYS_Coe_rep'].toString();
          Valores.viviendaParvada =
              Dicotomicos.fromString(value['Pace_APNP_HYS_Coe_avi']);
          Valores.viviendaCantidadParvada =
              value['REGE_Pace_APNP_HYS_Coe_avi'].toString();
          // *********************************

          Terminal.printSuccess(
              message: "Valores de Viviendas asignado : : : value");
          // Terminal.printData(message: "\t$value");
          Archivos.createJsonFromMap([value], filePath: fileAssocieted);
        }
      });
    });
  }

  static void actualizarRegistro() {
    Actividades.actualizar(
      Databases.siteground_database_regepi,
      Viviendas.viviendas['updateQuery'],
      [
        Viviendas.ID_Viviendas,
        Pacientes.ID_Paciente,
        Calendarios.today(format: 'yyyy/MM/dd'),
        // *********************************
        Valores.propiedadVivienda,
        // ******** ******** ******** ******** ******
        Valores.viviendaElectricidad,
        Valores.viviendaAguaPotable,
        Valores.viviendaAlcantarillado,
        Valores.viviendaDrenaje,
        Valores.viviendaHornoLena,
        Valores.viviendaEstufa,
        Valores.viviendaTelevision,
// ******** ******** ******** ******** ******
        Valores.cohabitaPadre,
        Valores.cohabitaMadre,
        Valores.cohabitaHijos,
        Valores.cohabitaFamiliares,
        Valores.cohabitaOtros,
        Valores.otrosCohabitantes,
        // ******** ******** ******** ******** ******
        Valores.materialPiso,
        Valores.materialTecho,
        Valores.materialParedes,
        // ******** ******** ******** ******** ******
        Valores.viviendaSala,
        Valores.viviendaBano,
        Valores.viviendaComedor,
        Valores.viviendaHabitacionesSeparadas,
        // ******** ******** ******** ******** ******
        'No',
        Valores.viviendaPatioDelantero,
        Valores.viviendaPatioTrasero,
        // *********************************
        Valores.viviendaAnimalesCorral,
        Valores.viviendaVacunos,
        Valores.viviendaCantidadVacunos,
        Valores.viviendaOvinos,
        Valores.viviendaCantidadOvinos,
        Valores.viviendaPorcinos,
        Valores.viviendaCantidadPorcinos,
        Valores.viviendaAves,
        Valores.viviendaCantidadAves,
        // ******** ******** ******** ******** ******
        Valores.viviendaAnimalesCompania,
        Valores.viviendaCaninos,
        Valores.viviendaCantidadCaninos,
        Valores.viviendaFelinos,
        Valores.viviendaCantidadFelinos,
        Valores.viviendaReptiles,
        Valores.viviendaCantidadReptiles,
        Valores.viviendaParvada,
        Valores.viviendaCantidadParvada,
        // *********************************
        Viviendas.ID_Viviendas,
      ],
      Viviendas.ID_Viviendas,
    ).then((value) {
      Terminal.printAlert(
          message:
              "RESPUESTA al Actualizar Viviendas - $value "); // ${listOfValues.length}
      if (value == "SUCCESS" || value == '"SUCCESS"') {
        Terminal.printOther(
            message: "Actualización $value - Eliminando $fileAssocieted");
        Archivos.deleteFile(filePath: fileAssocieted)
            .then((value) => consultarRegistro());
      }
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR al actualizar Viviendas - $error");
    });
  }

  static void registrarRegistro() {
    List listOfValues = [
      Pacientes.ID_Paciente,
      Calendarios.today(format: 'yyyy/MM/dd'),
      // *********************************
      Valores.propiedadVivienda,
      // ******** ******** ******** ******** ******
      Valores.viviendaElectricidad,
      Valores.viviendaAguaPotable,
      Valores.viviendaAlcantarillado,
      Valores.viviendaDrenaje,
      Valores.viviendaHornoLena,
      Valores.viviendaEstufa,
      Valores.viviendaTelevision,
// ******** ******** ******** ******** ******
      Valores.cohabitaPadre,
      Valores.cohabitaMadre,
      Valores.cohabitaHijos,
      Valores.cohabitaFamiliares,
      Valores.cohabitaOtros,
      Valores.otrosCohabitantes,
      // ******** ******** ******** ******** ******
      Valores.materialPiso,
      Valores.materialTecho,
      Valores.materialParedes,
      // ******** ******** ******** ******** ******
      Valores.viviendaSala,
      Valores.viviendaBano,
      Valores.viviendaComedor,
      Valores.viviendaHabitacionesSeparadas,
      // ******** ******** ******** ******** ******
      'No',
      Valores.viviendaPatioDelantero,
      Valores.viviendaPatioTrasero,
      // *********************************
      Valores.viviendaAnimalesCorral,
      Valores.viviendaVacunos,
      Valores.viviendaCantidadVacunos,
      Valores.viviendaOvinos,
      Valores.viviendaCantidadOvinos,
      Valores.viviendaPorcinos,
      Valores.viviendaCantidadPorcinos,
      Valores.viviendaAves,
      Valores.viviendaCantidadAves,
      // ******** ******** ******** ******** ******
      Valores.viviendaAnimalesCompania,
      Valores.viviendaCaninos,
      Valores.viviendaCantidadCaninos,
      Valores.viviendaFelinos,
      Valores.viviendaCantidadFelinos,
      Valores.viviendaReptiles,
      Valores.viviendaCantidadReptiles,
      Valores.viviendaParvada,
      Valores.viviendaCantidadParvada,
      // *********************************
    ];
    Actividades.registrar(
      Databases.siteground_database_regepi,
      Viviendas.viviendas['registerQuery'],
      listOfValues,
    ).then((value) {
      Terminal.printAlert(
          message:
              "RESPUESTA al registrar Viviendas - $value ${listOfValues.length}");
      if (value == "SUCCESS" || value == '"SUCCESS"') {
        consultarRegistro();
      }
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR al registrar Viviendas - $error");
    });
  }

// ********* ******** ******* ********* ***
  static final Map<String, dynamic> viviendas = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_apnp_hys;",
    "showColumns": "SHOW columns FROM pace_apnp_hys",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_apnp_hys'",
    "createQuery": """
    CREATE TABLE pace_apnp_hys (
                          ID_PACE_HYS int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                          ID_Pace int(11) NOT NULL,
                          Pace_APNP_HYS_Feca date NOT NULL,
                          Pace_APNP_HYS_Hab_ varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          Pace_APNP_HYS_Ser_ele tinyint(1) NOT NULL,
                          Pace_APNP_HYS_Ser_agu tinyint(1) NOT NULL,
                          Pace_APNP_HYS_Ser_alc tinyint(1) NOT NULL,
                          Pace_APNP_HYS_Ser_dre tinyint(1) NOT NULL,
                          Pace_APNP_HYS_Sed_len tinyint(1) NOT NULL,
                          Pace_APNP_HYS_Sed_est tinyint(1) NOT NULL,
                          Pace_APNP_HYS_Sed_tel tinyint(1) NOT NULL,
                          Pace_APNP_HYS_Tes_pa tinyint(1) NOT NULL,
                          Pace_APNP_HYS_Tes_ma tinyint(1) NOT NULL,
                          Pace_APNP_HYS_Tes_ho tinyint(1) NOT NULL,
                          Pace_APNP_HYS_Tes_hi tinyint(1) NOT NULL,
                          Pace_APNP_HYS_Tes_ot tinyint(1) NOT NULL,
                          REGE_Pace_APNP_HYS_Tes_ot varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          Pace_APNP_HYS_Coh_pis varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                          Pace_APNP_HYS_Coh_tec varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                          Pace_APNP_HYS_Coh_pad varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                          Pace_APNP_HYS_Coh_sal tinyint(1) NOT NULL,
                          Pace_APNP_HYS_Coh_ban tinyint(1) NOT NULL,
                          Pace_APNP_HYS_Coh_sac tinyint(1) NOT NULL,
                          Pace_APNP_HYS_Coh_cua tinyint(1) NOT NULL,
                          Pace_APNP_HYS_Coe_ varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          Pace_APNP_HYS_Coe_pad tinyint(1) NOT NULL,
                          Pace_APNP_HYS_Coe_pat tinyint(1) NOT NULL,
                          Pace_APNP_HYS_Coe_core tinyint(1) NOT NULL,
                          Pace_APNP_HYS_vac varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          REGE_Pace_APNP_HYS_vac int(11) NOT NULL,
                          Pace_APNP_HYS_ovi varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          REGE_Pace_APNP_HYS_ovi int(11) NOT NULL,
                          Pace_APNP_HYS_por varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          REGE_Pace_APNP_HYS_por int(11) NOT NULL,
                          Pace_APNP_HYS_avi varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          REGE_Pace_APNP_HYS_avi int(11) NOT NULL,
                          Pace_APNP_HYS_Coe_coma tinyint(1) NOT NULL,
                          Pace_APNP_HYS_Coe_can varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          REGE_Pace_APNP_HYS_Coe_can int(11) NOT NULL,
                          Pace_APNP_HYS_Coe_rep varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          REGE_Pace_APNP_HYS_Coe_rep int(11) NOT NULL,
                          Pace_APNP_HYS_Coe_fel varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          REGE_Pace_APNP_HYS_Coe_fel int(11) NOT NULL,
                          Pace_APNP_HYS_Coe_avi varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          REGE_Pace_APNP_HYS_Coe_avi int(11) NOT NULL
                        ) ENGINE=InnoDB AUTO_INCREMENT=4
                        DEFAULT CHARSET=utf8
                        COLLATE=utf8_unicode_ci
                        COMMENT='Esta Tabla es para Agregar Datos de Vivienda';
            """,
    "truncateQuery": "TRUNCATE pace_apnp_hys",
    "dropQuery": "DROP TABLE pace_apnp_hys",
    "consultQuery": "SELECT * FROM pace_apnp_hys",
    "consultIdQuery": "SELECT * FROM pace_apnp_hys WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_apnp_hys WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_apnp_hys",
    "consultLastQuery": "SELECT * FROM pace_apnp_hys WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM pace_apnp_hys WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO pace_apnp_hys (ID_Pace, Pace_APNP_HYS_Feca, "
        "Pace_APNP_HYS_Hab_, Pace_APNP_HYS_Ser_ele, Pace_APNP_HYS_Ser_agu, "
        "Pace_APNP_HYS_Ser_alc, Pace_APNP_HYS_Ser_dre, Pace_APNP_HYS_Sed_len, "
        "Pace_APNP_HYS_Sed_est, Pace_APNP_HYS_Sed_tel, Pace_APNP_HYS_Tes_pa, "
        "Pace_APNP_HYS_Tes_ma, Pace_APNP_HYS_Tes_ho, Pace_APNP_HYS_Tes_hi, "
        "Pace_APNP_HYS_Tes_ot, REGE_Pace_APNP_HYS_Tes_ot, Pace_APNP_HYS_Coh_pis, "
        "Pace_APNP_HYS_Coh_tec, Pace_APNP_HYS_Coh_pad, Pace_APNP_HYS_Coh_sal, "
        "Pace_APNP_HYS_Coh_ban, Pace_APNP_HYS_Coh_sac, Pace_APNP_HYS_Coh_cua, "
        "Pace_APNP_HYS_Coe_, Pace_APNP_HYS_Coe_pad, Pace_APNP_HYS_Coe_pat, "
        "Pace_APNP_HYS_Coe_core, Pace_APNP_HYS_vac, REGE_Pace_APNP_HYS_vac, "
        "Pace_APNP_HYS_ovi, REGE_Pace_APNP_HYS_ovi, Pace_APNP_HYS_por, "
        "REGE_Pace_APNP_HYS_por, Pace_APNP_HYS_avi, REGE_Pace_APNP_HYS_avi, "
        "Pace_APNP_HYS_Coe_coma, Pace_APNP_HYS_Coe_can, REGE_Pace_APNP_HYS_Coe_can, "
        "Pace_APNP_HYS_Coe_rep, REGE_Pace_APNP_HYS_Coe_rep, Pace_APNP_HYS_Coe_fel, "
        "REGE_Pace_APNP_HYS_Coe_fel, Pace_APNP_HYS_Coe_avi, REGE_Pace_APNP_HYS_Coe_avi) "
        "VALUES (?,?,?,?,?,?,?,?,?,?,"
        "?,?,?,?,?,?,?,?,?,?,"
        "?,?,?,?,?,?,?,?,?,?,"
        "?,?,?,?,?,?,?,?,?,?,"
        "?,?,?,?)", // 44 :
    "updateQuery": "UPDATE pace_apnp_hys "
        "SET ID_PACE_HYS = ?, ID_Pace = ?, Pace_APNP_HYS_Feca = ?, "
        "Pace_APNP_HYS_Hab_ = ?, "
        "Pace_APNP_HYS_Ser_ele = ?, Pace_APNP_HYS_Ser_agu = ?, "
        "Pace_APNP_HYS_Ser_alc = ?, Pace_APNP_HYS_Ser_dre = ?, "
        "Pace_APNP_HYS_Sed_len = ?, Pace_APNP_HYS_Sed_est = ?, "
        "Pace_APNP_HYS_Sed_tel = ?, "
        "Pace_APNP_HYS_Tes_pa = ?, Pace_APNP_HYS_Tes_ma = ?, "
        "Pace_APNP_HYS_Tes_ho = ?, Pace_APNP_HYS_Tes_hi = ?, "
        "Pace_APNP_HYS_Tes_ot = ?, REGE_Pace_APNP_HYS_Tes_ot = ?, "
        "Pace_APNP_HYS_Coh_pis = ?, Pace_APNP_HYS_Coh_tec = ?, "
        "Pace_APNP_HYS_Coh_pad = ?, "
        "Pace_APNP_HYS_Coh_sal = ?, Pace_APNP_HYS_Coh_ban = ?, "
        "Pace_APNP_HYS_Coh_sac = ?, Pace_APNP_HYS_Coh_cua = ?, "
        "Pace_APNP_HYS_Coe_ = ?, "
        "Pace_APNP_HYS_Coe_pad = ?, Pace_APNP_HYS_Coe_pat = ?, "
        "Pace_APNP_HYS_Coe_core = ?, "
        "Pace_APNP_HYS_vac = ?, REGE_Pace_APNP_HYS_vac = ?, "
        "Pace_APNP_HYS_ovi = ?, REGE_Pace_APNP_HYS_ovi = ?, "
        "Pace_APNP_HYS_por = ?, REGE_Pace_APNP_HYS_por = ?, "
        "Pace_APNP_HYS_avi = ?, REGE_Pace_APNP_HYS_avi = ?, "
        "Pace_APNP_HYS_Coe_coma = ?, "
        "Pace_APNP_HYS_Coe_can = ?, REGE_Pace_APNP_HYS_Coe_can = ?, "
        "Pace_APNP_HYS_Coe_rep = ?, REGE_Pace_APNP_HYS_Coe_rep = ?, "
        "Pace_APNP_HYS_Coe_fel = ?, REGE_Pace_APNP_HYS_Coe_fel = ?, "
        "Pace_APNP_HYS_Coe_avi = ?, REGE_Pace_APNP_HYS_Coe_avi = ? "
        "WHERE ID_PACE_HYS = ?", // 45
    "deleteQuery": "DELETE FROM pace_apnp_hys WHERE ID_pace_apnp_hys = ?",
    "viviendasColumns": [
      "ID_Pace",
    ],
    "viviendasItems": [
      "ID_Pace",
    ],
    "viviendasColums": [
      "ID Paciente",
    ],
    "viviendasStats": [
      "Total_Administradores",
    ],
    "viviendasStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_apnp_hys WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_apnp_hys WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_apnp_hys  WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
// ********* ******** ******* ********* ***
}

class Alimenticios {
  static int ID_Alimenticios = 0;
  static var fileAssocieted =
      "${Pacientes.localRepositoryPath}alimenticios.json";
  // ********* ******** ******* ********* ***
  static Map<String, dynamic> Alimenticio = {};
  // ********* ******** ******* ********* ***
  static void consultarRegistro() {
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      // Asignación de Valores ********* ******** ******* ********* ***
      Alimenticios.Alimenticio = value;
      Alimenticios.ID_Alimenticios = value['ID_PACE_APNP_ALI'];

      Valores.alimentacionDiaria =
          Dicotomicos.fromInt(value['Pace_APNP_ALI_ali_SINO'], toBoolean: true)
              as bool?;
      Valores.alimentacionDiariaDescripcion = value['Pace_APNP_ALI_ali'];
      Valores.dietaAsignada =
          Dicotomicos.fromInt(value['Pace_APNP_ALI_die_SINO'], toBoolean: true)
              as bool?;
      Valores.dietaAsignadaDescripcion = value['Pace_APNP_ALI_die'];
      Valores.variacionAlimentacion =
          Dicotomicos.fromInt(value['Pace_APNP_ALI_var_SINO'], toBoolean: true)
              as bool?;
      Valores.variacionAlimentacionDescripcion = value['Pace_APNP_ALI_var'];
      Valores.problemasMasticacion =
          Dicotomicos.fromInt(value['Pace_APNP_ALI_mas_SINO'], toBoolean: true)
              as bool?;
      Valores.problemasMasticacionDescripcion = value['Pace_APNP_ALI_mas'];
      Valores.intoleranciaAlimentaria =
          Dicotomicos.fromInt(value['Pace_APNP_ALI_int_SINO'], toBoolean: true)
              as bool?;
      Valores.intoleranciaAlimentariaDescripcion = value['Pace_APNP_ALI_int'];
      Valores.alteracionesPeso =
          Dicotomicos.fromInt(value['Pace_APNP_ALI_pes_SINO'], toBoolean: true)
              as bool?;
      Valores.alteracionesPesoDescripcion = value['Pace_APNP_ALI_pes'];
      // *********************************
    }).onError((error, stackTrace) {
      Actividades.consultarId(
              Databases.siteground_database_regepi,
              Alimenticios.alimenticios['consultIdQuery'],
              Pacientes.ID_Paciente)
          .then((value) {
        if (value.containsKey('Error')) {
          Terminal.printExpected(
              message: "Alimenticios consultar registro - $value");
          registrarRegistro();
        } else {
          // Asignación de Valores ********* ******** ******* ********* ***
          Alimenticios.Alimenticio = value;
          Alimenticios.ID_Alimenticios = value['ID_PACE_APNP_ALI'];

          Valores.alimentacionDiaria = Dicotomicos.fromInt(
              value['Pace_APNP_ALI_ali_SINO'],
              toBoolean: true) as bool?;
          Valores.alimentacionDiariaDescripcion = value['Pace_APNP_ALI_ali'];
          Valores.dietaAsignada = Dicotomicos.fromInt(
              value['Pace_APNP_ALI_die_SINO'],
              toBoolean: true) as bool?;
          Valores.dietaAsignadaDescripcion = value['Pace_APNP_ALI_die'];
          Valores.variacionAlimentacion = Dicotomicos.fromInt(
              value['Pace_APNP_ALI_var_SINO'],
              toBoolean: true) as bool?;
          Valores.variacionAlimentacionDescripcion = value['Pace_APNP_ALI_var'];
          Valores.problemasMasticacion = Dicotomicos.fromInt(
              value['Pace_APNP_ALI_mas_SINO'],
              toBoolean: true) as bool?;
          Valores.problemasMasticacionDescripcion = value['Pace_APNP_ALI_mas'];
          Valores.intoleranciaAlimentaria = Dicotomicos.fromInt(
              value['Pace_APNP_ALI_int_SINO'],
              toBoolean: true) as bool?;
          Valores.intoleranciaAlimentariaDescripcion =
              value['Pace_APNP_ALI_int'];
          Valores.alteracionesPeso = Dicotomicos.fromInt(
              value['Pace_APNP_ALI_pes_SINO'],
              toBoolean: true) as bool?;
          Valores.alteracionesPesoDescripcion = value['Pace_APNP_ALI_pes'];

          Terminal.printSuccess(
              message: "Valores de Alimenticios asignado : : : value");
          // Terminal.printData(message: "\t$value");
          Archivos.createJsonFromMap([value],
              filePath: "${Pacientes.localRepositoryPath}alimenticios.json");
        }
      });
    });
  }

  static void actualizarRegistro() {
    Actividades.actualizar(
      Databases.siteground_database_regepi,
      Alimenticios.alimenticios['updateQuery'],
      [
        Alimenticios.ID_Alimenticios,
        // ********* ******** ******* ********* ***
        Pacientes.ID_Paciente,
        Valores.alimentacionDiaria,
        Valores.alimentacionDiariaDescripcion,
        Valores.dietaAsignada,
        Valores.dietaAsignadaDescripcion,
        Valores.variacionAlimentacion,
        Valores.variacionAlimentacionDescripcion,
        Valores.problemasMasticacion,
        Valores.problemasMasticacionDescripcion,
        Valores.intoleranciaAlimentaria,
        Valores.intoleranciaAlimentariaDescripcion,
        Valores.alteracionesPeso,
        Valores.alteracionesPesoDescripcion,
        // ********* ******** ******* ********* ***
        Alimenticios.ID_Alimenticios,
      ],
      Alimenticios.ID_Alimenticios,
    ).then((value) {
      Terminal.printAlert(
          message:
              "RESPUESTA al Actualizar Alimenticios - $value "); // ${listOfValues.length}
      if (value == "SUCCESS" || value == '"SUCCESS"') {
        Terminal.printOther(
            message: "Actualización $value - Eliminando $fileAssocieted");
        Archivos.deleteFile(filePath: fileAssocieted)
            .then((value) => consultarRegistro());
      }
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR al actualizar Alimenticios - $error");
    });
  }

  static void registrarRegistro() {
    Actividades.registrar(
      Databases.siteground_database_regepi,
      Alimenticios.alimenticios['registerQuery'],
      [
        Pacientes.ID_Paciente,
        // ********* ******** ******* ********* ***
        Valores.alimentacionDiaria,
        Valores.alimentacionDiariaDescripcion,
        Valores.dietaAsignada,
        Valores.dietaAsignadaDescripcion,
        Valores.variacionAlimentacion,
        Valores.variacionAlimentacionDescripcion,
        Valores.problemasMasticacion,
        Valores.problemasMasticacionDescripcion,
        Valores.intoleranciaAlimentaria,
        Valores.intoleranciaAlimentariaDescripcion,
        Valores.alteracionesPeso,
        Valores.alteracionesPesoDescripcion,
        // ********* ******** ******* ********* ***
      ],
    ).then((value) {
      Terminal.printAlert(
          message:
              "RESPUESTA al registrar Alimenticios - $value "); // ${listOfValues.length}
      if (value == "SUCCESS" || value == '"SUCCESS"') {
        consultarRegistro();
      }
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR al registrar Alimenticios - $error");
    });
  }

// ********* ******** ******* ********* ***
  static final Map<String, dynamic> alimenticios = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_apnp_ali;",
    "showColumns": "SHOW columns FROM pace_apnp_ali",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_apnp_ali'",
    "createQuery": """
    CREATE TABLE pace_apnp_ali (
                          ID_PACE_APNP_ALI int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL ,
                          ID_Pace int(11) NOT NULL,
                          Pace_APNP_ALI_ali_SINO tinyint(1) NOT NULL,
                          Pace_APNP_ALI_ali varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          Pace_APNP_ALI_die_SINO tinyint(1) NOT NULL,
                          Pace_APNP_ALI_die varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          Pace_APNP_ALI_var_SINO tinyint(1) NOT NULL,
                          Pace_APNP_ALI_var varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          Pace_APNP_ALI_mas_SINO tinyint(1) NOT NULL,
                          Pace_APNP_ALI_mas varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          Pace_APNP_ALI_int_SINO tinyint(1) NOT NULL,
                          Pace_APNP_ALI_int varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          Pace_APNP_ALI_pes_SINO tinyint(1) NOT NULL,
                          Pace_APNP_ALI_pes varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                        ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Esta Tabla es para Agregar Datos de Habitos Alimentarios';
            """,
    "truncateQuery": "TRUNCATE pace_apnp_ali",
    "dropQuery": "DROP TABLE pace_apnp_ali",
    "consultQuery": "SELECT * FROM pace_apnp_ali",
    "consultIdQuery": "SELECT * FROM pace_apnp_ali WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_apnp_ali WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_apnp_ali",
    "consultLastQuery": "SELECT * FROM pace_apnp_ali WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM pace_apnp_ali WHERE Pace_APP_DEG LIKE '%",
    "registerQuery":
        "INSERT INTO pace_apnp_ali (ID_Pace, Pace_APNP_ALI_ali_SINO, "
            "Pace_APNP_ALI_ali, Pace_APNP_ALI_die_SINO, Pace_APNP_ALI_die, "
            "Pace_APNP_ALI_var_SINO, Pace_APNP_ALI_var, Pace_APNP_ALI_mas_SINO, "
            "Pace_APNP_ALI_mas, Pace_APNP_ALI_int_SINO, Pace_APNP_ALI_int, "
            "Pace_APNP_ALI_pes_SINO, Pace_APNP_ALI_pes) "
            "VALUES (?,?,?,?,?,?,?,?,?,?,"
            "?,?,?)",
    "updateQuery": "UPDATE pace_apnp_ali "
        "SET ID_PACE_APNP_ALI = ?, ID_Pace = ?,Pace_APNP_ALI_ali_SINO = ?,"
        "Pace_APNP_ALI_ali = ?,Pace_APNP_ALI_die_SINO = ?,Pace_APNP_ALI_die = ?,"
        "Pace_APNP_ALI_var_SINO = ?,Pace_APNP_ALI_var = ?,Pace_APNP_ALI_mas_SINO = ?,"
        "Pace_APNP_ALI_mas = ?,Pace_APNP_ALI_int_SINO = ?,Pace_APNP_ALI_int = ?,"
        "Pace_APNP_ALI_pes_SINO = ?,Pace_APNP_ALI_pes = ? "
        "WHERE ID_PACE_APNP_ALI = ?",
    "deleteQuery": "DELETE FROM pace_apnp_ali WHERE ID_pace_apnp_ali = ?",
    "alimenticiosColumns": [
      "ID_Pace",
    ],
    "alimenticiosItems": [
      "ID_Pace",
    ],
    "alimenticiosColums": [
      "ID Paciente",
    ],
    "alimenticiosStats": [
      "Total_Administradores",
    ],
    "alimenticiosStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_apnp_ali WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_apnp_ali WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_apnp_ali  WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
// ********* ******** ******* ********* ***
}

class Diarios {
  static int ID_Diarios = 0;
  static var fileAssocieted = "${Pacientes.localRepositoryPath}diarios.json";
  // ********* ******** ******* ********* ***
  static Map<String, dynamic> Diario = {};
  // ********* ******** ******* ********* ***
  static void consultarRegistro() {
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      // Asignación de Valores ********* ******** ******* ********* ***
      Diarios.Diario = value;

      Diarios.ID_Diarios = value['ID_PACE_HAD'];

      Valores.actividadesDiariasDescripcion = value['Pace_APNP_HAD_pas'];
      Valores.pasatiemposDescripcion = value['Pace_APNP_HAD_dia'];
      Valores.horasSuenoDescripcion = value['Pace_APNP_HAD_sue'];
      Valores.viajesRecientes =
          Dicotomicos.fromInt(value['Pace_APNP_HAD_via_SINO'], toBoolean: true)
              as bool?;
      Valores.viajesRecientesDescripcion = value['Pace_APNP_HAD_via'];
      Valores.problemasFamiliares =
          Dicotomicos.fromInt(value['Pace_APNP_HAD_pof_SINO'], toBoolean: true)
              as bool?;
      Valores.violenciaInfantil =
          Dicotomicos.fromInt(value['Pace_APNP_HAD_pol_vif'], toBoolean: true)
              as bool?;
      Valores.abusoSustancias =
          Dicotomicos.fromInt(value['Pace_APNP_HAD_pol_vit'], toBoolean: true)
              as bool?;
      Valores.problemasLaborales =
          Dicotomicos.fromInt(value['Pace_APNP_HAD_pol'], toBoolean: true)
              as bool?;
      Valores.estresLaboral =
          Dicotomicos.fromInt(value['Pace_APNP_HAD_pol_est'], toBoolean: true)
              as bool?;
      Valores.hostilidadLaboral =
          Dicotomicos.fromInt(value['Pace_APNP_HAD_pol_hos'], toBoolean: true)
              as bool?;
      Valores.abusoSexual =
          Dicotomicos.fromInt(value['Pace_APNP_HAD_pol_abu'], toBoolean: true)
              as bool?;
      Valores.acosoSexual =
          Dicotomicos.fromInt(value['Pace_APNP_HAD_pol_aco'], toBoolean: true)
              as bool?;
      // *********************************
    }).onError((error, stackTrace) {
      Actividades.consultarId(Databases.siteground_database_regepi,
              Diarios.diarios['consultIdQuery'], Pacientes.ID_Paciente)
          .then((value) {
        if (value.containsKey('Error')) {
          Terminal.printExpected(
              message: "Diarios consultar registro - $value");
          registrarRegistro();
        } else {
          // Asignación de Valores ********* ******** ******* ********* ***
          Diarios.Diario = value;

          Diarios.ID_Diarios = value['ID_PACE_HAD'];

          Valores.actividadesDiariasDescripcion = value['Pace_APNP_HAD_pas'];
          Valores.pasatiemposDescripcion = value['Pace_APNP_HAD_dia'];
          Valores.horasSuenoDescripcion = value['Pace_APNP_HAD_sue'];
          Valores.viajesRecientes = Dicotomicos.fromInt(
              value['Pace_APNP_HAD_via_SINO'],
              toBoolean: true) as bool?;
          Valores.viajesRecientesDescripcion = value['Pace_APNP_HAD_via'];
          Valores.problemasFamiliares = Dicotomicos.fromInt(
              value['Pace_APNP_HAD_pof_SINO'],
              toBoolean: true) as bool?;
          Valores.violenciaInfantil = Dicotomicos.fromInt(
              value['Pace_APNP_HAD_pol_vif'],
              toBoolean: true) as bool?;
          Valores.abusoSustancias = Dicotomicos.fromInt(
              value['Pace_APNP_HAD_pol_vit'],
              toBoolean: true) as bool?;
          Valores.problemasLaborales =
              Dicotomicos.fromInt(value['Pace_APNP_HAD_pol'], toBoolean: true)
                  as bool?;
          Valores.estresLaboral = Dicotomicos.fromInt(
              value['Pace_APNP_HAD_pol_est'],
              toBoolean: true) as bool?;
          Valores.hostilidadLaboral = Dicotomicos.fromInt(
              value['Pace_APNP_HAD_pol_hos'],
              toBoolean: true) as bool?;
          Valores.abusoSexual = Dicotomicos.fromInt(
              value['Pace_APNP_HAD_pol_abu'],
              toBoolean: true) as bool?;
          Valores.acosoSexual = Dicotomicos.fromInt(
              value['Pace_APNP_HAD_pol_aco'],
              toBoolean: true) as bool?;

          Terminal.printSuccess(
              message: "Valores de Diarios asignado : : : value");
          // Terminal.printData(message: "\t$value");
          Archivos.createJsonFromMap([value], filePath: fileAssocieted);
        }
      });
    });
  }

  static void actualizarRegistro() {
    Actividades.actualizar(
      Databases.siteground_database_regepi,
      Diarios.diarios['updateQuery'],
      [
        Diarios.ID_Diarios,
        Pacientes.ID_Paciente,
        // ********* ******** ******* ********* ***
        Valores.actividadesDiariasDescripcion,
        Valores.pasatiemposDescripcion,
        Valores.horasSuenoDescripcion,
        Valores.viajesRecientes,
        Valores.viajesRecientesDescripcion,
        Valores.problemasFamiliares,
        Valores.violenciaInfantil,
        Valores.abusoSustancias,
        Valores.problemasLaborales,
        Valores.estresLaboral,
        Valores.hostilidadLaboral,
        Valores.abusoSexual,
        Valores.acosoSexual,
        // ********* ******** ******* ********* ***
        Diarios.ID_Diarios,
      ],
      Diarios.ID_Diarios,
    ).then((value) {
      Terminal.printAlert(
          message:
              "RESPUESTA al Actualizar Diarios - $value "); // ${listOfValues.length}
      if (value == "SUCCESS" || value == '"SUCCESS"') {
        Terminal.printOther(
            message: "Actualización $value - Eliminando $fileAssocieted");
        Archivos.deleteFile(filePath: fileAssocieted)
            .then((value) => consultarRegistro());
      }
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR al actualizar Diarios - $error");
    });
  }

  static void registrarRegistro() {
    Actividades.registrar(
      Databases.siteground_database_regepi,
      Diarios.diarios['registerQuery'],
      [
        Pacientes.ID_Paciente,
        // ********* ******** ******* ********* ***
        Valores.actividadesDiariasDescripcion,
        Valores.pasatiemposDescripcion,
        Valores.horasSuenoDescripcion,
        Valores.viajesRecientes,
        Valores.viajesRecientesDescripcion,
        Valores.problemasFamiliares,
        Valores.violenciaInfantil,
        Valores.abusoSustancias,
        Valores.problemasLaborales,
        Valores.estresLaboral,
        Valores.hostilidadLaboral,
        Valores.abusoSexual,
        Valores.acosoSexual,
      ],
    ).then((value) {
      Terminal.printAlert(
          message:
              "RESPUESTA al registrar Diarios - $value "); // ${listOfValues.length}
      if (value == "SUCCESS" || value == '"SUCCESS"') {
        consultarRegistro();
      }
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR al registrar Diarios - $error");
    });
  }

// ********* ******** ******* ********* ***
  static final Map<String, dynamic> diarios = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_apnp_had;",
    "showColumns": "SHOW columns FROM pace_apnp_had",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_apnp_had'",
    "createQuery": """
    CREATE TABLE pace_apnp_had (
                          ID_PACE_HAD int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                          ID_Pace int(11) NOT NULL,
                          Pace_APNP_HAD_pas varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          Pace_APNP_HAD_dia varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          Pace_APNP_HAD_sue varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          Pace_APNP_HAD_via_SINO tinyint(1) NOT NULL,
                          Pace_APNP_HAD_via varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          Pace_APNP_HAD_pof_SINO tinyint(1) NOT NULL,
                          Pace_APNP_HAD_pol_vif tinyint(1) NOT NULL,
                          Pace_APNP_HAD_pol_vit tinyint(1) NOT NULL,
                          Pace_APNP_HAD_pol tinyint(1) NOT NULL,
                          Pace_APNP_HAD_pol_est tinyint(1) NOT NULL,
                          Pace_APNP_HAD_pol_hos tinyint(1) NOT NULL,
                          Pace_APNP_HAD_pol_abu tinyint(1) NOT NULL,
                          Pace_APNP_HAD_pol_aco tinyint(1) NOT NULL
                        ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8
                        COLLATE=utf8_unicode_ci
                        COMMENT='Tabla para Agregar Datos de Habitos Diarios';
            """,
    "truncateQuery": "TRUNCATE pace_apnp_had",
    "dropQuery": "DROP TABLE pace_apnp_had",
    "consultQuery": "SELECT * FROM pace_apnp_had",
    "consultIdQuery": "SELECT * FROM pace_apnp_had WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_apnp_had WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_apnp_had",
    "consultLastQuery": "SELECT * FROM pace_apnp_had WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM pace_apnp_had WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO pace_apnp_had (ID_Pace, Pace_APNP_HAD_pas, "
        "Pace_APNP_HAD_dia, Pace_APNP_HAD_sue, Pace_APNP_HAD_via_SINO, Pace_APNP_HAD_via, "
        "Pace_APNP_HAD_pof_SINO, Pace_APNP_HAD_pol_vif, Pace_APNP_HAD_pol_vit, "
        "Pace_APNP_HAD_pol, Pace_APNP_HAD_pol_est, Pace_APNP_HAD_pol_hos, "
        "Pace_APNP_HAD_pol_abu, Pace_APNP_HAD_pol_aco) "
        "VALUES (?,?,?,?,?,?,?,?,?,?,"
        "?,?,?,?)",
    "updateQuery": "UPDATE pace_apnp_had "
        "SET ID_PACE_HAD = ?,  ID_Pace = ?,  Pace_APNP_HAD_pas = ?,  Pace_APNP_HAD_dia = "
        "?,  Pace_APNP_HAD_sue = ?,  Pace_APNP_HAD_via_SINO = ?,  Pace_APNP_HAD_via = "
        "?,  Pace_APNP_HAD_pof_SINO = ?,  Pace_APNP_HAD_pol_vif = ?,  "
        "Pace_APNP_HAD_pol_vit = ?,  Pace_APNP_HAD_pol = ?,  Pace_APNP_HAD_pol_est = ?,  "
        "Pace_APNP_HAD_pol_hos = ?,  Pace_APNP_HAD_pol_abu = ?,  Pace_APNP_HAD_pol_aco = "
        "? WHERE ID_PACE_HAD = ?",
    "deleteQuery": "DELETE FROM pace_apnp_had WHERE ID_pace_apnp_had = ?",
    "diariosColumns": [
      "ID_Pace",
    ],
    "diariosItems": [
      "ID_Pace",
    ],
    "diariosColums": [
      "ID Paciente",
    ],
    "diariosStats": [
      "Total_Administradores",
    ],
    "diariosStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_apnp_had WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_apnp_had WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_apnp_had  WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
// ********* ******** ******* ********* ***
}

class Higienes {
  static int ID_Higienes = 0;
  static var fileAssocieted = "${Pacientes.localRepositoryPath}higienicos.json";
  // ********* ******** ******* ********* ***
  static Map<String, dynamic> Higiene = {};
  // ********* ******** ******* ********* ***
  static void consultarRegistro() {
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      // Asignación de Valores ********* ******** ******* ********* ***
      Higienes.Higiene = value;

      Higienes.ID_Higienes = value['ID_PACE_APNP_HIG'];

      Valores.banoCorporal =
          Dicotomicos.fromInt(value['Pace_APNP_HIG_bac_SINO'], toBoolean: true)
              as bool?;
      Valores.banoCorporalDescripcion = value['REGE_Pace_APNP_HIG_bac'];
      Valores.higieneManos =
          Dicotomicos.fromInt(value['Pace_APNP_HIG_man_SINO'], toBoolean: true)
              as bool?;
      Valores.higieneManosDescripcion = value['REGE_Pace_APNP_HIG_man'];
      Valores.cambiosRopa =
          Dicotomicos.fromInt(value['Pace_APNP_HIG_rop_SINO'], toBoolean: true)
              as bool?;
      Valores.cambiosRopaDescripcion = value['REGE_Pace_APNP_HIG_rop'];
      Valores.aseoDental =
          Dicotomicos.fromInt(value['Pace_APNP_HIG_den_SINO'], toBoolean: true)
              as bool?;
      Valores.aseoDentalDescripcion = value['REGE_Pace_APNP_HIG_den'];
      // *********************************
    }).onError((error, stackTrace) {
      Actividades.consultarId(Databases.siteground_database_regepi,
              Higienes.higienes['consultIdQuery'], Pacientes.ID_Paciente)
          .then((value) {
        if (value.containsKey('Error')) {
          Terminal.printExpected(
              message: "Higienes consultar registro - $value");
          registrarRegistro();
        } else {
          // Asignación de Valores ********* ******** ******* ********* ***
          Higienes.Higiene = value;

          Higienes.ID_Higienes = value['ID_PACE_APNP_HIG'];

          Valores.banoCorporal = Dicotomicos.fromInt(
              value['Pace_APNP_HIG_bac_SINO'],
              toBoolean: true) as bool?;
          Valores.banoCorporalDescripcion = value['REGE_Pace_APNP_HIG_bac'];
          Valores.higieneManos = Dicotomicos.fromInt(
              value['Pace_APNP_HIG_man_SINO'],
              toBoolean: true) as bool?;
          Valores.higieneManosDescripcion = value['REGE_Pace_APNP_HIG_man'];
          Valores.cambiosRopa = Dicotomicos.fromInt(
              value['Pace_APNP_HIG_rop_SINO'],
              toBoolean: true) as bool?;
          Valores.cambiosRopaDescripcion = value['REGE_Pace_APNP_HIG_rop'];
          Valores.aseoDental = Dicotomicos.fromInt(
              value['Pace_APNP_HIG_den_SINO'],
              toBoolean: true) as bool?;
          Valores.aseoDentalDescripcion = value['REGE_Pace_APNP_HIG_den'];

          Terminal.printSuccess(
              message: "Valores de Higienicos asignado : : : value");
          // Terminal.printData(message: "\t$value");
          Archivos.createJsonFromMap([value],
              filePath: "${Pacientes.localRepositoryPath}higienicos.json");
        }
      });
    });
  }

  static void actualizarRegistro() {
    Actividades.actualizar(
      Databases.siteground_database_regepi,
      Higienes.higienes['updateQuery'],
      [
        Higienes.ID_Higienes,
        Pacientes.ID_Paciente,
        Calendarios.today(format: 'yyyy/MM/dd'),
        // ********* ******** ******* ********* ***
        Valores.banoCorporal,
        Valores.banoCorporalDescripcion,
        Valores.higieneManos,
        Valores.higieneManosDescripcion,
        Valores.cambiosRopa,
        Valores.cambiosRopaDescripcion,
        Valores.aseoDental,
        Valores.aseoDentalDescripcion,
        // ********* ******** ******* ********* ***
        Higienes.ID_Higienes,
      ],
      Higienes.ID_Higienes,
    ).then((value) {
      Terminal.printAlert(
          message:
              "RESPUESTA al Actualizar Higienes - $value "); // ${listOfValues.length}
      if (value == "SUCCESS" || value == '"SUCCESS"') {
        Terminal.printOther(
            message: "Actualización $value - Eliminando $fileAssocieted");
        Archivos.deleteFile(filePath: fileAssocieted)
            .then((value) => consultarRegistro());
      }
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR al actualizar Higienes - $error");
    });
  }

  static void registrarRegistro() {
    Actividades.registrar(
      Databases.siteground_database_regepi,
      Higienes.higienes['registerQuery'],
      [
        Pacientes.ID_Paciente,
        Calendarios.today(format: 'yyyy/MM/dd'),
        // ********* ******** ******* ********* ***
        Valores.banoCorporal,
        Valores.banoCorporalDescripcion,
        Valores.higieneManos,
        Valores.higieneManosDescripcion,
        Valores.cambiosRopa,
        Valores.cambiosRopaDescripcion,
        Valores.aseoDental,
        Valores.aseoDentalDescripcion,
      ],
    ).then((value) {
      Terminal.printAlert(
          message:
              "RESPUESTA al registrar Higienes - $value "); // ${listOfValues.length}
      if (value == "SUCCESS" || value == '"SUCCESS"') {
        consultarRegistro();
      }
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR al registrar Higienes - $error");
    });
  }

// ********* ******** ******* ********* ***
  static final Map<String, dynamic> higienes = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_apnp_hig;",
    "showColumns": "SHOW columns FROM pace_apnp_hig",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_apnp_hig'",
    "createQuery": """
    CREATE TABLE pace_apnp_hig (
                          ID_PACE_APNP_HIG int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                          ID_Pace int(11) NOT NULL,
                          Pace_APNP_HIG_Feca date NOT NULL,
                          Pace_APNP_HIG_bac_SINO tinyint(1) NOT NULL,
                          REGE_Pace_APNP_HIG_bac varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          Pace_APNP_HIG_man_SINO tinyint(1) NOT NULL,
                          REGE_Pace_APNP_HIG_man varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          Pace_APNP_HIG_rop_SINO tinyint(1) NOT NULL,
                          REGE_Pace_APNP_HIG_rop varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          Pace_APNP_HIG_den_SINO tinyint(1) NOT NULL,
                          REGE_Pace_APNP_HIG_den varchar(200) COLLATE utf8_unicode_ci NOT NULL
                        ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Agregar Datos de Habitos Higienicos';
            """,
    "truncateQuery": "TRUNCATE pace_apnp_hig",
    "dropQuery": "DROP TABLE pace_apnp_hig",
    "consultQuery": "SELECT * FROM pace_apnp_hig",
    "consultIdQuery": "SELECT * FROM pace_apnp_hig WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_apnp_hig WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_apnp_hig",
    "consultLastQuery": "SELECT * FROM pace_apnp_hig WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM pace_apnp_hig WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO pace_apnp_hig (ID_Pace, Pace_APNP_HIG_Feca, "
        "Pace_APNP_HIG_bac_SINO, REGE_Pace_APNP_HIG_bac, Pace_APNP_HIG_man_SINO, "
        "REGE_Pace_APNP_HIG_man, Pace_APNP_HIG_rop_SINO, REGE_Pace_APNP_HIG_rop, "
        "Pace_APNP_HIG_den_SINO, REGE_Pace_APNP_HIG_den) "
        "VALUES (?,?,?,?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_apnp_hig "
        "SET ID_PACE_APNP_HIG = ?,  ID_Pace = ?,  Pace_APNP_HIG_Feca = ?,  "
        "Pace_APNP_HIG_bac_SINO = ?,  REGE_Pace_APNP_HIG_bac = ?,  Pace_APNP_HIG_man_SINO "
        "= ?,  REGE_Pace_APNP_HIG_man = ?,  Pace_APNP_HIG_rop_SINO = ?,  "
        "REGE_Pace_APNP_HIG_rop = ?,  Pace_APNP_HIG_den_SINO = ?,  REGE_Pace_APNP_HIG_den = ? "
        "WHERE ID_PACE_APNP_HIG = ?",
    "deleteQuery": "DELETE FROM pace_apnp_hig WHERE ID_pace_apnp_hig = ?",
    "higienesColumns": [
      "ID_Pace",
    ],
    "higienesItems": [
      "ID_Pace",
    ],
    "higienesColums": [
      "ID Paciente",
    ],
    "higienesStats": [
      "Total_Administradores",
    ],
    "higienesStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_apnp_hig WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_apnp_hig WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_apnp_hig  WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
// ********* ******** ******* ********* ***
}

class Limitaciones {
  static int ID_Limitaciones = 0;
  static var fileAssocieted =
      "${Pacientes.localRepositoryPath}limitaciones.json";
  // ********* ******** ******* ********* ***
  static Map<String, dynamic> Limitacion = {};
  // ********* ******** ******* ********* ***
  static void consultarRegistro() {
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      // Asignación de Valores ********* ******** ******* ********* ***
      Limitaciones.Limitacion = value;

      Limitaciones.ID_Limitaciones = value['ID_PACE_APNP_LIM'];

      Valores.usoLentes =
          Dicotomicos.fromInt(value['Pace_APNP_LIM_len_SINO'], toBoolean: true)
              as bool?;
      Valores.usoLentesDescripcion = value['Pace_APNP_LIM_len'];
      Valores.aparatoSordera =
          Dicotomicos.fromInt(value['Pace_APNP_LIM_sor_SINO'], toBoolean: true)
              as bool?;
      Valores.aparatoSorderaDescripcion = value['Pace_APNP_LIM_sor'];
      Valores.protesisDentaria =
          Dicotomicos.fromInt(value['Pace_APNP_LIM_ria_SINO'], toBoolean: true)
              as bool?;
      Valores.protesisDentariaDescripcion = value['Pace_APNP_LIM_ria'];
      Valores.marcapasosCardiaco =
          Dicotomicos.fromInt(value['Pace_APNP_LIM_mar_SINO'], toBoolean: true)
              as bool?;
      Valores.marcapasosCardiacoDescripcion = value['Pace_APNP_LIM_mar'];
      Valores.ortesisDeambular =
          Dicotomicos.fromInt(value['Pace_APNP_LIM_dea_SINO'], toBoolean: true)
              as bool?;
      Valores.ortesisDeambularDescripcion = value['Pace_APNP_LIM_dea'];
      Valores.limitacionesActividadCotidiana =
          Dicotomicos.fromInt(value['Pace_APNP_LIM_lim_SINO'], toBoolean: true)
              as bool?;
      Valores.limitacionesActividadCotidianaDescripcion =
          value['Pace_APNP_LIM_lim'];
      // *********************************
    }).onError((error, stackTrace) {
      Actividades.consultarId(
              Databases.siteground_database_regepi,
              Limitaciones.limitaciones['consultIdQuery'],
              Pacientes.ID_Paciente)
          .then((value) {
        if (value.containsKey('Error')) {
          Terminal.printExpected(
              message: "Limitacciones consultar registro - $value");
          registrarRegistro();
        } else {
          // Asignación de Valores ********* ******** ******* ********* ***
          Limitaciones.Limitacion = value;

          Limitaciones.ID_Limitaciones = value['ID_PACE_APNP_LIM'];

          Valores.usoLentes = Dicotomicos.fromInt(
              value['Pace_APNP_LIM_len_SINO'],
              toBoolean: true) as bool?;
          // Valores.usoLentesDescripcion = value['Pace_APNP_LIM_len'];
          Valores.aparatoSordera = Dicotomicos.fromInt(
              value['Pace_APNP_LIM_sor_SINO'],
              toBoolean: true) as bool?;
          // Valores.aparatoSorderaDescripcion = value['Pace_APNP_LIM_sor'];
          Valores.protesisDentaria = Dicotomicos.fromInt(
              value['Pace_APNP_LIM_ria_SINO'],
              toBoolean: true) as bool?;
          // Valores.protesisDentariaDescripcion = value['Pace_APNP_LIM_ria'];
          Valores.marcapasosCardiaco = Dicotomicos.fromInt(
              value['Pace_APNP_LIM_mar_SINO'],
              toBoolean: true) as bool?;
          // Valores.marcapasosCardiacoDescripcion = value['Pace_APNP_LIM_mar'];
          Valores.ortesisDeambular = Dicotomicos.fromInt(
              value['Pace_APNP_LIM_dea_SINO'],
              toBoolean: true) as bool?;
          // Valores.ortesisDeambularDescripcion = value['Pace_APNP_LIM_dea'];
          Valores.limitacionesActividadCotidiana = Dicotomicos.fromInt(
              value['Pace_APNP_LIM_lim_SINO'],
              toBoolean: true) as bool?;
          // Valores.limitacionesActividadCotidianaDescripcion = value['Pace_APNP_LIM_lim'];

          Terminal.printSuccess(
              message: "Valores de Limitaciones asignado : : : value");
          // Terminal.printData(message: "\t$value");
          Archivos.createJsonFromMap([value], filePath: fileAssocieted);
        }
      });
    });
  }

  static void actualizarRegistro() {
    Actividades.actualizar(
      Databases.siteground_database_regepi,
      Limitaciones.limitaciones['updateQuery'],
      [
        Limitaciones.ID_Limitaciones,
        Pacientes.ID_Paciente,
        Calendarios.today(format: 'yyyy/MM/dd'),
        // ********* ******** ******* ********* ***
        Valores.usoLentes,
        Valores.usoLentesDescripcion,
        Valores.aparatoSordera,
        Valores.aparatoSorderaDescripcion,
        Valores.protesisDentaria,
        Valores.protesisDentariaDescripcion,
        Valores.marcapasosCardiaco,
        Valores.marcapasosCardiacoDescripcion,
        Valores.ortesisDeambular,
        Valores.ortesisDeambularDescripcion,
        Valores.limitacionesActividadCotidiana,
        Valores.limitacionesActividadCotidianaDescripcion,
        // ********* ******** ******* ********* ***
        Limitaciones.ID_Limitaciones,
      ],
      Limitaciones.ID_Limitaciones,
    ).then((value) {
      Terminal.printAlert(
          message:
              "RESPUESTA al Actualizar Limitaciones - $value "); // ${listOfValues.length}
      if (value == "SUCCESS" || value == '"SUCCESS"') {
        Terminal.printOther(
            message: "Actualización $value - Eliminando $fileAssocieted");
        Archivos.deleteFile(filePath: fileAssocieted)
            .then((value) => consultarRegistro());
      }
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR al actualizar Limitaciones - $error");
    });
  }

  static void registrarRegistro() {
    Actividades.registrar(
      Databases.siteground_database_regepi,
      Limitaciones.limitaciones['registerQuery'],
      [
        Pacientes.ID_Paciente,
        Calendarios.today(format: 'yyyy/MM/dd'),
        // ********* ******** ******* ********* ***
        Valores.usoLentes,
        Valores.usoLentesDescripcion,
        Valores.aparatoSordera,
        Valores.aparatoSorderaDescripcion,
        Valores.protesisDentaria,
        Valores.protesisDentariaDescripcion,
        Valores.marcapasosCardiaco,
        Valores.marcapasosCardiacoDescripcion,
        Valores.ortesisDeambular,
        Valores.ortesisDeambularDescripcion,
        Valores.limitacionesActividadCotidiana,
        Valores.limitacionesActividadCotidianaDescripcion,
      ],
    ).then((value) {
      Terminal.printAlert(
          message:
              "RESPUESTA al registrar Limitaciones - $value "); // ${listOfValues.length}
      if (value == "SUCCESS" || value == '"SUCCESS"') {
        consultarRegistro();
      }
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR al registrar Limitaciones - $error");
    });
  }

// ********* ******** ******* ********* ***
  static final Map<String, dynamic> limitaciones = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_apnp_lim;",
    "showColumns": "SHOW columns FROM pace_apnp_lim",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_apnp_lim'",
    "createQuery": """
    CREATE TABLE pace_apnp_lim (
                      ID_PACE_APNP_LIM int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      ID_Pace int(11) NOT NULL,
                      Pace_APNP_LIM_Feca date NOT NULL,
                      Pace_APNP_LIM_len_SINO tinyint(1) NOT NULL,
                      Pace_APNP_LIM_len_DESC varchar(200) NOT NULL,
                      Pace_APNP_LIM_sor_SINO tinyint(1) NOT NULL,
                      Pace_APNP_LIM_sor_DESC varchar(200) NOT NULL,
                      Pace_APNP_LIM_ria_SINO tinyint(1) NOT NULL,
                      Pace_APNP_LIM_ria_DESC varchar(200) NOT NULL,
                      Pace_APNP_LIM_mar_SINO tinyint(1) NOT NULL,
                      Pace_APNP_LIM_mar_DESC varchar(200) NOT NULL,
                      Pace_APNP_LIM_dea_SINO tinyint(1) NOT NULL,
                      Pace_APNP_LIM_dea_DESC varchar(200) NOT NULL,
                      Pace_APNP_LIM_lim_SINO tinyint(1) NOT NULL, 
                      Pace_APNP_LIM_lim_DESC varchar(200) NOT NULL
                    ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8
                    COLLATE=utf8_unicode_ci
                    COMMENT='Tabla para Agregar Datos de Limitación Física';
            """,
    "truncateQuery": "TRUNCATE pace_apnp_lim",
    "dropQuery": "DROP TABLE pace_apnp_lim",
    "consultQuery": "SELECT * FROM pace_apnp_lim",
    "consultIdQuery": "SELECT * FROM pace_apnp_lim WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_apnp_lim WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_apnp_lim",
    "consultLastQuery": "SELECT * FROM pace_apnp_lim WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM pace_apnp_lim WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO pace_apnp_lim (ID_Pace, Pace_APNP_LIM_Feca, "
        "Pace_APNP_LIM_len_SINO, Pace_APNP_LIM_len_DESC, "
        "Pace_APNP_LIM_sor_SINO, Pace_APNP_LIM_sor_DESC, "
        "Pace_APNP_LIM_ria_SINO, Pace_APNP_LIM_ria_DESC, "
        "Pace_APNP_LIM_mar_SINO, Pace_APNP_LIM_mar_DESC, "
        "Pace_APNP_LIM_dea_SINO, Pace_APNP_LIM_dea_DESC, "
        "Pace_APNP_LIM_lim_SINO, Pace_APNP_LIM_lim_DESC) "
        "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_apnp_lim "
        "SET ID_PACE_APNP_LIM = ?,  ID_Pace = ?,  Pace_APNP_LIM_Feca = ?,  "
        "Pace_APNP_LIM_len_SINO = ?,  Pace_APNP_LIM_len_DESC = ?, "
        "Pace_APNP_LIM_sor_SINO = ?,  Pace_APNP_LIM_sor_DESC = ?, "
        "Pace_APNP_LIM_ria_SINO = ?,  Pace_APNP_LIM_ria_DESC = ?, "
        "Pace_APNP_LIM_mar_SINO = ?,  Pace_APNP_LIM_mar_DESC = ?, "
        "Pace_APNP_LIM_dea_SINO = ?,  Pace_APNP_LIM_dea_DESC = ?, "
        "Pace_APNP_LIM_lim_SINO = ?,  Pace_APNP_LIM_lim_DESC = ? "
        "WHERE ID_PACE_APNP_LIM = ?",
    "deleteQuery": "DELETE FROM pace_apnp_lim WHERE ID_pace_apnp_lim = ?",
    "limitacionesColumns": [
      "ID_Pace",
    ],
    "limitacionesItems": [
      "ID_Pace",
    ],
    "limitacionesColums": [
      "ID Paciente",
    ],
    "limitacionesStats": [
      "Total_Administradores",
    ],
    "limitacionesStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_apnp_lim WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_apnp_lim WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_apnp_lim  WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
// ********* ******** ******* ********* ***
}

class Sustancias {
  static int ID_Sustancias = 0;
  static var fileAssocieted =
      "${Pacientes.localRepositoryPath}exposiciones.json";
  // ********* ******** ******* ********* ***
  static Map<String, dynamic> Sustancia = {};
  // ********* ******** ******* ********* ***
  static void consultarRegistro() {
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      // Asignación de Valores ********* ******** ******* ********* ***
      Sustancias.Sustancia = value;

      Sustancias.ID_Sustancias = value['ID_PACE_APNP_SUS'];

      Valores.exposicionBiomasa =
          Dicotomicos.fromInt(value['Pace_APNP_SUS_len_SINO'], toBoolean: true)
              as bool?;
      // Valores.exposicionBiomasaDescripcion = value['Pace_APNP_SUS_len'];
      Valores.exposicionHumosQuimicos =
          Dicotomicos.fromInt(value['Pace_APNP_SUS_qui_SINO'], toBoolean: true)
              as bool?;
      // Valores.exposicionHumosQuimicosDescripcion = value['Pace_APNP_SUS_qui'];
      Valores.exposicionPesticidas =
          Dicotomicos.fromInt(value['Pace_APNP_SUS_pes_SINO'], toBoolean: true)
              as bool?;
      // Valores.exposicionPesticidasDescripcion = value['Pace_APNP_SUS_pes'];
      Valores.exposicionMetalesPesados =
          Dicotomicos.fromInt(value['Pace_APNP_SUS_met_SINO'], toBoolean: true)
              as bool?;
      // Valores.exposicionMetalesPesadosDescripcion = value['Pace_APNP_SUS_met'];
      Valores.exposicionPsicotropicos =
          Dicotomicos.fromInt(value['Pace_APNP_SUS_psi_SINO'], toBoolean: true)
              as bool?;
      // Valores.limitacionesActividadCotidianaDescripcion = value['Pace_APNP_LIM_lim'];
      // *********************************
    }).onError((error, stackTrace) {
      Actividades.consultarId(Databases.siteground_database_regepi,
              Sustancias.sustancias['consultIdQuery'], Pacientes.ID_Paciente)
          .then((value) {
        if (value.containsKey('Error')) {
          Terminal.printExpected(
              message: "Exposiciones consultar registro - $value");
          registrarRegistro();
        } else {
          // Asignación de Valores ********* ******** ******* ********* ***
          Sustancias.Sustancia = value;

          Sustancias.ID_Sustancias = value['ID_PACE_APNP_SUS'];

          Valores.exposicionBiomasa = Dicotomicos.fromInt(
              value['Pace_APNP_SUS_len_SINO'],
              toBoolean: true) as bool?;
          // Valores.exposicionBiomasaDescripcion = value['Pace_APNP_SUS_len'];
          Valores.exposicionHumosQuimicos = Dicotomicos.fromInt(
              value['Pace_APNP_SUS_qui_SINO'],
              toBoolean: true) as bool?;
          // Valores.exposicionHumosQuimicosDescripcion = value['Pace_APNP_SUS_qui'];
          Valores.exposicionPesticidas = Dicotomicos.fromInt(
              value['Pace_APNP_SUS_pes_SINO'],
              toBoolean: true) as bool?;
          // Valores.exposicionPesticidasDescripcion = value['Pace_APNP_SUS_pes'];
          Valores.exposicionMetalesPesados = Dicotomicos.fromInt(
              value['Pace_APNP_SUS_met_SINO'],
              toBoolean: true) as bool?;
          // Valores.exposicionMetalesPesadosDescripcion = value['Pace_APNP_SUS_met'];
          Valores.exposicionPsicotropicos = Dicotomicos.fromInt(
              value['Pace_APNP_SUS_psi_SINO'],
              toBoolean: true) as bool?;
          Terminal.printSuccess(
              message: "Valores de Exposiciones asignado : : : value");
          // Terminal.printData(message: "\t$value");
          Archivos.createJsonFromMap([value],
              filePath: "${Pacientes.localRepositoryPath}exposiciones.json");
        }
      });
    });
  }

  static void actualizarRegistro() {
    Actividades.actualizar(
      Databases.siteground_database_regepi,
      Sustancias.sustancias['updateQuery'],
      [
        Sustancias.ID_Sustancias,
        Pacientes.ID_Paciente,
        Calendarios.today(format: 'yyyy/MM/dd'),
        // ********* ******** ******* ********* ***
        Valores.exposicionBiomasa,
        Valores.exposicionBiomasaDescripcion,
        Valores.exposicionHumosQuimicos,
        Valores.exposicionHumosQuimicosDescripcion,
        Valores.exposicionPesticidas,
        Valores.exposicionPesticidasDescripcion,
        Valores.exposicionMetalesPesados,
        Valores.exposicionMetalesPesadosDescripcion,
        Valores.exposicionPsicotropicos,
        Valores.exposicionPsicotropicosDescripcion,
        // ********* ******** ******* ********* ***
        Sustancias.ID_Sustancias,
      ],
      Sustancias.ID_Sustancias,
    ).then((value) {
      Terminal.printAlert(
          message:
              "RESPUESTA al Actualizar Sustancias - $value "); // ${listOfValues.length}
      if (value == "SUCCESS" || value == '"SUCCESS"') {
        Terminal.printOther(
            message: "Actualización $value - Eliminando $fileAssocieted");
        Archivos.deleteFile(filePath: fileAssocieted)
            .then((value) => consultarRegistro());
      }
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR al actualizar Sustancias - $error");
    });
  }

  static void registrarRegistro() {
    Actividades.registrar(
      Databases.siteground_database_regepi,
      Sustancias.sustancias['registerQuery'],
      [
        Pacientes.ID_Paciente,
        Calendarios.today(format: 'yyyy/MM/dd'),
        // ********* ******** ******* ********* ***
        Valores.exposicionBiomasa,
        Valores.exposicionBiomasaDescripcion,
        Valores.exposicionHumosQuimicos,
        Valores.exposicionHumosQuimicosDescripcion,
        Valores.exposicionPesticidas,
        Valores.exposicionPesticidasDescripcion,
        Valores.exposicionMetalesPesados,
        Valores.exposicionMetalesPesadosDescripcion,
        Valores.exposicionPsicotropicos,
        Valores.exposicionPsicotropicosDescripcion,
      ],
    ).then((value) {
      Terminal.printAlert(
          message:
              "RESPUESTA al registrar Exposiciones - $value "); // ${listOfValues.length}
      if (value == "SUCCESS" || value == '"SUCCESS"') {
        consultarRegistro();
      }
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR al registrar Exposiciones - $error");
    });
  }

// ********* ******** ******* ********* ***
  static final Map<String, dynamic> sustancias = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_apnp_sus;",
    "showColumns": "SHOW columns FROM pace_apnp_sus",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_apnp_sus'",
    "createQuery": """
    CREATE TABLE pace_apnp_sus (
                          ID_PACE_APNP_SUS int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                          ID_Pace int(11) NOT NULL,
                          Pace_APNP_SUS_Feca date NOT NULL,
                          Pace_APNP_SUS_len_SINO tinyint(1) NOT NULL,
                          Pace_APNP_SUS_len_DESC varchar(200) NOT NULL,
                          Pace_APNP_SUS_qui_SINO tinyint(1) NOT NULL,
                          Pace_APNP_SUS_qui_DESC varchar(200) NOT NULL,
                          Pace_APNP_SUS_pes_SINO tinyint(1) NOT NULL,
                          Pace_APNP_SUS_pes_DESC varchar(200) NOT NULL,
                          Pace_APNP_SUS_met_SINO tinyint(1) NOT NULL,
                          Pace_APNP_SUS_met_DESC varchar(200) NOT NULL,
                          Pace_APNP_SUS_psi_SINO tinyint(1) NOT NULL,
                          Pace_APNP_SUS_psi_DESC varchar(200) NOT NULL,
                        ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8
                        COLLATE=utf8_unicode_ci
                        COMMENT='Tabla para Datos relacionados con Sustancias Toxicas';
            """,
    "truncateQuery": "TRUNCATE pace_apnp_sus",
    "dropQuery": "DROP TABLE pace_apnp_sus",
    "consultQuery": "SELECT * FROM pace_apnp_sus",
    "consultIdQuery": "SELECT * FROM pace_apnp_sus WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_apnp_sus WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_apnp_sus",
    "consultLastQuery": "SELECT * FROM pace_apnp_sus WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM pace_apnp_sus WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO pace_apnp_sus (ID_Pace, Pace_APNP_SUS_Feca, "
        "Pace_APNP_SUS_len_SINO, Pace_APNP_SUS_len_DESC, "
        "Pace_APNP_SUS_qui_SINO, Pace_APNP_SUS_qui_DESC, "
        "Pace_APNP_SUS_pes_SINO, Pace_APNP_SUS_pes_DESC, "
        "Pace_APNP_SUS_met_SINO, Pace_APNP_SUS_met_DESC, "
        "Pace_APNP_SUS_psi_SINO, Pace_APNP_SUS_psi_DESC) "
        "VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_apnp_sus "
        "SET ID_PACE_APNP_SUS = ?, ID_Pace = ?, Pace_APNP_SUS_Feca = ?, "
        "Pace_APNP_SUS_len_SINO = ?, Pace_APNP_SUS_len_DESC = ?, "
        "Pace_APNP_SUS_qui_SINO = ?, Pace_APNP_SUS_qui_DESC = ?, "
        "Pace_APNP_SUS_pes_SINO = ?, Pace_APNP_SUS_pes_DESC = ?, "
        "Pace_APNP_SUS_met_SINO = ?, Pace_APNP_SUS_met_DESC = ?, "
        "Pace_APNP_SUS_psi_SINO = ?, Pace_APNP_SUS_psi_DESC = ? "
        "WHERE ID_PACE_APNP_SUS = ?",
    "deleteQuery": "DELETE FROM pace_apnp_sus WHERE ID_pace_apnp_sus = ?",
    "sustanciasColumns": [
      "ID_Pace",
    ],
    "sustanciasItems": [
      "ID_Pace",
    ],
    "sustanciasColums": [
      "ID Paciente",
    ],
    "sustanciasStats": [
      "Total_Administradores",
    ],
    "sustanciasStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_apnp_sus WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_apnp_sus WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_apnp_sus  WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
// ********* ******** ******* ********* ***
}

class Toxicomanias {
  static int ID_Toxicomanias = 0;
  static var fileAssocieted =
      "${Pacientes.localRepositoryPath}toxicomanias.json";
  // ********* ******** ******* ********* ***
  static Map<String, dynamic> Toxicomania = {};
  // ********* ******** ******* ********* ***
  static void consultarRegistro() {
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      // Asignación de Valores ********* ******** ******* ********* ***
      Toxicomanias.Toxicomania = value;

      Toxicomanias.ID_Toxicomanias = value['ID_PACE_APNP_DRO'];

      Valores.esAlcoholismo =
          Dicotomicos.fromInt(value['Pace_APNP_DRO_alc_SINO'], toBoolean: true)
              as bool?;
      Valores.suspensionAlcoholismo = Dicotomicos.fromInt(
          value['Pace_APNP_DRO_alc_SUS_SINO'],
          toBoolean: true) as bool?;
      Valores.edadInicioAlcoholismo =
          value['REGE_Pace_APNP_DRO_alc_INE'].toString();
      Valores.duracionAnosAlcoholismo =
          value['REGE_Pace_APNP_DRO_alc_DUR'].toString();
      Valores.periodicidadAlcoholismo =
          value['REGE_Pace_APNP_DRO_alc_PER'].toString();
      Valores.intervaloAlcoholismo = value['Pace_APNP_DRO_alc_DUR_PER_'];
      Valores.aosSuspensionAlcoholismo =
          value['REGE_Pace_APNP_DRO_alc_SUS'].toString();
      Valores.tiposAlcoholismoDescripcion = value['Pace_APNP_DRO_alc_TIP'];
      // ********* ******** ******* ********* ***
      Valores.esTabaquismo =
          Dicotomicos.fromInt(value['Pace_APNP_DRO_tab_SINO'], toBoolean: true)
              as bool?;
      Valores.suspensionTabaquismo = Dicotomicos.fromInt(
          value['Pace_APNP_DRO_tab_SUS_SINO'],
          toBoolean: true) as bool?;
      Valores.edadInicioTabaquismo =
          value['REGE_Pace_APNP_DRO_tab_INE'].toString();
      Valores.duracionAnosTabaquismo =
          value['REGE_Pace_APNP_DRO_tab_DUR'].toString();
      Valores.periodicidadTabaquismo =
          value['REGE_Pace_APNP_DRO_tab_PER'].toString();
      Valores.intervaloTabaquismo = value['Pace_APNP_DRO_tab_DUR_PER_'];
      Valores.aosSuspensionTabaquismo =
          value['REGE_Pace_APNP_DRO_tab_SUS'].toString();
      Valores.tiposTabaquismoDescripcion = value['Pace_APNP_DRO_tab_TIP'];
      // ********* ******** ******* ********* ***
      Valores.esDrogadismo =
          Dicotomicos.fromInt(value['Pace_APNP_DRO_tox_SINO'], toBoolean: true)
              as bool?;
      Valores.suspensionDrogadismo = Dicotomicos.fromInt(
          value['Pace_APNP_DRO_tox_SUS_SINO'],
          toBoolean: true) as bool?;
      Valores.edadInicioDrogadismo =
          value['REGE_Pace_APNP_DRO_tox_INE'].toString();
      Valores.duracionAnosDrogadismo =
          value['REGE_Pace_APNP_DRO_tox_DUR'].toString();
      Valores.periodicidadDrogadismo =
          value['REGE_Pace_APNP_DRO_tox_PER'].toString();
      Valores.intervaloDrogadismo = value['Pace_APNP_DRO_tox_DUR_PER_'];
      Valores.aosSuspensionDrogadismo =
          value['REGE_Pace_APNP_DRO_tox_SUS'].toString();
      Valores.tiposDrogadismoDescripcion = value['Pace_APNP_DRO_tox_TIP'];
      // Valores.limitacionesActividadCotidianaDescripcion = value['Pace_APNP_LIM_lim'];
      // *********************************
    }).onError((error, stackTrace) {
      Actividades.consultarId(
              Databases.siteground_database_regepi,
              Toxicomanias.toxicomanias['consultIdQuery'],
              Pacientes.ID_Paciente)
          .then((value) {
        if (value.containsKey('Error')) {
          Terminal.printExpected(
              message: "Toxicomanias consultar registro - $value");
          registrarRegistro();
        } else {
          // Asignación de Valores ********* ******** ******* ********* ***
          Toxicomanias.Toxicomania = value;

          Toxicomanias.ID_Toxicomanias = value['ID_PACE_APNP_DRO'];

          Valores.esAlcoholismo = Dicotomicos.fromInt(
              value['Pace_APNP_DRO_alc_SINO'],
              toBoolean: true) as bool?;
          Valores.suspensionAlcoholismo = Dicotomicos.fromInt(
              value['Pace_APNP_DRO_alc_SUS_SINO'],
              toBoolean: true) as bool?;
          Valores.edadInicioAlcoholismo =
              value['REGE_Pace_APNP_DRO_alc_INE'].toString();
          Valores.duracionAnosAlcoholismo =
              value['REGE_Pace_APNP_DRO_alc_DUR'].toString();
          Valores.periodicidadAlcoholismo =
              value['REGE_Pace_APNP_DRO_alc_PER'].toString();
          Valores.intervaloAlcoholismo = value['Pace_APNP_DRO_alc_DUR_PER_'];
          Valores.aosSuspensionAlcoholismo =
              value['REGE_Pace_APNP_DRO_alc_SUS'].toString();
          Valores.tiposAlcoholismoDescripcion = value['Pace_APNP_DRO_alc_TIP'];
          // ********* ******** ******* ********* ***
          Valores.esTabaquismo = Dicotomicos.fromInt(
              value['Pace_APNP_DRO_tab_SINO'],
              toBoolean: true) as bool?;
          Valores.suspensionTabaquismo = Dicotomicos.fromInt(
              value['Pace_APNP_DRO_tab_SUS_SINO'],
              toBoolean: true) as bool?;
          Valores.edadInicioTabaquismo =
              value['REGE_Pace_APNP_DRO_tab_INE'].toString();
          Valores.duracionAnosTabaquismo =
              value['REGE_Pace_APNP_DRO_tab_DUR'].toString();
          Valores.periodicidadTabaquismo =
              value['REGE_Pace_APNP_DRO_tab_PER'].toString();
          Valores.intervaloTabaquismo = value['Pace_APNP_DRO_tab_DUR_PER_'];
          Valores.aosSuspensionTabaquismo =
              value['REGE_Pace_APNP_DRO_tab_SUS'].toString();
          Valores.tiposTabaquismoDescripcion = value['Pace_APNP_DRO_tab_TIP'];
          // ********* ******** ******* ********* ***
          Valores.esDrogadismo = Dicotomicos.fromInt(
              value['Pace_APNP_DRO_tox_SINO'],
              toBoolean: true) as bool?;
          Valores.suspensionDrogadismo = Dicotomicos.fromInt(
              value['Pace_APNP_DRO_tox_SUS_SINO'],
              toBoolean: true) as bool?;
          Valores.edadInicioDrogadismo =
              value['REGE_Pace_APNP_DRO_tox_INE'].toString();
          Valores.duracionAnosDrogadismo =
              value['REGE_Pace_APNP_DRO_tox_DUR'].toString();
          Valores.periodicidadDrogadismo =
              value['REGE_Pace_APNP_DRO_tox_PER'].toString();
          Valores.intervaloDrogadismo = value['Pace_APNP_DRO_tox_DUR_PER_'];
          Valores.aosSuspensionDrogadismo =
              value['REGE_Pace_APNP_DRO_tox_SUS'].toString();
          Valores.tiposDrogadismoDescripcion = value['Pace_APNP_DRO_tox_TIP'];
          // ********* ******** ******* ********* ***

          // // print("Valores de Toxicomanias asignado : : : $value");
          Terminal.printSuccess(
              message: "Valores de Toxicomanias asignado : : : value");
          // Terminal.printData(message: "\t$value");
          Archivos.createJsonFromMap([value], filePath: fileAssocieted);
        }
      });
    });
  }

  static void actualizarRegistro() {
    List listOfValues = [
      Toxicomanias.ID_Toxicomanias,
      Pacientes.ID_Paciente,
      Calendarios.today(format: 'yyyy/MM/dd'),
      // ********* ******** ******* ********* ***
      Valores.esAlcoholismo,
      Valores.edadInicioAlcoholismo,
      Valores.duracionAnosAlcoholismo,
      Valores.periodicidadAlcoholismo,
      Valores.intervaloAlcoholismo,
      Valores.suspensionAlcoholismo,
      Valores.aosSuspensionAlcoholismo,
      Valores.tiposAlcoholismoDescripcion,
      // ********* ******** ******* ********* ***
      Valores.esTabaquismo,
      Valores.edadInicioTabaquismo,
      Valores.duracionAnosTabaquismo,
      Valores.periodicidadTabaquismo,
      Valores.intervaloTabaquismo,
      Valores.suspensionTabaquismo,
      Valores.aosSuspensionTabaquismo,
      Valores.tiposTabaquismoDescripcion,
      // ********* ******** ******* ********* ***
      Valores.esDrogadismo,
      Valores.edadInicioDrogadismo,
      Valores.duracionAnosDrogadismo,
      Valores.periodicidadDrogadismo,
      Valores.intervaloDrogadismo,
      Valores.suspensionDrogadismo,
      Valores.aosSuspensionDrogadismo,
      Valores.tiposDrogadismoDescripcion,
      // ********* ******** ******* ********* ***
      Toxicomanias.ID_Toxicomanias,
    ];

    Actividades.actualizar(
      Databases.siteground_database_regepi,
      Toxicomanias.toxicomanias['updateQuery'],
      listOfValues,
      Toxicomanias.ID_Toxicomanias,
    ).then((value) {
      Terminal.printAlert(
          message:
              "RESPUESTA al Actualizar Toxicomanias - $listOfValues "); // ${listOfValues.length}
      if (value == "SUCCESS" || value == '"SUCCESS"') {
        Terminal.printOther(
            message: "Actualización "
                "$value - Eliminando $fileAssocieted");
        Archivos.deleteFile(filePath: fileAssocieted)
            .then((value) => consultarRegistro());
      }
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR al actualizar Toxicomanias - $error");
    });
  }

  static void registrarRegistro() {
    Actividades.registrar(
      Databases.siteground_database_regepi,
      Toxicomanias.toxicomanias['registerQuery'],
      [
        Pacientes.ID_Paciente,
        Calendarios.today(format: 'yyyy/MM/dd'),
        // ********* ******** ******* ********* ***
        Valores.esAlcoholismo,
        Valores.edadInicioAlcoholismo,
        Valores.duracionAnosAlcoholismo,
        Valores.periodicidadAlcoholismo,
        Valores.intervaloAlcoholismo,
        Valores.suspensionAlcoholismo,
        Valores.aosSuspensionAlcoholismo,
        Valores.tiposAlcoholismoDescripcion,
        // ********* ******** ******* ********* ***
        Valores.esTabaquismo,
        Valores.edadInicioTabaquismo,
        Valores.duracionAnosTabaquismo,
        Valores.periodicidadTabaquismo,
        Valores.intervaloTabaquismo,
        Valores.suspensionTabaquismo,
        Valores.aosSuspensionTabaquismo,
        Valores.tiposTabaquismoDescripcion,
        // ********* ******** ******* ********* ***
        Valores.esDrogadismo,
        Valores.edadInicioDrogadismo,
        Valores.duracionAnosDrogadismo,
        Valores.periodicidadDrogadismo,
        Valores.intervaloDrogadismo,
        Valores.suspensionDrogadismo,
        Valores.aosSuspensionDrogadismo,
        Valores.tiposDrogadismoDescripcion,
        // ********* ******** ******* ********* ***
      ],
    ).then((value) {
      Terminal.printAlert(
          message:
              "RESPUESTA al registrar Toxicomanias - $value "); // ${listOfValues.length}
      if (value == "SUCCESS" || value == '"SUCCESS"') {
        consultarRegistro();
      }
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR al registrar Toxicomanias - $error");
    });
  }

// ********* ******** ******* ********* ***
  static final Map<String, dynamic> toxicomanias = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_apnp_dro;",
    "showColumns": "SHOW columns FROM pace_apnp_dro",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_apnp_dro'",
    "createQuery": """
    CREATE TABLE pace_apnp_dro (
                      ID_PACE_APNP_DRO int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      ID_Pace int(11) NOT NULL,
                      Pace_APNP_DRO_Feca date NOT NULL,
                      Pace_APNP_DRO_alc_SINO tinyint(1) NOT NULL,
                      REGE_Pace_APNP_DRO_alc_INE int(200) NOT NULL,
                      REGE_Pace_APNP_DRO_alc_DUR int(200) NOT NULL,
                      REGE_Pace_APNP_DRO_alc_PER int(200) NOT NULL,
                      Pace_APNP_DRO_alc_DUR_PER_ varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      Pace_APNP_DRO_alc_SUS_SINO tinyint(1) NOT NULL,
                      REGE_Pace_APNP_DRO_alc_SUS int(200) NOT NULL,
                      Pace_APNP_DRO_alc_TIP varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      Pace_APNP_DRO_tab_SINO tinyint(1) NOT NULL,
                      REGE_Pace_APNP_DRO_tab_INE int(200) NOT NULL,
                      REGE_Pace_APNP_DRO_tab_DUR int(200) NOT NULL,
                      REGE_Pace_APNP_DRO_tab_PER int(200) NOT NULL,
                      Pace_APNP_DRO_tab_DUR_PER_ varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      Pace_APNP_DRO_tab_SUS_SINO tinyint(1) NOT NULL,
                      REGE_Pace_APNP_DRO_tab_SUS int(200) NOT NULL,
                      Pace_APNP_DRO_tab_TIP varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      Pace_APNP_DRO_tox_SINO tinyint(1) NOT NULL,
                      REGE_Pace_APNP_DRO_tox_INE int(200) NOT NULL,
                      REGE_Pace_APNP_DRO_tox_DUR int(200) NOT NULL,
                      REGE_Pace_APNP_DRO_tox_PER int(200) NOT NULL,
                      Pace_APNP_DRO_tox_DUR_PER_ varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      Pace_APNP_DRO_tox_SUS_SINO tinyint(1) NOT NULL,
                      REGE_Pace_APNP_DRO_tox_SUS int(200) NOT NULL,
                      Pace_APNP_DRO_tox_TIP varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                    ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8
                    COLLATE=utf8_unicode_ci
                    COMMENT='Tabla para Agregar antecedentes de Uso de Drogas Ilegales';
            """,
    "truncateQuery": "TRUNCATE pace_apnp_dro",
    "dropQuery": "DROP TABLE pace_apnp_dro",
    "consultQuery": "SELECT * FROM pace_apnp_dro",
    "consultIdQuery": "SELECT * FROM pace_apnp_dro WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_apnp_dro WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_apnp_dro",
    "consultLastQuery": "SELECT * FROM pace_apnp_dro WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM pace_apnp_dro WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO pace_apnp_dro (ID_Pace, Pace_APNP_DRO_Feca, "
        "Pace_APNP_DRO_alc_SINO, "
        "REGE_Pace_APNP_DRO_alc_INE, REGE_Pace_APNP_DRO_alc_DUR, "
        "REGE_Pace_APNP_DRO_alc_PER, Pace_APNP_DRO_alc_DUR_PER_, "
        "Pace_APNP_DRO_alc_SUS_SINO, "
        "REGE_Pace_APNP_DRO_alc_SUS, Pace_APNP_DRO_alc_TIP, "
        "Pace_APNP_DRO_tab_SINO, "
        "REGE_Pace_APNP_DRO_tab_INE, REGE_Pace_APNP_DRO_tab_DUR, "
        "REGE_Pace_APNP_DRO_tab_PER, Pace_APNP_DRO_tab_DUR_PER_, "
        "Pace_APNP_DRO_tab_SUS_SINO, "
        "REGE_Pace_APNP_DRO_tab_SUS, Pace_APNP_DRO_tab_TIP, "
        "Pace_APNP_DRO_tox_SINO, "
        "REGE_Pace_APNP_DRO_tox_INE, REGE_Pace_APNP_DRO_tox_DUR, "
        "REGE_Pace_APNP_DRO_tox_PER, Pace_APNP_DRO_tox_DUR_PER_, "
        "Pace_APNP_DRO_tox_SUS_SINO, "
        "REGE_Pace_APNP_DRO_tox_SUS, Pace_APNP_DRO_tox_TIP) "
        "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_apnp_dro "
        "SET ID_PACE_APNP_DRO = ?,  ID_Pace = ?,  Pace_APNP_DRO_Feca = ?,  "
        "Pace_APNP_DRO_alc_SINO = ?,  REGE_Pace_APNP_DRO_alc_INE = ?,  "
        "REGE_Pace_APNP_DRO_alc_DUR = ?,  REGE_Pace_APNP_DRO_alc_PER = ?,  "
        "Pace_APNP_DRO_alc_DUR_PER_ = ?,  Pace_APNP_DRO_alc_SUS_SINO = ?,  "
        "REGE_Pace_APNP_DRO_alc_SUS = ?,  Pace_APNP_DRO_alc_TIP = ?,  "
        "Pace_APNP_DRO_tab_SINO = ?,  REGE_Pace_APNP_DRO_tab_INE = ?,  "
        "REGE_Pace_APNP_DRO_tab_DUR = ?,  REGE_Pace_APNP_DRO_tab_PER = ?,  "
        "Pace_APNP_DRO_tab_DUR_PER_ = ?,  Pace_APNP_DRO_tab_SUS_SINO = ?,  "
        "REGE_Pace_APNP_DRO_tab_SUS = ?,  Pace_APNP_DRO_tab_TIP = ?,  "
        "Pace_APNP_DRO_tox_SINO = ?,  REGE_Pace_APNP_DRO_tox_INE = ?,  "
        "REGE_Pace_APNP_DRO_tox_DUR = ?,  REGE_Pace_APNP_DRO_tox_PER = ?,  "
        "Pace_APNP_DRO_tox_DUR_PER_ = ?,  Pace_APNP_DRO_tox_SUS_SINO = ?,  "
        "REGE_Pace_APNP_DRO_tox_SUS = ?,  Pace_APNP_DRO_tox_TIP = ? "
        "WHERE ID_PACE_APNP_DRO = ?",
    "deleteQuery": "DELETE FROM pace_apnp_dro WHERE ID_pace_apnp_dro = ?",
    "toxicomaniasColumns": [
      "ID_Pace",
    ],
    "toxicomaniasItems": [
      "ID_Pace",
    ],
    "toxicomaniasColums": [
      "ID Paciente",
    ],
    "toxicomaniasStats": [
      "Total_Administradores",
    ],
    "toxicomaniasStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_apnp_dro WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_apnp_dro WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_apnp_dro  WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
// ********* ******** ******* ********* ***
}

// ********* ******** ******* ********* ***   // ********* ******** ******* ********* ***
class Sexualogicos {
  static int ID_Sexualogicos = 0;
  //
  static Map<String, dynamic> Sexuales = {};

  static void ultimoRegistro() {
    Actividades.consultarId(Databases.siteground_database_regpace,
            Sexualogicos.sexuales['consultLastQuery'], Pacientes.ID_Paciente)
        .then((value) {
// Enfermedades de base del paciente, asi como las Hospitalarias.
      Sexualogicos.Sexuales = value;
    });
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            Sexualogicos.sexuales['consultIdQuery'], Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Sexualogicos = value;
    });
  }

  static final Map<String, dynamic> sexuales = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_aps;",
    "showColumns": "SHOW columns FROM pace_aps",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_aps'",
    "createQuery": """
CREATE TABLE pace_aps (
                  ID_Pace_APS_ets_ int(11) NOT NULL,
                  ID_Pace int(11) NOT NULL,
                  Pace_APS_ets_SINO varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_APS_ets varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_APS_ets_DIA varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_APS_ets_TRA_SINO varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_APS_ets_TRA varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_APS_ets_SUS_ varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_APS_ets_SUS varchar(300) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Antecedentes de Enf. de Transmision Sexual';
            """,
    "truncateQuery": "TRUNCATE pace_aps",
    "dropQuery": "DROP TABLE pace_aps",
    "consultQuery": "SELECT * FROM pace_aps",
    "consultIdQuery": "SELECT * FROM pace_aps WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_aps WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_aps",
    "consultLastQuery": "SELECT * FROM pace_aps WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM pace_aps WHERE Pace_APP_DEG LIKE '%",
    "registerQuery":
        "INSERT INTO pace_aps (ID_Pace, Pace_APS_ets_SINO, Pace_APS_ets, "
            "Pace_APS_ets_DIA, Pace_APS_ets_TRA_SINO, Pace_APS_ets_TRA, Pace_APS_ets_SUS_, "
            "Pace_APS_ets_SUS) "
            "VALUES (?,?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_aps "
        "SET ID_Pace_APS_ets_ = ?,  ID_Pace = ?,  Pace_APS_ets_SINO = ?,  Pace_APS_ets = "
        "?,  Pace_APS_ets_DIA = ?,  Pace_APS_ets_TRA_SINO = ?,  Pace_APS_ets_TRA = ?,  "
        "Pace_APS_ets_SUS_ = ?,  Pace_APS_ets_SUS = ? "
        "WHERE ID_Pace = ?",
    "deleteQuery": "DELETE FROM pace_aps WHERE ID_Pace_APS_ets_ = ?",
    "sexualesColumns": [
      "ID_Pace",
    ],
    "sexualesItems": [
      "ID_Pace",
    ],
    "sexualesColums": [
      "ID Paciente",
    ],
    "sexualesStats": [
      "Total_Administradores",
    ],
    "sexualesStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_aps WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_aps WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_aps WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
}

class Femeninologicos {
  static int ID_Femeninologicos = 0;
  //
  static Map<String, dynamic> Femeninos = {};

  // ********* ******** ******* ********* ***
  static void consultarRegistro() {
    Actividades.consultarId(Databases.siteground_database_regepi,
            Femeninologicos.femeninos['consultIdQuery'], Pacientes.ID_Paciente)
        .then((value) {
      // Asignación de Valores ********* ******** ******* ********* ***
      Femeninologicos.Femeninos = value;

      Femeninologicos.ID_Femeninologicos = value['ID_PACE_EYM'];
      Valores.prejuiciosAtencion =
          Dicotomicos.fromInt(value['Pace_EYM_xise'], toBoolean: true) as bool?;
      Valores.creenciasPaciente = value['Pace_EYM_xise_CREE'];
      Valores.valoresPaciente = value['Pace_EYM_xise_VALO'];
      Valores.costumbresPaciente = value['Pace_EYM_xise_COSU'];

      Valores.redesApoyo =
          Dicotomicos.fromInt(value['Pace_EYM_REDE'], toBoolean: true) as bool?;
      Valores.apoyoMadre =
          Dicotomicos.fromInt(value['Pace_EYM_REDE_Ma'], toBoolean: true)
              as bool?;
      Valores.apoyoPadre =
          Dicotomicos.fromInt(value['Pace_EYM_REDE_Pa'], toBoolean: true)
              as bool?;
      Valores.apoyoHermanos =
          Dicotomicos.fromInt(value['Pace_EYM_REDE_He'], toBoolean: true)
              as bool?;
      Valores.apoyoHijosMayores =
          Dicotomicos.fromInt(value['Pace_EYM_REDE_Hi'], toBoolean: true)
              as bool?;

      // // print("Valores de Femeninologicos asignado : : : $value");
    });
  }

  static void actualizarRegistro() {
    Actividades.actualizar(
      Databases.siteground_database_regepi,
      Femeninologicos.femeninos['updateQuery'],
      [
        Femeninologicos.ID_Femeninologicos,
        Pacientes.ID_Paciente,
        Valores.prejuiciosAtencion,
        Valores.creenciasPaciente,
        Valores.valoresPaciente,
        Valores.costumbresPaciente,
        Valores.redesApoyo,
        Valores.apoyoMadre,
        Valores.apoyoPadre,
        Valores.apoyoHermanos,
        Valores.apoyoHijosMayores,
        Femeninologicos.ID_Femeninologicos,
      ],
      Femeninologicos.ID_Femeninologicos,
    );
  }

  static void registrarRegistro() {
    Actividades.registrar(
      Databases.siteground_database_regepi,
      Femeninologicos.femeninos['registerQuery'],
      [
        Pacientes.ID_Paciente,
        Valores.prejuiciosAtencion,
        Valores.creenciasPaciente,
        Valores.valoresPaciente,
        Valores.costumbresPaciente,
        Valores.redesApoyo,
        Valores.apoyoMadre,
        Valores.apoyoPadre,
        Valores.apoyoHermanos,
        Valores.apoyoHijosMayores,
      ],
    );
  }

// ********* ******** ******* ********* ***

  static final Map<String, dynamic> femeninos = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_aps_femi;",
    "showColumns": "SHOW columns FROM pace_aps_femi",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_aps_femi'",
    "createQuery": """CREATE TABLE pace_aps_femi (
                      ID_PACE_APS int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      ID_Pace int(11) NOT NULL,
                      PACE_APS_Feca date NOT NULL,
                      Pace_APS_arc tinyint(1) NOT NULL,
                      REGE_Pace_APS_arc int(11) NOT NULL,
                      Pace_APS_cat_DIA int(200) NOT NULL,
                      Pace_APS_cat_CIC int(200) NOT NULL,
                      Pace_APS_pub_SINO tinyint(1) NOT NULL,
                      Pace_APS_pub int(200) NOT NULL,
                      Pace_APS_tel_SINO tinyint(1) NOT NULL,
                      REGE_Pace_APS_tel int(200) NOT NULL,
                      FEF_Pace_APS_fur date NOT NULL,
                      REGE_Pace_APS_ivs int(200) NOT NULL,
                      REGE_Pace_APS_pas int(200) NOT NULL,
                      Pace_APS_ise_ varchar(200) COLLATE utf8_unicode_520_ci NOT NULL,
                      Pace_APS_mpf_ varchar(200) COLLATE utf8_unicode_520_ci NOT NULL,
                      REGE_Pace_APS_ago_GES int(200) NOT NULL,
                      REGE_Pace_APS_ago_PAR int(200) NOT NULL,
                      REGE_Pace_APS_ago_CES int(200) NOT NULL,
                      REGE_Pace_APS_ago_ABO int(200) NOT NULL,
                      Pace_APS_ago_CLI_SINO tinyint(1) NOT NULL,
                      REGE_Pace_APS_ago_CLI int(200) NOT NULL,
                      Pace_APS_ago_MEN_ tinyint(1) NOT NULL,
                      REGE_Pace_APS_ago_MEN int(200) NOT NULL,
                      Pace_APS_ago_PAP_ tinyint(1) NOT NULL,
                      FEF_Pace_APS_ago_PAP date NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci COMMENT='Tabla para Antecedentes Gineco - Obstetricos';
            """,
    "truncateQuery": "TRUNCATE pace_aps_femi",
    "dropQuery": "DROP TABLE pace_aps_femi",
    "consultQuery": "SELECT * FROM pace_aps_femi",
    "consultIdQuery": "SELECT * FROM pace_aps_femi WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_aps_femi WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_aps_femi",
    "consultLastQuery": "SELECT * FROM pace_aps_femi WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM pace_aps_femi WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO pace_aps_femi (ID_Pace, PACE_APS_Feca, Pace_APS_arc, "
        "REGE_Pace_APS_arc, Pace_APS_cat_DIA, Pace_APS_cat_CIC, Pace_APS_pub_SINO, "
        "Pace_APS_pub, Pace_APS_tel_SINO, REGE_Pace_APS_tel, FEF_Pace_APS_fur, "
        "REGE_Pace_APS_ivs, REGE_Pace_APS_pas, Pace_APS_ise_, Pace_APS_mpf_, "
        "REGE_Pace_APS_ago_GES, REGE_Pace_APS_ago_PAR, REGE_Pace_APS_ago_CES, "
        "REGE_Pace_APS_ago_ABO, Pace_APS_ago_CLI_SINO, REGE_Pace_APS_ago_CLI, "
        "Pace_APS_ago_MEN_, REGE_Pace_APS_ago_MEN, Pace_APS_ago_PAP_, "
        "FEF_Pace_APS_ago_PAP)"
        "VALUES (?,?,?,?,?,?,?,?,?,?,"
        "?,?,?,?,?,?,?,?,?,?,"
        "?,?,?,?,?)",
    "updateQuery": "UPDATE pace_aps_femi "
        "SET ID_PACE_APS = ?, ID_Pace = ?, PACE_APS_Feca = ?, Pace_APS_arc = ?, "
        "REGE_Pace_APS_arc = ?, Pace_APS_cat_DIA = ?, Pace_APS_cat_CIC = ?, "
        "Pace_APS_pub_SINO = ?, Pace_APS_pub = ?, Pace_APS_tel_SINO = ?, "
        "REGE_Pace_APS_tel = ?, FEF_Pace_APS_fur = ?, REGE_Pace_APS_ivs = ?, "
        "REGE_Pace_APS_pas = ?, Pace_APS_ise_ = ?, Pace_APS_mpf_ = ?, "
        "REGE_Pace_APS_ago_GES = ?, REGE_Pace_APS_ago_PAR = ?, REGE_Pace_APS_ago_CES "
        "= ?, REGE_Pace_APS_ago_ABO = ?, Pace_APS_ago_CLI_SINO = ?, "
        "REGE_Pace_APS_ago_CLI = ?, Pace_APS_ago_MEN_ = ?, REGE_Pace_APS_ago_MEN = "
        "?, Pace_APS_ago_PAP_ = ?, FEF_Pace_APS_ago_PAP = ? "
        "WHERE ID_PACE_APS = ?",
    "deleteQuery": "DELETE FROM pace_aps_femi WHERE ID_PACE_APS = ?",
    "femeninosColumns": [
      "ID_Pace",
    ],
    "femeninosItems": [
      "ID_Pace",
    ],
    "femeninosColums": [
      "ID Paciente",
    ],
    "femeninosStats": [
      "Total_Administradores",
    ],
    "femeninosStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_aps_femi WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_aps_femi WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_aps_femi WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
}

class Masculinologicos {
  static int ID_Masculinologicos = 0;
  // ********* ******** ******* ********* ***
  static Map<String, dynamic> Masculinos = {};

  // ********* ******** ******* ********* ***
  static void consultarRegistro() {
    Actividades.consultarId(
            Databases.siteground_database_regepi,
            Masculinologicos.masculinos['consultIdQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      // Asignación de Valores ********* ******** ******* ********* ***
      Masculinologicos.Masculinos = value;

      Masculinologicos.ID_Masculinologicos = value['ID_PACE_EYM'];
      Valores.prejuiciosAtencion =
          Dicotomicos.fromInt(value['Pace_EYM_xise'], toBoolean: true) as bool?;
      Valores.creenciasPaciente = value['Pace_EYM_xise_CREE'];
      Valores.valoresPaciente = value['Pace_EYM_xise_VALO'];
      Valores.costumbresPaciente = value['Pace_EYM_xise_COSU'];

      Valores.redesApoyo =
          Dicotomicos.fromInt(value['Pace_EYM_REDE'], toBoolean: true) as bool?;
      Valores.apoyoMadre =
          Dicotomicos.fromInt(value['Pace_EYM_REDE_Ma'], toBoolean: true)
              as bool?;
      Valores.apoyoPadre =
          Dicotomicos.fromInt(value['Pace_EYM_REDE_Pa'], toBoolean: true)
              as bool?;
      Valores.apoyoHermanos =
          Dicotomicos.fromInt(value['Pace_EYM_REDE_He'], toBoolean: true)
              as bool?;
      Valores.apoyoHijosMayores =
          Dicotomicos.fromInt(value['Pace_EYM_REDE_Hi'], toBoolean: true)
              as bool?;

      // // print("Valores de Masculinologicos asignado : : : $value");
    });
  }

  static void actualizarRegistro() {
    Actividades.actualizar(
      Databases.siteground_database_regepi,
      Masculinologicos.masculinos['updateQuery'],
      [
        Masculinologicos.ID_Masculinologicos,
        Pacientes.ID_Paciente,
        Valores.prejuiciosAtencion,
        Valores.creenciasPaciente,
        Valores.valoresPaciente,
        Valores.costumbresPaciente,
        Valores.redesApoyo,
        Valores.apoyoMadre,
        Valores.apoyoPadre,
        Valores.apoyoHermanos,
        Valores.apoyoHijosMayores,
        Masculinologicos.ID_Masculinologicos,
      ],
      Masculinologicos.ID_Masculinologicos,
    );
  }

  static void registrarRegistro() {
    Actividades.registrar(
      Databases.siteground_database_regepi,
      Masculinologicos.masculinos['registerQuery'],
      [
        Pacientes.ID_Paciente,
        Valores.prejuiciosAtencion,
        Valores.creenciasPaciente,
        Valores.valoresPaciente,
        Valores.costumbresPaciente,
        Valores.redesApoyo,
        Valores.apoyoMadre,
        Valores.apoyoPadre,
        Valores.apoyoHermanos,
        Valores.apoyoHijosMayores,
      ],
    );
  }

// ********* ******** ******* ********* ***

  static final Map<String, dynamic> masculinos = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_aps_masc;",
    "showColumns": "SHOW columns FROM pace_aps_masc",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_aps_masc'",
    "createQuery": """
CREATE TABLE pace_aps_masc (
                      ID_PACE_APS int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      ID_Pace int(11) NOT NULL,
                      PACE_APS_Feca date NOT NULL,
                      REGE_Pace_APS_cri_SINO tinyint(1) NOT NULL,
                      Pace_APS_cri int(200) NOT NULL,
                      REGE_Pace_APS_cir_SINO tinyint(1) NOT NULL,
                      Pace_APS_cir int(200) NOT NULL,
                      REGE_Pace_APS_ivs varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      REGE_Pace_APS_pas varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      Pace_APS_ise_ varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      Pace_APS_mpf_ varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla de Antecedentes Andrologicos';
            """,
    "truncateQuery": "TRUNCATE pace_aps_masc",
    "dropQuery": "DROP TABLE pace_aps_masc",
    "consultQuery": "SELECT * FROM pace_aps_masc",
    "consultIdQuery": "SELECT * FROM pace_aps_masc WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_aps_masc WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_aps_masc",
    "consultLastQuery": "SELECT * FROM pace_aps_masc WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM pace_aps_masc WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO pace_aps_masc (ID_Pace, PACE_APS_Feca, "
        "REGE_Pace_APS_cri_SINO, Pace_APS_cri, REGE_Pace_APS_cir_SINO, Pace_APS_cir, "
        "REGE_Pace_APS_ivs, REGE_Pace_APS_pas, Pace_APS_ise_, Pace_APS_mpf_)"
        "VALUES (?,?,?,?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_aps_masc "
        "SET ID_PACE_APS = ?, ID_Pace = ?, PACE_APS_Feca = ?, REGE_Pace_APS_cri_SINO "
        "= ?, Pace_APS_cri = ?, REGE_Pace_APS_cir_SINO = ?, Pace_APS_cir = ?, "
        "REGE_Pace_APS_ivs = ?, REGE_Pace_APS_pas = ?, Pace_APS_ise_ = ?, "
        "Pace_APS_mpf_ = ? "
        "WHERE ID_PACE_APS = ?",
    "deleteQuery": "DELETE FROM pace_aps_masc WHERE ID_PACE_APS = ?",
    "masculinosColumns": [
      "ID_Pace",
    ],
    "masculinosItems": [
      "ID_Pace",
    ],
    "masculinosColums": [
      "ID Paciente",
    ],
    "masculinosStats": [
      "Total_Administradores",
    ],
    "masculinosStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_aps_masc WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_aps_masc WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_aps_masc WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
// ********* ******** ******* ********* ***
}

// ********* ******** ******* ********* ***   // ********* ******** ******* ********* ***

class Patologicos {
  static int ID_Patologicos = 0;
  static var fileAssocieted =
      '${Pacientes.localRepositoryPath}patologicos.json';
  //
  static String selectedDiagnosis = "";
  //

  static Map<String, dynamic> Degenerativos = {};

  static List<String> actualDiagno = Dicotomicos.dicotomicos();
  static List<String> actualTratamiento = Dicotomicos.dicotomicos();
  static List<String> actualSuspendido = Dicotomicos.dicotomicos();

  static void registros() {
    Actividades.consultarAllById(
            Databases.siteground_database_regpace,
            Patologicos.patologicos['consultByIdPrimaryQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      Pacientes.Patologicos = value;
      Archivos.createJsonFromMap(value,
          filePath: "${Pacientes.localRepositoryPath}patologicos.json");
    });
  }

  static void ultimoRegistro() {
    Actividades.consultarId(Databases.siteground_database_regpace,
            Patologicos.patologicos['consultLastQuery'], Pacientes.ID_Paciente)
        .then((value) {
      Patologicos.Degenerativos =
          value; // Enfermedades de base del paciente, asi como las Hospitalarias.
    });
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            Patologicos.patologicos['consultIdQuery'], Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Patologicos = value;
    });
  }

  static final Map<String, dynamic> patologicos = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_app_deg;",
    "showColumns": "SHOW columns FROM pace_app_deg",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_app_deg'",
    "createQuery": """CREATE TABLE pace_app_deg (
                        ID_PACE_APP_DEG int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                        ID_Pace int(11) NOT NULL,
                        Pace_APP_DEG_SINO tinyint(1) NOT NULL,
                        Pace_APP_DEG varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                        Pace_APP_DEG_com varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                        Pace_APP_DEG_dia int(200) NOT NULL,
                        Pace_APP_DEG_tra_SINO tinyint(1) NOT NULL,
                        Pace_APP_DEG_tra varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                        Pace_APP_DEG_sus_SINO tinyint(1) NOT NULL,
                        Pace_APP_DEG_sus varchar(200) COLLATE utf8_unicode_ci NOT NULL
                        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci 
                        COMMENT='Tabla para Antecedentes Cronico Degenerativos';
            """,
    "truncateQuery": "TRUNCATE pace_app_deg",
    "dropQuery": "DROP TABLE pace_app_deg",
    "consultQuery": "SELECT * FROM pace_app_deg",
    "consultIdQuery": "SELECT * FROM pace_app_deg WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_app_deg WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_app_deg",
    "consultLastQuery": "SELECT * FROM pace_app_deg WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM pace_app_deg WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO pace_app_deg (ID_Pace, Pace_APP_DEG_SINO, "
        "Pace_APP_DEG, Pace_APP_DEG_com, "
        "Pace_APP_DEG_dia, Pace_APP_DEG_tra_SINO, "
        "Pace_APP_DEG_tra, Pace_APP_DEG_sus_SINO, "
        "Pace_APP_DEG_sus) "
        "VALUES (?,?,?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_app_deg "
        "SET ID_PACE_APP_DEG = ?, ID_Pace = ?, "
        "Pace_APP_DEG_SINO = ?, Pace_APP_DEG = ?, "
        "Pace_APP_DEG_com = ?, Pace_APP_DEG_dia = ?, "
        "Pace_APP_DEG_tra_SINO = ?,  "
        "Pace_APP_DEG_tra = ?, Pace_APP_DEG_sus_SINO = ?, "
        "Pace_APP_DEG_sus = ? "
        "WHERE ID_PACE_APP_DEG = ?",
    "deleteQuery": "DELETE FROM pace_app_deg WHERE ID_pace_app_deg = ?",
    "vitalesColumns": [
      "ID_Pace",
    ],
    "vitalesItems": [
      "ID_Pace",
      "Nombre_Completo",
      "Apellido_Paterno",
      "Apellido_Materno",
      "Paciente",
      "Contraseña",
      "Permisos",
      "Especialización",
      "Area",
      "Estatus",
      "Anexado_por"
    ],
    "vitalesColums": [
      "ID Paciente",
      "Nombre Completo",
      "Apellido Paterno",
      "Apellido Materno",
      "Paciente",
      "Contraseña",
      "Permiso(s)",
      "Especialización",
      "Area",
      "Estatus",
      "Anexado Por"
    ],
    "vitalesStats": [
      "Total_Administradores",
      "Total_Mip",
      "Total_Mpss",
      "Total_Mg",
      "Total_Medesp",
      "Total_Tegra",
      "Total_Enfra",
      "Total_Enfesp",
      "Total_Tec",
      "Total_Secre",
      "Total_Captu",
      "Total_Inge",
      "Total_Directivos",
      "Total_Guardias",
      "Total_Logistica",
      "Total_Mantenimiento",
      "Total_Traslado_Intra",
      "otal_Traslado_Extra",
    ],
    "vitalesStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_sv WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_sv WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_sv WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
}

class Alergicos {
  static int ID_Alergicos = 0;
  static var fileAssocieted = '${Pacientes.localRepositoryPath}alergicos.json';
  //
  static String selectedDiagnosis = "";
  //

  static Map<String, dynamic> Alergias = {};

  static List<String> actualDiagno = Dicotomicos.dicotomicos();
  static List<String> actualTratamiento = Dicotomicos.dicotomicos();
  static List<String> actualSuspendido = Dicotomicos.dicotomicos();

  static void ultimoRegistro() {
    Actividades.consultarId(Databases.siteground_database_regpace,
            Alergicos.alergias['consultLastQuery'], Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Alergicos.Alergias = value;
    });
  }

  static void registros() {
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      // *********************************
      Pacientes.Alergicos = value;
    }).onError((error, stackTrace) {
      Actividades.consultarAllById(
              Databases.siteground_database_regpace,
              Alergicos.alergias['consultByIdPrimaryQuery'],
              Pacientes.ID_Paciente)
          .then((value) {
        // Asignación de Valores ********* ******** ******* ********* ***
        Pacientes.Alergicos = value;
        // ********* ******** ******* ********* ***
        Terminal.printSuccess(
            message: "Valores de Alérgicos asignado : : : $value");
        // ********* ******** ******* ********* ***
        Archivos.createJsonFromMap([value],
            filePath: "${Pacientes.localRepositoryPath}alergicos.json");
      });
    });
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            Alergicos.alergias['consultIdQuery'], Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Alergicos = value;
    });
  }

  static final Map<String, dynamic> alergias = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_app_ale;",
    "showColumns": "SHOW columns FROM pace_app_ale",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_app_ale'",
    "createQuery": """CREATE TABLE pace_app_ale (
                      ID_PACE_APP_ALE int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      ID_Pace int(11) NOT NULL,
                      Pace_APP_ALE_SINO tinyint(1) NOT NULL,
                      Pace_APP_ALE varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      Pace_APP_ALE_com varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      Pace_APP_ALE_dia int(200) NOT NULL,
                      Pace_APP_ALE_tra_SINO tinyint(1) COLLATE utf8_unicode_ci NOT NULL,
                      Pace_APP_ALE_tra varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Antecedentes Alérgicos.';
            """,
    "truncateQuery": "TRUNCATE pace_app_ale",
    "dropQuery": "DROP TABLE pace_app_ale",
    "consultQuery": "SELECT * FROM pace_app_ale",
    "consultIdQuery": "SELECT * FROM pace_app_ale WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_app_ale WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_app_ale",
    "consultLastQuery": "SELECT * FROM pace_app_ale WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM pace_app_ale WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO pace_app_ale (ID_Pace, "
        "Pace_APP_ALE_SINO, Pace_APP_ALE, Pace_APP_ALE_com, Pace_APP_ALE_dia, "
        "Pace_APP_ALE_tra_SINO, Pace_APP_ALE_tra) "
        "VALUES (?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_app_ale "
        "SET ID_PACE_APP_ALE = ?, ID_Pace = ?, "
        "Pace_APP_ALE_SINO = ?, Pace_APP_ALE = ?, "
        "Pace_APP_ALE_com = ?, "
        "Pace_APP_ALE_dia = ?, Pace_APP_ALE_tra_SINO = ?, "
        "Pace_APP_ALE_tra = ? "
        "WHERE ID_PACE_APP_ALE =?",
    "deleteQuery": "DELETE FROM pace_app_ale WHERE ID_pace_app_ale = ?",
    "alergiasColumns": [
      "ID_Pace",
    ],
    "alergiasItems": [
      "ID_Pace",
    ],
    "alergiasColums": [
      "ID Paciente",
    ],
    "alergiasStats": [
      "Total_Administradores",
    ],
    "alergiasStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_app_ale WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_app_ale WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_app_ale WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
}

class Quirurgicos {
  static int ID_Quirurgicos = 0;
  static var fileAssocieted =
      '${Pacientes.localRepositoryPath}quirurgicos.json';
  //
  static String selectedDiagnosis = "";
  //
  static Map<String, dynamic> Cirugias = {};

  static List<String> actualDiagno = Dicotomicos.dicotomicos();
  static List<String> actualTratamiento = Dicotomicos.dicotomicos();
  static List<String> actualSuspendido = Dicotomicos.dicotomicos();

  static void ultimoRegistro() {
    Actividades.consultarId(Databases.siteground_database_regpace,
            Quirurgicos.cirugias['consultLastQuery'], Pacientes.ID_Paciente)
        .then((value) {
// Enfermedades de base del paciente, asi como las Hospitalarias.
      Quirurgicos.Cirugias = value;
    });
  }

  static void registros() {
    Actividades.consultarAllById(
            Databases.siteground_database_regpace,
            Quirurgicos.cirugias['consultByIdPrimaryQuery'],
            Pacientes.ID_Paciente)
        .then((value) => Pacientes.Quirurgicos = value);
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            Quirurgicos.cirugias['consultIdQuery'], Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Quirurgicos = value;
      Archivos.createJsonFromMap(value,
          filePath: '${Pacientes.localRepositoryPath}quirurgicos.json');
    });
  }

  static final Map<String, dynamic> cirugias = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_app_qui;",
    "showColumns": "SHOW columns FROM pace_app_qui",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_app_qui'",
    "createQuery": """CREATE TABLE pace_app_qui (
                      ID_PACE_APP_QUI int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      ID_Pace int(11) NOT NULL,
                      Pace_APP_QUI_SINO tinyint(1) NOT NULL,
                      Pace_APP_QUI varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      Pace_APP_QUI_dia int(200) NOT NULL,
                      Pace_APP_QUI_com_SINO tinyint(1) NOT NULL,
                      Pace_APP_QUI_com varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Antecedentes Quirurgicos.';
            """,
    "truncateQuery": "TRUNCATE pace_app_qui",
    "dropQuery": "DROP TABLE pace_app_qui",
    "consultQuery": "SELECT * FROM pace_app_qui",
    "consultIdQuery": "SELECT * FROM pace_app_qui WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_app_qui WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_app_qui",
    "consultLastQuery": "SELECT * FROM pace_app_qui WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM pace_app_qui WHERE Pace_APP_DEG LIKE '%",
    "registerQuery":
        "INSERT INTO pace_app_qui (ID_Pace, Pace_APP_QUI_SINO, Pace_APP_QUI, "
            "Pace_APP_QUI_dia, Pace_APP_QUI_com_SINO, Pace_APP_QUI_com) "
            "VALUES (?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_app_qui "
        "SET ID_PACE_APP_QUI = ?, ID_Pace = ?, Pace_APP_QUI_SINO = ?, Pace_APP_QUI = ?, "
        "Pace_APP_QUI_dia = ?, Pace_APP_QUI_com_SINO = ?, Pace_APP_QUI_com = ? "
        "WHERE ID_PACE_APP_QUI =?",
    "deleteQuery": "DELETE FROM pace_app_qui WHERE ID_pace_app_qui = ?",
    "cirugiasColumns": [
      "ID_Pace",
    ],
    "cirugiasItems": [
      "ID_Pace",
    ],
    "cirugiasColums": [
      "ID Paciente",
    ],
    "cirugiasStats": [
      "Total_Administradores",
    ],
    "cirugiasStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_app_qui WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_app_qui WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_app_qui WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
}

class Transfusionales {
  static int ID_Transfusionales = 0;
  static var fileAssocieted =
      '${Pacientes.localRepositoryPath}transfusionales.json';
  //
  static String selectedDiagnosis = "";
  //

  static Map<String, dynamic> Transfusiones = {};

  static List<String> actualDiagno = Dicotomicos.dicotomicos();
  static List<String> actualTratamiento = Dicotomicos.dicotomicos();
  static List<String> actualSuspendido = Dicotomicos.dicotomicos();

  static void ultimoRegistro() {
    Actividades.consultarId(
            Databases.siteground_database_regpace,
            Transfusionales.transfusiones['consultLastQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
// Enfermedades de base del paciente, asi como las Hospitalarias.
      Transfusionales.Transfusiones = value;
    });
  }

  static void registros() {
    Actividades.consultarAllById(
            Databases.siteground_database_regpace,
            Transfusionales.transfusiones['consultByIdPrimaryQuery'],
            Pacientes.ID_Paciente)
        .then((value) => Pacientes.Transfusionales = value);
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(
            Databases.siteground_database_regpace,
            Transfusionales.transfusiones['consultIdQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Transfusionales = value;
    });
  }

  static final Map<String, dynamic> transfusiones = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_app_tra;",
    "showColumns": "SHOW columns FROM pace_app_tra",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_app_tra'",
    "createQuery": """CREATE TABLE pace_app_tra (
                      ID_PACE_APP_TRA int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      ID_Pace int(11) NOT NULL,
                      Pace_APP_TRA_SINO tinyint(1) NOT NULL,
                      Pace_APP_TRA varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      Pace_APP_TRA_dia int(11) NOT NULL,
                      Pace_APP_TRA_com_SINO tinyint(1) NOT NULL,
                      Pace_APP_TRA_com varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Antecedentes Transfusionales.';
            """,
    "truncateQuery": "TRUNCATE pace_app_tra",
    "dropQuery": "DROP TABLE pace_app_tra",
    "consultQuery": "SELECT * FROM pace_app_tra",
    "consultIdQuery": "SELECT * FROM pace_app_tra WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_app_tra WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_app_tra",
    "consultLastQuery": "SELECT * FROM pace_app_tra WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM pace_app_tra WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO pace_app_tra (ID_Pace, Pace_APP_TRA_SINO, "
        "Pace_APP_TRA, Pace_APP_TRA_dia, Pace_APP_TRA_com_SINO, "
        "Pace_APP_TRA_com) "
        "VALUES (?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_app_tra "
        "SET ID_PACE_APP_TRA = ?, ID_Pace = ?, Pace_APP_TRA_SINO = ?, "
        "Pace_APP_TRA = ?, Pace_APP_TRA_dia = ?, "
        "Pace_APP_TRA_com_SINO = ?, Pace_APP_TRA_com = ? "
        "WHERE ID_PACE_APP_TRA = ?",
    "deleteQuery": "DELETE FROM pace_app_tra WHERE ID_pace_app_tra = ?",
    "transfusionesColumns": [
      "ID_Pace",
    ],
    "transfusionesItems": [
      "ID_Pace",
    ],
    "transfusionesColums": [
      "ID Paciente",
    ],
    "transfusionesStats": [
      "Total_Administradores",
    ],
    "transfusionesStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_app_tra WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_app_tra WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_app_tra WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
}

class Traumatologicos {
  static int ID_Traumatologicos = 0;
  //
  static String selectedDiagnosis = "";
  //

  static Map<String, dynamic> Traumaticos = {};

  static List<String> actualDiagno = Dicotomicos.dicotomicos();
  static List<String> actualTratamiento = Dicotomicos.dicotomicos();
  static List<String> actualSuspendido = Dicotomicos.dicotomicos();

  static void ultimoRegistro() {
    Actividades.consultarId(
            Databases.siteground_database_regpace,
            Traumatologicos.traumaticos['consultLastQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
// Enfermedades de base del paciente, asi como las Hospitalarias.
      Traumatologicos.Traumaticos = value;
    });
  }

  static void registros() {
    Actividades.consultarAllById(
            Databases.siteground_database_regpace,
            Traumatologicos.traumaticos['consultByIdPrimaryQuery'],
            Pacientes.ID_Paciente)
        .then((value) => Pacientes.Traumatologicos = value);
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(
            Databases.siteground_database_regpace,
            Traumatologicos.traumaticos['consultIdQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Traumatologicos = value;
    });
  }

  static final Map<String, dynamic> traumaticos = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_app_inf;",
    "showColumns": "SHOW columns FROM pace_app_inf",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_app_inf'",
    "createQuery": """CREATE TABLE pace_app_inf (
                      ID_PACE_APP_INF int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      ID_Pace int(11) NOT NULL,
                      Pace_APP_INF_SINO tinyint(1) NOT NULL,
                      Pace_APP_INF varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      Pace_APP_INF_dia int(11) NOT NULL,
                      Pace_APP_INF_tra varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Antecedentes Enfermedades de la Infancia';
            """,
    "truncateQuery": "TRUNCATE pace_app_inf",
    "dropQuery": "DROP TABLE pace_app_inf",
    "consultQuery": "SELECT * FROM pace_app_inf",
    "consultIdQuery": "SELECT * FROM pace_app_inf WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_app_inf WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_app_inf",
    "consultLastQuery": "SELECT * FROM pace_app_inf WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM pace_app_inf WHERE Pace_APP_DEG LIKE '%",
    "registerQuery":
        "INSERT INTO pace_app_inf (ID_PACE_APP_INF, ID_Pace, Pace_APP_INF_SINO, "
            "Pace_APP_INF, Pace_APP_INF_dia, Pace_APP_INF_tra) "
            "VALUES (?,?,?,?,?)",
    "updateQuery": "UPDATE pace_app_inf "
        "SET ID_PACE_APP_INF = ?, ID_Pace = ?, Pace_APP_INF_SINO = ?, Pace_APP_INF = ?, "
        "Pace_APP_INF_dia = ?, Pace_APP_INF_tra = ? "
        "WHERE ID_PACE_APP_INF = ?",
    "deleteQuery": "DELETE FROM pace_app_inf WHERE ID_pace_app_inf = ?",
    "traumaticosColumns": [
      "ID_Pace",
    ],
    "traumaticosItems": [
      "ID_Pace",
    ],
    "traumaticosColums": [
      "ID Paciente",
    ],
    "traumaticosStats": [
      "Total_Administradores",
    ],
    "traumaticosStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_app_inf WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_app_inf WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_app_inf WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
}

class Antirretrovirales {
  static int ID_Antirretrovirales = 0;
  //
  static String selectedDiagnosis = "";
  //

  static Map<String, dynamic> Antirretroviral = {};

  static List<String> actualDiagno = Dicotomicos.dicotomicos();
  static List<String> actualTratamiento = Dicotomicos.dicotomicos();
  static List<String> actualSuspendido = Dicotomicos.dicotomicos();

  static void ultimoRegistro() {
    Actividades.consultarId(
            Databases.siteground_database_regpace,
            Antirretrovirales.antirretroviral['consultLastQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
// Enfermedades de base del paciente, asi como las Hospitalarias.
      Antirretrovirales.Antirretroviral = value;
    });
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(
            Databases.siteground_database_regpace,
            Antirretrovirales.antirretroviral['consultIdQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Antirretrovirales = value;
    });
  }

  static final Map<String, dynamic> antirretroviral = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_aps;",
    "showColumns": "SHOW columns FROM pace_aps",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_aps'",
    "createQuery": """CREATE TABLE pace_tar (
                  ID_TAR int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  ID_Pace int(11) NOT NULL,
                  TARactu tinyint(1) NOT NULL,
                  Pace_Fe_TAR date NOT NULL,
                  Pace_Ca_TAR date NOT NULL,
                  Pace_TAR varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Mov_TAR varchar(300) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Agregar Datos de Antirretrovirales';
            """,
    "truncateQuery": "TRUNCATE pace_aps",
    "dropQuery": "DROP TABLE pace_aps",
    "consultQuery": "SELECT * FROM pace_aps",
    "consultIdQuery": "SELECT * FROM pace_aps WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_aps WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_aps",
    "consultLastQuery": "SELECT * FROM pace_aps WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM pace_aps WHERE Pace_APP_DEG LIKE '%",
    "registerQuery":
        "INSERT INTO pace_tar (ID_Pace, TARactu, Pace_Fe_TAR, Pace_Ca_TAR, Pace_TAR, Pace_Mov_TAR) "
            "VALUES (?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_tar "
        "SET ID_TAR = ?, ID_Pace = ?, TARactu = ?, "
        "Pace_Fe_TAR = ?, Pace_Ca_TAR = ?, "
        "Pace_TAR = ?, Pace_Mov_TAR = ? "
        "WHERE ID_TAR = ?",
    "deleteQuery": "DELETE FROM pace_aps WHERE ID_TAR = ?",
    "antirretroviralColumns": [
      "ID_Pace",
    ],
    "antirretroviralItems": [
      "ID_Pace",
    ],
    "antirretroviralColums": [
      "ID Paciente",
    ],
    "antirretroviralStats": [
      "Total_Administradores",
    ],
    "antirretroviralStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_aps WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_aps WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_aps WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
}

class Vihs {
  static int ID_Vihs = 0;
  //
  static String selectedDiagnosis = "";
  //

  static Map<String, dynamic> Vih = {};

  static List<String> actualDiagno = Dicotomicos.dicotomicos();
  static List<String> actualTratamiento = Dicotomicos.dicotomicos();
  static List<String> actualSuspendido = Dicotomicos.dicotomicos();

  static void ultimoRegistro() {
    Actividades.consultarId(Databases.siteground_database_regpace,
            Vihs.vih['consultLastQuery'], Pacientes.ID_Paciente)
        .then((value) {
// Enfermedades de base del paciente, asi como las Hospitalarias.
      Vihs.Vih = value;
    });
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            Vihs.vih['consultIdQuery'], Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Vihs = value;
    });
  }

  static final Map<String, dynamic> vih = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_tar_vih;",
    "showColumns": "SHOW columns FROM pace_tar_vih",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_tar_vih'",
    "createQuery": """CREATE TABLE pace_tar_vih (
                  ID_TARVIH int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  ID_Pace int(10) NOT NULL,
                  Pace_DIA_VIH date NOT NULL,
                  Pace_CRIBAMO varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_CDC_DIA varchar(10) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_Fese_TAR date NOT NULL,
                  Pace_Fe_TAR date NOT NULL,
                  Rede_TAR_SINO tinyint(1) NOT NULL,
                  Pace_TAR_EMBA tinyint(1) NOT NULL,
                  Pace_No_TAR int(10) NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Agregar Datos de Retrovirosis';
            """,
    "truncateQuery": "TRUNCATE pace_tar_vih",
    "dropQuery": "DROP TABLE pace_tar_vih",
    "consultQuery": "SELECT * FROM pace_tar_vih",
    "consultIdQuery": "SELECT * FROM pace_tar_vih WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_tar_vih WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_tar_vih",
    "consultLastQuery": "SELECT * FROM pace_tar_vih WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM pace_tar_vih WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO pace_tar_vih (ID_Pace, "
        "Pace_DIA_VIH, Pace_CRIBAMO, "
        "Pace_CDC_DIA, Pace_Fese_TAR, "
        "Pace_Fe_TAR, Rede_TAR_SINO, "
        "Pace_TAR_EMBA, Pace_No_TAR) "
        "VALUES (?,?,?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_tar_vih "
        "SET ID_TARVIH = ?, ID_Pace = ?, Pace_DIA_VIH = ?, "
        "Pace_CRIBAMO = ?, Pace_CDC_DIA = ?, "
        "Pace_Fese_TAR = ?, Pace_Fe_TAR = ?, "
        "Rede_TAR_SINO = ?, Pace_TAR_EMBA = ?, "
        "Pace_No_TAR = ? "
        "WHERE ID_TARVIH = ?",
    "deleteQuery": "DELETE FROM pace_tar_vih WHERE ID_PACE_APP_DEG = ?",
    "vihColumns": [
      "ID_Pace",
    ],
    "vihItems": [
      "ID_Pace",
    ],
    "vihColums": [
      "ID Paciente",
    ],
    "vihStats": [
      "Total_Administradores",
    ],
    "vihStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_tar_vih WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_tar_vih WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_tar_vih WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
}

class Embarazos {
  static int ID_Embarazos = 0;
  //
  static String selectedDiagnosis = "";
  //

  static Map<String, dynamic> Embarazo = {};

  static List<String> actualDiagno = Dicotomicos.dicotomicos();
  static List<String> actualTratamiento = Dicotomicos.dicotomicos();
  static List<String> actualSuspendido = Dicotomicos.dicotomicos();

  static void ultimoRegistro() {
    Actividades.consultarId(Databases.siteground_database_regpace,
            Embarazos.embarazo['consultLastQuery'], Pacientes.ID_Paciente)
        .then((value) {
// Enfermedades de base del paciente, asi como las Hospitalarias.
      Embarazos.Embarazo = value;
    });
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            Embarazos.embarazo['consultIdQuery'], Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Embarazos = value;
    });
  }

  static final Map<String, dynamic> embarazo = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_tar_embarazo;",
    "showColumns": "SHOW columns FROM pace_tar_embarazo",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_tar_embarazo'",
    "createQuery": """CREATE TABLE pace_emba (
                  ID_Pace_EMB int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  ID_Pace int(10) NOT NULL,
                  ID_Gestacion int(10) NOT NULL,
                  Pace_Feca_EMB date NOT NULL,
                  Pace_Feca_FUR date NOT NULL,
                  Pace_EMB_fpp varchar(20) NOT NULL,
                  Pace_EMB_c_sit_fet int(10) NOT NULL,
                  Pace_EMB_afu int(10) NOT NULL,
                  Pace_EMB_pfe double NOT NULL,
                  Pace_EMB_c_johnson double NOT NULL,
                  Pace_EMB_fcf int(10) NOT NULL,
                  Pace_EMB_gmp varchar(20) NOT NULL,
                  Pace_EMB_dbp double NOT NULL, 
                  Pace_EMB_cc double NOT NULL, 
                  Pace_EMB_ca double NOT NULL, 
                  Pace_EMB_lfe double NOT NULL, 
                  Pace_EMB_phelan double NOT NULL, 
                  Pace_EMB_pfe_usg double NOT NULL 
                ) ENGINE=InnoDB AUTO_INCREMENT=1 
                DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Agregar Registros de Embarazos del Paciente.';
            """,
    "truncateQuery": "TRUNCATE pace_tar_embarazo",
    "dropQuery": "DROP TABLE pace_tar_embarazo",
    "consultQuery": "SELECT * FROM pace_tar_embarazo",
    "consultIdQuery": "SELECT * FROM pace_tar_embarazo WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery":
        "SELECT * FROM pace_tar_embarazo WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_tar_embarazo",
    "consultLastQuery": "SELECT * FROM pace_tar_embarazo WHERE ID_Pace = ?",
    "consultByName":
        "SELECT * FROM pace_tar_embarazo WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO pace_emba (ID_Pace, ID_Gestacion, "
        "Pace_Feca_EMB, Pace_Feca_FUR, Pace_EMB_fpp, "
        "Pace_EMB_c_sit_fet, "
        "Pace_EMB_afu, Pace_EMB_pfe, Pace_EMB_c_johnson, "
        "Pace_EMB_fcf, Pace_EMB_gmp, Pace_EMB_dbp, "
        "Pace_EMB_cc, Pace_EMB_ca, "
        "Pace_EMB_lfe, Pace_EMB_phelan, Pace_EMB_pfe_usg) "
        "VALUES (?,?,?,?,?,?,?,?,?,?,"
        "?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_emba "
        "SET ID_Pace_EMB = ?, ID_Pace = ?, ID_Gestacion = ?, "
        "Pace_Feca_EMB = ?, Pace_Feca_FUR = ?, "
        "Pace_EMB_fpp = ?, Pace_EMB_c_sit_fet = "
        "?, Pace_EMB_afu = ?, Pace_EMB_pfe = ?, "
        "Pace_EMB_c_johnson = ?, Pace_EMB_fcf = ?, Pace_EMB_gmp = "
        "?, Pace_EMB_dbp = ?, "
        "Pace_EMB_cc = ?, Pace_EMB_ca = ?, "
        "Pace_EMB_lfe = ?, Pace_EMB_phelan = ?, Pace_EMB_pfe_usg = ? "
        "WHERE ID_Pace_EMB =?",
    "deleteQuery": "DELETE FROM pace_tar_embarazo WHERE ID_Pace_EMB = ?",
    "embarazoColumns": [
      "ID_Pace",
    ],
    "embarazoItems": [
      "ID_Pace",
    ],
    "embarazoColums": [
      "ID Paciente",
    ],
    "embarazoStats": [
      "Total_Administradores",
    ],
    "embarazoStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_tar_embarazo WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_tar_embarazo WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_tar_embarazo WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
}

class Vitales {
  static int ID_Vitales = 0;
  static var fileAssocieted = '${Pacientes.localRepositoryPath}vitales.json';

  static void ultimoRegistro() {
    Actividades.consultarId(Databases.siteground_database_regpace,
            Vitales.vitales['consultLastQuery'], Pacientes.ID_Paciente)
        .then((value) {
      Pacientes.Vital = value;
      Actividades.consultarId(Databases.siteground_database_regpace,
              Vitales.antropo['consultLastQuery'], Pacientes.ID_Paciente)
          .then((value) {
        Pacientes.Vital.addAll(value);
      });
    });
  }

  static void registros() {
    List result = [];
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            vitales['consultByIdPrimaryQuery'], Pacientes.ID_Paciente)
        .then((value) {
      result.addAll(value);
      Actividades.consultarAllById(Databases.siteground_database_regpace,
              antropo['consultByIdPrimaryQuery'], Pacientes.ID_Paciente)
          .then((value) {
        int index = 0;
        for (var item in result) {
          if (index <= result.length) {
            var thirdMap = {};
            // // print("${value.length} ${result.length}");
            // // print("${value[index]['ID_Pace_SV']} ${item['ID_Pace_SV']}");
            thirdMap.addAll(item);
            thirdMap.addAll(value[index]);
            // Adición a Vitales ********** ************ ************** ********
            Pacientes.Vitales!.add(thirdMap);
            index++;
          }
        }
        // Terminal.printExpected(message: "${Pacientes.Vitales!}");
        Archivos.createJsonFromMap(Pacientes.Vitales!,
            filePath: fileAssocieted);
      });
    });
  }

  static final Map<String, dynamic> vitales = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_sv;",
    "showColumns": "SHOW columns FROM pace_sv",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_sv'",
    "createQuery": """CREATE TABLE pace_sv (
              ID_Pace_SV int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              ID_Pace int(10) NOT NULL,
              Pace_Feca_SV date NOT NULL,
              Pace_SV_tas int(10) NOT NULL,
              Pace_SV_tad int(10) NOT NULL,
              Pace_SV_fc int(10) NOT NULL,
              Pace_SV_fr int(10) NOT NULL,
              Pace_SV_tc double NOT NULL,
              Pace_SV_spo int(10) NOT NULL,
              Pace_SV_est double NOT NULL,
              Pace_SV_pct double NOT NULL, 
              Pace_SV_glu double NOT NULL, 
              Pace_SV_glu_ayu double NOT NULL
            ) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Agregar Signos Vitales del Paciente.';""",
    "truncateQuery": "TRUNCATE pace_sv",
    "dropQuery": "DROP TABLE pace_sv",
    "consultQuery": "SELECT * FROM pace_sv",
    "consultIdQuery": "SELECT * FROM pace_sv WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_sv WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_sv",
    "consultLastQuery":
        "SELECT * FROM pace_sv WHERE ID_Pace = ? ORDER BY Pace_Feca_SV DESC LIMIT 1",
    "consultByName": "SELECT * FROM pace_sv WHERE Pace_Feca_SV LIKE '%",
    "registerQuery":
        "INSERT INTO pace_sv (ID_Pace, Pace_Feca_SV, Pace_SV_tas, Pace_SV_tad, "
            "Pace_SV_fc, Pace_SV_fr, Pace_SV_tc, Pace_SV_spo, Pace_SV_est, Pace_SV_pct, "
            "Pace_SV_glu, Pace_SV_glu_ayu) "
            "VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_sv "
        "SET ID_Pace_SV = ?, ID_Pace = ?, Pace_Feca_SV = ?, Pace_SV_tas = ?, Pace_SV_tad = ?, "
        "Pace_SV_fc = ?, Pace_SV_fr = ?, Pace_SV_tc = ?, Pace_SV_spo = ?, "
        "Pace_SV_est = ?, Pace_SV_pct = ?, "
        "Pace_SV_glu = ?, Pace_SV_glu_ayu = ? "
        "WHERE ID_Pace_SV = ?",
    "deleteQuery": "DELETE FROM pace_sv WHERE ID_Pace_SV = ?",
    "vitalesColumns": [
      "ID_Pace",
    ],
    "vitalesItems": [
      "ID_Pace",
      "Nombre_Completo",
      "Apellido_Paterno",
      "Apellido_Materno",
      "Paciente",
      "Contraseña",
      "Permisos",
      "Especialización",
      "Area",
      "Estatus",
      "Anexado_por"
    ],
    "vitalesColums": [
      "ID Paciente",
      "Nombre Completo",
      "Apellido Paterno",
      "Apellido Materno",
      "Paciente",
      "Contraseña",
      "Permiso(s)",
      "Especialización",
      "Area",
      "Estatus",
      "Anexado Por"
    ],
    "vitalesStats": [
      "Total_Administradores",
      "Total_Mip",
      "Total_Mpss",
      "Total_Mg",
      "Total_Medesp",
      "Total_Tegra",
      "Total_Enfra",
      "Total_Enfesp",
      "Total_Tec",
      "Total_Secre",
      "Total_Captu",
      "Total_Inge",
      "Total_Directivos",
      "Total_Guardias",
      "Total_Logistica",
      "Total_Mantenimiento",
      "Total_Traslado_Intra",
      "otal_Traslado_Extra",
    ],
    "sistolicas":
        "SELECT Pace_Feca_SV, Pace_SV_tas FROM pace_sv WHERE ID_Pace = '${Pacientes.ID_Paciente}' ORDER BY Pace_Feca_SV ASC;",
    "diastolicas":
        "SELECT Pace_Feca_SV, Pace_SV_tad FROM pace_sv WHERE ID_Pace = '${Pacientes.ID_Paciente}' ORDER BY Pace_Feca_SV ASC;",
    "cardiacas":
        "SELECT Pace_Feca_SV, Pace_SV_fc FROM pace_sv WHERE ID_Pace = '${Pacientes.ID_Paciente}' ORDER BY Pace_Feca_SV ASC;",
    "respiratorias":
        "SELECT Pace_Feca_SV, Pace_SV_fr FROM pace_sv WHERE ID_Pace = '${Pacientes.ID_Paciente}' ORDER BY Pace_Feca_SV ASC;",
    "temperaturas":
        "SELECT Pace_Feca_SV, Pace_SV_tc FROM pace_sv WHERE ID_Pace = '${Pacientes.ID_Paciente}' ORDER BY Pace_Feca_SV ASC;",
    "oxigenacion":
        "SELECT Pace_Feca_SV, Pace_SV_spo FROM pace_sv WHERE ID_Pace = '${Pacientes.ID_Paciente}' ORDER BY Pace_Feca_SV ASC;",
    "vitalesStadistics": "SELECT "
        "(SELECT IFNULL(AVG(Pace_SV_tas), 0) FROM pace_sv WHERE ID_Pace = :id) as Promedio_TAS,"
        "(SELECT IFNULL(AVG(Pace_SV_tad), 0) FROM pace_sv WHERE ID_Pace = :id) as Promedio_TAD,"
        "(SELECT IFNULL(AVG(Pace_SV_fc), 0) FROM pace_sv WHERE ID_Pace = :id) as Promedio_FC,"
        "(SELECT IFNULL(AVG(Pace_SV_fr), 0) FROM pace_sv WHERE ID_Pace = :id) as Promedio_FR,"
        "(SELECT IFNULL(count(*), 0) FROM pace_sv WHERE ID_Pace = :id) as Total_Registros;"
  };
  static final Map<String, dynamic> antropo = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_antropo;",
    "showColumns": "SHOW columns FROM pace_antropo",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_antropo'",
    "createQuery": """CREATE TABLE pace_antropo (
              ID_Pace_SV int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              ID_Pace int(10) NOT NULL,
              Pace_Feca_SV date NOT NULL,
              Pace_SV_cue double NOT NULL,
              Pace_SV_cin double NOT NULL,
              Pace_SV_cad double NOT NULL,
              Pace_SV_cmb double NOT NULL,
              Pace_SV_pct double NOT NULL,
              Pace_SV_fa double NOT NULL,
              Pace_SV_fe double NOT NULL,
              Pace_SV_pcb double NOT NULL,
              Pace_SV_pse double NOT NULL,
              Pace_SV_psi double NOT NULL,
              Pace_SV_pst double NOT NULL, 
              Pace_SV_c_pect double NOT NULL,
              Pace_SV_c_fem_izq double NOT NULL,
              Pace_SV_c_fem_der double NOT NULL,
              Pace_SV_c_fem_izq, double NOT NULL,
              Pace_SV_c_suro_der double NOT NULL
            ) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Agregar Signos Vitales del Paciente.';""",
    "truncateQuery": "TRUNCATE pace_antropo",
    "dropQuery": "DROP TABLE pace_antropo",
    "consultQuery": "SELECT * FROM pace_antropo",
    "consultIdQuery": "SELECT * FROM pace_antropo WHERE ID_Pace_SV = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_antropo WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_antropo",
    "consultLastQuery":
        "SELECT * FROM pace_antropo WHERE ID_Pace = ? ORDER BY Pace_Feca_SV DESC LIMIT 1",
    "consultByName": "SELECT * FROM pace_antropo WHERE Pace_Feca_SV LIKE '%",
    "registerQuery":
        "INSERT INTO pace_antropo (ID_Pace, Pace_Feca_SV, Pace_SV_cue, "
            "Pace_SV_cin, "
            "Pace_SV_cad, Pace_SV_cmb, Pace_SV_pct, Pace_SV_fa, Pace_SV_fe, "
            "Pace_SV_pcb, "
            "Pace_SV_pse, Pace_SV_psi, Pace_SV_pst, "
            "Pace_SV_c_pect, "
            "Pace_SV_c_fem_der, Pace_SV_c_fem_izq, "
            "Pace_SV_c_suro_der, Pace_SV_c_suro_izq) "
            "VALUES (?,?,?,?,?,?,?,?,?,?,"
            "?,?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_antropo "
        "SET ID_Pace_SV = ?, ID_Pace = ?, Pace_Feca_SV = ?, "
        "Pace_SV_cue = ?, Pace_SV_cin = ?, Pace_SV_cad = ?, "
        "Pace_SV_cmb = ?, Pace_SV_pct = ?, Pace_SV_fa = ?, "
        "Pace_SV_fe = ?, Pace_SV_pcb = ?, Pace_SV_pse = ?, "
        "Pace_SV_psi = ?, Pace_SV_pst = ?, "
        "Pace_SV_c_pect = ?, "
        "Pace_SV_c_fem_der = ?, Pace_SV_c_fem_izq = ?, "
        "Pace_SV_c_suro_der = ?, Pace_SV_c_suro_izq = ? "
        "WHERE ID_Pace_SV = ?",
    "deleteQuery": "DELETE FROM pace_antropo WHERE ID_Pace_SV = ?",
    "antropoColumns": [
      "ID_Pace",
    ],
    "antropoItems": [
      "ID_Pace",
      "Nombre_Completo",
      "Apellido_Paterno",
      "Apellido_Materno",
      "Paciente",
      "Contraseña",
      "Permisos",
      "Especialización",
      "Area",
      "Estatus",
      "Anexado_por"
    ],
    "antropoColums": [
      "ID Paciente",
      "Nombre Completo",
      "Apellido Paterno",
      "Apellido Materno",
      "Paciente",
      "Contraseña",
      "Permiso(s)",
      "Especialización",
      "Area",
      "Estatus",
      "Anexado Por"
    ],
    "antropoStats": [
      "Total_Administradores",
      "Total_Mip",
      "Total_Mpss",
      "Total_Mg",
      "Total_Medesp",
      "Total_Tegra",
      "Total_Enfra",
      "Total_Enfesp",
      "Total_Tec",
      "Total_Secre",
      "Total_Captu",
      "Total_Inge",
      "Total_Directivos",
      "Total_Guardias",
      "Total_Logistica",
      "Total_Mantenimiento",
      "Total_Traslado_Intra",
      "otal_Traslado_Extra",
    ],
    "antropoStadistics": "SELECT "
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE Pace_Ses = '${Pacientes.Sexo[0]}') as Total_Mujeres,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE Pace_Ses = '${Pacientes.Sexo[1]}') as Total_Hombres,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE Pace_Hosp_Real = '${Pacientes.Atencion[0]}') as Total_Hospitalizacion,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE Pace_Hosp_Real = '${Pacientes.Atencion[1]}') as Total_Consulta,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE Pace_Turo = '${Pacientes.Turno[0]}') as Total_Matutino,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE Pace_Turo = '${Pacientes.Turno[1]}') as Total_Vespertino,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE Pace_Stat = '${Pacientes.Vivo[0]}') as Total_Vivos,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE Pace_Stat = '${Pacientes.Vivo[1]}') as Total_Fallecidos,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE IndiIdio_Pace_SiNo = '${Pacientes.Indigena[0]}') as Total_Hablantes,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE IndiIdio_Pace_SiNo = '${Pacientes.Indigena[1]}') as Total_No_Hablantes,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE IndiIdio_Pace_SiNo = '${Pacientes.lenguaIndigena[0]}') as Total_Hablantes,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE IndiIdio_Pace_SiNo = '${Pacientes.lenguaIndigena[1]}') as Total_No_Hablantes,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo) as Total_Pacientes;"
  };

  static final List<String> factorActividad = ["0.9", "1", "1.2", "3", "5"];
  static final List<String> factorEstres = ["0.9", "1", "1.2", "3", "5"];

  static List<String> Categorias = [
    'Promedio de TAS',
    'Promedio de TAD',
    'Promedio de FC',
    'Promedio de FR',
    'Total de Registros'
  ];

  static void fromJson(Map<dynamic, dynamic> json) {
    // Pacientes.Vital = json;

    ID_Vitales = json['ID_Pace_SV'];

    Valores.fechaVitales = json['Pace_Feca_SV'].toString();
    // Variables Vitales ********* *************** **********
    Valores.tensionArterialSystolica =
        int.parse(json['Pace_SV_tas'].toString());
    //
    Valores.tensionArterialDyastolica =
        int.parse(json['Pace_SV_tad'].toString());
    //
    Valores.frecuenciaCardiaca = int.parse(json['Pace_SV_fc'].toString());
    //
    Valores.frecuenciaRespiratoria = int.parse(json['Pace_SV_fr'].toString());
    //
    Valores.temperaturCorporal = double.parse(json['Pace_SV_tc'].toString());
    //
    Valores.saturacionPerifericaOxigeno =
        int.parse(json['Pace_SV_spo'].toString());
    //
    Valores.alturaPaciente = double.parse(json['Pace_SV_est'].toString());
    //
    Valores.pesoCorporalTotal = double.parse(json['Pace_SV_pct'].toString());
    //
    Valores.glucemiaCapilar = int.parse(json['Pace_SV_glu'].toString());
    //
    Valores.horasAyuno = int.parse(json['Pace_SV_glu_ayu'].toString());
    //
    // Variables Antropométricas ********* *************** **********
    Valores.circunferenciaCuello = int.parse(json['Pace_SV_cue'].toString());
    //
    Valores.circunferenciaCintura = int.parse(json['Pace_SV_cin'].toString());
    //
    Valores.circunferenciaCadera = int.parse(json['Pace_SV_cad'].toString());
    //
    Valores.circunferenciaMesobraquial =
        int.parse(json['Pace_SV_cmb'].toString());
    //

    Valores.factorActividad = double.parse(json['Pace_SV_fa'].toString());
    //
    Valores.factorEstres = double.parse(json['Pace_SV_fe'].toString());
    //

    // Circunferencias y Pliegues ************ ****************** *************
    Valores.circunferenciaPectoral =
        int.parse(json['Pace_SV_c_pect'].toString());
    Valores.pliegueCutaneoBicipital = int.parse(json['Pace_SV_pcb'].toString());
    Valores.pliegueCutaneoEscapular = int.parse(json['Pace_SV_pse'].toString());
    Valores.pliegueCutaneoIliaco = int.parse(json['Pace_SV_psi'].toString());
    Valores.pliegueCutaneoTricipital =
        int.parse(json['Pace_SV_pst'].toString());
    Valores.circunferenciaFemoralIzquierda =
        int.parse(json['Pace_SV_c_fem_izq'].toString());
    Valores.circunferenciaFemoralDerecha =
        int.parse(json['Pace_SV_c_fem_der'].toString());
    Valores.circunferenciaSuralIzquierda =
        int.parse(json['Pace_SV_c_suro_izq'].toString());
    Valores.circunferenciaSuralDerecha =
        int.parse(json['Pace_SV_c_suro_der'].toString());
  }
}

class Electrocardiogramas {
  static var fileAssocieted =
      '${Pacientes.localRepositoryPath}/electrocardiogramas.json';

  static final Map<String, dynamic> electrocardiogramas = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_reggabo "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_reggabo",
    "describeTable": "DESCRIBE gabo_ecg;",
    "showColumns": "SHOW columns FROM gabo_ecg",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'gabo_ecg'",
    "createQuery": """CREATE TABLE gabo_ecg (
              ID_Pace_GAB_EC int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              ID_Pace int(11) NOT NULL,
              Pace_GAB_EC_Feca date NOT NULL,
              Pace_EC_rit varchar(100) COLLATE utf8_unicode_ci NOT NULL,
              Pace_EC_rr int(50) NOT NULL,
              Pace_EC_dop double NOT NULL,
              Pace_EC_aop double NOT NULL,
              Pace_EC_dpr double NOT NULL,
              Pace_EC_dqrs double NOT NULL,
              Pace_EC_aqrs double NOT NULL,
              Pace_EC_qrsi double NOT NULL,
              Pace_EC_qrsa double NOT NULL,
              Pace_QRS double NOT NULL,
              Pace_EC_ast_ double NOT NULL,
              Pace_EC_st varchar(100) COLLATE utf8_unicode_ci NOT NULL,
              Pace_EC_dqt double NOT NULL,
              Pace_EC_dot double NOT NULL,
              Pace_EC_aot double NOT NULL,
              EC_rV1 double NOT NULL,
              EC_sV6 double NOT NULL,
              EC_sV1 double NOT NULL,
              EC_rV6 double NOT NULL,
              EC_rAVL double NOT NULL,
              EC_sV3 double NOT NULL,
              PatronQRS varchar(100) NOT NULL, 
              DeflexionIntrinsecoide int(10) NOT NULL, 
              EC_rDI int(10) NOT NULL, 
              EC_sDI int(10) NOT NULL, 
              EC_rDIII int(10) NOT NULL, 
              EC_sDIII int(10) NOT NULL,
              Pace_EC_CON varchar(500) COLLATE utf8_unicode_ci NOT NULL,
              Pace_GAB_Tee varchar(100) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci 
            COMMENT='Registro de los electrogramas de los pacientes registrados';""",
    "truncateQuery": "TRUNCATE gabo_ecg",
    "dropQuery": "DROP TABLE gabo_ecg",
    "consultQuery": "SELECT * FROM gabo_ecg",
    "consultIdQuery": "SELECT * FROM gabo_ecg WHERE ID_Pace_GAB_EC = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM gabo_ecg WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM gabo_ecg",
    "consultLastQuery":
        "SELECT * FROM gabo_ecg WHERE ID_Pace = ? ORDER BY ID_Pace_GAB_EC DESC",
    "consultByName": "SELECT * FROM gabo_ecg WHERE Pace_GAB_EC_Feca LIKE '%",
    "registerQuery": "INSERT INTO gabo_ecg (ID_Pace, Pace_GAB_EC_Feca, Pace_EC_rit, "
        "Pace_EC_rr, Pace_EC_dop, "
        "Pace_EC_aop, Pace_EC_dpr, Pace_EC_dqrs, Pace_EC_aqrs, Pace_EC_qrsi, Pace_EC_qrsa, "
        "Pace_QRS, Pace_EC_ast_, Pace_EC_st, Pace_EC_dqt, Pace_EC_dot, Pace_EC_aot, EC_rV1, "
        "EC_sV6, EC_sV1, EC_rV6, EC_rAVL, EC_sV3, PatronQRS, DeflexionIntrinsecoide, EC_rDI, "
        "EC_sDI, EC_rDIII, EC_sDIII, Pace_EC_CON, Pace_GAB_IMG, Pace_GAB_Tee) "
        "VALUES (?,?,?,?,?,?,?,?,?,?,"
        "?,?,?,?,?,?,?,?,?,?,"
        "?,?,?,?,?,?,?,?,?,?,"
        "from_base64(?), ?)",
    "updateQuery": "UPDATE gabo_ecg SET ID_Pace_GAB_EC = ?, ID_Pace = ?, Pace_GAB_EC_Feca = ?, "
        "Pace_EC_rit = ?, Pace_EC_rr = ?, Pace_EC_dop = ?, Pace_EC_aop = ?, Pace_EC_dpr = "
        "?, Pace_EC_dqrs = ?, Pace_EC_aqrs = ?, Pace_EC_qrsi = ?, Pace_EC_qrsa = ?, "
        "Pace_QRS = ?, Pace_EC_ast_ = ?, Pace_EC_st = ?, Pace_EC_dqt = ?, Pace_EC_dot = ?, "
        "Pace_EC_aot = ?, EC_rV1 = ?, EC_sV6 = ?, EC_sV1 = ?, EC_rV6 = ?, EC_rAVL = ?, "
        "EC_sV3 = ?, PatronQRS = ?, DeflexionIntrinsecoide = ?, EC_rDI = ?, EC_sDI = ?, "
        "EC_rDIII = ?, EC_sDIII = ?, Pace_EC_CON = ?, Pace_GAB_IMG = from_base64(?), "
        "Pace_GAB_Tee = ? "
        "WHERE ID_Pace_GAB_EC = ?",
    "deleteQuery": "DELETE FROM gabo_ecg WHERE ID_Pace_GAB_EC = ?",
    "antropoColumns": [
      "ID_Pace",
    ],
    "antropoItems": [],
    "antropoColums": [],
    "antropoStats": [],
    "electroStadistics": "SELECT "
        "(SELECT IFNULL(count(*), 0) FROM gabo_ecg WHERE Pace_Ses = '${Pacientes.Sexo[0]}') as Total_Mujeres,"
        "(SELECT IFNULL(count(*), 0) FROM gabo_ecg) as Total_Pacientes;"
  };

  static List<String> ritmos = ['Ritmo Sinusal', 'Ritmo no Sinusal'];
  static List<String> ast = [
    'Intervalo ST Supraeléctrico',
    'Intervalo ST Isoeléctrico',
    'Intervalo ST Infraeléctrico'
  ];
  static List<String> patronQRS = [
    'Patrón R',
    'Patrón Rs',
    'Patrón sR',
    'Patrón Q'
  ];

  static void fromJson(Map<String, dynamic> json) {
    try {

      Valores.fechaElectrocardiograma = json['Pace_GAB_EC_Feca'] ?? '';
      Valores.ritmoCardiaco = json['Pace_EC_rit'] ?? '';
      Valores.intervaloRR = json['Pace_EC_rr'] ?? 0;
      Valores.duracionOndaP = double.parse(
          json['Pace_EC_dop'] != null ? json['Pace_EC_dop'].toString() : '0');

      Valores.alturaOndaP = Numeros.toDoubleFromInt(json: json, keyEntered: 'Pace_EC_aop');
      Valores.duracionPR = Numeros.toDoubleFromInt(json: json, keyEntered: 'Pace_EC_dpr');
      Valores.duracionQRS = Numeros.toDoubleFromInt(json: json, keyEntered: 'Pace_EC_dqrs');
      Valores.alturaQRS = Numeros.toDoubleFromInt(json: json, keyEntered: 'Pace_EC_aqrs');
      Valores.QRSi = Numeros.toDoubleFromInt(json: json, keyEntered: 'Pace_EC_qrsi');
      Valores.QRSa = Numeros.toDoubleFromInt(json: json, keyEntered: 'Pace_EC_qrsa');
      //
      Valores.ejeCardiaco = double.parse(json['Pace_QRS'] ?? '0.0');
      //
      Valores.segmentoST = json['Pace_EC_st'] ?? '';
      Valores.alturaSegmentoST = Numeros.toDoubleFromInt(json: json, keyEntered: 'Pace_EC_ast_');
      Valores.duracionQT = Numeros.toDoubleFromInt(json: json, keyEntered: 'Pace_EC_dqt');
      Valores.duracionOndaT = Numeros.toDoubleFromInt(json: json, keyEntered: 'Pace_EC_dot');
      Valores.alturaOndaT = Numeros.toDoubleFromInt(json: json, keyEntered: 'Pace_EC_aot');
      //
      Valores.rV1 = json['EC_rV1'] ?? 0;
      Valores.sV6 = json['EC_sV6'] ?? 0;
      Valores.sV1 = json['EC_sV1'] ?? 0;
      Valores.rV6 = json['EC_rV6'] ?? 0;
      Valores.rAvL = json['EC_rAVL'] ?? 0;
      Valores.sV3 = json['EC_sV3'] ?? 0;
      //
      Valores.patronQRS = json['PatronQRS'] ?? '';
      Valores.deflexionIntrinsecoide =
          Numeros.toDoubleFromInt(json: json, keyEntered: 'DeflexionIntrinsecoide');

      Valores.rDI = Numeros.toDoubleFromInt(json: json, keyEntered: 'EC_rDI');
      Valores.sDI = Numeros.toDoubleFromInt(json: json, keyEntered: 'EC_sDI');
      Valores.rDIII = Numeros.toDoubleFromInt(json: json, keyEntered: 'EC_rDIII');
      Valores.sDIII = Numeros.toDoubleFromInt(json: json, keyEntered: 'EC_sDIII');
      //
      Valores.conclusionElectrocardiograma = json['Pace_EC_CON'] ?? '';
      // Valores.ima = json['Pace_GAB_IMG'];
    } on Exception catch (e) {
      Terminal.printExpected(message: "ERROR - $e");
    } finally {
      Terminal.printExpected(message: "Electrocardiograma seleccionados en Finally $json");
    }
  }
  // static void fromJson(Map<String, dynamic> json) {
  //   // print("Electrocardiogramas $json");
  //   //
  //   Valores.fechaElectrocardiograma = json['Pace_GAB_EC_Feca'] ?? '';
  //   Valores.ritmoCardiaco = json['Pace_EC_rit'] ?? '';
  //   Valores.intervaloRR = json['Pace_EC_rr'] == null ? json['Pace_EC_rr'] : 0;
  //   Valores.duracionOndaP = json['Pace_EC_dop'] == null ? json['Pace_EC_dop'] : 0;
  //   Valores.alturaOndaP = json['Pace_EC_aop'] == null ? json['Pace_EC_aop'] : 0;
  //   Valores.duracionPR = json['Pace_EC_dpr'] == null ? json['Pace_EC_dpr'] : 0;
  //   Valores.duracionQRS = json['Pace_EC_dqrs'] == null ? json['Pace_EC_dqrs'] : 0;
  //   Valores.alturaQRS = json['Pace_EC_aqrs'] == null ? json['Pace_EC_aqrs'] : 0;
  //   Valores.QRSi = json['Pace_EC_qrsi'] == null ? json['Pace_EC_qrsi'] : 0;
  //   Valores.QRSa = json['Pace_EC_qrsa'] == null ? json['Pace_EC_qrsa'] : 0;
  //   //
  //   Valores.ejeCardiaco = double.parse(
  //       json['Pace_QRS'] != '' && json['Pace_QRS'] != null
  //           ? json['Pace_QRS']
  //           : '0');
  //   //
  //   Valores.segmentoST = json['Pace_EC_st'] ?? '';
  //   Valores.alturaSegmentoST = json['Pace_EC_ast_'] == null ? json['Pace_EC_ast_'] : 0;
  //   Valores.duracionQT = json['Pace_EC_dqt'] == null ? json['Pace_EC_dqt'] : 0;
  //   Valores.duracionOndaT = json['Pace_EC_dot'] == null ? json['Pace_EC_dot'] : 0;
  //   Valores.alturaOndaT = json['Pace_EC_aot'] == null ? json['Pace_EC_aot'] : 0;
  //
  //   //
  //   Valores.rV1 = json['EC_rV1'] == null ? json['EC_rV1'] : 0;
  //   Valores.sV6 = json['EC_sV6'] == null ? json['EC_sV6'] : 0;
  //   Valores.sV1 = json['EC_sV1'] == null ? json['EC_sV1'] : 0;
  //   Valores.rV6 = json['EC_rV6'] == null ? json['EC_rV6'] : 0;
  //   Valores.rAvL = json['EC_rAVL'] == null ? json['EC_rAVL'] : 0;
  //   Valores.sV3 = json['EC_sV3'] == null ? json['EC_sV3'] : 0;
  //   //
  //   Valores.patronQRS = json['PatronQRS'] ?? '';
  //   Valores.deflexionIntrinsecoide = json['DeflexionIntrinsecoide'] == null
  //       ? json['DeflexionIntrinsecoide']
  //       : 0;
  //
  //   Valores.rDI = json['EC_rDI'] == null ? json['EC_rDI'] : 0;
  //   Valores.sDI = json['EC_sDI'] == null ? json['EC_sDI'] : 0;
  //   Valores.rDIII = json['EC_rDIII'] == null ? json['EC_rDIII'] : 0;
  //   Valores.sDIII = json['EC_sDIII'] == null ? json['EC_sDIII'] : 0;
  //
  //   Valores.conclusionElectrocardiograma = json['Pace_EC_CON'] ?? '';
  //
  // }
}

class Imagenologias {
  static var fileAssocieted =
      '${Pacientes.localRepositoryPath}/imagenologicos.json';

  static final Map<String, dynamic> imagenologias = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_reggabo "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_reggabo",
    "describeTable": "DESCRIBE gabo_rae;",
    "showColumns": "SHOW columns FROM gabo_rae",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default "
            "FROM information_schema.columns "
            "WHERE table_name = 'gabo_rae'",
    "createQuery": """CREATE TABLE gabo_rae (
                  ID_Pace_GAB_RA int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  ID_Pace int(11) NOT NULL,
                  Pace_GAB_RA_Feca date NOT NULL,
                  Pace_GAB_RA_typ varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_GAB_RA_reg varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_GAB_RA_hal varchar(500) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_GAB_RA_con varchar(500) COLLATE utf8_unicode_ci NOT NULL,
                   Pace_GAB_RA_IMG longblob NOT NULL, 
                  Pace_GAB_Tee varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci 
                COMMENT='Registro de los Estudios de imagen realizados a los pacientes.';""",
    "truncateQuery": "TRUNCATE gabo_rae",
    "dropQuery": "DROP TABLE gabo_rae",
    "consultQuery": "SELECT * FROM gabo_rae",
    "consultIdQuery": "SELECT * FROM gabo_rae WHERE ID_Pace_GAB_RA = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM gabo_rae WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM gabo_rae",
    "consultLastQuery":
        "SELECT * FROM gabo_rae WHERE ID_Pace = ? ORDER BY ID_Pace_GAB_EC DESC",
    "consultByName": "SELECT * FROM gabo_rae WHERE Pace_GAB_EC_Feca LIKE '%",
    "registerQuery": "INSERT INTO gabo_rae (ID_Pace, Pace_GAB_RA_Feca, "
        "Pace_GAB_RA_typ, Pace_GAB_RA_reg, Pace_GAB_RA_hal, "
        "Pace_GAB_RA_con, Pace_GAB_RA_IMG, Pace_GAB_Tee) "
        "VALUES (?,?,?,?,?,?,from_base64(?),?)",
    "updateQuery": "UPDATE gabo_rae SET ID_Pace_GAB_RA = ?, ID_Pace = ?, "
        "Pace_GAB_RA_Feca = ?, Pace_GAB_RA_typ = ?, "
        "Pace_GAB_RA_reg = ?, Pace_GAB_RA_hal = ?, "
        "Pace_GAB_RA_con = ?, Pace_GAB_RA_IMG = from_base64(?), Pace_GAB_Tee = ? "
        "WHERE ID_Pace_GAB_RA = ?",
    "deleteQuery": "DELETE FROM gabo_rae WHERE ID_Pace_GAB_RA = ?",
    "antropoColumns": [
      "ID_Pace",
    ],
    "antropoItems": [],
    "antropoColums": [],
    "antropoStats": [],
    "electroStadistics": "SELECT "
        "(SELECT IFNULL(count(*), 0) FROM gabo_rae WHERE Pace_Ses = '${Pacientes.Sexo[0]}') as Total_Mujeres,"
        "(SELECT IFNULL(count(*), 0) FROM gabo_rae) as Total_Pacientes;"
  };

  static String historial() {
    String prosa = "";
    var fechar = Listas.listWithoutRepitedValues(
      Listas.listFromMapWithOneKey(
        Pacientes.Imagenologicos!,
        keySearched: 'Fecha_Registro',
      ),
    );

    fechar.forEach((element) {
      // Filtro por estudio de los registros de Pacientes.Paraclinicos
      var aux = Pacientes.Imagenologicos!
          .where((user) => user["Fecha_Registro"].contains(element))
          .toList();
      String fecha = "($element)";
      String max = "";

      aux.forEach((element) {
        if (max == "") {
          max =
              "${element['Estudio'].toLowerCase()} ${element['Resultado']} ${element['Unidad_Medida']}";
        } else {
          max =
              "$max, ${element['Estudio'].toLowerCase()} ${element['Resultado']} ${element['Unidad_Medida']}";
        }
      });

      prosa = "$prosa$fecha: ${Sentences.capitalize(max)}\n";
    });
    // ************** ***************** ***************
    // Terminal.printExpected(message: "prosa $prosa");

    return prosa; // """$prosa$max. ";
  }

  static List<String> regiones = ['Ritmo Sinusal', 'Ritmo no Sinusal'];
  static List<String> typesEstudios = [
    'Radiografías',
    'Ultrasonidos',
    'Tomografías',
    'Resonancias',
    'Ecocardiograma',
    'Endoscopia',
    'Colonoscopia',
  ];
}

class Auxiliares {
  static var fileAssocieted =
      '${Pacientes.localRepositoryPath}paraclinicos.json';

  static void ultimoRegistro() {
    Actividades.detallesById(Databases.siteground_database_reggabo,
            Auxiliares.auxiliares['auxiliarStadistics'], Pacientes.ID_Paciente,
            emulated: true)
        .then((value) {
      Pacientes.Auxiliar = value;
    });
  }

  static void registros({String? tipoEstudio}) {
    Actividades.consultarAllById(
            Databases.siteground_database_reggabo,
            Auxiliares.auxiliares['consultByIdPrimaryQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      Pacientes.Paraclinicos = value;
      // Archivos.createJsonFromMap(value, filePath: fileAssocieted);
    });
    Actividades.consultarId(
            Databases.siteground_database_reggabo,
            Electrocardiogramas.electrocardiogramas['consultLastQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      Pacientes.Electrocardiogramas = value;
      // Calculos adicionales
      // Pacientes.Electrocardiogramas.addAll({
      //   "isl": (Pacientes.Electrocardiogramas['EC_sV1'] +
      //       Pacientes.Electrocardiogramas['EC_rV6']),
      //   "igu": (Pacientes.Electrocardiogramas['EC_rDI'] +
      //       Pacientes.Electrocardiogramas['EC_sDIII']),
      //   "il": (Pacientes.Electrocardiogramas['EC_rDI'] +
      //           Pacientes.Electrocardiogramas['EC_sDIII']) -
      //       (Pacientes.Electrocardiogramas['EC_rDIII'] +
      //           Pacientes.Electrocardiogramas['EC_sDI']),
      //   "vc": (Pacientes.Electrocardiogramas['EC_rAVL'] +
      //       Pacientes.Electrocardiogramas['EC_sV3'])
      // });
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR - $error : : $stackTrace");
    });
  }

  static String porTipoEstudio({int? indice = 0, String fechaActual = ""}) {
    // Filtro por estudio de los registros de Pacientes.Paraclinicos
    var aux = Pacientes.Paraclinicos!
        .where((user) =>
            user["Tipo_Estudio"].contains(Auxiliares.Categorias[indice!]))
        .toList();
    // Inicio del formato de la prosa.
    if (fechaActual == "") {
      fechaActual = aux[0]['Fecha_Registro'];
    }
    //
    String prosa = "${Auxiliares.Categorias[indice!]} ($fechaActual): ";
    String max = "";
    // Anexación de los valores correlacionados.
    for (var element in aux) {
      if (element['Fecha_Registro'] == fechaActual) {
        if (max == "") {
          max =
              "${element['Estudio']} ${element['Resultado']} ${element['Unidad_Medida']}";
        } else {
          max =
              "$max, ${element['Estudio']} ${element['Resultado']} ${element['Unidad_Medida']}";
        }
      }
    }
    // Devolución de la prosa.
    return "$prosa$max. ";
  }

  static String porFecha({String fechaActual = ""}) {
    // Filtro por estudio de los registros de Pacientes.Paraclinicos
    var aux = Pacientes.Paraclinicos!
        .where((user) => user["Fecha_Registro"].contains(fechaActual))
        .toList();
    // Inicio del formato de la prosa.
    if (fechaActual == "") {
      fechaActual = aux[0]['Fecha_Registro'];
    }
    //
    String prosa = "($fechaActual): ";
    String max = "";
    // Anexación de los valores correlacionados.
    for (var element in aux) {
      if (element['Fecha_Registro'] == fechaActual) {
        if (max == "") {
          max =
              "${element['Estudio'].toLowerCase()} ${element['Resultado']} ${element['Unidad_Medida']}";
        } else {
          max =
              "$max, ${element['Estudio'].toLowerCase()} ${element['Resultado']} ${element['Unidad_Medida']}";
        }
      }
    }
    //* ****************************
    // Terminal.printNotice(message:  "$prosa$max. ");
    // Devolución de la prosa.
    return "$prosa${Sentences.capitalize(max)}. ";
  }

  static String historial() {
    String prosa = "";
    var fechar = Listas.listWithoutRepitedValues(
      Listas.listFromMapWithOneKey(
        Pacientes.Paraclinicos!,
        keySearched: 'Fecha_Registro',
      ),
    );

    fechar.forEach((element) {
      // Filtro por estudio de los registros de Pacientes.Paraclinicos
      var aux = Pacientes.Paraclinicos!
          .where((user) => user["Fecha_Registro"].contains(element))
          .toList();
      String fecha = "($element)";
      String max = "";

      aux.forEach((element) {
        if (max == "") {
          max =
              "${element['Estudio'].toLowerCase()} ${element['Resultado']} ${element['Unidad_Medida']}";
        } else {
          max =
              "$max, ${element['Estudio'].toLowerCase()} ${element['Resultado']} ${element['Unidad_Medida']}";
        }
      });

      prosa = "$prosa$fecha: ${Sentences.capitalize(max)}\n";
    });
    // ************** ***************** ***************
    // Terminal.printExpected(message: "prosa $prosa");

    return prosa; // """$prosa$max. ";
  }

  static Future<Null> cambiarFecha(
      {required String fechaPrevia, required String fechaNueva}) async {
    Actividades.actualizar(
            Databases.siteground_database_reggabo,
            "UPDATE laboratorios "
            "SET Fecha_Registro = ? "
            "WHERE Fecha_Registro = ? AND ID_Pace = ?",
            [fechaNueva, fechaPrevia, Pacientes.ID_Paciente],
            Pacientes.ID_Paciente)
        .then((value) =>
            Terminal.printNotice(message: "Actualizado $value . . ."))
        .whenComplete(() => Terminal.printNotice(message: "Actualizado . . . "))
        .onError((error, stackTrace) =>
            Terminal.printAlert(message: "Error :  : $error :  $stackTrace"));
  }

  static String abreviado({required String estudio}) {
    if (estudio == 'Concentración Media de Hemoglobina Corpuscular') {
      return 'CMHC';
    } else if (estudio == 'Radio de Distribución Eritrocitaria') {
      return 'RDW';
    } else if (estudio == 'Alaninoaminotrasferasa') {
      return 'ALT';
    } else if (estudio == 'Aspartatoaminotransferasa') {
      return 'AST';
    } else if (estudio == 'Bilirrubinas Totales') {
      return 'BT';
    } else if (estudio == 'Bilirrubina Directa') {
      return 'BD';
    } else if (estudio == 'Bilirrubina Indirecta') {
      return 'BI';
    } else if (estudio == 'Deshidrogenasa Láctica') {
      return 'DHL';
    } else if (estudio == 'Glutrailtranspeptidasa') {
      return 'GGT';
    } else if (estudio == 'Fosfatasa Alcalina') {
      return 'FA';
    } else if (estudio == 'Tiempo de Protrombina') {
      return 'TP';
    } else if (estudio == 'Tiempo Parcial de Tromboplastina') {
      return 'TPT';
    } else if (estudio == 'Velocidad de Sedimentación Globular') {
      return 'VSG';
    } else if (estudio == 'Presión de Dióxido de Carbono') {
      return 'pCO2';
    } else if (estudio == 'Presión de Oxígeno') {
      return 'pO2';
    } else if (estudio == 'Bicarbonato Sérico') {
      return 'HCO3-' '';
    } else if (estudio == 'Fracción Inspiratoria de Oxígeno') {
      return 'FiO2';
    } else if (estudio == 'Saturación de Oxígeno') {
      return 'SO2';
    } else if (estudio == 'Sodio Urinario') {
      return 'NaU';
    } else if (estudio == 'Potasio Urinario') {
      return 'K+U';
    } else if (estudio == 'Cloro Urinario') {
      return 'CL-U';
    } else if (estudio == 'Calcio Urinario') {
      return 'CaU';
    } else if (estudio == 'Fósforo Urinario') {
      return 'PO3u';
    } else if (estudio == 'Magnesio Urinario') {
      return 'MgU';
    } else if (estudio == 'Creatinina Urinaria') {
      return 'CrU';
    } else if (estudio == 'Sodio') {
      return 'Na+';
    } else if (estudio == 'Potasio') {
      return 'K+';
    } else if (estudio == 'Cloro') {
      return 'Cl-';
    } else if (estudio == 'Magnesio') {
      return 'Mg';
    } else if (estudio == 'Fósforo') {
      return 'PO3';
    } else if (estudio == 'Calcio') {
      return 'Ca2';
    } else if (estudio == 'Hemoglobina') {
      return 'Hb';
    } else if (estudio == 'Hematocrito') {
      return 'Hto';
    } else if (estudio == 'Eritrocitos') {
      return 'Erit';
    } else if (estudio == 'Plaquetas') {
      return 'Plat';
    } else if (estudio == 'Albúmina') {
      return 'Alb';
    } else if (estudio == 'Urea') {
      return 'URe';
    } else if (estudio == 'Creatinina') {
      return 'Cr';
    } else if (estudio == 'Glucosa') {
      return 'GLU';
    } else {
      return estudio;
    }
  }

  static List<String> Categorias = [
    "Biometría Hemática",
    "Química Sanguínea",
    "Electrolitos Séricos",
    "Pruebas de Funcionamiento Hepático",
    "Perfil Tiroideo",
    "Perfil Pancreático",
    "Perfil Lipídico",
    "Tiempos de Coagulación",
    "Reactantes de Fase Aguda",
    "Gasometría Arterial",
    "Gasometría Venosa",
    "Examen General de Orina",
    "Depuración de Orina de 24 Horas",
    "Citoquimico",
    "Citológico",
    "Iones Urinarios",
    "Carga Viral",
    "Conteo de Linfocitos T CD4+",
    "Marcadores Cárdiacos",
    "",
    "",
    "Electrocardiograma"
  ];
  static Map<String, dynamic> Laboratorios = {
    Categorias[0]: [
      "Eritrocitos",
      "Hemoglobina",
      "Hematocrito",
      "Concentración Media de Hemoglobina Corpuscular",
      "VCM", // "Volumen Corpuscular Medio",
      "HCM", //"Hemoglobina Corpuscular Media",
      "CH", //"Concentración de Hemoglobina",
      "Radio de Distribución Eritrocitaria",
      "Plaquetas",
      "Leucocitos Totales",
      "Neutrofilos Totales",
      "Linfocitos Totales",
      "Monocitos Totales",
      "Eosinófilos Totales",
      "Basófilos Totales",
      "Bandas Totales"
    ],
    Categorias[1]: [
      "Glucosa",
      "Urea",
      "Creatinina",
      "Nitrógeno Úrico",
      "Acido Úrico"
    ],
    Categorias[2]: [
      "Sodio",
      "Potasio",
      "Cloro",
      "Calcio",
      "Fósforo",
      "Magnesio"
    ],
    Categorias[3]: [
      "Alaninoaminotrasferasa",
      "Aspartatoaminotransferasa",
      "Bilirrubinas Totales",
      "Bilirrubina Directa",
      "Bilirrubina Indirecta",
      "Deshidrogenasa Láctica",
      "Glutrailtranspeptidasa",
      "Fosfatasa Alcalina",
      "Albúmina",
      "Proteínas Totales",
      "Globulinas"
    ],
    Categorias[4]: ["TSH", "T4-L", "T3-L", "T4", "T3"],
    Categorias[5]: ["Lipasa", "Amilasa"],
    Categorias[6]: [
      "Colesterol Total",
      "Trigiliceridos",
      "c-HDL",
      "c-LDL",
      "c-VLDL"
    ],
    Categorias[7]: [
      "Tiempo de Protrombina",
      "TP%",
      "INR",
      "Tiempo Parcial de Tromboplastina"
    ],
    Categorias[8]: [
      "Procalcitonina",
      "Ácido Láctico",
      "Velocidad de Sedimentación Globular",
      "Proteina C Reactiva",
      "Factor Reumatoide",
      "Anticuerpo Antipéptido Citrulinado"
    ],
    //
    Categorias[9]: [
      "pH",
      "Presión de Dióxido de Carbono",
      "Presión de Oxígeno",
      "Bicarbonato Sérico",
      "Fracción Inspiratoria de Oxígeno",
      "Saturación de Oxígeno"
    ],
    Categorias[10]: [
      "pH",
      "Presión de Dióxido de Carbono",
      "Presión de Oxígeno",
      "Bicarbonato Sérico",
      "Fracción Inspiratoria de Oxígeno",
      "Saturación de Oxígeno"
    ],
    //
    Categorias[11]: [""],
    Categorias[12]: [""],
    Categorias[13]: [""],
    Categorias[14]: [""],
    Categorias[15]: [
      "Sodio Urinario",
      "Potasio Urinario",
      "Cloro Urinario",
      "Calcio Urinario",
      "Fósforo Urinario",
      "Magnesio Urinario",
      "Creatinina Urinaria"
    ],
    Categorias[16]: [
      "Conteo de Viriones de VIH",
      "Conteo de Viriones de Hepatitis A",
      "Conteo de Viriones de Hepatitis B",
      "Conteo de Viriones de Hepatitis C"
    ],
    Categorias[17]: [
      "Conteo de Linfocitos CD4+",
      "Porcentaje de Linfocitos CD4+"
    ],
    Categorias[18]: [
      "CK Total",
      "CK-Mb",
      "Mioglobina",
      "Troponina I (T nIc)",
      "Troponina I (T nTc)",
      "LDH",
    ],
    Categorias[19]: [
      "Conteo de Linfocitos CD4+",
      "Porcentaje de Linfocitos CD4+"
    ],
    Categorias[20]: [
      "Conteo de Linfocitos CD4+",
      "Porcentaje de Linfocitos CD4+"
    ],
  };
  static Map<String, dynamic> Medidas = {
    Categorias[0]: ["g/dL", "%", "fL", "pg", "10^3/UL", "10^6/UL", "K/uL"],
    Categorias[1]: ["mg/dL"],
    Categorias[2]: ["mEq/L", "mmol/L", "mg/dL"],
    Categorias[3]: ["UI/L", "g/dL", "mg/dL"],
    Categorias[4]: ["mUI/L", "pg/mL", "ng/dL", ""],
    Categorias[5]: [""],
    Categorias[6]: ["mg/dL"],
    Categorias[7]: ["", "seg"],
    Categorias[8]: ["ng/dL", "mm/Hr", "mg/dL", "ng/mL"],
    Categorias[9]: ["", "mmHg", "cmH20", "mmol/L", "%"],
    Categorias[10]: ["", "mmHg", "cmH20", "mmol/L", "%"],
    Categorias[11]: [""],
    Categorias[12]: [""],
    Categorias[13]: [""],
    Categorias[14]: [""],
    Categorias[15]: [""],
    Categorias[16]: [""],
    Categorias[17]: [""],
    Categorias[18]: ["UI/L", "ng/mL"],
    Categorias[19]: [""],
    Categorias[20]: [""],
  };
  static final Map<String, dynamic> auxiliares = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_reglabo "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_reglabo",
    "describeTable": "DESCRIBE laboratorios;",
    "showColumns": "SHOW columns FROM laboratorios",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'laboratorios'",
    "createQuery": """
                CREATE TABLE laboratorios (
                  ID_Laboratorio int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL, 
                  ID_Pace int(11) NOT NULL,
                  Fecha_Registro DATE NOT NULL, 
                  Tipo_Estudio varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Estudio varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Resultado varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  Unidad_Medida varchar(50) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='En esta Tabla se agregan los laboratorios de los pacientes';
    """,
    "truncateQuery": "TRUNCATE laboratorios",
    "dropQuery": "DROP TABLE laboratorios",
    "consultQuery": "SELECT * FROM laboratorios",
    "consultIdQuery": "SELECT * FROM laboratorios WHERE ID_Laboratorio = ?",
    "consultByIdPrimaryQuery":
        "SELECT ID_Laboratorio, Fecha_Registro, Tipo_Estudio, Estudio, Resultado, Unidad_Medida FROM laboratorios WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM laboratorios",
    "consultLastQuery": "SELECT * FROM laboratorios ORDER BY Pace_Feca_SV DESC",
    "consultByName": "SELECT * FROM laboratorios WHERE Pace_Feca_SV LIKE '%",
    "registerQuery": "INSERT INTO laboratorios (ID_Laboratorio, ID_Pace, "
        "Fecha_Registro, Tipo_Estudio, Estudio, Resultado, Unidad_Medida) "
        "VALUES (?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE laboratorios SET ID_Laboratorio = ?, "
        "ID_Pace = ?, Fecha_Registro = ?, Tipo_Estudio = ?, "
        "Estudio = ?, Resultado = ?, Unidad_Medida = ? "
        "WHERE ID_Laboratorio = ?",
    "deleteQuery": "DELETE FROM laboratorios WHERE ID_Laboratorio = ?",
    "antropoColumns": [
      "ID_Pace",
    ],
    "antropoItems": [
      "ID_Pace",
      "Nombre_Completo",
      "Apellido_Paterno",
      "Apellido_Materno",
      "Paciente",
      "Contraseña",
      "Permisos",
      "Especialización",
      "Area",
      "Estatus",
      "Anexado_por"
    ],
    "antropoColums": [
      "ID Paciente",
      "Nombre Completo",
      "Apellido Paterno",
      "Apellido Materno",
      "Paciente",
      "Contraseña",
      "Permiso(s)",
      "Especialización",
      "Area",
      "Estatus",
      "Anexado Por"
    ],
    "antropoStats": [
      "Total_Administradores",
      "Total_Mip",
      "Total_Mpss",
      "Total_Mg",
      "Total_Medesp",
      "Total_Tegra",
      "Total_Enfra",
      "Total_Enfesp",
      "Total_Tec",
      "Total_Secre",
      "Total_Captu",
      "Total_Inge",
      "Total_Directivos",
      "Total_Guardias",
      "Total_Logistica",
      "Total_Mantenimiento",
      "Total_Traslado_Intra",
      "otal_Traslado_Extra",
    ],
    "auxiliarStadistics": "SELECT "
        "(SELECT Fecha_Registro FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Tipo_Estudio = 'Biometría Hemática' ORDER BY Fecha_Registro DESC limit 1) as Fecha_Registro_Biometria,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Eritrocitos' ORDER BY Fecha_Registro DESC limit 1) as Eritrocitos,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Hemoglobina' ORDER BY Fecha_Registro DESC limit 1) as Hemoglobina,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Hematocrito' ORDER BY Fecha_Registro DESC limit 1) as Hematocrito,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Concentración Media de Hemoglobina Corpuscular' ORDER BY Fecha_Registro DESC limit 1) as CHCM,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'VCM' ORDER BY Fecha_Registro DESC limit 1) as VCM,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'HCM' ORDER BY Fecha_Registro DESC limit 1) as HCM,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Plaquetas' ORDER BY Fecha_Registro DESC limit 1) as Plaquetas,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Leucocitos Totales' ORDER BY Fecha_Registro DESC limit 1) as Leucocitos_Totales,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Neutrofilos Totales' ORDER BY Fecha_Registro DESC limit 1) as Neutrofilos_Totales,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Linfocitos Totales' ORDER BY Fecha_Registro DESC limit 1) as Linfocitos_Totales,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Monocitos Totales' ORDER BY Fecha_Registro DESC limit 1) as Monocitos_Totales,"
        //
        "(SELECT Fecha_Registro FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Tipo_Estudio = 'Química Sanguínea' ORDER BY Fecha_Registro DESC limit 1) as Fecha_Registro_Quimicas,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Glucosa' ORDER BY Fecha_Registro DESC limit 1) as Glucosa,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Urea' ORDER BY Fecha_Registro DESC limit 1) as Urea,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Creatinina' ORDER BY Fecha_Registro DESC limit 1) as Creatinina,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Acido Úrico' ORDER BY Fecha_Registro DESC limit 1) as Acido_Urico,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Nitrógeno Úrico' ORDER BY Fecha_Registro DESC limit 1) as Nitrogeno_Ureico,"
        //
        "(SELECT Fecha_Registro FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Tipo_Estudio = 'Electrolitos Séricos' ORDER BY Fecha_Registro DESC limit 1) as Fecha_Registro_Electrolitos,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Sodio' ORDER BY Fecha_Registro DESC limit 1) as Sodio,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Potasio' ORDER BY Fecha_Registro DESC limit 1) as Potasio,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Cloro' ORDER BY Fecha_Registro DESC limit 1) as Cloro,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Calcio' ORDER BY Fecha_Registro DESC limit 1) as Calcio,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Fósforo' ORDER BY Fecha_Registro DESC limit 1) as Fosforo,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Magnesio' ORDER BY Fecha_Registro DESC limit 1) as Magnesio,"
        //
        "(SELECT Fecha_Registro FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Tipo_Estudio = 'Reactantes de Fase Aguda' ORDER BY Fecha_Registro DESC limit 1) as Fecha_Registro_Reactantes,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Procalcitonina' ORDER BY Fecha_Registro DESC limit 1) as Procalcitonina,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Ácido Láctico' ORDER BY Fecha_Registro DESC limit 1) as Acido_Lactico,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Velocidad de Sedimentación Globular' ORDER BY Fecha_Registro DESC limit 1) as Velocidad_Sedimentacion,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Proteina C Reactiva' ORDER BY Fecha_Registro DESC limit 1) as Proteina_Reactiva,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Factor Reumatoide' ORDER BY Fecha_Registro DESC limit 1) as Factor_Reumatoide,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Anticuerpo Antipéptido Citrulinado' ORDER BY Fecha_Registro DESC limit 1) as Anticuerpo_Citrulinado,"
        //
        "(SELECT Fecha_Registro FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Tipo_Estudio = 'Pruebas de Funcionamiento Hepático' ORDER BY Fecha_Registro DESC limit 1) as Fecha_Registro_Hepaticos,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Alaninoaminotrasferasa' ORDER BY Fecha_Registro DESC limit 1) as Alaninoaminotrasferasa,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Aspartatoaminotransferasa' ORDER BY Fecha_Registro DESC limit 1) as Aspartatoaminotransferasa,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Bilirrubinas Totales' ORDER BY Fecha_Registro DESC limit 1) as Bilirrubinas_Totales,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Bilirrubina Directa' ORDER BY Fecha_Registro DESC limit 1) as Bilirrubina_Directa,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Bilirrubina Indirecta' ORDER BY Fecha_Registro DESC limit 1) as Bilirrubina_Indirecta,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Deshidrogenasa Láctica' ORDER BY Fecha_Registro DESC limit 1) as Deshidrogenasa_Lactica,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Glutrailtranspeptidasa' ORDER BY Fecha_Registro DESC limit 1) as Glutrailtranspeptidasa,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Fosfatasa Alcalina' ORDER BY Fecha_Registro DESC limit 1) as Fosfatasa_Alcalina,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Albúmina' ORDER BY Fecha_Registro DESC limit 1) as Albumina_Serica,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Proteínas Totales' ORDER BY Fecha_Registro DESC limit 1) as Proteinas_Totales,"
        // Gasometría Arterial
        "(SELECT Fecha_Registro FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Tipo_Estudio = 'Gasometría Arterial' ORDER BY Fecha_Registro DESC limit 1) as Fecha_Registro_Arterial,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Tipo_Estudio = 'Gasometría Arterial' AND Estudio = 'pH' ORDER BY Fecha_Registro DESC limit 1) as Ph_Arterial,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Tipo_Estudio = 'Gasometría Arterial' AND Estudio = 'Presión de Dióxido de Carbono' ORDER BY Fecha_Registro DESC limit 1) as Pco_Arterial,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Tipo_Estudio = 'Gasometría Arterial' AND Estudio = 'Presión de Oxígeno' ORDER BY Fecha_Registro DESC limit 1) as Po_Arterial,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Tipo_Estudio = 'Gasometría Arterial' AND Estudio = 'Bicarbonato Sérico' ORDER BY Fecha_Registro DESC limit 1) as Hco_Arterial,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Tipo_Estudio = 'Gasometría Arterial' AND Estudio = 'Fracción Inspiratoria de Oxígeno' ORDER BY Fecha_Registro DESC limit 1) as Fio_Arterial,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Tipo_Estudio = 'Gasometría Arterial' AND Estudio = 'Saturación de Oxígeno' ORDER BY Fecha_Registro DESC limit 1) as So_Arterial, "
//
        "(SELECT Fecha_Registro FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Tipo_Estudio = 'Gasometría Venosa' ORDER BY Fecha_Registro DESC limit 1) as Fecha_Registro_Venosa,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Tipo_Estudio = 'Gasometría Venosa' AND Estudio = 'pH' ORDER BY Fecha_Registro DESC limit 1) as Ph_Venosa,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Tipo_Estudio = 'Gasometría Venosa' AND Estudio = 'Presión de Dióxido de Carbono' ORDER BY Fecha_Registro DESC limit 1) as Pco_Venosa,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Tipo_Estudio = 'Gasometría Venosa' AND Estudio = 'Presión de Oxígeno' ORDER BY Fecha_Registro DESC limit 1) as Po_Venosa,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Tipo_Estudio = 'Gasometría Venosa' AND Estudio = 'Bicarbonato Sérico' ORDER BY Fecha_Registro DESC limit 1) as Hco_Venosa,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Tipo_Estudio = 'Gasometría Venosa' AND Estudio = 'Fracción Inspiratoria de Oxígeno' ORDER BY Fecha_Registro DESC limit 1) as Fio_Venosa,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Tipo_Estudio = 'Gasometría Venosa' AND Estudio = 'Saturación de Oxígeno' ORDER BY Fecha_Registro DESC limit 1) as So_Venosa;"
    //
    // "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Linfocitos' ORDER BY Fecha_Registro DESC limit 1) as Linfocitos_Totales;"
  };

  static String electrocardiograma() {
    return "Electrocardiograma (${Valores.fechaElectrocardiograma}): "
        "${Valores.ritmoCardiaco} "
        "con Intervalo R-R ${Valores.intervaloRR!.toStringAsFixed(0)} mm, "
        "Frecuencia Cardiaca ${(Valores.frecuenciaCardiacaElectrocardiograma).toStringAsFixed(0)} Lat/min; "
        "Duración de la Onda P ${(Valores.duracionOndaP! * 0.04).toStringAsFixed(2)} mSeg, "
        "Altura de la Onda P ${(Valores.alturaOndaP! * 0.1).toStringAsFixed(2)} mV, "
        "Duración de Intervalo PR ${(Valores.duracionPR! * 0.04).toStringAsFixed(2)} mSeg, "
        "Duración del Complejo QRS ${(Valores.duracionQRS! * 0.04).toStringAsFixed(2)} mSeg, "
        "Altura del Complejo QRS ${(Valores.alturaQRS! * 0.1).toStringAsFixed(2)} mV. "
        "Complejo QRS en aVF ${(Valores.QRSa! * 0.1).toStringAsFixed(2)} mV, "
        "Eje Cardiaco ${Valores.ejeCardiaco!.toStringAsFixed(1)}° (Tangente DI/aVF). "
        "Altura de la Onda T ${(Valores.alturaOndaT! * 0.1).toStringAsFixed(2)} mV, "
        "Duración de la Onda T ${(Valores.duracionOndaT! * 0.04).toStringAsFixed(2)} mSeg, "
        "Intervalo ST ${Valores.segmentoST}, "
        // "Duracion del Segmento ST ${(Valores.segmentoST} mSeg, "
        "Duracion del Intervalo QT ${(Valores.duracionQT! * 0.04).toStringAsFixed(2)} mSeg, "
        "Deflexión Intrinsecoide ${(Valores.deflexionIntrinsecoide! * 0.04).toStringAsFixed(2)} mSeg. "
        "Indice Sokolow - Lyon ${(Valores.indiceSokolowLyon * 0.1).toStringAsFixed(2)} mV, "
        "Indice Gubner - Ungerleider ${(Valores.indiceGubnerUnderleiger * 0.1).toStringAsFixed(2)} mV, "
        "Indice de Lewis ${(Valores.indiceLewis * 0.1).toStringAsFixed(2)} mV, "
        "Voltaje de Cornell ${(Valores.voltajeCornell * 0.1).toStringAsFixed(2)} mV, "
        "RaVL ${(Valores.rAvL! * 0.1).toStringAsFixed(2)} mV. ";

    // return "Electrocardiograma (${Pacientes.Electrocardiogramas['Pace_GAB_EC_Feca']}): "
    //     "${Pacientes.Electrocardiogramas['Pace_EC_rit']} "
    //     "con Intervalo R-R ${Pacientes.Electrocardiogramas['Pace_EC_rr']} mm, "
    //     "Frecuencia Cardiaca ${(300 / Pacientes.Electrocardiogramas['Pace_EC_rr']).toStringAsFixed(0)} Lat/min; "
    //     "Duración de la Onda P ${Pacientes.Electrocardiogramas['Pace_EC_dop'] * 0.04} mSeg, "
    //     "Altura de la Onda P ${Pacientes.Electrocardiogramas['Pace_EC_aop'] * 0.1} mV, "
    //     "Duración de Intervalo PR ${Pacientes.Electrocardiogramas['Pace_EC_dpr'] * 0.04} mSeg, "
    //     "Duración del Complejo QRS ${Pacientes.Electrocardiogramas['Pace_EC_dqrs'] * 0.04} mSeg, "
    //     "Altura del Complejo QRS ${Pacientes.Electrocardiogramas['Pace_EC_aqrs'] * 0.1} mV. "
    //     "Complejo QRS en aVF ${Pacientes.Electrocardiogramas['Pace_EC_qrsi'] * 0.1} mV, "
    //     "Eje Cardiaco ${Pacientes.Electrocardiogramas['Pace_QRS']}° (Tangente DI/aVF). "
    //     "Altura de la Onda T ${Pacientes.Electrocardiogramas['Pace_EC_aot'] * 0.1} mV, "
    //     "Duración de la Onda T ${Pacientes.Electrocardiogramas['Pace_EC_dot'] * 0.04} mSeg, "
    //     "Intervalo ST ${Pacientes.Electrocardiogramas['Pace_EC_ast_']}, "
    //     // "Duracion del Segmento ST ${Pacientes.Electrocardiogramas['Pace_EC_st'] * 0.04} mSeg, "
    //     "Duracion del Intervalo QT ${Pacientes.Electrocardiogramas['Pace_EC_dqt'] * 0.04} mSeg, "
    //     "Deflexión Intrinsecoide ${Pacientes.Electrocardiogramas['DeflexionIntrinsecoide'] * 0.04} mSeg. "
    //     "Indice Sokolow - Lyon ${(Pacientes.Electrocardiogramas['isl'] * 0.1).toStringAsFixed(0)} mV, "
    //     "Indice Gubner - Ungerleider ${(Pacientes.Electrocardiogramas['igu'] * 0.1).toStringAsFixed(0)} mV, "
    //     "Indice de Lewis ${(Pacientes.Electrocardiogramas['il'] * 0.1).toStringAsFixed(0)} mV, "
    //     "Voltaje de Cornell ${(Pacientes.Electrocardiogramas['vc'] * 0.1).toStringAsFixed(0)} mV, "
    //     "RaVL ${Pacientes.Electrocardiogramas['EC_rAVL']} mV. ";
  }
  static String electrocardiogramaAbreviado() {
    return "Electrocardiograma (${Valores.fechaElectrocardiograma}): "
        "${Valores.ritmoCardiaco} "
        "con Intervalo R-R ${Valores.intervaloRR!.toStringAsFixed(0)} mm, "
        "F. Card ${(Valores.frecuenciaCardiacaElectrocardiograma).toStringAsFixed(0)} Lat/min; "
        "Onda P ${(Valores.duracionOndaP! * 0.04).toStringAsFixed(2)} mSeg, "
        "${(Valores.alturaOndaP! * 0.1).toStringAsFixed(2)} mV, "
        "PR ${(Valores.duracionPR! * 0.04).toStringAsFixed(2)} mSeg, "
        "QRS ${(Valores.duracionQRS! * 0.04).toStringAsFixed(2)} mSeg, "
        "${(Valores.alturaQRS! * 0.1).toStringAsFixed(2)} mV. "
        "QRS en aVF ${(Valores.QRSa! * 0.1).toStringAsFixed(2)} mV, "
        "Eje Cardiaco ${Valores.ejeCardiaco!.toStringAsFixed(1)}° (Tangente DI/aVF). "
        "Onda T ${(Valores.alturaOndaT! * 0.1).toStringAsFixed(2)} mV, "
        "${(Valores.duracionOndaT! * 0.04).toStringAsFixed(2)} mSeg, "
        "Intervalo ST ${Valores.segmentoST}, "
        "QT ${(Valores.duracionQT! * 0.04).toStringAsFixed(2)} mSeg, "
        "Deflexión Intrinsecoide ${(Valores.deflexionIntrinsecoide! * 0.04).toStringAsFixed(2)} mSeg. "
        "Sokolow - Lyon ${(Valores.indiceSokolowLyon * 0.1).toStringAsFixed(2)} mV, "
        "Gubner - Ungerleider ${(Valores.indiceGubnerUnderleiger * 0.1).toStringAsFixed(2)} mV, "
        "Lewis ${(Valores.indiceLewis * 0.1).toStringAsFixed(2)} mV, "
        "Cornell ${(Valores.voltajeCornell * 0.1).toStringAsFixed(2)} mV, "
        "RaVL ${(Valores.rAvL! * 0.1).toStringAsFixed(2)} mV. ";

    // return "Electrocardiograma (${Pacientes.Electrocardiogramas['Pace_GAB_EC_Feca']}): "
    //     "${Pacientes.Electrocardiogramas['Pace_EC_rit']} "
    //     "con Intervalo R-R ${Pacientes.Electrocardiogramas['Pace_EC_rr']} mm, "
    //     "Frecuencia Cardiaca ${(300 / Pacientes.Electrocardiogramas['Pace_EC_rr']).toStringAsFixed(0)} Lat/min; "
    //     "Duración de la Onda P ${Pacientes.Electrocardiogramas['Pace_EC_dop'] * 0.04} mSeg, "
    //     "Altura de la Onda P ${Pacientes.Electrocardiogramas['Pace_EC_aop'] * 0.1} mV, "
    //     "Duración de Intervalo PR ${Pacientes.Electrocardiogramas['Pace_EC_dpr'] * 0.04} mSeg, "
    //     "Duración del Complejo QRS ${Pacientes.Electrocardiogramas['Pace_EC_dqrs'] * 0.04} mSeg, "
    //     "Altura del Complejo QRS ${Pacientes.Electrocardiogramas['Pace_EC_aqrs'] * 0.1} mV. "
    //     "Complejo QRS en aVF ${Pacientes.Electrocardiogramas['Pace_EC_qrsi'] * 0.1} mV, "
    //     "Eje Cardiaco ${Pacientes.Electrocardiogramas['Pace_QRS']}° (Tangente DI/aVF). "
    //     "Altura de la Onda T ${Pacientes.Electrocardiogramas['Pace_EC_aot'] * 0.1} mV, "
    //     "Duración de la Onda T ${Pacientes.Electrocardiogramas['Pace_EC_dot'] * 0.04} mSeg, "
    //     "Intervalo ST ${Pacientes.Electrocardiogramas['Pace_EC_ast_']}, "
    //     // "Duracion del Segmento ST ${Pacientes.Electrocardiogramas['Pace_EC_st'] * 0.04} mSeg, "
    //     "Duracion del Intervalo QT ${Pacientes.Electrocardiogramas['Pace_EC_dqt'] * 0.04} mSeg, "
    //     "Deflexión Intrinsecoide ${Pacientes.Electrocardiogramas['DeflexionIntrinsecoide'] * 0.04} mSeg. "
    //     "Indice Sokolow - Lyon ${(Pacientes.Electrocardiogramas['isl'] * 0.1).toStringAsFixed(0)} mV, "
    //     "Indice Gubner - Ungerleider ${(Pacientes.Electrocardiogramas['igu'] * 0.1).toStringAsFixed(0)} mV, "
    //     "Indice de Lewis ${(Pacientes.Electrocardiogramas['il'] * 0.1).toStringAsFixed(0)} mV, "
    //     "Voltaje de Cornell ${(Pacientes.Electrocardiogramas['vc'] * 0.1).toStringAsFixed(0)} mV, "
    //     "RaVL ${Pacientes.Electrocardiogramas['EC_rAVL']} mV. ";
  }
}

class Pendientes {
  static var fileAssocieted = '${Pacientes.localRepositoryPath}pendientes.json';

  static final Map<String, dynamic> pendientes = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_reggabo "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_reggabo",
    "describeTable": "DESCRIBE pace_pen;",
    "showColumns": "SHOW columns FROM pace_pen",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default "
            "FROM information_schema.columns "
            "WHERE table_name = 'pace_pen'",
    "createQuery": """CREATE TABLE pace_pen (
              ID_Pace_Pen int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              ID_Pace int(11) NOT NULL,
              ID_Hosp int(11) NOT NULL,
              Pace_PEN_realized tinyint(1) NOT NULL,
              Feca_PEN date NOT NULL,
              Pace_PEN varchar(150) COLLATE utf8_unicode_ci NOT NULL,
              Pace_Desc_PEN varchar(300) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci 
            COMMENT='Tabla para Registro de Pendientes durante Hospitalización.';
            """,
    "truncateQuery": "TRUNCATE pace_pen",
    "dropQuery": "DROP TABLE pace_pen",
    "consultQuery": "SELECT * FROM pace_pen",
    "consultIdQuery": "SELECT * FROM pace_pen WHERE ID_Hosp = ?",
    "consultIdDoQuery": "SELECT * FROM pace_pen WHERE ID_Pace = ?"
        "AND ID_Hosp = ? "
        "AND Pace_PEN_realized = '1'",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_pen WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_pen",
    "consultLastQuery":
        "SELECT * FROM pace_pen WHERE ID_Pace = ? ORDER BY Feca_PEN DESC",
    "consultByName": "SELECT * FROM pace_pen WHERE Pace_PEN LIKE '%",
    "registerQuery": "INSERT INTO pace_pen (ID_Pace, ID_Hosp, "
        "Feca_PEN, Pace_PEN_realized, "
        "Pace_PEN, Pace_Desc_PEN) "
        "VALUES (?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_pen "
        "SET ID_Pace_Pen = ?,  ID_Pace = ?,  ID_Hosp = ?,  "
        "Feca_PEN = ?,  "
        "Pace_PEN_realized = ?, "
        "Pace_PEN = ?,  Pace_Desc_PEN = ? "
        "WHERE ID_Pace_Pen = ?",
    "updateDoQuery": "UPDATE pace_pen "
        "SET Pace_PEN_realized = ? "
        "WHERE ID_Pace_Pen = ?",
    "deleteQuery": "DELETE FROM pace_pen WHERE ID_Pace_Pen = ?",
    "antropoColumns": [
      "ID_Pace",
    ],
    "antropoItems": [],
    "antropoColums": [],
    "antropoStats": [],
    "electroStadistics": "SELECT "
        "(SELECT IFNULL(count(*), 0) FROM pace_pen WHERE Pace_Ses = '${Pacientes.Sexo[0]}') as Total_Mujeres,"
        "(SELECT IFNULL(count(*), 0) FROM pace_pen) as Total_Pacientes;"
  };

  static Map<String, dynamic> Pendiente = {};

  static List<String> regiones = ['Ritmo Sinusal', 'Ritmo no Sinusal'];
  static List<String> typesPendientes = [
    'Radiografías',
    'Ultrasonidos',
    'Tomografías',
    'Resonancias'
  ];
}

class Reportes {
  //  # # # # ### ### ### # # # # . # # # # ### ### ### # # # #
  //  Diccionario de Reportes.
  //  # # # # ### ### ### # # # # . # # # # ### ### ### # # # #
  static Map<String, dynamic> reportes = {
    "Motivo_Prequirurgico": Pacientes.motivoPrequirurgico(),
    "Tipo_Interrogatorio": Valores.tipoInterrogatorio,
    "Tipo_Cirugia": Valores.tipoCirugia,
    "Motivo_Cirugia": Valores.motivoCirugia,
    // "Antecedentes_No_Patologicos": Valores.tipoInterrogatorio,
    "Datos_Generales": Pacientes.prosa(),
    "Antecedentes_No_Patologicos":
        Pacientes.noPatologicos(), //"Sin información recabada",
    "Antecedetes_No_Patologicos_Analisis": Pacientes.noPatologicosAnalisis(),
    "Antecedentes_Patologicos_Otros": Pacientes.antecedentesPatologicos(),
    "Antecedentes_Patologicos_Ingreso":
        Pacientes.antecedentesIngresosPatologicos(),
    "Antecedentes_Heredofamiliares": Pacientes.heredofamiliares(),
    "Antecedentes_Quirurgicos": Pacientes.hospitalarios(),
    "Antecedentes_Patologicos": Pacientes.patologicos(),
    "Antecedentes_Perinatales": Pacientes.perinatales(),
    "Antecedentes_Sexuales": Pacientes.sexuales(),
    "Antecedentes_Alergicos": Pacientes.alergicos(),
    //
    "Motivo_Consulta": Reportes.motivoConsulta,
    "Subjetivo": Reportes.subjetivoHospitalizacion,
    "Padecimiento_Actual": Reportes.padecimientoActual,
    //
    "Signos_Vitales": Reportes.signosVitales,
    "Exploracion_Fisica": Reportes.exploracionFisica,
    //
    "Auxiliares_Diagnosticos": Reportes.auxiliaresDiagnosticos,
    "Analisis_Complementarios": Reportes.analisisComplementarios,
    //
    "Eventualidades": Reportes.eventualidadesOcurridas,
    "Analisis_Terapia":
        "${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}",
    "Analisis_Medico":
        "${Reportes.eventualidadesOcurridas} ${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}",
    "Recomendaciones_Generales": Reportes.tratamientoPropuesto,
    "Impresiones_Diagnosticas": Reportes.impresionesDiagnosticas,
    // ***************************************
    "Dieta": Reportes.dieta,
    "Hidroterapia": Reportes.hidroterapia,
    "Insulinoterapia": Reportes.insulinoterapia,
    "Hemoterapia": Reportes.hemoterapia,
    "Oxigenoterapia": Reportes.oxigenoterapia,
    "Medicamentos": Reportes.medicamentosIndicados,
    // ***************************************
    "Motivo_Procedimiento": Valores.motivoProcedimiento,
    "Procedimiento_Realizado": Reportes.procedimientoRealizado,
    "Complicaciones_Procedimiento": Valores.complicacionesProcedimiento,
    "Pendientes_Procedimiento": Valores.pendientesProcedimiento,
    // ***************************************
    "Motivo_Transfusion": "",
    "Hemotipo_Admnistrado": "",
    "Cantidad_Unidades": "",
    "Volumen_Administrado": "",
    "Num_Identificacion": "",
    "Inicio_Transfusion": "",
    "Termino_Transfusion": "",
    "Seguimiento_Vitales": "",
    "Estado_Final_Transfusion":
        "Se realiza seguimiento y control a la paciente durante la transfusión. Termina procedimiento sin complicaciones ni evidencia de reacciones adversas asociadas a la transfusión de hemoderivados. ",
    "Reacciones_Presentadas": "Ninguna manifestada durante la transfusión. ",
    // ***************************************
    "Medidas_Generales": Reportes.medidasGenerales,
    "Licencia_Medica": Reportes.licenciasMedicas, // ['Sin licencia médica'],
    "Pendientes": Reportes.pendientes, // ['Sin pendientes'],
    "Recomendaciones":
        Reportes.recomendacionesGenerales, // ['Sin recomendaciones'],
    "Citas": Reportes.citasMedicas, //  ['Cita de acuerdo a agenda'],
    "Pronostico_Medico": Reportes.pronosticoMedico
  };
  //  # # # # ### ### ### # # # # . # # # # ### ### ### # # # #
  //
  //  # # # # ### ### ### # # # # . # # # # ### ### ### # # # #
  static String datosGenerales = "";
  static String antecedentesHeredofamiliares = "";
  // static String antecedentesHospitalarios = "";
  static String padecimientoActual = "";
  static String? personalesPatologicos =
          "Sin antecedentes patológicos de importancia. ",
      antecedentesQuirurgicos = "Negados. ",
      antecedentesAlergicos = "Negados. ", // negados
      antecedentesTraumatologicos = "Negados. ",
      antecedentesPerinatales = "",
      antecedentesSexuales = "";
  //
  static String signosVitales = "",
      exploracionFisica = "Sin hallazgos relevantes en la exploración física";
  //
  static String auxiliaresDiagnosticos = "", analisisComplementarios = "";
  //
  static String eventualidadesOcurridas = "Sin eventualidades reportadas. ",
      terapiasPrevias = "",
      analisisMedico = "",
      tratamientoPropuesto = "";
  //
  static List<dynamic> analisisAnteriores = [];
  //
  static String impresionesDiagnosticas = "";
  static String pronosticoMedico = "";
  //
  static String motivoConsulta = "",
      subjetivoHospitalizacion =
          "El paciente se refiere ${Valores.estadoGeneral}. "
          "Via oral a base de ${Valores.viaOral}. "
          "Uresis con frecuencia ${Valores.uresisCantidad}, "
          "excretas con frecuencia ${Valores.excretasCantidad}. "
          "${Valores.referenciasHospitalizacion}. ";
  // "Sin rerencias particulares del paciente durante la hospitalización";
  //
  static String procedimientoRealizado = "", bibliografias = "";
  //
  static List<String> dieta = ['Ayuno hasta nueva orden.'];
  static List<String> hidroterapia = ['Sin terapia hídrica.'];
  static List<String> medicamentosIndicados = ['Sin medicamentos otorgados.'];
  static List<String> medidasGenerales = [
    'Cuidados generales de enfermería.',
    'Signos vitales por turno.',
    'Barandales en alto',
  ];

  static List<String> insulinoterapia = ['Sin terapia insulinica.'];
  static List<String> oxigenoterapia = [
    'Sin administración de oxígeno suplementario.'
  ];
  static List<String> hemoterapia = ['Sin reposicion sanguinea.'];
  //
  static List<String> licenciasMedicas = ['Sin licencia médica otorgada.'];
  static List<String> pendientes = ['Sin pendientes.'];
  static List<String> citasMedicas = ['Cita de acuerdo a agenda.'];
  static List<String> recomendacionesGenerales = [
    'Como parte de la orientación dietética se recomienda evitar: ayunos prolongados, consumo de alimentos azucarados, empanizados, fritos y capeados, alcohol, botanas, comida rápida. Reducir consumo de jugo de fruta, reducir porciones de alimentos y sal. Aumentar el consumo de agua simple, consumo de verduras y cereales integrales y realizar actividad física.'
  ];

  static void close() {
    datosGenerales = "";
    antecedentesHeredofamiliares = "";
    // antecedentesHospitalarios = "";
    antecedentesQuirurgicos = "";
    personalesPatologicos = "";
    antecedentesPerinatales = "";
    antecedentesSexuales = "";
    padecimientoActual = "";
    //
    signosVitales = "";
    exploracionFisica = "";
    //
    auxiliaresDiagnosticos = "";
    analisisComplementarios = "";
    //
    eventualidadesOcurridas = "";
    terapiasPrevias = "";
    analisisMedico = "";
    tratamientoPropuesto = "";
    //
    impresionesDiagnosticas = "";
    pronosticoMedico = "";
    //
    procedimientoRealizado = "";
    bibliografias = "";
    //
    medicamentosIndicados = [''];
    medidasGenerales = [''];
    licenciasMedicas = [''];
    pendientes = [''];
    citasMedicas = [''];
    recomendacionesGenerales = [''];

    // *** * *** *** *** * ***
    Hospitalizaciones.Hospitalizacion = {};
    // *** * *** *** *** * ***

    Pacientes.Patologicos = [];
    Pacientes.Quirurgicos = [];
    Pacientes.Alergicos = [];
    Pacientes.Transfusionales = [];
    Pacientes.Traumatologicos = [];
    Pacientes.Vitales = [];
    Pacientes.Vital = {};
    Patologicos.Degenerativos = {};

    Pacientes.Notas = [];
  }

  static String nombreReporte({int? indefOfReport = 0}) {
    switch (indefOfReport) {
      case 0: // Nota de ingreso
        return "(NG) - ${Pacientes.nombreCompleto} - (${Calendarios.today()}).pdf";
      case 1: // Nota de evolución
        return "(NE) - ${Pacientes.nombreCompleto} - (${Calendarios.today()}).pdf";
      case 2: // Nota de consulta externa
        return "(CE) - ${Pacientes.nombreCompleto} - (${Calendarios.today()}).pdf";
      case 3: // Nota de Terapia Intensiva
        return "(NT) - ${Pacientes.nombreCompleto} - (${Calendarios.today()}).pdf";
      case 4: // Nota de Valoración Prequirúrgica
        return "(N-VPO) - ${Pacientes.nombreCompleto} - (${Calendarios.today()}).pdf";
      case 5: // Nota de Valoración Preanestésica
        return "(N-ANES) - ${Pacientes.nombreCompleto} - (${Calendarios.today()}).pdf";
      case 6: // Nota de Egreso
        return "(PA) - ${Pacientes.nombreCompleto} - (${Calendarios.today()}).pdf";
      case 7: //
        return "(NE) - ${Pacientes.nombreCompleto} - (${Calendarios.today()}).pdf";
      case 8: //
        return "(CE) - ${Pacientes.nombreCompleto} - (${Calendarios.today()}).pdf";
      case 9: //
        return "(CE) - ${Pacientes.nombreCompleto} - (${Calendarios.today()}).pdf";
      case 10: //
        return "(CEN) - (${Calendarios.today()}).pdf";
      default: // Nota auxiliar por default
        return "(AUX) - ${Pacientes.nombreCompleto} - (${Calendarios.today()}).pdf";

      // Nota de Valoración Preanestésica
    }
  }

  static void consultarRegistros() {
    Constantes.reinit();
    // ************** **************** *********** ********** **
    // ************** **************** *********** ********** **
    // Patologicos.consultarRegistro();
    // Pacientes.diagnosticos();
    // Vitales.ultimoRegistro();
    // ************** **************** *********** ********** **
    // ************** **************** *********** ********** **
  }

  static copiarReporte({required TypeReportes tipoReporte}) {
    switch (tipoReporte) {
      case TypeReportes.reporteIngreso:
        return CopiasReportes.reporteIngreso(Reportes.reportes);
      case TypeReportes.reporteEvolucion:
        return CopiasReportes.reporteEvolucion(Reportes.reportes);
      case TypeReportes.reporteConsulta:
        return CopiasReportes.reporteConsulta(Reportes.reportes);
      case TypeReportes.reporteTerapiaIntensiva:
        return CopiasReportes.reporteTerapia(Reportes.reportes);
      default:
        return CopiasReportes.reporteIngreso(Reportes.reportes);
    }
  }
}

class Balances {
  static int ID_Balances = 0;
  static var fileAssocieted = '${Pacientes.localRepositoryPath}balances.json';

  // *********** *********** ********* ****
  static Map<String, dynamic> Balance = {};

  static List<String> actualDiagno = Opciones.horarios();

  // *********** *********** ********* ****

  static void consultarRegistro() {
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      // Asignación de Valores ********* ******** ******* ********* ***
      Balances.Balance = value;
      Balances.fromJson(value);
      // *********************************
    }).onError((error, stackTrace) {
      Actividades.consultarAllById(
              Databases.siteground_database_reghosp,
              Balances.balance['consultByIdPrimaryQuery'],
              Pacientes.ID_Paciente)
          .then((value) {
        // Asignación de Valores ********* ******** ******* ********* ***
        Balances.Balance = value[value.length - 1];
        Balances.fromJson(value[value.length - 1]);

        Terminal.printSuccess(
            message: "Valores de Balances Hídricos asignado : : : value");
        // Terminal.printData(message: "\t$value");
        Archivos.createJsonFromMap([value], filePath: fileAssocieted);
      });
    });
  }

  static void ultimoRegistro() {
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      // Asignación de Valores ********* ******** ******* ********* ***
      Balances.Balance = value;
      Balances.fromJson(value);
      // *********************************
    }).onError((error, stackTrace) {
      Actividades.consultarId(Databases.siteground_database_reghosp,
              Balances.balance['consultIdQuery'], Pacientes.ID_Paciente)
          .then((value) {
        if (value.containsKey('Error')) {
          Terminal.printExpected(
              message: "Balances Hídricos : : consultar registro - $value");
        } else {
          // Asignación de Valores ********* ******** ******* ********* ***
          Balances.Balance = value;
          Balances.fromJson(value);

          Terminal.printSuccess(
              message: "Valores de Balances Hídricos asignado : : : value");
          // Terminal.printData(message: "\t$value");
          Archivos.createJsonFromMap([value], filePath: fileAssocieted);
        }
      });
    });

    Actividades.consultarId(Databases.siteground_database_reghosp,
            Balances.balance['consultLastQuery'], Pacientes.ID_Paciente)
        .then((value) {
// Enfermedades de base del paciente, asi como las Hospitalarias.
      Balances.Balance = value;
    });
  }

  // *********** *********** ********* ****
  static final Map<String, dynamic> balance = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_bala;",
    "showColumns": "SHOW columns FROM pace_bala",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_bala'",
    "createQuery": """CREATE TABLE pace_bala (
                  ID_Bala int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  ID_Pace int(11) NOT NULL,
                  Pace_bala_Fecha date NOT NULL,
                  Pace_bala_Time time NOT NULL,
                  Pace_bala_Oral double NOT NULL,
                  Pace_bala_Sonda double NOT NULL,
                  Pace_bala_Hemo double NOT NULL,
                  Pace_bala_NPT double NOT NULL,
                  Pace_bala_Sol double NOT NULL,
                  Pace_bala_Dil double NOT NULL,
                  Pace_bala_ING double NOT NULL,
                  Pace_bala_Uresis double NOT NULL,
                  Pace_bala_Evac double NOT NULL,
                  Pace_bala_Sangrado double NOT NULL,
                  Pace_bala_Succion double NOT NULL,
                  Pace_bala_Drenes double NOT NULL,
                  Pace_bala_PER double NOT NULL,
                  Pace_bala_ENG double NOT NULL,
                  Pace_bala_HOR int NOT NULL 
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Registro de Líquidos en Pacientes Hospitalizados.';
            """,
    "truncateQuery": "TRUNCATE pace_bala",
    "dropQuery": "DROP TABLE pace_bala",
    "consultQuery": "SELECT * FROM pace_bala",
    "consultIdQuery": "SELECT * FROM pace_bala WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery":
        "SELECT * FROM pace_bala WHERE ID_Pace = ? ORDER BY Pace_bala_Fecha ASC",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_bala",
    "consultLastQuery":
        "SELECT * FROM pace_bala WHERE ID_Pace = ? ORDER BY ID_Bala ASC",
    "consultByName": "SELECT * FROM pace_bala WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO pace_bala (ID_Pace, Pace_bala_Fecha, "
        "Pace_bala_Time, "
        "Pace_bala_Oral, Pace_bala_Sonda, Pace_bala_Hemo, "
        "Pace_bala_NPT, Pace_bala_Sol, "
        "Pace_bala_Dil, Pace_bala_ING, Pace_bala_Uresis, "
        "Pace_bala_Evac, Pace_bala_Sangrado, "
        "Pace_bala_Succion, Pace_bala_Drenes, Pace_bala_PER, "
        "Pace_bala_ENG, Pace_bala_HOR) "
        "VALUES (?,?,?,?,?,?,?,?,?,?,"
        "?,?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_bala "
        "SET ID_Bala = ?, ID_Pace = ?, Pace_bala_Fecha = ?, Pace_bala_Time = ?, "
        "Pace_bala_Oral = ?, Pace_bala_Sonda = ?, Pace_bala_Hemo = ?, Pace_bala_NPT = ?, "
        "Pace_bala_Sol = ?, Pace_bala_Dil = ?, Pace_bala_ING = ?, Pace_bala_Uresis = ?, "
        "Pace_bala_Evac = ?, Pace_bala_Sangrado = ?, Pace_bala_Succion = ?, Pace_bala_Drenes "
        "= ?, Pace_bala_PER = ?, Pace_bala_ENG = ?, Pace_bala_HOR = ? "
        "WHERE ID_Bala = ?",
    "deleteQuery": "DELETE FROM pace_bala WHERE ID_Bala = ?",
    "balanceColumns": [
      "ID_Pace",
    ],
    "balanceItems": [
      "ID_Pace",
    ],
    "balanceColums": [
      "ID Paciente",
    ],
    "balanceStats": [
      "Total_Administradores",
    ],
    "balanceStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_bala WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_bala WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_bala WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };

  // *********** *********** ********* ****
  static void fromJson(Map<String, dynamic> json) {
    Terminal.printExpected(message: "Balances seleccionados $json");

    Balances.ID_Balances = json['ID_Bala'];
    Valores.fechaRealizacionBalances = json['Pace_bala_Fecha'];

    Valores.viaOralBalances =
        double.parse(json['Pace_bala_Oral'].toString() ?? '0');
    Valores.sondaOrogastricaBalances =
        double.parse(json['Pace_bala_Sonda'].toString() ?? '0');
    Valores.hemoderivadosBalances =
        double.parse(json['Pace_bala_Hemo'].toString() ?? '0');
    Valores.nutricionParenteralBalances =
        double.parse(json['Pace_bala_NPT'].toString() ?? '0');
    Valores.parenteralesBalances =
        double.parse(json['Pace_bala_Sol'].toString() ?? '0');
    Valores.dilucionesBalances =
        double.parse(json['Pace_bala_Dil'].toString() ?? '0');
    Valores.otrosIngresosBalances =
        double.parse(json['Pace_bala_ING'].toString() ?? '0');

    Valores.uresisBalances =
        double.parse(json['Pace_bala_Uresis'].toString() ?? '0');
    Valores.evacuacionesBalances =
        double.parse(json['Pace_bala_Evac'].toString() ?? '0');
    Valores.sangradosBalances =
        double.parse(json['Pace_bala_Sangrado'].toString() ?? '0');
    Valores.succcionBalances =
        double.parse(json['Pace_bala_Succion'].toString() ?? '0');
    Valores.drenesBalances =
        double.parse(json['Pace_bala_Drenes'].toString() ?? '0');
    Valores.otrosEgresosBalances =
        double.parse(json['Pace_bala_ENG'].toString() ?? '0');

    Valores.horario = json['Pace_bala_HOR'];
    Valores.uresis = double.parse(json['Pace_bala_Uresis'].toString() ?? '0');

    // Valores.balanceTotal = Valores.ingresos - Valores.egresos;
    // Valores.diuresis = (Valores.uresis / Valores.pesoCorporalTotal!) / Valores.horario;
  }
}

class Ventilaciones {
  static int ID_Ventilaciones = 0;
  //
  static String selectedDiagnosis = "";
  //

  static Map<String, dynamic> Ventilacion = {};

  static List<String> actualDiagno = [
    'Ningún modo ventilatorio',
    'Ventilación Limitada por Presión Ciclada por Tiempo (P-VMC / VCP)',
    'Ventilación Limitada por Flujo Ciclada por Volumen (V-VMC / VCV)',
    'Ventilación Mandatoria Intermitente Sincrónizada (SIMV / VCV)',
    'Ventilación Mandatoria Intermitente Sincrónizada (SIMV / VCP)',
    'Presión Positiva en Vía Aérea con Presión Soporte (CPAP / PS)',
    'Espontáneo (ESPON)',
  ];

  static String modoVentilatorio ({required String modalidadVentilatoria}){
    if (modalidadVentilatoria ==
        'Ventilación Limitada por Presión Ciclada por Tiempo (P-VMC / VCP)') {
      return 'AC-VCP'; // # 'P-VMC/VCP';
    } else if (modalidadVentilatoria ==
        'Ventilación Limitada por Flujo Ciclada por Volumen (V-VMC / VCV)') {
      return 'AC-VCV'; // # 'V-VMC/VCV';
    } else if (modalidadVentilatoria ==
        'Ventilación Mandatoria Intermitente Sincrónizada (SIMV / VCV)') {
      return 'SIMV/VCV';
    } else if (modalidadVentilatoria ==
        'Ventilación Mandatoria Intermitente Sincrónizada (SIMV / VCP)') {
      return 'SIMV/VCP';
    } else if (modalidadVentilatoria ==
        'Presión Positiva en Vía Aérea con Presión Soporte (CPAP / PS)') {
      return 'CPAP/PS';
    } else if (modalidadVentilatoria == 'Espontáneo (ESPON)') {
      return 'ESPON';
    } else {
      return ' ';
    }
  }

  static void ultimoRegistro() {
    Actividades.consultarId(
            Databases.siteground_database_reghosp,
            Ventilaciones.ventilacion['consultLastQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
// Enfermedades de base del paciente, asi como las Hospitalarias.
      Ventilaciones.Ventilacion = value;
    });
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_reghosp,
            Ventilaciones.ventilacion['consultIdQuery'], Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Ventilaciones = value;
    });
  }

  static final Map<String, dynamic> ventilacion = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_vm;",
    "showColumns": "SHOW columns FROM pace_vm",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_vm'",
    "createQuery": """CREATE TABLE pace_vm (
                  ID_Ventilacion int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  ID_Pace int(11) NOT NULL,
                  Feca_VEN date NOT NULL,
                  Pace_Vt double NOT NULL,
                  Pace_Fr int(11) NOT NULL,
                  Pace_Fio int(11) NOT NULL,
                  Pace_Peep int(11) NOT NULL,
                  Pace_Insp int(11) NOT NULL,
                  Pace_Espi int(11) NOT NULL,
                  Pace_Pc int(11) NOT NULL,
                  Pace_Pm int(11) NOT NULL,
                  Pace_V int(11) NOT NULL,
                  Pace_F int(11) NOT NULL,
                  Pace_Ps int(11) NOT NULL,
                  Pace_Pip int(11) NOT NULL,
                  Pace_Pmet int(11) NOT NULL,
                  VM_Mod varchar(200) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Registro de Valores de Ventilación Mecánica';
            """,
    "truncateQuery": "TRUNCATE pace_vm",
    "dropQuery": "DROP TABLE pace_vm",
    "consultQuery": "SELECT * FROM pace_vm",
    "consultIdQuery": "SELECT * FROM pace_vm WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_vm WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_vm",
    "consultLastQuery":
        "SELECT * FROM pace_vm WHERE ID_Pace = ? ORDER BY ID_Ventilacion ASC",
    "consultByName": "SELECT * FROM pace_vm WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO pace_vm (ID_Pace, "
        "Feca_VEN, Pace_Vt, Pace_Fr, Pace_Fio, Pace_Peep, Pace_Insp, "
        "Pace_Espi, Pace_Pc, Pace_Pm, Pace_V, Pace_F, Pace_Ps, Pace_Pip, "
        "Pace_Pmet, VM_Mod) "
        "VALUES (?,?,?,?,?,?,?,?,?,?,"
        "?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_vm "
        "SET ID_Ventilacion = ?,  ID_Pace = ?,  Feca_VEN = ?,  "
        "Pace_Vt = ?,  Pace_Fr = ?,  Pace_Fio = ?,  Pace_Peep = ?,  "
        "Pace_Insp = ?,  Pace_Espi = ?,  Pace_Pc = ?,  Pace_Pm = ?,  "
        "Pace_V = ?,  Pace_F = ?,  Pace_Ps = ?,  Pace_Pip = ?,  "
        "Pace_Pmet = ?,  VM_Mod = ? "
        "WHERE ID_Ventilacion = ?",
    "deleteQuery": "DELETE FROM pace_vm WHERE ID_Ventilacion = ?",
    "ventilacionColumns": [
      "ID_Pace",
    ],
    "ventilacionItems": [
      "ID_Pace",
    ],
    "ventilacionColums": [
      "ID Paciente",
    ],
    "ventilacionStats": [
      "Total_Administradores",
    ],
    "ventilacionStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_vm WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_vm WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_vm WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
}

class Hospitalizaciones {
  static Map<String, dynamic> Hospitalizacion = {};

  static List<String> actualDiagno = Opciones.horarios();

  static fromJson(Map<String, dynamic> json) {
    Pacientes.ID_Hospitalizacion = json['ID_Hosp'] ?? 0;
    Hospitalizaciones.Hospitalizacion['ID_Hosp'] = Pacientes.ID_Hospitalizacion;
    // ******************************************** *** *
    Valores.fechaIngresoHospitalario = json['Feca_INI_Hosp'] ?? '';
    Hospitalizaciones.Hospitalizacion['Feca_INI_Hosp'] =
        Valores.fechaIngresoHospitalario;
    Valores.numeroCama = json['Id_Cama'] ?? 'N/A';
    Hospitalizaciones.Hospitalizacion['Id_Cama'] = Valores.numeroCama;
    Valores.medicoTratante = json['Medi_Trat'] ?? '';
    Hospitalizaciones.Hospitalizacion['Medi_Trat'] = Valores.medicoTratante;
    Valores.servicioTratante = json['Serve_Trat'] ?? '';
    Hospitalizaciones.Hospitalizacion['Serve_Trat'] = Valores.servicioTratante;
    Valores.servicioTratanteInicial = json['Serve_Trat_INI'] ?? '';
    Hospitalizaciones.Hospitalizacion['Serve_Trat_INI'] =
        Valores.servicioTratanteInicial;
    Valores.fechaEgresoHospitalario = json['Feca_EGE_Hosp'] ?? '';
    Hospitalizaciones.Hospitalizacion['Feca_EGE_Hosp'] =
        Valores.fechaEgresoHospitalario;
    Valores.motivoEgreso = json['EGE_Motivo'] ?? '';
    Hospitalizaciones.Hospitalizacion['EGE_Motivo'] = Valores.motivoEgreso;
  }

  static void ultimoRegistro() {
    Actividades.consultarId(Databases.siteground_database_reghosp,
            hospitalizacion['consultLastQuery'], Pacientes.ID_Paciente)
        .then((value) {
// Enfermedades de base del paciente, asi como las Hospitalarias.
      Hospitalizacion = value;
    });
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_reghosp,
            hospitalizacion['consultIdQuery'], Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Hospitalizaciones = value;
    });
  }

  static final Map<String, dynamic> hospitalizacion = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_reghosp "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_reghosp",
    "describeTable": "DESCRIBE pace_hosp;",
    "showColumns": "SHOW columns FROM pace_hosp",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_hosp'",
    "createQuery": """
    CREATE TABLE pace_hosp (
              ID_Hosp int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              ID_Pace int(11) NOT NULL,
              Feca_INI_Hosp date NOT NULL,
              Id_Cama int(11) NOT NULL,
              Dia_Estan int(11) NOT NULL,
              Medi_Trat varchar(300) COLLATE utf8_unicode_ci NOT NULL,
              Serve_Trat varchar(300) COLLATE utf8_unicode_ci NOT NULL,
              Serve_Trat_INI varchar(300) COLLATE utf8_unicode_ci NOT NULL,
              Feca_EGE_Hosp date NOT NULL,
              EGE_Motivo varchar(100) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla Inicial para la Hospitalizacion de Pacientes.';
            """,
    "truncateQuery": "TRUNCATE pace_hosp",
    "dropQuery": "DROP TABLE pace_hosp",
    "consultQuery": "SELECT * FROM pace_hosp WHERE",
    "consultIdQuery":
        "SELECT * FROM pace_hosp WHERE ID_Pace = ? ORDER BY ID_Hosp ASC",
    "consultIdLastQuery": "SELECT * FROM pace_hosp WHERE ID_Pace = ? "
        "ORDER BY ID_Hosp DESC",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_hosp WHERE ID_Hosp = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_hosp",
    "consultLastQuery":
        "SELECT * FROM pace_hosp WHERE ID_Pace = ? ORDER BY ID_Hosp ASC",
    "consultByName": "SELECT * FROM pace_hosp WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO pace_hosp (ID_Pace, "
        "Feca_INI_Hosp, Id_Cama, Dia_Estan, Medi_Trat, Serve_Trat, Serve_Trat_INI, "
        "Feca_EGE_Hosp, EGE_Motivo) "
        "VALUES (?,?,?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_hosp "
        "SET ID_Hosp = ?,  ID_Pace = ?,  Feca_INI_Hosp = ?,  "
        "Id_Cama = ?,  Dia_Estan = ?,  Medi_Trat = ?,  Serve_Trat = ?,  Serve_Trat_INI = ?, "
        "Feca_EGE_Hosp = ?,  EGE_Motivo = ? "
        "WHERE ID_Hosp =  ?",
    "deleteQuery": "DELETE FROM pace_hosp WHERE ID_Hosp = ?",
    "HospitalizacionColumns": [
      "ID_Pace",
    ],
    "HospitalizacionItems": [
      "ID_Pace",
    ],
    "HospitalizacionColums": [
      "ID Paciente",
    ],
    "Hospitalizaciontats": [
      "Total_Administradores",
    ],
    "Hospitalizaciontadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_hosp WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_hosp WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_hosp WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
}

class Diagnosticos {
  static int ID_Diagnosticos = 0;
  static var fileAssocieted =
      '${Pacientes.localRepositoryPath}diagnosticos.json';
  //
  static String selectedDiagnosis = "";
  //

  static Map<String, dynamic> Diagnostico = {};

  static List<String> actualDiagno = Dicotomicos.dicotomicos();
  static List<String> actualTratamiento = Dicotomicos.dicotomicos();
  static List<String> actualSuspendido = Dicotomicos.dicotomicos();

  static void registros() {
    Actividades.consultarAllById(
            Databases.siteground_database_reghosp,
            Diagnosticos.diagnosticos['consultByIdPrimaryQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      Pacientes.Diagnosticos = value;
      Archivos.createJsonFromMap(value,
          filePath: "${Pacientes.localRepositoryPath}diagnosticos.json");
    });
  }

  static void ultimoRegistro() {
    Actividades.consultarId(
            Databases.siteground_database_reghosp,
            Diagnosticos.diagnosticos['consultLastQuery'],
            Pacientes.ID_Hospitalizacion)
        .then((value) {
      Diagnosticos.Diagnostico =
          value; // Enfermedades de base del paciente, asi como las Hospitalarias.
    });
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(
            Databases.siteground_database_reghosp,
            Diagnosticos.diagnosticos['consultIdQuery'],
            Pacientes.ID_Hospitalizacion)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Diagnosticos = value;
      Archivos.createJsonFromMap(value,
          filePath: "${Pacientes.localRepositoryPath}diagnosticos.json");
    });
  }

  static final Map<String, dynamic> diagnosticos = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_dia;",
    "showColumns": "SHOW columns FROM pace_dia",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_dia'",
    "createQuery": """
    CREATE TABLE `pace_dia` (
                  `ID_PACE_APP_DEG` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `ID_Pace` int(11) NOT NULL,
                  `ID_Hosp` int(11) NOT NULL,
                  `Pace_APP_DEG_SINO` tinyint(1) NOT NULL,
                  `Pace_APP_DEG` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_APP_DEG_com` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_APP_DEG_dia` DATE NOT NULL,
                  `Pace_APP_DEG_tra_SINO` tinyint(1) NOT NULL,
                  `Pace_APP_DEG_tra` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_APP_DEG_sus_SINO` tinyint(1) NOT NULL,
                  `Pace_APP_DEG_sus` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8
                COLLATE=utf8_unicode_ci
                COMMENT='Tabla para Diagnósticos Intrahospitalarios';
            """,
    "truncateQuery": "TRUNCATE pace_dia",
    "dropQuery": "DROP TABLE pace_dia",
    "consultQuery": "SELECT * FROM pace_dia",
    "consultIdQuery": "SELECT * FROM pace_dia WHERE ID_Hosp = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_dia WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_dia",
    "consultLastQuery": "SELECT * FROM pace_dia WHERE ID_Hosp = ?",
    "consultByName": "SELECT * FROM pace_dia WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO `pace_dia` (ID_Pace, ID_Hosp, Pace_APP_DEG_SINO, "
        "Pace_APP_DEG, Pace_APP_DEG_com, Pace_APP_DEG_dia, Pace_APP_DEG_tra_SINO, "
        "Pace_APP_DEG_tra, Pace_APP_DEG_sus_SINO, Pace_APP_DEG_sus) "
        "VALUES (?,?,?,?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_dia "
        "SET ID_PACE_APP_DEG = ?,  ID_Pace = ?,  ID_Hosp = ?,  Pace_APP_DEG_SINO = ?,  "
        "Pace_APP_DEG = ?,  Pace_APP_DEG_com = ?,  Pace_APP_DEG_dia = ?,  "
        "Pace_APP_DEG_tra_SINO = ?,  Pace_APP_DEG_tra = ?,  Pace_APP_DEG_sus_SINO = ?,  "
        "Pace_APP_DEG_sus = ? "
        "WHERE ID_PACE_APP_DEG = ?",
    "deleteQuery": "DELETE FROM pace_dia WHERE ID_PACE_APP_DEG = ?",
    "vitalesColumns": [
      "ID_Pace",
    ],
    "vitalesItems": [
      "ID_Pace",
      "Nombre_Completo",
      "Apellido_Paterno",
      "Apellido_Materno",
      "Paciente",
      "Contraseña",
      "Permisos",
      "Especialización",
      "Area",
      "Estatus",
      "Anexado_por"
    ],
    "vitalesColums": [
      "ID Paciente",
      "Nombre Completo",
      "Apellido Paterno",
      "Apellido Materno",
      "Paciente",
      "Contraseña",
      "Permiso(s)",
      "Especialización",
      "Area",
      "Estatus",
      "Anexado Por"
    ],
    "vitalesStats": [
      "Total_Administradores",
      "Total_Mip",
      "Total_Mpss",
      "Total_Mg",
      "Total_Medesp",
      "Total_Tegra",
      "Total_Enfra",
      "Total_Enfesp",
      "Total_Tec",
      "Total_Secre",
      "Total_Captu",
      "Total_Inge",
      "Total_Directivos",
      "Total_Guardias",
      "Total_Logistica",
      "Total_Mantenimiento",
      "Total_Traslado_Intra",
      "otal_Traslado_Extra",
    ],
    "vitalesStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_sv WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_sv WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_sv WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
}

class Repositorios {
  static Map<String, dynamic> Repositorio = {};

  static List<String> actualDiagno = Opciones.horarios();

  static void padecimientoActual() {
    Actividades.consultarId(
            Databases.siteground_database_reghosp,
            Repositorios.repositorio['consultarPadecimientoActualQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
// Enfermedades de base del paciente, asi como las Hospitalarias.
      Reportes.padecimientoActual = "${value['TipoAnalisis']}. ";
      Repositorio = value;
    });
  }

  static void consultarAnalisis() {
    Actividades.consultarAllById(
            Databases.siteground_database_reghosp,
            Repositorios.repositorio['consultAnalisisQuery'],
            Pacientes.ID_Hospitalizacion)
        .then((value) {
      Terminal.printExpected(message: "ANALISIS - $value ${value.runtimeType}");
      Reportes.analisisMedico = value.last['Contexto'] ?? '';
      Reportes.analisisAnteriores = value;
    });
  }

  static void actualizarRegistro() {
    Actividades.actualizar(
      Databases.siteground_database_reghosp,
      Repositorios.repositorio['updateQuery'],
      [
        Valores.padecimientoActual,
        Pacientes.ID_Hospitalizacion,
        Items.tiposAnalisis[0],
      ],
      Pacientes.ID_Paciente,
    ).whenComplete(() => Terminal.printExpected(
        message: "PA : : ${Valores.padecimientoActual}"));
  }

  static void registrarRegistro() {
    Actividades.registrar(
      Databases.siteground_database_reghosp,
      Repositorios.repositorio['registerQuery'],
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Calendarios.today(format: 'yyyy/MM/dd'),
        Calendarios.today(format: 'yyyy/MM/dd'),
        Valores.servicioTratante,
        '', // Valores.padecimientoActual,
        Items.tiposAnalisis[0],
      ],
    );
  }

  static void registrarAnalisis() {
    Actividades.registrar(
      Databases.siteground_database_reghosp,
      Repositorios.repositorio['registerQuery'],
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores.fechaPadecimientoActual,
        Calendarios.today(format: 'yyyy/MM/dd'),
        Valores.servicioTratante,
        Reportes.analisisMedico, //'', // Valores.padecimientoActual,
        Items.tiposAnalisis[1],
      ],
    )
        .then((value) =>
            Terminal.printExpected(message: "SUCCESS - Análisis registrado"))
        .onError((error, stackTrace) =>
            Terminal.printAlert(message: "ERROR - $error : : $stackTrace"));
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_reghosp,
            Repositorio['consultIdQuery'], Pacientes.ID_Paciente)
        .then((value) {
      Reportes.analisisAnteriores = value;
    });
  }

  static final Map<String, dynamic> repositorio = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_reghosp "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_reghosp",
    "describeTable": "DESCRIBE pace_hosp_repo;",
    "showColumns": "SHOW columns FROM pace_hosp_repo",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_hosp_repo'",
    "createQuery": """CREATE TABLE pace_hosp_repo (
              ID_Compendio int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              ID_Pace int(11) NOT NULL,
              ID_Hosp int(11) NOT NULL,
              FechaPadecimiento date NOT NULL,
              FechaRealizacion date NOT NULL,
              ServicioMedico varchar(150) COLLATE utf8_unicode_ci NOT NULL,
              Contexto varchar(3000) COLLATE utf8_unicode_ci NOT NULL,
              TipoAnalisis varchar(150) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Almacenar Análisis por Reporte del Paciente.';
            """,
    "truncateQuery": "TRUNCATE pace_hosp_repo",
    "dropQuery": "DROP TABLE pace_hosp_repo",
    "consultQuery": "SELECT * FROM pace_hosp_repo WHERE",
    "consultPadecimientoQuery":
        "SELECT * FROM pace_hosp_repo WHERE ID_Hosp = ? "
            "AND TipoAnalisis = 'Padecimiento Actual'",
    "consultAnalisisQuery": "SELECT * FROM pace_hosp_repo WHERE ID_Hosp = ? "
        "AND TipoAnalisis = 'Análisis Médico' ORDER BY FechaRealizacion ASC",
    "consultIdQuery": "SELECT * FROM pace_hosp_repo WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_hosp_repo WHERE ID_Hosp = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_hosp_repo",
    "consultarPadecimientoActualQuery":
        "SELECT TipoAnalisis, Contexto FROM pace_hosp_repo "
            "WHERE TipoAnalisis = '${Items.tiposAnalisis[0]}' "
            "AND ID_Hosp = '${Pacientes.ID_Hospitalizacion}' "
            "AND ID_Pace = ? ORDER Y ID_Hosp DESC",
    "consultLastQuery":
        "SELECT * FROM pace_hosp_repo WHERE ID_Pace = ? ORDER BY ID_Hosp DESC",
    "consultByName": "SELECT * FROM pace_hosp_repo WHERE Pace_APP_DEG LIKE '%",
    "registerQuery":
        "INSERT INTO pace_hosp_repo (ID_Pace, ID_Hosp, FechaPadecimiento, FechaRealizacion, "
            "ServicioMedico, Contexto, TipoAnalisis) "
            "VALUES (?,?,?,?,?,?,?)",
    "updateQuery":
        "UPDATE pace_hosp_repo SET Contexto = ? WHERE ID_Hosp = ? AND TipoAnalisis = ?",
    "deleteQuery": "DELETE FROM pace_hosp_repo WHERE ID_Compendio = ?",
    "RepositorioColumns": [
      "ID_Pace",
    ],
    "RepositorioItems": [
      "ID_Pace",
    ],
    "RepositorioColums": [
      "ID Paciente",
    ],
    "Repositoriotats": [
      "Total_Administradores",
    ],
    "Repositoriotadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_hosp_repo WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_hosp_repo WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_hosp_repo WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
}

class Situaciones {
  static int ID_Situaciones = 0;

  static Map<String, dynamic> Situacion = {};

  static List<String> actualDiagno = Opciones.horarios();

  static void ultimoRegistro() {
    Actividades.consultarId(Databases.siteground_database_reghosp,
            situacion['consultLastQuery'], Pacientes.ID_Paciente)
        .then((value) {
// Enfermedades de base del paciente, asi como las Hospitalarias.
      Situacion = value;
      Situaciones.ID_Situaciones = value['ID_Siti'] ?? 0;
    });
  }

  static void actualizarRegistro() {
    Actividades.actualizar(
      Databases.siteground_database_reghosp,
      Situaciones.situacion['updateQuery'],
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        'Hosp_Siti',
        Valores.dispositivoOxigeno,
        Dicotomicos.fromBoolean(Valores.isCateterPeriferico!, toInt: true),
        Dicotomicos.fromBoolean(Valores.isCateterLargoPeriferico!, toInt: true),
        Dicotomicos.fromBoolean(Valores.isCateterVenosoCentral!, toInt: true),
        Dicotomicos.fromBoolean(Valores.isCateterHemodialisis!, toInt: true),
        Dicotomicos.fromBoolean(Valores.isSondaFoley!, toInt: true),
        Dicotomicos.fromBoolean(Valores.isSondaNasogastrica!, toInt: true),
        Dicotomicos.fromBoolean(Valores.isSondaOrogastrica!, toInt: true),
        Dicotomicos.fromBoolean(Valores.isDrenajePenrose!, toInt: true),
        Dicotomicos.fromBoolean(Valores.isPleuroVac!, toInt: true),
        Dicotomicos.fromBoolean(Valores.isColostomia!, toInt: true),
        Dicotomicos.fromBoolean(Valores.isGastrostomia!, toInt: true),
        Dicotomicos.fromBoolean(Valores.isDialisisPeritoneal!, toInt: true),
        Pacientes.ID_Hospitalizacion,
      ],
      Pacientes.ID_Paciente,
    ).whenComplete(() => Terminal.printAlert(
        message: 'Situación Hospitalaria Actualizada . . . '));
  }

  static void registrarRegistro() {
    Actividades.registrar(
      Databases.siteground_database_reghosp,
      Situaciones.situacion['registerQuery'],
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        'Hosp_Siti',
        Valores.dispositivoOxigeno,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
      ],
    ).whenComplete(() => Terminal.printAlert(
        message: 'Situación Hospitalaria Registrada . . . '));
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_reghosp,
            situacion['consultIdQuery'], Pacientes.ID_Paciente)
        .then((value) {
      Situaciones.ID_Situaciones = value.last['ID_Siti'];
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      // Pacientes.Situaciones = value;
    });
  }

  static final Map<String, dynamic> situacion = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_reghosp "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_reghosp",
    "describeTable": "DESCRIBE siti_pace;",
    "showColumns": "SHOW columns FROM siti_pace",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'siti_pace'",
    "createQuery": """ CREATE TABLE siti_pace (
                    ID_Siti int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                    ID_Pace int(11) NOT NULL,
                    ID_Hosp int(11) NOT NULL,
                    Hosp_Siti varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                    Disp_Oxigen varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                    CVP tinyint(1) NOT NULL,
                    CVLP tinyint(1) NOT NULL,
                    CVC tinyint(1) NOT NULL,
                    MAH tinyint(1) NOT NULL,
                    S_Foley tinyint(1) NOT NULL,
                    SNG tinyint(1) NOT NULL,
                    SOG tinyint(1) NOT NULL,
                    Drenaje tinyint(1) NOT NULL,
                    Pleuro_Vac tinyint(1) NOT NULL,
                    Colostomia tinyint(1) NOT NULL,
                    Gastrostomia tinyint(4) NOT NULL,
                    Dialisis_Peritoneal tinyint(4) NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla de Registro de Situacion Hospitalaria.';
            """,
    "truncateQuery": "TRUNCATE siti_pace",
    "dropQuery": "DROP TABLE siti_pace",
    "consultQuery": "SELECT * FROM siti_pace WHERE ID_Hosp = ?",
    "consultPadecimientoQuery": "SELECT * FROM siti_pace WHERE ID_Hosp = ? "
        "AND TipoAnalisis = 'Padecimiento Actual'",
    "consultIdQuery": "SELECT * FROM siti_pace WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM siti_pace WHERE ID_Hosp = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM siti_pace",
    "consultLastQuery":
        "SELECT * FROM siti_pace WHERE ID_Pace = ? ORDER BY ID_Hosp ASC",
    "consultByName": "SELECT * FROM siti_pace WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO siti_pace (ID_Pace, ID_Hosp, "
        "Hosp_Siti, Disp_Oxigen, CVP, CVLP, CVC, MAH, "
        "S_Foley, SNG, SOG, Drenaje, Pleuro_Vac, "
        "Colostomia, Gastrostomia, Dialisis_Peritoneal) "
        "VALUES (?,?,?,?,?,?,?,?,?,?,?,"
        "?,?,?,?,?)",
    "updateQuery": "UPDATE siti_pace "
        "SET ID_Pace = ?, ID_Hosp = ?, Hosp_Siti = ?, "
        "Disp_Oxigen = ?, CVP = ?, CVLP = ?, CVC = ?, MAH = ?, S_Foley = ?, "
        "SNG = ?, SOG = ?, Drenaje = ?, Pleuro_Vac = ?, Colostomia = ?, "
        "Gastrostomia = ?, Dialisis_Peritoneal = ? "
        "WHERE ID_Hosp = ?",
    "deleteQuery": "DELETE FROM siti_pace WHERE ID_Hosp = ?",
    "situacionColumns": [
      "ID_Pace",
    ],
    "situacionItems": [
      "ID_Pace",
    ],
    "situacionColums": [
      "ID Paciente",
    ],
    "situaciontats": [
      "Total_Administradores",
    ],
    "situaciontadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM siti_pace WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM siti_pace WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM siti_pace WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
}

class Expedientes {
  static int ID_Expedientes = 0;

  static Map<String, dynamic> Expediente = {};

  static List<String> actualDiagno = Opciones.horarios();

  static void ultimoRegistro() {
    Actividades.consultarId(Databases.siteground_database_reghosp,
            expedientes['consultLastQuery'], Pacientes.ID_Paciente)
        .then((value) {
// Enfermedades de base del paciente, asi como las Hospitalarias.
      Expediente = value;
      Expedientes.ID_Expedientes = value['ID_Expe'] ?? 0;
    });
  }

  static void actualizarRegistro() {
    Actividades.actualizar(
      Databases.siteground_database_reghosp,
      Expedientes.expedientes['updateQuery'],
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromBoolean(Valores.isPortada!, toInt: true),
        Dicotomicos.fromBoolean(Valores.isHistoriaClinica!, toInt: true),
        Dicotomicos.fromBoolean(Valores.isNotaIngreso!, toInt: true),
        Dicotomicos.fromBoolean(Valores.isEvaluacionInicial!, toInt: true),
        Dicotomicos.fromBoolean(Valores.isValoracionVademecum!, toInt: true),
        Dicotomicos.fromBoolean(Valores.isConsentimientos!, toInt: true),
        Dicotomicos.fromBoolean(Valores.isOrdenado!, toInt: true),
        Pacientes.ID_Hospitalizacion,
      ],
      Pacientes.ID_Paciente,
    ).then((value) {
      // // print(value)
    });
  }

  static void registrarRegistro() {
    Actividades.registrar(
      Databases.siteground_database_reghosp,
      Expedientes.expedientes['registerQuery'],
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
      ],
    ).whenComplete(() => Terminal.printAlert(
        message: 'Expediente Hospitalario Registrado . . . '));
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_reghosp,
            expedientes['consultLastQuery'], Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Expedientes.ID_Expedientes = value.last['ID_Expe'];
    });
  }

  static final Map<String, dynamic> expedientes = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_reghosp "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_reghosp",
    "describeTable": "DESCRIBE expe_pace;",
    "showColumns": "SHOW columns FROM expe_pace",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'expe_pace'",
    "createQuery": """CREATE TABLE expe_pace (
                  ID_Expe int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  ID_Pace int(10) NOT NULL,
                  ID_Hosp int(11) NOT NULL,
                  POR tinyint(1) NOT NULL,
                  HIS tinyint(1) NOT NULL,
                  ING tinyint(1) NOT NULL,
                  EVA tinyint(1) NOT NULL,
                  VAL tinyint(1) NOT NULL,
                  CON tinyint(1) NOT NULL,
                  ORD tinyint(1) NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Registro de Estado de Expediente Clinico.';
            """,
    "truncateQuery": "TRUNCATE expe_pace",
    "dropQuery": "DROP TABLE expe_pace",
    "consultQuery": "SELECT * FROM expe_pace WHERE ID_Hosp = ?",
    "consultIdQuery": "SELECT * FROM expe_pace WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM expe_pace WHERE ID_Hosp = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM expe_pace",
    "consultLastQuery":
        "SELECT * FROM expe_pace WHERE ID_Pace = ? ORDER BY ID_Hosp ASC",
    "consultByName": "SELECT * FROM expe_pace WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO expe_pace (ID_Pace, ID_Hosp, "
        "POR, HIS, ING, EVA, VAL, CON, ORD) "
        "VALUES (?,?,?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE expe_pace "
        "SET ID_Pace = ?, ID_Hosp = ?, POR = ?, HIS = ?, ING = ?, "
        "EVA = ?, VAL = ?, CON = ?, ORD = ? "
        "WHERE ID_Hosp = ?",
    "deleteQuery": "DELETE FROM expe_pace WHERE ID_Hosp = ?",
    "ExpedienteColumns": [
      "ID_Pace",
    ],
    "ExpedienteItems": [
      "ID_Pace",
    ],
    "ExpedienteColums": [
      "ID Paciente",
    ],
    "Expedientetats": [
      "Total_Administradores",
    ],
    "Expedientetadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM expe_pace WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM expe_pace WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM expe_pace WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
}

class Licencias {
  static int ID_Licencias = 0;
  //
  static void fromJson(Map<String, dynamic> json) {
    Valores.folioLicencia = json['Folio'];
    Valores.diasOtorgadosLicencia = json['Dias_Otorgados'].toString();
    Valores.fechaRealizacionLicencia = json['Fecha_Realizacion'];
    Valores.fechaInicioLicencia = json['Fecha_Inicio'];
    Valores.fechaTerminoLicencia = json['Fecha_Termino'];
    Valores.motivoLicencia = json['Motivo_Incapacidad'];
    Valores.caracterLicencia = json['Caracter'];
    Valores.lugarExpedicionLicencia = json['Lugar_Expedicion'];
    Valores.diagnosticoLicencia = json['Diagnos_Expedicion'];
  }

  //

  static Map<String, dynamic> Licencia = {};

  static List<String> typesLicencias = Items.typesLicencias;
  static List<String> lugarExpedicion = Items.lugarExpedicion;
  static List<String> caracterLicencia = Items.caracterLicencia;

  static void ultimoRegistro() {
    Actividades.consultarId(Databases.siteground_database_reghosp,
            Licencias.vicencia['consultLastQuery'], Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Licencias.Licencia = value;
      //
      Valores.folioLicencia = value['Folio'];
      Valores.diasOtorgadosLicencia = value['Dias_Otorgados'].toString();
      Valores.fechaRealizacionLicencia = value['Fecha_Realizacion'];
      Valores.fechaInicioLicencia = value['Fecha_Inicio'];
      Valores.fechaTerminoLicencia = value['Fecha_Termino'];
      Valores.motivoLicencia = value['Motivo_Incapacidad'];
      Valores.caracterLicencia = value['Caracter'];
      Valores.lugarExpedicionLicencia = value['Lugar_Expedicion'];
      Valores.diagnosticoLicencia = value['Diagnos_Expedicion'];
    });
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_reghosp,
            Licencias.vicencia['consultIdQuery'], Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Licencias = value;
      // print("Pacientes.Licencias ${Pacientes.Licencias}");
    });
  }

  static String porTipoEstudio({int? indice = 0, String fechaActual = ""}) {
    // Filtro por estudio de los registros de Pacientes.Paraclinicos
    var aux = Pacientes.Licencias!
        .where((user) =>
            user["Tipo_Estudio"].contains(Auxiliares.Categorias[indice!]))
        .toList();
    // Inicio del formato de la prosa.
    if (fechaActual == "") {
      fechaActual = aux[0]['Fecha_Registro'];
    }
    //
    String prosa = "${Auxiliares.Categorias[indice!]} ($fechaActual): ";
    String max = "";
    // Anexación de los valores correlacionados.
    for (var element in aux) {
      if (element['Fecha_Registro'] == fechaActual) {
        if (max == "") {
          max =
              "${element['Estudio']} ${element['Resultado']} ${element['Unidad_Medida']}";
        } else {
          max =
              "$max, ${element['Estudio']} ${element['Resultado']} ${element['Unidad_Medida']}";
        }
      }
    }
    // Devolución de la prosa.
    return "$prosa$max. ";
  }

  static final Map<String, dynamic> vicencia = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE licen_med;",
    "showColumns": "SHOW columns FROM licen_med",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'licen_med'",
    "createQuery": """CREATE TABLE licen_med (
                          ID_Licen_Med int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                          ID_Pace int(10) NOT NULL,
                          Folio varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          Dias_Otorgados int(10) NOT NULL,
                          Fecha_Realizacion date NOT NULL,
                          Fecha_Inicio date NOT NULL,
                          Fecha_Termino date NOT NULL,
                          Motivo_Incapacidad varchar(200) COLLATE utf8_unicode_ci NOT NULL, 
                          Caracter varchar(200) COLLATE utf8_unicode_ci NOT NULL, 
                          Lugar_Expedicion varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          Diagnos_Expedicion varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 
                    COLLATE=utf8_unicode_ci 
                    COMMENT='Tabla para Registro de Expedición de Licencias Médicas.';
            """,
    "truncateQuery": "TRUNCATE licen_med",
    "dropQuery": "DROP TABLE licen_med",
    "consultQuery": "SELECT * FROM licen_med",
    "consultIdQuery":
        "SELECT * FROM licen_med WHERE ID_Pace = ? ORDER BY Fecha_Realizacion DESC",
    "consultByIdPrimaryQuery": "SELECT * FROM licen_med WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM licen_med",
    "consultLastQuery":
        "SELECT * FROM licen_med WHERE ID_Pace = ? ORDER BY Fecha_Realizacion ASC",
    "consultByName": "SELECT * FROM licen_med WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO licen_med (ID_Pace, Folio, Dias_Otorgados, "
        "Fecha_Realizacion, Fecha_Inicio, Fecha_Termino, "
        "Motivo_Incapacidad, Caracter, Lugar_Expedicion, "
        "Diagnos_Expedicion) "
        "VALUES (?,?,?,?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE licen_med "
        "SET ID_Licen_Med = ?, ID_Pace = ?, Folio = ?, "
        "Dias_Otorgados = ?, Fecha_Realizacion = ?, Fecha_Inicio = ?, Fecha_Termino = ?, "
        "Motivo_Incapacidad = ?, Caracter = ?, Lugar_Expedicion = ?, "
        "Diagnos_Expedicion = ? "
        "WHERE ID_Licen_Med = ?",
    "deleteQuery": "DELETE FROM licen_med WHERE ID_Licen_Med = ?",
    "vicenciaColumns": [
      "ID_Pace",
    ],
    "vicenciaItems": [
      "ID_Pace",
    ],
    "vicenciaColums": [
      "ID Paciente",
    ],
    "vicenciaStats": [
      "Total_Administradores",
    ],
    "vicenciaStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM licen_med WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM licen_med WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM licen_med WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
}

class Vacunales {
  static int ID_Vacunales = 0;
  static var fileAssocieted = '${Pacientes.localRepositoryPath}vacunales.json';
  //
  static String selectedDiagnosis = "";
  //

  static Map<String, dynamic> Vacunas = {};

  static List<String> actualDiagno = Dicotomicos.dicotomicos();
  static List<String> actualTratamiento = Dicotomicos.dicotomicos();
  static List<String> actualSuspendido = Dicotomicos.dicotomicos();

  static void registros() {
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            Vacunales.vacuna['consultByIdPrimaryQuery'], Pacientes.ID_Paciente)
        .then((value) => Pacientes.Vacunales = value);
  }

  static void ultimoRegistro() {
    Actividades.consultarId(Databases.siteground_database_regpace,
            Vacunales.vacuna['consultLastQuery'], Pacientes.ID_Paciente)
        .then((value) {
// Enfermedades de base del paciente, asi como las Hospitalarias.
      Vacunales.Vacunas = value;
    });
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            Vacunales.vacuna['consultIdQuery'], Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Vacunales = value;
    });
  }

  static final Map<String, dynamic> vacuna = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE pace_app_vac;",
    "showColumns": "SHOW columns FROM pace_app_vac",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_app_vac'",
    "createQuery": """CREATE TABLE pace_app_vac (
                        ID_PACE_APP_VAC int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                        ID_Pace int(11) NOT NULL,
                        Pace_APP_VAC_SINO tinyint(1) NOT NULL,
                        Pace_APP_VAC varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                        Pace_APP_VAC_dia int(200) NOT NULL,
                        Pace_APP_VAC_tra_SINO tinyint(1) NOT NULL,
                        Pace_APP_VAC_tra varchar(200) COLLATE utf8_unicode_ci NOT NULL
                        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
                        COMMENT='Tabla para antecedentes vacunales';
            """,
    "truncateQuery": "TRUNCATE pace_app_vac",
    "dropQuery": "DROP TABLE pace_app_vac",
    "consultQuery": "SELECT * FROM pace_app_vac",
    "consultIdQuery": "SELECT * FROM pace_app_vac WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_app_vac WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_app_vac",
    "consultLastQuery": "SELECT * FROM pace_app_vac WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM pace_app_vac WHERE Pace_APP_VAC LIKE '%",
    "registerQuery": "INSERT INTO pace_app_vac (ID_Pace, Pace_APP_VAC_SINO, "
        "Pace_APP_VAC, "
        "Pace_APP_VAC_dia, Pace_APP_VAC_tra_SINO, "
        "Pace_APP_VAC_tra) "
        "VALUES (?,?,?,?,?,?)",
    "updateQuery": "UPDATE pace_app_vac "
        "SET ID_PACE_APP_VAC = ?, ID_Pace = ?, "
        "Pace_APP_VAC_SINO = ?, Pace_APP_VAC = ?, "
        "Pace_APP_VAC_dia = ?, "
        "Pace_APP_VAC_tra_SINO = ?,  "
        "Pace_APP_VAC_tra = ? "
        "WHERE ID_PACE_APP_VAC = ?",
    "deleteQuery": "DELETE FROM pace_app_vac WHERE ID_PACE_APP_VAC = ?",
    "vacunaColumns": [
      "ID_Pace",
    ],
    "vacunaItems": [
      "ID_Pace",
    ],
    "vacunaColums": [
      "ID Paciente",
    ],
    "vacunaStats": [
      "Total_Administradores",
    ],
    "vacunaStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM pace_app_vac WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM pace_app_vac WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM pace_app_vac WHERE ID_Pace = '${Pacientes.ID_Paciente}') as Total_Registros;"
  };
}
