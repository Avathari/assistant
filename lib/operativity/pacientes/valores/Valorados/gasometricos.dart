import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/ferricos.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/info/info.dart';
import 'dart:math' as math;
import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/cardiometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/hidrometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/metabolometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/renometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/ventometr%C3%ADas.dart';
import 'package:assistant/values/Strings.dart';
import 'package:dart_numerics/dart_numerics.dart' as numerics;

class Gasometricos {
  // ANALISIS

  // CONCLUSIONES
  static String get gasometricos {
    return "Gasometría Arterial (${Valores.fechaGasometriaArterial}):  "
        "pH ${Valores.pHArteriales}, "
        "PCO2 ${Valores.pcoArteriales} mmHg, "
        "PO2 ${Valores.poArteriales} mmHg, "
        "SO2 ${Valores.soArteriales} %, "
        "HCO3- ${Valores.bicarbonatoArteriales!.toStringAsFixed(2)} mmol/L, "
        "HCO3std ${Gasometricos.EBecf.toStringAsFixed(2)} mmol/L, "
        "EB ${Gasometricos.EB.toStringAsFixed(2)} mmol/L, "
        "TCO2 ${Gasometricos.TCO.toStringAsFixed(2)} mmHg, "
        "PCO2e ${Gasometricos.PCO2C.toStringAsFixed(2)} mmHg, "
    // "EBe ${Valores.pHArteriales} mmol/L, "
        "aGAP ${Gasometricos.GAP.toStringAsFixed(1)}, "
        "Temp ${Valores.temperaturCorporal}°C, "
        "FiO2 ${Valores.fioArteriales}%, "
        "A-aO2 ${Gasometricos.GAA.toStringAsFixed(1)} mmHg, "
        "PaO2/FiO2 ${Gasometricos.PAFI_FIO.toStringAsFixed(0)}mmHg/%";
  }

  static String get gasometricosNombrado {
    return "${Valores.nombreCompleto} "
        "(${Valores.fechaGasometriaArterial}) - "
        "pH ${Valores.pHArteriales}, "
        "PCO2 ${Valores.pcoArteriales} mmHg, "
        "PO2 ${Valores.poArteriales} mmHg, "
        "SO2 ${Valores.soArteriales} %, "
        "HCO3- ${Valores.bicarbonatoArteriales!.toStringAsFixed(2)} mmol/L, "
        "HCO3std ${Gasometricos.EBecf.toStringAsFixed(2)} mmol/L, "
        "EB ${Gasometricos.EB.toStringAsFixed(2)} mmol/L, "
        "TCO2 ${Gasometricos.TCO.toStringAsFixed(2)} mmHg, "
        "PCO2e ${Gasometricos.PCO2C.toStringAsFixed(2)} mmHg, "
    // "EBe ${Valores.pHArteriales} mmol/L, "
        "aGAP ${Gasometricos.GAP.toStringAsFixed(1)}, "
        "Temp ${Valores.temperaturCorporal}°C, "
        "FiO2 ${Valores.fioArteriales}%, "
        "A-aO2 ${Gasometricos.GAA.toStringAsFixed(1)} mmHg, "
        "PaO2/FiO2 ${Gasometricos.PAFI_FIO.toStringAsFixed(0)}mmHg/%";
  }

  static String get gasometricosMedial {
    return "Gasometría Arterial (${Valores.fechaGasometriaArterial}):  "
        "pH ${Valores.pHArteriales}, "
        "PCO2 ${Valores.pcoArteriales} mmHg, "
        "PCO2Tp ${Gasometricos.PCO2C.toStringAsFixed(2)} mmHg, "
        "PO2 ${Valores.poArteriales} mmHg, "
        "SO2 ${Valores.soArteriales} %, "
        "Hb ${Valores.hemoglobina} g/dL, "
        "Hto ${Valores.hematocrito} %, "
        "HCO3- ${Valores.bicarbonatoArteriales!.toStringAsFixed(2)} mmol/L, "
        "HCO3std ${Gasometricos.EBecf.toStringAsFixed(2)} mmol/L, "
        "EB ${Gasometricos.EB.toStringAsFixed(2)} mmol/L, "
        "TCO2 ${Gasometricos.TCO.toStringAsFixed(2)} mmHg, "
        "PCO2e ${Gasometricos.PCO2C.toStringAsFixed(2)} mmHg, "
        "Temp ${Valores.temperaturCorporal}°C, "
        "FiO2 ${Valores.fioArteriales}%, "
        "PAO2 ${Gasometricos.PAO} mmHg, "
        "A-aO2 ${Gasometricos.GAA.toStringAsFixed(1)} mmHg, "
        "PAO2/PO2 ${Gasometricos.PaO2PAO2.toStringAsFixed(0)}mmHg, "
        "PO2/FiO2 ${Gasometricos.PAFI_FIO.toStringAsFixed(0)}mmHg, "
        "SO2/FiO2 ${Gasometricos.SAFI.toStringAsFixed(0)}mmHg/%, "
        "aGAP ${Gasometricos.GAP.toStringAsFixed(1)}, "
        "GAPoms ${Gasometricos.GAPO.toStringAsFixed(1)}, "
        "RI ${Valores.RI.toStringAsFixed(1)}"
        ".";
  }

  static String get gasometricosCompleto {
    return "Gasometría Arterial (${Valores.fechaGasometriaArterial}):  "
        "pH ${Valores.pHArteriales}, "
        "PCO2 ${Valores.pcoArteriales} mmHg, "
        "PCO2Tp ${Gasometricos.PCO2C.toStringAsFixed(2)} mmHg, "
        "PO2 ${Valores.poArteriales} mmHg, "
        "SO2 ${Valores.soArteriales} %, "
        "Hb ${Valores.hemoglobina} g/dL, "
        "Hto ${Valores.hematocrito} %, "
        "HCO3- ${Valores.bicarbonatoArteriales!.toStringAsFixed(2)} mmol/L, "
        "HCO3std ${Gasometricos.EBecf.toStringAsFixed(2)} mmol/L, "
        "EB ${Gasometricos.EB.toStringAsFixed(2)} mmol/L, "
        "TCO2 ${Gasometricos.TCO.toStringAsFixed(2)} mmHg, "
        "PCO2e ${Gasometricos.PCO2C.toStringAsFixed(2)} mmHg, "
        "Temp ${Valores.temperaturCorporal}°C, "
        "FiO2 ${Valores.fioArteriales}%, "
        "PAO2 ${Gasometricos.PAO} mmHg, "
        "A-aO2 ${Gasometricos.GAA.toStringAsFixed(1)} mmHg, "
        "PAO2/PO2 ${Gasometricos.PaO2PAO2.toStringAsFixed(0)}mmHg, "
        "PO2/FiO2 ${Gasometricos.PAFI_FIO.toStringAsFixed(0)}mmHg, "
        "SO2/FiO2 ${Gasometricos.SAFI.toStringAsFixed(0)}mmHg/%, "
        "aGAP ${Gasometricos.GAP.toStringAsFixed(1)}, "
        "GAPoms ${Gasometricos.GAPO.toStringAsFixed(1)}, "
        "RI ${Valores.RI.toStringAsFixed(1)}, "
        "pH- 1ra Regla ${Gasometricos.HCOR_a.toStringAsFixed(2)}, "
        "pH- 2da Regla ${Gasometricos.HCOR_b.toStringAsFixed(2)}, "
        "HCO3- 3ra Regla ${Gasometricos.HCOR_c.toStringAsFixed(2)} mmol/L, "
        "Rep. HCO3- ${Gasometricos.HCOAM.toStringAsFixed(2)}, "
        "en total ${Gasometricos.NOAMP.toStringAsFixed(0)} ámpulas de bicarbonato al 7.5%"
        ".";
  }

  static String get gasometricosBicarbonato {
    return "Gasometría Arterial (${Valores.fechaGasometriaArterial}):  "
        "pH ${Valores.pHArteriales}, "
        "PCO2 ${Valores.pcoArteriales} mmHg, "
        "PCO2Tp ${Gasometricos.PCO2C.toStringAsFixed(2)} mmHg, "
        "PO2 ${Valores.poArteriales} mmHg, "
        "SO2 ${Valores.soArteriales} %, "
        "Hb ${Valores.hemoglobina} g/dL, "
        "Hto ${Valores.hematocrito} %, "
        "HCO3- ${Valores.bicarbonatoArteriales!.toStringAsFixed(2)} mmol/L, "
        "HCO3std ${Gasometricos.EBecf.toStringAsFixed(2)} mmol/L, "
        "EB ${Gasometricos.EB.toStringAsFixed(2)} mmol/L, "
        "TCO2 ${Gasometricos.TCO.toStringAsFixed(2)} mmHg, "
        "PCO2e ${Gasometricos.PCO2C.toStringAsFixed(2)} mmHg, "
        "Temp ${Valores.temperaturCorporal}°C, "
        "FiO2 ${Valores.fioArteriales}%, "
        "pH- 1ra Regla ${Gasometricos.HCOR_a.toStringAsFixed(2)}, "
        "pH- 2da Regla ${Gasometricos.HCOR_b.toStringAsFixed(2)}, "
        "HCO3- 3ra Regla ${Gasometricos.HCOR_c.toStringAsFixed(2)} mmol/L, "
        "Rep. HCO3- ${Gasometricos.HCOAM.toStringAsFixed(2)}, "
        "en total ${Gasometricos.NOAMP.toStringAsFixed(0)} ámpulas de bicarbonato al 7.5%"
        ".";
  }
  // FÓRMULAS
  static String get trastornoPrimario {
    if (Valores.pHArteriales! < 7.34) {
      return 'Acidemia';
    } else if (Valores.pHArteriales! > 7.45) {
      return 'Alcalemia';
    } else {
      return 'Normal';
    }
  }

  // Comparación entre el PCO2 y el HCO3-
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
    if (Gasometricos.EB < -3) {
      return 'Consumo de Bases'; // Acidosis
    } else if (Valores.poArteriales! > 3) {
      return 'Retención de Bases'; // Alcalosis
    } else {
      return 'Normal';
    }
    // excesoBaseArteriales
  }

  static String get trastornoGap {
    if (Gasometricos.GAP < 8) {
      return 'Pérdida de Bicarbonato';
    } else if (Gasometricos.GAP > 12) {
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

  static double get PAFI_PB => (PAFI * (Valores.presionBarometrica / 760));

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

  static double get GAPO => ((280) / (Hidrometrias.osmolaridadSerica));

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
  static double get DA => (Gasometricos.EB - EBb); // # Diferencia Anionica
  static double get VDb => (Gasometricos.EB - DA); // # Verdadero Déficit de Base

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

  static double get PIO => (Valores.presionGasSeco / Valores.fioArteriales!);
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
    if (Gasometricos.EB < 0) {
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
    if (Gasometricos.EB < 0) {
      return Gasometricos.EB * (Valores.pesoCorporalTotal! * 0.3) * (-1);
    } else {
      return Gasometricos.EB * (Valores.pesoCorporalTotal! * 0.3) * (1);
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

  // # Concentración de Hidrigeniones H+
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


}
