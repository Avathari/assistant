import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/gasometricos.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/hepatometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';

class Cardiometrias {
  // ANALISIS
  static String get cardiovasculares =>
      "Parámetros Cardiovasculares - Presión Arterial Media: ${Cardiometrias.presionArterialMedia.toStringAsFixed(0)} mmHg. "
      //
      "Diferencia de Presión Arterial ${Cardiometrias.diferenciaTensionArterial.toStringAsFixed(0)} mmHg. "
      "Presión de Pulso: ${Cardiometrias.presionPulso.toStringAsFixed(0)} mmHg. "
      "Producto Frecuencia - Presión: ${Cardiometrias.productoFrecuenciaPresion.toStringAsFixed(1)} mmHg/Lpm. "
      "Presión Coloido - Oncótica: ${Cardiometrias.presionColoidosmotica.toStringAsFixed(2)}  mmHg. "
      "Frecuencia Cárdiaca Máxima: ${Cardiometrias.frecuenciaCardiacaMaxima.toStringAsFixed(0)} L/min. "
      "Frecuencia Cárdiaca Blanco: ${Cardiometrias.frecuenciaCardiacaBlanco.toStringAsFixed(0)} L/min. "
      "Frecuencia Cárdiaca Intrínseca: ${Cardiometrias.frecuenciaCardiacaIntrinseca.toStringAsFixed(0)} L/min. "
      "Volemia Aproximada: ${Valores.volemiaAproximada.toStringAsFixed(2)} mL,  "
      "Volumen Plasmático Aproximado: ${Valores.volumenPlasmatico.toStringAsFixed(2)} L. \n";

  // Δ
  static String get transporteOxigeno => "Parámetros Hemodinamicos - "
      "CaO2 ${Gasometricos.CAO.toStringAsFixed(2)} mL/dL, " // Concentración Arterial de Oxígeno
      "CvO2 ${Gasometricos.CVO.toStringAsFixed(2)} mL/dL, " // Concentración Venosa de Oxígeno
      "DavO2 ${Gasometricos.DAV.toStringAsFixed(2)} mL/dL. "
      "\n" // Diferencia Arterio - Venosa
      "GC ${Cardiometrias.gastoCardiacoFick.toStringAsFixed(2)} L/min. " // Gasto Cardiaco
      "GCi ${Cardiometrias.indiceCardiaco.toStringAsFixed(2)} L/min/m2, " // Gasto Cardiaco Indexado, Indice Cardiaco
      "V_Sys ${Cardiometrias.volumenSistolico.toStringAsFixed(2)} mL/min. " // Volumen Látido Sistólico : GC * FC
      "\n"
      //
      "VO2  ${Valores.CO.toStringAsFixed(2)}  mL O2/g Hb, "
      "IEO2(%) ${Valores.IEO.toStringAsFixed(2)} %, "
      "DO2 ${Valores.DO.toStringAsFixed(2)} mL/min,  "
      // "Consumo de Oxígeno (cO2): ${Valores.CAO.toStringAsFixed(2)} mL/min/m2, "
      "RVS ${Valores.RVS.toStringAsFixed(2)} Dinas/seg/cm2. "
      "TO2 ${Valores.TO.toStringAsFixed(2)} mL/O2/m2. "
      "QS/QT ${Valores.SF.toStringAsFixed(2)} %. "
      "\n"
      "G(A-a)O2 ${Gasometricos.GAA.toStringAsFixed(2)} mmHg. "
      "PIO2 ${Gasometricos.PIO.toStringAsFixed(2)} mmHg. "
      "PAO2 ${Gasometricos.PAO.toStringAsFixed(2)} mmHg. "
      "\n";

  static String get hemodinamicos => "Parámetros Hemodinámicos - "
      "Gasto Cárdiaco Aproximado: ${Cardiometrias.gastoCardiacoFick.toStringAsFixed(2)} L/min. "
      "Volumen Látido Aproximado: ${Valores.indiceVolumenSanguineo.toStringAsFixed(2)} mL/min, "
      "Volemia Aproximada: ${Valores.volemiaAproximada.toStringAsFixed(2)} mL,  "
      "Volumen Plasmático Aproximado: ${Valores.volumenPlasmatico.toStringAsFixed(2)} L,  "
      "Trabajo Cardiaco - Trabajo Cardiaco: ${Cardiometrias.trabajoCardiacoIzquierdo.toStringAsFixed(2)} Kg*m. "
      "Trabajo Látido Ventricular Izquierdo: ${Cardiometrias.trabajoLatidoVentricularIzquierdo.toStringAsFixed(2)} g*m. "
      "Trabajo Látido Ventricular Derecho: ${Cardiometrias.TLVD.toStringAsFixed(2)} g*m. \n";

  // CONCLUSIONES
  static String get cardiometrias =>
      "Parámetros Cardiovasculares - TAM ${Cardiometrias.presionArterialMedia.toStringAsFixed(0)} mmHg. "
      // "(${Cardiometrias.clase.toStringAsFixed(2)})
      "Diferencia de Presión Arterial ${Cardiometrias.diferenciaTensionArterial.toStringAsFixed(0)} mmHg. "
      "Presión de Pulso: ${Cardiometrias.presionPulso.toStringAsFixed(0)} mmHg. "
      "Producto Frecuencia - Presión: ${Cardiometrias.productoFrecuenciaPresion.toStringAsFixed(0)} mmHg/Lpm. "
      "Presión Coloido - Oncótica: ${Cardiometrias.presionColoidosmotica.toStringAsFixed(1)}  mmHg. "
      "Frecuencia Cárdiaca Máxima: ${Cardiometrias.frecuenciaCardiacaMaxima.toStringAsFixed(0)} L/min. "
      "Frecuencia Cárdiaca Blanco: ${Cardiometrias.frecuenciaCardiacaBlanco.toStringAsFixed(0)} L/min. "
      "Frecuencia Cárdiaca Intrínseca: ${Cardiometrias.frecuenciaCardiacaIntrinseca.toStringAsFixed(0)} L/min. "
      "Volemia Aproximada: ${Valores.volemiaAproximada.toStringAsFixed(2)} L,  "
      // "Volumen Plasmático Aproximado: ${Valores.volumenPlasmatico.toStringAsFixed(2)} L,  "
      "aGC ${Cardiometrias.gastoCardiacoFick.toStringAsFixed(2)} L/min. "
          "GCindex: ${Cardiometrias.indiceCardiaco.toStringAsFixed(2)} L/min. "
      "Volumen Sistólico: ${Cardiometrias.volumenSistolico.toStringAsFixed(2)} mL/min,"
          "Volumen Sistólico Indexado: ${Cardiometrias.volumenSistolicoIndexado.toStringAsFixed(2)} mL/min. \n"
      "Parámetros Hemodinámicos - "
      "Concentración Arterial de Oxígeno (CaO2): ${Gasometricos.CAO.toStringAsFixed(2)}  mL/dL, "
      "Concentración Venosa de Oxígeno (CvO2): ${Gasometricos.CVO.toStringAsFixed(2)}  mL/dL, "
      "Diferencia Arterio - Venosa (DavO2): ${Gasometricos.DAV.toStringAsFixed(2)}  mL/dL, "
      "Capacidad de Oxígeno (CapO2): ${Valores.CO.toStringAsFixed(2)}  mL O2/g Hb. "
      "Indice Cárdiaco ${Cardiometrias.indiceCardiaco.toStringAsFixed(2)} L/min/m2, "
      "Resistencias Venosas Sistémicas (R.V.S.): ${Valores.RVS.toStringAsFixed(2)} Dinas/seg/cm2. "
      "Indice de Extracción de Oxígeno (I.E.O.): ${Valores.IEO.toStringAsFixed(2)} %, "
      "Disponibilidad de Oxígeno (dO2): ${Valores.iDO.toStringAsFixed(2)} mL/min,  "
      "Transporte de Oxígeno (TO2): ${Valores.TO.toStringAsFixed(2)} mL/O2/m2. "
      "Shunt Fisiológico (QS/QT): ${Valores.SF.toStringAsFixed(2)} %. "
      "Gradiente Alveolo - Arterial (G(A-a)): ${Gasometricos.GAA.toStringAsFixed(2)} mmHg. \n"
      "Trabajo Cardiaco - Trabajo Cardiaco: ${Cardiometrias.trabajoCardiacoIzquierdo.toStringAsFixed(2)} Kg*m. "
      "Trabajo Látido Ventricular Izquierdo: ${Cardiometrias.trabajoLatidoVentricularIzquierdo.toStringAsFixed(2)} g*m. "
      "Trabajo Látido Ventricular Derecho: ${Cardiometrias.TLVD.toStringAsFixed(2)} g*m. "
          "Poder Cardiaco : ${Cardiometrias.poderCardiaco.toStringAsFixed(2)} g*m. "
          "Poder Cardiaco Indexado : ${Cardiometrias.poderCardiacoIndexado.toStringAsFixed(2)} g*m. "
          "\n";

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


  /// Trabajo Cardiaco Izquierdo (TCI)
  ///
  /// *** TTCI = GC * TAM * 0.0144
  ///
  /// VN : 5.1 - 9.45 Kg*m
  ///
  /// ** Referencias :
  /// *** Consulte: https://www.scymed.com/es/smnxph/phmfw011.htm
  ///
  static double get trabajoCardiacoIzquierdo => (gastoCardiacoFick *
      Cardiometrias.presionArterialMedia *
      0.0144); // # Trabajo Cardiaco Izquierdo

  /// Indice Trabajo Latido Ventricular Izquierdo
  ///      VN : : 	VL*PAM*0.0144
  ///
  static double get indiceTrabajoCardiacoIzquierdo => (indiceCardiaco *
      Cardiometrias.presionArterialMedia *
      0.0144); //

  /// Trabajo Latido Ventricular Izquierdo
  ///       VN : : 75 - 115 g/Lat/m
  static double get trabajoLatidoVentricularIzquierdo =>
      Cardiometrias.volumenSistolico *
      Cardiometrias.presionArterialMedia *
      0.0144; //

  /// Trabajo Latido Ventricular Izquierdo
  ///       VN : : 75 - 115 g/Lat/m
  ///
  static double get trabajoLatidoVentricularIzquierdoIndexado =>
      Cardiometrias.volumenSistolicoIndexado *
          Cardiometrias.presionArterialMedia *
          0.0144;

  /// Trabajo Latido Ventricular DERECHO
  static double get TLVD => 00.00; //  # Trabajo Latido Ventricular Derecho
  // # FE = VL / VDF # FE(%)= ((VDF-VSF)*100)/VDF. (porque VL= VDF-VSF). (%)

  /// Presión de Perfusión Coronaria (PPC)
  static double get presionPerfusionCoronaria => // PC
      (Valores.tensionArterialDyastolica! -
          Valores
              .presionCunaPulmonar!); //  # Presión Perfusión de la Arteria Coronaria

  // Parámetros de Electrocardiogramas

  static double get gastoCardiacoFick => Gasometricos.gastoCardiaco;
  static double get indiceCardiaco =>
      (Gasometricos.gastoCardiaco / Antropometrias.SC); // # Indice Cardiaco

  //
  /// Presion Coloidosmotica :
  ///       . . PCO = 	(glob*1.4)+(alb*5.5)
  /// VN : mayor 15 mmHg
  ///
  /// * * Consulte: https://www.scymed.com/es/smnxph/phglp010.htm
  ///
  static double get presionColoidosmotica {
    if (Hepatometrias.globulinas != 0) {
      return (Hepatometrias.globulinas * 1.14) +
          (Valores.albuminaSerica! * 5.54);
    } else {
      return double.nan;
    }
  }

  /// Poder Cardiaco
  /// * *  It has been found that a cutoff value for CP of 0.53 W accurately predict in–hospital mortality for cardiogenic shock patients. Others investigators observed cutoff for increased mortality of CP < 1 W, data that were obtained at doses of maximal pharmacologic support yielding the individual maximal CP.
  /// * * In our experience, the cutoff value for CP that accurately predicts in–hospital mortality for cardiogenic shock patients is 0.7 W but its impact on short–term prognosis is clearer if the patient achieves a CP equal or higher than 1 W after an optimal myocardial revascularization with interventional cardiac procedures.
  ///
  /// VN: mayor a 0.53 Watts (J/seg)
  /// * * * Por cada incremento del 0.20 en el poder cardiaco se abate el riesgo relativo de muerte en un 45%. El poder cardiaco menor de 0.53 tuvo una sensibilidaad-especificidad de 0.66 con un VP 58% y VPN 71% cuando es mayor de 0.53.
  /// Consulte : https://www.scielo.org.mx/scielo.php?script=sci_arttext&pid=S1405-99402006000100015
  ///
  static double get poderCardiaco {
    if (Valores.presionVenosaCentral != 0 || Valores.presionVenosaCentral !=null) {
      return (Cardiometrias.presionArterialMedia - Valores.presionVenosaCentral!) * Gasometricos.gastoCardiaco / 451;
    } else {
      return (Cardiometrias.presionArterialMedia) * Gasometricos.gastoCardiaco / 451;
    }
  }

  /// Poder Cardiaco
  /// * *  It has been found that a cutoff value for CP of 0.53 W accurately predict in–hospital mortality for cardiogenic shock patients. Others investigators observed cutoff for increased mortality of CP < 1 W, data that were obtained at doses of maximal pharmacologic support yielding the individual maximal CP.
  /// * * In our experience, the cutoff value for CP that accurately predicts in–hospital mortality for cardiogenic shock patients is 0.7 W but its impact on short–term prognosis is clearer if the patient achieves a CP equal or higher than 1 W after an optimal myocardial revascularization with interventional cardiac procedures.
  ///
  /// VN: mayor a 0.53 Watts (J/seg)
  /// * * * Por cada incremento del 0.20 en el poder cardiaco se abate el riesgo relativo de muerte en un 45%. El poder cardiaco menor de 0.53 tuvo una sensibilidaad-especificidad de 0.66 con un VP 58% y VPN 71% cuando es mayor de 0.53.
  /// Consulte : https://www.scielo.org.mx/scielo.php?script=sci_arttext&pid=S1405-99402006000100015
  ///
  static double get poderCardiacoIndexado {
    if (Valores.presionVenosaCentral != 0 || Valores.presionVenosaCentral !=null) {
      return (Cardiometrias.presionArterialMedia - Valores.presionVenosaCentral!) * Cardiometrias.indiceCardiaco / 451;
    } else {
      return (Cardiometrias.presionArterialMedia) * Cardiometrias.indiceCardiaco / 451;
    }
  }

  /// Volumen Látido Sístolico (VLS)
  ///
  ///
  ///
  static double get volumenSistolico => ((Cardiometrias.gastoCardiacoFick * 1000) /
      Valores
          .frecuenciaCardiaca!); //  # Volumen Latido Sistólico De Litros a mL

  /// Volumen Látido Sístolico Indexado (VLS)
  ///
  ///
  ///
  static double get volumenSistolicoIndexado => (volumenSistolico /
      Antropometrias
          .SCE); //mL/Lat/m2 *IC se multiplica por 1000 para ajustar unidades a mL/min/m2
  // ((indiceCardiaco * 1000) / Valores.frecuenciaCardiaca!);


  /// Indice de Briones  : :
  ///
  /// VN : mayor a 0.11
  static double get indiceBriones {
    if (presionColoidosmotica != 0) {
      return (presionColoidosmotica) / (Cardiometrias.presionArterialMedia);
    } else {
      return double.nan;
    }
  }
}
