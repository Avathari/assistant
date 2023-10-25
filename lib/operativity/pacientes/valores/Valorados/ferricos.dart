import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/info/info.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';

class Ferricos {
  // ANALISIS
  static String ferricos() {
    if (Datos.isUpperValue(value: Valores.ferritinaSerica!, lim: 300)) {
      if (Datos.isUpperValue(value: indiceSaturacionTransferrina, lim: 45)) {
        return "Posible Sobrecarga de Hierro ${infoFerritina.clusterFerritinaBajaTSATelevado}";
      } else { //  if (Datos.isInnerValue(value: indiceSaturacionTransferrina, lim: 45)) { || }
        return "Otras causas de Ferritina elevada: ${infoFerritina
            .clusterFerritinaAltaTSATbajo}";
      }
    } else if (Datos.isInnerValue(value: Valores.ferritinaSerica!, lim: 300)) {
      return "";
    } else {
      return "";
    }
  }

  // CONCLUSIONES

  // FÓRMULAS
  // static double get VCM => (Valores.hematocrito! / Valores.eritrocitos!) * 10; // 80 - 98 fL
  // TSAT
  static double get indiceSaturacionTransferrina =>
      (Valores.hierroSerico! * 100) /
      Valores
          .transferrinaSerica!; // 25 - 50% : Eritropoyesis ferropénica menor a 16%
}

// Hierro sérico : : 50 - 150 g/dL
// Ferritina 30 -300 ng/dL (H); 14 - 200 ng/dL (Mujeres)
// Transferrina 170 - 290 mg/dL
// CFT 250 - 370 IJg/dL
// IS 25-50%
// Receptor de Transferrina 1.25-1.75 mg/I
// Contenido de Hemoglobina Reticulocitaria 27-30
// Protoporfirina Eritrocitaria Libre menor 75%
// TIBC : 300 - 600 g/dL (Transferrina Sérica)
