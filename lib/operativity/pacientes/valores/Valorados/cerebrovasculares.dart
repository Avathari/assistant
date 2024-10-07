import 'package:assistant/operativity/pacientes/valores/Valorados/cardiometrias.dart';

class Cerebrovasculares {

  /// https://revistachilenadeanestesia.cl/revchilanestv5008101043/
  ///
  ///

  /// Presión Intracraneal inferida por DVNO (PIC-DVNO)
  ///        La presión Intracraneal (PIC) es de 7- 15 mmHg en adultos, considerándose como normal hasta 20mmHg.
  ///
  /// https://th.bing.com/th/id/R.0d70fd3406b7fc78518b953014d1d433?rik=XTs%2f5zSYLui5Lw&pid=ImgRaw&r=0
  /// https://pbs.twimg.com/media/F2U_gibXIAAVScD.jpg
  ///
  static double picDVNO(double dvno) {
    return (dvno * 5.69) - 8.23;
    return double.nan;
}

/// Presión de Perfusión Cerebral (PPC)
  /// Es la relación de la presión existente entre el parénquima cerebral, sangre y líquido al interior del cráneo rígido.
  ///        La presión Intracraneal (PIC) es de 7- 15 mmHg en adultos, considerándose como normal hasta 20mmHg.
  /// Permite determinar la presión de la perfusión cerebral (PPC) mediante la fórmula:
  ///        PPC=PAM (presión arterial media) – PIC.
static double presionPrefusionCerebral(double dvno) {
  return Cardiometrias.presionArterialMedia - picDVNO(dvno);
}
///  El FSC es por lo tanto, grande, recibe casi el 20% del gasto cardiaco, aunque sólo representa el 4% del volumen intracraneal.
  ///         En condiciones normales el FSC en un adulto sano es de 50 ml/100 g de tejido cerebral/minuto.
  ///         Este valor es diferente en los niños y en los ancianos
  ///
  /// https://www.scielo.org.mx/scielo.php?script=sci_arttext&pid=S2444-054X2019000500580
  ///
  /// (PIC = PPC/FSC) esfuerzos, respiración y tos.
  ///  . . . PIC*PPC = FSC
  ///

    static double flujoSanguineoCerebral(double dvno) {
      return presionPrefusionCerebral(dvno)*picDVNO(dvno);
        }

}