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
      imagenUsuario,
      sexo,
      fechaNacimiento,
      telefono,
      curp,
      rfc,
      modoAtencion;
  static int? edad, numeroCama;
  static bool? isHospitalizado;
  static int get diasEstancia {
    if (fechaIngresoHospitalario != '' && fechaIngresoHospitalario != null) {
      print(fechaIngresoHospitalario!);
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
  static int? tensionArterialSystolica,
      tensionArterialDyastolica,
      frecuenciaCardiaca,
      frecuenciaRespiratoria,
      saturacionPerifericaOxigeno,
      glucemiaCapilar,
      horasAyuno,
      circunferenciaCintura,
      circunferenciaCadera,
      circunferenciaCuello,
      circunferenciaMesobraquial,
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
  static double? eritrocitos,
      hemoglobina,
      hematocrito,
      leucocitosTotales,
      linfocitosTotales,
      neutrofilosTotales,
      monocitosTotales;
  //
  static double? glucosa, urea, creatinina, acidoUrico;
  //
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
  static String? fechaGasometriaVenosa,
      fechaGasometriaArterial;
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
  static double? intervaloRR,
      duracionOndaP,
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
      rV1,
      sV6,
      sV1,
      rV6,
      rAvL,
      sV3,
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

  // Variables Estaticas
  static int? constanteRequerimientos = 30;
  static int porcentajeCarbohidratos = 50;
  static int porcentajeLipidos = 20;
  static int porcentajeProteinas = 30;
  static int presionBarometrica = 760;
  static double pi = 3.14159265;
  // Variables de Procedimientos
  static String? motivoProcedimiento;
  static String? sitiosCateterCentral,
      sitiosSondaPleural,
      sitiosCateterTenckhoff;
  static String? complicacionesProcedimiento;
  static String? pendientesProcedimiento;
  // Variables de Valoraciones
  static String? valoracionAsa, valoracionBromage, valoracionNyha;
  // Variables de la situación hospitalaria
  static String? dispositivoOxigeno = Items.dispositivosOxigeno[0];
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
    //
    Vitales.registros();
    Vitales.ultimoRegistro();
    Patologicos.registros();
    Patologicos.consultarRegistro();

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
    Pacientes.diagnosticos();
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
    valores.addAll(aux);
    final elect = await Actividades.consultarId(
        Databases.siteground_database_reggabo,
        Electrocardiogramas.electrocardiogramas['consultLastQuery'],
        Pacientes.ID_Paciente,
        emulated: true);
    valores.addAll(elect);

    final vento = await Actividades.consultarId(
        Databases.siteground_database_reghosp,
        Ventilaciones.ventilacion['consultLastQuery'],
        Pacientes.ID_Paciente,
        emulated: true);
    valores.addAll(vento);

    final hosp = await Actividades.consultarId(
        Databases.siteground_database_reghosp,
        Hospitalizaciones.hospitalizacion['consultLastQuery'],
        Pacientes.ID_Paciente,
        emulated: true);
    valores.addAll(hosp);

    //valores.map((key, value) => value = null);
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
    imagenUsuario = json['Pace_FIAT'];
    Pacientes.imagenPaciente = json['Pace_FIAT'];
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
    } else if (modoAtencion == 'Consulta Externa') {
      isHospitalizado = false;
    } else {
      isHospitalizado = false;
    }
    //
    pesoCorporalTotal = double.parse(
        json['Pace_SV_pct'] != null ? json['Pace_SV_pct'].toString() : '0');
    alturaPaciente = json['Pace_SV_est'] ?? 0.0;

    tensionArterialSystolica = json['Pace_SV_tas'] ?? 0;
    tensionArterialDyastolica = json['Pace_SV_tad'] ?? 0;
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
    eritrocitos = double.parse(json['Eritrocitos'] ?? '0');
    hematocrito = double.parse(json['Hematocrito'] ?? '0');
    hemoglobina = double.parse(json['Hemoglobina'] ?? '0');
    hematocrito = double.parse(json['Hematocrito'] ?? '0');

    leucocitosTotales = double.parse(json['Leucocitos_Totales'] ?? '0');
    neutrofilosTotales = double.parse(json['Neutrofilos_Totales'] ?? '0');
    linfocitosTotales = double.parse(json['Linfocitos_Totales'] ?? '0');
    monocitosTotales = double.parse(json['Monocitos_Totales'] ?? '0');
    //
    glucosa = double.parse(json['Glucosa'] ?? '0');
    urea = double.parse(json['Urea'] ?? '0');
    creatinina = double.parse(json['Creatinina'] ?? '0');
    acidoUrico = double.parse(json['Acido_Urico'] ?? '0');
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
    pHArteriales = double.parse(json['Ph_Arterial'] ?? '0');
    pcoArteriales = double.parse(json['Pco_Arterial'] ?? '0');
    poArteriales = double.parse(json['Po_Arterial'] ?? '0');
    bicarbonatoArteriales = double.parse(json['Hco_Arterial'] ?? '0');
    excesoBaseArteriales = double.parse(json['Eb_Arterial'] ?? '0');
    fioArteriales = double.parse(json['Fio_Arterial'] ?? '0');
    soArteriales = double.parse(json['So_Arterial'] ?? '0');
    // pHArteriales  = double.parse(json['Ph_Arterial'] ?? '0');
    pHVenosos = double.parse(json['Ph_Venosa'] ?? '0');
    pcoVenosos = double.parse(json['Pco_Venosa'] ?? '0');
    poVenosos = double.parse(json['Po_Venosa'] ?? '0');
    bicarbonatoVenosos = double.parse(json['Hco_Venosa'] ?? '0');
    fioVenosos = double.parse(json['Fio_Venosa'] ?? '0');
    soVenosos = double.parse(json['So_Venosa'] ?? '0');
    //
    fechaElectrocardiograma = json['Pace_GAB_EC_Feca'] ?? '';
    ritmoCardiaco = json['Pace_EC_rit'] ?? '';
    intervaloRR = json['Pace_EC_rr'] == null ? json['Pace_EC_rr'] : 0;
    duracionOndaP = json['Pace_EC_dop'] == null ? json['Pace_EC_dop'] : 0;
    alturaOndaP = json['Pace_EC_aop'] == null ? json['Pace_EC_aop'] : 0;
    duracionPR = json['Pace_EC_dpr'] == null ? json['Pace_EC_dpr'] : 0;
    duracionQRS = json['Pace_EC_dqrs'] == null ? json['Pace_EC_dqrs'] : 0;
    alturaQRS = json['Pace_EC_aqrs'] == null ? json['Pace_EC_aqrs'] : 0;
    QRSi = json['Pace_EC_qrsi'] == null ? json['Pace_EC_qrsi'] : 0;
    QRSa = json['Pace_EC_qrsa'] == null ? json['Pace_EC_qrsa'] : 0;
    //
    ejeCardiaco = double.parse(
        json['Pace_QRS'] != '' && json['Pace_QRS'] != null
            ? json['Pace_QRS']
            : '0');
    //
    segmentoST = json['Pace_EC_st'] ?? '';
    alturaSegmentoST = json['Pace_EC_ast_'] == null ? json['Pace_EC_ast_'] : 0;
    duracionQT = json['Pace_EC_dqt'] == null ? json['Pace_EC_dqt'] : 0;
    duracionOndaT = json['Pace_EC_dot'] == null ? json['Pace_EC_dot'] : 0;
    alturaOndaT = json['Pace_EC_aot'] == null ? json['Pace_EC_aot'] : 0;

    //
    rV1 = json['EC_rV1'] == null ? json['EC_rV1'] : 0;
    sV6 = json['EC_sV6'] == null ? json['EC_sV6'] : 0;
    sV1 = json['EC_sV1'] == null ? json['EC_sV1'] : 0;
    rV6 = json['EC_rV6'] == null ? json['EC_rV6'] : 0;
    rAvL = json['EC_rAVL'] == null ? json['EC_rAVL'] : 0;
    sV3 = json['EC_sV3'] == null ? json['EC_sV3'] : 0;
    //
    patronQRS = json['PatronQRS'] ?? '';
    deflexionIntrinsecoide = json['DeflexionIntrinsecoide'] == null
        ? json['DeflexionIntrinsecoide']
        : 0;

    rDI = json['EC_rDI'] == null ? json['EC_rDI'] : 0;
    sDI = json['EC_sDI'] == null ? json['EC_sDI'] : 0;
    rDIII = json['EC_rDIII'] == null ? json['EC_rDIII'] : 0;
    sDIII = json['EC_sDIII'] == null ? json['EC_sDIII'] : 0;

    conclusionElectrocardiograma = json['Pace_EC_CON'] ?? '';
    //
    fechaVentilaciones = json['Feca_VEN'] ?? '';
    modalidadVentilatoria = json['VM_Mod'] ?? '';
    frecuenciaVentilatoria = json['Pace_Fr'] == null ? json['Pace_Fr'] : 0;
    fraccionInspiratoriaVentilatoria =
        json['Pace_Fio'] == null ? json['Pace_Fio'] : 0;
    presionFinalEsiracion = json['Pace_Peep'] == null ? json['Pace_Peep'] : 0;
    sensibilidadInspiratoria =
        json['Pace_Insp'] == null ? json['Pace_Insp'] : 0;
    sensibilidadEspiratoria = json['Pace_Espi'] == null ? json['Pace_Espi'] : 0;
    presionControl = json['Pace_Pc'] == null ? json['Pace_Pc'] : 0;
    presionMaxima = json['Pace_Pm'] == null ? json['Pace_Pm'] : 0;

    volumenVentilatorio = json['Pace_V'] == null ? json['Pace_V'] : 0;
    flujoVentilatorio = json['Pace_F'] == null ? json['Pace_F'] : 0;
    presionSoporte = json['Pace_Ps'] == null ? json['Pace_Ps'] : 0;
    presionInspiratoriaPico = json['Pace_Pip'] == null ? json['Pace_Pip'] : 0;
    presionPlateau = json['Pace_Pmet'] == null ? json['Pace_Pmet'] : 0;
    volumenTidal = json['Pace_Vt'] == null ? json['Pace_Vt'] : 0;

    // Datos generales de la última Hospitalización.
    Pacientes.ID_Hospitalizacion = json['ID_Hosp'] ?? 0;
    // ******************************************** *** *
    Valores.fechaIngresoHospitalario = json['Feca_INI_Hosp'] ?? '';
    // Valores.diasEstancia = json['Dia_Estan'] == null ? json['Dia_Estan'] : 0;
    Valores.numeroCama = json['Id_Cama'] == null ? json['Id_Cama'] : 0;
    Valores.medicoTratante = json['Medi_Trat'] ?? '';
    Valores.servicioTratante = json['Serve_Trat'] ?? '';
    Valores.servicioTratanteInicial = json['Serve_Trat_INI'] ?? '';
    Valores.fechaEgresoHospitalario = json['Feca_EGE_Hosp'] ?? '';
    Valores.motivoEgreso = json['EGE_Motivo'] ?? '';

    print("Valores.gastoCardiaco ${Valores.gastoCardiaco}");
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
      return "Sodio Corregido: ${Valores.sodioCorregidoGlucosa} mEq/L. \n";
    } else {
      return "\n";
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
      return (Valores.pesoCorporalTotal! * (Valores.potasio! - 4));
    } else {
      return double.nan;
    }
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
      return 0.00;
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
      (math.pow((Valores.pesoCorporalTotal! * (Valores.alturaPaciente!)), 0.5) /
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
      return gastoEnergeticoBasal * Valores.factorActividad! +
          efectoTermicoAlimentos;
    } else if (Valores.factorActividad! != 0 && Valores.factorEstres! != 0) {
      return gastoEnergeticoBasal *
          (Valores.factorActividad!) *
          (Valores.factorEstres!);
    } else {
      return 0.0;
    }
  }

  static double get glucosaPorcentaje =>
      ((gastoEnergeticoTotal / 100) * (porcentajeCarbohidratos));
  static double get lipidosPorcentaje =>
      ((gastoEnergeticoTotal / 100) * (porcentajeLipidos));
  static double get proteinasPorcentaje =>
      ((gastoEnergeticoTotal / 100) * (porcentajeProteinas));

  static double get glucosaGramos => (glucosaPorcentaje / 4.0);
  static double get lipidosGramos => (lipidosPorcentaje / 9.0);
  static double get proteinasGramos => (proteinasPorcentaje / 4.0);

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

  // # Parametros Hemodinamicos
  // # Concentración Arterial de Oxígeno
  static double get CAO =>
      (((Valores.hemoglobina! * 1.34) * Valores.soArteriales!) +
          (Valores.poArteriales! * 0.031)) /
      (100); //  # Concentración Arterial de Oxígeno
  // # Concentración Venosa de Oxígeno
  static double get CVO =>
      (((Valores.hemoglobina! * 1.34) * Valores.soVenosos!) +
          (Valores.poVenosos! * 0.031)) /
      (100); // # Concentración Venosa de Oxígeno
  // # Concentración Capilar de Oxígeno
  static double get CCO => (((Valores.hemoglobina! * 1.34) *
              (Valores.soVenosos! - Valores.soArteriales!) +
          ((Valores.poVenosos! - Valores.poArteriales!) * 0.031)) /
      (100)); // # Concentración Capilar de Oxígeno
  static double get DAV => (CAO - CVO); // # Diferencia Arteriovenosa
  static double get capacidadOxigeno =>
      (Valores.hemoglobina! * (1.36)); //  # Capacidad de Oxígeno
  // # Gasto Cardiaco
  static double get gastoCardiaco {
    if (DAV != null && DAV != 0) {
      return (((DAV * 100) / CAO) / (DAV)); // # Gasto Cardiaco
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
    if (Valores.excesoBaseArteriales! < -3) {
      return 'Consumo de Bases'; // Acidosis
    } else if (Valores.poArteriales! > 3) {
      return 'Retención de Bases'; // Alcalosis
    } else {
      return 'Normal';
    }
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
    return (Valores.fioArteriales! / 100) * (760 - 47) -
        (Valores.pcoArteriales! / 0.8); // # Presión alveolar de oxígeno
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
  static double get CI =>
      (Valores.pcoArteriales! * Valores.frecuenciaVentilatoria!) / 40.00;

  // # ######################################################
  // # Análisis de pCO2 / pO2
  // # ######################################################
  static double get indiceTobinYang =>
      (Valores.frecuenciaVentilatoria! / Valores.volumenTidal!);

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

  static double get VL =>
      (indiceCardiaco / Valores.frecuenciaCardiaca!) *
      1000; //  # Volumen Latido De Litros a mL
  static double get IVL => ((indiceCardiaco * 1000) /
      Valores
          .frecuenciaCardiaca!); //mL/Lat/m2 *IC se multiplica por 1000 para ajustar unidades a mL/min/m2
  static double get DO =>
      ((gastoCardiaco * CAO) * (10)); // # Disponibilidad de Oxígeno
  static double get TO =>
      ((capacidadOxigeno * CAO) / (10)); // # Transporte de Oxígeno // CAP_O
  static double get SF =>
      ((CCO - CAO) / (CCO - CAO)) * (100); //  # Shunt Fisiológico
  static double get CO =>
      ((gastoCardiaco * DAV) * (10)); // # Consumo de Oxígeno

  static double get presionColoidoOsmotica => // PC
      ((Valores.proteinasTotales! - Valores.albuminaSerica!) * 1.4) +
      (Valores.albuminaSerica! * 5.5); //  # Presión Coloidóncotica
  static double get TC => (gastoCardiaco *
      Valores.presionArterialMedia *
      0.0144); // # Trabajo Cardiaco
  static double get TLVI =>
      gastoCardiaco *
      Valores.presionArterialMedia *
      0.0144; //  # Trabajo Latido Ventricular Izquierdo
  static double get TLVD => 00.00; //  # Trabajo Latido Ventricular Derecho
  // # FE = VL / VDF # FE(%)= ((VDF-VSF)*100)/VDF. (porque VL= VDF-VSF). (%)
  static double get FE => 0.0;

  // Parámetros de Electrocardiogramas
  static double get indiceSokolowLyon {
    if (Valores.sV1 != 0 &&
        Valores.sV1 != null &&
        Valores.rV6 != 0 &&
        Valores.rV6 != null) {
      return (Valores.sV1! + Valores.rV6!);
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
      return (Valores.rAvL! + Valores.sV3!);
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
      "ANALISIS ANTROPOMÉTRICO ENFOCADO A RIESGO - "
      "Pliegue Cutáneo Trícipital: ${Valores.pliegueCutaneoTricipital} mm, "
      "Circunferencia Mesobraquial: ${Valores.circunferenciaMesobraquial} cm, "
      "Perimetro Muscular Mesobraquial: ${Valores.perimetroMesobraquial} cm, "
      "Área Muscular Mesobraquial: ${Valores.AM} cm2, "
      "Área Adiposa Mesobraquial: ${Valores.areaAdiposaMesobraquial} cm2, "
      "Área Mesobraquial: ${Valores.areaMesobraquial} cm2. \n";

  static String get antropometricos => "Análisis de Medidas Corporales -  "
      "Peso Corporal Ideal: ${Valores.pesoCorporalPredicho.toStringAsFixed(2)} Kg, (${Valores.PCIP.toStringAsFixed(2)} %), "
      "Peso Corporal Ajustado: ${Valores.pesoCorporalAjustado.toStringAsFixed(2)} Kg, "
      "Exceso de Peso Corporal: ${Valores.excesoPesoCorporal.toStringAsFixed(2)} Kg, "
      "Indice de Masa Corporal: ${Valores.imc.toStringAsFixed(2)} Kg/m2. (${Valores.claseIMC}). "
      "Peso Corporal Blanco: ${Valores.PCB_25.toStringAsFixed(2)} Kg, "
      "Peso Corporal Blanco (I.M.C. 30): ${Valores.PCB_30.toStringAsFixed(2)} Kg. "
      "Superficie Corporal Total: ${Valores.SC.toStringAsFixed(2)} m2 "
      "Relacion Cintura : Cadera ${Valores.indiceCinturaCadera.toStringAsFixed(2)} cm. \n"
      "Grasa Corporal: ${Valores.grasaCorporalEsencial.toStringAsFixed(2)} Kg, "
      "Grasa Corporal Porcentual: ${Valores.grasaCorporalEsencial.toStringAsFixed(2)} %, "
      "Peso Corporal Magro: ${Valores.porcentajeCorporalMagro.toStringAsFixed(2)} Kg. \n";
  static String get metabolometrias =>
      "Análisis Energético - Gasto Energetico Basal: ${Valores.gastoEnergeticoBasal.toStringAsFixed(2)} kCal/dia "
      "(Factor de Actividad: ${Valores.factorActividad}; "
      "Factor de Estres: ${Valores.factorEstres}); "
      "Metabolismo Basal: ${Valores.metabolismoBasal.toStringAsFixed(2)} kCal/m2/hr, "
      "Efecto Termico de los Alimentos: ${Valores.efectoTermicoAlimentos.toStringAsFixed(2)} kCal/m2/hr. "
      "Gasto Energetico Total: ${Valores.gastoEnergeticoTotal.toStringAsFixed(2)} kCal/dia. \n";

  static String get renales => "Tasa de Filtrado Glomerular - "
      "${Valores.tasaRenalCrockoft_Gault.toStringAsFixed(2)} mL/min/1.73 m2 (Cockcroft - Gault), "
      "${Valores.tasaRenalMDRD.toStringAsFixed(2)} mL/min/1.73 m2 (M.D.R.D. 4), "
      "${Valores.tasaRenalCKDEPI.toStringAsFixed(2)} mL/min/1.73 m2 (C.K.D. E.P.I.); "
      "Clasificación (Estadio) ${Valores.claseTasaRenal} (KDOQI / KDIGO).\n";

  static String get hidricos =>
      "Requerimiento hídrico diario: ${Valores.requerimientoHidrico.toStringAsFixed(2)} mL/dia (${Valores.constanteRequerimientos} mL/Kg/dia), "
      "Agua corporal total: ${Valores.aguaCorporalTotal.toStringAsFixed(2)} mL, "
      "Delta H2O: ${Valores.excesoAguaLibre} L, "
      "Deficit de agua corporal: ${Valores.deficitAguaCorporal} L. "
      "Osmolaridad: ${Valores.osmolaridadSerica} mOsm/L, "
      "Brecha osmolar: ${Valores.brechaOsmolar} mOsm/L. "
      "${Valores.sodioCorregido} ${Valores.requerimientoPotasio} "
      "Delta potasio: ${Valores.deficitSodio} mEq/L: ${Valores.deltaPotasio}";
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

  static List<dynamic> serviciosHospitalarios = [];
  static List<String> motivosEgresos = [
    '',
    'Máximo beneficio',
    'Mejorado',
    'Traslado',
    'Alta voluntaria',
    'Defunción',
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
  static List<String> tiposAnalisis = ['Padecimiento Actual'];

  static List<String> dispositivosOxigeno = ['', 'Puntas nasales'];

  static List<String> dicotomicos = Dicotomicos.dicotomicos();
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

