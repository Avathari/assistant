import 'package:assistant/operativity/pacientes/valores/Valores.dart';

class Cefalorraquideos {
  static double? presionAperturaLCR;
  static double? phLCR,
      eritrocitosLCR,
      hemoglobinaLCR,
      leucocitosLCR,
      polimorfonuclearesLCR, mononuclearesLCR;
  static double? glucosaLCR, albuminaLCR, proteinasLCR;
  static double? adaLCR, lactatoDeshidrogenasaLCR, lactatoLCR, dimeroLCR;

  static double get relacionGlucosa {
    if (Cefalorraquideos.glucosaLCR != null &&
        Cefalorraquideos.glucosaLCR != 0) {
      return Cefalorraquideos.glucosaLCR! / Valores.glucosa!;
    } else {
      return double.nan;
    }
  }

  static double get relacionAlbumina {
    if (Cefalorraquideos.albuminaLCR != null &&
        Cefalorraquideos.albuminaLCR != 0) {
      return Cefalorraquideos.albuminaLCR! / Valores.albuminaSerica!;
    } else {
      return double.nan;
    }
  }

  /// Recuento ajustado de glóbulos blancos en el líquido cefalorraquídeo en presencia de glóbulos rojos
  ///
  ///  Esta fórmula debe utilizarse como factor de corrección para el recuento ajustado de leucocitos en el LCR en presencia de glóbulos rojos en el LCR.
  ///
  /// En la ecuación, la cantidad que se resta es el recuento de glóbulos blancos en LCR previsto que ocurriría si todos los glóbulos blancos en LCR fueran el resultado de la contaminación de la sangre.
  ///
  /// Grupos de leucocitos: glóbulos blancos; LCR: líquido cefalorraquídeo; RBC: glóbulos rojos.
  ///
  /// * * Fórmula : Adjusted_WBCs_in_CSF = Measured_WBCs_in_CSF - ((WBCs_in_blood * RBCs_in_CSF) / (RBCs_in_blood * 1000000))
  ///
  /// CONSULTE . . Tunkel AR. Approach to the patient with central nervous system infection. In: Principles and Practice of Infectious Diseases, 7th ed, Mandell GL, Bennett JE, Dolin R (Eds), Churchill Livingstone Elsevier, Philadelphia 2010. Vol 1, p.1183.
  ///
  /// Bonadio WA. The cerebrospinal fluid: physiologic aspects and alterations associated with bacterial meningitis. Pediatr Infect Dis J 1992; 11:423.
  static double get leucocitosRealesLCR {
    if (Cefalorraquideos.leucocitosLCR != null &&
        Cefalorraquideos.leucocitosLCR != 0) {
      return (Cefalorraquideos.leucocitosLCR!) -
          ((Valores.leucocitosTotales! * Cefalorraquideos.eritrocitosLCR!) /
              (Valores.eritrocitos! * 1000000));
    } else {
      return double.nan;
    }
  }

  /// Calculo de Proteinas Totales en LCR
  ///  * Valores.eritrocitos! == se refiere estrictamente al número de Cayados(%)
  static double get proteinasRealesLCR {
    if (Cefalorraquideos.proteinasLCR != null &&
        Cefalorraquideos.proteinasLCR != 0 &&
        Cefalorraquideos.eritrocitosLCR != null &&
        Cefalorraquideos.eritrocitosLCR != 0) {
      return Cefalorraquideos.proteinasLCR! -
          (Valores.eritrocitos! *
              1000 *
              (1 - Valores.hematocrito! / 100) *
              Cefalorraquideos.eritrocitosLCR! /
              (Valores.eritrocitos! * 1000000));
    } else {
      return double.nan;
    }
  }
}
