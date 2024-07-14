
import 'package:assistant/operativity/pacientes/valores/Valores.dart';

class Lipidometria {

  // FÓRMULAS

  /// Indice Aterogénico (Indice de Castelli)
  ///    VN : Menor a 4 . . Valores normales
  ///             Mayor a 4 . . Aumenta riesgo caardiovascular
  ///
  ///
  static double get indiceAterogenico => (Valores.colesterolTotal! / Valores.cHDL!);

  /// Indice c-LDL / c-HDL
  ///      VN : Menor a 3 (Hombres)
  ///               Menor a 2.5 (Mujeres)
  ///
  static double get indiceLDLHDL => (Valores.cLDL! / Valores.cHDL!);

  /// Indice Trigliceridos/c-HDL (Ratio TG/HDLc)
  ///      VN: Mayor a 2
  ///
  static double get indiceTrigliceridosHDL => (Valores.trigliceridos! / Valores.cHDL!);

  // CALCULOS
  // static double get ldlCalculado => (Valores.colesterolTotal! -(( Valores.trigliceridos! / 5) + LAD));

  static double get vldlCalculado => (Valores.trigliceridos! / 5);

}