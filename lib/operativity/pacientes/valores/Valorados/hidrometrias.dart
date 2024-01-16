import 'package:assistant/operativity/pacientes/valores/Valores.dart';

class Hidrometrias {
  static double get deltaSodio =>
      (sodioInfundido! - Valores.sodio!) / (aguaCorporalTotal + 1); // Adrogue-Madias

  // CALCULOS HIDRICOS ****************************************
  static double get requerimientoHidrico {
    if (Valores.pesoCorporalTotal != 0 && Valores.pesoCorporalTotal != null) {
      return (Valores.pesoCorporalTotal! * constanteRequerimientos!);
    } else {
      return double.nan;
    }
  }

  static double get aguaCorporalTotal {
    if (Valores.pesoCorporalTotal != 0 && Valores.pesoCorporalTotal != null) {
      if (Valores.sexo == "Masculino") {
        return 0.60 * Valores.pesoCorporalTotal!;
      } else if (Valores.sexo == "Femenino") {
        return 0.55 * Valores.pesoCorporalTotal!;
      } else {
        return 0.60 * Valores.pesoCorporalTotal!;
      }
    } else {
      return double.nan;
    }
  }

  static double get excesoAguaLibre {
    if (Valores.sodio != 0 && Valores.sodio != null) {
      return (aguaCorporalTotal) *
          ((1) - (140 / Valores.sodio!)); // Delta H2O Resultado en Litros.
    } else {
      return double.nan;
    }
  }

  static double get deficitAguaCorporal {
    if (Valores.sodio != 0 && Valores.sodio != null) {
      return ((aguaCorporalTotal) *
          ((Valores.sodio! - 140.00) / 140.00)); // Deficit de Agua Corporal
    } else {
      return double.nan;
    }
  }

  // CALCULOS POTASIO ****************************************
  static double get SOL => (aguaCorporalTotal * osmolaridadSerica);

  static double get LIC => aguaCorporalTotal * 0.666;

  static double get LEC => aguaCorporalTotal * 0.333;

  static double get LI => aguaCorporalTotal * 0.222;

  static double get LIV => aguaCorporalTotal * 0.111;

  static double get volumenPlasmatico => aguaCorporalTotal * 0.074;

  static double get VS => aguaCorporalTotal * 0.037;

  static double get kalemiaPorPeriferico =>
      0.25 * Valores.pesoCorporalTotal!; // 0.2 - 0.3 mEq/Kg/Hr [ 40 mEq/L]
  static double get kalemiaPorCentral =>
      0.75 * Valores.pesoCorporalTotal!; // 0.5 - 1.0 mEq/Kg/Hr [ 80 mEq/L]

  // CALCULOS POTASIO ****************************************
  static double get deficitSodio {
    if (Valores.sodio != 0 && Valores.sodio != null) {
      if (Valores.sodio! < 130) {
        return (130 - Valores.sodio!) * (aguaCorporalTotal);
      } else if (Valores.sodio! >= 130) {
        return 130 - Valores.sodio!;
      } else {
        return 0.0;
      }
    } else {
      return 0.0;
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

  // CALCULOS POTASIO ****************************************
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
          (requerimientoBasalPotasio);
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

  // CONCLUSIONES
  static String get hidricosGeneral =>
      "Requerimiento hídrico diario: ${requerimientoHidrico.toStringAsFixed(0)} mL/dia (${constanteRequerimientos.toStringAsFixed(0)} mL/Kg/dia), "
      "agua corporal total ${aguaCorporalTotal.toStringAsFixed(1)} mL, "
      "delta H2O ${excesoAguaLibre.toStringAsFixed(1)} L, "
      "deficit de agua corporal ${deficitAguaCorporal.toStringAsFixed(1)} L. "
      "osmolaridad ${osmolaridadSerica.toStringAsFixed(1)} mOsm/L, "
      "brecha osmolar ${brechaOsmolar.toStringAsFixed(1)} mOsm/L. "
      "$sodioCorregido"
      "Requerimiento de potasio ${requerimientoPotasio.toStringAsFixed(1)}, delta de potasio ${deltaPotasio.toStringAsFixed(1)} mmol/L; "
      "delta de sodio ${deficitSodio.toStringAsFixed(1)} mEq/L. ";

  static String get hidricos =>
      "Requerimiento hídrico diario: ${requerimientoHidrico.toStringAsFixed(0)} mL/dia (${constanteRequerimientos.toStringAsFixed(0)} mL/Kg/dia), "
      "agua corporal total ${aguaCorporalTotal.toStringAsFixed(1)} mL, "
      "delta H2O ${excesoAguaLibre.toStringAsFixed(1)} L, "
      "osmolaridad sérica ${osmolaridadSerica.toStringAsFixed(0)} mOsm/L, "
      "";

  static String get sodios => "$sodioCorregido"
      "Reposición de sodio ${reposicionSodio.toStringAsFixed(1)} mEq/L, "
      "déficit de sodio ${deficitSodio.toStringAsFixed(1)} mEq/L, "
      "delta de sodio ${deltaSodio.toStringAsFixed(1)} mEq/L, "
      "";

  static String get potasios =>
      "Requerimiento basal de potasio ${requerimientoBasalPotasio.toStringAsFixed(1)} mEq/L, "
      "Requerimiento de potasio ${reposicionPotasio.toStringAsFixed(1)} mEq/L ("
      "${((reposicionPotasio / 3) * 1).toStringAsFixed(2)} mEq/L : ${((reposicionPotasio / 3) * 2).toStringAsFixed(2)} mEq/L), "
      "velocidad de infusión "
      "${kalemiaPorPeriferico.toStringAsFixed(2)} mEq/Hr (Periférico), "
      "${kalemiaPorCentral.toStringAsFixed(2)} mEq/Hr (Central), "
      "delta de potasio ${deltaPotasio.toStringAsFixed(1)} mEq/L, "
      "potasio ajustado a pH ${pHKalemia.toStringAsFixed(1)} mEq/L, "
      "";

  static String get sodioCorregido {
    if (Valores.glucosa! > 200) {
      return "Sodio Corregido: $sodioCorregidoGlucosa mEq/L. ";
    } else {
      return "";
    }
  }

  // Variables
  static int? constante = 00;
  static int? sodioInfundido = 00;

  // CONSTANTES
  static double constanteRequerimientos = 30;

  // RELACIONES
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

  static double get brechaOsmolar => (290.00 - (osmolaridadSerica));
}
