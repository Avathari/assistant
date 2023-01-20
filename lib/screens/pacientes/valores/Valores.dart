import 'dart:async';
import 'dart:math' as math;
import 'package:dart_numerics/dart_numerics.dart' as numerics;

import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/usuarios/Pacientes.dart';

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
      rfc;
  static int? edad;
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
  static double? albuminaSerica, proteinasTotales;
  //
  static double? sodio, potasio, cloro, fosforo, calcio, magnesio;
  //
  static double? pH, bicarbonatoArteriales;

  // Variables Estaticas
  static int constanteRequerimientos = 30;
  static double pi = 3.14159265;

  Valores();

  Future<bool> load() async {
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
    //valores.map((key, value) => value = null);
    Valores.fromJson(valores);
    return true;
  }

  Valores.fromJson(Map<String, dynamic> json) {
    print("Valors $json");
    numeroPaciente = json['Pace_NSS'];
    agregadoPaciente = json['Pace_AGRE'];
    primerNombre = json['Pace_Nome_PI'];
    segundoNombre = json['Pace_Nome_SE'];
    apellidoPaterno = json['Pace_Ape_Pat'];
    apellidoMaterno = json['Pace_Ape_Mat'];
    imagenUsuario = json['Pace_FIAT'];
    //
    edad = json['Pace_Eda']; // int.parse();
    sexo = json['Pace_Ses'];
    curp = json['Pace_Curp'];
    rfc = json['Pace_RFC'];
    fechaNacimiento = json['Pace_Nace'];
    telefono = json['Pace_Tele'];
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
  }
  static String get numeroExpediente =>
      '${Valores.numeroPaciente} ${Valores.agregadoPaciente}';

  static String get tensionArterialSistemica =>
      '${Valores.tensionArterialSystolica}/${Valores.tensionArterialDyastolica}';
  static double get imc =>
      pesoCorporalTotal! / (alturaPaciente! * alturaPaciente!);

  static double get requerimientoHidrico =>
      (pesoCorporalTotal! * constanteRequerimientos);
  static double get aguaCorporalTotal {
    if (sexo == "Masculino") {
      return 0.60 * pesoCorporalTotal!;
    } else if (sexo == "Femenino") {
      return 0.55 * pesoCorporalTotal!;
    } else {
      return 0.60 * pesoCorporalTotal!;
    }
  }

  static double get excesoAguaLibre {
    if (Valores.sodio != 0 || Valores.sodio == null) {
      return (Valores.aguaCorporalTotal) *
          ((1) - (140 / Valores.sodio!)); // Delta H2O Resultado en Litros.
    } else {
      return 0.0;
    }
  }

  static double get deficitAguaCorporal {
    if (Valores.sodio != 0 || Valores.sodio == null) {
      return ((Valores.aguaCorporalTotal) *
          ((Valores.sodio! - 140.00) / 140.00)); // Deficit de Agua Corporal
    } else {
      return 0.0;
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

  static double get osmolaridadSerica =>
      ((2 * (Valores.sodio! + Valores.potasio!)) +
          (Valores.glucosa! / 18) +
          (Valores.urea! / 2.8));

  static double get brechaOsmolar => (290.00 - (Valores.osmolaridadSerica));

  static double get SOL => (aguaCorporalTotal * osmolaridadSerica);

  static double get LIC => aguaCorporalTotal * 0.666;
  static double get LEC => aguaCorporalTotal * 0.333;
  static double get LI => aguaCorporalTotal * 0.222;
  static double get LIV => aguaCorporalTotal * 0.111;

  static double get VP => aguaCorporalTotal * 0.074;
  static double get VS => aguaCorporalTotal * 0.037;

  static double get DSO {
    if (Valores.sodio! < 120) {
      return 120 - Valores.sodio!;
    } else if (Valores.sodio! > 120 && Valores.sodio! < 120) {
      return (130 - Valores.sodio!) * aguaCorporalTotal;
    } else if (Valores.sodio! > 130) {
      return 120 - Valores.sodio!;
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

  static double get RES => ((140 - Valores.sodio!) / (aguaCorporalTotal + 1.0));
  static double get VIF =>
      RES + ((140 - Valores.sodio!) / (aguaCorporalTotal + 1.0));

  static double get sodioCorregidoGlucosa =>
      (Valores.sodio! + ((1.65 * Valores.glucosa! - 100) / 100));
  static double get globulinasSericas =>
      (Valores.proteinasTotales! - Valores.albuminaSerica!);
  static double get CAC {
    if (Valores.albuminaSerica != 0) {
      if (globulinasSericas != 0) {
        return (Valores.calcio! +
            (0.16 *
                ((Valores.proteinasTotales! - Valores.albuminaSerica!) - 7.4)));
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
  }

  static double get CACPH {
    if (Valores.pH! != 0) {
      return (Valores.calcio! + (0.12 * ((Valores.pH! - 7.4) / 0.1)));
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
  static double get DK => (Valores.pesoCorporalTotal! * (Valores.potasio! - 4));
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

  static double get pHKalemia =>
      (Valores.pH! * ((Valores.potasio! * 0.1) / 0.6));

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

  static double get glucosaGramos =>
      ((gastoEnergeticoTotal / 100) * (Metabolometrias._Carbohidratos));
  static double get lipidosGramos =>
      ((gastoEnergeticoTotal / 100) * (Metabolometrias._Lipidos));
  static double get proteinasGramos =>
      ((gastoEnergeticoTotal / 100) * (Metabolometrias._Proteinas));

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
  // static double get PAO => (valores.get('FraccionInspiratoriaOxigeno_Arteriales') / 100) * (720 - 47) - (valores.get('PresionDioxidoCarbono_Arteriales') / 0.8)

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
  // static double get CAO => (((Valores.hemoglobina * 1.34) * valores.get('SaturacionOxigeno_Arteriales')) + (valores.get('PresionOxigenoArterial_Arteriales') * 0.031)) / (100); //  # Concentración Arterial de Oxígeno
  // # Concentración Venosa de Oxígeno
  // static double get CVO = (((Valores.hemoglobina * 1.34) * valores.get('SaturacionOxigeno_Venosos')) + (valores.get('PresionOxigenoArterial_Venosos') * 0.031)) / (100)  # Concentración Venosa de Oxígeno
  // # Concentración Capilar de Oxígeno
  // static double get CCO => (((Valores.hemoglobina * 1.34) * (valores.get('SaturacionOxigeno_Venosos') - valores.get('SaturacionOxigeno_Arteriales')) + ((valores.get('PresionOxigenoArterial_Venosos') - valores.get('PresionOxigenoArterial_Arteriales')) * 0.031)) / (100)) // # Concentración Capilar de Oxígeno
  // static double get DAV => (CAO - CVO); // # Diferencia Arteriovenosa
  static double get capacidadOxigeno =>
      (Valores.hemoglobina! * (1.36)); //  # Capacidad de Oxígeno
  // # Gasto Cardiaco
  // if DAV != 0.0:
  // GC = (((DAV * 100) / CAO) / (DAV))  # Gasto Cardiaco
  // else:
  //  GC = 1

  // # Indice de Volumen Sanguineo
  static double get indiceVolumenSanguineo =>
      VP /
      (1 - Valores.hematocrito!) *
      ((1.1 * Valores.pesoCorporalTotal!) -
          (128 *
              (math.pow(Valores.pesoCorporalTotal!, 2) /
                  math.pow(Valores.alturaPaciente!, 2))));
  // static double get indiceCardiaco => (Valores.gastoCardiaco! / Valores.superficieCorporal!); // # Indice Cardiaco
  // static double get IRVS => (TAM / Valores.indiceCardiaco!);
  // static double get RVS => (((TAM - 12.0) * 80.00) / Valores.indiceCardiaco!); //  # Resistencias Venosas Sistémicas
  // # (((TAM - 12.0) / IC) * 79.9)
  // static double get IEO => (((DAV / CAO) * 100)); // # Indice de Extracción de Oxígeno
  // static double get VL => (GC / Valores.frecuenciaCardiaca!) * 1000; //  # Volumen Latido De Litros a mL
  // static double get IVL => ((IC * 1000) / FC)  ; //mL/Lat/m2 *IC se multiplica por 1000 para ajustar unidades a mL/min/m2
  // static double get DO => ((GC * CAO) * (10)); // # Disponibilidad de Oxígeno
  // static double get TO => ((CAP_O * CAO) / (10)); // # Transporte de Oxígeno
  // static double get SF => ((CCO - CAO) / (CCO - CAO)) * (100); //  # Shunt Fisiológico
  // static double get CO => ((GC * DAV) * (10)); // # Consumo de Oxígeno
  // static double get GAA => (PAO - valores.get('PresionOxigenoArterial_Arteriales')); //  # Gradiente Alveolo - Arterial
  // static double get PC => ((valores.get('ProteinasTotales') - valores.get('AlbuminaSerica')) * 1.4) + (valores.get('AlbuminaSerica') * 5.5); //  # Presión Coloidóncotica
  // static double get TC => (GC * TAM * 0.0144); // # Trabajo Cardiaco
  // static double get TLVI => GC * TAM * 0.0144; //  # Trabajo Latido Ventricular Izquierdo
  static double get TLVD => 00.00; //  # Trabajo Latido Ventricular Derecho
  // # FE = VL / VDF # FE(%)= ((VDF-VSF)*100)/VDF. (porque VL= VDF-VSF). (%)
  static double get FE => 0.0;
}

class Metabolometrias {
  static double _Carbohidratos = 50.0;

  static double _Lipidos = 20.0;

  static double _Proteinas = 30.0;
}

isNull(value) {
  if (value == null || value == 'null') {
    if (value.runtimeType == 'String') {
      return '0.0';
    } else {
      return 0.0;
    }
  } else {
    return value;
  }
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
      "Delta potasio: ${Valores.DSO} mEq/L: ${Valores.DK}";
}
