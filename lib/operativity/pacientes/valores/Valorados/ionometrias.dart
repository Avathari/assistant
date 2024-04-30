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

  /// Indice de Falla Renal (IFR / RFI)
  ///
  /// * * * Se usa para diferenciar entre Insuficiencia Renal "renal o prerenal".
  /// RFI > 1% (> 0.01 fracción) indica causa renal.
  ///
  /// RFI < 1% (< 0.01 fracción) indica causa prerenal.
  ///
  /// Consulte : https://www.bing.com/images/search?view=detailV2&ccid=TW4Svsqn&id=3B0B1ACB06DCE14F8937FBA8BA5469752E963776&thid=OIP.TW4Svsqn4_kaPzGqZ0LkmAHaFD&mediaurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.4d6e12becaa7e3f91a3f31aa6742e498%3frik%3ddjeWLnVpVLqo%252bw%26riu%3dhttp%253a%252f%252fwww.saludinfantil.org%252fGuia_Alegria%252fguia%252f32.-Insuficiencia_Renal_Aguda%252fimagen%2b4%2bcapitulo%2b32.jpg%26ehk%3dD1luWWan0NTPfvuefgnnf2My2DHt6iOaocFmvx%252fS5vA%253d%26risl%3d%26pid%3dImgRaw%26r%3d0&exph=815&expw=1195&q=%c3%adndice+de+falla+renal&simid=608030961678764804&FORM=IRPRST&ck=0A8FCE5CF2249B9B037239FDFA0B25DE&selectedIndex=7&itb=0
  ///
  /// https://www.scymed.com/es/smnxps/pspdm085.htm
  ///
  /// https://www.msdmanuals.com/es-mx/professional/multimedia/table/%C3%ADndices-diagn%C3%B3sticos-urinarios-en-la-lesi%C3%B3n-renal-aguda-prerrenal-y-la-lesi%C3%B3n-tubular-aguda
  ///
  /// https://www.bing.com/images/search?view=detailV2&ccid=BHiIhFRR&id=B2CB9C75F925FFC953BD17DBDC3A08196B1B7749&thid=OIP.BHiIhFRRFJPur1h_eV-srgHaEp&mediaurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.0478888454511493eeaf587f795facae%3frik%3dSXcbaxkIOtzbFw%26riu%3dhttp%253a%252f%252fwww.chuletasmedicas.com%252fwp-content%252fuploads%252f2019%252f02%252finsuficiencia-renal-aguda-clasificacion-etiologica-chuleta.jpg%26ehk%3dpBVt816hbDtg0E%252fK5HvyA7DHzBf6%252f7dAPFizYPj8Cs0%253d%26risl%3d%26pid%3dImgRaw%26r%3d0&exph=942&expw=1500&q=%c3%adndice+de+falla+renal&simid=608052943329189504&FORM=IRPRST&ck=E7CE73A55496613873E155A5754A88E9&selectedIndex=9&itb=0
  ///
  /// https://www.bing.com/images/search?view=detailV2&ccid=YITg%2fsal&id=5AD6CDFFF131322A8D841DB6B45FE62ABFAAC994&thid=OIP.YITg_salN9aa6WL2c81GwgHaHg&mediaurl=https%3a%2f%2fi.pinimg.com%2foriginals%2f6a%2f53%2f05%2f6a5305cfa8031146edd9f7432e1f0584.jpg&cdnurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.6084e0fec6a537d69ae962f673cd46c2%3frik%3dlMmqvyrmX7S2HQ%26pid%3dImgRaw%26r%3d0&exph=1094&expw=1080&q=%c3%adndice+de+falla+renal&simid=608026666710029736&FORM=IRPRST&ck=8450924DB89AC7059F935EA477DABEEB&selectedIndex=10&itb=0
  ///
  static double get indiceFallaRenal {
    if (sodioUrinario != null) {
      return (sodioUrinario! / (creatininaUrinaria! / Valores.creatinina!));
    } else {
      return double.nan;
    }
  }
}
