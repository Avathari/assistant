import 'package:assistant/operativity/pacientes/valores/Valores.dart';

class Pleurometrias {
  static double? dhlPleural, proteinasPleural;

  //
  static double get relacionDHL {
    if (dhlPleural != null) {
      return Valores.deshidrogenasaLactica! / dhlPleural!;
    } else {
      return double.nan;
    }
  }

  static double get relacionProteinas {
    if (proteinasPleural != null) {
      return Valores.proteinasTotales! / proteinasPleural!;
    } else {
      return double.nan;
    }
  }
}
