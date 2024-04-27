import 'package:assistant/operativity/pacientes/valores/Valores.dart';

class Ionometrias {
  static double? sodioUrinario,
      potasioUrinario,
      cloroUrinario,
      calcioUrinario,
      fosforoUrinario,
      magnesioUrinario,
      //
      creatininaUrinaria,
      ureaUrinaria,
      //
      glucosaUrinario;

  static double get osmolaridadUrinaria {
    if (sodioUrinario != null && potasioUrinario != null && glucosaUrinario != null) {
      return (2 * (sodioUrinario! + potasioUrinario!)) + (glucosaUrinario! / 18);
    } else {
      return double.nan;
    }

  }
  static double get osmolaridadUrinariaPorDensidad =>
      (((Valores.densidadUrinaria! - 1) * 1000) * 30);
  //
  static double get fraccionExcrecionUrea {
    if (ureaUrinaria != null && creatininaUrinaria != null) {
      return (ureaUrinaria! / Valores.urea!) /
          (creatininaUrinaria! / Valores.creatinina!) *
          100;
    } else {
      return double.nan;
    }

  }

  static double get fraccionExcrecionFosforo => double
      .nan; // (ureaUrinaria! / Valores.urea!)/(creatininaUrinaria!/Valores.creatinina!)*100;
  //
  static double get fraccionExcrecionPotasio {
    if (potasioUrinario != null && creatininaUrinaria != null) {
      return (potasioUrinario! / Valores.creatinina!) /
          (Valores.potasio! / creatininaUrinaria!) *
          100;
    } else {
      return double.nan;
    }
  }

  static double get fraccionExcrecionSodio {
    if (sodioUrinario != null) {
      return (sodioUrinario! / Valores.sodio!) * 100;
    } else {
      return double.nan;
    }
  }
  //
}
