import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/ferricos.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/info/info.dart';

class Citometrias {
  // ANALISIS
  static String esAnemia() {
    if (Datos.isUpperValue(value: Valores.hemoglobina!, lim: 16)) {
      return "Hemoconcentración";
    } else if (Datos.isMiddleValue(
        value: Valores.hemoglobina!, min: 12, max: 16)) {
      return "Normal";
    } else if (Datos.isMiddleValue(
        value: Valores.hemoglobina!, min: 10, max: 12)) {
      return "Anemia Grado I";
    } else if (Datos.isMiddleValue(
        value: Valores.hemoglobina!, min: 8, max: 10)) {
      return "Anemia Grado II";
    } else if (Datos.isMiddleValue(
        value: Valores.hemoglobina!, min: 6, max: 8)) {
      return "Anemia Grado III";
    } else if (Datos.isInnerValue(value: Valores.hemoglobina!, lim: 6)) {
      return "Anemia Grado IV";
    } else {
      return "Normal";
    }
  }

  static String tamanoEritrocitario() {
    if (Datos.isUpperValue(value: Valores.volumenCorpuscularMedio!, lim: 107)) {
      return "Macrócítica";
    } else if (Datos.isMiddleValue(value: Valores.volumenCorpuscularMedio!, min: 80, max: 107)) {
      return "Normocítica";
    } else if (Datos.isInnerValue(value: Valores.volumenCorpuscularMedio!, lim: 80)) {
      return "Microcítica";
    } else {
      return "Tamaño Normal";
    }
  }

  static String aspectoEritrocitario() {
    if (Datos.isUpperValue(value: Valores.hemoglobinaCorpuscularMedia!, lim: 35)) {
      return "Hipercrómica";
    } else if (Datos.isMiddleValue(value: Valores.hemoglobinaCorpuscularMedia!, min: 27, max: 35)) {
      return "Normocrómica";
    } else if (Datos.isInnerValue(value: Valores.hemoglobinaCorpuscularMedia!, lim: 27)) {
      return "Hipocrómica";
    } else {
      return "Aspecto Normal";
    }
  }
  // CONCLUSIONES
 static String hematicos () {
    if (Datos.isInnerValue(value: Valores.hemoglobina!, lim: 12)) {
      if (Datos.isUpperValue(value: Valores.volumenCorpuscularMedio!, lim: 107)) { // MACROCITOSIS
        if (Datos.isUpperValue(value: Valores.anchoDistribucionEritrocitaria! , lim: 14)) {
          return "Eritrocitario - "
              "${esAnemia()} "
              "${tamanoEritrocitario()} "
              "${aspectoEritrocitario()}, "
              "Hb ${Valores.hemoglobina!} g/dL, "
              "VCM ${Valores.volumenCorpuscularMedio!} fL, "
              "HCM ${Valores.hemoglobinaCorpuscularMedia!} pg, "
              "ADE Alto (${Valores.anchoDistribucionEritrocitaria!.toStringAsFixed(2)} %) : "
              "${infoCitometrias.clusterVCMaltoRDWalto}";
        } else {
          return "Eritrocitario - "
              "${esAnemia()} "
              "${tamanoEritrocitario()} "
              "${aspectoEritrocitario()}, "
              "Hb ${Valores.hemoglobina!} g/dL, "
              "VCM ${Valores.volumenCorpuscularMedio!} fL, "
              "HCM ${Valores.hemoglobinaCorpuscularMedia!} pg, "
              "ADE Normal (${Valores.anchoDistribucionEritrocitaria!.toStringAsFixed(2)} %) : "
              "${infoCitometrias.clusterVCMaltoRDWnormal}";
        }

      } else if (Datos.isMiddleValue(value: Valores.volumenCorpuscularMedio!, min: 80, max: 107)) { // NORMOCITOSIS
        if (Datos.isUpperValue(value: Valores.anchoDistribucionEritrocitaria! , lim: 14)) {
          return "Eritrocitario - "
              "${esAnemia()} "
              "${tamanoEritrocitario()} "
              "${aspectoEritrocitario()}, "
              "Hb ${Valores.hemoglobina!} g/dL, "
              "VCM ${Valores.volumenCorpuscularMedio!} fL, "
              "HCM ${Valores.hemoglobinaCorpuscularMedia!} pg, "
              "ADE Alto (${Valores.anchoDistribucionEritrocitaria!.toStringAsFixed(2)} %) : "
              "${infoCitometrias.clusterVCMnormalRDWalto}";
        } else {
          return "Eritrocitario - "
              "${esAnemia()} "
              "${tamanoEritrocitario()} "
              "${aspectoEritrocitario()}, "
              "Hb ${Valores.hemoglobina!} g/dL, "
              "VCM ${Valores.volumenCorpuscularMedio!} fL, "
              "HCM ${Valores.hemoglobinaCorpuscularMedia!} pg, "
              "ADE Normal (${Valores.anchoDistribucionEritrocitaria!.toStringAsFixed(2)} %) : "
              "${infoCitometrias.clusterVCMnormalRDWnormal}";
        }

      } else if (Datos.isInnerValue(value: Valores.volumenCorpuscularMedio!, lim: 80)) { // MICROCITOSIS
        if (Datos.isUpperValue(value: Valores.anchoDistribucionEritrocitaria! , lim: 14)) {
          return "Eritrocitario - "
              "${esAnemia()} "
              "${tamanoEritrocitario()} "
              "${aspectoEritrocitario()}, "
              "Hb ${Valores.hemoglobina!} g/dL, "
              "VCM ${Valores.volumenCorpuscularMedio!} fL, "
              "HCM ${Valores.hemoglobinaCorpuscularMedia!} pg, "
              "ADE Alto (${Valores.anchoDistribucionEritrocitaria!.toStringAsFixed(2)} %) : "
              "${infoCitometrias.clusterVCMbajoRDWalto}; "
              "Indice Metzner ${indiceMetzner.toStringAsFixed(0)}. "
              "Perfil de Hierro ${Ferricos.ferricos()}"
              "";
        } else {
          return "Eritrocitario - "
              "${esAnemia()} "
              "${tamanoEritrocitario()} "
              "${aspectoEritrocitario()}, "
              "Hb ${Valores.hemoglobina!} g/dL, "
              "VCM ${Valores.volumenCorpuscularMedio!} fL, "
              "HCM ${Valores.hemoglobinaCorpuscularMedia!} pg, "
              "ADE Normal (${Valores.anchoDistribucionEritrocitaria!.toStringAsFixed(2)} %) : "
              "${infoCitometrias.clusterVCMbajoRDWnormal}; "
              "Indice Metzner ${indiceMetzner.toStringAsFixed(0)}. "
              "";
        }
      } else {
        return "Tamaño Normal";
      }


    } else {  // HEMOGLOBINA NORMAL
      return "Hemoglobina Normal";
    }
 }

  // FÓRMULAS
  static double get VCM =>
      (Valores.hematocrito! / Valores.eritrocitos!) * 10; // 80 - 98 fL
  static double get HCM =>
      (Valores.hemoglobina! / Valores.eritrocitos!) * 10; // 27 - 32 pg
  static double get CMHC =>
      (Valores.hemoglobina! / Valores.hematocrito!) * 100; // 30 - 38 g/dL

  /// Deficit de Hierro
  ///     Fe_Def = [PCT (kG) * (15-Hb)] + 100 . .
  ///       * Si la Hb es mayor a 15 g/dL, el resultado será 0 .
  /// VN :
  static double get deficitHierro =>
      (Valores.pesoCorporalTotal! * (15 - Valores.hemoglobina!)) +
      1000; // 0 - 0 mg {0.001 : gr}

  // INDICES
  static double get indiceMetzner =>
      Valores.volumenCorpuscularMedio! /
      Valores
          .eritrocitos!; // menor a 13 : Talasemia menor; mayor 13 : Deficiencia de Hierro

  /// Indice de Protrombina
  ///
  /// * * * Determina la relación del tiempo de protrombina comparado con cTP ordinal; en este caso, 30 segundos como estándar
  /// * * * * Sirve para determinar alteraciones de la Vía Extrínseca
  /// VN:
  ///
  static double get indiceProtrombina => (Valores.tiempoProtrombina! / 30);
// RELACIONES
}

//VPM - Volumen Plaquetar Medio : 9 +/-2 fL
// PDW - Indice de Distribución Plaquetar : 45 +/- 20%

