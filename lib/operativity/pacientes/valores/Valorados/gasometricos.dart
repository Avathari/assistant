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
        "RI ${Gasometricos.RI.toStringAsFixed(1)}"
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
        "RI ${Gasometricos.RI.toStringAsFixed(1)}, "
        "pH- 1ra Regla ${Gasometricos.HCOR_a.toStringAsFixed(2)}, "
        "pH- 2da Regla ${Gasometricos.HCOR_b.toStringAsFixed(2)}, "
        "HCO3- 3ra Regla ${Gasometricos.HCOR_c.toStringAsFixed(2)} mmol/L, "
        "Rep. HCO3- ${Gasometricos.HCOAM.toStringAsFixed(2)}, "
        "en total ${Gasometricos.NOAMP.toStringAsFixed(
        0)} ámpulas de bicarbonato al 7.5%"
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
        "en total ${Gasometricos.NOAMP.toStringAsFixed(
        0)} ámpulas de bicarbonato al 7.5%"
        ".";
  }

  static String get gasometricosAvanzado {
    return "Gasometría (${Valores.fechaGasometriaArterial}):  "
        "pH ${Valores.pHArteriales}, "
        "PCO2 ${Valores.pcoArteriales} mmHg, "
        "PO2 ${Valores.poArteriales} mmHg, "
        "SO2 ${Valores.soArteriales} %, "
        "HCO3- ${Valores.bicarbonatoArteriales!.toStringAsFixed(2)} mmol/L, "
        "HCO3std ${Gasometricos.EBecf.toStringAsFixed(2)} mmol/L, "
        "EB ${Gasometricos.EB.toStringAsFixed(2)} mmol/L "
        ". "
        "${Valores.temperaturCorporal != 0 ? "Temp ${Valores
        .temperaturCorporal}" : ""}°C, "
        "FiO2 ${Valores.fioArteriales}%, "
        ". "
        "PAO2 ${Gasometricos.PAO.toStringAsFixed(0)} mmHg, "
        "PIO2 ${Gasometricos.PIO.toStringAsFixed(0)} mmHg, "
        ". "
        "A-aO2 ${Gasometricos.GAA.toStringAsFixed(0)} mmHg, "
        "PaO2/FiO2 ${Gasometricos.PAFI_FIO.toStringAsFixed(0)}mmHg/%"
        ". "
        "Alb ${Valores.albuminaSerica!} "
        ". . . "
        "aGAP ${Gasometricos.GAP.toStringAsFixed(0)} "
        "("
        "aGAP/Alb ${Gasometricos.aGapAlb.toStringAsFixed(0)}"
        ")"
        "; "
        "Delta delta ${Gasometricos.D_d_GAP.toStringAsFixed(0)} "
        "("
        "dGAP ${Gasometricos.d_GAP.toStringAsFixed(0)} . . "
        "dHCO3- ${Gasometricos.d_HCO.toStringAsFixed(0)}) "
        " : "
        "Delta ratio ${Gasometricos.D_d_ratio.toStringAsFixed(0)}"
        " . : "
    //
        "PCO2e ${Gasometricos.PCO2esperado.isNaN ? "N/A" : Gasometricos
        .PCO2esperado.toStringAsFixed(2)} mmHg, "
        "EBe ${Gasometricos.excesoBaseEsperado.isNaN ? "N/A" : Gasometricos
        .excesoBaseEsperado.toStringAsFixed(2)} mmol/L, "
        "pH(1ra)e ${Gasometricos.HCOR_a.isNaN ? "N/A" : Gasometricos.HCOR_a
        .toStringAsFixed(2)}, "
        "pH(2da)e ${Gasometricos.HCOR_b.isNaN ? "N/A" : Gasometricos.HCOR_b
        .toStringAsFixed(2)}"
        " . : : . "
    // "EBe ${Valores.pHArteriales} mmol/L, "
        "iCL/NA ${Gasometricos.indiceCloroSodiio.toStringAsFixed(1)}, "
        "difNa/Cl ${Gasometricos.diferenciaSodioCloro.toStringAsFixed(1)} . . "
        "";
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

  /// Indice Cl-/Na+2
  ///  * * Adyuva en la descripción de la Acidosis Metabólica.
  ///  * * * Se explica que,
  ///           valores menores a 0.75 correponden a Iones no medidos
  ///           valores entre 0.75 - 0.79 correponden al Lactato-Cloro e Iones no meididos, por lo que su naturaleza es mixta
  ///           valores mayores a 0.79 correponden a Hipercloremia
  ///
  /// VN: Depende del contexto y de otros valores.
  ///
  /// Consulte : https://www.medigraphic.com/pdfs/medcri/ti-2017/ti173h.pdf
  ///
  static double get NaClindex => (Valores.cloro!) / (Valores.sodio!);

  //
  static double get GAP =>
      (Valores.sodio! + Valores.potasio!) -
          (Valores.cloro! + Valores.bicarbonatoArteriales!);

  static double get GAPA =>
      (Valores.sodioArteriales! + Valores.potasioArteriales!) -
          (Valores.cloro! + Valores.bicarbonatoArteriales!);

  //
  static double get PAFI =>
      (Valores.poArteriales! / (Valores.fioArteriales! / 100));

  static double get PAFI_PB => (PAFI * (Valores.presionBarometrica / 760));

  static double get PAFI_PO2 => (Valores.poArteriales! * (PAFI / 100));

  static double get PAFI_FIO =>
      (Valores.poArteriales! / Valores.fioArteriales!) * 100;

  static double get SAFI =>
      (Valores.soArteriales! / (Valores.fioArteriales! / 100));

  /// pCO2 corregido por Temperatura (°C)
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

  /// pCO2 esperado en Acidosis
  static double get PCO2esperado {
    if (Valores.pHArteriales! >= 7.45) {
      return (Valores.bicarbonatoArteriales! * 1.5) + 8;
    } else if (Valores.pHArteriales! <= 7.35) {
      return (Valores.bicarbonatoArteriales! * 0.7) + 21;
    } else {
      return double.nan;
    }
  }

  static double get excesoBaseEsperado {
    if (Valores.pHArteriales! >= 7.45) {
      return double.nan;
    } else if (Valores.pHArteriales! <= 7.35) {
      return (Valores.pcoArteriales! - 40) * (0.4);
    } else {
      return double.nan;
    }
  }

  static double get EB =>
      ((1 - 0.014 * Valores.hemoglobina!) *
          (Valores.bicarbonatoArteriales! -
              24.8 +
              (1.43 * Valores.hemoglobina! + 7.7) *
                  (Valores.pHArteriales! - 7.4)));

  static double get EBecf =>
      (24) -
          ((Valores.bicarbonatoArteriales! + 10.00) *
              (Valores.pHArteriales! - 7.4)); //  # Bicarbonato Standard

  /// Delta Gap (aGAp)
  static double get d_GAP {
    if (aGapAlb != null || aGapAlb != 0) {
      return (aGapAlb - 12);
    } else {
      return (GAP - 12);
    }
  }

  static double get d_HCO => (25 - Valores.bicarbonatoArteriales!);

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

  static double get D_d_GAP => d_GAP - d_HCO;

  static double get D_d_ratio => d_GAP / d_HCO;

  static double get aGapAlb {
    if (Valores.albuminaSerica != null || Valores.albuminaSerica! != 0) {
      return GAP + (0.25 * (4.4 - Valores.albuminaSerica!));
    } else {
      return GAP;
    }
  }

  static double get aGapAlbArterial {
    if (Valores.albuminaSerica != null || Valores.albuminaSerica! != 0) {
      return GAPA + (0.25 * (4.4 - Valores.albuminaSerica!));
    } else {
      return GAP;
    }
  }


  /// Gap Osmolar (ΔOms)
  ///
  /// *** Existen bibliografias que, de hecho, toman como fórmula OSMmedido * OSMcalculado
  ///       Tal que . . . OSMc = (2*Na2) + (Glu/18)
  /// VN: menor a 10 - 15
  ///         mayor a 25 sugiere Intoxicación por Etilen Glicol
  ///
  ///
  static double get GAPO => ((280) - (Hidrometrias.osmolaridadSerica));

  /// GAPIonesLibres (GIF)
  ///
  /// VN: 0 - 2
  ///
  static double get GIF =>
      diferenciaIonesFuertesAparente -
          diferenciaIonesFuertesEfectiva; //  - (2.46 * 108 * Valores.pcoArteriales! / 10);

  /// Efecto de Aniones y Cationes Principales (EACp)
  ///
  ///
  static double get efectoAnionesCationesPrincipales =>
      (Valores.sodio! - Valores.cloro!) -
          38; //  # Efecto de Aniones y Cationes Principales
  /// Efecto de Buffers Principales (EBp)
  ///
  ///
  static double get efectoPrincipalesBuffers =>
      (0.25 *
          (42.00 -
              Valores.albuminaSerica!)); //  # Efecto de Buffers Principales

  /// Diferencia Aniónica (DA)
  ///
  static double get DA =>
      (efectoAnionesCationesPrincipales -
          efectoPrincipalesBuffers); // # Diferencia Anionica

  /// Verdadero Déficit de Baase
  static double get VDb =>
      (Gasometricos.EB - DA); // # Verdadero Déficit de Base

  static double get EBvGilFix => (Valores.sodio!) - (Valores.cloro!) - 38;

  // *********************************************************
  static double get TCO {
    return ((Valores.bicarbonatoArteriales!) +
        (0.03 * Valores.pcoArteriales!)); //# Dioxido de Carbono Total
  }

  static double get PAO {
    return PIO -
        (Valores.pcoArteriales! * 0.8); // 1.25 # Presión alveolar de oxígeno
    // return (Valores.fioArteriales! / 100) * (760 - 47) -
    //     (Valores.pcoArteriales! / 0.8); // # Presión alveolar de oxígeno
  }

  /// Indice Cloro/Na
  ///
  /// iCL/Na = Cl/Na
  /// - Si menor a 0.75 : Efecto alcalinizante en el plasma
  /// - 0.75 - 0.79 :  Acidosis mixtas
  /// - Si mayor a 0.79 : Acidosis secundaria a Hipercloremia
  static double get indiceCloroSodiio => (Valores.cloro! / Valores.sodio!);

  /// Diferencia Sodio Cloro (difNaCl)
  ///
  /// difNa/Cl = Na - Cl
  ///
  /// Si menor 31 mEq/L : Hipercloremia
  ///
  static double get diferenciaSodioCloro => (Valores.sodio! - Valores.cloro!);

  // *********************************************************
  /// Diferencia de Iones Fuertes Aparente (DIFa) // Strong Ion Difference (SID)
  ///
  /// DIFa= [Na+] + [K+] +[ Mg+] + [Ca+] -[ Cl-]- [Lactato-]
  ///
  /// sDIFa= ([Na+] + [K+]) - [ Cl-]
  ///
  /// * * * En el plasma normal el DIF es igual a 42 mEq/lt.
  ///
  ///               Esto significa que para lograr la electroneutralidad requiero de 42 mEq de iones de carga negativa diferente de los iones fuertes.
  ///
  /// Las causas de DIF disminuido (acidosis metabólica) son:
  ///
  /// * * (1) Acidosis tubular renal: Distal tipo 1 (pH urinario >5,5), Proximal tipo 2 (pH urinario <5,5, K+ sérico bajo); deficiencia de aldosterona tipo 4 (ph urinario < 5,5, K+ sérico alto)
  ///
  /// * * (2) Causas no renales: Gastrointestinal (diarrea, drenaje pancreático, intestino corto); Iatrogénica (nutrición parenteral, salino, resina de intercambio aniónico).
  ///
  /// Consulta : http://www.scielo.org.pe/scielo.php?script=sci_arttext&pid=S1728-59172011000100008
  /// https://image.slidesharecdn.com/alteracionesrespiratoriasdelequilibrioacidobase-120723105118-phpapp02/95/alteraciones-respiratorias-del-equilibrio-acido-base-21-728.jpg?cb=1343041062
  ///
  ///
  /// ANOTACIONES:
  /// . . Ca+2 SU mg/dL a mEq/L : : mg/dL/valencia || Valencia = 2.0
  ///
  /// . . Cl- SU mg/dL a mEq/L  : : mg/dL/valencia || Valencia = 3.55
  ///
  /// . . Mg- SU mg/dL a mEq/L  : : mg/dL/valencia || Valencia = 1.2
  ///
  /// . . Lact- SU mg/dL a mEq/L  : : mg/dL/valencia || Valencia = 9.0
  ///
  /// . . PO3- SU mg/dL a mEq/L  : : mg/dL/valencia || Valencia = 1.54
  ///
  ///
  static double get diferenciaIonesFuertesAparente {
    if (Valores.lactatoArterial != null || Valores.lactatoArterial != 0) {
      // return (Valores.sodio! +
      //     Valores.potasio! ) -
      //     (Valores.cloro!);
      return (Valores.sodio! +
          Valores.potasio! +
          (Valores.calcio!) +
          (Valores.magnesio!)) -
          (Valores.cloro! + Valores.lactatoArterial!);
      return (Valores.sodio! +
          Valores.potasio! +
          (Valores.calcio! / 2.0) +
          (Valores.magnesio! / 1.2)) -
          ((Valores.cloro! / 3.55) + Valores.lactatoArterial!);
    } else {
      return double.nan;
    }
  }

  /// Diferencia de Iones Fuertes Efectiva (DIFe)
  ///
  /// DIFe  [(2.46 x 10 -8 ) x (PCO 2)/ 10 -pH )] + [[Albúmina] g / L x 0.123 x (pH -0.631)]
  /// + [[Fosfatos] mmol / L x 0.309 x (pH -0.469)]
  ///
  static double get diferenciaIonesFuertesEfectiva =>
      Valores.bicarbonatoArteriales! + aTOT;

  // ((2.46 * (10 - 8)) * (Valores.pcoArteriales! / (10 - Valores.pHArteriales!))) + (((Valores.albuminaSerica! * 10) * 0.123 *
  //     (Valores.pHArteriales! - 0.631))) + (Valores.fosforo! * 0.309 * (Valores.pHArteriales! - 0.469));

  /// Ácidos débiles no volátiles (Atot)
  ///
  /// a) Atot = 2 (Albúmina gr/dl) + 0,5 (P04-) mg/dl y su valor normal oscila entre 17 y 19 meq/lt.
  ///
  /// b) Atot = 2,43 * [Proteínas totales].
  ///
  /// c) Atot = [Albúmina (0,123*pH – 0,631] – [Fosfato (0,309*pH – 0,469)]
  ///
  /// c) Atot = [Albúmina] + [Fosfato]
  ///
  /// * * * Forman parte de los Atot la albúmina y el fosfato.
  /// * * * Atot = 2 (Albúmina gr/dl) + 0,5 (P04-) mg/dl y su valor normal oscila entre 17 y 19 meq/lt.
  ///
  /// CONSULTE: https://image.slidesharecdn.com/acidobase-150309000502-conversion-gate01/95/acido-base-12-638.jpg?cb=1425860714
  ///
  static double get aTOT => 2.43 * Valores.proteinasTotales!;

  // ((Valores.albuminaSerica!*10) * (0.123 * Valores.pHArteriales! - 0.631))
  //     - (((Valores.fosforo! *10) * 3.06)* (0.309 * Valores.pHArteriales! - 0.469)); //

  // *********************************************************

  //(Valores.presionGasSeco / (Valores.fioArteriales! / 100));
  static double get PIO =>
      (Valores.presionBarometrica - Valores.presionVaporAgua) *
          (Valores.fioArteriales! / 100);

  /// Gradiente Alveolo Arterial (GAA)
  ///
  /// Otras fórmulas : (PAO - Valores.poArteriales!); //  # Gradiente Alveolo - Arterial

  static double get GAA =>
      (PAO - Valores.poArteriales!); //  # Gradiente Alveolo - Arterial
// static double get GAA => ((Valores.presionBarometrica - Valores.presionVaporAgua) * (Valores.fioArteriales! / 100) -
  //     (Valores.pcoArteriales! / 0.8) -
  //     Valores.poArteriales!); //  # Gradiente Alveolo Arterial

  /// Delta CO2
  ///
  /// VN : Un delta CO2 (PvCO2-PaCO2) mayor a 6 mmhG denotan Hipoperfusión
  ///
  /// Valores normales : menor a 6 mmHg
  ///
  static double get DeltaCOS =>
      (Valores.pcoVenosos!) - (Valores.pcoArteriales!);

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

  /// Saturación Venosa Central (SvcO2)
  ///
  ///
  ///
  static double get SvcO2 =>
      (Valores.soArteriales!) -
          (Valores.DO - Valores.TO) * Valores.hemoglobina!;

  // # ######################################################
  // # Reglas del Bicarbonato
  // # ######################################################
  // # Trastorno de Origen Respiratorio.

  ///  pH esperado por Primera Regla del Bicarbonato
  ///
  /// # Primera Regla del Bicarbonato: Por cada 10 mmHg que varía la pCO2 mmHg, el pH se incrementa o reduce 0.08 unidades en forma inversamente proporcional
  /// # Se suma el HCOR_a al pH Ideal, que es 7.40 si resulta en una discrepancia entonces el Origen del Trastorno no es respiratorio. No cumple la primera regla.
  /// # Trastorno de Origen Metabólico (pH Real)
  ///
  static double get HCOR_a =>
      (7.40) + (((40 - Valores.pcoArteriales!) * 0.08) / 10);

  /// pH esperado por Segunda Regla del Bicarbonato
  ///
  /// # Segunda Regla del Bicarbonato: Por cada 0.15 unidades que se modifican el pH, se incrementa o disminuye el exceso o déficit de base en 10 unidades, que pueden expresarse en mEq/L de bicarbonato
  ///   # Se suma el HCOR_a al pH Ideal, que es 7.40 si resulta en una discrepancia entonces el Origen del Trastorno no es respiratorio. No cumple la primera regla.
  ///   # Reposición de Bicarbonato
  static double get HCOR_b => (Valores.pHArteriales! + ((EB * 0.15) / 10));


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
              (Valores.bicarbonatoArteriales! /
                  (0.03 * Valores.pcoArteriales!)));

  static double get PaO2_estimado => 103.5 - 0.42 * Valores.edad!;

  static double get PaO2_estimado_sedestacion => 104.2 - 0.27 * Valores.edad!;

  static double get PaO2_estimado_decubito => 109.0 - 0.43 * Valores.edad!;

// static double get PAO => (Valores.fioArteriales! / 100) * (720 - 47) - (Valores.pcoArteriales! / 0.8)

  /// Concentración Arterial de Oxígeno
  ///
  /// VN: 14-19ml/O2%
  ///
  static double get CAO =>
      (((Valores.hemoglobina! * 1.34) * (Valores.soArteriales! / 100)) +
          (Valores.poArteriales! *
              0.031)); // / (100); //  # Concentración Arterial de Oxígeno

  /// Concentración Venosa de Oxígeno
  ///
  /// VN: 11-16ml/O2%
  ///
  static double get CVO =>
      (((Valores.hemoglobina! * 1.34) * (Valores.soVenosos! / 100)) +
          (Valores.poVenosos! *
              0.031)); //  / (100); // # Concentración Venosa de Oxígeno

  /// Concentración Capilar de Oxígeno (CcO2)
  ///
  /// VN: 16-20ml/O2%
  ///
  static double get CCO =>
      ((Valores.hemoglobina! * 1.34) +
          (Gasometricos.PAO! * 0.031)); // # Concentración Capilar de Oxígeno
  // (((Valores.hemoglobina! * 1.34) *
  //         (Valores.soVenosos! - Valores.soArteriales!) +
  //     ((Valores.poVenosos! - Valores.poArteriales!) * 0.031)) /
  // (100));

  static double get CACO =>
      (((Valores.hemoglobina! * 1.34) * (Valores.soArteriales! / 100)) +
          (Valores.pcoArteriales! * 0.031)) /
          (100); //  # Concentración Arterial de Oxígeno
  static double get CVCO =>
      (((Valores.hemoglobina! * 1.34) * (Valores.soVenosos! / 100)) +
          (Valores.pcoVenosos! * 0.031)) /
          (100); // # Concentración Venosa de Oxígeno

  static double get DAV => (CAO - CVO); // # Diferencia Arteriovenosa de O2

  /// Delta de CO2 (D_CO2) , DavCO2
  ///     *** Denota Hipoperfusión tisular.
  /// VN: menor 6 mmHg
  ///
  static double get DavCO2 =>
      (CACO - CVCO); // # Diferencia Arteriovenosa de CO2

  /// Delta DavCO2/DavO2 : PavCO2
  ///     Cociente de la división de CO2 veno-arterial y la diferencia arteriovenosa
  /// VN : Menor a 1.6 . . . Normal . .
  ///         Mayor a 1.6 indica Hipoperfusión Tisular
  ///
  static double get DvaCO2DavO2 => (Gasometricos.DeltaCOS - DAV);

  /// Cociente Respiratorio
  ///   ** Tambien expresado como . . .
  ///             CR = VCO2 / VO2
  ///             CR = GC*CavCO2 / GC * CavO2
  ///             CR = D_PavCO2 / D_PavO2
  /// VN mayor a 1 (1,4-1,68 mmHg/mL) . .
  /// * * * Los cambios en el CO2 (efecto Haldane), la concentración de hemoglobina y EO2
  /// tisular influyen en el ∆pv-aCO2 y el ∆pvaCO2/∆Ca-vO2 a pesar de una perfusión
  /// tisular preservada o incluso aumentada.
  /// * * * El argumento en contra más importante es el relacionado con la interacción en la
  /// curva de disociación del CO2. Otro dato importante es el punto de corte ideal para el
  /// ∆pv-aCO2/∆Ca-vO2 el cual aún no está bien
  /// definido, aunque los rangos oscilan entre
  /// 1,4-1,68 mmHg/mL
  /// Consulte : http://scielo.org.co/pdf/rca/v49n1/es_2256-2087-rca-49-01-e500.pdf
  ///
  static double get D_PavCO2D_PavO2 => (D_PavO2 / D_PavCO2);

  static double get D_PavO2 => (Valores.poArteriales! - Valores.poVenosos!);

  static double get D_PavCO2 => (Valores.pcoArteriales! - Valores.pcoVenosos!);

  /// Indice Mitocodrial
  ///
  /// VN : menos de 1.6
  ///          mayor de 1.6 . . . Hipoperfusión Celular
  ///
  static double get indiceMitocondrial => (Gasometricos.DeltaCOS / DAV);

  // # Cociente Respiratorio
  static double get RI => 0.8;

  /// Capacidad de Oxígeno
  static double get capacidadOxigeno =>
      (Valores.hemoglobina! * (1.36)); //  # Capacidad de Oxígeno

  /// Gasto Cardiaco (GC)
  ///
  ///   Como resultad de la DavO2 y CaO2
  ///   VN: 4.75 L/min
  ///
  static double get gastoCardiaco {
    if (DAV != 0) {
      return (((DAV * 100) / CAO) / (DAV)); // # Gasto Cardiaco
    } else {
      return double.nan;
    }
  }

  // Enfoque STEWART ***********************************************************
  /// Enfoque STEWART (Influencia del Lactato)
  ///  * * EB: 1- Lactato
  static double get influenciaLactato {
    if (Valores.lactatoArterial != null || Valores.lactatoArterial != 0 &&
        Valores.lactatoVenoso != null || Valores.lactatoVenoso != 0) {
      return Valores.lactatoArterial! - 1;
    } else {
      return double.nan;
    }
  }

  /// Enfoque STEWART (Influenica de Iones Medibles)
  ///  * * Iones medibles: ([Na2+]+[K+]-[Cl-])-40
  static double get influenciaIonesMedibles {
    if (Valores.sodio != null || Valores.sodio != 0 &&
        Valores.sodio != null || Valores.sodio != 0) {
      return (Valores.sodio! + Valores.potasio! - Valores.cloro!) - 40;
    } else {
      return double.nan;
    }
  }

  /// Enfoque STEWART (Influencia de la Albumina)
  ///  * * Albúmina: (42-[Alb g/L]) * 0.25
  static double get influenciaAlbumina {
    if (Valores.albuminaSerica != null && Valores.albuminaSerica != 0.0) {
      return (0.25 * (42 - (Valores.albuminaSerica! * 10)));
    } else {
      return double.nan;
    }
  }

  /// Enfoque STEWART (Influencia de Otros Iones)
  ///  * * BE-[Lact]-[NaKCl-]-Alb
  static double get influenciaOtrosIones {
    if (Valores.lactatoArterial != null || Valores.lactatoArterial != 0 &&
        Valores.lactatoVenoso != null || Valores.lactatoVenoso != 0) {
      return EB - Valores.lactatoArterial! -
          (Valores.sodio! + Valores.potasio! - Valores.cloro!) -
          Valores.albuminaSerica!;
    } else {
      return double.nan;
    }
  }
}
