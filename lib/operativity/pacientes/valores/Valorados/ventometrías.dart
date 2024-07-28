import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/gasometricos.dart';
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
      return "VMI ${modoVentilatorio}, "
          "F. Resp. ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "PEEP ${Valores.presionFinalEsiracion} mmHg, "
          "Psopp ${Valores.presionControl} mmHg. "
          "${ventilatorios}";
    } else if (modoVentilatorio == 'CPAP/PS') {
      return "VMI ${modoVentilatorio}, "
          "F. Resp. ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "PEEP ${Valores.presionFinalEsiracion} mmHg, "
          "Psopp ${Valores.presionControl} mmHg. "
          "${ventilatorios}";
    } else if (modoVentilatorio == 'AC-VCV') {
      return "VMI ${modoVentilatorio} con "
          "F. Resp. ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "PEEP ${Valores.presionFinalEsiracion} mmHg, "
          "Vt ${Valores.volumenTidal} mmHg. "
          "${ventilatorios}";
    } else if (modoVentilatorio == 'AC-VCP') {
      return "VMI ${modoVentilatorio} con "
          "F. Resp ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "PEEP ${Valores.presionFinalEsiracion} mmHg, "
          "P. control ${Valores.presionControl} mmHg. "
          "${ventilatorios}";
    } else if (modoVentilatorio == 'SIMV/VCV') {
      return "VMI ${modoVentilatorio} con "
          "F. Resp ${Valores.frecuenciaVentilatoria} Vent/min, "
          "FiO2 ${Valores.fraccionInspiratoriaVentilatoria} %, "
          "PEEP ${Valores.presionFinalEsiracion} mmHg, "
          "Vt ${Valores.volumenTidal} mmHg. "
          "${ventilatorios}";
    } else if (modoVentilatorio == 'SIMV/VCP') {
      return "VMI ${modoVentilatorio} con "
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
          "VTI ${Valores.volumenTidal} mL; "
          "VM ${Ventometrias.volumenMinuto.toStringAsFixed(1)} L/min, "
          "PIP ${Valores.presionMaxima} cmH2O, "
          "Pplat ${Valores.presionPlateau} cmH2O. "
          "PmVA ${Ventometrias.presionMediaViaAerea.toStringAsFixed(0)} cmH2O, "
          "Dest ${Ventometrias.distensibilidadPulmonarEstatica.toStringAsFixed(2)} mL/cmH2O, "
          "Dp ${Ventometrias.presionDistencion.toStringAsFixed(0)} mmHg, "
          "Pd ${Ventometrias.presionDistencion} J. ";
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
          "Dp  ${Ventometrias.presionDistencion.toStringAsFixed(0)} mmHg, "
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
  static double get volumenTidalIdeal =>
      (Ventometrias.distensibilidadPulmonarEstatica *
          Ventometrias.drivingPressure);

  static double get fiO2deal =>
      (Gasometricos.PaO2_estimado * Valores.fraccionInspiratoriaOxigeno!) /
      Valores.poArteriales!;

  static double get indiceTobinYang =>
      (Valores.frecuenciaVentilatoria! / (Valores.volumenTidal! / 100));
  // # ######################################################
  /// Poder Mecánico : :
  ///
  /// VN : Menor a 12 J/min
  ///
  ///  Formula:
  ///
  ///     PM = 0.098 * FR * VC * (Pmax - ((Pplat - PEEP) / 2)
  ///       * * El Mantener PM mayor a 10 J/min, y un aumento de 2 J/min del basal del poder mecánico identifica a los pacientes con mayor riesgo de reintubación.
  ///       * * El mantener PM menor a 8 J/min, identifica a los pacientes con menor incidencia en reintubaciones.
  /// Existen otras formulas :
  ///
  ///     MP = VE * (Pmax + PEEP + F/6) / 20
  ///
  ///         Consulte: https://icm-experimental.springeropen.com/articles/10.1186/s40635-019-0276-8
  ///            Giosa, L., Busana, M., Pasticci, I. et al. Mechanical power at a glance: a simple surrogate for volume-controlled ventilation. ICMx 7, 61 (2019). https://doi.org/10.1186/s40635-019-0276-8
  ///

  static double get poderMecanico {
    // return (0.098 * Valores.frecuenciaVentilatoria! * (Valores.volumenTidal!/1000) * (Valores.presionMaxima! - (Valores.presionPlateau! - Valores.presionFinalEsiracion!) / 2));
    return (Valores.frecuenciaVentilatoria! *
        (Valores.volumenTidal! / 1000) *
        (Valores.presionMaxima! -
            ((Valores.presionPlateau! - Valores.presionFinalEsiracion!) / 2)) *
        0.098);
    return (0.098 *
        Valores.frecuenciaVentilatoria! *
        (Valores.presionPlateau! - Valores.presionFinalEsiracion! / 2));
    // PM = (0.098 * Valores.frecuenciaVentilatoria * (
    // Valores.presionPlateau! - Valores.presionFinalEsiracion! / 2))
  }

  /// Poder Distencion expresado como []
  ///
  /// VN : Menor a 12 J/min
  static double get poderDistencion {
    return (0.098 *
        (Ventometrias.drivingPressure) *
        (Valores.volumenTidal! / 1000) *
        Valores.frecuenciaVentilatoria!);
    // PM = (0.098 * Valores.frecuenciaVentilatoria * (
    // Valores.presionPlateau! - Valores.presionFinalEsiracion! / 2))
  }

  /// Poder Mecánico Indexado .
  ///     Al parecer describe exíto de intubación.
  ///     VN : menor a 3000 incrementa probabilidad de éxito.
  ///              entre 4000-6000, se conoce como Zona Gris.
  ///              mayor a 7000 incrementa la posibiliadd de fracaso.
  /// Consulte: Ghiani, A., Paderewska, J., Walcher, S. et al. Mechanical power normalized to lung-thorax compliance predicts prolonged ventilation weaning failure: a prospective study. BMC Pulm Med 21, 202 (2021).
  ///       https://doi.org/10.1186/s12890-021-01566-8
  ///
  static double get poderMecanicoIndexado {
    return Valores.frecuenciaVentilatoria! *
        Valores.presionMaxima! *
        (Valores.presionMaxima! - Valores.presionFinalEsiracion!) *
        (Valores.pcoArteriales! / 45);
  }

  /// Presión Transpulmonar (Pta)
  ///
  /// VN : 2.5-3.0 cmH2O
  static double get presionTranspulmonar {
    return Valores.presionMaxima!.toDouble() -
        Valores.presionPlateau!.toDouble();
    return double.nan;
  }

  /// Driving Pressure expresado como [Vt / Cstat]
  static double get drivingPressure {
    if (Valores.distensibilidadEstaticaMedida == null) {
      if (Valores.volumenTidal != 0 &&
          Ventometrias.distensibilidadPulmonarEstatica != 0) {
        return (Valores.volumenTidal! /
            Ventometrias.distensibilidadPulmonarEstatica);
      } else {
        return double.nan;
      }
    } else {
      if (Valores.volumenTidal != 0 &&
          Valores.distensibilidadEstaticaMedida != 0) {
        return (Valores.volumenTidal! / Valores.distensibilidadEstaticaMedida!);
      } else {
        return double.nan;
      }
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
