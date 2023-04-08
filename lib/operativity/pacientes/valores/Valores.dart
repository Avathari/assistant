import 'dart:async';
import 'dart:math' as math;
import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:dart_numerics/dart_numerics.dart' as numerics;

import 'package:assistant/conexiones/conexiones.dart';

class Valores {
  bool loading = false;

  Map<String, dynamic> valores = {};

  static double? prueba;
  //
  static String? numeroPaciente,
      agregadoPaciente,
      primerNombre,
      segundoNombre,
      apellidoPaterno,
      apellidoMaterno,
      hemotipo,
      imagenUsuario,
      sexo,
      fechaNacimiento,
      telefono,
      curp,
      rfc,
      modoAtencion;
  static int? edad, numeroCama;
  static bool? isHospitalizado;

  static String folioLicencia = "",
      diasOtorgadosLicencia = "",
      fechaRealizacionLicencia = "",
      fechaInicioLicencia = "",
      fechaTerminoLicencia = "",
      motivoLicencia = "",
      caracterLicencia = "",
      lugarExpedicionLicencia = "",
      diagnosticoLicencia = "";

  static String fileAssocieted = "${Pacientes.localRepositoryPath}valores.json";
  //
  static int get edadDesdeNacimiento {
    if (fechaNacimiento != '' && fechaNacimiento != null) {
      // print(fechaNacimiento!);
      return int.parse(((DateTime.now()
                  .difference(DateTime.parse(fechaNacimiento!))
                  .inDays) /
              365)
          .toString());
    } else {
      return 0;
    }
  }

  static String? creenciasPaciente =
          'Refiere Ningún Prejuicio Relacionado a Creencias Personales',
      valoresPaciente =
          'Refiere Ningún Prejuicio Relacionado a Valores Personales',
      costumbresPaciente =
          'Refiere Ningun Prejuicio Relacionado a Costumbres Personales';
  static bool? prejuiciosAtencion = false,
      redesApoyo = true,
      apoyoMadre = false,
      apoyoPadre = false,
      apoyoHermanos = true,
      apoyoHijosMayores = true;

  static String? propiedadVivienda = Items.propiedad[0],
      otrosCohabitantes = '0',
      materialPiso = 'Cemento',
      materialParedes = 'Cemento',
      materialTecho = 'Cemento',
      viviendaCantidadVacunos = '0',
      viviendaCantidadOvinos = '0',
      viviendaCantidadPorcinos = '0',
      viviendaCantidadAves = '0',
      // ******** ******** ******** ******** ******
      viviendaCantidadCaninos = '0',
      viviendaCantidadFelinos = '0',
      viviendaCantidadReptiles = '0',
      viviendaCantidadParvada = '0';
  static bool cohabitaPadre = true,
      cohabitaMadre = true,
      cohabitaHijos = true,
      cohabitaFamiliares = false,
      cohabitaOtros = false,
      viviendaElectricidad = true,
      viviendaAguaPotable = true,
      viviendaAlcantarillado = true,
      viviendaDrenaje = true,
      viviendaTelevision = true,
      viviendaEstufa = true,
      viviendaHornoLena = false,
      viviendaSala = true,
      viviendaComedor = true,
      viviendaBano = true,
      viviendaHabitacionesSeparadas = true,
      // *********************************
      viviendaPatioDelantero = false,
      viviendaPatioTrasero = false,
      // *********************************
      viviendaAnimalesCorral = false,
      viviendaAnimalesCompania = false,
      // *********************************
      viviendaVacunos = false,
      viviendaOvinos = false,
      viviendaPorcinos = false,
      viviendaAves = false,
      // *********************************
      viviendaCaninos = false,
      viviendaFelinos = false,
      viviendaReptiles = false,
      viviendaParvada = false;

  static String? alimentacionDiariaDescripcion =
          'Refiere alimentación diaria tres veces al dia',
      dietaAsignadaDescripcion = 'Sin dieta asignada por nutriologo',
      variacionAlimentacionDescripcion = 'Sin variaciones en la alimentación',
      problemasMasticacionDescripcion =
          'No refiere problemas en la masticación',
      intoleranciaAlimentariaDescripcion =
          'No refiere alergia o intolerancia alimentaria de ningún tipo',
      alteracionesPesoDescripcion =
          'No refiere variaciones significativas del peso en los últimos dos meses';
  static bool? alimentacionDiaria = false,
      dietaAsignada = false,
      variacionAlimentacion = false,
      problemasMasticacion = false,
      intoleranciaAlimentaria = false,
      alteracionesPeso = false;

  static String? actividadesDiariasDescripcion = 'Labores Propias del Trabajo',
      pasatiemposDescripcion = 'No Comentados',
      horasSuenoDescripcion = Items.horasSueno[2],
      viajesRecientesDescripcion = '';
  static bool? viajesRecientes = false,
      problemasFamiliares = false,
      violenciaInfantil = false,
      abusoSustancias = false,
      problemasLaborales = false,
      estresLaboral = false,
      hostilidadLaboral = false,
      abusoLaboral = false,
      acosoLaboral = false,
      acosoSexual = false,
      abusoSexual = false;

  static bool? banoCorporal = true,
      higieneManos = true,
      cambiosRopa = true,
      aseoDental = true;
  static String? banoCorporalDescripcion =
          'Refiere realizar aseo corporal diario',
      higieneManosDescripcion =
          'Refiere realizar aseo de manos antes y después de comer e ir al baño',
      cambiosRopaDescripcion = 'Refiere cambio diario de ropa',
      aseoDentalDescripcion =
          'Refiere aseo dental tres veces al dia, pero no usa hilo dental';

  static bool? usoLentes = false,
      aparatoSordera = false,
      protesisDentaria = false,
      marcapasosCardiaco = false,
      ortesisDeambular = false,
      limitacionesActividadCotidiana = false;
  static String? usoLentesDescripcion =
          'No usa lentes graduados ni otro en particular',
      aparatoSorderaDescripcion = 'No usa aparatos por hipoacusia',
      protesisDentariaDescripcion = 'No usa prótesis dentaria',
      marcapasosCardiacoDescripcion = 'No presenta uso de marcapasos cardiaco',
      ortesisDeambularDescripcion = 'No usa ortésis al deambular',
      limitacionesActividadCotidianaDescripcion =
          'No presenta limitaciones en la actividad cotidiana';

  static bool? exposicionBiomasa = false,
      exposicionHumosQuimicos = false,
      exposicionPesticidas = false,
      exposicionMetalesPesados = false,
      exposicionPsicotropicos = false;
  static String? exposicionBiomasaDescripcion =
          'No refiere uso o exposición a humo de biomasa',
      exposicionHumosQuimicosDescripcion =
          'No refiere uso o exposición a humos químicos',
      exposicionPesticidasDescripcion =
          'No refiere uso o exposición a pesticidas',
      exposicionMetalesPesadosDescripcion =
          'No refiere uso o exposición a metales pesados',
      exposicionPsicotropicosDescripcion =
          'Sin referencia de uso de psicotrópicos';

  static bool? esAlcoholismo = false, suspensionAlcoholismo = false;
  static String? edadInicioAlcoholismo = '',
      duracionAnosAlcoholismo = '',
      periodicidadAlcoholismo = '',
      intervaloAlcoholismo = Items.periodicidad[0],
      aosSuspensionAlcoholismo = '',
      tiposAlcoholismo = Items.tiposAlcoholes[0],
      tiposAlcoholismoDescripcion = 'Alcoholes';

  static bool? esTabaquismo = false, suspensionTabaquismo = false;
  static String? edadInicioTabaquismo = '',
      duracionAnosTabaquismo = '',
      periodicidadTabaquismo = '',
      intervaloTabaquismo = Items.periodicidad[0], //'Días'
      aosSuspensionTabaquismo = '',
      tiposTabaquismo = Items.tiposTabacos[0],
      tiposTabaquismoDescripcion = 'Tabacos';

  static bool? esDrogadismo = false, suspensionDrogadismo = false;
  static String? edadInicioDrogadismo = '',
      duracionAnosDrogadismo = '',
      periodicidadDrogadismo = '',
      intervaloDrogadismo = Items.periodicidad[0],
      aosSuspensionDrogadismo = '',
      tiposDrogadismo = Items.tiposDrogas[0],
      tiposDrogadismoDescripcion = 'Drogas';

  static int get diasEstancia {
    if (fechaIngresoHospitalario != '' && fechaIngresoHospitalario != null) {
      // print(fechaIngresoHospitalario!);
      return DateTime.now()
          .difference(DateTime.parse(fechaIngresoHospitalario!))
          .inDays;
    } else {
      return 0;
    }
  }

  static String? get isEstanciaProlongada {
    if (diasEstancia == 0) {
      return 'Ingreso Hospitalario';
    } else if (diasEstancia > 0 && diasEstancia < 14) {
      return 'Estancia Hospitalaria';
    } else {
      return 'Estancia Prolongada';
    }
  }

  //
  static String? fechaIngresoHospitalario,
      fechaEgresoHospitalario,
      medicoTratante,
      servicioTratante,
      servicioTratanteInicial,
      motivoEgreso,
      fechaPadecimientoActual,
      padecimientoActual;
  //
  static String motivoCirugia = "",
      tipoCirugia = "",
      tipoInterrogatorio = 'Directo';
  //
  static String motivoTransfusion = "",
      hemotipoAdmnistrado = "",
      cantidadUnidades = "",
      volumenAdministrado = "",
      numIdentificacion = "",
      fechaCaducidad = "",
      fechaInicioTransfusion = "",
      fechaTerminoTransfusion = "",
      estadoFinalTransfusion =
          "Se realiza seguimiento y control a la paciente durante la transfusión. Termina procedimiento sin complicaciones ni evidencia de reacciones adversas asociadas a la transfusión de hemoderivados. ",
      reaccionesPresentadas = "Ninguna manifestada durante la transfusión. ";
  //
  static String? fechaVitales;
  static int? tensionArterialSystolica,
      tensionArterialDyastolica,
      presionVenosaCentral,
      frecuenciaCardiaca,
      frecuenciaRespiratoria,
      saturacionPerifericaOxigeno,
      glucemiaCapilar,
      horasAyuno,
      circunferenciaCintura,
      circunferenciaCadera,
      circunferenciaCuello,
      circunferenciaMesobraquial,
      circunferenciaPectoral,
      pliegueCutaneoBicipital,
      pliegueCutaneoEscapular,
      pliegueCutaneoIliaco,
      pliegueCutaneoTricipital,
      pliegueCutaneoPectoral,
      circunferenciaFemoralIzquierda,
      circunferenciaFemoralDerecha,
      circunferenciaSuralIzquierda,
      circunferenciaSuralDerecha;
  static double? temperaturCorporal,
      pesoCorporalTotal,
      alturaPaciente,
      factorActividad,
      factorEstres;
  //
  static double? presionArteriaPulmonarSistolica,
      presionArteriaPulmonarDiastolica,
      presionMediaArteriaPulmonar,
      presionCunaPulmonar;
  //
  static String? fechaRealizacionBalances = "";
  // static double diuresis = 0;
  static int? viaOralBalances = 0,
      sondaOrogastricaBalances = 0,
      hemoderivadosBalances = 0,
      nutricionParenteralBalances = 0,
      parenteralesBalances = 0,
      dilucionesBalances = 0,
      otrosIngresosBalances = 0;
  static int? uresisBalances = 0,
      evacuacionesBalances = 0,
      sangradosBalances = 0,
      succcionBalances = 0,
      drenesBalances = 0,
      otrosEgresosBalances = 0;
  static int? uresis = 0, horario = 8;
  //
  static String? fechaBiometria;
  static double? eritrocitos,
      hemoglobina,
      hematocrito,
      concentracionMediaHemoglobina,
      volumenCorpuscularMedio,
      hemoglobinaCorpuscularMedia,
      plaquetas,
      leucocitosTotales,
      linfocitosTotales,
      neutrofilosTotales,
      monocitosTotales;
  //
  static double? glucosa, urea, creatinina, acidoUrico, nitrogenoUreico;
  //
  static String? fechaHepaticos;
  static double? alaninoaminotrasferasa,
      aspartatoaminotransferasa,
      bilirrubinasTotales,
      bilirrubinaDirecta,
      bilirrubinaIndirecta,
      deshidrogenasaLactica,
      glutrailtranspeptidasa,
      fosfatasaAlcalina,
      albuminaSerica,
      proteinasTotales;
  //
  static String? fechaGasometriaVenosa, fechaGasometriaArterial;
  static double? pHArteriales,
      pcoArteriales,
      poArteriales,
      bicarbonatoArteriales,
      excesoBaseArteriales,
      fioArteriales,
      soArteriales;
  static double? pHVenosos,
      pcoVenosos,
      poVenosos,
      bicarbonatoVenosos,
      excesoBaseVenosos,
      fioVenosos,
      soVenosos;
  //
  static double? sodio, potasio, cloro, fosforo, calcio, magnesio;
  //
  static double? procalcitonina,
      lactato,
      velocidadSedimentacionGlobular,
      proteinaCreactiva,
      factorReumatoide,
      anticuerpoCitrulinado;
  //
  static String? ritmoCardiaco = '',
      segmentoST = '',
      patronQRS = '',
      conclusionElectrocardiograma = '',
      fechaElectrocardiograma = '';
  static int? intervaloRR, rV1, sV6, sV1, rV6, rAvL, sV3;
  static double? duracionOndaP,
      alturaOndaP,
      duracionPR,
      duracionQRS,
      alturaQRS,
      QRSi,
      QRSa,
      ejeCardiaco,
      //
      alturaSegmentoST,
      duracionQT,
      duracionOndaT,
      alturaOndaT,
      //
      deflexionIntrinsecoide,
      rDI,
      sDI,
      rDIII,
      sDIII;
  //
  // Parámetros Ventilatorios
  static String? fechaVentilaciones = '', modalidadVentilatoria = '';
  static int? frecuenciaVentilatoria = 0,
      fraccionInspiratoriaVentilatoria = 0,
      presionFinalEsiracion = 0,
      sensibilidadInspiratoria = 0,
      sensibilidadEspiratoria = 0,
      presionControl = 0,
      presionMaxima = 0,
      volumenVentilatorio = 0,
      flujoVentilatorio = 0,
      presionSoporte = 0,
      presionInspiratoriaPico = 0,
      presionPlateau = 0;
  static double? volumenTidal = 0;

  // Referencias del paciente
  static String estadoGeneral = Items.estadoGeneral[0],
      viaOral = Items.viaOralAlimentacion[0],
      uresisCantidad = Items.uresisCantidad[0],
      excretasCantidad = Items.excretasCantidad[0],
      referenciasHospitalizacion = "Sin referencias por parte del paciente";
  // Variables Estaticas
  static int? constanteRequerimientos = 30;
  static int porcentajeCarbohidratos = 50;
  static int porcentajeLipidos = 20;
  static int porcentajeProteinas = 30;
  static int presionBarometrica = 585; // mmHg (Nm: 760
  static int presionVaporAgua = 47; // mmHg
  static int presionGasSeco = 536; // mmHg
  static double pi = 3.14159265;
  // Variables de Procedimientos
  static String? motivoProcedimiento;
  static String? sitiosCateterCentral,
      sitiosSondaPleural,
      sitiosCateterTenckhoff,
      sitiosPuncionLumbar,
      sitios;
  static String? complicacionesProcedimiento,
      pendientesProcedimiento,
      anestesiaEmpleada;
  // Variables de Valoraciones
  static String? valoracionAsa, valoracionBromage, valoracionNyha;
  // Variables de la situación hospitalaria
  static String? dispositivoOxigeno = Items.dispositivosOxigeno[0],
      dispositivoEmpleado = Items.dispositivosOxigeno[0],
      auxiliarVentilacion = Items.dispositivosOxigeno[0],
      rass = Escalas.RASS[0],
      ramsay = Escalas.ramsay[0],
      ashworth = Escalas.ashworth[0],
      daniels = Escalas.daniels[0],
      mrc = Escalas.MRC[0],
      faseVentilatoria = Items.ventilatorio[0],
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
  static bool? isCateterPeriferico = false,
      isCateterLargoPeriferico = false,
      isCateterVenosoCentral = false,
      isSondaFoley = false,
      isDrenajePenrose = false,
      isSondaNasogastrica = false,
      isSondaOrogastrica = false,
      isDrenajePenros = false,
      isPleuroVac = false,
      isColostomia = false,
      isGastrostomia = false,
      isDialisisPeritoneal = false;
  // Variables del Ordenamiento del Expediente Clínico
  static bool? isPortada = false,
      isHistoriaClinica = false,
      isNotaIngreso = false,
      isEvaluacionInicial = false,
      isValoracionVademecum = false,
      isConsentimientos = false,
      isOrdenado = false;
  //
  static String? antecedenteInfarto = Dicotomicos.dicotomicos()[1];
  static String? ritmoSinusal = Dicotomicos.dicotomicos()[0];
  static String? extrasistolesVentriculares = Dicotomicos.dicotomicos()[1];
  static String? ingurgitacionYugular = Dicotomicos.dicotomicos()[1];
  static String? estenosisAortica = Dicotomicos.dicotomicos()[1];
  static String? cirugiaUrgencia = Dicotomicos.dicotomicos()[1];
  static String? cirugiaAbdomen = Dicotomicos.dicotomicos()[0];
  static String? malEstadoOrganico = Dicotomicos.dicotomicos()[1];
  static String? anginaEnMeses = Dicotomicos.dicotomicos()[1];
  static String? edemaPulmonar = Dicotomicos.dicotomicos()[1];
  static String? edemaPulmonarPasado = Dicotomicos.dicotomicos()[1];
  static String? saturacionPerifericaOrigeno =
      Escalas.saturacionPerifericaOrigeno[0];
  static String? infeccionRespiratoria = Dicotomicos.dicotomicos()[1];
  static String? hemoglobinaInferior = Dicotomicos.dicotomicos()[1];
  static String? incisionTipo = Escalas.incisionTipo[0];
  static String? duracionCirugiaHoras = Escalas.duracionCirugiaHoras[0];
  //

  Valores();

  Future<bool> load() async {
    // Otras configuraciones
    Escalas.serviciosHospitalarios = await Archivos.listFromText(
        path: 'assets/diccionarios/Servicios.txt', splitChar: ',');
    //
    valores.addAll(Pacientes.Paciente);
    // ********* *********** ********** ******
    Pacientes.getImage();
    // ********* *********** ********** ******

    // ********* *********** ********** ******
    Eticos.consultarRegistro();
    Viviendas.consultarRegistro();
    Higienes.consultarRegistro();
    Diarios.consultarRegistro();
    Alimenticios.consultarRegistro();
    Limitaciones.consultarRegistro();
    Sustancias.consultarRegistro();
    //
    Toxicomanias.consultarRegistro();
    // ********* *********** ********** ******
    Vitales.registros();
    // Vitales.ultimoRegistro();
    Patologicos.registros();
    Patologicos.consultarRegistro();
    Diagnosticos.registros();
    Diagnosticos.consultarRegistro();
    Alergicos.registros();
    Alergicos.consultarRegistro();
    Quirurgicos.registros();
    Quirurgicos.consultarRegistro();
    Transfusionales.registros();
    Transfusionales.consultarRegistro();
    Traumatologicos.registros();
    Traumatologicos.consultarRegistro();
    Vacunales.registros();
    Vacunales.consultarRegistro();
    //
    Balances.consultarRegistro();
    Auxiliares.registros();
// ********* *********** ********** ******
//     Electrocardiogramas.ultimoRegistro();
    // Pacientes.diagnosticos();
    // Ventilaciones.ultimoRegistro();
// ********* *********** ********** ******
    // Llamado a las distintas clases de valores.
    // final patol = await Actividades.consultarId(
    //     Databases.siteground_database_regpace,
    //     Patologicos.patologicos['consultLastQuery'],
    //     Pacientes.ID_Paciente);
    // valores.addAll(patol); // Enfermedades de base del paciente, asi como las Hospitalarias.
    final vital = await Actividades.consultarId(
        Databases.siteground_database_regpace,
        Vitales.vitales['consultLastQuery'],
        Pacientes.ID_Paciente);
    // Pacientes.Vital = vital;
    valores.addAll(vital);

    final antro = await Actividades.consultarId(
        Databases.siteground_database_regpace,
        Vitales.antropo['consultLastQuery'],
        Pacientes.ID_Paciente);
    valores.addAll(antro);
    Pacientes.Vital.addAll(antro);
    final aux = await Actividades.detallesById(
        Databases.siteground_database_reggabo,
        Auxiliares.auxiliares['auxiliarStadistics'],
        Pacientes.ID_Paciente,
        emulated: true);
    // Terminal.printExpected(message: "Auxiliares ${Auxiliares.auxiliares['auxiliarStadistics']} $aux");
    valores.addAll(aux);
    final elect = await Actividades.consultarId(
        Databases.siteground_database_reggabo,
        Electrocardiogramas.electrocardiogramas['consultLastQuery'],
        Pacientes.ID_Paciente,
        emulated: true);
    Pacientes.Electrocardiogramas = elect;
    valores.addAll(elect);

    final vento = await Actividades.consultarId(
        Databases.siteground_database_reghosp,
        Ventilaciones.ventilacion['consultLastQuery'],
        Pacientes.ID_Paciente,
        emulated: true);
    valores.addAll(vento);

    final bala = await Actividades.consultarId(
        Databases.siteground_database_reghosp,
        Balances.balance['consultLastQuery'],
        Pacientes.ID_Paciente,
        emulated: true);
    valores.addAll(bala);

    final hosp = await Actividades.consultarId(
        Databases.siteground_database_reghosp,
        Hospitalizaciones.hospitalizacion['consultLastQuery'],
        Pacientes.ID_Paciente,
        emulated: true);
    valores.addAll(hosp);

    Valores.fromJson(valores);
    return true;
  }

  Valores.fromJson(Map<String, dynamic> json) {
    // print("Valors $json");

    numeroPaciente = json['Pace_NSS'];
    agregadoPaciente = json['Pace_AGRE'];
    primerNombre = json['Pace_Nome_PI'];
    segundoNombre = json['Pace_Nome_SE'];
    apellidoPaterno = json['Pace_Ape_Pat'];
    apellidoMaterno = json['Pace_Ape_Mat'];
    hemotipo = Pacientes.Paciente['Pace_Hemo'] ?? '';
    // imagenUsuario = json['Pace_FIAT'];
    // Pacientes.imagenPaciente = json['Pace_FIAT'];
    json.addAll({'Pace_FIAT': ''});

    // Actualización de las Directrices ********** ***********
    Pacientes.nombreCompleto = Valores.nombreCompleto;
    Pacientes.localPath = 'assets/vault/'
        '${Pacientes.nombreCompleto}/'
        '${Pacientes.nombreCompleto}.json';
    Pacientes.localRepositoryPath = 'assets/vault/'
        '${Pacientes.nombreCompleto}/';
    Pacientes.localReportsPath = 'assets/vault/'
        '${Pacientes.nombreCompleto}/'
        'reportes/';

    // Actualización de las Directrices Complementarias ********** ***********
    Valores.fileAssocieted = "${Pacientes.localRepositoryPath}valores.json";
    Eticos.fileAssocieted =
        "${Pacientes.localRepositoryPath}eticos.json"; // Eticos.registrarRegistro(); // Si
    Viviendas.fileAssocieted =
        "${Pacientes.localRepositoryPath}viviendas.json"; // Viviendas.registrarRegistro(); // Si
    Higienes.fileAssocieted =
        "${Pacientes.localRepositoryPath}higienicos.json"; // Higienes.registrarRegistro(); // Si
    Diarios.fileAssocieted =
        "${Pacientes.localRepositoryPath}diarios.json"; // Diarios.registrarRegistro();
    Alimenticios.fileAssocieted =
        "${Pacientes.localRepositoryPath}alimenticios.json"; // Alimenticios.registrarRegistro(); // Si
    Limitaciones.fileAssocieted =
        "${Pacientes.localRepositoryPath}limitaciones.json"; // Limitaciones.registrarRegistro(); // Si
    Sustancias.fileAssocieted =
        "${Pacientes.localRepositoryPath}exposiciones.json"; // Sustancias.registrarRegistro();

    Patologicos.fileAssocieted =
        '${Pacientes.localRepositoryPath}patologicos.json';
    Toxicomanias.fileAssocieted =
        "${Pacientes.localRepositoryPath}toxicomanias.json";
    Quirurgicos.fileAssocieted =
        '${Pacientes.localRepositoryPath}quirurgicos.json';
    Alergicos.fileAssocieted = '${Pacientes.localRepositoryPath}alergicos.json';
    Transfusionales.fileAssocieted =
        '${Pacientes.localRepositoryPath}transfusionales.json';
    Vacunales.fileAssocieted = '${Pacientes.localRepositoryPath}vacunales.json';

    Diagnosticos.fileAssocieted =
        '${Pacientes.localRepositoryPath}diagnosticos.json';
    Pendientes.fileAssocieted =
        '${Pacientes.localRepositoryPath}pendientes.json';

    Vitales.fileAssocieted = '${Pacientes.localRepositoryPath}vitales.json';
    Auxiliares.fileAssocieted =
        '${Pacientes.localRepositoryPath}paraclinicos.json';
    Imagenologias.fileAssocieted =
        '${Pacientes.localRepositoryPath}imagenologicos.json';
    Electrocardiogramas.fileAssocieted =
        '${Pacientes.localRepositoryPath}electrocardiogramas.json';
    Balances.fileAssocieted = '${Pacientes.localRepositoryPath}balances.json';
    //
    edad = json['Pace_Eda']; // int.parse();
    sexo = json['Pace_Ses'];
    curp = json['Pace_Curp'];
    rfc = json['Pace_RFC'];
    fechaNacimiento = json['Pace_Nace'];
    telefono = json['Pace_Tele'];
    //
    modoAtencion = json['Pace_Hosp'];

    // Comprobar estado de Atención del Paciente.
    if (modoAtencion == 'Hospitalización') {
      isHospitalizado = true;
      Pacientes.esHospitalizado = true;
    } else if (modoAtencion == 'Consulta Externa') {
      isHospitalizado = false;
      Pacientes.esHospitalizado = false;
    } else {
      isHospitalizado = false;
      Pacientes.esHospitalizado = false;
    }
    //
    presionArteriaPulmonarSistolica = double.parse(json['PAPS'] ?? '0');
    presionArteriaPulmonarDiastolica = double.parse(json['PAPD'] ?? '0');
    presionMediaArteriaPulmonar = double.parse(json['PMAP'] ?? '0');
    presionCunaPulmonar = double.parse(json['PoP'] ?? '0');
    //
    pesoCorporalTotal = toDoubleFromInt(json: json, keyEntered: 'Pace_SV_pct');
    // = double.parse(json['Pace_SV_pct'] != null ? json['Pace_SV_pct'].toString() : '0');
    alturaPaciente = toDoubleFromInt(json: json, keyEntered: 'Pace_SV_est');
    // json['Pace_SV_est'] ?? 0.0;

    fechaVitales = json['Pace_Feca_SV'] ?? '';
    tensionArterialSystolica = json['Pace_SV_tas'] ?? 0;
    tensionArterialDyastolica = json['Pace_SV_tad'] ?? 0;
    presionVenosaCentral = json['Pace_SV_pcv'] ?? 0;
    frecuenciaCardiaca = json['Pace_SV_fc'] ?? 0;
    frecuenciaRespiratoria = json['Pace_SV_fr'] ?? 0;
    temperaturCorporal = double.parse(
        json['Pace_SV_tc'] != null ? json['Pace_SV_tc'].toString() : '0');
    saturacionPerifericaOxigeno = json['Pace_SV_spo'] ?? 0;
    glucemiaCapilar = json['Pace_SV_glu'] ?? 0;
    horasAyuno = json['Pace_SV_glu_ayu'] ?? 0;

    circunferenciaCuello = json['Pace_SV_cue'] ?? 0;
    circunferenciaCintura = json['Pace_SV_cin'] ?? 0;
    circunferenciaCadera = json['Pace_SV_cad'] ?? 0;

    circunferenciaMesobraquial = json['Pace_SV_cmb'] ?? 0;
    factorActividad = double.parse(
        json['Pace_SV_fa'] != null ? json['Pace_SV_fa'].toString() : '0');
    factorEstres = double.parse(
        json['Pace_SV_fe'] != null ? json['Pace_SV_fe'].toString() : '0');

    pliegueCutaneoBicipital = json['Pace_SV_pcb'] ?? 0;
    pliegueCutaneoEscapular = json['Pace_SV_pse'] ?? 0;
    pliegueCutaneoIliaco = json['Pace_SV_psi'] ?? 0;
    pliegueCutaneoTricipital = json['Pace_SV_pst'] ?? 0;
    pliegueCutaneoPectoral = json['Pace_SV_c_pect'] ?? 0;

    circunferenciaFemoralIzquierda = json['Pace_SV_c_fem_izq'] ?? 0;
    circunferenciaFemoralDerecha = json['Pace_SV_c_fem_der'] ?? 0;
    circunferenciaSuralIzquierda = json['Pace_SV_c_suro_izq'] ?? 0;
    circunferenciaSuralDerecha = json['Pace_SV_c_suro_der'] ?? 0;
    //
    fechaBiometria = json['Fecha_Registro_Biometria'] ?? '';
    eritrocitos = double.parse(json['Eritrocitos'] ?? '0');
    hematocrito = double.parse(json['Hematocrito'] ?? '0');
    hemoglobina = double.parse(json['Hemoglobina'] ?? '0');

    concentracionMediaHemoglobina = double.parse(json['CMHC'] ?? '0');
    volumenCorpuscularMedio = double.parse(json['VCM'] ?? '0');
    hemoglobinaCorpuscularMedia = double.parse(json['HCM'] ?? '0');

    plaquetas = double.parse(json['Plaquetas'] ?? '0');

    leucocitosTotales = double.parse(json['Leucocitos_Totales'] ?? '0');
    neutrofilosTotales = double.parse(json['Neutrofilos_Totales'] ?? '0');
    linfocitosTotales = double.parse(json['Linfocitos_Totales'] ?? '0');
    monocitosTotales = double.parse(json['Monocitos_Totales'] ?? '0');
    //
    glucosa = double.parse(json['Glucosa'] ?? '0');
    urea = double.parse(json['Urea'] ?? '0');
    creatinina = double.parse(json['Creatinina'] ?? '0');
    acidoUrico = double.parse(json['Acido_Urico'] ?? '0');
    nitrogenoUreico = double.parse(json['Nitrogeno_Ureico'] ?? '0');

    //
    sodio = double.parse(json['Sodio'] ?? '0');
    potasio = double.parse(json['Potasio'] ?? '0');
    cloro = double.parse(json['Cloro'] ?? '0');
    magnesio = double.parse(json['Magnesio'] ?? '0');
    fosforo = double.parse(json['Fosforo'] ?? '0');
    calcio = double.parse(json['Calcio'] ?? '0');
    //
    alaninoaminotrasferasa =
        double.parse(json['Alaninoaminotrasferasa'] ?? '0');
    aspartatoaminotransferasa =
        double.parse(json['Aspartatoaminotransferasa'] ?? '0');
    bilirrubinasTotales = double.parse(json['Bilirrubinas_Totales'] ?? '0');
    bilirrubinaDirecta = double.parse(json['Bilirrubina_Directa'] ?? '0');
    bilirrubinaIndirecta = double.parse(json['Bilirrubina_Indirecta'] ?? '0');
    deshidrogenasaLactica = double.parse(json['Glutrailtranspeptidasa'] ?? '0');
    glutrailtranspeptidasa =
        double.parse(json['Glutrailtranspeptidasa'] ?? '0');
    fosfatasaAlcalina = double.parse(json['Fosfatasa_Alcalina'] ?? '0');
    albuminaSerica = double.parse(json['Albumina_Serica'] ?? '0');
    proteinasTotales = double.parse(json['Proteinas_Totales'] ?? '0');
    //
    procalcitonina = double.parse(json['Procalcitonina'] ?? '0');
    lactato = double.parse(json['Acido_Lactico'] ?? '0');
    velocidadSedimentacionGlobular =
        double.parse(json['Velocidad_Sedimentacion'] ?? '0');
    proteinaCreactiva = double.parse(json['Proteina_Reactiva'] ?? '0');
    factorReumatoide = double.parse(json['Factor_Reumatoide'] ?? '0');
    anticuerpoCitrulinado = double.parse(json['Anticuerpo_Citrulinado'] ?? '0');
    //
    fechaGasometriaArterial = json['Fecha_Registro_Arterial'];
    pHArteriales = double.parse(json['Ph_Arterial'] ?? '0');
    pcoArteriales = double.parse(json['Pco_Arterial'] ?? '0');
    poArteriales = double.parse(json['Po_Arterial'] ?? '0');
    bicarbonatoArteriales = double.parse(json['Hco_Arterial'] ?? '0');
    excesoBaseArteriales = double.parse(json['Eb_Arterial'] ?? '0');
    fioArteriales = double.parse(json['Fio_Arterial'] ?? '0');
    soArteriales = double.parse(json['So_Arterial'] ?? '0');
    //
    fechaGasometriaVenosa = json['Fecha_Registro_Venosa'];
    pHVenosos = double.parse(json['Ph_Venosa'] ?? '0');
    pcoVenosos = double.parse(json['Pco_Venosa'] ?? '0');
    poVenosos = double.parse(json['Po_Venosa'] ?? '0');
    bicarbonatoVenosos = double.parse(json['Hco_Venosa'] ?? '0');
    fioVenosos = double.parse(json['Fio_Venosa'] ?? '0');
    soVenosos = double.parse(json['So_Venosa'] ?? '0');
    //
    fechaElectrocardiograma = json['Pace_GAB_EC_Feca'] ?? '';
    ritmoCardiaco = json['Pace_EC_rit'] ?? '';
    intervaloRR = json['Pace_EC_rr'] ?? 0;
    duracionOndaP = double.parse(
        json['Pace_EC_dop'] != null ? json['Pace_EC_dop'].toString() : '0');

    alturaOndaP = toDoubleFromInt(json: json, keyEntered: 'Pace_EC_aop');
    duracionPR = toDoubleFromInt(json: json, keyEntered: 'Pace_EC_dpr');
    duracionQRS = toDoubleFromInt(json: json, keyEntered: 'Pace_EC_dqrs');
    alturaQRS = toDoubleFromInt(json: json, keyEntered: 'Pace_EC_aqrs');
    QRSi = toDoubleFromInt(json: json, keyEntered: 'Pace_EC_qrsi');
    QRSa = toDoubleFromInt(json: json, keyEntered: 'Pace_EC_qrsa');
    //
    ejeCardiaco = double.parse(json['Pace_QRS'] ?? '0');
    //
    segmentoST = json['Pace_EC_st'] ?? '';
    alturaSegmentoST = toDoubleFromInt(json: json, keyEntered: 'Pace_EC_ast_');
    duracionQT = toDoubleFromInt(json: json, keyEntered: 'Pace_EC_dqt');
    duracionOndaT = toDoubleFromInt(json: json, keyEntered: 'Pace_EC_dot');
    alturaOndaT = toDoubleFromInt(json: json, keyEntered: 'Pace_EC_aot');
    //
    rV1 = json['EC_rV1'] ?? 0;
    sV6 = json['EC_sV6'] ?? 0;
    sV1 = json['EC_sV1'] ?? 0;
    rV6 = json['EC_rV6'] ?? 0;
    rAvL = json['EC_rAVL'] ?? 0;
    sV3 = json['EC_sV3'] ?? 0;
    //
    patronQRS = json['PatronQRS'] ?? '';
    deflexionIntrinsecoide =
        toDoubleFromInt(json: json, keyEntered: 'DeflexionIntrinsecoide');

    rDI = toDoubleFromInt(json: json, keyEntered: 'EC_rDI');
    sDI = toDoubleFromInt(json: json, keyEntered: 'EC_sDI');
    rDIII = toDoubleFromInt(json: json, keyEntered: 'EC_rDIII');
    sDIII = toDoubleFromInt(json: json, keyEntered: 'EC_sDIII');
    //
    conclusionElectrocardiograma = json['Pace_EC_CON'] ?? '';
    //
    fechaVentilaciones = json['Feca_VEN'] ?? '';
    modalidadVentilatoria = json['VM_Mod'] ?? '';
    frecuenciaVentilatoria = json['Pace_Fr'] ?? 0;
    fraccionInspiratoriaVentilatoria = json['Pace_Fio'] ?? 0;
    presionFinalEsiracion = json['Pace_Peep'] ?? 0;
    sensibilidadInspiratoria = json['Pace_Insp'] ?? 0;
    sensibilidadEspiratoria = json['Pace_Espi'] ?? 0;
    presionControl = json['Pace_Pc'] ?? 0;
    presionMaxima = json['Pace_Pm'] ?? 0;

    volumenVentilatorio = json['Pace_V'] ?? 0;
    flujoVentilatorio = json['Pace_F'] ?? 0;
    presionSoporte = json['Pace_Ps'] ?? 0;
    presionInspiratoriaPico = json['Pace_Pip'] ?? 0;
    presionPlateau = json['Pace_Pmet'] ?? 0;
    volumenTidal = toDoubleFromInt(json: json, keyEntered: 'Pace_Vt');

    // Datos generales de la última Hospitalización. **** ** *********** ****** * *** *
    Pacientes.ID_Hospitalizacion = json['ID_Hosp'] ?? 0;
    Hospitalizaciones.Hospitalizacion['ID_Hosp'] = Pacientes.ID_Hospitalizacion;
    // ******************************************** *** *
    Valores.fechaIngresoHospitalario = json['Feca_INI_Hosp'] ?? '';
    Hospitalizaciones.Hospitalizacion['Feca_INI_Hosp'] =
        Valores.fechaIngresoHospitalario;
    Valores.numeroCama = json['Id_Cama'] ?? 0;
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

    json['Pace_FIAT'] = Pacientes.imagenPaciente;
    //
    Archivos.createJsonFromMap([json], filePath: Pacientes.localPath);
  }

  static String get nombreCompleto {
    if (Valores.segundoNombre == '' || Valores.segundoNombre == null) {
      return "${Valores.primerNombre} ${Valores.apellidoPaterno} ${Valores.apellidoMaterno}";
    } else {
      return "${Valores.primerNombre} ${Valores.segundoNombre} ${Valores.apellidoPaterno} ${Valores.apellidoMaterno}";
    }
  }

  static String get numeroExpediente =>
      '${Valores.numeroPaciente} ${Valores.agregadoPaciente}';

  static String get tensionArterialSistemica =>
      '${Valores.tensionArterialSystolica}/${Valores.tensionArterialDyastolica}';
  static double get imc =>
      pesoCorporalTotal! / (alturaPaciente! * alturaPaciente!);

  static double get requerimientoHidrico {
    if (Valores.pesoCorporalTotal != 0 && Valores.pesoCorporalTotal != null) {
      return (pesoCorporalTotal! * constanteRequerimientos!);
    } else {
      return double.nan;
    }
  }

  static double get aguaCorporalTotal {
    if (Valores.pesoCorporalTotal != 0 && Valores.pesoCorporalTotal != null) {
      if (sexo == "Masculino") {
        return 0.60 * pesoCorporalTotal!;
      } else if (sexo == "Femenino") {
        return 0.55 * pesoCorporalTotal!;
      } else {
        return 0.60 * pesoCorporalTotal!;
      }
    } else {
      return double.nan;
    }
  }

  static double get excesoAguaLibre {
    if (Valores.sodio != 0 && Valores.sodio != null) {
      return (Valores.aguaCorporalTotal) *
          ((1) - (140 / Valores.sodio!)); // Delta H2O Resultado en Litros.
    } else {
      return double.nan;
    }
  }

  static double get deficitAguaCorporal {
    if (Valores.sodio != 0 && Valores.sodio != null) {
      return ((Valores.aguaCorporalTotal) *
          ((Valores.sodio! - 140.00) / 140.00)); // Deficit de Agua Corporal
    } else {
      return double.nan;
    }
  }

  static double get deficitBicarbonato {
    if (Valores.bicarbonatoArteriales != 0 ||
        Valores.bicarbonatoArteriales == null) {
      return (28 - Valores.bicarbonatoArteriales!) *
          Valores.pesoCorporalTotal! *
          0.5;
    } else {
      return 0.0;
    }
  }

  static double get osmolaridadSerica {
    if (Valores.sodio != 0 &&
        Valores.sodio != null &&
        Valores.potasio != 0 &&
        Valores.potasio != null &&
        Valores.glucosa != 0 &&
        Valores.glucosa != null &&
        Valores.urea != 0 &&
        Valores.urea != null) {
      return ((2 * (Valores.sodio! + Valores.potasio!)) +
          (Valores.glucosa! / 18) +
          (Valores.urea! / 2.8));
    } else {
      return double.nan;
    }
  }

  static double get brechaOsmolar => (290.00 - (Valores.osmolaridadSerica));

  static double get SOL => (aguaCorporalTotal * osmolaridadSerica);

  static double get LIC => aguaCorporalTotal * 0.666;
  static double get LEC => aguaCorporalTotal * 0.333;
  static double get LI => aguaCorporalTotal * 0.222;
  static double get LIV => aguaCorporalTotal * 0.111;

  static double get VP => aguaCorporalTotal * 0.074;
  static double get VS => aguaCorporalTotal * 0.037;

  static double get deficitSodio {
    if (Valores.sodio != 0 && Valores.sodio != null) {
      if (Valores.sodio! < 120) {
        return 120 - Valores.sodio!;
      } else if (Valores.sodio! > 120 && Valores.sodio! < 120) {
        return (130 - Valores.sodio!) * aguaCorporalTotal;
      } else if (Valores.sodio! > 130) {
        return 120 - Valores.sodio!;
      } else {
        return 0.0;
      }
    } else {
      return 0.0;
    }
  }

  static String get sodioCorregido {
    if (Valores.glucosa! > 200) {
      return "Sodio Corregido: ${Valores.sodioCorregidoGlucosa} mEq/L. ";
    } else {
      return "";
    }
  }

  static double get reposicionSodio =>
      ((140 - Valores.sodio!) / (aguaCorporalTotal + 1.0));
  static double get VIF =>
      reposicionSodio + ((140 - Valores.sodio!) / (aguaCorporalTotal + 1.0));

  static double get sodioCorregidoGlucosa {
    if (Valores.sodio != 0 &&
        Valores.sodio != null &&
        Valores.glucosa != 0 &&
        Valores.glucosa != null) {
      return (Valores.sodio! + ((1.65 * Valores.glucosa! - 100) / 100));
    } else {
      return double.nan;
    }
  }

  static double get globulinasSericas {
    if (Valores.proteinasTotales != 0 &&
        Valores.proteinasTotales != null &&
        Valores.albuminaSerica != 0 &&
        Valores.albuminaSerica != null) {
      return (Valores.proteinasTotales! - Valores.albuminaSerica!);
    } else {
      return double.nan;
    }
  }

  static double get calcioCorregidoAlbumina {
    if (Valores.proteinasTotales != 0 &&
        Valores.proteinasTotales != null &&
        Valores.albuminaSerica != 0 &&
        Valores.albuminaSerica != null &&
        Valores.calcio != 0 &&
        Valores.calcio != null) {
      if (Valores.albuminaSerica != 0) {
        if (globulinasSericas != 0) {
          return (Valores.calcio! +
              (0.16 *
                  ((Valores.proteinasTotales! - Valores.albuminaSerica!) -
                      7.4)));
        } else {
          return (Valores.calcio! + (0.8 * (4.0 - Valores.albuminaSerica!)));
        }
      } else if (Valores.proteinasTotales != 0) {
        return (Valores.calcio! - Valores.proteinasTotales! * 0.676) + (4.87);
      } else {
        return 00.00;
        //return (Valores.albuminaSerica! * 8) +
        //  ((Valores.proteinasTotales! - Valores.albuminaSerica!) * 2) +
        //3;
      }
    } else {
      return double.nan;
    }
  }

  static double get CACPH {
    if (Valores.pHArteriales! != 0) {
      return (Valores.calcio! + (0.12 * ((Valores.pHArteriales! - 7.4) / 0.1)));
    } else {
      return 0.0;
    }
  }

  static double get tasaRenalCrockoft_Gault {
    if (Valores.creatinina! != 0) {
      return ((140 - Valores.edad!) *
          Valores.pesoCorporalTotal! /
          (72 * Valores.creatinina!));
    } else {
      return 0.0;
    }
  }

  static double get tasaRenalMDRD {
    if (Valores.sexo! == 'Masculino') {
      return ((186.3 *
          ((math.pow(Valores.creatinina!, -1.154) *
              (math.pow(Valores.edad!, -0.203) * (1.0) * (1.0))))));
    } else if (Valores.sexo! == 'Femenino') {
      return ((186.3 *
          ((math.pow(Valores.creatinina!, -1.154) *
              (math.pow(Valores.edad!, -0.203) * (1.018) * (1.0))))));
    } else {
      return 0.0;
    }
  }

  static double get tasaRenalCKDEPI {
    if (Valores.sexo! == 'Masculino') {
      return ((141 *
          (math.pow((Valores.creatinina! / 0.9), -0.411)) *
          (math.pow((Valores.creatinina! / 0.9), -1.209)) *
          (math.pow(0.993, Valores.edad!)) *
          (1.0) *
          (1.0)));
    } else if (Valores.sexo! == 'Femenino') {
      return ((141 *
          (math.pow((Valores.creatinina! / 0.9), -0.411)) *
          (math.pow((Valores.creatinina! / 0.9), -1.209)) *
          (math.pow(0.993, Valores.edad!)) *
          (1.018) *
          (1.0)));
    } else {
      return 0.0;
    }
  }

  static String get claseTasaRenal {
    String clasificacion = '';
    double tfgPace = (Valores.tasaRenalCrockoft_Gault +
            Valores.tasaRenalMDRD +
            Valores.tasaRenalCKDEPI) /
        3;
    if (tfgPace <= 15) {
      clasificacion = "Estadio G5 $tfgPace mL/min/1.73 m2)";
    } else if (tfgPace <= 29) {
      clasificacion = "Estadio G4 $tfgPace mL/min/1.73 m2)";
    } else if (tfgPace <= 44) {
      clasificacion = "Estadio G3b  $tfgPace mL/min/1.73 m2)";
    } else if (tfgPace <= 59) {
      clasificacion = "Estadio G3a $tfgPace mL/min/1.73 m2)";
    } else if (tfgPace <= 89) {
      clasificacion = "Estadio G2 $tfgPace mL/min/1.73 m2)";
    } else if (tfgPace <= 140) {
      clasificacion = "Estadio G1 $tfgPace mL/min/1.73 m2)";
    } else {
      clasificacion = "Estadio G1 $tfgPace mL/min/1.73 m2)";
    }

    return clasificacion;
  }

  static double get ureaCreatinina => Valores.urea! / Valores.creatinina!;
  static String get uremia {
    if (Valores.ureaCreatinina >= 20) {
      return 'Azoemia Prerrenal';
    } else if (Valores.ureaCreatinina > 10 && Valores.ureaCreatinina > 15) {
      return 'Azoemia Posrrenal';
    } else if (Valores.ureaCreatinina <= 10) {
      return 'Azoemia Renal';
    } else {
      return 'Normal';
    }
  }

  // # ######################################################
  // # Ajustes de Potasio [K+]
  // # ######################################################
  static double get deltaPotasio {
    if (Valores.pesoCorporalTotal != 0 &&
        Valores.pesoCorporalTotal != null &&
        Valores.potasio != 0 &&
        Valores.potasio != null) {
      return ((4 - Valores.potasio!) * Valores.pesoCorporalTotal!);
    } else {
      return double.nan;
    }
  }

  static double get reposicionPotasio {
    if (Valores.potasio! != 0 && Valores.potasio! != null) {
      return ((4.0 - Valores.potasio!) * 0.4 * Valores.pesoCorporalTotal!) +
          (Valores.requerimientoBasalPotasio);
    } else {
      return double.nan;
    }
  }

  static double get requerimientoBasalPotasio {
    return 1.5 * Valores.pesoCorporalTotal!;
  }

  static double get requerimientoPotasio {
    if (Valores.potasio! <= 3.4 && Valores.potasio! >= 3.1) {
      return 1.0 * Valores.pesoCorporalTotal!;
    } // mEq/Dosis [60 mEq/Dosis cada 4 - 6 Horas]
    else if (Valores.potasio! < 3.0 && Valores.potasio! >= 2.6) {
      return 0.2 * Valores.pesoCorporalTotal!;
    } // mEq/Hr máximo [60 mEq/Hr CVC 40 mEq/Hr Periférico]
    else if (Valores.potasio! <= 2.5 && Valores.potasio! >= 2.1) {
      return 1.0 * Valores.pesoCorporalTotal!;
    } // mEq/Hr [20 mEq/Hr]
    else if (Valores.potasio! <= 2.0) {
      return 1.0 * Valores.pesoCorporalTotal!;
    } // mEq/Kg a 0.25 - 0.50 mEq/Kg/Hr [20 mEq/Hr]
    else {
      return 1.0 * Valores.pesoCorporalTotal!; // 0.0
    }
  }

  static String get kalemia {
    if (Valores.potasio! >= 7.0) {
      return 'Hiperkalemia Severa)';
    } else if (Valores.potasio! <= 6.9 && Valores.potasio! >= 6.5) {
      return 'Hiperkalemia Severa';
    } else if (Valores.potasio! <= 6.4 && Valores.potasio! >= 5.5) {
      return 'Hiperkalemia Severa';
    } else if (Valores.potasio! <= 5.5 && Valores.potasio! >= 3.5) {
      return 'Normokalemia';
    } else if (Valores.potasio! <= 3.4 && Valores.potasio! >= 3.1) {
      return 'Hipokalemia Leve';
    } else if (Valores.potasio! <= 3.0 && Valores.potasio! >= 2.6) {
      return 'Hipokalemia Moderada';
    } else if (Valores.potasio! <= 2.5 && Valores.potasio! >= 2.1) {
      return 'Hipokalemia Severa';
    } else if (Valores.potasio! <= 2.0) {
      return 'Hipokalemia Crítica';
    } else {
      return '';
    }
  }

  static double get pHKalemia {
    if (Valores.pHArteriales != 0 &&
        Valores.pHArteriales != null &&
        Valores.potasio != 0 &&
        Valores.potasio != null) {
      return (Valores.pHArteriales! * ((Valores.potasio! * 0.1) / 0.6));
    } else {
      return double.nan;
    }
  }

  // # ######################################################
  // # Antropométricos
  // # ######################################################

  static double get pesoCorporalPredicho {
    print("Valores.sexo ${Valores.sexo}");
    if (Valores.sexo == "Masculino") {
      return 23.0 * (Valores.alturaPaciente! * Valores.alturaPaciente!);
    } else if (Valores.sexo == "Femenino") {
      return 21.5 * (Valores.alturaPaciente! * Valores.alturaPaciente!);
    } else {
      return 0.00;
    }
  }

  static double get PP {
    if (Valores.sexo == "Masculino") {
      return 50 + (0.91 * ((Valores.alturaPaciente! * 100) - 152.4));
    } else if (Valores.sexo == "Femenino") {
      return 45.5 + (0.91 * ((Valores.alturaPaciente! * 100) - 152.4));
    } else {
      return 0.00;
    }
  }

  static double get PCIP =>
      ((Valores.pesoCorporalTotal! * 100) / (pesoCorporalPredicho));

  static double get PCIB => ((Valores.alturaPaciente! * 100) - 100);

  static double get PCIL {
    if (Valores.sexo == ("Masculino")) {
      return (((Valores.alturaPaciente! * 100) - 100) -
          (((Valores.alturaPaciente! * 100) - 150) / 4));
    } else if (Valores.sexo == ("Femenino")) {
      return (((Valores.alturaPaciente! * 100) - 100) -
          (((Valores.alturaPaciente! * 100) - 150) / 2));
    } else {
      return 0.00;
    }
  }

  static double get PCIW {
    if (Valores.sexo == ("Masculino")) {
      return (22.1 * (math.pow(Valores.alturaPaciente!, 2)));
    } else if (Valores.sexo == ("Femenino")) {
      return (20.6 * (math.pow(Valores.alturaPaciente!, 2)));
    } else {
      return 0.00;
    }
  }

  static double get PCIM => (PCIB + PCIL + PCIW) / 3;
  static double get pesoCorporalAjustado =>
      pesoCorporalPredicho +
      ((Valores.pesoCorporalTotal! - pesoCorporalPredicho) * 0.25);

  static double get excesoPesoCorporal =>
      (Valores.pesoCorporalTotal! / pesoCorporalPredicho);

  static double get PCB_25 =>
      (Valores.alturaPaciente! * Valores.alturaPaciente!) * 25;
  static double get PCB_30 =>
      (Valores.alturaPaciente! * Valores.alturaPaciente!) * 30;

  static double get SC =>
      (math.pow(Valores.pesoCorporalTotal!, 0.425)) *
      (math.pow(Valores.alturaPaciente!, 0.725) *
          (0.007184)); // Dubois y Dubois

  static double get SCE {
    if (Valores.edad! <= 1.0) {
      return (((Valores.pesoCorporalTotal! * 4) + 9) / 100);
    } else if (Valores.edad! >= 1.0) {
      return ((Valores.pesoCorporalTotal! * 4) + 7) /
          (Valores.pesoCorporalTotal! + 90);
    } else {
      return 0.00;
    }
  }

  static double get SCS =>
      (math.sqrt(Valores.pesoCorporalTotal! * (Valores.alturaPaciente! * 100)) /
          3600); // Mosteller

  static double get SCH => (0.024265 *
      ((math.pow(Valores.alturaPaciente!, 0.3964)) *
          (math.pow(Valores.pesoCorporalTotal!, 0.5378))));

  /// Indice Cintura - Cadera ; Mujeres 0.71 - 0.84, Hombres 0.78 - 0.94
  static double get indiceCinturaCadera {
    if (Valores.circunferenciaCintura! == 0 ||
        Valores.circunferenciaCadera! == 0) {
      return 00.00;
    } else {
      return (Valores.circunferenciaCintura! / Valores.circunferenciaCadera!);
    }
  }

  static double get densidadCorporal {
    if (Valores.edad! == '') {
      return 0.0;
    } else if (Valores.edad! == 0) {
      return 0.0;
    } else if (Valores.edad! <= 11) {
      if (Valores.sexo == ("Masculino")) {
        return 1.1690 -
            (0.0788 *
                numerics.log10((Valores.pliegueCutaneoBicipital! +
                    Valores.pliegueCutaneoTricipital! +
                    Valores.pliegueCutaneoEscapular! +
                    Valores.pliegueCutaneoIliaco!)));
      } else if (Valores.sexo == ("Femenino")) {
        return 1.2063 -
            (0.0999 *
                numerics.log10((Valores.pliegueCutaneoBicipital! +
                    Valores.pliegueCutaneoTricipital! +
                    Valores.pliegueCutaneoEscapular! +
                    Valores.pliegueCutaneoIliaco!)));
      } else {
        return 0.0;
      }
    } else if (Valores.edad! > 11) {
      if (Valores.sexo == ("Masculino")) {
        return 1.1369 -
            (0.0598 *
                numerics.log10((Valores.pliegueCutaneoBicipital! +
                    Valores.pliegueCutaneoTricipital! +
                    Valores.pliegueCutaneoEscapular! +
                    Valores.pliegueCutaneoIliaco!)));
      } else if (Valores.sexo == ("Femenino")) {
        return 1.1533 -
            (0.0643 *
                math.log((Valores.pliegueCutaneoBicipital! +
                    Valores.pliegueCutaneoTricipital! +
                    Valores.pliegueCutaneoEscapular! +
                    Valores.pliegueCutaneoIliaco!)));
      } else {
        return 0.0;
      }
    } else {
      return 0.0;
    }
  }

  //static double get GCE => (495 / densidadCorporal) - 450; // De Siri
  // GCE = (CAD / (Antropometria.getEstatura() * Math.sqrt(Antropometria.getEstatura()))) - 18 // De Brook
  static double get grasaCorporalEsencial =>
      ((495 / densidadCorporal) - 450) * -100; // De Siri

  static double get porcentajeGrasaCorporal {
    if (Valores.sexo == "Masculino" && imc != 0) {
      return ((1.2 * imc) +
          (0.23 * Valores.edad!) -
          (10.8 * 1) -
          5.4); // Formula de Deurenberg
    } else if (Valores.sexo == "Femenino" && imc != 0) {
      return ((1.2 * imc) +
          (0.23 * Valores.edad!) -
          (10.8 * 0) -
          5.4); // Formula de Deurenberg
    } else {
      return 0.0;
    }
  }

  static double get masaMuscularMagra =>
      7.138 + (0.02908 * Valores.creatinina!); // Masa Magra Muscular
  static double get porcentajeCorporalMagro =>
      ((Valores.pesoCorporalTotal! * (100 - grasaCorporalEsencial)) / 100);

  static String get claseIMC {
    if (Valores.edad! <= 18 && Valores.edad! <= 59) {
      if (Valores.sexo == 'Femenino') {
        // Talla Baja
        if (Valores.alturaPaciente! <= 1.50) {
          if (imc <= 18.5) {
            return 'Bajo Peso (Quetelet)';
          } else if (imc < 18.5 && imc <= 22.9) {
            return "Normal (Quetelet)";
          } else if (imc < 23.0 && imc <= 25.0) {
            return "Sobre - Peso (Quetelet)";
          } else if (imc > 25) {
            return "Obesidad (Quetelet)";
          } else {
            return "Ninguno";
          }
        }
        // # ################################################
        else if (Valores.alturaPaciente! > 1.50) {
          if (imc == 0.00) {
            return "Clasificaccion de I.M.C. - No Aplica";
          } else if (imc >= 40.00) {
            return "Obesidad Grado III (Quetelet)";
          } else if (imc >= 35.0) {
            return "Obesidad Grado II (Quetelet)";
          } else if (imc >= 30.0) {
            return "Obesidad Grado I (Quetelet)";
          } else if (imc >= 29.99 && imc >= 26.0) {
            return "Sobre - Peso (Quetelet)";
          } else if (imc >= 25.99 && imc >= 18.0) {
            return "Normal (Quetelet)";
          } else if (imc >= 17.99 && imc >= 17.0) {
            return "Bajo Peso (Quetelet)";
          } else if (imc >= 16.99 && imc >= 16.0) {
            return "Desnitricion Moderada (Quetelet)";
          } else if (imc <= 15.99) {
            return "Desnutricion Severa (Quetelet)";
          } else {
            return "Ninguno";
          }
        } else {
          return "Ninguno";
        }
      } else if (Valores.sexo == 'Masculino') {
        // # Talla Baja
        if (Valores.alturaPaciente! <= 1.60) {
          if (imc <= 18.5) {
            return 'Bajo Peso (Quetelet)';
          } else if (imc > 18.5 && imc <= 22.9) {
            return "Normal (Quetelet)";
          } else if (imc > 23.0 && imc <= 25.0) {
            return "Sobre - Peso (Quetelet)";
          } else if (imc > 25) {
            return "Obesidad (Quetelet)";
          } else {
            return "Ninguno";
          }
        } else if (Valores.alturaPaciente! > 1.60) {
          if (imc == 0.00) {
            return "Clasificaccion de I.M.C. - No Aplica";
          } else if (imc >= 40.00) {
            return "Obesidad Grado III (Quetelet)";
          } else if (imc >= 35.0) {
            return "Obesidad Grado II (Quetelet)";
          } else if (imc >= 30.0) {
            return "Obesidad Grado I (Quetelet)";
          } else if (imc < 29.99 && imc >= 26.0) {
            return "Sobre - Peso (Quetelet)";
          } else if (imc < 25.99 && imc >= 18.0) {
            return "Normal (Quetelet)";
          } else if (imc < 17.99 && imc >= 17.0) {
            return "Bajo Peso (Quetelet)";
          } else if (imc < 16.99 && imc >= 16.0) {
            return "Desnitricion Moderada (Quetelet)";
          } else if (imc <= 15.99) {
            return "Desnutricion Severa (Quetelet)";
          } else {
            return "Ninguno";
          }
        } else {
          return "Ninguno";
        }
      } else {
        return "Ninguno";
      }
    } else if (Valores.edad! >= 60) {
      if (imc <= 18.5) {
        return 'Bajo Peso (Quetelet)';
      } else if (imc > 18.5 && imc <= 22.9) {
        return "Normal (Quetelet)";
      } else if (imc > 23.0 && imc <= 25.0) {
        return "Sobre - Peso (Quetelet)";
      } else if (imc > 25) {
        return "Obesidad (Quetelet)";
      } else {
        return "Ninguno";
      }
    } else {
      return "Ninguno";
    }
  }

  static double get perimetroMesobraquial =>
      (Valores.circunferenciaMesobraquial! -
          (3.1416 * (Valores.pliegueCutaneoTricipital! / 100)));
  static double get areaMesobraquial => (math.pow(
          Valores.circunferenciaMesobraquial! -
              (3.1416 * (Valores.pliegueCutaneoTricipital! / 100)),
          2) /
      (4 * 3.1416));
  static double get areaAdiposaMesobraquial =>
      (((perimetroMesobraquial * (Valores.pliegueCutaneoTricipital! / 100)) /
              2) -
          ((3.1416 * (Valores.pliegueCutaneoTricipital! / 100)) / 4));
  static double get AM =>
      ((3.1416) * math.pow(((perimetroMesobraquial) / (2 * 3.1416)), 2));

  static double get gastoEnergeticoBasal {
    if (Valores.sexo == "Masculino") {
      return 655 +
          (9.6 * Valores.pesoCorporalTotal!) +
          (1.8 * Valores.alturaPaciente! * 100) -
          (4.7 * Valores.edad!);
    } else if (Valores.sexo == "Femenino") {
      return 66 +
          (13.7 * Valores.pesoCorporalTotal!) +
          (5.0 * (Valores.alturaPaciente! * 100)) -
          (6.8 * Valores.edad!);
    } else {
      return 0.0;
    }
  }

  static double get metabolismoBasal => 37 - ((Valores.edad! - 20) / 10);
  static double get efectoTermicoAlimentos => metabolismoBasal * 0.1;
  static double get gastoEnergeticoTotal {
    if (Valores.factorActividad! == 0 && Valores.factorEstres! == 0) {
      return gastoEnergeticoBasal +
          (gastoEnergeticoBasal *
              (Valores.factorActividad! + efectoTermicoAlimentos));
    } else if (Valores.factorActividad! != 0 && Valores.factorEstres! != 0) {
      return gastoEnergeticoBasal +
          (gastoEnergeticoBasal *
              (Valores.factorActividad!) *
              (Valores.factorEstres!));
    } else {
      return 0.0;
    }
  }

  static double get fibraDietaria =>
      (gastoEnergeticoTotal * 0.02); // / 1000) * 10; // 0.02

  static double get glucosaPorcentaje =>
      ((gastoEnergeticoTotal / 100) * (porcentajeCarbohidratos));
  static double get lipidosPorcentaje =>
      ((gastoEnergeticoTotal / 100) * (porcentajeLipidos));
  static double get proteinasPorcentaje =>
      ((gastoEnergeticoTotal / 100) * (porcentajeProteinas));

  static double get aguaTotal =>
      (gastoEnergeticoTotal * 1.0) / 1000; // 0.5 - 2.25

  static double get glucosaGramos => (glucosaPorcentaje / 4.0);
  static double get lipidosGramos => (lipidosPorcentaje / 9.0);
  static double get proteinasGramos => (proteinasPorcentaje / 4.0);

  static double get proteinasAVM => (pesoCorporalPredicho / 1.5);
  static double get sodioDietario => (pesoCorporalPredicho / 2.0);
  static double get potasioDietario => (pesoCorporalPredicho / 3.0);
  static double get cloroDietario => (pesoCorporalPredicho / 5.0);
  static double get magnesioDietario => (pesoCorporalPredicho / 3.5);
  static double get calcioDietario => (pesoCorporalPredicho / 14.0);

  static double get selenioDietario => (pesoCorporalPredicho / 0.7);
  static double get hierroDietario => (pesoCorporalPredicho / 0.14);
  static double get fosforoDietario => (pesoCorporalPredicho / 11.42);
  static double get cromoDietario => (pesoCorporalPredicho / 0.71);

  static int get sumaPorcentualMetabolicos =>
      porcentajeCarbohidratos + porcentajeProteinas + porcentajeLipidos;

  static double get edadMetabolica {
    if (Valores.sexo == 'Masculino') {
      return 66 +
          (6.23 * Valores.pesoCorporalTotal!) +
          (12.7 * Valores.alturaPaciente!) -
          (6.8 * Valores.edad!);
    } else if (Valores.sexo == 'Femenino') {
      return 66 +
          (4.35 * Valores.pesoCorporalTotal!) +
          (4.7 * Valores.alturaPaciente!) -
          (4.7 * Valores.edad!);
    } else {
      return 0.0;
    }
  }

  // static double get SC => (math.pow(Valores.pesoCorporalTotal!, 0.425)) * (math.pow(Valores.alturaPaciente!, 0.725) * 0.007184);

  static double get presionArterialMedia =>
      (Valores.tensionArterialSystolica! +
          (2 * Valores.tensionArterialDyastolica!)) /
      3; //# Tensión Arterial Media
  static String get clasificacionTAM {
    if ((presionArterialMedia > 110)) {
      return "Hipertension Arterial";
    } else if ((presionArterialMedia < 65)) {
      return "Hipotension Arterial";
    } else {
      return "Normo - Tensión Arterial";
    }
  }

  static int get diferenciaTensionArterial =>
      (Valores.tensionArterialSystolica!) -
      (Valores.tensionArterialDyastolica!); //# Diferencia Tensión Arterial
  static int get productoFrecuenciaPresion => (Valores.frecuenciaCardiaca! *
      Valores.tensionArterialSystolica!); //# Producto Frecuencia Presión
  static int get presionPulso => (Valores.tensionArterialSystolica! -
      Valores.tensionArterialDyastolica!); //  # Presión Pulso

  static int get frecuenciaCardiacaMaxima {
    if (Valores.sexo == ("Masculino")) {
      return (220 - Valores.edad!);
    } // # Frecuencia_Cardiaca_Maxima
    else if (Valores.sexo == ("Femenino")) {
      return (226 - Valores.edad!);
    } else {
      return 0;
    } //# Frecuencia_Cardiaca_Maxima
  }

  static double get frecuenciaCardiacaBlanco =>
      ((220 - Valores.edad!) * 0.7); // # Frecuencia_Cardiaca_Blanco
  static double get frecuenciaCardiacaIntrinseca =>
      (118.1 - (0.57 * Valores.edad!)); // # Frecuencia Cardiaca Intrinseca

  static double get volemiaAproximada =>
      ((80) * Valores.pesoCorporalTotal!) / 1000; // # Volemia Aproximada

  // # Volumen Plasmático
  static double get volumenPlasmatico {
    if (Valores.sexo! == ("Masculino")) {
      return (((0.3669) * (Valores.alturaPaciente!) * 3) +
          ((0.03219) * (Valores.pesoCorporalTotal!)) +
          0.6041); //# Volumen Plasmático : Fórmula de Nadler.
    } else if (Valores.sexo! == ("Femenino")) {
      return (((0.3561) * (Valores.alturaPaciente!) * 3) +
          ((0.03308) * (Valores.pesoCorporalTotal!) +
              0.1833)); //# Volumen Plasmático : Fórmula de Nadler.
    } else {
      return 2800;
    }
  }

  static double get perdidasInsensibles =>
      ((Valores.pesoCorporalTotal!) * constantePerdidasInsensibles) *
      Valores.horario!;

  static int get ingresosBalances {
    return Valores.viaOralBalances! +
        Valores.sondaOrogastricaBalances! +
        Valores.hemoderivadosBalances! +
        Valores.nutricionParenteralBalances! +
        Valores.parenteralesBalances! +
        Valores.dilucionesBalances! +
        Valores.otrosIngresosBalances!;
  }

  static int get egresosBalances {
    return Valores.uresisBalances! +
        Valores.evacuacionesBalances! +
        Valores.sangradosBalances! +
        Valores.succcionBalances! +
        Valores.drenesBalances! +
        Valores.otrosEgresosBalances!;
  }

  static double get constantePerdidasInsensibles {
    return 0.5;
  }

  // Analisis de los Parámetros Hepáticos *******************
  static double get relacionASTALT {
    if (Valores.alaninoaminotrasferasa! != 0 &&
        Valores.aspartatoaminotransferasa! != 0) {
      return (Valores.alaninoaminotrasferasa! /
          Valores.aspartatoaminotransferasa!);
    } else {
      return double.nan;
    }
  }

  static double get factorR {
    if (Valores.aspartatoaminotransferasa! != 0 &&
        Valores.fosfatasaAlcalina! != 0) {
      return (Valores.aspartatoaminotransferasa! / 40) /
          (Valores.fosfatasaAlcalina! / 104);
    } else {
      return double.nan;
    }
  }

  static double get relacionALTFA {
    if (Valores.alaninoaminotrasferasa! != 0 &&
        Valores.fosfatasaAlcalina! != 0) {
      return (Valores.alaninoaminotrasferasa! / Valores.fosfatasaAlcalina!);
    } else {
      return double.nan;
    }
  }

  // # Parametros Hemodinamicos
  // # Concentración Arterial de Oxígeno
  static double get CAO =>
      (((Valores.hemoglobina! * 1.34) * Valores.soArteriales!) +
          (Valores.poArteriales! * 0.031)) /
      (100); //  # Concentración Arterial de Oxígeno
  static double get CVO =>
      (((Valores.hemoglobina! * 1.34) * Valores.soVenosos!) +
          (Valores.poVenosos! * 0.031)) /
      (100); // # Concentración Venosa de Oxígeno
  static double get CCO => ((Valores.hemoglobina! * 1.39) + (Valores.poArteriales! * 0.0031)); // # Concentración Capilar de Oxígeno
      // (((Valores.hemoglobina! * 1.34) *
      //         (Valores.soVenosos! - Valores.soArteriales!) +
      //     ((Valores.poVenosos! - Valores.poArteriales!) * 0.031)) /
      // (100));
  static double get DAV => (CAO - CVO); // # Diferencia Arteriovenosa
  static double get capacidadOxigeno =>
      (Valores.hemoglobina! * (1.36)); //  # Capacidad de Oxígeno
  // # Gasto Cardiaco
  static double get gastoCardiaco {
    if (DAV != 0) {
      return (((DAV * 100) / CAO) / (DAV)); // # Gasto Cardiaco
    } else {
      return double.nan;
    }
  }
  static double get gastoCardiacoFick {
    if (DAV != 0) {
      return ((125 * SCE) / (8.5 * DAV));// # Gasto Cardiaco
      // return (((DAV * 100) / CAO) / (DAV)); // # Gasto Cardiaco
    } else {
      return double.nan;
    }
  }

  // # ############## ######### #######
  // # ############## ######### #######
  // # Parámetros Gasométricos
  // # ############## ######### #######
  static String get trastornoPrimario {
    if (Valores.pHArteriales! < 7.34) {
      return 'Acidemia';
    } else if (Valores.pHArteriales! > 7.45) {
      return 'Alcalemia';
    } else {
      return 'Normal';
    }
  }

  // # ############## ######### #######
  // Comparación entre el PCO2 y el HCO3-
  // # ############## ######### #######
  static String get trastornoSecundario {
    if (Valores.pcoArteriales! < 35 || Valores.pcoArteriales! > 45) {
      return 'Alteración Respiratoria';
    } else if (Valores.bicarbonatoArteriales! > 18 ||
        Valores.bicarbonatoArteriales! > 28) {
      return 'Alteración Metabólica';
    } else {
      return 'Normal';
    }
  }

  //
  // # ############## ######### #######
  static String get alteracionRespiratoria {
    if (Valores.pcoArteriales! < 35) {
      return 'Hipocapnia';
    } else if (Valores.pcoArteriales! > 45) {
      return 'Hipercapnia';
    } else {
      return 'Normal';
    }
  }

  static String get trastornoTerciario {
    if (Valores.poArteriales! < 80) {
      return 'Hipoxemia';
    } else if (Valores.poArteriales! > 45) {
      return 'Hiperoxemia';
    } else {
      return 'Normal';
    }
  }

  static String get trastornoBases {
    if (Valores.EB < -3) {
      return 'Consumo de Bases'; // Acidosis
    } else if (Valores.poArteriales! > 3) {
      return 'Retención de Bases'; // Alcalosis
    } else {
      return 'Normal';
    }
    // excesoBaseArteriales
  }

  static String get trastornoGap {
    if (Valores.GAP < 8) {
      return 'Pérdida de Bicarbonato';
    } else if (Valores.GAP > 12) {
      return 'Acidosis por Anion GAP Elevado';
    } else {
      return 'Normal';
    }
  }

  //
  static double get GAP =>
      (Valores.sodio! + Valores.potasio!) -
      (Valores.cloro! + Valores.bicarbonatoArteriales!);
  static double get PAFI =>
      (Valores.poArteriales! / (Valores.fioArteriales! / 100));
  static double get PAFI_PB => (PAFI * (presionBarometrica / 760));
  static double get PAFI_PO2 => (Valores.poArteriales! * (PAFI / 100));
  static double get PAFI_FIO =>
      (Valores.poArteriales! / Valores.fioArteriales!) * 100;
  static double get SAFI =>
      (Valores.soArteriales! / (Valores.fioArteriales! / 100));

  static double get PCO2C {
    if (Valores.temperaturCorporal == 37) {
      return (Valores.pcoArteriales! *
          math.pow(10, math.pow(0.019, 2))); // # 37 - 35 °C
    } else if (Valores.temperaturCorporal! < 37) {
      return (Valores.pcoArteriales! *
          math.pow(10, math.pow(0.019, 37.00 - Valores.temperaturCorporal!)));
    } else if (Valores.temperaturCorporal! > 37) {
      return (Valores.pcoArteriales! *
          math.pow(10, math.pow(0.019, Valores.temperaturCorporal! - 37)));
    } else {
      return double.nan;
    }
  }

  static double get EB => ((1 - 0.014 * Valores.hemoglobina!) *
      (Valores.bicarbonatoArteriales! -
          24.8 +
          (1.43 * Valores.hemoglobina! + 7.7) * (Valores.pHArteriales! - 7.4)));
  static double get EBecf =>
      (24) -
      ((Valores.bicarbonatoArteriales! + 10.00) *
          (Valores.pHArteriales! - 7.4)); //  # Bicarbonato Standard
  static double get d_GAP => (GAP - 14) / (20 - Valores.bicarbonatoArteriales!);
  // Trastorno_DGAP = '';
  static String get trastorno_d_GAP {
    if (d_GAP < 1) {
      return 'Acidemia Metabólica Hipercloremica';
    } else if (d_GAP < 1) {
      return 'Alcalosis Metabólica';
    } else {
      return '';
    }
  }

  static double get D_d_GAP => d_GAP - Valores.bicarbonatoArteriales!;
  static double get GAPO => ((280) / (Valores.osmolaridadSerica));

  static double get DIF =>
      (Valores.sodio! +
          Valores.potasio! +
          Valores.magnesio! +
          Valores.calcio!) -
      (Valores.cloro! + Valores.lactato!);
  // # GAPIonesLibres GIF = SID - (2.46 * 108 * Gasometria.Valores.pcoArteriales! / 10)
  static double get EBvGilFix => (Valores.sodio!) - (Valores.cloro!) - 38;
  static double get EBb => (0.25 *
      (42.00 - Valores.albuminaSerica!)); //  # Efecto de Buffers Principales
  static double get DA => (Valores.EB - EBb); // # Diferencia Anionica
  static double get VDb => (Valores.EB - DA); // # Verdadero Déficit de Base

  static double get TCO {
    return ((Valores.bicarbonatoArteriales!) +
        (0.03 * Valores.pcoArteriales!)); //# Dioxido de Carbono Total
  }

  static double get PAO {
    return PIO -
        (Valores.pcoArteriales! * 1.25); // # Presión alveolar de oxígeno
    // return (Valores.fioArteriales! / 100) * (760 - 47) -
    //     (Valores.pcoArteriales! / 0.8); // # Presión alveolar de oxígeno
  }

  static double get GAA => ((760.00 - 47.00) * (Valores.fioArteriales! / 100) -
      (Valores.pcoArteriales! / 0.8) -
      Valores.poArteriales!); //  # Gradiente Alveolo Arterial

  // static double get GAA => (PAO - Valores.poArteriales!); //  # Gradiente Alveolo - Arterial

  static String get DiagnosticosPorGradiente {
    if (GAA < 10) {
      return "Hipoventilacion sin Enfermedad Pulmonar Intrinseca \n "
          "(Considerar: Fiebre, Embarazo).";
    } else if (GAA >= 10) {
      return "Hipoventilación con Enfermedad Pulmonar Intrínseca \n"
          "(Considerar: Alteracion Ventilacion/Perfusion \n"
          "(Tromboembolia Pulmonar, Neumonia)).";
    } else {
      return '';
    }
  }

  static double get DAA =>
      PAO - (Valores.poArteriales!); //  # Diferencia Alveolar
  static double get PaO2PAO2 =>
      (Valores.poArteriales! / PAO); //  # Relación PaO2 / PAO2

  // # ######################################################
  // # Reglas del Bicarbonato
  // # ######################################################
  // # Trastorno de Origen Respiratorio.
  static double get HCOR_a =>
      (7.40) + (((40 - Valores.pcoArteriales!) * 0.08) / 10);
  // # Primera Regla del Bicarbonato: Por cada 10 mmHg que varía la pCO2 mmHg, el pH se incrementa o reduce 0.08 unidades en forma inversamente proporcional
  // # Se suma el HCOR_a al pH Ideal, que es 7.40 si resulta en una discrepancia entonces el Origen del Trastorno no es respiratorio. No cumple la primera regla.
  // # Trastorno de Origen Metabólico (pH Real)
  static double get HCOR_b => (Valores.pHArteriales! + ((EB * 0.15) / 10));
  // # Segunda Regla del Bicarbonato: Por cada 0.15 unidades que se modifican el pH, se incrementa o disminuye el exceso o déficit de base en 10 unidades, que pueden expresarse en mEq/L de bicarbonato
  // # Se suma el HCOR_a al pH Ideal, que es 7.40 si resulta en una discrepancia entonces el Origen del Trastorno no es respiratorio. No cumple la primera regla.
  // # Reposición de Bicarbonato
  static double get HCOR_c {
    if (Valores.EB < 0) {
      return (EB * (Valores.pesoCorporalTotal! * 0.3)) * (-1);
    } else {
      return (EB * (Valores.pesoCorporalTotal! * 0.3)) * (1);
    }
  }
  // # Tercera Regla del Bicarbonato: Corrección de HCO3- en Acidosis Metabólica

  // # ######################################################
  // # Reposición de Bicarbonato de Sodio
  // # ######################################################
  //  # Déficit de Bicarbonato
  static double get DHCO {
    if (Valores.pHArteriales! < 7.34) {
      return (28 - Valores.bicarbonatoArteriales!) *
          (0.2 * Valores.pesoCorporalTotal!);
    } else if (Valores.pHArteriales! < 7.20) {
      return (28 - Valores.bicarbonatoArteriales!) *
          (0.3 * Valores.pesoCorporalTotal!);
    } else if (Valores.pHArteriales! < 7.0) {
      return (28 - Valores.bicarbonatoArteriales!) *
          (0.4 * Valores.pesoCorporalTotal!);
    } else if (Valores.pHArteriales! < 6.5) {
      return (28 - Valores.bicarbonatoArteriales!) *
          (0.5 * Valores.pesoCorporalTotal!);
    } else if (Valores.pHArteriales! < 6.0) {
      return (28 - Valores.bicarbonatoArteriales!) *
          (0.8 * Valores.pesoCorporalTotal!);
    } else {
      return double.nan;
    }
  }

  // # Déficit de Bicarbonato mediante Astrup - Mellemgard
  static double get HCOAM {
    if (Valores.EB < 0) {
      return Valores.EB * (Valores.pesoCorporalTotal! * 0.3) * (-1);
    } else {
      return Valores.EB * (Valores.pesoCorporalTotal! * 0.3) * (1);
    }
  }

  // # Velocidad de Infusión para la Reposición de Bicarbonato de Sodio
  static double get VHCOAM {
    if (Valores.pHArteriales! <= 7.0) {
      return HCOAM;
    } //  # Administar 1/1 de la solución hasta conseguir pH 7.20 - 7.30}
    else {
      return HCOAM / 2;
    }
  } //# Administar 1/2 de la solución hasta conseguir pH 7.20 - 7.30

  // # Número de Frascos / Ampulas de Bicarbonato de Sodio al  7.5%
  static double get NOAMP {
    if (DHCO != 0) {
      return DHCO / 20;
    } else {
      return 0;
    }
  }

  // # Cociente Respiratorio
  static double get RI => 0.8;
  // # ######################################################
  // # Concentración de Hidrigeniones H+
  // # ######################################################
  static double get H =>
      24 * (Valores.pcoArteriales! / Valores.bicarbonatoArteriales!);
  static double get PH =>
      6.1 +
      numerics.log10(
          (Valores.bicarbonatoArteriales! / (0.03 * Valores.pcoArteriales!)));
  static double get PaO2_estimado => 103.5 - 0.42 * Valores.edad!;
  static double get PaO2_estimado_sedestacion => 104.2 - 0.27 * Valores.edad!;
  static double get PaO2_estimado_decubito => 109.0 - 0.43 * Valores.edad!;
  // static double get PAO => (Valores.fioArteriales! / 100) * (720 - 47) - (Valores.pcoArteriales! / 0.8)

  // # Indice de Volumen Sanguineo
  static double get indiceVolumenSanguineo =>
      VP /
      (1 - Valores.hematocrito!) *
      ((1.1 * Valores.pesoCorporalTotal!) -
          (128 *
              (math.pow(Valores.pesoCorporalTotal!, 2) /
                  math.pow(Valores.alturaPaciente!, 2))));
  static double get indiceCardiaco =>
      (Valores.gastoCardiaco / Valores.SC); // # Indice Cardiaco
  static double get IRVS =>
      (Valores.presionArterialMedia / Valores.indiceCardiaco);
  static double get RVS => (((Valores.presionArterialMedia - 12.0) * 80.00) /
      Valores.indiceCardiaco); //  # Resistencias Venosas Sistémicas
  // # (((Valores.presionArterialMedia! - 12.0) / IC) * 79.9)
  static double get IEO =>
      (((DAV / CAO) * 100)); // # Indice de Extracción de Oxígeno
  static double get IV =>
      (Valores.presionMediaViaAerea * Valores.frecuenciaVentilatoria!) *
      (Valores.pcoArteriales! / 10);

  static double get EV {
    if (Valores.pcoArteriales != 0) {
      return (Valores.volumenMinutoIdeal * Valores.pcoArteriales!) /
          ((Valores.volumenMinutoIdeal * 37.5));
    } else if (Valores.pcoArteriales! == 0) {
      return (Valores.volumenMinutoIdeal) /
          ((3.2 * Valores.pesoCorporalTotal!)) *
          (100);
    } else {
      return 0;
    }
  }

  static int get PPI =>
      Valores.presionFinalEsiracion! + Valores.presionSoporte!;
  static int get PPE => Valores.presionFinalEsiracion!;
  static double get CI => (Valores.pcoArteriales!  / DAV);
      // (Valores.pcoArteriales! * Valores.frecuenciaVentilatoria!) / 40.00;

  // # ######################################################
  // # Análisis de pCO2 / pO2
  // # ######################################################
  static double get indiceTobinYang =>
      (Valores.frecuenciaVentilatoria! / Valores.volumenTidal!) * 100;

  static double get indiceOxigenacion {
    if (Valores.poArteriales! != 0) {
      return (Valores.presionMediaViaAerea * (Valores.fioArteriales! / 100)) *
          (100.00) /
          Valores.poArteriales!;
    } else if (Valores.soArteriales != 0) {
      return ((Valores.presionMediaViaAerea * (Valores.fioArteriales! / 100)) *
          (100.00) /
          Valores.poArteriales!);
    } //  Indice de Saturación
    else {
      return double.nan;
    }
  }

  static double get FIOV => ((GAA + 100) / 760) * 100;

  static double get FIOI {
    if (FIOV < 21) {
      return (21.00);
    } else {
      return FIOV;
    }
  }

  static double get VENT =>
      (Valores.pcoArteriales! * Valores.frecuenciaVentilatoria!) / 40.00;

  static double get VA {
    if (Valores.pcoArteriales! != 0) {
      return (0.863 * (3.2 * Valores.pesoCorporalTotal!)) /
          (Valores.pcoArteriales!);
    } else {
      return 00.00;
    }
  }

  static double get PIO =>
      (presionGasSeco / Valores.fioArteriales!);
  static double get VLS =>
      ((gastoCardiacoFick * 1000 ) / Valores.frecuenciaCardiaca!); //  # Volumen Latido Sistólico De Litros a mL
  static double get IVL => (VLS / SCE); //mL/Lat/m2 *IC se multiplica por 1000 para ajustar unidades a mL/min/m2
      // ((indiceCardiaco * 1000) / Valores.frecuenciaCardiaca!);
  static double get DO =>
      ((gastoCardiaco * CAO) * (10)); // # Disponibilidad de Oxígeno
  static double get iDO =>
      (DO / SCS); // # Indice de Disponibilidad de Oxígeno
  static double get TO =>
      ((capacidadOxigeno * CAO) / (10)); // # Transporte de Oxígeno // CAP_O
  static double get SF =>
      ((CCO - CAO) / (CCO - CVO)) * (100); //  # Shunt Fisiológico
  static double get CO =>
      ((gastoCardiaco * DAV) * (10)); // # Consumo de Oxígeno
  static double get cAO =>
      (CAO / DAV); // # Cociente Arterial de Oxígeno
  static double get cVO =>
      (CVO / DAV); // # Cociente Venoso de Oxígeno

  static double get presionColoidoOsmotica => // PC
      ((Valores.proteinasTotales! - Valores.albuminaSerica!) * 1.4) +
      (Valores.albuminaSerica! * 5.5); //  # Presión Coloidóncotica
  static double get TC => (gastoCardiaco *
      Valores.presionArterialMedia *
      0.0144); // # Trabajo Cardiaco

  static double get FE => 0.0;

  // Paramétros con Catéter Swan-Ganz
  static double get resistenciaVascularPulmonar => // PC
  ((Valores.proteinasTotales! - Valores.albuminaSerica!) * 1.4) +
      (Valores.albuminaSerica! * 5.5); //  # Rest. Vasc. Pulmonar 45 - 255 dinas
  static double get TLVI =>
      VLS *
          Valores.presionArterialMedia *
          0.0144; //  # Trabajo Latido Ventricular Izquierdo : : 75 - 115 g/Lat/m2
  static double get iTLVI =>
      TLVI / SCS; //  # Indice Trabajo Latido Ventricular Izquierdo
  static double get TLVD => 00.00; //  # Trabajo Latido Ventricular Derecho
  // # FE = VL / VDF # FE(%)= ((VDF-VSF)*100)/VDF. (porque VL= VDF-VSF). (%)
  static double get presionPerfusionCoronaria => // PC
  (tensionArterialDyastolica! - presionCunaPulmonar!); //  # Presión Perfusión de la Arteria Coronaria

  // Parámetros de Electrocardiogramas
  static double get frecuenciaCardiacaElectrocardiograma {
    if (Valores.intervaloRR! != 0) {
      return (1500 / Valores.intervaloRR!);
    } else {
      return 0.0;
    }
  }

  static double get indiceSokolowLyon {
    if (Valores.sV1 != 0 &&
        Valores.sV1 != null &&
        Valores.rV6 != 0 &&
        Valores.rV6 != null) {
      return (Valores.sV1! + Valores.rV6!).toDouble();
    } else {
      return double.nan;
    }
  }

  static double get indiceGubnerUnderleiger {
    if (Valores.rDI != 0 &&
        Valores.rDI != null &&
        Valores.sDIII != 0 &&
        Valores.sDIII != null) {
      return (Valores.rDI! + Valores.sDIII!);
    } else {
      return double.nan;
    }
  }

  static double get indiceLewis {
    if (Valores.rDI != 0 &&
        Valores.rDI != null &&
        Valores.sDIII != 0 &&
        Valores.sDIII != null &&
        Valores.sDI != 0 &&
        Valores.sDI != null &&
        Valores.rDIII != 0 &&
        Valores.rDIII != null) {
      return (Valores.rDI! + Valores.sDIII!) - (Valores.rDIII! + Valores.sDI!);
    } else {
      return double.nan;
    }
  }

  static double get voltajeCornell {
    if (Valores.rAvL != 0 &&
        Valores.rAvL != null &&
        Valores.sV3 != 0 &&
        Valores.sV3 != null) {
      return (Valores.rAvL! + Valores.sV3!).toDouble();
    } else {
      return double.nan;
    }
  }

  static double get indiceEnriqueCabrera {
    if (Valores.sV1 != 0 &&
        Valores.sV1 != null &&
        Valores.rV1 != 0 &&
        Valores.rV1 != null) {
      return (Valores.rV1! / (Valores.rV1! + Valores.sV1!));
    } else {
      return double.nan;
    }
  }

  // Parámetros de Ventilatorios
  static int get constanteTidal {
    if (Valores.volumenTidal != 0 &&
        Valores.volumenTidal != null &&
        Valores.pesoCorporalPredicho != 0) {
      return Valores.volumenTidal! ~/ Valores.pesoCorporalPredicho;
    } else {
      return 0;
    }
  }

  //
  static int get balanceTotal {
    if (Valores.ingresosBalances != 0 && Valores.egresosBalances != 0) {
      return (Valores.ingresosBalances - Valores.egresosBalances);
    } else {
      return 0;
    }
  }

  static double get diuresis {
    if (Valores.uresisBalances != 0 &&
        Valores.pesoCorporalTotal != null &&
        Valores.horario != 0) {
      return (Valores.uresisBalances! / Valores.pesoCorporalTotal!) /
          Valores.horario!;
    } else {
      return double.nan;
    }
  }

  // # ######################################################
  // # Volumenes Tidales Vt6, Vt7, Vt8
  // # ######################################################
  static double get volumentTidal6 => (Valores.pesoCorporalPredicho * 6);
  static double get volumentTidal7 => (Valores.pesoCorporalPredicho * 7);
  static double get volumentTidal8 => (Valores.pesoCorporalPredicho * 8);
  // # ######################################################
  static double get presionAlveolarOxigeno {
    if (Valores.volumenTidal != 0 &&
        Valores.volumenTidal != null &&
        Valores.pesoCorporalPredicho != 0) {
      // return (valores.get('FraccionInspiratoriaOxigeno') / 100) * (720 - 47) - (Valores.pcoArteriales! / 0.8);
      return 0;
    } else {
      return double.nan;
    }
  }

  static double get presionMediaViaAerea {
    if (Valores.presionPlateau != 0 &&
        Valores.presionPlateau != null &&
        Valores.sensibilidadInspiratoria != 0 &&
        Valores.sensibilidadInspiratoria != null) {
      return (Valores.presionFinalEsiracion! +
              ((Valores.presionPlateau! - Valores.presionFinalEsiracion!) *
                  (Valores.sensibilidadInspiratoria!)))
          .toDouble();
    } else {
      return double.nan;
    }
  }

  static double get volumenMinuto {
    if (Valores.volumenTidal != 0 &&
        Valores.volumenTidal != null &&
        Valores.pesoCorporalPredicho != 0) {
      return (Valores.volumenTidal! * Valores.frecuenciaVentilatoria!) / 1000;
    } else {
      return double.nan;
    }
  }

  static double get flujoVentilatorioMedido {
    if (Valores.volumenMinuto != 0) {
      return (Valores.volumenMinuto * 4);
    } else {
      return double.nan;
    }
  }

  static double get volumenMinutoIdeal {
    if (Valores.pesoCorporalPredicho != 0) {
      return (Valores.pesoCorporalPredicho / 10);
      // VMI = (PCI / 10)
    } else {
      return double.nan;
    }
  }

  static double get poderMecanico {
    if (Valores.pesoCorporalPredicho != 0) {
      return (0.098 *
          Valores.frecuenciaVentilatoria! *
          (Valores.presionPlateau! - Valores.presionFinalEsiracion! / 2));
      // PM = (0.098 * Valores.frecuenciaVentilatoria * (
      // Valores.presionPlateau! - Valores.presionFinalEsiracion! / 2))
    } else {
      return double.nan;
    }
  }

  static double get distensibilidadPulmonarEstatica {
    if (Valores.presionPlateau != 0 &&
        Valores.presionPlateau != null &&
        Valores.presionFinalEsiracion != 0 &&
        Valores.presionFinalEsiracion != null) {
      return (Valores.volumenTidal! /
          (Valores.presionPlateau! - Valores.presionFinalEsiracion!));
      //  DPE = (Valores.volumenTidal! / (
      //   Valores.presionPlateau! - Valores.presionFinalEsiracion!));
    } else {
      return double.nan;
    }
  }

  static double get distensibilidadPulmonarDinamica {
    if (Valores.presionPlateau != 0 &&
        Valores.presionPlateau != null &&
        Valores.presionFinalEsiracion != 0 &&
        Valores.presionFinalEsiracion != null) {
      return (Valores.volumenTidal! /
          (Valores.presionMaxima! -
              Valores.presionFinalEsiracion!)); //# Presion_Inspiratorio_Pico
      // DP = DPE + DPD / 2  // # Promedio entre las Distensibilidades Pulmonares estaticas y dinamicas
    } else {
      return double.nan;
    }
  }

  static double get distensibilidadPulmonar {
    if (Valores.distensibilidadPulmonarEstatica != 0 &&
        Valores.distensibilidadPulmonarDinamica != 0) {
      return distensibilidadPulmonarEstatica +
          distensibilidadPulmonarDinamica /
              2; // # Promedio entre las Distensibilidades Pulmonares estaticas y dinamicas
    } else {
      return double.nan;
    }
  }

  static double get resistenciaPulmonar {
    if (Valores.presionMaxima != 0 &&
        Valores.presionMaxima != null &&
        Valores.presionPlateau != 0 &&
        Valores.presionPlateau != null) {
      return (Valores.presionMaxima! - Valores.presionPlateau!) /
          (Valores.flujoVentilatorio! / 60);
      // RP = (Valores.presionMaxima- Valores.presionPlateau!) / (F / 60)
    } else {
      return double.nan;
    }
  }

  static double get elastanciaPulmonar {
    if (Valores.presionMaxima != 0 &&
        Valores.presionMaxima != null &&
        Valores.presionFinalEsiracion != 0 &&
        Valores.presionFinalEsiracion != null) {
      return ((Valores.presionMaxima! - Valores.presionFinalEsiracion!) /
              (Valores.volumenTidal!)) *
          1000;
      // EP = ((Valores.presionMaxima- Valores.presionFinalEsiracion) / (Valores.volumenTidal!)) * 1000
    } else {
      return double.nan;
    }
  }

  static double get presionDistencion {
    if (Valores.presionMaxima != 0 &&
        Valores.presionMaxima != null &&
        Valores.presionFinalEsiracion != 0 &&
        Valores.presionFinalEsiracion != null) {
      return (Valores.presionMaxima!.toDouble() -
          Valores.presionFinalEsiracion!.toDouble());
    } else {
      return double.nan;
    }
  }

  // if valores.get('PresionOxigenoArterial') != 0:
  // IO = (PMVA * (valores.get('FraccionInspiratoriaOxigeno') / 100)) * (100.00) / valores.get(
  // 'PresionOxigenoArterial')
  // else if valores.get('SaturacionOxigeno') != 0:  # //  Indice de Saturación
  // IO = ((PMVA * (valores.get('FraccionInspiratoriaOxigeno') / 100)) * (100.00) / valores.get(
  // 'PresionOxigenoArterial'))
  // else:
  // IO = 0
  //
  // IV = (PMVA * Valores.frecuenciaVentilatoria) * (Valores.pcoArteriales! / 10)
  //
  // if Valores.pcoArteriales! != 0:
  // EV = (VM * Valores.pcoArteriales!) / ((VMI * 37.5))
  // else if Valores.pcoArteriales! == 0:
  // EV = (VM) / ((3.2 * Valores.pesoCorporalTotal!)) * (100)
  // else:
  // EV = 0
  //
  // PPI = Valores.presionFinalEsiracion+ Valores.presionSoporte!
  // PPE = Valores.presionFinalEsiracionCI = (Valores.pcoArteriales! * Valores.frecuenciaVentilatoria) / 40.00
  //
  // # ######################################################
  // # Análisis de pCO2 / pO2
  // # ######################################################
  // FIOV = ((valores.get('GradienteAlveoloArterial_Arteriales') + 100) / 760) * 100
  //
  // if (FIOV < 21):
  // FIOI = (21.00)
  // else:
  // FIOI = FIOV
  // VENT = (Valores.pcoArteriales! * Valores.frecuenciaVentilatoria) / 40.00
  //
  // if Valores.pcoArteriales! != 0:
  // VA = (0.863 * (3.2 * Valores.pesoCorporalTotal!)) / (
  // Valores.pcoArteriales!)
  // else:
  // VA = 00.00
  static double dummy = 0;
  // Parámetros de Imagenológicos
  static String? fechaEstudioImagenologico;
  static String? regionCorporalImagenologico;
  static String? hallazgosEstudioImagenologico;
  static String? conclusionesImagenologico;
  // # ######################################################
  // # Valoraciones del Riesgo Anestésico
  // # ######################################################
  static String get valoracionDetsky {
    int puntaje = 0;
    //
    if (Valores.edad != 0 && Valores.edad != null) {
      if (Valores.edad! >= 70) {
        puntaje = puntaje + 5;
      }
      if (Valores.antecedenteInfarto == Dicotomicos.dicotomicos()[0]) {
        puntaje = puntaje + 10;
      }
      //
      if (Valores.valoracionNyha == Escalas.nyha[2]) {
        puntaje = puntaje + 10;
      } else if (Valores.valoracionNyha == Escalas.nyha[3]) {
        puntaje = puntaje + 20;
      }
      //
      if (Valores.anginaEnMeses == Dicotomicos.dicotomicos()[0]) {
        puntaje = puntaje + 10;
      }
      //
      if (Valores.edemaPulmonarPasado == Dicotomicos.dicotomicos()[0]) {
        puntaje = puntaje + 10;
      }
      //
      if (Valores.estenosisAortica == Dicotomicos.dicotomicos()[0]) {
        puntaje = puntaje + 20;
      }
      //
      if (Valores.ritmoSinusal == Dicotomicos.dicotomicos()[1]) {
        puntaje = puntaje + 5;
      }
      //
      if (Valores.extrasistolesVentriculares == Dicotomicos.dicotomicos()[1]) {
        puntaje = puntaje + 5;
      }
      //
      if (Valores.cirugiaUrgencia == Dicotomicos.dicotomicos()[0]) {
        puntaje = puntaje + 10;
      }
      //
      if (Valores.valoracionGoldmann ==
          'Clase IV (Complicaciones Graves 22%, Muerte Cárdiaca 56%)') {
        puntaje = puntaje + 10;
      }
      // ##############################################
      // Comprobación de los Puntajes para el dictamen de escala.
      // ##############################################
      print("Puntaje (Detsky) $puntaje");
      //
      if (puntaje >= 30) {
        return 'Clase III (Riesgo cardiaco alto)';
      } else if (puntaje > 15 && puntaje < 30) {
        return 'Clase II (Riesgo cardiaco medio)';
      } else if (puntaje <= 15) {
        return 'Clase I (Riesgo cardiaco bajo)';
      } else {
        return 'Sin resolución';
      }
    } else {
      return 'No valorable';
    }
  }

  static String get valoracionGoldmann {
    int puntaje = 0;
    //
    if (Valores.edad != 0 && Valores.edad != null) {
      if (Valores.edad! >= 70) {
        puntaje = puntaje + 5;
      }
      if (Valores.antecedenteInfarto == Dicotomicos.dicotomicos()[0]) {
        puntaje = puntaje + 10;
      }
      if (Valores.ritmoSinusal == Dicotomicos.dicotomicos()[1]) {
        puntaje = puntaje + 7;
      }
      if (Valores.extrasistolesVentriculares == Dicotomicos.dicotomicos()[0]) {
        puntaje = puntaje + 7;
      }
      if (Valores.ingurgitacionYugular == Dicotomicos.dicotomicos()[0]) {
        puntaje = puntaje + 11;
      }
      if (Valores.estenosisAortica == Dicotomicos.dicotomicos()[0]) {
        puntaje = puntaje + 3;
      }
      if (Valores.cirugiaUrgencia == Dicotomicos.dicotomicos()[0]) {
        puntaje = puntaje + 4;
      }
      if (Valores.cirugiaAbdomen == Dicotomicos.dicotomicos()[0]) {
        puntaje = puntaje + 3;
      }
      if (Valores.malEstadoOrganico == Dicotomicos.dicotomicos()[0]) {
        puntaje = puntaje + 3;
      }

      // ##############################################
      // Comprobación de los Puntajes para el dictamen de escala.
      // ##############################################
      print("Puntaje (Goldmann) $puntaje");
      //
      if (puntaje >= 25) {
        return 'Clase IV (Complicaciones Graves 22%, Muerte Cárdiaca 56%)';
      } else if (puntaje > 13 && puntaje < 25) {
        return 'Clase III (Complicaciones Graves 11%, Muerte Cárdiaca 2%)';
      } else if (puntaje > 6 && puntaje < 12) {
        return 'Clase II (Complicaciones Graves 5%, Muerte Cárdiaca 2%)';
      } else if (puntaje <= 5) {
        return 'Clase I (Complicaciones Graves 0.7%, Muerte Cárdiaca 0.2%)';
      } else {
        return 'Sin resolución';
      }
    } else {
      return 'No valorable';
    }
  }

  static String get valoracionAriscat {
    int puntaje = 0;
//
    if (Valores.edad != 0 && Valores.edad != null) {
      if (Valores.edad! >= 80) {
        puntaje = puntaje + 16;
      } else if (Valores.edad! > 51 && Valores.edad! < 80) {
        puntaje = puntaje + 3;
      } else if (Valores.edad! < 50) {
        puntaje = puntaje + 0;
      }
      //
      if (Valores.saturacionPerifericaOrigeno! ==
          Escalas.saturacionPerifericaOrigeno[0]) {
        puntaje = puntaje + 0;
      } else if (Valores.saturacionPerifericaOrigeno! ==
          Escalas.saturacionPerifericaOrigeno[1]) {
        puntaje = puntaje + 8;
      } else if (Valores.saturacionPerifericaOrigeno! ==
          Escalas.saturacionPerifericaOrigeno[2]) {
        puntaje = puntaje + 24;
      }
      //
      if (Valores.infeccionRespiratoria == Dicotomicos.dicotomicos()[0]) {
        puntaje = puntaje + 17;
      }
      //
      if (Valores.hemoglobinaInferior == Dicotomicos.dicotomicos()[0]) {
        puntaje = puntaje + 11;
      }
      //
      if (Valores.incisionTipo == Escalas.incisionTipo[0]) {
        puntaje = puntaje + 0;
      } else if (Valores.incisionTipo == Escalas.incisionTipo[1]) {
        puntaje = puntaje + 15;
      } else if (Valores.incisionTipo == Escalas.incisionTipo[2]) {
        puntaje = puntaje + 24;
      }
      //
      if (Valores.duracionCirugiaHoras == Escalas.duracionCirugiaHoras[0]) {
        puntaje = puntaje + 0;
      } else if (Valores.duracionCirugiaHoras ==
          Escalas.duracionCirugiaHoras[1]) {
        puntaje = puntaje + 16;
      } else if (Valores.duracionCirugiaHoras ==
          Escalas.duracionCirugiaHoras[2]) {
        puntaje = puntaje + 23;
      }
      //
// ##############################################
// Comprobación de los Puntajes para el dictamen de escala.
// ##############################################
      print("Puntaje (ARISCAT) $puntaje");
      //
      if (puntaje >= 45) {
        return 'Clase III (Riesgo pulmonar alto)';
      } else if (puntaje > 26 && puntaje < 45) {
        return 'Clase II (Riesgo pulmonar medio)';
      } else if (puntaje <= 26) {
        return 'Clase I (Riesgo pulmonar bajo)';
      } else {
        return 'Sin resolución';
      }
    } else {
      return 'No valorable';
    }
  }

  static String movilidadCervical = Escalas.movilidadCervical[0];
  static String distanciaTiromentoniana = Escalas.distanciaTiromentoniana[0];
  static String distanciaEsternomentoniana =
      Escalas.distanciaEsternomentoniana[0];
  static String movilidadTemporoMandibular =
      Escalas.movilidadTemporoMandibular[0];
  static String aperturaMandibular = Escalas.aperturaMandibular[0];
  static String escalaMallampati = Escalas.escalaMallampati[0];
  static String escalaCormackLahane = Escalas.escalaCormackLahane[0];
}

class Valorados {
  static String get cardiovasculares => "Análisis cardiovascular";

  // "Parámetros Cardiovasculares - Presión Arterial Media: " + str(
  // "%.2f" % Cardiovascular.get('Tension_Media_Arterial')) + " mmHg. " \
  // + "(" + Cardiovascular.get('Clase_Tension_Media') + "); " \
  // + "Diferencia de Presión Arterial: " + str(
  // "%.2f" % Cardiovascular.get('Diferencia_Presion_Arterial')) + " mmHg. " \
  // + "Presión de Pulso: " + str("%.2f" % Cardiovascular.get('Presion_Pulso')) + " mmHg. " \
  // + "Producto Frecuencia - Presión: " + str(
  // "%.2f" % Cardiovascular.get('Producto_Frecuencia_Presion')) + " mmHg/Lpm. " \
  // + "Presión Coloido - Oncótica: " + str("%.2f" % Cardiovascular.get('Presion_Coloido_Oncotica')) + " mmHg. " \
  // + "Frecuencia Cárdiaca Máxima: " + str(
  // "%.2f" % Cardiovascular.get('Frecuencia_Cardiaca_Maxima')) + " L/min. " \
  // + "Frecuencia Cárdiaca Blanco: " + str(
  // "%.2f" % Cardiovascular.get('Frecuencia_Cardiaca_Blanco')) + " L/min. " \
  // + "Frecuencia Cárdiaca Intrínseca: " + str(
  // "%.2f" % Cardiovascular.get('Frecuencia_Cardiaca_Intrinseca')) + " L/min. " \
  // + "Volemia Aproximada: " + str("%.2f" % Cardiovascular.get('Volemia_Aproximada')) + " mL,  " \
  // + "Volumen Plasmático Aproximado: " + str(
  // "%.2f" % Cardiovascular.get('Volumen_Plasmatico_Aproximado')) + " L,  " \
  // + "Gasto Cárdiaco Aproximado: " + str("%.2f" % Cardiovascular.get('Gasto_Cardiaco_Aproximado')) + " L/min. " \
  // + "Volumen Látido Aproximado: " + str(
  // "%.2f" % Cardiovascular.get('Volumen_Latido_Aproximado')) + " mL/min. " + "\n" \
  // + "Parámetros Hemodinámicos - Concentración Arterial de Oxígeno (CaO2): " + str(
  // "%.2f" % Cardiovascular.get('Concentracion_Arterial_Oxigeno')) + " mL/dL, " \
  // + "Concentración Venosa de Oxígeno (CvO2): " + str(
  // "%.2f" % Cardiovascular.get('Concentracion_Venosa_Oxigeno')) + " mL/dL, " \
  // + "Diferencia Arterio - Venosa (DavO2): " + str(
  // "%.2f" % Cardiovascular.get('Diferencia_Arterio_Venosa')) + " mL/dL. " \
  // + "Capacidad de Oxígeno (CapO2): " + str("%.2f" % Cardiovascular.get('Capacidad_Oxigeno')) + " mL O2/g Hb. " \
  // + "Indice Cárdicado (I.C.): " + str("%.2f" % Cardiovascular.get('Indice_Cardiaco')) + " L/min/m2, " \
  // + "Resistencias Venosas Sistémicas (R.V.S.): " + str(
  // "%.2f" % Cardiovascular.get('Resistencias_Venosas_Sistemicas')) + " Dinas/seg/cm2. " \
  // + "Indice de Extracción de Oxígeno (I.E.O.): " + str(
  // "%.2f" % Cardiovascular.get('Indice_Extraccion_Oxigeno')) + " %, " \
  // + "Disponibilidad de Oxígeno (dO2): " + str(
  // "%.2f" % Cardiovascular.get('Disponibilidad_Oxigeno')) + " mL/min,  " \
  // + "Consumo de Oxígeno (cO2): " + str("%.2f" % Cardiovascular.get('Consumo_Oxigeno')) + " mL/min/m2, " \
  // + "Transporte de Oxígeno (TO2): " + str("%.2f" % Cardiovascular.get('Transporte_Oxigeno')) + " mL/O2/m2. " \
  // + "Shunt Fisiológico (QS/QT): " + str("%.2f" % Cardiovascular.get('Shunt_Fisiologico')) + " %. " \
  // + "Gradiente Alveolo - Arterial (G(A-a)): " + str(
  // "%.2f" % Cardiovascular.get('Gradiente_Alveolo_Arterial')) + " mmHg. " + "\n" \
  // + "Trabajo Cardiaco - Trabajo Cardiaco: " + str("%.2f" % Cardiovascular.get('Trabajo_Cardiaco')) + " Kg*m. " \
  // + "Trabajo Látido Ventricular Izquierdo: " + str(
  // "%.2f" % Cardiovascular.get('Trabajo_Latido_Ventricular_Izquierdo')) + " g*m. " \
  // + "Trabajo Látido Ventricular Derecho: " + str(
  // "%.2f" % Cardiovascular.get('Trabajo_Latido_Ventricular_Derecho')) + " g*m. " \
  // + "" + "\n"

  static String get vitales =>
      "Signos vitales con " // fecha de ${Pacientes.Vital['Pace_Feca_SV']} con "
      "tensión arterial sistémica en ${Valores.tensionArterialSistemica} mmHg, "
      "frecuencia cardiaca de ${Valores.frecuenciaCardiaca} L/min, "
      "frecuencia respiratoria de ${Valores.frecuenciaRespiratoria} L/min, "
      "temperatura corporal ${Valores.temperaturCorporal}°C, "
      "saturación periférica de oxígeno ${Valores.saturacionPerifericaOxigeno}%, "
      "estatura ${Valores.alturaPaciente} mts";

  static String get signosVitales =>
      "Signos vitales con " // fecha de ${Pacientes.Vital['Pace_Feca_SV']} con "
      "tensión arterial sistémica en ${Valores.tensionArterialSistemica} mmHg, "
      "frecuencia cardiaca de ${Valores.frecuenciaCardiaca} L/min, "
      "frecuencia respiratoria de ${Valores.frecuenciaRespiratoria} L/min, "
      "temperatura corporal ${Valores.temperaturCorporal}°C, "
      "saturación periférica de oxígeno ${Valores.saturacionPerifericaOxigeno}%, "
      "estatura ${Valores.alturaPaciente} mts, "
      "peso corporal total ${Valores.pesoCorporalTotal} Kg, "
      "I.M.C. ${Valores.imc.toStringAsFixed(2)} Kg/m2. "
      "Glucemia capilar ${Valores.glucemiaCapilar} mg/dL, con ${Valores.horasAyuno} horas de ayuno";

  static String get bioconstantes =>
      "Signos vitales con " // fecha de ${Pacientes.Vital['Pace_Feca_SV']} con "
      "tensión arterial sistémica en ${Valores.tensionArterialSistemica} mmHg, "
      "frecuencia cardiaca de ${Valores.frecuenciaCardiaca} L/min, "
      "frecuencia respiratoria de ${Valores.frecuenciaRespiratoria} L/min, "
      "temperatura corporal ${Valores.temperaturCorporal}°C, "
      "saturación periférica de oxígeno ${Valores.saturacionPerifericaOxigeno}%, "
      "estatura ${Valores.alturaPaciente} mts, "
      "peso corporal total ${Valores.pesoCorporalTotal} Kg, "
      "I.M.C. ${Valores.imc.toStringAsFixed(2)} Kg/m2. "
      "C. cintura ${Valores.circunferenciaCintura} cm. "
      "C. cadera ${Valores.circunferenciaCadera} cm. "
      "Glucemia capilar ${Valores.glucemiaCapilar} mg/dL, con ${Valores.horasAyuno} horas de ayuno";

  static String get asociadosRiesgo =>
      "Análisis Antropométrico enfocado al Riesgo: "
      "Pliegue Cutáneo Trícipital ${Valores.pliegueCutaneoTricipital} mm, "
      "Circunferencia Mesobraquial ${Valores.circunferenciaMesobraquial} cm, "
      "Perimetro Muscular Mesobraquial ${Valores.perimetroMesobraquial} cm, "
      "Área Muscular Mesobraquial ${Valores.AM} cm2, "
      "Área Adiposa Mesobraquial ${Valores.areaAdiposaMesobraquial} cm2, "
      "Área Mesobraquial ${Valores.areaMesobraquial} cm2. ";

  static String get antropometricos => "Análisis de Medidas Corporales: "
      "Peso Corporal Ideal ${Valores.pesoCorporalPredicho.toStringAsFixed(2)} Kg, (${Valores.PCIP.toStringAsFixed(2)} %), "
      "Peso Corporal Ajustado ${Valores.pesoCorporalAjustado.toStringAsFixed(2)} Kg, "
      "Exceso de Peso Corporal ${Valores.excesoPesoCorporal.toStringAsFixed(2)} Kg, "
      "Indice de Masa Corporal ${Valores.imc.toStringAsFixed(2)} Kg/m2. (${Valores.claseIMC}). "
      "Peso Corporal Blanco ${Valores.PCB_25.toStringAsFixed(2)} Kg, "
      "Peso Corporal Blanco (I.M.C. 30) ${Valores.PCB_30.toStringAsFixed(2)} Kg. "
      "Superficie Corporal Total ${Valores.SC.toStringAsFixed(2)} m2 "
      "Relacion Cintura  Cadera ${Valores.indiceCinturaCadera.toStringAsFixed(2)} cm. " // \n"
      "Grasa Corporal ${Valores.grasaCorporalEsencial.toStringAsFixed(2)} Kg, "
      "Grasa Corporal Porcentual ${Valores.grasaCorporalEsencial.toStringAsFixed(2)} %, "
      "Peso Corporal Magro ${Valores.porcentajeCorporalMagro.toStringAsFixed(2)} Kg. ";

  static String get metabolometrias =>
      "Análisis Energético: Gasto Energético Basal ${Valores.gastoEnergeticoBasal.toStringAsFixed(2)} kCal/dia "
      "(Factor de Actividad ${Valores.factorActividad}; "
      "Factor de Éstres ${Valores.factorEstres}); "
      "Metabolismo Basal ${Valores.metabolismoBasal.toStringAsFixed(2)} kCal/m2/hr, "
      "Efecto Térmico de los Alimentos ${Valores.efectoTermicoAlimentos.toStringAsFixed(2)} kCal/m2/hr. "
      "Gasto Energético Total ${Valores.gastoEnergeticoTotal.toStringAsFixed(2)} kCal/dia. "
      "Fibra total ${Valores.fibraDietaria.toStringAsFixed(2)} gr/Día";

  static String get renales => "Tasa de Filtrado Glomerular : "
      "${Valores.tasaRenalCrockoft_Gault.toStringAsFixed(2)} mL/min/1.73 m2 (Cockcroft : Gault), "
      "${Valores.tasaRenalMDRD.toStringAsFixed(2)} mL/min/1.73 m2 (M.D.R.D. 4), "
      "${Valores.tasaRenalCKDEPI.toStringAsFixed(2)} mL/min/1.73 m2 (C.K.D. E.P.I.); "
      "Clasificación (Estadio) ${Valores.claseTasaRenal} (KDOQI / KDIGO).";

  static String get hidricos =>
      "Requerimiento hídrico diario: ${Valores.requerimientoHidrico.toStringAsFixed(0)} mL/dia (${Valores.constanteRequerimientos} mL/Kg/dia), "
      "agua corporal total: ${Valores.aguaCorporalTotal.toStringAsFixed(1)} mL, "
      "delta H2O: ${Valores.excesoAguaLibre.toStringAsFixed(1)} L, "
      "deficit de agua corporal: ${Valores.deficitAguaCorporal.toStringAsFixed(1)} L. "
      "osmolaridad: ${Valores.osmolaridadSerica.toStringAsFixed(1)} mOsm/L, "
      "brecha osmolar ${Valores.brechaOsmolar.toStringAsFixed(1)} mOsm/L. "
      "${Valores.sodioCorregido}"
      "Requerimiento de potasio ${Valores.requerimientoPotasio.toStringAsFixed(1)} "
      "delta de potasio ${Valores.deficitSodio.toStringAsFixed(1)} mEq/L: ${Valores.deltaPotasio.toStringAsFixed(1)}";

  static String get hepaticos {
    return "";
    // "Perfil Hepático - " \
    // + "Relacion ALT:FA : " + str("%.1f" % Hepaticos.get('Relacion_ALT_FA')) + "; Conclusión: " + Hepaticos.get(
    //     'Patron_ALT_FA') + " (Consideraciones Diagnósticas: " + Hepaticos.get('Diagnosticos_ALT_FA') + ". " \
    // + "Relacion AST:ALT : " + str(
    //     "%.1f" % Hepaticos.get('Relacion_AST_ALT')) + "; Consideraciones Diagnósticas: " + Hepaticos.get('Patron_AST_ALT') + ". " \
    // + "Relacion GGT:FA : " + str(
    //     "%.1f" % Hepaticos.get('Relacion_GGT_FA')) + "; Consideraciones Diagnósticas: " + Hepaticos.get(
    //     'Diagnosticos_GGT__FA') + ". " \
    // + "Relacion BD:BT : " + str(
    //     "%.1f" % Hepaticos.get('Relacion_BD_BT')) + "; Consideraciones Diagnósticas: " + Hepaticos.get('Diagnosticos_BD_BT') + ". " \
    // + "Relacion BD:BI : " + str("%.1f" % Hepaticos.get('Relacion_BD_BI')) + ". \n"
  }

  static String get prequirurgicos {
    return ""
        "A.S.A.: ${Valores.valoracionAsa}. \n"
        "Goldmann: ${Valores.valoracionGoldmann}. \n"
        "Detsky: ${Valores.valoracionDetsky}. \n"
        "ARISCAT: ${Valores.valoracionAriscat}. "
        "";
  }
}

class Formatos {
  static String get dietasAyuno {
    return 'Ayuno hasta nueva orden';
  }

  static String get dietasCompletas {
    return "Dieta de ${Valores.gastoEnergeticoBasal.toStringAsFixed(0)} kCal/Día "
        "repartido en "
        "hidratos de carbono ${Valores.porcentajeCarbohidratos}% "
        "(${Valores.glucosaPorcentaje.toStringAsFixed(0)} kCal/Día; ${Valores.glucosaGramos.toStringAsFixed(0)} gr/Día), "
        "proteínas ${Valores.porcentajeProteinas}% "
        "(${Valores.proteinasPorcentaje.toStringAsFixed(0)} kCal/Día; ${Valores.proteinasGramos.toStringAsFixed(0)} gr/Día), "
        "lípidos ${Valores.porcentajeLipidos}% "
        "(${Valores.lipidosPorcentaje.toStringAsFixed(0)} kCal/Día; ${Valores.lipidosGramos.toStringAsFixed(0)} gr/Día); \n"
        "${Valores.proteinasAVM.toStringAsFixed(0)} gr/Día de proteína de alto valor molecular, "
        "${Valores.sodioDietario.toStringAsFixed(0)} mEq/Día de sodio, "
        "${Valores.fibraDietaria.toStringAsFixed(0)} gr/Día de fibra total, "
        "${Valores.aguaTotal.toStringAsFixed(0)} Lt/Día de agua libre.\n";
  }

  static String get dietas {
    return "Dieta de ${Valores.gastoEnergeticoBasal.toStringAsFixed(0)} kCal/Día; "
        "${Valores.proteinasAVM.toStringAsFixed(0)} gr/Día de proteína de alto valor molecular, "
        "${Valores.sodioDietario.toStringAsFixed(0)} mEq/Día de sodio, "
        "${Valores.fibraDietaria.toStringAsFixed(0)} gr/Día de fibra total, "
        "${Valores.aguaTotal.toStringAsFixed(0)} Lt/Día de agua libre.\n";
  }

  static String get concentraciones {
    return "";
  }

  static String get indicacionesPreoperatorias {
    return "No suspender Metformina, sólo el día de la cirugía control con Insulina y durante el transquirurgico. \n"
        "Medidas universales de cuidados y prevención de paciente quirúrgico. \n"
        "Monitoreo y control de cifras tensionales mantener TAM >65. \n"
        "Mantener cifras de glicemia entre 100 a 185 mg/dL, "
        "en caso de hiperglicemia aplicar infusión de insulina durante el tranquirúrgico. \n"
        "Evitar uso de antiinflamatorios no esteroideos. \n"
        "Procurar hidroterapia en rangos del requerimiento basal; "
        "se sugiere uso de soluciones cristaloides isotónicas en caso de ser necesario. \n"
        "Analgesia con opioides intermedios o fuertes. \n"
        "Evitar el ayuno mayor de 8 horas durante los momentos prequirúrgicos y/o postquirúrgicos por riesgo de disglicemia. \n"
        "Se sugire inicio de Metformina 850 mg cada 12 horas, asi como realización de estudios paraclinicos para valoración ulterior. "
        "";
  }

  static String get transfusiones {
    return "Debido a ${Valores.motivoTransfusion}, "
        "se administra ${Valores.hemotipoAdmnistrado}, ${Valores.cantidadUnidades} Unidad(es), "
        "para volumen total ${Valores.volumenAdministrado} "
        "identificable con Folio ${Valores.numIdentificacion}; "
        "verificando previamente fecha de caducidad (Día ${Valores.fechaCaducidad}, de acuerdo a registro).  Serología No Reactiva.";
  }

  static String get subjetivos {
    return "El paciente se refiere ${Valores.estadoGeneral}. "
        "Via oral a base de ${Valores.viaOral}. "
        "Uresis con frecuencia ${Valores.uresisCantidad}, "
        "excretas con frecuencia ${Valores.excretasCantidad}. "
        "${Valores.referenciasHospitalizacion}. ";
  }

  static String get ideologias {
    String prejuicios = "", creencias = "", valores = "", costumbres = "";
    // ******** **** ******* **** *******
    if (Valores.prejuiciosAtencion!) {
      if (Valores.creenciasPaciente != '' ||
          Valores.creenciasPaciente != null) {
        creencias = "debido a las creencias del paciente argumentadas por "
            "${Valores.creenciasPaciente!}";
      }
      prejuicios = "Existencia de prejuicios respecto a la atención médica "
          "$creencias"
          "$valores"
          "$costumbres \n";
    } else {
      prejuicios =
          "Sin existencia de prejuicios respecto a la atención médica. ";
    }
    // ******** **** ******* **** *******
    return "Ideologias: "
        "$prejuicios"
        "Redes de apoyo durante la hospitalización "
        "por parte de la Madre (${Dicotomicos.fromBoolean(Valores.apoyoMadre!)}), "
        "por parte del Padre (${Dicotomicos.fromBoolean(Valores.apoyoPadre!)}), "
        "por parte de los Hermanos (${Dicotomicos.fromBoolean(Valores.apoyoHermanos!)}), "
        "por parte de los Hijos o familiares (${Dicotomicos.fromBoolean(Valores.apoyoHijosMayores!)}). ";
  }

  static String get viviendas {
    // Variables ******** **** ********* ******** **********
    String formacion = "",
        comodidades = "",
        servicios = "",
        conformacion = "",
        corral = "",
        compania = "";
    // Formación ******** **** ********* ******** **********
    if (Valores.viviendaSala) {
      formacion = "$formacion con sala";
    }
    if (Valores.viviendaComedor) {
      formacion = "$formacion, comedor";
    }
    if (Valores.viviendaBano) {
      formacion = "$formacion, baño";
    }
    if (Valores.viviendaHabitacionesSeparadas) {
      formacion = "$formacion, habitaciones separadas";
    }
    // Servicios ******** **** ********* ******** **********
    if (Valores.viviendaAguaPotable) {
      servicios = "$servicios con agua potable";
    }
    if (Valores.viviendaDrenaje) {
      servicios = "$servicios, drenaje";
    }
    if (Valores.viviendaAlcantarillado) {
      servicios = "$servicios, alcantarillado";
    }
    if (Valores.viviendaElectricidad) {
      servicios = "$servicios, electricidad";
    }
    // Comodidades ******** **** ********* ******** **********
    if (Valores.viviendaTelevision) {
      comodidades = "$comodidades con televisión";
    }
    if (Valores.viviendaEstufa) {
      comodidades = "$comodidades, estufa";
    }
    if (Valores.viviendaHornoLena) {
      comodidades = "$comodidades, leña";
    }
    // Conformación ******** **** ********* ******** **********
    if (Valores.viviendaPatioDelantero) {
      conformacion = "$conformacion con patio delantero";
    } else {
      conformacion = "$conformacion sin patio delantero";
    }
    if (Valores.viviendaPatioTrasero) {
      conformacion = "$conformacion, con patio trasero";
    } else {
      conformacion = "$conformacion, sin patio trasero";
    }
    // ******** **** ********* ******** **********
    if (Valores.viviendaAnimalesCorral) {
      if (Valores.viviendaVacunos) {
        corral = "$corral, ${Valores.viviendaCantidadVacunos} vacas. ";
      }
      if (Valores.viviendaOvinos) {
        var aux = corral.substring(0, corral.length - 2);
        //
        corral = "$aux, ${Valores.viviendaCantidadOvinos} ovejas. ";
      }
      if (Valores.viviendaPorcinos) {
        var aux = corral.substring(0, corral.length - 2);
        //
        corral = "$aux, ${Valores.viviendaCantidadPorcinos} cerdos. ";
      }
      if (Valores.viviendaAves) {
        var aux = corral.substring(0, corral.length - 2);
        //
        corral = "$aux, ${Valores.viviendaCantidadAves} aves. ";
      }
    } else {
      corral = "Sin animales de corral en la vivienda. ";
    }
    // ******** **** ********* ******** **********
    if (Valores.viviendaAnimalesCompania) {
      if (Valores.viviendaCaninos) {
        compania = "$compania, ${Valores.viviendaCantidadCaninos} perros. ";
      }
      if (Valores.viviendaFelinos) {
        var aux = compania.substring(0, compania.length - 2);
        //
        compania = "$aux, ${Valores.viviendaCantidadFelinos} felinnoss. ";
      }
      if (Valores.viviendaReptiles) {
        var aux = compania.substring(0, compania.length - 2);
        //
        compania = "$aux, ${Valores.viviendaCantidadReptiles} réptiles. ";
      }
      if (Valores.viviendaParvada) {
        var aux = compania.substring(0, compania.length - 2);
        //
        compania = "$aux, ${Valores.viviendaCantidadParvada} aves. ";
      }
    } else {
      compania = "Sin animales de compañia en la vivienda. ";
    }
    // ******** **** ********* ******** **********
    return "Vivienda: Propiedad ${Valores.propiedadVivienda}. "
        "Conformacion interna de la vivienda con "
        "piso de ${Valores.materialPiso!.toLowerCase()}, "
        "pared de ${Valores.materialParedes!.toLowerCase()}, "
        "techo de ${Valores.materialTecho!.toLowerCase()}. \n"
        "Separación habitacional$formacion. "
        "Servicios publicos habitacionales$servicios. "
        "Servicios domiciliarios$comodidades. "
        "Conformación externa de la vivienda$conformacion. \n"
        "Presencia de animales en la vivienda: "
        // "Animales de corral en la vivienda (${Dicotomicos.fromBoolean(Valores.viviendaAnimalesCorral)})"
        "$corral"
        // " Animales de compañia en la vivienda (${Dicotomicos.fromBoolean(Valores.viviendaAnimalesCompania)})"
        "$compania";
  }

  static String get alimentarios {
    return "Hábitos alimenticios: "
        "${Valores.alimentacionDiariaDescripcion}. "
        "${Valores.dietaAsignadaDescripcion}. "
        "${Valores.variacionAlimentacionDescripcion}. "
        "${Valores.problemasMasticacionDescripcion}. "
        "${Valores.intoleranciaAlimentariaDescripcion}. "
        "${Valores.alteracionesPesoDescripcion}. ";
    // "Alimentacion Diaria (${Dicotomicos.fromBoolean(Valores.alimentacionDiaria!)}). "
    // "Dieta Asignada (${Dicotomicos.fromBoolean(Valores.dietaAsignada!)}) ${Valores.dietaAsignadaDescripcion}. "
    // "Variaciones de la Dieta (${Dicotomicos.fromBoolean(Valores.variacionAlimentacion!)}) ${Valores.variacionAlimentacionDescripcion}. "
    // "Problemas con la Alimentación (${Dicotomicos.fromBoolean(Valores.problemasMasticacion!)}) ${Valores.problemasMasticacionDescripcion}. "
    // "Intolerancias Alimentarias (${Dicotomicos.fromBoolean(Valores.intoleranciaAlimentaria!)}) ${Valores.intoleranciaAlimentariaDescripcion}. "
    // "Alteraciones del Peso (${Dicotomicos.fromBoolean(Valores.alteracionesPeso!)}) ${Valores.alteracionesPesoDescripcion}. ";
  }

  static String get diarios {
    return "Hábitos diarios: "
        "Actividad Habitual ${Valores.actividadesDiariasDescripcion}; "
        "Pasatiempos referidos ${Valores.pasatiemposDescripcion}; "
        "Horas de Sueño ${Valores.horasSuenoDescripcion}; "
        "Viajes al Nacionales / Extranjero Recientemente (${Dicotomicos.fromBoolean(Valores.viajesRecientes!)}) ${Valores.viajesRecientesDescripcion}. \n"
        "Problemas en Interacciones Cotidianas: "
        "Problemas Familiares (${Dicotomicos.fromBoolean(Valores.problemasFamiliares!)}): "
        "Violencia Infantil ${Dicotomicos.fromBoolean(Valores.violenciaInfantil!)}, "
        "Abuso de Sustancias ${Dicotomicos.fromBoolean(Valores.abusoSustancias!)}. "
        "Problemas Laborales (${Dicotomicos.fromBoolean(Valores.problemasLaborales!)}): "
        "Estres Laboral ${Dicotomicos.fromBoolean(Valores.estresLaboral!)}, "
        "Hostilidad en el Trabajo ${Dicotomicos.fromBoolean(Valores.hostilidadLaboral!)}, "
        "Abuso Sexual ${Dicotomicos.fromBoolean(Valores.abusoSexual!)}, "
        "Acoso Sexual ${Dicotomicos.fromBoolean(Valores.acosoSexual!)}. ";
  }

  static String get higienicos {
    // String bano = "", manos = "", ropa = "", dental = "";
    //
    // if (Valores.banoCorporal!) {
    // bano = "${Valores.banoCorporalDescripcion}";
    // } else {
    //   bano = 'Refiere no realizar aseo corporal diario';
    // }
    // if (Valores.higieneManos!) {
    //   bano = "${Valores.higieneManosDescripcion}";
    // } else {
    //   bano = 'Refiere realizar un mal aseo de manos';;
    // }
    // if (Valores.cambiosRopa!) {
    //   bano = "${Valores.cambiosRopaDescripcion}";
    // } else {
    //   bano = 'Refiere no realizar aseo corporal diario';
    // }
    // if (Valores.aseoDental!) {
    //   bano = "${Valores.aseoDentalDescripcion}";
    // } else {
    //   bano = 'Refiere no realizar aseo corporal diario';
    // }

    return "Hábitos higiénicos: "
        "${Valores.banoCorporalDescripcion}. "
        "${Valores.higieneManosDescripcion}. "
        "${Valores.cambiosRopaDescripcion}. "
        "${Valores.aseoDentalDescripcion}. ";
    // "Bano corporal diario (${Dicotomicos.fromBoolean(Valores.banoCorporal!)}) (${Valores.banoCorporalDescripcion}). "
    // "Lavado de manos (${Dicotomicos.fromBoolean(Valores.higieneManos!)}) (${Valores.higieneManosDescripcion}). "
//         "Cambio de ropa (${Dicotomicos.fromBoolean(Valores.cambiosRopa!)}) (${Valores.cambiosRopaDescripcion}). "
    //      "Aseo dental ${Dicotomicos.fromBoolean(Valores.aseoDental!)} (${Valores.aseoDentalDescripcion}). "
  }

  static String get limitaciones {
    String lentes = "",
        sordera = "",
        dentaria = "",
        marcapasos = "",
        protesis = "",
        limitacion = "";
    // ******** ********** ******* ****** ******
    if (Valores.usoLentes!) {
      lentes = Valores.usoLentesDescripcion!;
    } else {
      lentes = "Sin uso de lentes. ";
    }
    // ******** ********** ******* ****** ******
    if (Valores.aparatoSordera!) {
      sordera = Valores.aparatoSorderaDescripcion!;
    } else {
      sordera = "Sin uso de aparatos para hipoacusia. ";
    }
    // ******** ********** ******* ****** ******
    if (Valores.protesisDentaria!) {
      dentaria = Valores.protesisDentariaDescripcion!;
    } else {
      dentaria = "Sin uso de protesis dentaria. ";
    }
    // ******** ********** ******* ****** ******
    if (Valores.marcapasosCardiaco!) {
      marcapasos = Valores.marcapasosCardiacoDescripcion!;
    } else {
      marcapasos = "Sin uso de marcapasos cárdiaco. ";
    }
    // ******** ********** ******* ****** ******
    if (Valores.ortesisDeambular!) {
      protesis = Valores.ortesisDeambularDescripcion!;
    } else {
      protesis = "Sin uso de ortesis de algún tipo. ";
    }
    // ******** ********** ******* ****** ******
    if (Valores.limitacionesActividadCotidiana!) {
      limitacion = Valores.limitacionesActividadCotidianaDescripcion!;
    } else {
      limitacion = "Sin limitaciones en la actividad diaria. ";
    }
    // ******** ********** ******* ****** ******
    return "Limitaciones físicas: "
        "$lentes"
        "$sordera"
        "$dentaria"
        "$marcapasos"
        "$protesis"
        "$limitacion";

    // "Uso de Lentes ${Dicotomicos.fromBoolean(Valores.usoLentes!)}. "
    // "Uso de Aparatos de Sordera ${Dicotomicos.fromBoolean(Valores.aparatoSordera!)}. "
    // "Uso de Protesis Dentaria ${Dicotomicos.fromBoolean(Valores.protesisDentaria!)}. "
    // "Uso de Marcapasos Cardiaco ${Dicotomicos.fromBoolean(Valores.marcapasosCardiaco!)}. "
    // "Uso de Protesis para Deambular ${Dicotomicos.fromBoolean(Valores.ortesisDeambular!)}. "
    // "Limitaciones Fisicas para las Actividades Diarias ${Dicotomicos.fromBoolean(Valores.limitacionesActividadCotidiana!)}. ";
  }

  static String get exposiciones {
    // ************* ********** ************** ***
    return "Exposición a sustancias tóxicas: "
        "${Valores.exposicionBiomasaDescripcion}. "
        "${Valores.exposicionHumosQuimicosDescripcion}. "
        "${Valores.exposicionPesticidasDescripcion}. "
        "${Valores.exposicionMetalesPesadosDescripcion}. "
        "${Valores.exposicionPsicotropicosDescripcion}. ";

    // "Exposicion a Humos de Leña ${Dicotomicos.fromBoolean(Valores.exposicionBiomasa!)}. "
    // "Exposicion a Humos Quimicos ${Dicotomicos.fromBoolean(Valores.exposicionHumosQuimicos!)}. "
    // "Exposicion a Pesticidas ${Dicotomicos.fromBoolean(Valores.exposicionPesticidas!)}. "
    // "Exposicion a Metales Pesados ${Dicotomicos.fromBoolean(Valores.exposicionMetalesPesados!)}. "
    // "Uso de Medicamentos Psicotropicos ${Dicotomicos.fromBoolean(Valores.exposicionPsicotropicos!)}. ";
  }

  // ************* ********** ************** ***
  static String get toxicomanias {
    String alcoholismo = "", tabaquismo = "", drogadismo = "";
    // ************* ********** ************** ***
    if (Valores.esAlcoholismo!) {
      String suspension = "";
      if (Valores.suspensionAlcoholismo!) {
        suspension =
            "Suspendido hace ${Valores.aosSuspensionAlcoholismo} años. ";
      } else {
        suspension = "";
      }
      // ***** // ******************** // ************
      alcoholismo =
          "Alcoholismo iniciado a los ${Valores.edadInicioAlcoholismo}, "
          "con duración aproximada de  ${Valores.duracionAnosAlcoholismo} años, "
          "a razón de  ${Valores.periodicidadAlcoholismo} cada  ${Valores.intervaloAlcoholismo}. "
          "$suspension"
          "Tipo de alcohol usado ( ${Valores.tiposAlcoholismoDescripcion}). ";
    } else {
      alcoholismo = 'Alcoholismo negado. ';
    }
    // ************* ********** ************** ***
    if (Valores.esTabaquismo!) {
      String suspension = "";
      if (Valores.suspensionTabaquismo!) {
        suspension =
            "Suspendido hace ${Valores.aosSuspensionTabaquismo} años. ";
      } else {
        suspension = "";
      }
      // ***** // ******************** // ************
      tabaquismo = "Tabaquismo iniciado a los ${Valores.edadInicioTabaquismo}, "
          "con duración aproximada de  ${Valores.duracionAnosTabaquismo} años, "
          "a razón de  ${Valores.periodicidadTabaquismo} cada  ${Valores.intervaloTabaquismo}. "
          "$suspension"
          "Tipo de tabaco usado ( ${Valores.tiposTabaquismoDescripcion}). ";
    } else {
      tabaquismo = 'Tabaquismo negado. ';
    }
    // ************* ********** ************** ***
    if (Valores.esDrogadismo!) {
      String suspension = "";
      if (Valores.suspensionDrogadismo!) {
        suspension =
            "Suspendido hace ${Valores.aosSuspensionDrogadismo} años. ";
      } else {
        suspension = "";
      }
      // ***** // ******************** // ************
      drogadismo = "Drogadismo iniciado a los ${Valores.edadInicioDrogadismo}, "
          "con duración aproximada de  ${Valores.duracionAnosDrogadismo} años, "
          "a razón de  ${Valores.periodicidadDrogadismo} cada  ${Valores.intervaloDrogadismo}. "
          "$suspension"
          "Tipo de drogas usadas ( ${Valores.tiposDrogadismoDescripcion}). ";
    } else {
      drogadismo = 'Drogadismo negado. ';
    }
    // ************* ********** ************** ***

    return 'Toxicomanias: '
        '$alcoholismo'
        '$tabaquismo'
        '$drogadismo';
  }

  // ************* ********** ************** ***
  static String get cateterVenosoCentral {
    return "Previa recolección de Material y Lavado de Manos. "
        "Se coloca a la paciente en posición en Decúbito Supino rotando la cabeza de la paciente a 45° al contrario de la ${Valores.sitiosCateterCentral}. Realizado calzado de guantes estériles.\n"
        "Se localiza el Tubérculo Coroídeo para indicar zona de punción y se procede a infiltrar con Lidocaína al 1%.\n"
        "Posteriormente se coloca Campos Estériles y se inicia a la comprobación del Equipo corroborando permeabilidad de las lineas vasculares con solución inyectable y Heparina Sódica, "
        "para posteriormente sellar los lumenes de acceso. \n"
        "Corroborado el Equipo se procede a realizar la Punción de la Vena con el Trocar en orientación hacia la Horquilla Esternal a 45° con respecto a la piel, aspirando de manera continua, "
        "obteniendo sangre venosa en recamara de inserción, "
        "comprobando el ingreso a la vena. Se inserta la guia metálica y se procede al retiro de la guia mediante la cual se introduce dilatador a tres tercios de su extensión para posteriormente retirarla. "
        "Ex post facto, se inserta el catéter retirando al mismo tiempo la guia. Se comprueba la permeabilidad del catéter observándose ingreso de solución parenteral, "
        "y posteriormente corroborando reflujo sanguíneo por medio de la linea vascular.\n"
        "Se procede a Fijar el Catéter Venoso Central a la piel con Sutura Nylon 2-0, colocando previamente los aditivos para la fijación. Se recubre con aditivo de tela transparente (Tegaderm) "
        "y se membrete fecha de colocación. ";
  }

  static String get intubacionEndotraqueal {
    return "Previo Lavado de Manos y colocación de elementos de protección personal, asi como preparación del Material a Utilizar, se revisa que el laringoscopio tenga pilas y funcione correctamente "
        "y se comprueba la integridad del globo del ${Valores.dispositivoEmpleado} insuflandolo para corroborar su correcta dilatación sin fuga. "
        "Se lubrica el dispositivo con xilocaína, y se corrobora que la guía metálica no rebase la punta del ${Valores.dispositivoEmpleado}.\n"
        "Se administra Sedante Opiáceo para asegurar sedoanalgésia, mientras se realiza Preoxigenación al paciente con Dispositivo de Alto Flujo, "
        "recolocando la cama del paciente para que la cabeza del mismo quede a la altura del apéndice xifoides del operador, inclinando la cabeza del paciente hacia posterior "
        "resultando en una Movilidad Cervical ${Valores.movilidadCervical}, para posteriormente elevar el mentón en Posición de Olfateo; "
        "clasificando la Distancia Esternomentoniana como ${Valores.distanciaEsternomentoniana}, y Distancia Tiromentoniana como ${Valores.distanciaTiromentoniana}. \n"
        "Se apertura la Mandíbula Inferior clasificando la Apertura Mandibular como ${Valores.aperturaMandibular}, además de Protrusión Mandibular como ${Valores.movilidadTemporoMandibular}, "
        "para posteriormente visualizar el Istmo Orofaríngeo, catalogándolo como ${Valores.escalaMallampati} (Mallampati). Posteriormente se ingresa la hoja del Laringoscopio del lado derecho "
        "de la lengua empujando la misma hacia la izquierda; coadyuvado mediante la realización de la Maniobra de Sellick, "
        "quedando asi la hoja en la línea media. "
        "Se desciende hasta la base de la lengua hasta presionarla sobre el piso de la boca en el ángulo de la Vallecula Epiglótica, quedando el mango del laringoscopio apuntando al techo, en un ángulo de 45 grados. "
        "Visualizando las cuerdas vocales siendo catalogado el acceso aéreo como ${Valores.escalaCormackLahane}(Cormack - Lahane). Se toma el ${Valores.dispositivoEmpleado} "
        "con la mano derecha desplazandolo sobre la hoja del laríngoscopio para ir atravezando las Cuerdas Vocales hasta ver desaparecer el extremo inferior del ${Valores.dispositivoEmpleado}, "
        "donde quedará ubicado el balón del dispositivo (3 - 4 cm de las Cuerdas Vocales).\n"
        "Se retira la guia metálica, posteriormente se retira el laringoscopio para la posterior confirmación de la correcta colocacion del ${Valores.dispositivoEmpleado} mediante la visualización de la columna de aire através del dispositivo, "
        "la simétria de la ventilación evidenciada por la mecánica tóracica y por la auscultación directa. "
        "Toda vez corroborado la correcta inserción de este, se conecta el ${Valores.dispositivoEmpleado} al ${Valores.dispositivoOxigeno}.\n"
        "Se ausculta el abdomen en búsqueda de presion positiva, asi como ambos pulmones a la altura de la linea media axilar obteniendo sonido simétrico en ambos pulmones.\n"
        "Se mantiene el ${Valores.dispositivoEmpleado} a 22 cm respecto a los dientes, y se procede a asegurarlo con esparadrapo y pegarla a las mejillas. ";
  }

  static String get sondaEndopleural {
    return "Posterior a haber brindado información sobre el Procedimiento al Paciente, y haber recabado los Consentimientos Informados. "
        "Se hace la Recolección del Material y se procede a realizar el procedimiento. \n"
        "Se coloca al paciente en Decúbito Dorsal ligeramente girado respecto Sitio de Colocación, con el brazo del lado afectado detrás "
        "de la cabeza del paciente para exponer el área axilar. Se identifica, mediante palpación, el ${Valores.sitiosSondaPleural} a la Altura "
        "de la Línea Axilar Anterior. Se procede a realizar la investidura de ropa estéril para posteriormente realizar asepsia y antisépsia "
        "del Hemitórax a operar. Se mide la Sonda Pleural respecto al cuerpo del paciente previo a su introducción tomando "
        "como referencia el punto de insición y la zona de estancia. Se prepara la zona a puncionar cubriendo con campos quirúrgicos, tomando "
        "en cuenta el Triángulo de Seguridad (conformado en su Borde Anterior el Latísimo del Músculo Dorsal Ancho, "
        "el Pectoral Mayor en su borde Posterior, "
        "y la Cuarta Costilla como su base marcando como referencia el nivel horizontal del pezón, y un ápice debajo de la áxila). \n"
        "Se procede a anestesiar la zona con Lidocaína al 2% iniciando con un botón en piel, y posteriormente se infiltra el área aledaña a esta. "
        "A nivel del ${Valores.sitiosSondaPleural} se realiza una incisión horizontal de ~1.5 cm para el paso de la Sonda Pleural, con una pinza Kelly se "
        "apertura el trayecto subcutáneo, se introduce el dedo indice por el trayecto y se palpa el pulmón para garantizar la localización de la cavidad pleural "
        "comprobando que no haya adherencias. Se coloca la pinza Kelly en el extremo distal de la Sonda de pleurostomía, "
        "y en el extremo proximal se localiza coloca "
        "una Pinza Foester para introducirla através del trayecto subcutáneo hasta llegar dentro de la Cavidad Pleural. "
        "Se abren las pinzas Kelly y se retiran para "
        "colocar la Sonda en su posición final. \n"
        "Se asegura la sonda con Sutura tipo Jareta con Hilo de Seda, y se realiza la conexión de la Sonda Pleural al Sístema de Sello de Agua. "
        "Finalmente, se coloca "
        "un vendaje para fijar la sonda con cinta adhesiva, y se comprueba nuevamente el gasto de la misma atraves de la sonda.";
  }

  static String get cateterTenckhoff {
    return "Previa recolección de Material y Lavado de Manos. Se procede a realizar antisepsia de la región abdominal, se colocan campos estériles, "
        "considerando como sitio de punción la región paraumbilical derecha a 3 cm de la cicatriz umbilical, en dirección hacia la fosa iliaca derecha, se infiltra el sitio para la punción "
        "con lidocaina al 2%, se icide la piel aproximadamente un centímetro y se diseca por planos anatomicos atravezando la piel, el téjido subcutáneo, la aponeurosis, "
        "hasta las membranas extraperitoneales hasta llegar al peritoneo. \n"
        "Se verifica la posición del cáteter tipo Tenchkoff, se introduce en guía de alambre y se dirige a la cavidad pélvica en dirección a la fosa iliaca izquierda, "
        "y se posiciona el coginete proximal en la aponeurosis muscular. "
        "Se realiza la tunelación del catéter a aproximadamente 4 cm del orificio de entrada, mediante el tunelador cuidando de no sobreestirar el catéter ni torcerlo, "
        "posicionando el coginete distal a 2 cm del sitio de salida. \n"
        "Instalado el conector de titanio y la linea de transferencia, se infunde solución dializante al 1.5% para verificar los tiempos de ingreso y egreso del líquido dialítico. "
        "Se cierra el tejido celular con catgut crómico de 2-0 y la piel con sutura nylon 2-0. Se coloca gasa esteril en el sitio de salida.";
    // Tiempo de ingreso ideal: 12 minutos; tiempo de egreso ideal 15 minutos.
    // Pendientes: S
  }

  static String get puncionLumbar {
    return "Posterior a haber brindado información sobre el Procedimiento al Paciente, y haber recabado los Consentimientos Informados. "
        "Se hace la Recolección del Material y se procede a realizar el procedimiento. \n"
        "Se localizan el sitio de punción tomando como referencias las espinas iliacas posterosuperiores y se traza una linea imaginaria perpendicular "
        "entre ambas, encontrandose a la altura de ${Valores.sitiosPuncionLumbar}. "
        "${Valores.anestesiaEmpleada}"
        // "Se coloca un parche con un combinado de lidocaína-prilocaína al 2.5% en crema, aproximadamente 1 gr del compuesto, siendo cubierto con un "
        // "apósito oclusivo adhesivo. "
        "Se coloca al paciente en decúbito lateral " // En posición sentada
        // "Se procede a realizar asepsia y antisepsia de la zona para posteriormente infiltrar la zona con lidocaina al 2%"
        "Se realiza higiene de manos "
        // "y se procede a retirar la anestesia tópica"
        "y se comienza con la colocación de la vestimenta estéril. "
        "Se localiza nuevamente el sitio de punción encontrandose, nuevamente, a la altura de ${Valores.sitiosPuncionLumbar}. "
        "Se realiza asepsia y antisepsia de la zona, "
        "se toma la aguja"
        "posteriormente se procede a introducir la aguja con el bisel considerando un ángulo de 30° hacia arriba" // Hacia la derecha o izquierda si es sentado
        "Se retira el mandril obteniendo líquido de aspecto " //
        "y se procede a obtener muestras del fluido. "
        "Se obtiene un total de " // Generalmente tres muestras (PCR para virus/bacterias, citología y bioquímica, cultivo microbiológico.)
        "Tras la recogida del líquido cefalorraquídeo, se introduce el mandril y se retira la aguda. Una vez retirada la aguja se deja colocado una "
        "gasa estéril haciendo una breve presión sobre el sitio de punción. \n"
        "Se realiza el envió de las muestras al laboratorio. ";
  }

  static String get exploracionTerapia => ""
      "Durante la Exploración Física, siendo evaluado por Aparatos y Sistemas, es encontrado: \n"
      "NEUROLOGICO: "
      "En sedoanalgesia con ${Valores.sedoanalgesia} consiguiendo "
      "R.A.S.S. ${Valores.rass} y "
      "Ramsay ${Valores.ramsay}, sin datos de focalización neurológica. \n"
      "VENTILATORIO: Apoyo ventilatorio con ${Valores.dispositivoEmpleado!.toLowerCase()}, "
      "mediante ${Valores.tuboEndotraqueal} ${Valores.haciaArcadaDentaria!.toLowerCase()}. "
      "${Formatos.ventilador} \n"
      // **************** ************ ********
      "PCO2 ${Valores.pcoArteriales!.toStringAsFixed(0)} mmHg, "
      "PO2 ${Valores.poArteriales!.toStringAsFixed(0)} mmHg, "
      "SO2 ${Valores.soArteriales!.toStringAsFixed(0)} %, "
      "Indice PaO2/FiO2: ${Valores.PAFI.toStringAsFixed(0)} mmHg. "
      "Aa-O2 ${Valores.GAA.toStringAsFixed(0)} mmHg. \n"
      "Ruidos pulmonares audibles, sin estertores ni sibilancias. "
      "\n"
      "HEMODINAMICO: "
      "Con tensión arterial sistémica ${Valores.tensionArterialSistemica} mmHg, "
      "(TAM ${Valores.presionArterialMedia.toStringAsFixed(0)} mmHg), ${Valores.apoyoAminergico!.toLowerCase()}; "
      "frecuencia cardiaca ${Valores.frecuenciaCardiaca!.toStringAsFixed(0)} L/min detectada por monitoreo cardiaco continuo, "
      "con telemetría a  ritmo sinusal; ruidos cardiacos rítmicos, "
      "adecuada frecuencia aumentados en intensidad, llenado capilar distal de 2 segundos, pulsos presentes de adecuada frecuencia e intensidad. \n"
      "HEMATOINFECCIOSO: "
      "Con temperatura corporal ${Valores.temperaturCorporal!.toStringAsFixed(1)} °C, con "
      "${Valores.antibioticoterapia}; última biometría hemática obteniendo "
      "hemoglobina ${Valores.hemoglobina} g/dL, "
      "hematocrito ${Valores.hematocrito}%, "
      "leucocitos ${Valores.leucocitosTotales} K/uL, "
      "neutrofilos ${(Valores.neutrofilosTotales! / Valores.leucocitosTotales!).toStringAsFixed(2)} %, "
      "linfocitos ${(Valores.linfocitosTotales! / Valores.leucocitosTotales!).toStringAsFixed(2)} %, "
      "monocitos ${(Valores.monocitosTotales! / Valores.leucocitosTotales!).toStringAsFixed(2)} %; "
      "reactantes con "
      // + Pacientes.Auxiliares.Laboratorios.Biometrias.prosaSimple(self) ""
      "proteína C reactiva ${Valores.proteinaCreactiva} mg/dL, "
      "procalcitonina ${Valores.procalcitonina} ng/mL. "
      // "Riesgo de úlceras por presión por inmovilización ${Valores.evaluacionNorton} (Norton), "
      // "${Valores.evaluacionBraden} (Braden). \n"
      "Sin datos de sangrado, ni requerimiento transfusional. \n"
      "GASTROMETABÓLICO: ${Valores.tipoSondaAlimentacion}; ${Valores.alimentacion}. "
      "Peso corporal total: ${Valores.pesoCorporalTotal!.toStringAsFixed(2)} Kg, "
      "estatura: ${Valores.alturaPaciente} mts, I.M.C ${Valores.imc.toStringAsFixed(0)} Kg/m2, y "
      "peso predicho ${Valores.pesoCorporalPredicho.toStringAsFixed(1)} Kg. \n"
      "Glucometría capilar con ${Valores.glucemiaCapilar} mg/dL, y "
      "glucosa sérica ${Valores.glucosa!.toStringAsFixed(0)} mg/dL, "
      "albúmina en ${Valores.albuminaSerica!.toStringAsFixed(1)} g/dL. "
      "Abdomen blando, depresible, sin datos de irritación peritoneal. \n"
      "HIDRICO-RENAL: ${Valores.tipoSondaVesical}, con "
      "balance hídrico con "
      "ingresos ${Valores.ingresosBalances} mL,  "
      "egresos ${Valores.egresosBalances} mL  "
      "(${Valores.balanceTotal} mL/${Valores.horario} Horas),  "
      "perdidas insensibles ${Valores.perdidasInsensibles} mL, "
      "uresis ${Valores.uresis} mL "
      "(diuresis ${Valores.diuresis.toStringAsFixed(2)} mL/${Valores.horario} Horas). "
      "Respecto a la función renal  con "
      "creatinina ${Valores.creatinina!.toStringAsFixed(1)} mg/dL, "
      "urea ${Valores.urea!.toStringAsFixed(1)} mg/dL; "
      "tasa de filtrado glomerular ${Valores.tasaRenalCrockoft_Gault.toStringAsFixed(0)} mL/min/1.73 m2 (Cockcroft - Gault). \n"
      "pH ${Valores.pHArteriales}, "
      "HCO3- ${Valores.bicarbonatoArteriales!.toStringAsFixed(1)} mmol/L, "
      "E.B. ${Valores.EB.toStringAsFixed(1)} mmol/L. " // excesoBaseArteriales
      "Sodio ${Valores.sodio!.toStringAsFixed(0)} mmol/L, "
      "potasio ${Valores.potasio!.toStringAsFixed(1)} mmol/L, "
      "cloro: ${Valores.cloro!.toStringAsFixed(0)} mmol/L. \n"
      "${Valorados.hidricos}";

  static String get modoVentilatorio {
    var MOD = ' ';
    if (Valores.modalidadVentilatoria ==
        'Ventilación Limitada por Presión Ciclada por Tiempo (P-VMC / VCP)') {
      MOD = 'AC-VCP'; // # 'P-VMC/VCP';
    } else if (Valores.modalidadVentilatoria ==
        'Ventilación Limitada por Flujo Ciclada por Volumen (V-VMC / VCV)') {
      MOD = 'AC-VCV'; // # 'V-VMC/VCV';
    } else if (Valores.modalidadVentilatoria ==
        'Ventilación Mandatoria Intermitente Sincrónizada (SIMV / VCV)') {
      MOD = 'SIMV/VCV';
    } else if (Valores.modalidadVentilatoria ==
        'Ventilación Mandatoria Intermitente Sincrónizada (SIMV / VCP)') {
      MOD = 'SIMV/VCP';
    } else if (Valores.modalidadVentilatoria ==
        'Presión Positiva en Vía Aérea con Presión Soporte (CPAP / PS)') {
      MOD = 'CPAP/PS';
    } else if (Valores.modalidadVentilatoria == 'Espontáneo (ESPON)') {
      MOD = 'ESPON';
    } else {
      MOD = ' ';
    }
    return MOD;
  }

  static String get ventilador {
    if (Formatos.modoVentilatorio == 'ESPON') {
      return "Ventilación en modalidad ${Formatos.modoVentilatorio} con parámetros ajustados a "
          "frecuencia ventilatoria ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "presión al final de la espiración ${Valores.presionFinalEsiracion} mmHg, "
          "presión soporte ${Valores.presionControl} mmHg. "
          "Analisis ventilatorio con  ${Formatos.ventilatorios}";
    } else if (Formatos.modoVentilatorio == 'CPAP/PS') {
      return "Ventilación en modalidad ${Formatos.modoVentilatorio} con parámetros ajustados a "
          "frecuencia ventilatoria ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "presión al final de la espiración ${Valores.presionFinalEsiracion} mmHg, "
          "presión soporte ${Valores.presionControl} mmHg. "
          "Analisis ventilatorio con  ${Formatos.ventilatorios}";
    } else if (Formatos.modoVentilatorio == 'AC-VCV') {
      return "Ventilación en modalidad ${Formatos.modoVentilatorio} con parámetros ajustados a "
          "frecuencia ventilatoria ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "presión al final de la espiración ${Valores.presionFinalEsiracion} mmHg, "
          "volumen tidal ${Valores.volumenTidal} mmHg. "
          "Analisis ventilatorio con  ${Formatos.ventilatorios}";
    } else if (Formatos.modoVentilatorio == 'AC-VCP') {
      return "Ventilación en modalidad ${Formatos.modoVentilatorio} con parámetros ajustados a "
          "frecuencia ventilatoria ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "presión al final de la espiración ${Valores.presionFinalEsiracion} mmHg, "
          "presión control ${Valores.presionControl} mmHg. "
          "Analisis ventilatorio con  ${Formatos.ventilatorios}";
    } else if (Formatos.modoVentilatorio == 'SIMV/VCV') {
      return "Ventilación en modalidad ${Formatos.modoVentilatorio} con parámetros ajustados a "
          "frecuencia ventilatoria ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "presión al final de la espiración ${Valores.presionFinalEsiracion} mmHg, "
          "volumen tidal ${Valores.volumenTidal} mmHg. "
          "Analisis ventilatorio con  ${Formatos.ventilatorios}";
    } else if (Formatos.modoVentilatorio == 'SIMV/VCP') {
      return "Ventilación en modalidad ${Formatos.modoVentilatorio} con parámetros ajustados a "
          "frecuencia ventilatoria ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "presión al final de la espiración ${Valores.presionFinalEsiracion} mmHg, "
          "presión control ${Valores.presionControl} mmHg. "
          "Analisis ventilatorio con  ${Formatos.ventilatorios}";
    } else {
      return '';
    }
  }

  static String get ventilatorios {
    Terminal.printExpected(
        message:
            "Formatos.modoVentilatorioALIDAD VENTILATORIA ${Valores.modalidadVentilatoria} ${Formatos.modoVentilatorio}");

    // Prosa del Análisis Ventilatorio **************** ****************** **********************
    var PS = '';
    if (Formatos.modoVentilatorio == 'ESPON') {
      PS = "Psopp ${Valores.presionSoporte} cmH2O, "
          "P. pulmonar insp. ${Valores.presionInspiratoriaPico} cmH2O, "
          "P. pulmonar esp. ${Valores.presionFinalEsiracion} cmH2O, ";
    } else if (Formatos.modoVentilatorio == 'CPAP/PS') {
      PS = "Psopp ${Valores.presionSoporte} cmH2O, "
          "P. pulmonar insp. ${Valores.presionInspiratoriaPico} cmH2O, "
          "P. pulmonar esp. ${Valores.presionFinalEsiracion} cmH2O, ";
    } else if (Formatos.modoVentilatorio == 'AC-VCV') {
      PS = "VM ${Valores.volumenMinuto.toStringAsFixed(1)} L/min, "
          "Flujo ${Valores.flujoVentilatorioMedido.toStringAsFixed(2)} L/min, "
          "VTI ${Valores.volumenTidal} mL, ";
    } else if (Formatos.modoVentilatorio == 'AC-VCP') {
      PS = "Pinsp ${Valores.presionControl} cmH2O, "
          "PIP ${Valores.presionMaxima} cmH2O, "
          "Pplat ${Valores.presionPlateau} cmH2O. \n"
          "PmVA ${Valores.presionMediaViaAerea.toStringAsFixed(0)} cmH2O, "
          "WOB ${Valores.poderMecanico.toStringAsFixed(2)} J/min, "
          "Dist P. ${Valores.distensibilidadPulmonar.toStringAsFixed(2)} mL/cmH2O, "
          "Dest ${Valores.distensibilidadPulmonarEstatica.toStringAsFixed(2)} mL/cmH2O, "
          "Ddyn ${Valores.distensibilidadPulmonarDinamica.toStringAsFixed(2)} mL/cmH2O, "
          "RP ${Valores.resistenciaPulmonar.toStringAsFixed(2)} mL/cmH2O, "
          "Elast ${Valores.elastanciaPulmonar.toStringAsFixed(2)} cmH2O/mL, "
          "D. Pressure ${Valores.presionDistencion.toStringAsFixed(0)} mmHg, "
          "VM ${Valores.volumenMinuto.toStringAsFixed(1)} L/min, "
          "Flujo ${Valores.flujoVentilatorioMedido.toStringAsFixed(2)} L/min, ";
    } else if (Formatos.modoVentilatorio == 'SIMV/VCV') {
      PS = "Psopp ${Valores.presionSoporte} cmH2O, "
          "VM ${Valores.volumenMinuto.toStringAsFixed(1)} L/min, "
          "Flujo ${Valores.flujoVentilatorioMedido.toStringAsFixed(2)} L/min, "
          "VTI ${Valores.volumenTidal} mL, ";
    } else if (Formatos.modoVentilatorio == 'SIMV/VCP') {
      PS = "Psopp ${Valores.presionSoporte} cmH2O, "
          "Pinsp ${Valores.presionControl} cmH2O, "
          "PIP ${Valores.presionMaxima} cmH2O, "
          "Pplat ${Valores.presionPlateau} cmH2O. \n"
          "PmVA ${Valores.presionMediaViaAerea.toStringAsFixed(0)} cmH2O, "
          "WOB ${Valores.poderMecanico.toStringAsFixed(2)} J/min, "
          "Dist P. ${Valores.distensibilidadPulmonar.toStringAsFixed(2)} mL/cmH2O, "
          "Dest ${Valores.distensibilidadPulmonarEstatica.toStringAsFixed(2)} mL/cmH2O, "
          "Ddyn ${Valores.distensibilidadPulmonarDinamica.toStringAsFixed(2)} mL/cmH2O, "
          "RP ${Valores.resistenciaPulmonar.toStringAsFixed(2)} mL/cmH2O, "
          "Elast ${Valores.elastanciaPulmonar.toStringAsFixed(2)} cmH2O/mL, "
          "D. Pressure ${Valores.presionDistencion.toStringAsFixed(0)} mmHg, "
          "VM ${Valores.volumenMinuto.toStringAsFixed(1)} L/min, "
          "Flujo ${Valores.flujoVentilatorioMedido.toStringAsFixed(2)} L/min, ";
    } else {
      PS = '';
    }
    // print("PROSA VENTILATORIA $PS");
    return PS;
  }

  static String get licenciaMedica {
    return "Licencia médica otorgada con folio ${Valores.folioLicencia}, "
        "con ${Valores.diasOtorgadosLicencia} dias otorgados desde la "
        "fecha de inicio ${Valores.fechaInicioLicencia} hasta el ${Valores.fechaTerminoLicencia}, "
        "por ${Valores.motivoLicencia}, de cáracter ${Valores.caracterLicencia}. ";
  }

  static String get balances {
    return "Balance hídrico (${Valores.fechaRealizacionBalances}) - "
        "Ingresos ${Valores.ingresosBalances} mL,  "
        "egresos ${Valores.egresosBalances} mL  "
        "(balance Total ${Valores.balanceTotal} mL${Valores.horario} mL),  "
        "uresis ${Valores.uresis} mL,  "
        "diuresis ${Valores.diuresis.toStringAsFixed(2)} mL/${Valores.horario} mL.  "
        "\n ";
  }

  static String get gasometricos {
    return "Gasometría Arterial (${Valores.fechaGasometriaArterial}):  "
        "pH ${Valores.pHArteriales}, "
        "PCO2 ${Valores.pcoArteriales} mmHg, "
        "PO2 ${Valores.poArteriales} mmHg, "
        "SO2 ${Valores.soArteriales} %, "
        "HCO3- ${Valores.bicarbonatoArteriales!.toStringAsFixed(2)} mmol/L, "
        "HCO3std ${Valores.EBecf.toStringAsFixed(2)} mmol/L, "
        "EB ${Valores.EB.toStringAsFixed(2)} mmol/L, "
        "TCO2 ${Valores.TCO.toStringAsFixed(2)} mmHg, "
        "PCO2e ${Valores.PCO2C.toStringAsFixed(2)} mmHg, "
        // "EBe ${Valores.pHArteriales} mmol/L, "
        "aGAP ${Valores.GAP.toStringAsFixed(1)}, "
        "Temp ${Valores.temperaturCorporal}°C, "
        "FiO2 ${Valores.fioArteriales}%, "
        "A-aO2 ${Valores.GAA.toStringAsFixed(1)} mmHg, "
        "PaO2/FiO2 ${Valores.PAFI_FIO.toStringAsFixed(0)}mmHg/%";
  }

  static String get gasometricosNombrado {
    return "${Valores.nombreCompleto} - "
        "pH ${Valores.pHArteriales}, "
        "PCO2 ${Valores.pcoArteriales} mmHg, "
        "PO2 ${Valores.poArteriales} mmHg, "
        "SO2 ${Valores.soArteriales} %, "
        "HCO3- ${Valores.bicarbonatoArteriales!.toStringAsFixed(2)} mmol/L, "
        "HCO3std ${Valores.EBecf.toStringAsFixed(2)} mmol/L, "
        "EB ${Valores.EB.toStringAsFixed(2)} mmol/L, "
        "TCO2 ${Valores.TCO.toStringAsFixed(2)} mmHg, "
        "PCO2e ${Valores.PCO2C.toStringAsFixed(2)} mmHg, "
        // "EBe ${Valores.pHArteriales} mmol/L, "
        "aGAP ${Valores.GAP.toStringAsFixed(1)}, "
        "Temp ${Valores.temperaturCorporal}°C, "
        "FiO2 ${Valores.fioArteriales}%, "
        "A-aO2 ${Valores.GAA.toStringAsFixed(1)} mmHg, "
        "PaO2/FiO2 ${Valores.PAFI_FIO.toStringAsFixed(0)}mmHg/%";
  }

  static String get gasometricosMedial {
    return "Gasometría Arterial (${Valores.fechaGasometriaArterial}):  "
        "pH ${Valores.pHArteriales}, "
        "PCO2 ${Valores.pcoArteriales} mmHg, "
        "PCO2Tp ${Valores.PCO2C.toStringAsFixed(2)} mmHg, "
        "PO2 ${Valores.poArteriales} mmHg, "
        "SO2 ${Valores.soArteriales} %, "
        "Hb ${Valores.hemoglobina} g/dL, "
        "Hto ${Valores.hematocrito} %, "
        "HCO3- ${Valores.bicarbonatoArteriales!.toStringAsFixed(2)} mmol/L, "
        "HCO3std ${Valores.EBecf.toStringAsFixed(2)} mmol/L, "
        "EB ${Valores.EB.toStringAsFixed(2)} mmol/L, "
        "TCO2 ${Valores.TCO.toStringAsFixed(2)} mmHg, "
        "PCO2e ${Valores.PCO2C.toStringAsFixed(2)} mmHg, "
        "Temp ${Valores.temperaturCorporal}°C, "
        "FiO2 ${Valores.fioArteriales}%, "
        "PAO2 ${Valores.PAO} mmHg, "
        "A-aO2 ${Valores.GAA.toStringAsFixed(1)} mmHg, "
        "PAO2/PO2 ${Valores.PaO2PAO2.toStringAsFixed(0)}mmHg, "
        "PO2/FiO2 ${Valores.PAFI_FIO.toStringAsFixed(0)}mmHg, "
        "SO2/FiO2 ${Valores.SAFI.toStringAsFixed(0)}mmHg/%, "
        "aGAP ${Valores.GAP.toStringAsFixed(1)}, "
        "GAPoms ${Valores.GAPO.toStringAsFixed(1)}, "
        "RI ${Valores.RI.toStringAsFixed(1)}"
        ".";
  }

  static String get gasometricosCompleto {
    return "Gasometría Arterial (${Valores.fechaGasometriaArterial}):  "
        "pH ${Valores.pHArteriales}, "
        "PCO2 ${Valores.pcoArteriales} mmHg, "
        "PCO2Tp ${Valores.PCO2C.toStringAsFixed(2)} mmHg, "
        "PO2 ${Valores.poArteriales} mmHg, "
        "SO2 ${Valores.soArteriales} %, "
        "Hb ${Valores.hemoglobina} g/dL, "
        "Hto ${Valores.hematocrito} %, "
        "HCO3- ${Valores.bicarbonatoArteriales!.toStringAsFixed(2)} mmol/L, "
        "HCO3std ${Valores.EBecf.toStringAsFixed(2)} mmol/L, "
        "EB ${Valores.EB.toStringAsFixed(2)} mmol/L, "
        "TCO2 ${Valores.TCO.toStringAsFixed(2)} mmHg, "
        "PCO2e ${Valores.PCO2C.toStringAsFixed(2)} mmHg, "
        "Temp ${Valores.temperaturCorporal}°C, "
        "FiO2 ${Valores.fioArteriales}%, "
        "PAO2 ${Valores.PAO} mmHg, "
        "A-aO2 ${Valores.GAA.toStringAsFixed(1)} mmHg, "
        "PAO2/PO2 ${Valores.PaO2PAO2.toStringAsFixed(0)}mmHg, "
        "PO2/FiO2 ${Valores.PAFI_FIO.toStringAsFixed(0)}mmHg, "
        "SO2/FiO2 ${Valores.SAFI.toStringAsFixed(0)}mmHg/%, "
        "aGAP ${Valores.GAP.toStringAsFixed(1)}, "
        "GAPoms ${Valores.GAPO.toStringAsFixed(1)}, "
        "RI ${Valores.RI.toStringAsFixed(1)}, "
        "pH- 1ra Regla ${Valores.HCOR_a.toStringAsFixed(2)}, "
        "pH- 2da Regla ${Valores.HCOR_b.toStringAsFixed(2)}, "
        "HCO3- 3ra Regla ${Valores.HCOR_c.toStringAsFixed(2)} mmol/L, "
        "Rep. HCO3- ${Valores.HCOAM.toStringAsFixed(2)}, "
        "en total ${Valores.NOAMP.toStringAsFixed(0)} ámpulas de bicarbonato al 7.5%"
        ".";
  }

  static String get gasometricosBicarbonato {
    return "Gasometría Arterial (${Valores.fechaGasometriaArterial}):  "
        "pH ${Valores.pHArteriales}, "
        "PCO2 ${Valores.pcoArteriales} mmHg, "
        "PCO2Tp ${Valores.PCO2C.toStringAsFixed(2)} mmHg, "
        "PO2 ${Valores.poArteriales} mmHg, "
        "SO2 ${Valores.soArteriales} %, "
        "Hb ${Valores.hemoglobina} g/dL, "
        "Hto ${Valores.hematocrito} %, "
        "HCO3- ${Valores.bicarbonatoArteriales!.toStringAsFixed(2)} mmol/L, "
        "HCO3std ${Valores.EBecf.toStringAsFixed(2)} mmol/L, "
        "EB ${Valores.EB.toStringAsFixed(2)} mmol/L, "
        "TCO2 ${Valores.TCO.toStringAsFixed(2)} mmHg, "
        "PCO2e ${Valores.PCO2C.toStringAsFixed(2)} mmHg, "
        "Temp ${Valores.temperaturCorporal}°C, "
        "FiO2 ${Valores.fioArteriales}%, "
        "pH- 1ra Regla ${Valores.HCOR_a.toStringAsFixed(2)}, "
        "pH- 2da Regla ${Valores.HCOR_b.toStringAsFixed(2)}, "
        "HCO3- 3ra Regla ${Valores.HCOR_c.toStringAsFixed(2)} mmol/L, "
        "Rep. HCO3- ${Valores.HCOAM.toStringAsFixed(2)}, "
        "en total ${Valores.NOAMP.toStringAsFixed(0)} ámpulas de bicarbonato al 7.5%"
        ".";
  }
}

class Escalas {
  static List<String> asa = [
    'A.S.A. I (Paciente Sano)',
    'A.S.A. II (Enfermedad Sistémica Compensada)',
    'A.S.A. III (Enfermedad Sistémica Descompensada)',
    'A.S.A. IV (Enfermedad Sistémica Amenaza Constante para la Vida)',
    'A.S.A. V (Paciente Moribundo con Probabilidad de Vida Menor)',
    'A.S.A. VI (Muerte Cerebral)',
  ];
  static List<String> bromage = [
    'Grado I: Libre Circulación de las Piernas y los Pies (Bloqueo 0%)',
    'Grado II: Capaz de flexionar rodillas con Libre Circulación Podálica (Bloqueo 33%)',
    'Grado III: Incapaz de flexionar rodillas perocon Libre Circulación Podálica (Bloqueo 66%)',
    'Grado IV: Incapaz de flexionnar rodillas y pies (Bloqueo 100%)',
  ];
  static List<String> nyha = [
    'Clase I (Asintomático, Sin limitación en la actividad física)',
    'Clase II (Leve, Limitación leve en la actividad física)',
    'Clase III (Moderado, Limitación leve en la actividad diaria)',
    'Clase IV (Severo, Limitación para cualquier actividad diaria)',
  ];
  static List<String> ashworth = ["0", "1", "1+", "2", "3", "4"];
  static List<String> daniels = ["0", "1", "2", "3", "4", "5"];
  static List<String> MRC = [
    "0 (Ausente)",
    "1 (Mínima)",
    "2 (Escasa)",
    "3 (Regular)",
    "3+ (Regular +)",
    "4- (Buena -)",
    "4 (Buena)",
    "4+ (Buena +)",
    "5 (Normal)"
  ];
  static List<String> siedel = [
    "0 (Arreflexia)",
    "+ (Hiporreflexia)",
    "++ (Normal)",
    "+++ (Hiperreflexia)",
    "++++ (Hiperreflexia y Clonus)"
  ];
  static List<String> norton = [
    "> 14 Puntos (Riesgo Mínimo)",
    "13 a 14 Puntos (Riesgo Medio)",
    "10 a 12 Puntos (Riesgo Alto)",
    "5 a 9 Puntos (Riesgo Muy Alto)"
  ];
  static List<String> braden = [
    "18 a 23 Puntos (Sin Riesgo)",
    "15 a 18 Puntos (Riesgo Leve)",
    "13 a 14 Puntos (Riesgo Moderado)",
    "10 a 12 Puntos (Riesgo Alto)",
    "< 9 Puntos (Riesgo Muy Alto)"
  ];
  static List<String> RASS = [
    "4",
    "3",
    "2",
    "1",
    "0",
    "-1",
    "-2",
    "-3",
    "-4",
    "-5"
  ];
  static List<String> ramsay = ["1", "2", "3", "4", "5"];
  static List<String> glasgow = [
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15"
  ];

  static List<dynamic> serviciosHospitalarios = [];
  static List<String> motivosEgresos = [
    '',
    'Máximo beneficio',
    'Mejorado',
    'Traslado',
    'Alta voluntaria',
    'Defunción',
  ];

  static List<String> saturacionPerifericaOrigeno = [
    '> 96%',
    '91 - 95%',
    '<90%',
  ];
  static List<String> incisionTipo = [
    'Periférica',
    'Torácica',
    'Abdominal Alta',
  ];
  static List<String> duracionCirugiaHoras = [
    '<2',
    '2 - 3',
    '> 3',
  ];

  static List<String> movilidadCervical = [
    'Grado I: Sin ninguna limitante (35°)',
    'Grado II: Un tercio limitante (23°)',
    'Grado III: Dos tercios limitados (11°)',
    'Grado IV: Limitación completa',
  ];
  static List<String> distanciaTiromentoniana = [
    'Grado I: Mayor a 6.5 cm',
    'Grado II: Entre 6 a 6.5 cm',
    'Grado III: Menor a 6 cm',
  ];
  static List<String> distanciaEsternomentoniana = [
    'Grado I: Mayor a 13 cm',
    'Grado II: Entre 12 - 13 cm',
    'Grado III: Entre 11 - 12 cm',
    'Grado IV: Menor de 11 cm',
  ];
  static List<String> movilidadTemporoMandibular = [
    'Clase A: Los incisivos inferiores se superponen a los superiores',
    'Clase B: Los incisivos inferiores se alinean a los superiores',
    'Clase C: Los incisivos inferiores se retroponen a los superiores',
  ];
  static List<String> aperturaMandibular = [
    'Grado I: Mayor a 4 cm',
    'Grado II: Entre 3 - 4 cm',
    'Grado III: Menor a 3 cm',
  ];
  static List<String> escalaMallampati = [
    'Grado I: Total visibilidad de las amígdalas, úvula y paladar blando',
    'Grado II: Visibilidad del paladar duro y blando, porción superior de las amígdalas',
    'Grado III: Visibilidad de la base de la úvula',
    'Grado IV: Visibilidad única del paladar duro',
  ];
  static List<String> escalaCormackLahane = [
    'Tipo I: Visualización completa de la glotis',
    'Tipo II-a: Vista parcial de la glotis',
    'Tipo II-b: Vista parcial de la aritenoides, o posterior glótica',
    'Tipo III: Visualización única de la epiglotis',
    'Tipo IV: Sin visualización de la epiglotis',
  ];

  static List<String> regionCorporalImagenologico = [
    'Región craneal',
  ];
}

class Items {
  static List<String> tiposAnalisis = [
    'Padecimiento Actual',
    'Análisis Médico'
  ];
  static List<String> motivosTraslado = [
    "Falla de Respuesta Favorable al Tratamiento",
    "Presencia de Complicaciones",
    "Requiere Estudios Auxiliares Diagnósticos Especiales",
    "Riesgo de Secuelas que Requieren Tratamiento Especializado",
    "Complementación Diagnóstica por Servicio Especializado",
    "Requerimiento de Tratamiento Especializado"
  ];
  static List<String> fentanilo = [
    "> 10 mL/Hr",
    "10 - 5 mL/Hr",
    "< 5 mL/Hr",
  ];
  static List<String> midazolam = ["> 10 mL/Hr", "< 9 mL/Hr"];

  static List<String> sedacion = [
    "Ninguno",
    "Midazolam",
    "Propofol",
    "Dexmedetomidina",
    "Fentanilo",
    "Buprenorfina",
    "Morfina",
    "Midazolam y Morfina",
    "Midazolam y Buprenorfina",
    "Midazolam y Propofol",
    "Midazolam y Fentanilo",
    "Midazolam, Propofol y Fentanilo",
    "Midazolam, Propofol y Morfina",
    "Dexmedetomidina y Fentanilo",
    "Dexmedetomidina y Buprenorfina",
    "Midazolam, Fentanilo y Dexmedetomidina",
    "Propofol y Fentanilo",
    "Propofol y Buprenorfina",
    "Propofol y Morfina",
    "Propofol y Midazolam",
    "Tiopental Sódico",
    "Tiopental Sódico y Morfina",
    "Tiopental Sódico y Midazolam",
    "Tiopental Sódico, Midazolam y Morfina",
    "Tiopental Sódico, Midazolam y Propofol",
    "Tiopental Sódico, Midazolam, Propofol y Morfina",
    "Tiopental Sódico, Propofol y Morfina"
  ];
  static List<String> pupilar = [
    "Púpilas Isocóricas Normorreflécticas",
    "Púpilas Isocóricas Arreflécticas",
    "Púpilas Anisocóricas Normorreflécticas",
    "Púpilas Anisocóricas Arreflécticas"
  ];
  static List<String> respuestaOcular = [
    "Apertura Ocular Espontánea",
    "Apertura Ocular ante Estímulo Verbal",
    "Apertura Ocular Ante Estímulo Doloroso",
    "Sin Apertura Ocular Ante Estímulo"
  ];
  static List<String> respuestaVerbal = [
    "Respuesta Verbal Coherente",
    "Respuesta Verbal Confusa",
    "Respuesta Verbal mediante Palabras Inadecuadas",
    "Respuesta Verbal mediantes Sonidos Incomprensibles",
    "Sin Respuesta Verbal Alguna",
    "Respuesta Verbal Limitada"
  ];
  static List<String> respuestaMotora = [
    "Respuesta Motora Obedeciendo Ordenes",
    "Respuesta Motora Localizando el Dolor",
    "Respuesta Motora por Movimiento de Retirada",
    "Respuesta Motora mediante Fléxión Hipertónica",
    "Respuesta Motora mediante Extensión Hipertónica",
    "Sin Respuesta Motora Alguna"
  ];

  static List<String> ventilatorio = [
    "Fase O",
    "Fase I",
    "Fase II",
    "Fase III"
  ];
  static List<String> tuboendotraqueal = [
    "Tubo Endotraqueal Fr. 10.0",
    "Tubo Endotraqueal Fr. 9.5",
    "Tubo Endotraqueal Fr. 9.0",
    "Tubo Endotraqueal Fr. 8.0",
    "Tubo Endotraqueal Fr. 8.5",
    "Tubo Endotraqueal Fr. 7.5",
    "Tubo Endotraqueal Fr. 7.0",
    "Tubo Endotraqueal Fr. 6.5",
    "Tubo Endotraqueal Fr. 6",
    "Cánula de Traqueostomía Fr. 10.0",
    "Cánula de Traqueostomía Fr. 9.5",
    "Cánula de Traqueostomía Fr. 9.0",
    "Cánula de Traqueostomía Fr. 8.5",
    "Cánula de Traqueostomía Fr. 8.0",
    "Cánula de Traqueostomía Fr. 7.5",
    "Cánula de Traqueostomía Fr. 7.0",
    "Cánula de Traqueostomía Fr. 6.5",
    "Cánula de Traqueostomía Fr. 6"
  ];
  static List<String> arcadaDentaria = [
    "a 18 cm de la Arcada Dentaria",
    "a 19 cm de la Arcada Dentaria",
    "a 20 cm de la Arcada Dentaria",
    "a 21 cm de la Arcada Dentaria",
    "a 22 cm de la Arcada Dentaria",
    "a 23 cm de la Arcada Dentaria",
    "a 24 cm de la Arcada Dentaria",
    "a 25 cm de la Arcada Dentaria",
    "a 26 cm de la Arcada Dentaria",
    "a 27 cm de la Arcada Dentaria",
    "a 28 cm de la Arcada Dentaria",
    "a 29 cm de la Arcada Dentaria",
    "a 30 cm de la Arcada Dentaria"
  ];
  static List<String> aminergico = [
    "Sin Apoyo Aminérgico ni Inotrópicos",
    "Con Apoyo Aminérgico",
    "Con Soporte Inotrópico"
  ];
  static List<String> orogastrico = [
    "Sin Sonda Oro/Nasogástrica",
    "Con Sonda Orogástrica Fr. 14",
    "Con Sonda Orogástrica Fr. 16",
    "Con Sonda Orogástrica Fr. 18",
    "Con Sonda Nasogástrica Fr. 14",
    "Con Sonda Nasogástrica Fr. 16",
    "Con Sonda Nasogástrica Fr. 18"
  ];
  static List<String> foley = [
    "Sin Sonda Vesical",
    "Con Sonda Vesical Fr. 10",
    "Con Sonda Vesical Fr. 12",
    "Con Sonda Vesical Fr. 14",
    "Con Sonda Vesical Fr. 16",
    "Con Sonda Vesical Fr. 18"
  ];
  static List<String> dieta = [
    "En Ayuno Hasta Nueva Orden",
    "Dieta Líquida",
    "Dieta Blanda",
    "Dieta Enteral Completa",
    "Dieta Polimérica",
    "Dieta Líquida por Sonda Nasogástrica",
    "Dieta Blanda por Sonda Nasogástrica",
    "Dieta Enteral Completa por Sonda Nasogástrica",
    "Dieta Polimérica por Sonda Nasogástrica",
    "Dieta Líquida por Sonda Orogástrica",
    "Dieta Blanda por Sonda Orogástrica",
    "Dieta Enteral Completa por Sonda Orogástrica",
    "Dieta Polimérica por Sonda Orogástrica"
  ];
  static List<String> antibioticoterapia = [
    "Sin Antibioticoterapia",
    "Con Antibioticoterapia a Base de Penicilina Natural",
    "Con Antibioticoterapia a Base de Penicilina Resistente a Penicilinasa",
    "Con Antibioticoterapia a Base de Aminopenicilina",
    "Con Antibioticoterapia a Base de Carboxipenicilina",
    "Con Antibioticoterapia a Base de Ureidoenicilina",
    "Con Antibioticoterapia a Base de Inhibidor de Beta - Lactamasas",
    "Con Antibioticoterapia a Base de Polipéptido",
    "Con Antibioticoterapia a Base de Cefalosporina de Primera Generación",
    "Con Antibioticoterapia a Base de Cefalosporina de Segunda Generación",
    "Con Antibioticoterapia a Base de Cefalosporina de Tercera Generación",
    "Con Antibioticoterapia a Base de Cefalosporina de Cuarta Generación",
    "Con Antibioticoterapia a Base de Cefalosporina de Quinta Generación",
    "Con Antibioticoterapia a Base de Inhibidor de Beta - Lactamasas",
    "Con Antibioticoterapia a Base de Betalactámico",
    "Con Antibioticoterapia a Base de Sulfonamida",
    "Con Antibioticoterapia a Base de Polimixina A",
    "Con Antibioticoterapia a Base de Polimixina B",
    "Con Antibioticoterapia a Base de Polimixina C",
    "Con Antibioticoterapia a Base de Polimixina D",
    "Con Antibioticoterapia a Base de Polimixina E",
    "Con Antibioticoterapia a Base de Polienos",
    "Con Antibioticoterapia a Base de Tetraciclina",
    "Con Antibioticoterapia a Base de Fenicol",
    "Con Antibioticoterapia a Base de Nitroimidazol",
    "Con Antibioticoterapia a Base de Imidazol",
    "Con Antibioticoterapia a Base de Triazol",
    "Con Antibioticoterapia a Base de Macrólido",
    "Con Antibioticoterapia a Base de Aminoglucósido",
    "Con Antibioticoterapia a Base de Quinolona",
    "Con Antibioticoterapia a Base de Ansamicina",
    "Con Antibioticoterapia a Base de Lincosamida",
    "Con Antibioticoterapia a Base de Glucopéptido",
    "Con Antibioticoterapia a Base de Carbapenémico",
    "Con Antibioticoterapia a Base de Ertapenémico",
    "Con Antibioticoterapia a Base de Monobactámico",
    "Con Antibioticoterapia a Base de Cefalosporina y Macrólido",
    "Con Antibioticoterapia a Base de Cefalosporina y Quinolona",
    "Con Antibioticoterapia a Base de Macrólido y Quinolona",
    "Con Antibioticoterapia a Base de Glucopéptido y Quinolona",
    "Con Antibioticoterapia a Base de Glucopéptido y Aminoglucósido",
    "Con Antibioticoterapia a Base de Glucopéptido y Tetraciclina",
    "Con Antibioticoterapia a Base de Glucopéptido y Glicilciclina",
    "Con Antibioticoterapia a Base de Glucopéptido, Aminoglucósido y Polimixina",
    "Con Antibioticoterapia a Base de Carbapenémico y Glucopéptido",
    "Con Antibioticoterapia a Base de Carbapenémico y Imidazol",
    "Con Antibioticoterapia a Base de Carbapenémico y Oxazolidinona",
    "Con Antibioticoterapia a Base de Carbapenémico y Beta - Lactámico",
    "Con Antibioticoterapia a Base de Carbapenémico y Quinolona",
    "Con Antibioticoterapia a Base de Carbapenémico y Tetraciclina",
    "Con Antibioticoterapia a Base de Carbapenémico y Glicilciclina",
    "Con Antibioticoterapia a Base de Carbapenémico y Polimixina",
    "Con Antibioticoterapia a Base de Inhibidor de Beta - Lactamasas y Betalactámico"
  ];

  static List<String> tusigeno = ["TUSIGENO", "Si", "No"];
  static List<String> deglutorio = ["DEGLUTORIO", "Si", "No"];
  static List<String> expectoratorio = ["EXPECTORATORIO", "Si", "No"];

  static List<String> dispositivosOxigeno = [
    'Ventilador Mecánico Controlado por Presión',
    'Ventilador Mecánico Controlado por Volumen',
    'Ventilador Mecánico Controlado por Presión Modalidad para Bi-Presión Continua de la Via Aérea  (BiPAP: iPAP, ePAP),'
        'Ventilador Mecánico Controlado por Presión Modalidad para Presión Continua de la Via Aérea (C.P.A.P.)',
    'Ventilador Mecánico Volumétrico Controlado Neumáticamente y Controlado Electrónicamente',
    'Dispositivo Bolsa-Válvula-Mascarilla',
    'Nebulizador con Sistema Venturi',
    'Casco Cefálco, con Dispositivo Borboteador',
    'Incubadora con Dispositivo Oxigenoterapia Integrado',
    'Pieza en T, con Dispositivo Borboteador',
    'Collarín de Traqueostomía, con Dispositivo Borboteador',
    'Tienda Facial, con Dispositivo Borboteador',
    'Cánula Nasal, con Dispositivo Borboteador',
    'Cánula Nasal con Reservorio "de Bigote", con Dispositivo Borboteador',
    'Cánula Nasal con Reservorio Colgante, con Dispositivo Borboteador',
    'Mascarilla Simple con Dispositivo Borboteador',
    'Máscara de Oxígeno con Reservorio, con Dispositivo Borboteador',
    'Máscara de Reinhalación Parcial, con Dispositivo Borboteador',
    'Máscara de No Reinhalación con Reservorio, con Dispositivo Borboteador'
  ];

  static List<String> sitiosCateterCentral = [
    'Vena Yugular Anterior Derecha',
    'Vena Yugular Anterior Izquierda',
    'Vena Subclavia Derecha',
    'Vena Subclavia Izquierda',
  ];
  static List<String> sitiosSondaPleural = [
    'Cuarto Espacio Intercostal Derecho',
    'Cuarto Espacio Intercostal Izquierdo',
    'Quinto Espacio Intercostal Derecho',
    'Quinto Espacio Intercostal Izquierdo',
  ];
  static List<String> sitiosCateterTenckhoff = [
    'Linea Media Infraumbilical',
    'Linea Paramedia Derecha',
  ];
  static List<String> sitiosPuncionLumbar = [
    'L3-L4',
    'L4-L5',
  ];

  static List<String> horasSueno = [
    'Menos de 4 horas',
    'De 4 a 6 horas',
    '6 a 8 Horas',
    'De 6 a 8 Horas',
    'Más de 8 horas',
  ];
  static List<String> dicotomicos = Dicotomicos.dicotomicos();

  static List<String> propiedad = [
    'Propia',
    'Rentada',
  ];

  static List<String> materialesPiso = [
    'Cemento',
    'Madera',
    'Tierra',
    'Azulejo',
  ];
  static List<String> materialesParedes = [
    'Cemento',
    'Madera',
    'Lámina de Zinc',
    'Lámina de Cartón',
    'Ladrillos',
  ];
  static List<String> materialesTecho = [
    'Cemento',
    'Huano',
    'Lámina de Zinc',
    'Lámina de Cartón',
  ];

  static List<String> periodicidad = [
    'Días',
    'Mes',
    'Año',
  ];
  static List<String> tiposAlcoholes = [
    'Cerveza',
    'Ron',
    'Whisky',
    'Tequila',
    'Vodka',
    'Brandy',
    'Vino Tinto',
    'Vino Blanco',
    'Vino Rosado',
    'Ginebra',
    '',
    '',
  ];
  static List<String> tiposTabacos = [
    'Cigarrillos',
    'Puros Cubanos',
    'Cigarrillos Electronicos',
    '',
    '',
  ];
  static List<String> tiposDrogas = [
    'MMDA',
    'Yie',
    'Tusi Rosa',
    'L.S.D.',
    'Cocaína',
    'Metanfetaminas',
    'Cristal',
    '',
    '',
  ];

  static List<String> interaccionesSexuales = [
    'Heterosexual',
    'Bisexual',
    'Homosexual',
    'Asexual'
  ];
  static List<String> metodosPlanificacionFamiliar = [
    'D.I.U.',
    'D.I.U. Hormonal',
    'Implante Sub - Dermico',
    'Hormonales Inyectables',
    'Condon Masculino',
    'Condon Femenino',
    'Diafragma',
    'Oclusion Tubarica Bilateral',
    'Histerectomia'
  ];

  static List<String> tipoInterrogatorio = ['Directo', 'Indirecto'];

  static List<String> estadoGeneral = [
    'Asintomático',
    'Dolor localizado',
    'Dolor generalizado'
  ];
  static List<String> viaOralAlimentacion = [
    'Ayuno',
    'Dieta líquida',
    'Dieta blanda',
    'Dieta completa'
  ];
  static List<String> uresisCantidad = [
    'Menor a 2 veces',
    'Entre 2 - 4 veces',
    'Mayor a 4 veces'
  ];
  static List<String> excretasCantidad = [
    'Menor a 2 veces',
    'Entre 2 - 4 veces',
    'Mayor a 4 veces'
  ];
  static List<String> typesLicencias = [
    'Enfermedad General',
  ];
  static List<String> lugarExpedicion = [
    'Consulta Externa',
    'Hospitalización',
    'Urgencias',
  ];
  static List<String> caracterLicencia = [
    'Inicial',
    'Subsecuente',
    'Maternidad Inicial',
    'Maternidad Subsecuente',
    'Retroactiva'
  ];

  static List<String> get orderOfCamas {
    List<String> list = [];
    list.add('N/A');
    list.addAll(Listas.listOfRange(maxNum: 100));
    return list;
  }

  static List<String> Hemotipo = [
    '',
    'Desconoce',
    'O +',
    'O -',
    'A +',
    'A -',
    'B +',
    'B -',
    'AB +',
    'AB -',
    // 'Hemotipo O Grupo Rh Positivo',
    // 'Hemotipo O Grupo Rh Negativo',
    // 'Hemotipo A Grupo Rh Positivo',
    // 'Hemotipo A Grupo Rh Negativo',
    // 'Hemotipo B Grupo Rh Positivo',
    // 'Hemotipo B Grupo Rh Negativo',
    // 'Hemotipo AB Grupo Rh Positivo',
    // 'Hemotipo AB Grupo Rh Negativo',
  ];

  static List ordinales = [
    "Primer",
    "Segundo",
    "Tercer",
    "Cuarto",
    "Quinto",
    "Sexto",
    "Séptimo",
    "Octavo",
    "Noveno",
    "Décimo",
    "Décimo Primer",
    "Décimo Segundo",
    "Décimo Tercer",
    "Décimo Cuarto",
    "Décimo Quinto",
    "Décimo Sexto",
    "Décimo Séptimo",
    "Décimo Octavo",
    "Décimo Noveno",
    "Vigésimo",
    "Vigésimo Primer",
    "Vigésimo Segundo",
    "Vigésimo Tercer",
    "Vigésimo Cuarto",
    "Vigésimo Quinto",
    "Vigésimo Sexto",
    "Vigésimo Séptimo",
    "Vigésimo Octavo",
    "Vigésimo Noveno",
    "Trigésimo",
    "Trigésimo Primer",
    "Trigésimo Segundo",
    "Trigésimo Tercer",
    "Trigésimo Cuarto",
    "Trigésimo Quinto",
    "Trigésimo Sexto",
    "Trigésimo Séptimo",
    "Trigésimo Octavo",
    "Trigésimo Noveno",
    "Cuadragésimo",
    "Cuadragésimo Primer",
    "Cuadragésimo Segundo",
    "Cuadragésimo Tercer",
    "Cuadragésimo Cuarto",
    "Cuadragésimo Quinto",
    "Cuadragésimo Sexto",
    "Cuadragésimo Séptimo",
    "Cuadragésimo Octavo",
    "Cuadragésimo Noveno",
    "Quincuagésimo ",
    "Quincuagésimo Primer",
    "Quincuagésimo Segundo",
    "Quincuagésimo Tercer",
    "Quincuagésimo Cuarto",
    "Quincuagésimo Quinto",
    "Quincuagésimo Sexto",
    "Quincuagésimo Séptimo",
    "Quincuagésimo Octavo",
    "Quincuagésimo Noveno",
    "Sexagésimo",
    "Sexagésimo Primer",
    "Sexagésimo Segundo",
    "Sexagésimo Tercer",
    "Sexagésimo Cuarto",
    "Sexagésimo Quinto",
    "Sexagésimo Sexto",
    "Sexagésimo Séptimo",
    "Sexagésimo Octavo",
    "Sexagésimo Noveno",
    "Septuagésimo",
    "Septuagésimo Primer",
    "Septuagésimo Segundo",
    "Septuagésimo Tercer",
    "Septuagésimo Cuarto",
    "Septuagésimo Quinto",
    "Septuagésimo Sexto",
    "Septuagésimo Séptimo",
    "Septuagésimo Octavo",
    "Septuagésimo Noveno",
    "Octogésimo ",
    "Octogésimo Primer",
    "Octogésimo Segundo",
    "Octogésimo Tercer",
    "Octogésimo Cuarto",
    "Octogésimo Quinto",
    "Octogésimo Sexto",
    "Octogésimo Séptimo",
    "Octogésimo Octavo",
    "Octogésimo Noveno",
    "Nonagésimo",
    "Nonagésimo Primer",
    "Nonagésimo Segundo",
    "Nonagésimo Tercer",
    "Nonagésimo Cuarto",
    "Nonagésimo Quinto",
    "Nonagésimo Sexto",
    "Nonagésimo Séptimo",
    "Nonagésimo Octavo",
    "Nonagésimo Noveno",
    "Nonagésimo"
  ];
}

double toDoubleFromInt(
    {required Map<String, dynamic> json, required String keyEntered}) {
  return double.parse(
      json[keyEntered] != null ? json[keyEntered].toString() : '0');
}

isNull(value) {
  print("Is Value method : : ${value.runtimeType} \n"
      " : : : $value");

  if (value.runtimeType.toString() == "String") {
    if (value == null || value == 'null' || value == '') {
      return '';
    } else {
      return value;
    }
  } else if (value.runtimeType == 'int') {
    return 0.0;
  } else {
    return value;
  }
}

enum sitiosPuncionLumbar {
  l3l4(''),
  l4l5('');

  const sitiosPuncionLumbar(this.sitio);
  final String sitio;
}
