import 'dart:math';

import 'package:assistant/operativity/pacientes/valores/Valores.dart';

class Renometrias {

  static String renales({isAbreviado = true}) {
    if (isAbreviado) {
      return "Tasa de Filtrado Glomerular : $claseTasaRenal (KDIGO:CKD-EPI). "
          "Relación Urea - Creatinina ${ureaCreatinina.toStringAsFixed(1)} ($uremia)";
    } else {
      return "Tasa de Filtrado Glomerular : "
          "${tasaRenalCrockoft_Gault.toStringAsFixed(2)} mL/min/1.73 m2 (Cockcroft-Gault), "
          "${tasaRenalMDRD.toStringAsFixed(2)} mL/min/1.73 m2 (M.D.R.D. 4), "
          "${tasaRenalCKDEPI.toStringAsFixed(2)} mL/min/1.73 m2 (C.K.D. E.P.I.); "
          "Clasificación (Estadio) $claseTasaRenal (KDOQI / KDIGO)."
          "Relación Urea - Creatinina ${ureaCreatinina.toStringAsFixed(1)} ($uremia})";
    }
  }

  // CALCULOS
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
          ((pow(Valores.creatinina!, -1.154) *
              (pow(Valores.edad!, -0.203) * (1.0) * (1.0))))));
    } else if (Valores.sexo! == 'Femenino') {
      return ((186.3 *
          ((pow(Valores.creatinina!, -1.154) *
              (pow(Valores.edad!, -0.203) * (1.018) * (1.0))))));
    } else {
      return 0.0;
    }
  }

  static double get tasaRenalCKDEPI {
    if (Valores.sexo! == 'Masculino') {
      return ((141 *
          (pow((Valores.creatinina! / 0.9), -0.411)) *
          (pow((Valores.creatinina! / 0.9), -1.209)) *
          (pow(0.993, Valores.edad!)) *
          (1.0) *
          (1.0)));
    } else if (Valores.sexo! == 'Femenino') {
      return ((141 *
          (pow((Valores.creatinina! / 0.9), -0.411)) *
          (pow((Valores.creatinina! / 0.9), -1.209)) *
          (pow(0.993, Valores.edad!)) *
          (1.018) *
          (1.0)));
    } else {
      return 0.0;
    }
  }

  static String get claseTasaRenal {
    String clasificacion = '';
    double tfgPace = (tasaRenalCrockoft_Gault +
        tasaRenalMDRD +
        tasaRenalCKDEPI) /
        3;
    if (tfgPace <= 15) {
      clasificacion =
      "Estadio G5 ${tfgPace.toStringAsFixed(2)} mL/min/1.73 m2";
    } else if (tfgPace <= 29) {
      clasificacion =
      "Estadio G4 ${tfgPace.toStringAsFixed(2)} mL/min/1.73 m2";
    } else if (tfgPace <= 44) {
      clasificacion =
      "Estadio G3b  ${tfgPace.toStringAsFixed(2)} mL/min/1.73 m2";
    } else if (tfgPace <= 59) {
      clasificacion =
      "Estadio G3a ${tfgPace.toStringAsFixed(2)} mL/min/1.73 m2";
    } else if (tfgPace <= 89) {
      clasificacion =
      "Estadio G2 ${tfgPace.toStringAsFixed(2)} mL/min/1.73 m2";
    } else if (tfgPace <= 140) {
      clasificacion =
      "Estadio G1 ${tfgPace.toStringAsFixed(2)} mL/min/1.73 m2";
    } else {
      clasificacion =
      "Estadio G1 ${tfgPace.toStringAsFixed(2)} mL/min/1.73 m2";
    }

    return clasificacion;
  }

  static double get ureaCreatinina => Valores.urea! / Valores.creatinina!;

  static String get uremia {
    if (ureaCreatinina >= 20) {
      return 'Azoemia Prerrenal';
    } else if (ureaCreatinina > 10 && ureaCreatinina > 15) {
      return 'Azoemia Posrrenal';
    } else if (ureaCreatinina <= 10) {
      return 'Azoemia Renal';
    } else {
      return 'Normal';
    }
  }

  /// Indice de Insuficiencia Renal (RFI)
  ///
  /// Se usa para diferenciar entre Insuficiencia Renal "renal o prerenal".
  ///
  /// RFI > 1% (> 0.01 fracción) indica causa renal.
  ///
  /// RFI < 1% (< 0.01 fracción) indica causa prerenal.
  ///
  /// puede consultar https://www.scymed.com/es/smnxps/pspdm085.htm
  ///
  static double? get indiceFallaRenal{
    if (Valores.creatinina != null) {
      if (Valores.creatininaUrinarios != null) {
        if (Valores.sodioUrinarios != null) {
          return (Valores.sodioUrinarios!) /
              (Valores.creatininaUrinarios! / Valores.sodioUrinarios!);
        }
      }
    } else {
      return null;
    }
    return null;
  }


  /// Fracción Excretada de Sodio (FeNa2+) . . .
  ///
  static double get fraccionExcretadaSodio => Valores.urea! / Valores.creatinina!;
}