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
