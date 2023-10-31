import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/gasometricos.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';

class Cardiometrias {
  // ANALISIS

  // CONCLUSIONES
  static String get cardiovasculares =>
      "Parámetros Cardiovasculares - Presión Arterial Media: ${Cardiometrias.presionArterialMedia} mmHg. "
      // "(${Cardiometrias.clase})
          "Diferencia de Presión Arterial ${Cardiometrias.diferenciaTensionArterial} mmHg. "
          "Presión de Pulso: ${Cardiometrias.presionPulso} mmHg. "
          "Producto Frecuencia - Presión: ${Cardiometrias.productoFrecuenciaPresion} mmHg/Lpm. "
          "Presión Coloido - Oncótica: ${Valores.presionColoidoOsmotica}  mmHg. "
          "Frecuencia Cárdiaca Máxima: ${Cardiometrias.frecuenciaCardiacaMaxima} L/min. "
          "Frecuencia Cárdiaca Blanco: ${Cardiometrias.frecuenciaCardiacaBlanco} L/min. "
          "Frecuencia Cárdiaca Intrínseca: ${Cardiometrias.frecuenciaCardiacaIntrinseca} L/min. "
          "Volemia Aproximada: ${Valores.volemiaAproximada} mL,  "
          "Volumen Plasmático Aproximado: ${Valores.volumenPlasmatico} L,  "
          "Gasto Cárdiaco Aproximado: ${Cardiometrias.gastoCardiacoFick} L/min. "
          "Volumen Látido Aproximado: ${Valores.indiceVolumenSanguineo} mL/min. \n"
          "Parámetros Hemodinámicos - "
          "Concentración Arterial de Oxígeno (CaO2): ${Valores.CAO}  mL/dL, "
          "Concentración Venosa de Oxígeno (CvO2): ${Valores.CVO}  mL/dL, "
          "Diferencia Arterio - Venosa (DavO2): ${Valores.DAV}  mL/dL, "
          "Capacidad de Oxígeno (CapO2): ${Valores.CO}  mL O2/g Hb. "
          "Indice Cárdicado (I.C.): ${Valores.indiceCardiaco} L/min/m2, "
          "Resistencias Venosas Sistémicas (R.V.S.): ${Valores.RVS} Dinas/seg/cm2. "
          "Indice de Extracción de Oxígeno (I.E.O.): ${Valores.IEO} %, "
          "Disponibilidad de Oxígeno (dO2): ${Valores.DO} mL/min,  "
          "Consumo de Oxígeno (cO2): ${Valores.CAO} mL/min/m2, "
          "Transporte de Oxígeno (TO2): ${Valores.TO} mL/O2/m2. "
          "Shunt Fisiológico (QS/QT): ${Valores.SF} %. "
          "Gradiente Alveolo - Arterial (G(A-a)): ${Gasometricos.GAA} mmHg. \n"
          "Trabajo Cardiaco - Trabajo Cardiaco: ${Valores.TC} Kg*m. "
          "Trabajo Látido Ventricular Izquierdo: ${Cardiometrias.TLVI} g*m. "
          "Trabajo Látido Ventricular Derecho: ${Cardiometrias.TLVD} g*m. \n";


// FÓRMULAS

  static double get presionArterialMedia =>
      (Valores.tensionArterialSystolica! +
          (2 * Valores.tensionArterialDyastolica!)) /
          3; //# Tensión Arterial Media
  static String get clasificacionTAM {
    if ((presionArterialMedia > 110)) {
      return "Hipertension Arterial";
    } else if ((presionArterialMedia < 65)) {
      return "Hipotension Arterial";
    } else {
      return "Normo - Tensión Arterial";
    }
  }

  static int get diferenciaTensionArterial =>
      (Valores.tensionArterialSystolica!) -
          (Valores.tensionArterialDyastolica!); //# Diferencia Tensión Arterial
  static int get productoFrecuenciaPresion => (Valores.frecuenciaCardiaca! *
      Valores.tensionArterialSystolica!); //# Producto Frecuencia Presión
  static int get presionPulso => (Valores.tensionArterialSystolica! -
      Valores.tensionArterialDyastolica!); //  # Presión Pulso

  static int get frecuenciaCardiacaMaxima {
    if (Valores.sexo == ("Masculino")) {
      return (220 - Valores.edad!);
    } // # Frecuencia_Cardiaca_Maxima
    else if (Valores.sexo == ("Femenino")) {
      return (226 - Valores.edad!);
    } else {
      return 0;
    } //# Frecuencia_Cardiaca_Maxima
  }

  static double get frecuenciaCardiacaBlanco =>
      ((220 - Valores.edad!) * 0.7); // # Frecuencia_Cardiaca_Blanco
  static double get frecuenciaCardiacaIntrinseca =>
      (118.1 - (0.57 * Valores.edad!)); // # Frecuencia Cardiaca Intrinseca
  // Paramétros con Catéter Swan-Ganz
  static double get resistenciaVascularPulmonar => // PC
  ((Valores.proteinasTotales! - Valores.albuminaSerica!) * 1.4) +
      (Valores.albuminaSerica! * 5.5); //  # Rest. Vasc. Pulmonar 45 - 255 dinas
  static double get TLVI =>
      Valores.VLS *
          Cardiometrias.presionArterialMedia *
          0.0144; //  # Trabajo Latido Ventricular Izquierdo : : 75 - 115 g/Lat/m2
  static double get iTLVI =>
      TLVI / Antropometrias.SCS; //  # Indice Trabajo Latido Ventricular Izquierdo
  static double get TLVD => 00.00; //  # Trabajo Latido Ventricular Derecho
  // # FE = VL / VDF # FE(%)= ((VDF-VSF)*100)/VDF. (porque VL= VDF-VSF). (%)
  static double get presionPerfusionCoronaria => // PC
  (Valores.tensionArterialDyastolica! -
      Valores.presionCunaPulmonar!); //  # Presión Perfusión de la Arteria Coronaria

  // Parámetros de Electrocardiogramas

  static double get gastoCardiacoFick {
    if (Valores.DAV != 0) {
      return ((125 * Antropometrias.SCE) / (8.5 * Valores.DAV)); // # Gasto Cardiaco
      // return (((DAV * 100) / CAO) / (DAV)); // # Gasto Cardiaco
    } else {
      return double.nan;
    }
  }

}
