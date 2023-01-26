import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';

class Pacientes {
  static int ID_Paciente = 0;

  static String? nombreCompleto;
  static String? imagenPaciente;

  // ####### ### ### ## ### ### ####### ####### ####### #######
  // Variables para la asignación del pronóstico médico.
  // ####### ### ### ## ### ### ####### ####### ####### #######
  static String? pronosticoTiempo = PronosticoTiempo[0],
      pronosticoEstado = PronosticoEstado[0],
      pronosticoFuncion = PronosticoFuncion[0],
      pronosticoVida = PronosticoVida[0];
  // ####### ### ### ## ### ### ####### ####### ####### #######
  // Diccionarios por Actividades y gestores.
  // ####### ### ### ## ### ### ####### ####### ####### #######
  static Map<String, dynamic> Valores = {};
  // ####### ### ### ## ### ### ####### ####### ####### #######
  // Diccionarios por Actividades y gestores.
  // ####### ### ### ## ### ### ####### ####### ####### #######
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
  static List? Ventilaciones = [];
  //
  static List? Sexuales = [];
  static List? Antirretrovirales = [];
  static List? Embarazos = [];
  //
  static List? Paraclinicos = [];

  Pacientes(numeroPaciente, agregadoPaciente, primerNombre, segundoNombre,
      apellidoPaterno, apellidoMaterno, imagenUsuario) {
    Pacientes.nombreCompleto =
        "$apellidoPaterno $apellidoMaterno $primerNombre $segundoNombre";
    Pacientes.imagenPaciente = "$imagenUsuario";
  }

  // Pacientes.fromJson(Map json) {
  //   nombreCompleto =
  //       "${json['Us_Ape_Pat']} ${json['Us_Ape_Pat']} ${json['Us_Nome']}";
  //   imagenPaciente = json['Pace_FIAT'];
  // }

  // ####### ### ### ## ### ### ####### ####### ####### #######
  // Prosas y apartados literales en la formación de las Actividades.
  // ####### ### ### ## ### ### ####### ####### ####### #######
  static String originario() {
    return "${Pacientes.Paciente['Pace_Orig_Muni']}, ${Pacientes.Paciente['Pace_Orig_EntFed']}";
  }

  static String residente() {
    return "la localidad de ${Pacientes.Paciente['Pace_Resi_Loca']} por ${Pacientes.Paciente['Pace_Resi_Dur'].toString()} año(s)";
  }

  static String prosa() {
    return "${Pacientes.Paciente['Pace_Ses']} de ${Pacientes.Paciente['Pace_Eda']} años, "
        "con fecha de nacimiento el ${Pacientes.Paciente['Pace_Nace']}. "
        "Originario/a de ${originario()}, residente de ${residente()} . "
        "Escolaridad hasta ${Pacientes.Paciente['Pace_Esco']}, "
        "ocupación como ${Pacientes.Paciente['Pace_Ocupa']}, "
        "religión ${Pacientes.Paciente['Pace_Reli']}, "
        "y estado civil ${Pacientes.Paciente['Pace_Edo_Civ']}.n ";
  }

  static String heredofamiliares() {
    return "con desconocimiento de enfermedades preexistentes";
  }

  static String epidemiologicos() {
    return "Antecedentes epidemiológicos";
  }

  static String hospitalarios() {
    return "negados";
  }

  static String alergicos() {
    return "negados";
  }

  static String patologicos() {
    return "negados";
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
    double imc = Pacientes.Vital['Pace_SV_pct'] /
        (Pacientes.Vital['Pace_SV_est'] * Pacientes.Vital['Pace_SV_est']);

    switch (indice) {
      case 1:
        return Valorados.signosVitales;
      case 2:
        return Valorados.bioconstantes;
      case 3:
        // return "Medidas antropométricas";
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
        return "Exploración acortada";
      case 2:
        return "Exploración extensa";
      case 3:
        return "Análisis de terapia intensiva";
      case 4:
        return "";
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

  static String auxiliaresDiagnosticos({int? indice = 0}) {
    if (indice! < 20) {
      return Auxiliares.porTipoEstudio(indice: indice);
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

    print("Patologicos ${Patologicos!.length} $Patologicos \n "
        "Reportes.impresionesDiagnosticas ${Reportes.impresionesDiagnosticas}");
    // ************************ ************** ********** **** *** *
    if (Patologicos != []) {
      for (var element in Patologicos!) {
        if (Reportes.impresionesDiagnosticas == "") {
          Reportes.impresionesDiagnosticas =
              "${element['Pace_APP_DEG']} (${element['Pace_APP_DEG_com']}). ";
        } else {
          Reportes.impresionesDiagnosticas =
              "${Reportes.impresionesDiagnosticas} ${element['Pace_APP_DEG']} (${element['Pace_APP_DEG_com']}). \n";
        }
      }
    }
    // ************************ ************** ********** **** *** *
    print(
        "Reportes.impresionesDiagnosticas ${Reportes.impresionesDiagnosticas}");
    Reportes.reportes['Impresiones_Diagnosticas'] =
        Reportes.impresionesDiagnosticas;
    // ************************ ************** ********** **** *** *
    return Reportes.impresionesDiagnosticas;
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
    "H.G.R. 17",
    'H.G.Z. 1',
    'INSABI No 27',
    "Consulta Externa"
  ];
  static final List<String> Atencion = ['Hospitalización', 'Consulta Externa'];
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
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_regpace` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_regpace`",
    "describeTable": "DESCRIBE pace_iden_iden;",
    "showColumns": "SHOW columns FROM pace_iden_iden",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_iden_iden'",
    "createQuery": """CREATE TABLE `pace_iden_iden` (
                  `ID_Pace` int(10) NOT NULL,
                  `Pace_NSS` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_AGRE` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Nome_PI` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Nome_SE` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Ape_Pat` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Ape_Mat` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_FIAT` longblob NOT NULL, 
                  `Pace_UMF` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Hosp_Real` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Turo` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Feca_Hace` date NOT NULL,
                  `Pace_Hora_Hace` time(6) NOT NULL,
                  `Pace_Tele` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Nace` date NOT NULL,
                  `Pace_Ses` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Hosp` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Curp` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_RFC` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Eda` int(11) NOT NULL,
                  `Pace_Stat` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Ocupa` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Edo_Civ` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Reli` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Esco` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Esco_COM` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Esco_ESPE` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Orig_Muni` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Orig_EntFed` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Resi_Loca` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Resi_Dur` int(11) NOT NULL,
                  `Pace_Domi` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Indi_Pace_SiNo` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `IndiIdio_Pace_SiNo` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `IndiIdio_Pace_Espe` varchar(50) COLLATE utf8_unicode_ci NOT NULL 
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Esta Tabla es para Agregar Datos Generales de los Pacientes';""",
    "truncateQuery": "TRUNCATE pace_iden_iden",
    "dropQuery": "DROP TABLE pace_iden_iden",
    "consultQuery": "SELECT ID_Pace, Pace_NSS, Pace_AGRE, Pace_Nome_PI, Pace_Nome_SE, Pace_Ape_Pat, Pace_Ape_Mat, Pace_FIAT, "
        "Pace_UMF, Pace_Hosp_Real, Pace_Turo, Pace_Feca_Hace, Pace_Hora_Hace, Pace_Tele, Pace_Nace, Pace_Ses, Pace_Hosp, "
        "Pace_Curp, Pace_RFC, Pace_Eda, Pace_Stat, Pace_Ocupa, Pace_Edo_Civ, Pace_Reli, Pace_Esco, Pace_Esco_COM, Pace_Esco_ESPE, "
        "Pace_Orig_Muni, Pace_Orig_EntFed, Pace_Resi_Loca, Pace_Resi_Dur, Pace_Domi, Indi_Pace_SiNo, IndiIdio_Pace_SiNo, IndiIdio_Pace_Espe "
        "FROM pace_iden_iden",
    "consultIdQuery": "SELECT ID_Pace, Pace_NSS, Pace_AGRE, "
        "Pace_Nome_PI, Pace_Nome_SE, Pace_Ape_Pat, "
        "Pace_Ape_Mat, to_base64(Pace_FIAT) as Pace_FIAT, "
        "Pace_UMF, Pace_Hosp_Real, Pace_Turo, Pace_Feca_Hace, Pace_Hora_Hace, "
        "Pace_Tele, Pace_Nace, Pace_Ses, Pace_Hosp, Pace_Curp, "
        "Pace_RFC, Pace_Eda, Pace_Stat, "
        "Pace_Ocupa, Pace_Edo_Civ, Pace_Reli, Pace_Esco, Pace_Esco_COM, Pace_Esco_ESPE, "
        "Pace_Orig_Muni, Pace_Orig_EntFed, Pace_Resi_Loca, Pace_Resi_Dur, "
        "Pace_Domi, Indi_Pace_SiNo, "
        "IndiIdio_Pace_SiNo, IndiIdio_Pace_Espe FROM pace_iden_iden WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_iden_iden",
    "consultLastQuery": "SELECT * FROM pace_iden_iden ORDER BY ID_Pace DESC",
    "consultByName":
        "SELECT Pace_Ape_Pat FROM pace_iden_iden WHERE Us_Nome LIKE '%",
    "registerQuery": "INSERT INTO pace_iden_iden ("
        "Pace_NSS, Pace_AGRE, "
        "Pace_Nome_PI, Pace_Nome_SE, Pace_Ape_Pat, Pace_Ape_Mat, Pace_FIAT, "
        "Pace_UMF, Pace_Hosp_Real, Pace_Turo, Pace_Feca_Hace, Pace_Hora_Hace, "
        "Pace_Tele, Pace_Nace, Pace_Ses, Pace_Hosp, Pace_Curp, "
        "Pace_RFC, Pace_Eda, Pace_Stat, "
        "Pace_Ocupa, Pace_Edo_Civ, Pace_Reli, Pace_Esco, Pace_Esco_COM, Pace_Esco_ESPE, "
        "Pace_Orig_Muni, Pace_Orig_EntFed, Pace_Resi_Loca, Pace_Resi_Dur, Pace_Domi, "
        "Indi_Pace_SiNo, IndiIdio_Pace_SiNo, IndiIdio_Pace_Espe) "
        "VALUES (?,?,?,?,?,?, from_base64(?), "
        "?,?,?,?,?, "
        "?,?,?,?,?, "
        "?,?,?, "
        "?,?,?,?,?,?,?,?,?,?,?, "
        "?,?,?)",
    "updateQuery": "UPDATE pace_iden_iden "
        "SET ID_Pace = ?, Pace_NSS = ?, Pace_AGRE = ?, "
        "Pace_Nome_PI = ?, Pace_Nome_SE = ?, Pace_Ape_Pat = ?, Pace_Ape_Mat = ?, Pace_FIAT = from_base64(?), "
        "Pace_UMF = ?, Pace_Hosp_Real = ?, Pace_Turo = ?, Pace_Feca_Hace = ?, Pace_Hora_Hace = ?, "
        "Pace_Tele = ?, Pace_Nace = ?, Pace_Ses = ?, Pace_Hosp = ?, Pace_Curp = ?, "
        "Pace_RFC = ?, Pace_Eda = ?, Pace_Stat = ?, "
        "Pace_Ocupa = ?, Pace_Edo_Civ = ?, Pace_Reli = ?, Pace_Esco = ?, Pace_Esco_COM = ?, Pace_Esco_ESPE = ?, "
        "Pace_Orig_Muni = ?, Pace_Orig_EntFed = ?, Pace_Resi_Loca = ?, Pace_Resi_Dur = ?, Pace_Domi = ?, Indi_Pace_SiNo = ?, "
        "IndiIdio_Pace_SiNo = ?, IndiIdio_Pace_Espe = ? "
        "WHERE ID_Pace = ?",
    "deleteQuery": "DELETE FROM pace_iden_iden WHERE ID_Pace = ?",
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
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE `Pace_Ses` = '${Pacientes.Sexo[0]}') as Total_Mujeres,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE `Pace_Ses` = '${Pacientes.Sexo[1]}') as Total_Hombres,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE `Pace_Hosp_Real` = '${Pacientes.Atencion[0]}') as Total_Hospitalizacion,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE `Pace_Hosp_Real` = '${Pacientes.Atencion[1]}') as Total_Consulta,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE `Pace_Turo` = '${Pacientes.Turno[0]}') as Total_Matutino,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE `Pace_Turo` = '${Pacientes.Turno[1]}') as Total_Vespertino,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE `Pace_Stat` = '${Pacientes.Vivo[0]}') as Total_Vivos,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE `Pace_Stat` = '${Pacientes.Vivo[1]}') as Total_Fallecidos,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE `IndiIdio_Pace_SiNo` = '${Pacientes.Indigena[0]}') as Total_Indigenas,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE `IndiIdio_Pace_SiNo` = '${Pacientes.Indigena[1]}') as Total_No_Indigenas,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE `IndiIdio_Pace_SiNo` = '${Pacientes.lenguaIndigena[0]}') as Total_Hablantes,"
        "(SELECT IFNULL(count(*), 0) FROM pace_iden_iden WHERE `IndiIdio_Pace_SiNo` = '${Pacientes.lenguaIndigena[1]}') as Total_No_Hablantes,"
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

  static void close() {
    Pacientes.ID_Paciente = 0;
    Pacientes.nombreCompleto = "";
    Pacientes.imagenPaciente = "";
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
    Sexuales = [];
    Antirretrovirales = [];
    Embarazos = [];
    // ******* *** *******
    Constantes.reinit();
    Reportes.close();
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
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_regpace` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_regpace`",
    "describeTable": "DESCRIBE pace_ahf;",
    "showColumns": "SHOW columns FROM pace_ahf",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_ahf'",
    "createQuery": """CREATE TABLE pace_ahf (
                  `ID_MEFAM` int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `ID_Pace` int(10) NOT NULL,
                  `Pace_MEFAM` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `MEFAM_VFS` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `MEFAM_EdaL` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `AHF_INFO_APato` varchar(50) COLLATE utf8_unicode_ci NOT NULL
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
    "registerQuery": "INSERT INTO `pace_ahf` (`ID_Pace`, `Pace_MEFAM`, "
        "`MEFAM_VFS`, `MEFAM_EdaL`, `AHF_INFO_APato`) "
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

class Sexualogicos {
  static int ID_Sexualogicos = 0;
  //
  static String selectedDiagnosis = "";
  //

  static Map<String, dynamic> Sexuales = {};

  static List<String> actualDiagno = Dicotomicos.dicotomicos();
  static List<String> actualTratamiento = Dicotomicos.dicotomicos();
  static List<String> actualSuspendido = Dicotomicos.dicotomicos();

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
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_regpace` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_regpace`",
    "describeTable": "DESCRIBE pace_aps;",
    "showColumns": "SHOW columns FROM pace_aps",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_aps'",
    "createQuery": """
CREATE TABLE `pace_aps` (
                  `ID_Pace_APS_ets_` int(11) NOT NULL,
                  `ID_Pace` int(11) NOT NULL,
                  `Pace_APS_ets_SINO` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_APS_ets` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_APS_ets_DIA` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_APS_ets_TRA_SINO` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_APS_ets_TRA` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_APS_ets_SUS_` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_APS_ets_SUS` varchar(300) COLLATE utf8_unicode_ci NOT NULL
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
        "INSERT INTO `pace_aps` (ID_Pace, Pace_APS_ets_SINO, Pace_APS_ets, "
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
  static String selectedDiagnosis = "";
  //

  static Map<String, dynamic> Femeninos = {};

  static List<String> actualDiagno = Dicotomicos.dicotomicos();
  static List<String> actualTratamiento = Dicotomicos.dicotomicos();
  static List<String> actualSuspendido = Dicotomicos.dicotomicos();

  static void ultimoRegistro() {
    Actividades.consultarId(
            Databases.siteground_database_regpace,
            Femeninologicos.femeninos['consultLastQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
// Enfermedades de base del paciente, asi como las Hospitalarias.
      Femeninologicos.Femeninos = value;
    });
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            Femeninologicos.femeninos['consultIdQuery'], Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Femeninologicos = value;
    });
  }

  static final Map<String, dynamic> femeninos = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_regpace` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_regpace`",
    "describeTable": "DESCRIBE pace_aps_femi;",
    "showColumns": "SHOW columns FROM pace_aps_femi",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_aps_femi'",
    "createQuery": """CREATE TABLE `pace_aps_femi` (
                      `ID_PACE_APS` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `PACE_APS_Feca` date NOT NULL,
                      `Pace_APS_arc` tinyint(1) NOT NULL,
                      `REGE_Pace_APS_arc` int(11) NOT NULL,
                      `Pace_APS_cat_DIA` int(200) NOT NULL,
                      `Pace_APS_cat_CIC` int(200) NOT NULL,
                      `Pace_APS_pub_SINO` tinyint(1) NOT NULL,
                      `Pace_APS_pub` int(200) NOT NULL,
                      `Pace_APS_tel_SINO` tinyint(1) NOT NULL,
                      `REGE_Pace_APS_tel` int(200) NOT NULL,
                      `FEF_Pace_APS_fur` date NOT NULL,
                      `REGE_Pace_APS_ivs` int(200) NOT NULL,
                      `REGE_Pace_APS_pas` int(200) NOT NULL,
                      `Pace_APS_ise_` varchar(200) COLLATE utf8_unicode_520_ci NOT NULL,
                      `Pace_APS_mpf_` varchar(200) COLLATE utf8_unicode_520_ci NOT NULL,
                      `REGE_Pace_APS_ago_GES` int(200) NOT NULL,
                      `REGE_Pace_APS_ago_PAR` int(200) NOT NULL,
                      `REGE_Pace_APS_ago_CES` int(200) NOT NULL,
                      `REGE_Pace_APS_ago_ABO` int(200) NOT NULL,
                      `Pace_APS_ago_CLI_SINO` tinyint(1) NOT NULL,
                      `REGE_Pace_APS_ago_CLI` int(200) NOT NULL,
                      `Pace_APS_ago_MEN_` tinyint(1) NOT NULL,
                      `REGE_Pace_APS_ago_MEN` int(200) NOT NULL,
                      `Pace_APS_ago_PAP_` tinyint(1) NOT NULL,
                      `FEF_Pace_APS_ago_PAP` date NOT NULL
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
  //
  static String selectedDiagnosis = "";
  //

  static Map<String, dynamic> Masculinos = {};

  static List<String> actualDiagno = Dicotomicos.dicotomicos();
  static List<String> actualTratamiento = Dicotomicos.dicotomicos();
  static List<String> actualSuspendido = Dicotomicos.dicotomicos();

  static void ultimoRegistro() {
    Actividades.consultarId(
            Databases.siteground_database_regpace,
            Masculinologicos.masculinos['consultLastQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
// Enfermedades de base del paciente, asi como las Hospitalarias.
      Masculinologicos.Masculinos = value;
    });
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(
            Databases.siteground_database_regpace,
            Masculinologicos.masculinos['consultIdQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Masculinologicos = value;
    });
  }

  static final Map<String, dynamic> masculinos = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_regpace` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_regpace`",
    "describeTable": "DESCRIBE pace_aps_masc;",
    "showColumns": "SHOW columns FROM pace_aps_masc",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_aps_masc'",
    "createQuery": """
CREATE TABLE `pace_aps_masc` (
                      `ID_PACE_APS` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `PACE_APS_Feca` date NOT NULL,
                      `REGE_Pace_APS_cri_SINO` tinyint(1) NOT NULL,
                      `Pace_APS_cri` int(200) NOT NULL,
                      `REGE_Pace_APS_cir_SINO` tinyint(1) NOT NULL,
                      `Pace_APS_cir` int(200) NOT NULL,
                      `REGE_Pace_APS_ivs` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `REGE_Pace_APS_pas` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APS_ise_` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APS_mpf_` varchar(200) COLLATE utf8_unicode_ci NOT NULL
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
    "registerQuery": "INSERT INTO `pace_aps_masc` (ID_Pace, PACE_APS_Feca, "
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
}

class Patologicos {
  static int ID_Patologicos = 0;
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
        .then((value) => Pacientes.Patologicos = value);
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
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_regpace` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_regpace`",
    "describeTable": "DESCRIBE pace_app_deg;",
    "showColumns": "SHOW columns FROM pace_app_deg",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_app_deg'",
    "createQuery": """CREATE TABLE `pace_app_deg` (
                        `ID_PACE_APP_DEG` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                        `ID_Pace` int(11) NOT NULL,
                        `Pace_APP_DEG_SINO` tinyint(1) NOT NULL,
                        `Pace_APP_DEG` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                        `Pace_APP_DEG_com` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                        `Pace_APP_DEG_dia` int(200) NOT NULL,
                        `Pace_APP_DEG_tra_SINO` tinyint(1) NOT NULL,
                        `Pace_APP_DEG_tra` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                        `Pace_APP_DEG_sus_SINO` tinyint(1) NOT NULL,
                        `Pace_APP_DEG_sus` varchar(200) COLLATE utf8_unicode_ci NOT NULL
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
    "registerQuery": "INSERT INTO `pace_app_deg` (ID_Pace, Pace_APP_DEG_SINO, "
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

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            Alergicos.alergias['consultIdQuery'], Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Alergicos = value;
    });
  }

  static final Map<String, dynamic> alergias = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_regpace` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_regpace`",
    "describeTable": "DESCRIBE pace_app_ale;",
    "showColumns": "SHOW columns FROM pace_app_ale",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_app_ale'",
    "createQuery": """CREATE TABLE pace_app_ale (
                      `ID_PACE_APP_ALE` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APP_ALE_SINO` tinyint(1) NOT NULL,
                      `Pace_APP_ALE` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APP_ALE_com` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APP_ALE_dia` int(200) NOT NULL,
                      `Pace_APP_ALE_tra_SINO` tinyint(1) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APP_ALE_tra` varchar(200) COLLATE utf8_unicode_ci NOT NULL
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

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            Quirurgicos.cirugias['consultIdQuery'], Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Quirurgicos = value;
    });
  }

  static final Map<String, dynamic> cirugias = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_regpace` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_regpace`",
    "describeTable": "DESCRIBE pace_app_qui;",
    "showColumns": "SHOW columns FROM pace_app_qui",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_app_qui'",
    "createQuery": """CREATE TABLE pace_app_qui (
                      `ID_PACE_APP_QUI` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APP_QUI_SINO` tinyint(1) NOT NULL,
                      `Pace_APP_QUI` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APP_QUI_dia` int(200) NOT NULL,
                      `Pace_APP_QUI_com_SINO` tinyint(1) NOT NULL,
                      `Pace_APP_QUI_com` varchar(200) COLLATE utf8_unicode_ci NOT NULL
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
        "INSERT INTO `pace_app_qui` (ID_Pace, Pace_APP_QUI_SINO, Pace_APP_QUI, "
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
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_regpace` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_regpace`",
    "describeTable": "DESCRIBE pace_app_tra;",
    "showColumns": "SHOW columns FROM pace_app_tra",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_app_tra'",
    "createQuery": """CREATE TABLE pace_app_tra (
                      `ID_PACE_APP_TRA` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APP_TRA_SINO` tinyint(1) NOT NULL,
                      `Pace_APP_TRA` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APP_TRA_dia` int(11) NOT NULL,
                      `Pace_APP_TRA_com_SINO` tinyint(1) NOT NULL,
                      `Pace_APP_TRA_com` varchar(200) COLLATE utf8_unicode_ci NOT NULL
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
    "registerQuery": "INSERT INTO `pace_app_tra` (ID_Pace, Pace_APP_TRA_SINO, "
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
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_regpace` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_regpace`",
    "describeTable": "DESCRIBE pace_app_inf;",
    "showColumns": "SHOW columns FROM pace_app_inf",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_app_inf'",
    "createQuery": """CREATE TABLE pace_app_inf (
                      `ID_PACE_APP_INF` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APP_INF_SINO` tinyint(1) NOT NULL,
                      `Pace_APP_INF` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APP_INF_dia` int(11) NOT NULL,
                      `Pace_APP_INF_tra` varchar(200) COLLATE utf8_unicode_ci NOT NULL
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
        "INSERT INTO `pace_app_inf` (ID_PACE_APP_INF, ID_Pace, Pace_APP_INF_SINO, "
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
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_regpace` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_regpace`",
    "describeTable": "DESCRIBE pace_aps;",
    "showColumns": "SHOW columns FROM pace_aps",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_aps'",
    "createQuery": """CREATE TABLE pace_tar (
                  `ID_TAR` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `ID_Pace` int(11) NOT NULL,
                  `TARactu` tinyint(1) NOT NULL,
                  `Pace_Fe_TAR` date NOT NULL,
                  `Pace_Ca_TAR` date NOT NULL,
                  `Pace_TAR` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Mov_TAR` varchar(300) COLLATE utf8_unicode_ci NOT NULL
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
        "INSERT INTO `pace_tar` (ID_Pace, TARactu, Pace_Fe_TAR, Pace_Ca_TAR, Pace_TAR, Pace_Mov_TAR) "
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
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_regpace` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_regpace`",
    "describeTable": "DESCRIBE pace_tar_vih;",
    "showColumns": "SHOW columns FROM pace_tar_vih",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_tar_vih'",
    "createQuery": """CREATE TABLE pace_tar_vih (
                  `ID_TARVIH` int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `ID_Pace` int(10) NOT NULL,
                  `Pace_DIA_VIH` date NOT NULL,
                  `Pace_CRIBAMO` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_CDC_DIA` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Fese_TAR` date NOT NULL,
                  `Pace_Fe_TAR` date NOT NULL,
                  `Rede_TAR_SINO` tinyint(1) NOT NULL,
                  `Pace_TAR_EMBA` tinyint(1) NOT NULL,
                  `Pace_No_TAR` int(10) NOT NULL
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
    "registerQuery": "INSERT INTO pace_tar_vih (`ID_Pace`, "
        "`Pace_DIA_VIH`, `Pace_CRIBAMO`, "
        "`Pace_CDC_DIA`, `Pace_Fese_TAR`, "
        "`Pace_Fe_TAR`, `Rede_TAR_SINO`, "
        "`Pace_TAR_EMBA`, `Pace_No_TAR`) "
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
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_regpace` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_regpace`",
    "describeTable": "DESCRIBE pace_tar_embarazo;",
    "showColumns": "SHOW columns FROM pace_tar_embarazo",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_tar_embarazo'",
    "createQuery": """CREATE TABLE `pace_emba` (
                  `ID_Pace_EMB` int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `ID_Pace` int(10) NOT NULL,
                  `ID_Gestacion` int(10) NOT NULL,
                  `Pace_Feca_EMB` date NOT NULL,
                  `Pace_Feca_FUR` date NOT NULL,
                  `Pace_EMB_fpp` varchar(20) NOT NULL,
                  `Pace_EMB_c_sit_fet` int(10) NOT NULL,
                  `Pace_EMB_afu` int(10) NOT NULL,
                  `Pace_EMB_pfe` double NOT NULL,
                  `Pace_EMB_c_johnson` double NOT NULL,
                  `Pace_EMB_fcf` int(10) NOT NULL,
                  `Pace_EMB_gmp` varchar(20) NOT NULL,
                  `Pace_EMB_dbp` double NOT NULL, 
                  `Pace_EMB_cc` double NOT NULL, 
                  `Pace_EMB_ca` double NOT NULL, 
                  `Pace_EMB_lfe` double NOT NULL, 
                  `Pace_EMB_phelan` double NOT NULL, 
                  `Pace_EMB_pfe_usg` double NOT NULL 
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
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            vitales['consultByIdPrimaryQuery'], Pacientes.ID_Paciente)
        .then((value) => Pacientes.Vitales = value);
  }

  static final Map<String, dynamic> vitales = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_regpace` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_regpace`",
    "describeTable": "DESCRIBE pace_sv;",
    "showColumns": "SHOW columns FROM pace_sv",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_sv'",
    "createQuery": """CREATE TABLE `pace_sv` (
              `ID_Pace_SV` int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              `ID_Pace` int(10) NOT NULL,
              `Pace_Feca_SV` date NOT NULL,
              `Pace_SV_tas` int(10) NOT NULL,
              `Pace_SV_tad` int(10) NOT NULL,
              `Pace_SV_fc` int(10) NOT NULL,
              `Pace_SV_fr` int(10) NOT NULL,
              `Pace_SV_tc` double NOT NULL,
              `Pace_SV_spo` int(10) NOT NULL,
              `Pace_SV_est` double NOT NULL,
              `Pace_SV_pct` double NOT NULL, 
              `Pace_SV_glu` double NOT NULL, 
              `Pace_SV_glu_ayu` double NOT NULL
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
        "SET ID_Pace_SV = ?, ID_Pace = ?, Pace_Feca_SV = ?, Pace_SV_tas = ?, Pace_SV_tad = "
        "?, Pace_SV_fc = ?, Pace_SV_fr = ?, Pace_SV_tc = ?, Pace_SV_spo = ?, Pace_SV_est = "
        "?, Pace_SV_pct = ?, "
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
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_regpace` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_regpace`",
    "describeTable": "DESCRIBE pace_antropo;",
    "showColumns": "SHOW columns FROM pace_antropo",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_antropo'",
    "createQuery": """CREATE TABLE `pace_antropo` (
              `ID_Pace_SV` int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              `ID_Pace` int(10) NOT NULL,
              `Pace_Feca_SV` date NOT NULL,
              `Pace_SV_cue` double NOT NULL,
              `Pace_SV_cin` double NOT NULL,
              `Pace_SV_cad` double NOT NULL,
              `Pace_SV_cmb` double NOT NULL,
              `Pace_SV_pct` double NOT NULL,
              `Pace_SV_fa` double NOT NULL,
              `Pace_SV_fe` double NOT NULL,
              `Pace_SV_pcb` double NOT NULL,
              `Pace_SV_pse` double NOT NULL,
              `Pace_SV_psi` double NOT NULL,
              `Pace_SV_pst` double NOT NULL, 
              `Pace_SV_c_pect` double NOT NULL,
              `Pace_SV_c_fem_izq` double NOT NULL,
              `Pace_SV_c_fem_der` double NOT NULL,
              `Pace_SV_c_fem_izq`, double NOT NULL,
              `Pace_SV_c_suro_der` double NOT NULL
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
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE `Pace_Ses` = '${Pacientes.Sexo[0]}') as Total_Mujeres,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE `Pace_Ses` = '${Pacientes.Sexo[1]}') as Total_Hombres,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE `Pace_Hosp_Real` = '${Pacientes.Atencion[0]}') as Total_Hospitalizacion,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE `Pace_Hosp_Real` = '${Pacientes.Atencion[1]}') as Total_Consulta,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE `Pace_Turo` = '${Pacientes.Turno[0]}') as Total_Matutino,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE `Pace_Turo` = '${Pacientes.Turno[1]}') as Total_Vespertino,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE `Pace_Stat` = '${Pacientes.Vivo[0]}') as Total_Vivos,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE `Pace_Stat` = '${Pacientes.Vivo[1]}') as Total_Fallecidos,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE `IndiIdio_Pace_SiNo` = '${Pacientes.Indigena[0]}') as Total_Hablantes,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE `IndiIdio_Pace_SiNo` = '${Pacientes.Indigena[1]}') as Total_No_Hablantes,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE `IndiIdio_Pace_SiNo` = '${Pacientes.lenguaIndigena[0]}') as Total_Hablantes,"
        "(SELECT IFNULL(count(*), 0) FROM pace_antropo WHERE `IndiIdio_Pace_SiNo` = '${Pacientes.lenguaIndigena[1]}') as Total_No_Hablantes,"
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
}

class Electrocardiogramas {
  static final Map<String, dynamic> electrocardiogramas = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_reggabo` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_reggabo`",
    "describeTable": "DESCRIBE gabo_ecg;",
    "showColumns": "SHOW columns FROM gabo_ecg",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'gabo_ecg'",
    "createQuery": """CREATE TABLE gabo_ecg (
              `ID_Pace_GAB_EC` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              `ID_Pace` int(11) NOT NULL,
              `Pace_GAB_EC_Feca` date NOT NULL,
              `Pace_EC_rit` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
              `Pace_EC_rr` int(50) NOT NULL,
              `Pace_EC_dop` double NOT NULL,
              `Pace_EC_aop` double NOT NULL,
              `Pace_EC_dpr` double NOT NULL,
              `Pace_EC_dqrs` double NOT NULL,
              `Pace_EC_aqrs` double NOT NULL,
              `Pace_EC_qrsi` double NOT NULL,
              `Pace_EC_qrsa` double NOT NULL,
              `Pace_QRS` double NOT NULL,
              `Pace_EC_ast_` double NOT NULL,
              `Pace_EC_st` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
              `Pace_EC_dqt` double NOT NULL,
              `Pace_EC_dot` double NOT NULL,
              `Pace_EC_aot` double NOT NULL,
              `EC_rV1` double NOT NULL,
              `EC_sV6` double NOT NULL,
              `EC_sV1` double NOT NULL,
              `EC_rV6` double NOT NULL,
              `EC_rAVL` double NOT NULL,
              `EC_sV3` double NOT NULL,
              `PatronQRS` varchar(100) NOT NULL, 
              `DeflexionIntrinsecoide` int(10) NOT NULL, 
              `EC_rDI` int(10) NOT NULL, 
              `EC_sDI` int(10) NOT NULL, 
              `EC_rDIII` int(10) NOT NULL, 
              `EC_sDIII` int(10) NOT NULL,
              `Pace_EC_CON` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
              `Pace_GAB_Tee` varchar(100) COLLATE utf8_unicode_ci NOT NULL
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
    "registerQuery":
        "INSERT INTO gabo_ecg (ID_Pace, Pace_GAB_EC_Feca, Pace_EC_rit, Pace_EC_rr, Pace_EC_dop, "
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
        "(SELECT IFNULL(count(*), 0) FROM gabo_ecg WHERE `Pace_Ses` = '${Pacientes.Sexo[0]}') as Total_Mujeres,"
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
}

class Auxiliares {
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
        .then((value) => Pacientes.Paraclinicos = value);
    Actividades.consultarId(
            Databases.siteground_database_reggabo,
            Electrocardiogramas.electrocardiogramas['consultLastQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      Pacientes.Electrocardiogramas = value;
      // Calculos adicionales
      Pacientes.Electrocardiogramas.addAll({
        "isl": (Pacientes.Electrocardiogramas['EC_sV1'] +
            Pacientes.Electrocardiogramas['EC_rV6']),
        "igu": (Pacientes.Electrocardiogramas['EC_rDI'] +
            Pacientes.Electrocardiogramas['EC_sDIII']),
        "il": (Pacientes.Electrocardiogramas['EC_rDI'] +
                Pacientes.Electrocardiogramas['EC_sDIII']) -
            (Pacientes.Electrocardiogramas['EC_rDIII'] +
                Pacientes.Electrocardiogramas['EC_sDI']),
        "vc": (Pacientes.Electrocardiogramas['EC_rAVL'] +
            Pacientes.Electrocardiogramas['EC_sV3'])
      });
    });
  }

  static String porTipoEstudio({int? indice = 0}) {
    // ####### ### ### ## ### ### ####### ####### ####### #######
    // Filtro por estudio de los registros de Pacientes.Paraclinicos
    // ####### ### ### ## ### ### ####### ####### ####### #######
    var aux = Pacientes.Paraclinicos!
        .where((user) =>
            user["Tipo_Estudio"].contains(Auxiliares.Categorias[indice!]))
        .toList();
    // ####### ### ### ## ### ### ####### ####### ####### #######
    // Inicio del formato de la prosa.
    // ####### ### ### ## ### ### ####### ####### ####### #######
    String prosa =
        "${Auxiliares.Categorias[indice!]} (${aux[0]['Fecha_Registro']}): ";
    String max = "";
    // ####### ### ### ## ### ### ####### ####### ####### #######
    // Anexación de los valores correlacionados.
    // ####### ### ### ## ### ### ####### ####### ####### #######
    aux.forEach((element) {
      max =
          "$max ${element['Estudio']} ${element['Resultado']} ${element['Unidad_Medida']}. ";
    });
    // ####### ### ### ## ### ### ####### ####### ####### #######
    // Devolución de la prosa.
    // ####### ### ### ## ### ### ####### ####### ####### #######
    return prosa + max;
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
    "Gasometrías",
    "Examen General de Orina",
    "Depuración de Orina de 24 Horas",
    "Citoquimico",
    "Citológico",
    "Iones Urinarios",
    "Carga Viral",
    "Conteo de Linfocitos T CD4+",
    "",
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
    Categorias[1]: ["Glucosa", "Urea", "Creatinina", "Acido Úrico"],
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
    Categorias[9]: [""],
    Categorias[10]: [""],
    Categorias[11]: [""],
    Categorias[12]: [""],
    Categorias[13]: [""],
    Categorias[14]: [
      "Sodio Urinario",
      "Potasio Urinario",
      "Cloro Urinario",
      "Calcio Urinario",
      "Fósforo Urinario",
      "Magnesio Urinario",
      "Creatinina Urinaria"
    ],
    Categorias[15]: [
      "Conteo de Viriones de VIH",
      "Conteo de Viriones de Hepatitis A",
      "Conteo de Viriones de Hepatitis B",
      "Conteo de Viriones de Hepatitis C"
    ],
    Categorias[16]: [
      "Conteo de Linfocitos CD4+",
      "Porcentaje de Linfocitos CD4+"
    ]
  };
  static Map<String, dynamic> Medidas = {
    Categorias[0]: ["g/dL", "%", "fL", "pg", "10^3/UL", "10^6/UL"],
    Categorias[1]: ["mg/dL"],
    Categorias[2]: ["mEq/L", "mmol/L", "mg/dL"],
    Categorias[3]: ["UI/L", "g/dL", "mg/dL"],
    Categorias[4]: [""],
    Categorias[5]: [""],
    Categorias[6]: [""],
    Categorias[7]: [""],
    Categorias[8]: [""],
    Categorias[9]: [""],
    Categorias[10]: [""],
    Categorias[11]: [""],
    Categorias[12]: [""],
    Categorias[13]: [""],
    Categorias[14]: [""],
    Categorias[15]: [""],
    Categorias[16]: [""]
  };

  static final Map<String, dynamic> auxiliares = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_reglabo` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_reglabo`",
    "describeTable": "DESCRIBE laboratorios;",
    "showColumns": "SHOW columns FROM laboratorios",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'laboratorios'",
    "createQuery": """
                CREATE TABLE `laboratorios` (
                  `ID_Laboratorio` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL, 
                  `ID_Pace` int(11) NOT NULL,
                  `Fecha_Registro` DATE NOT NULL, 
                  `Tipo_Estudio` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Estudio` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Resultado` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Unidad_Medida` varchar(50) COLLATE utf8_unicode_ci NOT NULL
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
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Eritrocitos' ORDER BY Fecha_Registro DESC limit 1) as Eritrocitos,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Hemoglobina' ORDER BY Fecha_Registro DESC limit 1) as Hemoglobina,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Hematocrito' ORDER BY Fecha_Registro DESC limit 1) as Hematocrito,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Plaquetas' ORDER BY Fecha_Registro DESC limit 1) as Plaquetas,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Leucocitos' ORDER BY Fecha_Registro DESC limit 1) as Leucocitos_Totales,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Neutrofilos' ORDER BY Fecha_Registro DESC limit 1) as Neutrofilos_Totales,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Linfocitos' ORDER BY Fecha_Registro DESC limit 1) as Linfocitos_Totales,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Glucosa' ORDER BY Fecha_Registro DESC limit 1) as Glucosa,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Urea' ORDER BY Fecha_Registro DESC limit 1) as Urea,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Creatinina' ORDER BY Fecha_Registro DESC limit 1) as Creatinina,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Acido Úrico' ORDER BY Fecha_Registro DESC limit 1) as Acido_Urico,"
        "(SELECT IFNULL(Resultado, 0) FROM laboratorios WHERE ID_Pace = ${Pacientes.ID_Paciente} AND Estudio = 'Linfocitos' ORDER BY Fecha_Registro DESC limit 1) as Linfocitos_Totales;"
  };

  static String electrocardiograma() {
    return "Electrocardiograma (${Pacientes.Electrocardiogramas['Pace_GAB_EC_Feca']}): "
        "${Pacientes.Electrocardiogramas['Pace_EC_rit']} "
        "con Intervalo R-R ${Pacientes.Electrocardiogramas['Pace_EC_rr']} mm, "
        "Frecuencia Cardiaca ${(300 / Pacientes.Electrocardiogramas['Pace_EC_rr']).toStringAsFixed(0)} Lat/min; "
        "Duración de la Onda P ${Pacientes.Electrocardiogramas['Pace_EC_dop'] * 0.04} mSeg, "
        "Altura de la Onda P ${Pacientes.Electrocardiogramas['Pace_EC_aop'] * 0.1} mV, "
        "Duración de Intervalo PR ${Pacientes.Electrocardiogramas['Pace_EC_dpr'] * 0.04} mSeg, "
        "Duración del Complejo QRS ${Pacientes.Electrocardiogramas['Pace_EC_dqrs'] * 0.04} mSeg, "
        "Altura del Complejo QRS ${Pacientes.Electrocardiogramas['Pace_EC_aqrs'] * 0.1} mV. "
        "Complejo QRS en aVF ${Pacientes.Electrocardiogramas['Pace_EC_qrsi'] * 0.1} mV, "
        "Eje Cardiaco ${Pacientes.Electrocardiogramas['Pace_QRS']}° (Tangente DI/aVF). "
        "Altura de la Onda T ${Pacientes.Electrocardiogramas['Pace_EC_aot'] * 0.1} mV, "
        "Duración de la Onda T ${Pacientes.Electrocardiogramas['Pace_EC_dot'] * 0.04} mSeg, "
        "Intervalo ST ${Pacientes.Electrocardiogramas['Pace_EC_ast_']}, "
        "Duracion del Segmento ST ${Pacientes.Electrocardiogramas['Pace_EC_st'] * 0.04} mSeg, "
        "Duracion del Intervalo QT ${Pacientes.Electrocardiogramas['Pace_EC_dqt'] * 0.04} mSeg, "
        "Deflexión Intrinsecoide ${Pacientes.Electrocardiogramas['DeflexionIntrinsecoide'] * 0.04} mSeg. "
        "Indice Sokolow - Lyon ${(Pacientes.Electrocardiogramas['isl'] * 0.1).toStringAsFixed(0)} mV, "
        "Indice Gubner - Ungerleider ${(Pacientes.Electrocardiogramas['igu'] * 0.1).toStringAsFixed(0)} mV, "
        "Indice de Lewis ${(Pacientes.Electrocardiogramas['il'] * 0.1).toStringAsFixed(0)} mV, "
        "Voltaje de Cornell ${(Pacientes.Electrocardiogramas['vc'] * 0.1).toStringAsFixed(0)} mV, "
        "RaVL ${Pacientes.Electrocardiogramas['EC_rAVL']} mV. ";
  }
}

class Reportes {
  //  # # # # ### ### ### # # # # . # # # # ### ### ### # # # #
  //  Diccionario de Reportes.
  //  # # # # ### ### ### # # # # . # # # # ### ### ### # # # #
  static Map<String, dynamic> reportes = {
    "Datos_Generales": Pacientes.prosa(),
    "Antecedentes_Heredofamiliares": Pacientes.heredofamiliares(),
    "Antecedentes_Hospitalarios": Pacientes.hospitalarios(),
    "Antecedentes_Patologicos": Pacientes.patologicos(),
    "Antecedentes_Perinatales": Pacientes.perinatales(),
    "Antecedentes_Sexuales": Pacientes.sexuales(),
    "Antecedentes_Alergicos": Pacientes.alergicos(),
    //
    "Motivo_Consulta": Reportes.motivoConsulta,
    //
    "Signos_Vitales": Reportes.signosVitales,
    "Exploracion_Fisica": Reportes.exploracionFisica,
    //
    "Auxiliares_Diagnosticos": Reportes.auxiliaresDiagnosticos,
    "Analisis_Complementarios": Reportes.analisisComplementarios,
    //
    "Analisis_Medico":
        "${Reportes.eventualidadesOcurridas} ${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}",
    "Impresiones_Diagnosticas": Reportes.impresionesDiagnosticas,
    // "Bullets": "Auxiliares:\n\tOtro.\tOtro.\nDiagnosticos:\n\tOtro.\tOtro.",
    "Hidroterapia": Reportes.hidroterapia,
    "Insulinoterapia": Reportes.insulinoterapia,
    "Hemoterapia": Reportes.hemoterapia,
    "Oxigenoterapia": Reportes.oxigenoterapia,
    //
    "Medicamentos": Reportes
        .medicamentosIndicados, // ['Paracetamol Tabletas 500, tomar 1 cada 8 horas por 7 dias',],
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
  static String antecedentesHospitalarios = "";
  static String padecimientoActual = "";
  static String personalesPatologicos = "";
  static String antecedentesPerinatales = "";
  static String antecedentesSexuales = "";
  //
  static String signosVitales = "";
  static String exploracionFisica =
      "Sin hallazgos relevantes en la exploración física";
  //
  static String auxiliaresDiagnosticos = "";
  static String analisisComplementarios = "";
  //
  static String eventualidadesOcurridas = "";
  static String terapiasPrevias = "";
  static String analisisMedico = "";
  static String tratamientoPropuesto = "";
  //
  static String impresionesDiagnosticas = "";
  static String pronosticoMedico = "";
  //
  static String motivoConsulta = "";
  //
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
    antecedentesHospitalarios = "";
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
    medicamentosIndicados = [''];
    medidasGenerales = [''];
    licenciasMedicas = [''];
    pendientes = [''];
    citasMedicas = [''];
    recomendacionesGenerales = [''];
    // *** * *** *** *** * ***

    Pacientes.Patologicos = [];
    Pacientes.Vitales = [];
    Pacientes.Vital = {};
    Patologicos.Degenerativos = {};
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
        return "(N-QUI) - ${Pacientes.nombreCompleto} - (${Calendarios.today()}).pdf";
      case 5: // Nota de Valoración Preanestésica
        return "(N-ANES) - ${Pacientes.nombreCompleto} - (${Calendarios.today()}).pdf";
      case 6: // Nota de Egreso
        return "(PA) - ${Pacientes.nombreCompleto} - (${Calendarios.today()}).pdf";
      case 7: //
        return "(NE) - ${Pacientes.nombreCompleto} - (${Calendarios.today()}).pdf";
      case 8: //
        return "(CE) - ${Pacientes.nombreCompleto} - (${Calendarios.today()}).pdf";
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
}

class Balances {
  static int ID_Balances = 0;
  //
  static Map<String, dynamic> Balance = {};

  static List<String> actualDiagno = Opciones.horarios();

  static void ultimoRegistro() {
    Actividades.consultarId(Databases.siteground_database_regpace,
            Balances.balance['consultLastQuery'], Pacientes.ID_Paciente)
        .then((value) {
// Enfermedades de base del paciente, asi como las Hospitalarias.
      Balances.Balance = value;
    });
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            Balances.balance['consultIdQuery'], Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Balances = value;
    });
  }

  static final Map<String, dynamic> balance = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_regpace` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_regpace`",
    "describeTable": "DESCRIBE pace_bala;",
    "showColumns": "SHOW columns FROM pace_bala",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_bala'",
    "createQuery": """CREATE TABLE `pace_bala` (
                  `ID_Bala` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `ID_Pace` int(11) NOT NULL,
                  `Pace_bala_Fecha` date NOT NULL,
                  `Pace_bala_Time` time NOT NULL,
                  `Pace_bala_Oral` double NOT NULL,
                  `Pace_bala_Sonda` double NOT NULL,
                  `Pace_bala_Hemo` double NOT NULL,
                  `Pace_bala_NPT` double NOT NULL,
                  `Pace_bala_Sol` double NOT NULL,
                  `Pace_bala_Dil` double NOT NULL,
                  `Pace_bala_ING` double NOT NULL,
                  `Pace_bala_Uresis` double NOT NULL,
                  `Pace_bala_Evac` double NOT NULL,
                  `Pace_bala_Sangrado` double NOT NULL,
                  `Pace_bala_Succion` double NOT NULL,
                  `Pace_bala_Drenes` double NOT NULL,
                  `Pace_bala_PER` double NOT NULL,
                  `Pace_bala_ENG` double NOT NULL,
                  `Pace_bala_HOR` int NOT NULL 
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Registro de Líquidos en Pacientes Hospitalizados.';
            """,
    "truncateQuery": "TRUNCATE pace_bala",
    "dropQuery": "DROP TABLE pace_bala",
    "consultQuery": "SELECT * FROM pace_bala",
    "consultIdQuery": "SELECT * FROM pace_bala WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_bala WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_bala",
    "consultLastQuery": "SELECT * FROM pace_bala WHERE ID_Pace = ?",
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
}

class Ventilaciones {
  static int ID_Ventilaciones = 0;
  //
  static String selectedDiagnosis = "";
  //

  static Map<String, dynamic> Ventilacion = {};

  static List<String> actualDiagno = [
    'Ningún modo ventilatorio',
    'Ventilación Limitada por Presión Ciclada por Tiempo (P-VMC)',
    'Ventilación Limitada por Flujo Ciclada por Volumen (V-VMC)',
    'Ventilación Mandatoria Intermitente Sincronizada (SIMV / VMC)',
    'Ventilación Mandatoria Intermitente Sincronizada (SIMV / PMC)',
    'Ventilación Positiva en Vía Aerea con Presión Soporte (CPAP/PS)',
    'Espontáneo (ESPON)',
  ];

  static void ultimoRegistro() {
    Actividades.consultarId(
            Databases.siteground_database_regpace,
            Ventilaciones.ventilacion['consultLastQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
// Enfermedades de base del paciente, asi como las Hospitalarias.
      Ventilaciones.Ventilacion = value;
    });
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            Ventilaciones.ventilacion['consultIdQuery'], Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Ventilaciones = value;
    });
  }

  static final Map<String, dynamic> ventilacion = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_regpace` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_regpace`",
    "describeTable": "DESCRIBE pace_vm;",
    "showColumns": "SHOW columns FROM pace_vm",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_vm'",
    "createQuery": """CREATE TABLE `pace_vm` (
                  `ID_Ventilacion` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `ID_Pace` int(11) NOT NULL,
                  `Feca_VEN` date NOT NULL,
                  `Pace_Vt` double NOT NULL,
                  `Pace_Fr` int(11) NOT NULL,
                  `Pace_Fio` int(11) NOT NULL,
                  `Pace_Peep` int(11) NOT NULL,
                  `Pace_Insp` int(11) NOT NULL,
                  `Pace_Espi` int(11) NOT NULL,
                  `Pace_Pc` int(11) NOT NULL,
                  `Pace_Pm` int(11) NOT NULL,
                  `Pace_V` int(11) NOT NULL,
                  `Pace_F` int(11) NOT NULL,
                  `Pace_Ps` int(11) NOT NULL,
                  `Pace_Pip` int(11) NOT NULL,
                  `Pace_Pmet` int(11) NOT NULL,
                  `VM_Mod` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Registro de Valores de Ventilación Mecánica';
            """,
    "truncateQuery": "TRUNCATE pace_vm",
    "dropQuery": "DROP TABLE pace_vm",
    "consultQuery": "SELECT * FROM pace_vm",
    "consultIdQuery": "SELECT * FROM pace_vm WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM pace_vm WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM pace_vm",
    "consultLastQuery": "SELECT * FROM pace_vm WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM pace_vm WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO `pace_vm` (ID_Pace, "
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

class Licencias {
  static int ID_Licencias = 0;
  //
  static String selectedDiagnosis = "";
  //

  static Map<String, dynamic> Licencia = {};

  static List<String> actualDiagno = Dicotomicos.dicotomicos();
  static List<String> actualTratamiento = Dicotomicos.dicotomicos();
  static List<String> actualSuspendido = Dicotomicos.dicotomicos();

  static void ultimoRegistro() {
    Actividades.consultarId(Databases.siteground_database_regpace,
            Licencias.vicencia['consultLastQuery'], Pacientes.ID_Paciente)
        .then((value) {
// Enfermedades de base del paciente, asi como las Hospitalarias.
      Licencias.Licencia = value;
    });
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            Licencias.vicencia['consultIdQuery'], Pacientes.ID_Paciente)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Pacientes.Licencias = value;
    });
  }

  static final Map<String, dynamic> vicencia = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_regpace` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_regpace`",
    "describeTable": "DESCRIBE licen_med;",
    "showColumns": "SHOW columns FROM licen_med",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'licen_med'",
    "createQuery": """CREATE TABLE licen_med (
                          `ID_Licen_Med` int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                          `ID_Pace` int(10) NOT NULL,
                          `Folio` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          `Dias_Otorgados` int(10) NOT NULL,
                          `Fecha_Realizacion` date NOT NULL,
                          `Fecha_Inicio` date NOT NULL,
                          `Fecha_Termino` date NOT NULL,
                          `Motivo_Incapacidad` varchar(200) COLLATE utf8_unicode_ci NOT NULL, 
                          `Caracter` varchar(200) COLLATE utf8_unicode_ci NOT NULL, 
                          `Lugar_Expedicion` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 
                    COLLATE=utf8_unicode_ci 
                    COMMENT='Tabla para Registro de Expedición de Licencias Médicas.';
            """,
    "truncateQuery": "TRUNCATE licen_med",
    "dropQuery": "DROP TABLE licen_med",
    "consultQuery": "SELECT * FROM licen_med",
    "consultIdQuery": "SELECT * FROM licen_med WHERE ID_Pace = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM licen_med WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM licen_med",
    "consultLastQuery": "SELECT * FROM licen_med WHERE ID_Pace = ?",
    "consultByName": "SELECT * FROM licen_med WHERE Pace_APP_DEG LIKE '%",
    "registerQuery": "INSERT INTO licen_med (ID_Pace, Folio, Dias_Otorgados, "
        "Fecha_Realizacion, Fecha_Inicio, Fecha_Termino, "
        "Motivo_Incapacidad, Caracter, Lugar_Expedicion) "
        "VALUES (?,?,?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE licen_med "
        "SET ID_Licen_Med = ?, ID_Pace = ?, Folio = ?, "
        "Dias_Otorgados = ?, Fecha_Realizacion = ?, Fecha_Inicio = ?, Fecha_Termino = ?, "
        "Motivo_Incapacidad = ?, Caracter = ?, Lugar_Expedicion = ? "
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
  //
  static String selectedDiagnosis = "";
  //

  static Map<String, dynamic> Vacunas = {};

  static List<String> actualDiagno = Dicotomicos.dicotomicos();
  static List<String> actualTratamiento = Dicotomicos.dicotomicos();
  static List<String> actualSuspendido = Dicotomicos.dicotomicos();

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
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_regpace` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_regpace`",
    "describeTable": "DESCRIBE pace_app_vac;",
    "showColumns": "SHOW columns FROM pace_app_vac",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'pace_app_vac'",
    "createQuery": """CREATE TABLE pace_app_vac (
                        `ID_PACE_APP_VAC` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                        `ID_Pace` int(11) NOT NULL,
                        `Pace_APP_VAC_SINO` tinyint(1) NOT NULL,
                        `Pace_APP_VAC` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                        `Pace_APP_VAC_dia` int(200) NOT NULL,
                        `Pace_APP_VAC_tra_SINO` tinyint(1) NOT NULL,
                        `Pace_APP_VAC_tra` varchar(200) COLLATE utf8_unicode_ci NOT NULL
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
    "registerQuery": "INSERT INTO `pace_app_vac` (ID_Pace, Pace_APP_VAC_SINO, "
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
