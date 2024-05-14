import 'package:assistant/operativity/pacientes/valores/Valores.dart';

class Ascitometrias {
  static double? glucosaAscitis = 0,
      colesterolAscitis = 0,
      dhlAscital = 0,
      proteinasAscital = 0,
      albuminaAscital = 0;

  //
  static double get relacionGlucosa {
    if (glucosaAscitis != null) {
      return glucosaAscitis! / Valores.glucosa!;
    } else {
      return double.nan;
    }
  }

  static double get relacionAlbumina {
    if (albuminaAscital != null) {
      return Valores.albuminaSerica! / albuminaAscital!;
    } else {
      return double.nan;
    }
  }

  static double get relacionDHL {
    if (dhlAscital != null) {
      return Valores.deshidrogenasaLactica! / dhlAscital!;
    } else {
      return double.nan;
    }
  }

  static double get relacionProteinas {
    if (proteinasAscital != null) {
      return Valores.proteinasTotales! / proteinasAscital!;
    } else {
      return double.nan;
    }
  }
}
