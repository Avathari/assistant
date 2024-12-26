import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'dart:math' as math;
import 'package:dart_numerics/dart_numerics.dart' as numerics;

class Antropometrias {
  // ANALISIS

  // CONCLUSIONES
  static String antropometricos({bool isAbreviado = true}) {
    String indiceCaderaCintura = '', grasaCorporal = '';
    if (Valores.circunferenciaCintura! != 0 ||
        Valores.circunferenciaCadera! != 0) {
      indiceCaderaCintura =
          "Relacion Cintura  Cadera ${Antropometrias.indiceCinturaCadera.toStringAsFixed(2)} cm. ";
    }
    if (Valores.pliegueCutaneoBicipital! != 0 &&
        Valores.pliegueCutaneoTricipital! != 0 &&
        Valores.pliegueCutaneoEscapular! != 0 &&
        Valores.pliegueCutaneoIliaco != 0) {
      grasaCorporal =
          "Grasa Corporal ${Antropometrias.grasaCorporalEsencial.toStringAsFixed(2)} Kg, "
          "Grasa Corporal Porcentual ${Antropometrias.grasaCorporalEsencial.toStringAsFixed(2)} %, "
          "Peso Corporal Magro ${Antropometrias.pesoCorporalMagro.toStringAsFixed(2)} Kg. ";
    }
    if (isAbreviado) {
      return "Análisis de Medidas Corporales: "
          "Peso Corporal Ideal ${Antropometrias.pesoCorporalPredicho.toStringAsFixed(2)} Kg, "
          "Indice de Masa Corporal ${Antropometrias.imc.toStringAsFixed(2)} Kg/m2. (${Antropometrias.claseIMC}). "
          "Superficie Corporal Total ${Antropometrias.SC.toStringAsFixed(2)} m2. ";
    } else {
      return "Análisis de Medidas Corporales: "
          "Peso Corporal Ideal ${Antropometrias.pesoCorporalPredicho.toStringAsFixed(2)} Kg, (${Antropometrias.PCIP.toStringAsFixed(2)} %), "
          "Peso Corporal Ajustado ${Antropometrias.pesoCorporalAjustado.toStringAsFixed(2)} Kg, "
          "Exceso de Peso Corporal ${Antropometrias.excesoPesoCorporal.toStringAsFixed(2)} Kg, "
          "Indice de Masa Corporal ${Antropometrias.imc.toStringAsFixed(2)} Kg/m2. (${Antropometrias.claseIMC}). "
          "Peso Corporal Blanco ${Antropometrias.PCB_25.toStringAsFixed(2)} Kg, "
          "Peso Corporal Blanco (I.M.C. 30) ${Antropometrias.PCB_30.toStringAsFixed(2)} Kg. "
          "Superficie Corporal Total ${Antropometrias.SC.toStringAsFixed(2)} m2. "
          "Peso Corporal Magro ${Antropometrias.pesoCorporalMagro.toStringAsFixed(2)} Kg. "
          "$indiceCaderaCintura";
    }
  }

  static String get vitales =>
      "Signos vitales con " // fecha de ${Pacientes.Vital['Pace_Feca_SV']} con "
      "tensión arterial sistémica en ${Valores.tensionArterialSistemica} mmHg, "
      "frecuencia cardiaca de ${Valores.frecuenciaCardiaca} L/min, "
      "frecuencia respiratoria de ${Valores.frecuenciaRespiratoria} L/min, "
      "temperatura corporal ${Valores.temperaturCorporal}°C, "
      "saturación periférica de oxígeno ${Valores.saturacionPerifericaOxigeno}%, "
      "peso corporal total ${Valores.pesoCorporalTotal} Kg, "
      "estatura ${Valores.alturaPaciente} mts";

  static String get vitalesAbreviado =>
      "TA ${Valores.tensionArterialSistemica} mmHg, "
      "FC ${Valores.frecuenciaCardiaca} L/min, "
      "FR ${Valores.frecuenciaRespiratoria} L/min, "
      "Temp ${Valores.temperaturCorporal}°C, "
      "SpO2 ${Valores.saturacionPerifericaOxigeno}%, "
      "PCT ${Valores.pesoCorporalTotal} Kg, "
      "Estatura ${Valores.alturaPaciente} mts. "
      "IMC ${Antropometrias.imc.toStringAsFixed(2)} Kg/m2, "
      "PCI ${Antropometrias.pesoCorporalPredicho.toStringAsFixed(2)} Kg . . "
      "";

  static String get vitalesTerapiaAbreviado =>
      "TA ${Valores.tensionArterialSistemica} mmHg, "
      "FC ${Valores.frecuenciaCardiaca} L/min, "
      "FR ${Valores.frecuenciaRespiratoria} L/min, "
      "Temp ${Valores.temperaturCorporal}°C, "
      "SpO2 ${Valores.saturacionPerifericaOxigeno}%. \n"
      "     "
      "PCT ${Valores.pesoCorporalTotal} Kg, "
      "Estatura ${Valores.alturaPaciente} mts, "
      "IMC ${Antropometrias.imc.toStringAsFixed(2)} Kg/m2, "
      "PCI ${Antropometrias.pesoCorporalPredicho.toStringAsFixed(2)} Kg . . "
      "Glucemia capilar ${Valores.glucemiaCapilar} mg/dL, con ${Valores.horasAyuno} horas de ayuno";

  static String get signosVitales =>
      "Signos vitales con " // fecha de ${Pacientes.Vital['Pace_Feca_SV']} con "
      "tensión arterial sistémica en ${Valores.tensionArterialSistemica} mmHg, "
      "frecuencia cardiaca de ${Valores.frecuenciaCardiaca} L/min, "
      "frecuencia respiratoria de ${Valores.frecuenciaRespiratoria} L/min, "
      "temperatura corporal ${Valores.temperaturCorporal}°C, "
      "saturación periférica de oxígeno ${Valores.saturacionPerifericaOxigeno}%, "
      "estatura ${Valores.alturaPaciente} mts, "
      "peso corporal total ${Valores.pesoCorporalTotal} Kg, "
      "I.M.C. ${Antropometrias.imc.toStringAsFixed(2)} Kg/m2. "
      "Glucemia capilar ${Valores.glucemiaCapilar} mg/dL, con ${Valores.horasAyuno} horas de ayuno";

  static String get bioconstantes =>
      "Signos vitales con " // fecha de ${Pacientes.Vital['Pace_Feca_SV']} con "
      "tensión arterial sistémica en ${Valores.tensionArterialSistemica} mmHg, "
      "frecuencia cardiaca de ${Valores.frecuenciaCardiaca} L/min, "
      "frecuencia respiratoria de ${Valores.frecuenciaRespiratoria} L/min, "
      "temperatura corporal ${Valores.temperaturCorporal}°C, "
      "saturación periférica de oxígeno ${Valores.saturacionPerifericaOxigeno}%, "
      "estatura ${Valores.alturaPaciente} mts, "
      "peso corporal total ${Valores.pesoCorporalTotal} Kg, "
      "I.M.C. ${Antropometrias.imc.toStringAsFixed(2)} Kg/m2. "
      "C. cintura ${Valores.circunferenciaCintura} cm. "
      "C. cadera ${Valores.circunferenciaCadera} cm. "
      "Glucemia capilar ${Valores.glucemiaCapilar} mg/dL, con ${Valores.horasAyuno} horas de ayuno";

  static String get asociadosRiesgo =>
      "Análisis Antropométrico enfocado al Riesgo: "
      "Pliegue Cutáneo Trícipital ${Valores.pliegueCutaneoTricipital} mm, "
      "Circunferencia Mesobraquial ${Valores.circunferenciaMesobraquial} cm, "
      "Perimetro Muscular Mesobraquial ${Antropometrias.perimetroMesobraquial} cm, "
      "Área Muscular Mesobraquial ${Antropometrias.AM} cm2, "
      "Área Adiposa Mesobraquial ${Antropometrias.areaAdiposaMesobraquial} cm2, "
      "Área Mesobraquial ${Antropometrias.areaMesobraquial} cm2. ";

  static String get pesosCorporales => "Análisis por Pesos Corporales: "
      "Est ${Valores.alturaPaciente} mts, "
      "PCT ${Valores.pesoCorporalTotal} kG, "
      "IMC ${Antropometrias.imc.toStringAsFixed(2)} kG/m2. "
      "Peso Ideal ${Antropometrias.pesoCorporalIdeal.toStringAsFixed(2)} kG, "
      "Peso Predicho ${Antropometrias.pesoCorporalPredicho.toStringAsFixed(2)} Kg, "
      "Peso Ajustado ${Antropometrias.pesoCorporalAjustado.toStringAsFixed(2)} kG. ";

// FÓRMULAS
  static double get pesoCorporalPredicho {
    if (Valores.sexo == "Masculino") {
      return 23.0 * (Valores.alturaPaciente! * Valores.alturaPaciente!);
    } else if (Valores.sexo == "Femenino") {
      return 21.5 * (Valores.alturaPaciente! * Valores.alturaPaciente!);
    } else {
      return 0.00;
    }
  }

  static double get pesoCorporalIdeal {
    if (Valores.sexo == "Masculino") {
      return 23.0 * (Valores.alturaPaciente! * Valores.alturaPaciente!);
    } else if (Valores.sexo == "Femenino") {
      return 21.5 * (Valores.alturaPaciente! * Valores.alturaPaciente!);
    } else {
      return 0.00;
    }
  }

  static double get imc =>
      Valores.pesoCorporalTotal! /
      (Valores.alturaPaciente! * Valores.alturaPaciente!);

  static double get PP {
    if (Valores.sexo == "Masculino") {
      return 50 + (0.91 * ((Valores.alturaPaciente! * 100) - 152.4));
    } else if (Valores.sexo == "Femenino") {
      return 45.5 + (0.91 * ((Valores.alturaPaciente! * 100) - 152.4));
    } else {
      return 0.00;
    }
  }

  static double get PCIP =>
      ((Valores.pesoCorporalTotal! * 100) / (pesoCorporalPredicho));

  static double get PCIB => ((Valores.alturaPaciente! * 100) - 100);

  static double get PCIL {
    if (Valores.sexo == ("Masculino")) {
      return (((Valores.alturaPaciente! * 100) - 100) -
          (((Valores.alturaPaciente! * 100) - 150) / 4));
    } else if (Valores.sexo == ("Femenino")) {
      return (((Valores.alturaPaciente! * 100) - 100) -
          (((Valores.alturaPaciente! * 100) - 150) / 2));
    } else {
      return 0.00;
    }
  }

  static double get PCIW {
    if (Valores.sexo == ("Masculino")) {
      return (22.1 * (math.pow(Valores.alturaPaciente!, 2)));
    } else if (Valores.sexo == ("Femenino")) {
      return (20.6 * (math.pow(Valores.alturaPaciente!, 2)));
    } else {
      return 0.00;
    }
  }

  static double get PCIM => (PCIB + PCIL + PCIW) / 3;

  /// Ajuste de Peso Corporal Total respecto a Peso Predicho.
  ///
  /// Formula: (Peso Real - Peso Ideal) * 0.33 + Peso Ideal
  ///
  static double get pesoCorporalAjustado =>
      pesoCorporalPredicho +
      ((Valores.pesoCorporalTotal! - pesoCorporalPredicho) * 0.25);

  static double get excesoPesoCorporal =>
      (Valores.pesoCorporalTotal! / pesoCorporalPredicho);

  static double get PCB_25 =>
      (Valores.alturaPaciente! * Valores.alturaPaciente!) * 25;

  static double get PCB_30 =>
      (Valores.alturaPaciente! * Valores.alturaPaciente!) * 30;

  static double get SC =>
      ((math.pow(Valores.pesoCorporalTotal!, 0.425)) *
          (math.pow((Valores.alturaPaciente! * 100), 0.725) * (0.7184))) /
      100; // Dubois y Dubois

  // static double get SC => (math.pow(Valores.pesoCorporalTotal!, 0.425)) * (math.pow(Valores.alturaPaciente!, 0.725) * 0.007184);

  static double get SCE {
    if (Valores.edad! <= 1.0) {
      return (((Valores.pesoCorporalTotal! * 4) + 9) / 100);
    } else if (Valores.edad! >= 1.0) {
      return ((Valores.pesoCorporalTotal! * 4) + 7) /
          (Valores.pesoCorporalTotal! + 90);
    } else {
      return 0.00;
    }
  }

  static double get SCS =>
      (math.sqrt(Valores.pesoCorporalTotal! * (Valores.alturaPaciente! * 100)) /
          3600); // Mosteller

  static double get SCH => (0.024265 *
      ((math.pow(Valores.alturaPaciente!, 0.3964)) *
          (math.pow(Valores.pesoCorporalTotal!, 0.5378))));

  /// pO2 equivalente por SpO2 (Ecuación de Severinhause-Ellis / Inverso de Ellis) .
  ///
  /// * * *
  ///
  /// Consulte : : https://www.rccc.eu/protocolos/SpFi.html#info
  ///
  /// Nonlinear Imputation of Pao2/Fio2 From Spo2/Fio2 Among Patients With Acute Respiratory Distress Syndrome : https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4980543/#appsec1
  /// https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4980543/bin/mmc1.pdf
  ///
  /// Imputation of partial pressures of arterial oxygen using oximetry and its impact on sepsis diagnosis : https://iopscience.iop.org/article/10.1088/1361-6579/ab5154
  ///
  /// Imputing the ratio of partial pressure of arterial oxygen to fraction of inspired oxygen: the optimal strategy in non-intubated floor patients. : https://bit.ly/2X50EBb
  ///
  /// Comparison of the SpO2/FIO2 Ratio and the PaO2/FIO2 Ratio in Patients With Acute Lung Injury or ARDS : http://journal.publications.chestnet.org/article.aspx?articleid=1085326
  ///
  ///
  static double get pO2equivalente {
    // return math.pow((23400 / (1/(Valores.saturacionPerifericaOxigeno!/100)) - 0.99), (1/3)).toDouble();
    double S = (Valores.saturacionPerifericaOxigeno! / 100).toDouble();
    //
    double A = (11700) * math.pow((math.pow(1 / S, -1) - 1), -1).toDouble();
    double B = math.pow(math.pow(50, 3) + math.pow(A, 2), (1 / 2)).toDouble();

    return (math.pow(B + A, (1 / 3)) + math.pow(B - A, (1 / 3))).toDouble();
  }

  /// Indice Cintura - Cadera (iC-C)
  ///
  /// VN : Mujeres 0.71 - 0.84, Hombres 0.78 - 0.94
  static double get indiceCinturaCadera {
    if (Valores.circunferenciaCintura! == 0 ||
        Valores.circunferenciaCadera! == 0) {
      return 00.00;
    } else {
      return (Valores.circunferenciaCintura! / Valores.circunferenciaCadera!);
    }
  }

  static double get densidadCorporal {
    if (Valores.edad! == '') {
      return 0.0;
    } else if (Valores.edad! == 0) {
      return 0.0;
    } else if (Valores.edad! <= 11) {
      if (Valores.sexo == ("Masculino")) {
        return 1.1690 -
            (0.0788 *
                numerics.log10((Valores.pliegueCutaneoBicipital! +
                    Valores.pliegueCutaneoTricipital! +
                    Valores.pliegueCutaneoEscapular! +
                    Valores.pliegueCutaneoIliaco!)));
      } else if (Valores.sexo == ("Femenino")) {
        return 1.2063 -
            (0.0999 *
                numerics.log10((Valores.pliegueCutaneoBicipital! +
                    Valores.pliegueCutaneoTricipital! +
                    Valores.pliegueCutaneoEscapular! +
                    Valores.pliegueCutaneoIliaco!)));
      } else {
        return 0.0;
      }
    } else if (Valores.edad! > 11) {
      if (Valores.sexo == ("Masculino")) {
        return 1.1369 -
            (0.0598 *
                numerics.log10((Valores.pliegueCutaneoBicipital! +
                    Valores.pliegueCutaneoTricipital! +
                    Valores.pliegueCutaneoEscapular! +
                    Valores.pliegueCutaneoIliaco!)));
      } else if (Valores.sexo == ("Femenino")) {
        return 1.1533 -
            (0.0643 *
                math.log((Valores.pliegueCutaneoBicipital! +
                    Valores.pliegueCutaneoTricipital! +
                    Valores.pliegueCutaneoEscapular! +
                    Valores.pliegueCutaneoIliaco!)));
      } else {
        return 0.0;
      }
    } else {
      return 0.0;
    }
  }

  //static double get GCE => (495 / densidadCorporal) - 450; // De Siri
  // GCE = (CAD / (Antropometria.getEstatura() * Math.sqrt(Antropometria.getEstatura()))) - 18 // De Brook
  /// Grasa Corporal Esencial (Fórmula de Siri)
  ///
  /// Parte de la medición de la densidad Corporal; es decir, de la medida de los pliegues cutáneos.
  ///
  ///
  static double get grasaCorporalEsencial =>
      ((4.95 / densidadCorporal) - 4.50) * 100; // De Siri

  /// Estimación del Porcentaje de Grasa Corporal (Fórmula de Durenberg)
  ///
  /// VN : Hombres 15-18% : : Mujeres 20-25%
  ///
  /// * Mayor 25% en Hombres, Mayor del 33% en Mujeres, se considera Obesidad.
  ///
  /// ** Consulte : https://www.medigraphic.com/cgi-bin/new/resumen.cgi?IDARTICULO=29821
  ///
  /// Referencias : Lavalle GFJ, Mancillas AL, Villarreal PJZ, et al. Comparación del porcentaje de grasa corporal estimado por la fórmula de Deurenberg y el obtenido por plestismografía por desplazamiento de aire. Rev Salud Publica Nutr. 2011;12(1):.
  ///
  static double get porcentajeGrasaCorporal {
    if (Valores.sexo == "Masculino" && imc != 0) {
      return ((1.2 * imc) +
          (0.23 * Valores.edad!) -
          (10.8 * 1) -
          5.4); // Formula de Deurenberg
    } else if (Valores.sexo == "Femenino" && imc != 0) {
      return ((1.2 * imc) +
          (0.23 * Valores.edad!) -
          (10.8 * 0) -
          5.4); // Formula de Deurenberg
    } else {
      return 0.0;
    }
  }

  static double get pesoCorporalMagro {
    if (Valores.sexo == 'Femenino') {
      return ((9270 * Valores.pesoCorporalTotal!) /
          (8780 + 244 * Antropometrias.imc));
    } else if (Valores.sexo == 'Masculino') {
      return ((9270 * Valores.pesoCorporalTotal!) /
          (6680 + 216 * Antropometrias.imc));
    } else {
      return double.nan;
    }
    // if (Valores.sexo == 'Femenino') {
    //   return (1.07 * Valores.pesoCorporalTotal!) -
    //       (148 *
    //           (math.pow(Valores.pesoCorporalTotal!, 2) /
    //               math.pow(Valores.alturaPaciente! * 100, 2)));
    // } else if (Valores.sexo == 'Masculino') {
    //   return (1.10 * Valores.pesoCorporalTotal!) -
    //       (128 *
    //           (math.pow(Valores.pesoCorporalTotal!, 2) /
    //               math.pow(Valores.alturaPaciente! * 100, 2)));
    // } else {
    //   return double.nan;
    // }
  }

  static double get pesoCorporalGraso {
    return (porcentajeGrasaCorporal * 100) / Valores.pesoCorporalTotal!;
  }

  static double get masaMuscularMagra =>
      7.138 + (0.02908 * Valores.creatinina!); // Masa Magra Muscular
  static double get porcentajeCorporalMagro =>
      ((Valores.pesoCorporalTotal! * (100 - grasaCorporalEsencial)) / 100);

  static String get claseIMC {
    if (Valores.edad! >= 18 && Valores.edad! <= 59) {
      if (Valores.sexo == 'Femenino') {
        // Talla Baja
        if (Valores.alturaPaciente! <= 1.50) {
          if (imc <= 18.5) {
            return 'Bajo Peso (Quetelet)';
          } else if (imc < 18.5 && imc <= 22.9) {
            return "Normal (Quetelet)";
          } else if (imc < 23.0 && imc <= 25.0) {
            return "Sobre - Peso (Quetelet)";
          } else if (imc > 25) {
            return "Obesidad (Quetelet)";
          } else {
            return "Ninguno";
          }
        }
        // # ################################################
        else if (Valores.alturaPaciente! >= 1.50) {
          if (imc == 0.00) {
            return "Clasificaccion de I.M.C. - No Aplica";
          } else if (imc >= 40.00) {
            return "Obesidad Grado III (Quetelet)";
          } else if (imc >= 35.0) {
            return "Obesidad Grado II (Quetelet)";
          } else if (imc >= 30.0) {
            return "Obesidad Grado I (Quetelet)";
          } else if (imc <= 29.99 && imc >= 26.0) {
            return "Sobre - Peso (Quetelet)";
          } else if (imc <= 25.99 && imc >= 18.0) {
            return "Normal (Quetelet)";
          } else if (imc <= 17.99 && imc >= 17.0) {
            return "Bajo Peso (Quetelet)";
          } else if (imc <= 16.99 && imc >= 16.0) {
            return "Desnitricion Moderada (Quetelet)";
          } else if (imc <= 15.99) {
            return "Desnutricion Severa (Quetelet)";
          } else {
            return "Ninguno";
          }
        } else {
          return "Ninguno";
        }
      } else if (Valores.sexo == 'Masculino') {
        // # Talla Baja
        if (Valores.alturaPaciente! <= 1.60) {
          if (imc <= 18.5) {
            return 'Bajo Peso (Quetelet)';
          } else if (imc > 18.5 && imc <= 22.9) {
            return "Normal (Quetelet)";
          } else if (imc > 23.0 && imc <= 25.0) {
            return "Sobre - Peso (Quetelet)";
          } else if (imc > 25) {
            return "Obesidad (Quetelet)";
          } else {
            return "Ninguno";
          }
        } else if (Valores.alturaPaciente! > 1.60) {
          if (imc == 0.00) {
            return "Clasificaccion de I.M.C. - No Aplica";
          } else if (imc >= 40.00) {
            return "Obesidad Grado III (Quetelet)";
          } else if (imc >= 35.0) {
            return "Obesidad Grado II (Quetelet)";
          } else if (imc >= 30.0) {
            return "Obesidad Grado I (Quetelet)";
          } else if (imc < 29.99 && imc >= 26.0) {
            return "Sobre - Peso (Quetelet)";
          } else if (imc < 25.99 && imc >= 18.0) {
            return "Normal (Quetelet)";
          } else if (imc < 17.99 && imc >= 17.0) {
            return "Bajo Peso (Quetelet)";
          } else if (imc < 16.99 && imc >= 16.0) {
            return "Desnitricion Moderada (Quetelet)";
          } else if (imc <= 15.99) {
            return "Desnutricion Severa (Quetelet)";
          } else {
            return "Ninguno";
          }
        } else {
          return "Ninguno";
        }
      } else {
        return "Ninguno";
      }
    } else if (Valores.edad! >= 60) {
      if (imc <= 18.5) {
        return 'Bajo Peso (Quetelet)';
      } else if (imc > 18.5 && imc <= 22.9) {
        return "Normal (Quetelet)";
      } else if (imc > 23.0 && imc <= 25.0) {
        return "Sobre - Peso (Quetelet)";
      } else if (imc > 25) {
        return "Obesidad (Quetelet)";
      } else {
        return "Ninguno";
      }
    } else {
      return "Ninguno";
    }
  }

  static double get perimetroMesobraquial =>
      (Valores.circunferenciaMesobraquial! -
          (3.1416 * (Valores.pliegueCutaneoTricipital! / 100)));

  static double get areaMesobraquial => (math.pow(
          Valores.circunferenciaMesobraquial! -
              (3.1416 * (Valores.pliegueCutaneoTricipital! / 100)),
          2) /
      (4 * 3.1416));

  static double get areaAdiposaMesobraquial =>
      (((perimetroMesobraquial * (Valores.pliegueCutaneoTricipital! / 100)) /
              2) -
          ((3.1416 * (Valores.pliegueCutaneoTricipital! / 100)) / 4));

  /// Agua Metabólica (AM) : H2Om
  ///
  /// Definida como la resultante derivada de las reacciones anabólicas-catabólicas del Organismo, que
  /// culminan en la formación de H2O
  ///
  static double get AM =>
      ((3.1416) * math.pow(((perimetroMesobraquial) / (2 * 3.1416)), 2));

  /// Indice ROX :
  ///
  /// iROX = [SpO2 / Fio2] / fR
  ///
  /// VN:     Mayor 4.88 : : Riesgo bajo de Intubación
  ///             Entre 3.85 - 4.88 : : Riesgo Indeterminado
  ///             Menor a 3.85 : : Riesgo incrementado de Intubación
  ///
  /// Valores menores a 3 a los 60 minutos de inicio de HFNC (OAF)
  ///                  menores a 3.5 a las 6 horas, ó 4 a las 12 horas
  ///                  predicen la neccesidad de intubación.
  ///       En pacientes con SDRA se recomienda evaluar a los 60 minutos.
  ///       Cuando se mide 12 horas despues de iniciar HFN, un indice ROX mayor de 4.88 es
  ///       un determinante de éxito de HFNC en pacientes con neumonía.
  ///
  /// ** Consulte: https://www.ncbi.nlm.nih.gov/pubmed/27481760?dopt=Abstract
  ///
  /// https://ebmcalc.com/NoteRight3000/ROX.htm#:~:text=ROXIndex%20%3D%20O2Sat%20%2F,%28FIO2%20%2F%20100%29%20%2F%20RespiratoryRate
  ///
  /// *** Referencias:
  ///
  /// Roca O, Messika J, Caralt B, et al. Predicting success of high-flow nasal cannula in pneumonia patients with hypoxemic respiratory failure: The utility of the ROX index. J Crit Care. 2016 Oct;35:200-5. PubMed ID: 27481760 ::: https://www.ncbi.nlm.nih.gov/pubmed/27481760
  ///
  /// Gianstefani A, Farina G, Salvatore V, et al. Role of ROX index in the first assessment of COVID-19 patients in the emergency department. Intern Emerg Med. 2021 Mar 1:1–7. PubMed ID: 33646507 ::: https://www.ncbi.nlm.nih.gov/pubmed/33646507
  ///
  /// Roca O, Caralt B, Messika J, Samper M, et al. An Index Combining Respiratory Rate and Oxygenation to Predict Outcome of Nasal High-Flow Therapy. Am J Respir Crit Care Med. 2019 Jun 1;199(11):1368-1376. PubMed ID: 30576221 ::: https://www.ncbi.nlm.nih.gov/pubmed/30576221
  ///
  static double get indiceRox =>
      (Valores.saturacionPerifericaOxigeno! /
          (Valores.fraccionInspiratoriaOxigeno! / 100)) /
      Valores.frecuenciaRespiratoria!;
}
