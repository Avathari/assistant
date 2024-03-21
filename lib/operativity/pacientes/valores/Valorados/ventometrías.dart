import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';

class Ventometrias {
  // ANALISIS

  // CONCLUSIONES: VENTILATORIOS ************* ********** ************** ***
  static String get modoVentilatorio {
    var MOD = ' ';
    if (Valores.modalidadVentilatoria ==
        'Ventilación Limitada por Presión Ciclada por Tiempo (P-VMC / VCP)') {
      MOD = 'AC-VCP'; // # 'P-VMC/VCP';
    } else if (Valores.modalidadVentilatoria ==
        'Ventilación Limitada por Flujo Ciclada por Volumen (V-VMC / VCV)') {
      MOD = 'AC-VCV'; // # 'V-VMC/VCV';
    } else if (Valores.modalidadVentilatoria ==
        'Ventilación Mandatoria Intermitente Sincrónizada (SIMV / VCV)') {
      MOD = 'SIMV/VCV';
    } else if (Valores.modalidadVentilatoria ==
        'Ventilación Mandatoria Intermitente Sincrónizada (SIMV / VCP)') {
      MOD = 'SIMV/VCP';
    } else if (Valores.modalidadVentilatoria ==
        'Presión Positiva en Vía Aérea con Presión Soporte (CPAP / PS)') {
      MOD = 'CPAP/PS';
    } else if (Valores.modalidadVentilatoria == 'Espontáneo (ESPON)') {
      MOD = 'ESPON';
    } else {
      MOD = ' ';
    }
    return MOD;
  }

  static String get ventilador {
    if (modoVentilatorio == 'ESPON') {
      return "Ventilación en modalidad ${modoVentilatorio} con parámetros ajustados a "
          "frecuencia ventilatoria ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "presión al final de la espiración ${Valores.presionFinalEsiracion} mmHg, "
          "presión soporte ${Valores.presionControl} mmHg. "
          "Analisis ventilatorio con  ${ventilatorios}";
    } else if (modoVentilatorio == 'CPAP/PS') {
      return "Ventilación en modalidad ${modoVentilatorio} con parámetros ajustados a "
          "frecuencia ventilatoria ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "presión al final de la espiración ${Valores.presionFinalEsiracion} mmHg, "
          "presión soporte ${Valores.presionControl} mmHg. "
          "Analisis ventilatorio con  ${ventilatorios}";
    } else if (modoVentilatorio == 'AC-VCV') {
      return "Ventilación en modalidad ${modoVentilatorio} con parámetros ajustados a "
          "frecuencia ventilatoria ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "presión al final de la espiración ${Valores.presionFinalEsiracion} mmHg, "
          "volumen tidal ${Valores.volumenTidal} mmHg. "
          "Analisis ventilatorio con  ${ventilatorios}";
    } else if (modoVentilatorio == 'AC-VCP') {
      return "Ventilación en modalidad ${modoVentilatorio} con parámetros ajustados a "
          "frecuencia ventilatoria ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "presión al final de la espiración ${Valores.presionFinalEsiracion} mmHg, "
          "presión control ${Valores.presionControl} mmHg. "
          "Analisis ventilatorio con  ${ventilatorios}";
    } else if (modoVentilatorio == 'SIMV/VCV') {
      return "Ventilación en modalidad ${modoVentilatorio} con parámetros ajustados a "
          "frecuencia ventilatoria ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "presión al final de la espiración ${Valores.presionFinalEsiracion} mmHg, "
          "volumen tidal ${Valores.volumenTidal} mmHg. "
          "Analisis ventilatorio con  ${ventilatorios}";
    } else if (modoVentilatorio == 'SIMV/VCP') {
      return "Ventilación en modalidad ${modoVentilatorio} con parámetros ajustados a "
          "frecuencia ventilatoria ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "presión al final de la espiración ${Valores.presionFinalEsiracion} mmHg, "
          "presión control ${Valores.presionControl} mmHg. "
          "Analisis ventilatorio con  ${ventilatorios}";
    } else {
      return '';
    }
  }

  static String get ventiladorCorto {
    if (modoVentilatorio == 'ESPON') {
      return "Ventilación en ${modoVentilatorio}, "
          "F. Resp. ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "PEEP ${Valores.presionFinalEsiracion} mmHg, "
          "Psopp ${Valores.presionControl} mmHg. "
          "${ventilatorios}";
    } else if (modoVentilatorio == 'CPAP/PS') {
      return "Ventilación en ${modoVentilatorio}, "
          "F. Resp. ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "PEEP ${Valores.presionFinalEsiracion} mmHg, "
          "Psopp ${Valores.presionControl} mmHg. "
          "${ventilatorios}";
    } else if (modoVentilatorio == 'AC-VCV') {
      return "Ventilación en ${modoVentilatorio} con "
          "F. Resp. ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "PEEP ${Valores.presionFinalEsiracion} mmHg, "
          "Vt ${Valores.volumenTidal} mmHg. "
          "${ventilatorios}";
    } else if (modoVentilatorio == 'AC-VCP') {
      return "Ventilación en ${modoVentilatorio} con "
          "F. Resp ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "PEEP ${Valores.presionFinalEsiracion} mmHg, "
          "P. control ${Valores.presionControl} mmHg. "
          "${ventilatorios}";
    } else if (modoVentilatorio == 'SIMV/VCV') {
      return "Ventilación en ${modoVentilatorio} con "
          "F. Resp ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "PEEP ${Valores.presionFinalEsiracion} mmHg, "
          "Vt ${Valores.volumenTidal} mmHg. "
          "${ventilatorios}";
    } else if (modoVentilatorio == 'SIMV/VCP') {
      return "Ventilación en ${modoVentilatorio} con "
          "F. Resp ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "PEEP ${Valores.presionFinalEsiracion} mmHg, "
          "P. control ${Valores.presionControl} mmHg. "
          "${ventilatorios}";
    } else {
      return '';
    }
  }

  static String get ventilatorios {
    Terminal.printExpected(
        message:
        "modoVentilatorioALIDAD VENTILATORIA ${Valores.modalidadVentilatoria} ${modoVentilatorio}");

    // Prosa del Análisis Ventilatorio **************** ****************** **********************
    var PS = '';
    if (modoVentilatorio == 'ESPON') {
      PS = "Psopp ${Valores.presionSoporte} cmH2O, "
          "P. pulmonar insp. ${Valores.presionInspiratoriaPico} cmH2O, "
          "P. pulmonar esp. ${Valores.presionFinalEsiracion} cmH2O";
    } else if (modoVentilatorio == 'CPAP/PS') {
      PS = "Psopp ${Valores.presionSoporte} cmH2O, "
          "P. pulmonar insp. ${Valores.presionInspiratoriaPico} cmH2O, "
          "P. pulmonar esp. ${Valores.presionFinalEsiracion} cmH2O";
    } else if (modoVentilatorio == 'AC-VCV') {
      PS = "VM ${Ventometrias.volumenMinuto.toStringAsFixed(1)} L/min, "
          "Flujo ${Ventometrias.flujoVentilatorioMedido.toStringAsFixed(2)} L/min, "
          "VTI ${Valores.volumenTidal} mL";
    } else if (modoVentilatorio == 'AC-VCP') {
      PS = "Pinsp ${Valores.presionControl} cmH2O, "
          "PIP ${Valores.presionMaxima} cmH2O, "
          "Pplat ${Valores.presionPlateau} cmH2O. \n"
          "PmVA ${Ventometrias.presionMediaViaAerea.toStringAsFixed(0)} cmH2O, "
          "WOB ${Ventometrias.poderMecanico.toStringAsFixed(2)} J/min, "
          "Dist P. ${Ventometrias.distensibilidadPulmonar.toStringAsFixed(2)} mL/cmH2O, "
          "Dest ${Ventometrias.distensibilidadPulmonarEstatica.toStringAsFixed(2)} mL/cmH2O, "
          "Ddyn ${Ventometrias.distensibilidadPulmonarDinamica.toStringAsFixed(2)} mL/cmH2O, "
          "RP ${Ventometrias.resistenciaPulmonar.toStringAsFixed(2)} mL/cmH2O, "
          "Elast ${Ventometrias.elastanciaPulmonar.toStringAsFixed(2)} cmH2O/mL, "
          "D. Pressure ${Ventometrias.presionDistencion.toStringAsFixed(0)} mmHg, "
          "VM ${Ventometrias.volumenMinuto.toStringAsFixed(1)} L/min, "
          "Flujo ${Ventometrias.flujoVentilatorioMedido.toStringAsFixed(2)} L/min";
    } else if (modoVentilatorio == 'SIMV/VCV') {
      PS = "Psopp ${Valores.presionSoporte} cmH2O, "
          "VM ${Ventometrias.volumenMinuto.toStringAsFixed(1)} L/min, "
          "Flujo ${Ventometrias.flujoVentilatorioMedido.toStringAsFixed(2)} L/min, "
          "VTI ${Valores.volumenTidal} mL";
    } else if (modoVentilatorio == 'SIMV/VCP') {
      PS = "Psopp ${Valores.presionSoporte} cmH2O, "
          "Pinsp ${Valores.presionControl} cmH2O, "
          "PIP ${Valores.presionMaxima} cmH2O, "
          "Pplat ${Valores.presionPlateau} cmH2O. \n"
          "PmVA ${Ventometrias.presionMediaViaAerea.toStringAsFixed(0)} cmH2O, "
          "WOB ${Ventometrias.poderMecanico.toStringAsFixed(2)} J/min, "
          "Dist P. ${Ventometrias.distensibilidadPulmonar.toStringAsFixed(2)} mL/cmH2O, "
          "Dest ${Ventometrias.distensibilidadPulmonarEstatica.toStringAsFixed(2)} mL/cmH2O, "
          "Ddyn ${Ventometrias.distensibilidadPulmonarDinamica.toStringAsFixed(2)} mL/cmH2O, "
          "RP ${Ventometrias.resistenciaPulmonar.toStringAsFixed(2)} mL/cmH2O, "
          "Elast ${Ventometrias.elastanciaPulmonar.toStringAsFixed(2)} cmH2O/mL, "
          "D. Pressure ${Ventometrias.presionDistencion.toStringAsFixed(0)} mmHg, "
          "VM ${Ventometrias.volumenMinuto.toStringAsFixed(1)} L/min, "
          "Flujo ${Ventometrias.flujoVentilatorioMedido.toStringAsFixed(2)} L/min";
    } else {
      PS = '';
    }
    // print("PROSA VENTILATORIA $PS");
    return PS;
  }

  // FÓRMULAS
  static double get volumentTidal6 => (Antropometrias.pesoCorporalPredicho * 6);

  static double get volumentTidal7 => (Antropometrias.pesoCorporalPredicho * 7);

  static double get volumentTidal8 => (Antropometrias.pesoCorporalPredicho * 8);

  // # ######################################################
  static double get volumenTidalIdeal => (Ventometrias.distensibilidadPulmonarEstatica * Ventometrias.presionDistencion);

  // # ######################################################
  static double get poderMecanico {
    if (Antropometrias.pesoCorporalPredicho != 0) {
      return (0.098 *
          Valores.frecuenciaVentilatoria! *
          (Valores.presionPlateau! - Valores.presionFinalEsiracion! / 2));
      // PM = (0.098 * Valores.frecuenciaVentilatoria * (
      // Valores.presionPlateau! - Valores.presionFinalEsiracion! / 2))
    } else {
      return double.nan;
    }
  }

  /// Poder Distencion expresado como []
  static double get poderDistencion {
    if (Antropometrias.pesoCorporalPredicho != 0) {
      return (0.098 *
          (Ventometrias.drivingPressure)
      * (Valores.volumenTidal! / 1000)
          *Valores.frecuenciaVentilatoria!);
      // PM = (0.098 * Valores.frecuenciaVentilatoria * (
      // Valores.presionPlateau! - Valores.presionFinalEsiracion! / 2))
    } else {
      return double.nan;
    }
  }

  /// Driving Pressure expresado como [Vt / Cstat]
  static double get drivingPressure {
    if (Valores.volumenTidal != 0 && Ventometrias.distensibilidadPulmonarEstatica !=0) {
      return (Valores.volumenTidal! / Ventometrias.distensibilidadPulmonarEstatica);
    } else {
      return double.nan;
    }
  }

  // # ######################################################
  static double get distensibilidadPulmonarEstatica {
    if (Valores.presionPlateau != 0 &&
        Valores.presionPlateau != null &&
        Valores.presionFinalEsiracion != 0 &&
        Valores.presionFinalEsiracion != null) {
      return (Valores.volumenTidal! /
          (Valores.presionPlateau! - Valores.presionFinalEsiracion!));
      //  DPE = (Valores.volumenTidal! / (
      //   Valores.presionPlateau! - Valores.presionFinalEsiracion!));
    } else {
      return double.nan;
    }
  }

  static double get distensibilidadPulmonarDinamica {
    if (Valores.presionPlateau != 0 &&
        Valores.presionPlateau != null &&
        Valores.presionFinalEsiracion != 0 &&
        Valores.presionFinalEsiracion != null) {
      return (Valores.volumenTidal! /
          (Valores.presionMaxima! -
              Valores.presionFinalEsiracion!)); //# Presion_Inspiratorio_Pico
      // DP = DPE + DPD / 2  // # Promedio entre las Distensibilidades Pulmonares estaticas y dinamicas
    } else {
      return double.nan;
    }
  }

  static double get distensibilidadPulmonar {
    if (Ventometrias.distensibilidadPulmonarEstatica != 0 &&
        Ventometrias.distensibilidadPulmonarDinamica != 0) {
      return distensibilidadPulmonarEstatica +
          distensibilidadPulmonarDinamica /
              2; // # Promedio entre las Distensibilidades Pulmonares estaticas y dinamicas
    } else {
      return double.nan;
    }
  }

  static double get resistenciaPulmonar {
    if (Valores.presionMaxima != 0 &&
        Valores.presionMaxima != null &&
        Valores.presionPlateau != 0 &&
        Valores.presionPlateau != null) {
      return (Valores.presionMaxima! - Valores.presionPlateau!) /
          (Valores.flujoVentilatorio! / 60);
      // RP = (Valores.presionMaxima- Valores.presionPlateau!) / (F / 60)
    } else {
      return double.nan;
    }
  }

  static double get elastanciaPulmonar {
    if (Valores.presionMaxima != 0 &&
        Valores.presionMaxima != null &&
        Valores.presionFinalEsiracion != 0 &&
        Valores.presionFinalEsiracion != null) {
      return ((Valores.presionMaxima! - Valores.presionFinalEsiracion!) /
          (Valores.volumenTidal!)) *
          1000;
      // EP = ((Valores.presionMaxima- Valores.presionFinalEsiracion) / (Valores.volumenTidal!)) * 1000
    } else {
      return double.nan;
    }
  }

  static double get presionDistencion {
    if (Valores.presionMaxima != 0 &&
        Valores.presionMaxima != null &&
        Valores.presionFinalEsiracion != 0 &&
        Valores.presionFinalEsiracion != null) {
      return (Valores.presionMaxima!.toDouble() -
          Valores.presionFinalEsiracion!.toDouble());
    } else {
      return double.nan;
    }
  }
  // # ######################################################
  static double get presionAlveolarOxigeno {
    if (Valores.volumenTidal != 0 &&
        Valores.volumenTidal != null &&
        Antropometrias.pesoCorporalPredicho != 0) {
      // return (valores.get('FraccionInspiratoriaOxigeno') / 100) * (720 - 47) - (Valores.pcoArteriales! / 0.8);
      return 0;
    } else {
      return double.nan;
    }
  }

  static double get presionMediaViaAerea {
    if (Valores.presionPlateau != 0 &&
        Valores.presionPlateau != null &&
        Valores.sensibilidadInspiratoria != 0 &&
        Valores.sensibilidadInspiratoria != null) {
      return (Valores.presionFinalEsiracion! +
          ((Valores.presionPlateau! - Valores.presionFinalEsiracion!) *
              (Valores.sensibilidadInspiratoria!)))
          .toDouble();
    } else {
      return double.nan;
    }
  }

  static double get volumenMinuto {
    if (Valores.volumenTidal != 0 &&
        Valores.volumenTidal != null &&
        Antropometrias.pesoCorporalPredicho != 0) {
      return (Valores.volumenTidal! * Valores.frecuenciaVentilatoria!) / 1000;
    } else {
      return double.nan;
    }
  }

  static double get flujoVentilatorioMedido {
    if (Ventometrias.volumenMinuto != 0) {
      return (Ventometrias.volumenMinuto * 4);
    } else {
      return double.nan;
    }
  }

  static double get volumenMinutoIdeal {
    if (Antropometrias.pesoCorporalPredicho != 0) {
      return (Antropometrias.pesoCorporalPredicho / 10);
      // VMI = (PCI / 10)
    } else {
      return double.nan;
    }
  }


// # ######################################################

// if valores.get('PresionOxigenoArterial') != 0:
// IO = (PMVA * (valores.get('FraccionInspiratoriaOxigeno') / 100)) * (100.00) / valores.get(
// 'PresionOxigenoArterial')
// else if valores.get('SaturacionOxigeno') != 0:  # //  Indice de Saturación
// IO = ((PMVA * (valores.get('FraccionInspiratoriaOxigeno') / 100)) * (100.00) / valores.get(
// 'PresionOxigenoArterial'))
// else:
// IO = 0
//
// IV = (PMVA * Valores.frecuenciaVentilatoria) * (Valores.pcoArteriales! / 10)
//
// if Valores.pcoArteriales! != 0:
// EV = (VM * Valores.pcoArteriales!) / ((VMI * 37.5))
// else if Valores.pcoArteriales! == 0:
// EV = (VM) / ((3.2 * Valores.pesoCorporalTotal!)) * (100)
// else:
// EV = 0
//
// PPI = Valores.presionFinalEsiracion+ Valores.presionSoporte!
// PPE = Valores.presionFinalEsiracionCI = (Valores.pcoArteriales! * Valores.frecuenciaVentilatoria) / 40.00
//
// # ######################################################
// # Análisis de pCO2 / pO2
// # ######################################################
// FIOV = ((valores.get('GradienteAlveoloArterial_Arteriales') + 100) / 760) * 100
//
// if (FIOV < 21):
// FIOI = (21.00)
// else:
// FIOI = FIOV
// VENT = (Valores.pcoArteriales! * Valores.frecuenciaVentilatoria) / 40.00
//
// if Valores.pcoArteriales! != 0:
// VA = (0.863 * (3.2 * Valores.pesoCorporalTotal!)) / (
// Valores.pcoArteriales!)
// else:
// VA = 00.00
}