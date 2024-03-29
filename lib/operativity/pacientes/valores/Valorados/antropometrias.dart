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
          "Peso Corporal Magro ${Antropometrias.porcentajeCorporalMagro.toStringAsFixed(2)} Kg. ";
    }
    if (isAbreviado) {
      return "Análisis de Medidas Corporales: "
          "Peso Corporal Ideal ${Antropometrias.pesoCorporalPredicho.toStringAsFixed(2)} Kg, "
          "Indice de Masa Corporal ${Antropometrias.imc.toStringAsFixed(2)} Kg/m2. (${Antropometrias.claseIMC}). "
          "Superficie Corporal Total ${Antropometrias.SC.toStringAsFixed(2)} m2. ";
    }else {
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
          "Estatura ${Valores.alturaPaciente} mts";

  static String get vitalesTerapiaAbreviado =>
      "TA ${Valores.tensionArterialSistemica} mmHg, "
          "FC ${Valores.frecuenciaCardiaca} L/min, "
          "FR ${Valores.frecuenciaRespiratoria} L/min, "
          "Temp ${Valores.temperaturCorporal}°C, "
          "SpO2 ${Valores.saturacionPerifericaOxigeno}%, "
          "PCT ${Valores.pesoCorporalTotal} Kg, "
          "Estatura ${Valores.alturaPaciente} mts, "
          "IMC ${Antropometrias.imc.toStringAsFixed(2)} Kg/m2, "
          "PCI ${Antropometrias.pesoCorporalPredicho.toStringAsFixed(2)} Kg";

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


// FÓRMULAS
  static double get pesoCorporalPredicho {
    print("Valores.sexo ${Valores.sexo}");
    if (Valores.sexo == "Masculino") {
      return 23.0 * (Valores.alturaPaciente! * Valores.alturaPaciente!);
    } else if (Valores.sexo == "Femenino") {
      return 21.5 * (Valores.alturaPaciente! * Valores.alturaPaciente!);
    } else {
      return 0.00;
    }
  }

  static double get imc =>
      Valores.pesoCorporalTotal! / (Valores.alturaPaciente! * Valores.alturaPaciente!);

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

  /// Indice Cintura - Cadera ; Mujeres 0.71 - 0.84, Hombres 0.78 - 0.94
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
  static double get grasaCorporalEsencial =>
      ((495 / densidadCorporal) - 450) * -100; // De Siri

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
      return (1.07 * Valores.pesoCorporalTotal!) -
          (148 *
              (math.pow(Valores.pesoCorporalTotal!, 2) /
                  math.pow(Valores.alturaPaciente! * 100, 2)));
    } else if (Valores.sexo == 'Masculino') {
      return (1.10 * Valores.pesoCorporalTotal!) -
          (128 *
              (math.pow(Valores.pesoCorporalTotal!, 2) /
                  math.pow(Valores.alturaPaciente! * 100, 2)));
    } else {
      return double.nan;
    }
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

  static double get AM =>
      ((3.1416) * math.pow(((perimetroMesobraquial) / (2 * 3.1416)), 2));

}


