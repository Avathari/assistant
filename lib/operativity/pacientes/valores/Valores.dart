import 'dart:async';
import 'dart:math' as math;
import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/cardiometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/gasometricos.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/hidrometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/metabolometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/renometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/ventometr%C3%ADas.dart';
import 'package:assistant/operativity/pacientes/valores/semiologia/semiotica.dart';

import 'package:assistant/conexiones/conexiones.dart';

class Valores {
  bool loading = false;
  Map<String, dynamic> valores = {};
  static double? prueba;

// ******* **** ****** ** * * * * * ** ***** **** *
  Future<bool> load() async {
    // Otras configuraciones
    Escalas.serviciosHospitalarios = await Archivos.listFromText(
        path: 'assets/diccionarios/Servicios.txt', splitChar: ',');
    //
    Terminal.printWarning(message: "INICIADO Valores.load : : ");
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
    // Patologicos.consultarRegistro();
    Diagnosticos.registros();
    // Diagnosticos.consultarRegistro();
    Alergicos.registros();
    // Alergicos.consultarRegistro();
    Quirurgicos.registros();
    // Quirurgicos.consultarRegistro();
    Transfusionales.registros();
    // Transfusionales.consultarRegistro();
    Traumatologicos.registros();
    // Traumatologicos.consultarRegistro();
    Vacunales.registros();
    // Vacunales.consultarRegistro();

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
        Pacientes.getAuxiliaryStats(Pacientes.ID_Paciente),
        Pacientes.ID_Paciente,
        emulated: true);

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

    // final hosp = await Actividades.consultarId(
    //     Databases.siteground_database_reghosp,
    //     Hospitalizaciones.hospitalizacion['consultLastQuery'],
    //     Pacientes.ID_Paciente,
    //     emulated: true);
    // valores.addAll(hosp);

    Situaciones.ultimoRegistro();
    Expedientes.ultimoRegistro();

    Valores.fromJson(valores);
    return true;
  }

  Future<bool> loadWithoutRegisters() async {
    // Otras configuraciones
    Escalas.serviciosHospitalarios = await Archivos.listFromText(
        path: 'assets/diccionarios/Servicios.txt', splitChar: ',');
    //
    valores.addAll(Pacientes.Paciente);
    // ********* *********** ********** ******
    Pacientes.getImage();
    // ********* *********** ********** ******

    // ********* *********** ********** ******

// ********* *********** ********** ******
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

    Situaciones.ultimoRegistro();
    Expedientes.ultimoRegistro();

    Valores.fromJson(valores);
    return true;
  }

  Valores.fromJson(Map<String, dynamic> json) {
    Terminal.printWarning(
        message: "INICIADO Valores.fromJson : : ${json.keys}");

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
    if (modoAtencion == 'Hospitalización' ||
        modoAtencion == 'Otra Hospitalización') {
      isHospitalizado = true;
      // Consultar Último Registro de Hospitalización **************************************
      Hospitalizaciones.ultimoRegistro();
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
    anchoDistribucionEritrocitaria = double.parse(json['RDW'] ?? '0');

    plaquetas = double.parse(json['Plaquetas'] ?? '0');

    leucocitosTotales = double.parse(json['Leucocitos_Totales'] ?? '0');
    neutrofilosTotales = double.parse(json['Neutrofilos_Totales'] ?? '0');
    linfocitosTotales = double.parse(json['Linfocitos_Totales'] ?? '0');
    monocitosTotales = double.parse(json['Monocitos_Totales'] ?? '0');
    //
    fechaQuimicas = json['Fecha_Registro_Quimicas'] ?? '';
    glucosa = double.parse(json['Glucosa'] ?? '0');
    urea = double.parse(json['Urea'] ?? '0');
    creatinina = double.parse(json['Creatinina'] ?? '0');
    acidoUrico = double.parse(json['Acido_Urico'] ?? '0');
    nitrogenoUreico = double.parse(json['Nitrogeno_Ureico'] ?? '0');

    //
    tiempoProtrombina = double.parse(json['Tiempo_Protrombina'] ?? '0');
    tiempoTromboplastina = double.parse(json['TP_Tromboplastina'] ?? '0');
    INR = double.parse(json['Normalized_Ratio'] ?? '0');
    //
    fechaElectrolitos = json['Fecha_Registro_Electrolitos'] ?? '';
    sodio = double.parse(json['Sodio'] ?? '0');
    potasio = double.parse(json['Potasio'] ?? '0');
    cloro = double.parse(json['Cloro'] ?? '0');
    magnesio = double.parse(json['Magnesio'] ?? '0');
    fosforo = double.parse(json['Fosforo'] ?? '0');
    calcio = double.parse(json['Calcio'] ?? '0');
    //
    fechaHepaticos = json['Fecha_Registro_Hepaticos'] ?? '';
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
    fechaReactantes = json['Fecha_Registro_Reactantes'] ?? '';
    procalcitonina = double.parse(json['Procalcitonina'] ?? '0');
    lactato = double.parse(json['Acido_Lactico'] ?? '0');
    velocidadSedimentacionGlobular =
        double.parse(json['Velocidad_Sedimentacion'] ?? '0');
    proteinaCreactiva = double.parse(json['Proteina_Reactiva'] ?? '0');
    factorReumatoide = double.parse(json['Factor_Reumatoide'] ?? '0');
    anticuerpoCitrulinado = double.parse(json['Anticuerpo_Citrulinado'] ?? '0');
    //
    fechaGasometriaArterial = json['Fecha_Registro_Arterial'] ?? '';
    pHArteriales = double.parse(json['Ph_Arterial'] ?? '0');
    pcoArteriales = double.parse(json['Pco_Arterial'] ?? '0');
    poArteriales = double.parse(json['Po_Arterial'] ?? '0');
    bicarbonatoArteriales = double.parse(json['Hco_Arterial'] ?? '0');
    excesoBaseArteriales = double.parse(json['Eb_Arterial'] ?? '0');
    fioArteriales = double.parse(json['Fio_Arterial'] ?? '0');
    soArteriales = double.parse(json['So_Arterial'] ?? '0');
    //
    fechaGasometriaVenosa = json['Fecha_Registro_Venosa'] ?? '';
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
    ejeCardiaco = double.parse(json['Pace_QRS'] ?? '0.0');
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
    // VENTILACIONES
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

    Exploracion.tuboEndotraqueal = json['Pace_TET'] ?? '';
    Exploracion.haciaArcadaDentaria = json['Pace_DAC'] ?? '';

    // Balances Hídricos ******************************************** * *** *
    // Balances.ID_Balances = json['ID_Bala'];
    // Valores.fechaRealizacionBalances = json['Pace_bala_Fecha'];
    //
    // Valores.viaOralBalances =
    //     double.parse(json['Pace_bala_Oral'].toString() ?? '0');
    // Valores.sondaOrogastricaBalances =
    //     double.parse(json['Pace_bala_Sonda'].toString() ?? '0');
    // Valores.hemoderivadosBalances =
    //     double.parse(json['Pace_bala_Hemo'].toString() ?? '0');
    // Valores.nutricionParenteralBalances =
    //     double.parse(json['Pace_bala_NPT'].toString() ?? '0');
    // Valores.parenteralesBalances =
    //     double.parse(json['Pace_bala_Sol'].toString() ?? '0');
    // Valores.dilucionesBalances =
    //     double.parse(json['Pace_bala_Dil'].toString() ?? '0');
    // Valores.otrosIngresosBalances =
    //     double.parse(json['Pace_bala_ING'].toString() ?? '0');
    //
    // Valores.uresisBalances =
    //     double.parse(json['Pace_bala_Uresis'].toString() ?? '0');
    // Valores.evacuacionesBalances =
    //     double.parse(json['Pace_bala_Evac'].toString() ?? '0');
    // Valores.sangradosBalances =
    //     double.parse(json['Pace_bala_Sangrado'].toString() ?? '0');
    // Valores.succcionBalances =
    //     double.parse(json['Pace_bala_Succion'].toString() ?? '0');
    // Valores.drenesBalances =
    //     double.parse(json['Pace_bala_Drenes'].toString() ?? '0');
    // Valores.otrosEgresosBalances =
    //     double.parse(json['Pace_bala_ENG'].toString() ?? '0');
    // Valores.tipoSondaVesical = json['Pace_Foley'] ?? '';
    //
    // Valores.horario = json['Pace_bala_HOR'];
    // Valores.uresis = double.parse(json['Pace_bala_Uresis'].toString() ?? '0');
    // Datos generales de la última Hospitalización. **** ** *********** ****** * *** *
    Pacientes.ID_Hospitalizacion = json['ID_Hosp'] ?? 0;
    Hospitalizaciones.Hospitalizacion['ID_Hosp'] = Pacientes.ID_Hospitalizacion;
    // ******************************************** *** *
    Valores.fechaIngresoHospitalario = json['Feca_INI_Hosp'] ?? '';
    Hospitalizaciones.Hospitalizacion['Feca_INI_Hosp'] =
        Valores.fechaIngresoHospitalario;
    Valores.numeroCama = json['Id_Cama'].toString() ?? 'N/A';
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

  // ******* **** ****** ** * * * * * ** ***** **** *
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
      modoAtencion,
      numeroCama;
  static int? edad;
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
  static double? viaOralBalances = 0,
      sondaOrogastricaBalances = 0,
      hemoderivadosBalances = 0,
      nutricionParenteralBalances = 0,
      parenteralesBalances = 0,
      dilucionesBalances = 0,
      otrosIngresosBalances = 0;
  static double? uresisBalances = 0,
      evacuacionesBalances = 0,
      sangradosBalances = 0,
      succcionBalances = 0,
      drenesBalances = 0,
      otrosEgresosBalances = 0;
  static double? uresis = 0;
  static int? horario = 24;

  //
  static String? fechaBiometria;
  static double? eritrocitos,
      hemoglobina,
      hematocrito,
      concentracionMediaHemoglobina,
      volumenCorpuscularMedio,
      hemoglobinaCorpuscularMedia,
      anchoDistribucionEritrocitaria,
      plaquetas,
      leucocitosTotales,
      linfocitosTotales,
      neutrofilosTotales,
      monocitosTotales;

  // PANEL FERRICO
  static double? ferritinaSerica, transferrinaSerica, hierroSerico;
  //
  static String? fechaQuimicas;
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
  static double? tiempoProtrombina, tiempoTromboplastina, INR;
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
  static String? fechaElectrolitos;
  static double? sodio, potasio, cloro, fosforo, calcio, magnesio;

  //
  static String? fechaReactantes;
  static double? procalcitonina,
      lactato,
      velocidadSedimentacionGlobular,
      proteinaCreactiva,
      factorReumatoide,
      anticuerpoCitrulinado;

  // PARAMETROS ELECTROCARDIOGRAMA
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

  // PARÁMETROS VENTILATORIO
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
  static int presionBarometrica = 585; // mmHg (Nm: 760
  static int presionVaporAgua = 47; // mmHg
  static int presionGasSeco = 536; // mmHg
  static const double pi = 3.14159265;

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

  // Variables del Ordenamiento del Expediente Clínico
  static bool? isPortada = false,
      isHistoriaClinica = false,
      isNotaIngreso = false,
      isEvaluacionInicial = false,
      isValoracionVademecum = false,
      isConsentimientos = false,
      isOrdenado = false;

  //
  Valores();

  static String get nombreCompleto {
    if (Valores.segundoNombre == '' || Valores.segundoNombre == null) {
      return "${Valores.primerNombre} ${Valores.apellidoPaterno} ${Valores.apellidoMaterno}";
    } else {
      return "${Valores.primerNombre} ${Valores.segundoNombre} ${Valores.apellidoPaterno} ${Valores.apellidoMaterno}";
    }
  }

  static String get numeroExpediente =>
      '${Valores.numeroPaciente} ${Valores.agregadoPaciente}';

  // CALCULOS HEMODINAMICOS

  static String get tensionArterialSistemica =>
      '${Valores.tensionArterialSystolica}/${Valores.tensionArterialDyastolica}';

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

  // BALANCES HÍDRICOS
  static double get perdidasInsensibles =>
      ((Valores.pesoCorporalTotal!) * constantePerdidasInsensibles!) *
      Valores.horario!;

  static double get ingresosBalances {
    return Valores.viaOralBalances! +
        Valores.sondaOrogastricaBalances! +
        Valores.hemoderivadosBalances! +
        Valores.nutricionParenteralBalances! +
        Valores.parenteralesBalances! +
        Valores.dilucionesBalances! +
        Valores.otrosIngresosBalances!;
  }

  static double get egresosBalances {
    return Valores.uresisBalances! +
        Valores.evacuacionesBalances! +
        Valores.sangradosBalances! +
        Valores.succcionBalances! +
        Valores.drenesBalances! +
        Valores.perdidasInsensibles +
        Valores.otrosEgresosBalances!;
  }

  static double? constantePerdidasInsensibles = 0.5;

  // # Cociente Respiratorio
  static double get RI => 0.8;

  // # Indice de Volumen Sanguineo
  static double get indiceVolumenSanguineo =>
      Hidrometrias.volumenPlasmatico /
      (1 - Valores.hematocrito!) *
      ((1.1 * Valores.pesoCorporalTotal!) -
          (128 *
              (math.pow(Valores.pesoCorporalTotal!, 2) /
                  math.pow(Valores.alturaPaciente!, 2))));

  static double get indiceCardiaco =>
      (Valores.gastoCardiaco / Antropometrias.SC); // # Indice Cardiaco
  static double get IRVS =>
      (Cardiometrias.presionArterialMedia / Valores.indiceCardiaco);

  static double get RVS =>
      (((Cardiometrias.presionArterialMedia - 12.0) * 80.00) /
          Valores.indiceCardiaco); //  # Resistencias Venosas Sistémicas
  // # (((Valores.presionArterialMedia! - 12.0) / IC) * 79.9)
  static double get IEO =>
      (((DAV / CAO) * 100)); // # Indice de Extracción de Oxígeno
  static double get IV =>
      (Ventometrias.presionMediaViaAerea * Valores.frecuenciaVentilatoria!) *
      (Valores.pcoArteriales! / 10);

  static double get EV {
    if (Valores.pcoArteriales != 0) {
      return (Ventometrias.volumenMinutoIdeal * Valores.pcoArteriales!) /
          ((Ventometrias.volumenMinutoIdeal * 37.5));
    } else if (Valores.pcoArteriales! == 0) {
      return (Ventometrias.volumenMinutoIdeal) /
          ((3.2 * Valores.pesoCorporalTotal!)) *
          (100);
    } else {
      return 0;
    }
  }

  static int get PPI =>
      Valores.presionFinalEsiracion! + Valores.presionSoporte!;

  static int get PPE => Valores.presionFinalEsiracion!;

  static double get CI => (Valores.pcoArteriales! / DAV);

  // (Valores.pcoArteriales! * Valores.frecuenciaVentilatoria!) / 40.00;

  // # Análisis Gasométrico : : de pCO2 / pO2
  static double get indiceTobinYang =>
      (Valores.frecuenciaVentilatoria! / Valores.volumenTidal!) * 100;

  static double get indiceOxigenacion {
    if (Valores.poArteriales! != 0) {
      return (Ventometrias.presionMediaViaAerea *
              (Valores.fioArteriales! / 100)) *
          (100.00) /
          Valores.poArteriales!;
    } else if (Valores.soArteriales != 0) {
      return ((Ventometrias.presionMediaViaAerea *
              (Valores.fioArteriales! / 100)) *
          (100.00) /
          Valores.poArteriales!);
    } //  Indice de Saturación
    else {
      return double.nan;
    }
  }

  static double get FIOV => ((Gasometricos.GAA + 100) / 760) * 100;

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

  static double get VLS => ((Cardiometrias.gastoCardiacoFick * 1000) /
      Valores
          .frecuenciaCardiaca!); //  # Volumen Latido Sistólico De Litros a mL
  static double get IVL => (VLS /
      Antropometrias
          .SCE); //mL/Lat/m2 *IC se multiplica por 1000 para ajustar unidades a mL/min/m2
  // ((indiceCardiaco * 1000) / Valores.frecuenciaCardiaca!);
  static double get DO =>
      ((gastoCardiaco * CAO) * (10)); // # Disponibilidad de Oxígeno
  static double get iDO =>
      (DO / Antropometrias.SCS); // # Indice de Disponibilidad de Oxígeno
  static double get TO =>
      ((capacidadOxigeno * CAO) / (10)); // # Transporte de Oxígeno // CAP_O
  static double get SF =>
      ((CCO - CAO) / (CCO - CVO)) * (100); //  # Shunt Fisiológico
  static double get CO =>
      ((gastoCardiaco * DAV) * (10)); // # Consumo de Oxígeno
  static double get cAO => (CAO / DAV); // # Cociente Arterial de Oxígeno
  static double get cVO => (CVO / DAV); // # Cociente Venoso de Oxígeno

  static double get presionColoidoOsmotica => // PC
      ((Valores.proteinasTotales! - Valores.albuminaSerica!) * 1.4) +
      (Valores.albuminaSerica! * 5.5); //  # Presión Coloidóncotica
  static double get TC => (gastoCardiaco *
      Cardiometrias.presionArterialMedia *
      0.0144); // # Trabajo Cardiaco

  static double get FE => 0.0;

// # Parametros Hemodinamicos ******************************************
  static double get CAO =>
      (((Valores.hemoglobina! * 1.34) * Valores.soArteriales!) +
          (Valores.poArteriales! * 0.031)) /
      (100); //  # Concentración Arterial de Oxígeno
  static double get CVO =>
      (((Valores.hemoglobina! * 1.34) * Valores.soVenosos!) +
          (Valores.poVenosos! * 0.031)) /
      (100); // # Concentración Venosa de Oxígeno
  static double get CCO => ((Valores.hemoglobina! * 1.39) +
      (Valores.poArteriales! * 0.0031)); // # Concentración Capilar de Oxígeno
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
        Antropometrias.pesoCorporalPredicho != 0) {
      return Valores.volumenTidal! ~/ Antropometrias.pesoCorporalPredicho;
    } else {
      return 0;
    }
  }

  //
  static double get balanceTotal {
    if (Valores.ingresosBalances != 0 && Valores.egresosBalances != 0) {
      return (Valores.ingresosBalances -
          (Valores.egresosBalances + Valores.perdidasInsensibles));
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

  static double dummy = 0;

  // Parámetros de Imagenológicos
  static String? fechaEstudioImagenologico;
  static String? regionCorporalImagenologico;
  static String? hallazgosEstudioImagenologico;
  static String? conclusionesImagenologico;

  // # Valoraciones del Riesgo Anestésico
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
      if (Exploracion.valoracionNyha == Escalas.nyha[2]) {
        puntaje = puntaje + 10;
      } else if (Exploracion.valoracionNyha == Escalas.nyha[3]) {
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

  static String get valoracionPorProcedimiento {
    if (Datos.isNullValue(value: Valores.edad)) {
      return '';
    } else {
      return '';
    }
  }

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
}

class Valorados {
  static String get mSOFA {
    String resultado = "";
    int resp = 0, plat = 0, hig = 0, card = 0, glasg = 0, ren = 0;
    // ***************************************************
    if (Gasometricos.PAFI != null) {
      if (Datos.isMiddleValue(value: Gasometricos.PAFI, min: 300, max: 400)) {
        resp = 1;
      } else if (Datos.isMiddleValue(
          value: Gasometricos.PAFI, min: 200, max: 300)) {
        resp = 2;
      } else if (Datos.isMiddleValue(
          value: Gasometricos.PAFI, min: 100, max: 200)) {
        resp = 3;
      } else if (Datos.isInnerValue(value: Gasometricos.PAFI, lim: 200)) {
        resp = 2;
      } else {
        resp = 0;
      }
    } else if (Gasometricos.SAFI != null) {
      if (Datos.isMiddleValue(value: Gasometricos.SAFI, min: 221, max: 301)) {
        resp = 1;
      } else if (Datos.isMiddleValue(
          value: Gasometricos.SAFI, min: 142, max: 220)) {
        resp = 2;
      } else if (Datos.isMiddleValue(
          value: Gasometricos.SAFI, min: 67, max: 141)) {
        resp = 3;
      } else if (Datos.isInnerValue(value: Gasometricos.SAFI, lim: 67)) {
        resp = 2;
      } else {
        resp = 0;
      }
    }
    // ***************************************************
    if (Datos.isMiddleValue(value: Valores.plaquetas, min: 150, max: 300)) {
      plat = 1;
    } else if (Datos.isMiddleValue(
        value: Valores.plaquetas, min: 100, max: 150)) {
      plat = 2;
    } else if (Datos.isMiddleValue(
        value: Valores.plaquetas, min: 50, max: 100)) {
      plat = 3;
    } else if (Datos.isInnerValue(value: Valores.plaquetas!, lim: 20)) {
      plat = 2;
    } else {
      plat = 0;
    }
    // ***************************************************
    if (Datos.isMiddleValue(
        value: Valores.bilirrubinasTotales, min: 1.2, max: 1.9)) {
      hig = 1;
    } else if (Datos.isMiddleValue(
        value: Valores.bilirrubinasTotales, min: 2.0, max: 5.9)) {
      hig = 2;
    } else if (Datos.isMiddleValue(
        value: Valores.bilirrubinasTotales, min: 6.0, max: 11.9)) {
      hig = 3;
    } else if (Datos.isUpperValue(
        value: Valores.bilirrubinasTotales!, lim: 12)) {
      hig = 2;
    } else {
      hig = 0;
    }
    // ***************************************************
    if (Datos.isMiddleValue(value: Valores.creatinina, min: 1.2, max: 1.9)) {
      ren = 1;
    } else if (Datos.isMiddleValue(
        value: Valores.creatinina, min: 2.0, max: 3.4)) {
      ren = 2;
    } else if (Datos.isMiddleValue(
        value: Valores.creatinina, min: 3.5, max: 4.9)) {
      ren = 3;
    } else if (Datos.isUpperValue(value: Valores.creatinina!, lim: 5)) {
      ren = 2;
    } else {
      ren = 0;
    }
    // Glasgow ***************************************************
    if (Datos.isMiddleValue(
        value: double.parse(Exploracion.glasgow!), min: 6.0, max: 9.0)) {
      glasg = 3;
    } else if (Datos.isMiddleValue(
        value: double.parse(Exploracion.glasgow!), min: 10.0, max: 12.0)) {
      glasg = 2;
    } else if (Datos.isMiddleValue(
        value: double.parse(Exploracion.glasgow!), min: 13, max: 14.0)) {
      glasg = 1;
    } else if (Datos.isUpperValue(
        value: double.parse(Exploracion.glasgow!), lim: 15)) {
      glasg = 0;
    } else {
      glasg = 4;
    }

    // SUMATORIA ***************************************************
    double aux = resp.toDouble() +
        plat.toDouble() +
        hig.toDouble() +
        card.toDouble() +
        glasg.toDouble() +
        ren.toDouble();
    // RESULTADOS ***************************************************
    if (Datos.isMiddleValue(value: aux, min: 0.0, max: 6.0)) {
      resultado =
          'menor al 10% de Mortalidad estimada durante la Hospitalización';
    } else if (Datos.isMiddleValue(value: aux, min: 6.0, max: 9.0)) {
      resultado = '15-20% de Mortalidad estimada durante la Hospitalización';
    } else if (Datos.isMiddleValue(value: aux, min: 9.0, max: 12.0)) {
      resultado = '40-50% de Mortalidad estimada durante la Hospitalización';
    } else if (Datos.isMiddleValue(value: aux, min: 12.0, max: 14.0)) {
      resultado = '50-60% de Mortalidad estimada durante la Hospitalización';
    } else if (Datos.isMiddleValue(value: aux, min: 14.0, max: 15.0)) {
      resultado = '60-80% de Mortalidad estimada durante la Hospitalización';
    } else if (Datos.isUpperValue(value: aux, lim: 15)) {
      resultado = '90% de Mortalidad estimada durante la Hospitalización';
    } else {
      resultado = 'no concordante. ';
    }

    Terminal.printSuccess(
        message: "mSOFA $resultado : : "
            "$hig . $ren . $glasg . $resp . $card : ($aux)");
    return resultado;
  }

  static String get prequirurgicos {
    return ""
        "A.S.A.: ${Exploracion.valoracionAsa}. \n"
        "Goldmann: ${Valores.valoracionGoldmann}. \n"
        "Detsky: ${Valores.valoracionDetsky}. \n"
        "ARISCAT: ${Valores.valoracionAriscat}. "
        "";
  }

  static double get indiceChoque =>
      Valores.frecuenciaCardiaca! / Valores.tensionArterialSystolica!;
  // Si Mayor a 1.0, alta probabiilidad de Choque ; 0.5 - 0.7

  static double get indiceChoqueModificado =>
      Valores.frecuenciaCardiaca! / Cardiometrias.presionArterialMedia;
// 0.7 - 1.3
}

class Formatos {
  static String get dietasAyuno {
    return 'Ayuno hasta nueva orden';
  }

  static String get dietasCompletas {
    return "Dieta de ${Metabolometrias.gastoEnergeticoBasal.toStringAsFixed(0)} kCal/Día "
        "repartido en "
        "hidratos de carbono ${Metabolometrias.porcentajeCarbohidratos}% "
        "(${Metabolometrias.glucosaPorcentaje.toStringAsFixed(0)} kCal/Día; ${Metabolometrias.glucosaGramos.toStringAsFixed(0)} gr/Día), "
        "proteínas ${Metabolometrias.porcentajeProteinas}% "
        "(${Metabolometrias.proteinasPorcentaje.toStringAsFixed(0)} kCal/Día; ${Metabolometrias.proteinasGramos.toStringAsFixed(0)} gr/Día), "
        "lípidos ${Metabolometrias.porcentajeLipidos}% "
        "(${Metabolometrias.lipidosPorcentaje.toStringAsFixed(0)} kCal/Día; ${Metabolometrias.lipidosGramos.toStringAsFixed(0)} gr/Día); \n"
        "${Metabolometrias.proteinasAVM.toStringAsFixed(0)} gr/Día de proteína de alto valor molecular, "
        "${Metabolometrias.sodioDietario.toStringAsFixed(0)} mEq/Día de sodio, "
        "${Metabolometrias.fibraDietaria.toStringAsFixed(0)} gr/Día de fibra total, "
        "${Metabolometrias.aguaTotal.toStringAsFixed(0)} Lt/Día de agua libre.\n";
  }

  static String get dietas {
    return "Dieta de ${Metabolometrias.gastoEnergeticoBasal.toStringAsFixed(0)} kCal/Día; "
        "${Metabolometrias.proteinasAVM.toStringAsFixed(0)} gr/Día de proteína de alto valor molecular, "
        "${Metabolometrias.sodioDietario.toStringAsFixed(0)} mEq/Día de sodio, "
        "${Metabolometrias.fibraDietaria.toStringAsFixed(0)} gr/Día de fibra total, "
        "${Metabolometrias.aguaTotal.toStringAsFixed(0)} Lt/Día de agua libre.\n";
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

  //
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

  static String get viviendasSimplificado {
    // Variables ******** **** ********* ******** **********
    String formacion = "", comodidades = "", servicios = "", conformacion = "";

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
    return "Vivienda: Propiedad ${Valores.propiedadVivienda}. "
        "Conformación interna de la vivienda con separación habitacional$formacion. "
        "Servicios públicos habitacionales$servicios. "
        "Servicios domiciliarios$comodidades. "
        "Conformación externa de la vivienda$conformacion. \n";
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
      drogadismo =
          "Toxicomania iniciado a los ${Valores.edadInicioDrogadismo}, "
          "con duración aproximada de  ${Valores.duracionAnosDrogadismo} años, "
          "a razón de  ${Valores.periodicidadDrogadismo} cada  ${Valores.intervaloDrogadismo}. "
          "$suspension"
          "Tipo de drogas usadas ( ${Valores.tiposDrogadismoDescripcion}). ";
    } else {
      drogadismo = 'Toxicomanias negadas. ';
    }
    // ************* ********** ************** ***

    return ''
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
        "y se comprueba la integridad del globo del ${Exploracion.dispositivoEmpleado} insuflandolo para corroborar su correcta dilatación sin fuga. "
        "Se lubrica el dispositivo con xilocaína, y se corrobora que la guía metálica no rebase la punta del ${Exploracion.dispositivoEmpleado}.\n"
        "Se administra Sedante Opiáceo para asegurar sedoanalgésia, mientras se realiza Preoxigenación al paciente con Dispositivo de Alto Flujo, "
        "recolocando la cama del paciente para que la cabeza del mismo quede a la altura del apéndice xifoides del operador, inclinando la cabeza del paciente hacia posterior "
        "resultando en una Movilidad Cervical ${Exploracion.movilidadCervical}, para posteriormente elevar el mentón en Posición de Olfateo; "
        "clasificando la Distancia Esternomentoniana como ${Exploracion.distanciaEsternomentoniana}, y Distancia Tiromentoniana como ${Exploracion.distanciaTiromentoniana}. \n"
        "Se apertura la Mandíbula Inferior clasificando la Apertura Mandibular como ${Exploracion.aperturaMandibular}, además de Protrusión Mandibular como ${Exploracion.movilidadTemporoMandibular}, "
        "para posteriormente visualizar el Istmo Orofaríngeo, catalogándolo como ${Exploracion.escalaMallampati} (Mallampati). Posteriormente se ingresa la hoja del Laringoscopio del lado derecho "
        "de la lengua empujando la misma hacia la izquierda; coadyuvado mediante la realización de la Maniobra de Sellick, "
        "quedando asi la hoja en la línea media. "
        "Se desciende hasta la base de la lengua hasta presionarla sobre el piso de la boca en el ángulo de la Vallecula Epiglótica, quedando el mango del laringoscopio apuntando al techo, en un ángulo de 45 grados. "
        "Visualizando las cuerdas vocales siendo catalogado el acceso aéreo como ${Exploracion.escalaCormackLahane}(Cormack - Lahane). Se toma el ${Exploracion.dispositivoEmpleado} "
        "con la mano derecha desplazandolo sobre la hoja del laríngoscopio para ir atravezando las Cuerdas Vocales hasta ver desaparecer el extremo inferior del ${Exploracion.dispositivoEmpleado}, "
        "donde quedará ubicado el balón del dispositivo (3 - 4 cm de las Cuerdas Vocales).\n"
        "Se retira la guia metálica, posteriormente se retira el laringoscopio para la posterior confirmación de la correcta colocacion del ${Exploracion.dispositivoEmpleado} mediante la visualización de la columna de aire através del dispositivo, "
        "la simétria de la ventilación evidenciada por la mecánica tóracica y por la auscultación directa. "
        "Toda vez corroborado la correcta inserción de este, se conecta el ${Exploracion.dispositivoEmpleado} al ${Exploracion.dispositivoOxigeno}.\n"
        "Se ausculta el abdomen en búsqueda de presion positiva, asi como ambos pulmones a la altura de la linea media axilar obteniendo sonido simétrico en ambos pulmones.\n"
        "Se mantiene el ${Exploracion.dispositivoEmpleado} a 22 cm respecto a los dientes, y se procede a asegurarlo con esparadrapo y pegarla a las mejillas. ";
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

  // TERAPIAS ************* ********** ************** ***
  static String get exploracionTerapia => ""
      "Durante la Exploración Física, siendo evaluado por Aparatos y Sistemas, es encontrado: \n"
      "NEUROLOGICO: "
      "En sedoanalgesia con ${Exploracion.sedoanalgesia} consiguiendo "
      "R.A.S.S. ${Exploracion.rass} y "
      "Ramsay ${Exploracion.ramsay}, sin datos de focalización neurológica. \n"
      "VENTILATORIO: Apoyo ventilatorio con ${Exploracion.dispositivoEmpleado!.toLowerCase()}, "
      "mediante ${Exploracion.tuboEndotraqueal} ${Exploracion.haciaArcadaDentaria!.toLowerCase()}. "
      "${Ventometrias.ventilador} \n"
      // **************** ************ ********
      "PCO2 ${Valores.pcoArteriales!.toStringAsFixed(0)} mmHg, "
      "PO2 ${Valores.poArteriales!.toStringAsFixed(0)} mmHg, "
      "SO2 ${Valores.soArteriales!.toStringAsFixed(0)} %, "
      "Indice PaO2/FiO2: ${Gasometricos.PAFI.toStringAsFixed(0)} mmHg. "
      "Aa-O2 ${Gasometricos.GAA.toStringAsFixed(0)} mmHg. \n"
      "Ruidos pulmonares audibles, sin estertores ni sibilancias. "
      "\n"
      "HEMODINAMICO: "
      "Con tensión arterial sistémica ${Valores.tensionArterialSistemica} mmHg, "
      "(TAM ${Cardiometrias.presionArterialMedia.toStringAsFixed(0)} mmHg), ${Exploracion.apoyoAminergico!.toLowerCase()}; "
      "frecuencia cardiaca ${Valores.frecuenciaCardiaca!.toStringAsFixed(0)} L/min detectada por monitoreo cardiaco continuo, "
      "con telemetría a  ritmo sinusal; ruidos cardiacos rítmicos, "
      "adecuada frecuencia aumentados en intensidad, llenado capilar distal de 2 segundos, pulsos presentes de adecuada frecuencia e intensidad. \n"
      "HEMATOINFECCIOSO: "
      "Con temperatura corporal ${Valores.temperaturCorporal!.toStringAsFixed(1)} °C, con "
      "${Exploracion.antibioticoterapia}; última biometría hemática obteniendo "
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
      "GASTROMETABÓLICO: ${Exploracion.tipoSondaAlimentacion}; ${Exploracion.alimentacion}. "
      "Peso corporal total: ${Valores.pesoCorporalTotal!.toStringAsFixed(2)} Kg, "
      "estatura: ${Valores.alturaPaciente} mts, I.M.C ${Antropometrias.imc.toStringAsFixed(0)} Kg/m2, y "
      "peso predicho ${Antropometrias.pesoCorporalPredicho.toStringAsFixed(1)} Kg. \n"
      "Glucometría capilar con ${Valores.glucemiaCapilar} mg/dL, y "
      "glucosa sérica ${Valores.glucosa!.toStringAsFixed(0)} mg/dL, "
      "albúmina en ${Valores.albuminaSerica!.toStringAsFixed(1)} g/dL. "
      "Abdomen blando, depresible, sin datos de irritación peritoneal. \n"
      "HIDRICO-RENAL: ${Exploracion.tipoSondaVesical}, con "
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
      "tasa de filtrado glomerular ${Renometrias.tasaRenalCrockoft_Gault.toStringAsFixed(0)} mL/min/1.73 m2 (Cockcroft - Gault). \n"
      "pH ${Valores.pHArteriales}, "
      "HCO3- ${Valores.bicarbonatoArteriales!.toStringAsFixed(1)} mmol/L, "
      "E.B. ${Gasometricos.EB.toStringAsFixed(1)} mmol/L. " // excesoBaseArteriales
      "Sodio ${Valores.sodio!.toStringAsFixed(0)} mmol/L, "
      "potasio ${Valores.potasio!.toStringAsFixed(1)} mmol/L, "
      "cloro: ${Valores.cloro!.toStringAsFixed(0)} mmol/L. \n"
      "${Hidrometrias.hidricos}";

  static String get exploracionTerapiaCorta => ""
      "${Antropometrias.vitalesAbreviado}\n"
      "Durante la Exploración Física, siendo evaluado por Aparatos y Sistemas, es encontrado: \n"
      "          "
      "En sedoanalgesia con ${Exploracion.sedoanalgesia}, "
      "R.A.S.S. ${Exploracion.rass}, "
      // "Ramsay ${Valores.ramsay}, "
      "sin focalización neurológica. \n"
      "          "
      "Apoyo ventilatorio "
      "mediante ${Exploracion.tuboEndotraqueal} ${Exploracion.haciaArcadaDentaria!.toLowerCase()}. "
      "${Ventometrias.ventiladorCorto}. "
      // **************** ************ ********
      "Última gasometría (${Valores.fechaGasometriaArterial}): "
      "PaCO2 ${Valores.pcoArteriales!.toStringAsFixed(0)} mmHg, "
      "PaO2 ${Valores.poArteriales!.toStringAsFixed(0)} mmHg, "
      "SaO2 ${Valores.soArteriales!.toStringAsFixed(0)} %, "
      "PaO2/FiO2 ${Gasometricos.PAFI.toStringAsFixed(0)} mmHg. "
      "Aa-O2 ${Gasometricos.GAA.toStringAsFixed(0)} mmHg. "
      "Murmullo vesicular audible, sin estertores ni sibilancias. "
      "\n"
      "          "
      "T/A ${Valores.tensionArterialSistemica} mmHg, "
      "(TAM ${Cardiometrias.presionArterialMedia.toStringAsFixed(0)} mmHg), "
      "${Exploracion.apoyoAminergico!.toLowerCase()}; "
      "FC ${Valores.frecuenciaCardiaca!.toStringAsFixed(0)} L/min, "
      "telemetría a  ritmo sinusal; precordio rítmico, "
      "llenado capilar 2 segundos, pulsos homócrotos presentes. \n"
      "          "
      "Temperatura corporal ${Valores.temperaturCorporal!.toStringAsFixed(1)} °C, con "
      "${Exploracion.antibioticoterapia!.toLowerCase()}; última biometría hemática (${Valores.fechaBiometria}): "
      "Hb ${Valores.hemoglobina} g/dL, "
      "Hto ${Valores.hematocrito}%, "
      "Leu ${Valores.leucocitosTotales} K/uL, "
      "Neu ${(Valores.neutrofilosTotales! / Valores.leucocitosTotales!).toStringAsFixed(2)} K/uL, "
      "Lyn ${(Valores.linfocitosTotales! / Valores.leucocitosTotales!).toStringAsFixed(2)} K/uL, "
      "reactantes de fase aguda con "
      "PCR ${Valores.proteinaCreactiva} mg/dL, "
      "Procalcitonina ${Valores.procalcitonina} ng/mL. "
      "No presenta sangrado, sin requerimiento transfusional. \n"
      "          "
      "${Exploracion.tipoSondaAlimentacion}; ${Exploracion.alimentacion!.toLowerCase()}. "
      "PCT ${Valores.pesoCorporalTotal!.toStringAsFixed(1)} Kg, "
      "estatura ${Valores.alturaPaciente} mts, I.M.C ${Antropometrias.imc.toStringAsFixed(0)} Kg/m2, y "
      "PP ${Antropometrias.pesoCorporalPredicho.toStringAsFixed(1)} Kg. "
      "Glucometría ${Valores.glucemiaCapilar} mg/dL, "
      "glucosa sérica ${Valores.glucosa!.toStringAsFixed(0)} mg/dL, "
      "albúmina ${Valores.albuminaSerica!.toStringAsFixed(1)} g/dL. "
      "Abdomen blando, normoperistalsis, depresible, sin irritación peritoneal. \n"
      "          "
      "Genitourinario ${Exploracion.tipoSondaVesical!.toLowerCase()}; "
      "balance hídrico: "
      "ingresos ${Valores.ingresosBalances} mL, "
      "egresos ${Valores.egresosBalances} mL "
      "(${Valores.balanceTotal} mL/${Valores.horario} Horas), "
      "P.I. ${Valores.perdidasInsensibles} mL, "
      "uresis ${Valores.uresis!.toStringAsFixed(0)} mL "
      "(${Valores.diuresis.toStringAsFixed(2)} mL/${Valores.horario} Horas). "
      "Creatinina ${Valores.creatinina!.toStringAsFixed(1)} mg/dL, "
      "urea ${Valores.urea!.toStringAsFixed(1)} mg/dL; "
      "pH ${Valores.pHArteriales}, "
      "HCO3- ${Valores.bicarbonatoArteriales!.toStringAsFixed(1)} mmol/L, "
      "E.B. ${Gasometricos.EB.toStringAsFixed(1)} mmol/L. " // excesoBaseArteriales
      "Na2+ ${Valores.sodio!.toStringAsFixed(0)} mmol/L, "
      "K+ ${Valores.potasio!.toStringAsFixed(1)} mmol/L, "
      "Cl- ${Valores.cloro!.toStringAsFixed(0)} mmol/L. \n"
      "${Auxiliares.getUltimo(esAbreviado: true)}";

  static String get exploracionTerapiaBreve => ""
      "${Antropometrias.vitalesTerapiaAbreviado}\n"
      "Durante la Exploración Física, siendo evaluado por Aparatos y Sistemas, es encontrado: \n"
      "          "
      "En sedoanalgesia con ${Exploracion.sedoanalgesia}, "
      "R.A.S.S. ${Exploracion.rass}, sin focalización neurológica. \n"
      "          "
      "Apoyo ventilatorio mediante ${Exploracion.tuboEndotraqueal} ${Exploracion.haciaArcadaDentaria!.toLowerCase()}. "
      "${Ventometrias.ventiladorCorto}. "
      "Murmullo vesicular audible, sin estertores ni sibilancias. "
      "\n"
      "          "
      "T/A ${Valores.tensionArterialSistemica} (${Cardiometrias.presionArterialMedia.toStringAsFixed(0)}) mmHg, "
      "${Exploracion.apoyoAminergico!.toLowerCase()}; "
      "FC ${Valores.frecuenciaCardiaca!.toStringAsFixed(0)} L/min, "
      "telemetría a  ritmo sinusal; precordio rítmico, "
      "llenado capilar 2 segundos, pulsos homócrotos presentes. \n"
      "          "
      "Temperatura corporal ${Valores.temperaturCorporal!.toStringAsFixed(1)} °C, "
      "${Exploracion.antibioticoterapia!.toLowerCase()}. "
      "No presenta sangrado, sin requerimiento transfusional. \n"
      "          "
      "${Exploracion.tipoSondaAlimentacion}; ${Exploracion.alimentacion!.toLowerCase()}. "
      "Abdomen blando, normoperistalsis, depresible, sin irritación peritoneal. \n"
      "          "
      "Genitourinario ${Exploracion.tipoSondaVesical!.toLowerCase()}; "
      "balance hídrico: "
      "ingresos ${Valores.ingresosBalances} mL, "
      "egresos ${Valores.egresosBalances} mL "
      "(${Valores.balanceTotal} mL/${Valores.horario} Horas), "
      "P.I. ${Valores.perdidasInsensibles} mL, "
      "uresis ${Valores.uresis!.toStringAsFixed(0)} mL "
      "(${Valores.diuresis.toStringAsFixed(2)} mL/${Valores.horario} Horas). \n"
      "${Auxiliares.getUltimo(esAbreviado: true)}";

  // OTROS ************* ********** ************** ***
  static String get licenciaMedica {
    return "Licencia médica otorgada con folio ${Valores.folioLicencia}, "
        "con ${Valores.diasOtorgadosLicencia} dias otorgados desde la "
        "fecha de inicio ${Valores.fechaInicioLicencia} hasta el ${Valores.fechaTerminoLicencia}, "
        "por ${Valores.motivoLicencia}, de cáracter ${Valores.caracterLicencia}. ";
  }

  static String get balances {
    return "Balance hídrico (${Valores.fechaRealizacionBalances}) - "
        "Ingresos ${Valores.ingresosBalances.toStringAsFixed(2)} mL,  "
        "egresos ${Valores.egresosBalances.toStringAsFixed(2)} mL; "
        "perdidas insensibles ${Valores.perdidasInsensibles.toStringAsFixed(2)} mL  "
        "(balance Total ${Valores.balanceTotal.toStringAsFixed(2)} mL/${Valores.horario} mL),  "
        "uresis ${Valores.uresis} mL,  "
        "diuresis ${Valores.diuresis.toStringAsFixed(2)} mL/${Valores.horario} mL.  "
        "\n ";
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
    'Cambio de Sector', // Otras Hospitalización / Cambio de Cama
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

  /// Se divide por Grados: ['Grado I: Mayor a 6.5 cm','Grado II: Entre 6 a 6.5 cm', 'Grado III: Menor a 6 cm',];
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

  // TORAX
  static List<String> amplexionTorax = [
    'Grado I: Mayor a 6.5 cm',
    'Grado II: Entre 6 a 6.5 cm',
    'Grado III: Menor a 6 cm',
  ];
  static List<String> amplexacionTorax = [
    'Grado I: Mayor a 6.5 cm',
    'Grado II: Entre 6 a 6.5 cm',
    'Grado III: Menor a 6 cm',
  ];
  static List<String> ruidosCardiacos = [
    'Grado I: Mayor a 6.5 cm',
    'Grado II: Entre 6 a 6.5 cm',
    'Grado III: Menor a 6 cm',
  ];
  static List<String> murmulloVesicular = [
    'Grado I: Mayor a 6.5 cm',
    'Grado II: Entre 6 a 6.5 cm',
    'Grado III: Menor a 6 cm',
  ];
  static List<String> estertoresPulmonar = [
    'Grado I: Mayor a 6.5 cm',
    'Grado II: Entre 6 a 6.5 cm',
    'Grado III: Menor a 6 cm',
  ];
  static List<String> sibilanciasPulmonar = [
    'Grado I: Mayor a 6.5 cm',
    'Grado II: Entre 6 a 6.5 cm',
    'Grado III: Menor a 6 cm',
  ];

  // ABDOMEN
  static List<String> aspectoAbdomen = [
    'Blando',
    'Globoso'
        'En Batea',
    'En batracio',
  ];
  static List<String> peristalisisAbdomen = [
    'Peristalsis disminuida',
    'Normo-peristalsis',
    'Peristalsis Aumentada',
  ];
  static List<String> dolorosoAbdomen = [
    'No doloroso',
    'Doloroso a la palpación superficial',
    'Doloroso a la palpación media',
    'Doloroso a la palpación profunda',
    'Doloroso a la palpación media y profunda'
  ];
  static List<String> irritacionPeritoneal = [
    "Sin irritación peritoneal",
    "Con irritación peritoneal",
  ];
}

class Items {
  static List<String> tiposAnalisis = [
    'Análisis de Ingreso', // 0
    'Análisis de Evolución', // 1
    'Análisis de Revisión',
    'Análisis de Egreso',
    'Análisis de Gravedad', // 4
    'Análisis de Traslado', // 5
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
    "Cánula de Traqueostomía Fr. 6",
    "",
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
    "a 30 cm de la Arcada Dentaria",
    "",
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
    "Con Sonda Vesical Fr. 18",
    ""
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
    '',
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
  static List<String> oxigenSuplementario = [
    'Sin Oxígeno Suplementario',
    'oxigeno medicinal entre 1- 3 Lts/min',
    'oxigeno medicinal entre 3- 5 Lts/min',
    'oxigeno medicinal entre 5- 8 Lts/min',
    'oxigeno medicinal entre 8- 10 Lts/min',
    'oxigeno medicinal entre mayor a 10 Lts/min',
  ];
  static List<String> excretasBristol = [
    'Tipo 1',
    'Tipo 2',
    'Tipo 3',
    'Tipo 4',
    'Tipo 5',
    'Tipo 6',
    'Tipo 7',
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

  static List<String> coloracionTegumentaria = [
    'Sin palidez tegumentaria',
    'Con palidez tegumentaria'
  ];

  static List<String> coloracionMucosas = ['Deshidratado', 'Hidratado'];

  static List<String> inspeccionGeneral = [
    'Alerta',
    'Obnubilado',
    'Somnoliento',
    'Estuporoso'
  ];

  static List<String> typesDocumentaciones = [
    'Cartilla Nacional de Vacunación',
    'Identificación Federal del Elector',
    'Acta de Nacimiento',
    'Comprobante de Domicilio',
    'Reporte de Biopsia',
    'Valoración Preanestésica',
    'Valoración Preoperatoria',
    'Valoración por Especialidades',
    'Reporte de Gammagrama',
    'Reporte de Ecocardiografía',
    'Reporte de Holter',
    'Antibiogramas',
    '',
    'Alerta',
    'Obnubilado',
    'Somnoliento',
    'Estuporoso',
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

  static List<String> religiones = [
    'Sin religión',
    'Católica',
    'Evangelista',
    'Testigo de Jehova',
    'Cristiana',
    'Adventista',
    'Pentecostés',
    'Hinduista',
    'Islámica'
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
    "Centésimo",
    "Centésimo Primer",
    "Centésimo Segundo",
    "Centésimo Tercer",
    "Centésimo Cuarto",
    "Centésimo Quinto",
    "Centésimo Sexto",
    "Centésimo Séptimo",
    "Centésimo Octavo",
    "Centésimo Noveno",
    "Centésimo",
    "Centésimo Primer",
    "Centésimo Segundo",
    "Centésimo Tercer",
    "Centésimo Cuarto",
    "Centésimo Quinto",
    "Centésimo Sexto",
    "Centésimo Séptimo",
    "Centésimo Octavo",
    "Centésimo Noveno",
  ];
}

class Parenterales {
  static List parenterales = [
    'Sol. Hartmann',
    'Sol. NaCl 0.9%',
    'Sol. Mixta',
    'Sol. Glucosada 5%',
    'Sol. Glucosada 10%',
    'Sol. Glucosada 50%',
    'Sol. NaCl 17.7%',
  ];
  static List composiciones = [
    {
      "Sodio": 130.0,
      "Potasio": 4.0,
      "Cloro": 2.75,
      'Cloruro': 109.0,
      'Lactato': 28.0,
      'Osmolaridad': 272.0,
      'Glucosa': 0.0,
      'Calcio': 3.0
    }, // Hartmann
    {
      "Sodio": 154.0,
      "Potasio": 0.0,
      "Cloro": 154.0,
      'Cloruro': 0.0,
      'Lactato': 0.0,
      'Osmolaridad': 308.0,
      'Glucosa': 0.0,
      'Calcio': 0.0
    }, // NaCl 0.9%
    {
      "Sodio": 77.0,
      "Potasio": 0.0,
      "Cloro": 77.0,
      'Cloruro': 0.0,
      'Lactato': 0.0,
      'Osmolaridad': 292.0,
      'Glucosa': 0.0,
      'Calcio': 0.0
    }, // Mixta
    {
      "Sodio": 0.0,
      "Potasio": 0.0,
      "Cloro": 0.0,
      'Cloruro': 0.0,
      'Lactato': 0.0,
      'Osmolaridad': 277.0,
      'Glucosa': 5.0,
      'Calcio': 0.0
    }, // Glucosada 5%
    {
      "Sodio": 0.0,
      "Potasio": 0.0,
      "Cloro": 0.0,
      'Cloruro': 0.0,
      'Lactato': 0.0,
      'Osmolaridad': 555.0,
      'Glucosa': 50.0,
      'Calcio': 0.0
    }, // Glucosada 10%
    {
      "Sodio": 0.0,
      "Potasio": 0.0,
      "Cloro": 0.0,
      'Cloruro': 0.0,
      'Lactato': 0.0,
      'Osmolaridad': 277.0,
      'Glucosa': 100.0,
      'Calcio': 0.0
    }, // Glucosada 50%
    {
      "Sodio": 3028.0,
      "Potasio": 0.0,
      "Cloro": 3028.0,
      'Cloruro': 0.0,
      'Lactato': 0.0,
      'Osmolaridad': 6056.0,
      'Glucosa': 100.0,
      'Calcio': 0.0
    }, // Sol NaCl 17.7%
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
