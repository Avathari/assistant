import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';

class Metabolometrias {
  // CALCULOS ENERGÉTICOS

  // CONCLUSIONES
  static String get metabolometrias =>
      "Análisis Energético: Gasto Energético Basal ${Metabolometrias.gastoEnergeticoBasal.toStringAsFixed(2)} kCal/dia "
      "(Factor de Actividad ${Valores.factorActividad}; "
      "Factor de Éstres ${Valores.factorEstres}); "
      "Metabolismo Basal ${Metabolometrias.metabolismoBasal.toStringAsFixed(2)} kCal/m2/hr, "
      "Efecto Térmico de los Alimentos ${Metabolometrias.efectoTermicoAlimentos.toStringAsFixed(2)} kCal/m2/hr. "
      "Gasto Energético Total ${Metabolometrias.gastoEnergeticoTotal.toStringAsFixed(2)} kCal/dia. "
      "Fibra total ${Metabolometrias.fibraDietaria.toStringAsFixed(2)} gr/Día";
  // FÓRMULAS
  static double get gastoEnergeticoBasal {
    if (Valores.sexo == "Masculino") {
      return 655 +
          (9.6 * Valores.pesoCorporalTotal!) +
          (1.8 * Valores.alturaPaciente! * 100) -
          (4.7 * Valores.edad!);
    } else if (Valores.sexo == "Femenino") {
      return 66 +
          (13.7 * Valores.pesoCorporalTotal!) +
          (5.0 * (Valores.alturaPaciente! * 100)) -
          (6.8 * Valores.edad!);
    } else {
      return 0.0;
    }
  }

  static double get metabolismoBasal => 37 - ((Valores.edad! - 20) / 10);

  static double get efectoTermicoAlimentos => metabolismoBasal * 0.1;

  static double get gastoEnergeticoTotal {
    if (Valores.factorActividad! == 0 && Valores.factorEstres! == 0) {
      return gastoEnergeticoBasal +
          (gastoEnergeticoBasal *
              (Valores.factorActividad! + efectoTermicoAlimentos));
    } else if (Valores.factorActividad! != 0 && Valores.factorEstres! != 0) {
      return gastoEnergeticoBasal +
          (gastoEnergeticoBasal *
              (Valores.factorActividad!) *
              (Valores.factorEstres!));
    } else {
      return 0.0;
    }
  }

  static double get fibraDietaria =>
      (gastoEnergeticoTotal * 0.02); // / 1000) * 10; // 0.02

  static double get glucosaPorcentaje =>
      ((gastoEnergeticoTotal / 100) * (porcentajeCarbohidratos));

  static double get lipidosPorcentaje =>
      ((gastoEnergeticoTotal / 100) * (porcentajeLipidos));

  static double get proteinasPorcentaje =>
      ((gastoEnergeticoTotal / 100) * (porcentajeProteinas));

  static double get aguaTotal =>
      (gastoEnergeticoTotal * 1.0) / 1000; // 0.5 - 2.25

  static double get glucosaGramos => (glucosaPorcentaje / 4.0);

  static double get lipidosGramos => (lipidosPorcentaje / 9.0);

  static double get proteinasGramos => (proteinasPorcentaje / 4.0);

  static double get proteinasAVM => (Antropometrias.pesoCorporalPredicho / 1.5);

  static double get sodioDietario =>
      (Antropometrias.pesoCorporalPredicho / 2.0);

  static double get potasioDietario =>
      (Antropometrias.pesoCorporalPredicho / 3.0);

  static double get cloroDietario =>
      (Antropometrias.pesoCorporalPredicho / 5.0);

  static double get magnesioDietario =>
      (Antropometrias.pesoCorporalPredicho / 3.5);

  static double get calcioDietario =>
      (Antropometrias.pesoCorporalPredicho / 14.0);

  static double get selenioDietario =>
      (Antropometrias.pesoCorporalPredicho / 0.7);

  static double get hierroDietario =>
      (Antropometrias.pesoCorporalPredicho / 0.14);

  static double get fosforoDietario =>
      (Antropometrias.pesoCorporalPredicho / 11.42);

  static double get cromoDietario =>
      (Antropometrias.pesoCorporalPredicho / 0.71);

  static int get sumaPorcentualMetabolicos =>
      porcentajeCarbohidratos + porcentajeProteinas + porcentajeLipidos;

  static double get edadMetabolica {
    if (Valores.sexo == 'Masculino') {
      return 66 +
          (6.23 * Valores.pesoCorporalTotal!) +
          (12.7 * Valores.alturaPaciente!) -
          (6.8 * Valores.edad!);
    } else if (Valores.sexo == 'Femenino') {
      return 66 +
          (4.35 * Valores.pesoCorporalTotal!) +
          (4.7 * Valores.alturaPaciente!) -
          (4.7 * Valores.edad!);
    } else {
      return 0.0;
    }
  }

  /// Indice Catabólico : Indice de Bristian
  ///
  /// Tambien llamado 'Indice de Bristian', empleado para medir el estado metabólico del paciente, generalmente
  /// quirúrgico.
  ///
  /// Cat_I =
  ///       Cat_I = Indice Catabólico (g/d)
  ///       Ingesta Proteica (g/d)
  ///       UUN = Nitrógeno de Urea (U, g/d)
  ///       *UUN/0.8 representa el UUN más el N+ urinario no-ureico.
  ///       *2.5 es la suma del N+ fecal y tegumentario.
  ///
  ///  Consulta  :https://www.scymed.com/es/smnxpn/pnjdh298.htm
  static double get indiceCatabolico {
    return (Valores.nitrogenoUrinario! / 0.8) -
        ((0.5 * (Valores.ingestaProteica! / 6.25)) + 3);
  }

  /// Balance Nitrogenado
  ///
  /// Cociente entre los compuestos nitrogenados administrados contra los depurados.
  ///
  static double get balanceNitrogenado {
    return (Valores.ingestaProteica! - Valores.nitrogenoUrinario!);
  }

  // VARIABLES ESTATICAS
  static int porcentajeCarbohidratos = 50;
  static int porcentajeLipidos = 20;
  static int porcentajeProteinas = 30;
}
