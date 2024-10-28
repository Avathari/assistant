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


  /// Calculo de Gasto Energético Basal según constante 20 kCal/Kg/Día
  static double get gastoEnergeticoBasal_A {
    if (Antropometrias.imc >= 30) {
      return (20 * Antropometrias.pesoCorporalIdeal);
    } else{
      return (20 * Valores.pesoCorporalTotal!);
    }
  }

  /// Calculo de Gasto Energético Basal según constante 25 kCal/Kg/Día
     static double get gastoEnergeticoBasal_B {
      if (Antropometrias.imc >= 30) {
        return (25 * Antropometrias.pesoCorporalIdeal);
      } else{
        return (25 * Valores.pesoCorporalTotal!);
      }
    }

  /// Calculo de Requerimiento Proteíco Basal según constante 1.0 - 2.2 gr/Kg/Día (1.7 g/Kg)
  static double get requerimientoProteico => (1.0 * Valores.pesoCorporalTotal!);
  //
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

  /// INDICE TyG :
  ///        El índice TyG fue calculado como el logaritmo natural (Ln) del producto de glucosa y TG plasmáticos,
  ///        según la siguiente fórmula: Ln (TG [mg/dL] x glucosa [mg/dL]/2)14.
  ///     * El índice TyG fue un buen discriminante de SM. La simplicidad de su cálculo justifica profundizar su estudio como marcador alternativo de insulinorresistencia.
  /// El punto de corte para el índice TyG en hombres fue 8,8 y en mujeres 8,7;
  /// Consulte: https://search.bvsalud.org/portal/resource/es/ibc-217725#:~:text=El%20%C3%ADndice%20triglic%C3%A9ridos%20y%20glucosa%20%28TyG%29%20fue%20creado,ha%20empleado%20en%20la%20predicci%C3%B3n%20de%20diabetes%20mellitus.
  /// https://www.elsevier.es/es-revista-endocrinologia-nutricion-12-articulo-ndice-trigliceridos-glucosa-un-indicador-S1575092214002009
  /// * * Unger, G., Benozzi, S. F., Perruzza, F., & Pennacchiotti, G. L. (2014). Índice triglicéridos y glucosa: un indicador útil de insulinorresistencia. Endocrinología y Nutrición, 61(10), 533-540.
  /// * * https://www.incmnsz.mx/2020/uiem/Publicaciones/Indices%20para%20la%20evaluacion%20de%20la%20resistencia%20a%20la%20insulina%20en%20individuos%20mexicanos%20sin%20diabetes.pdf
  ///
  static double get indiceTrigliceridosGlucosa {
    if (Valores.trigliceridos != null && Valores.glucosa != null) {
      return Valores.trigliceridos! / Valores.glucosa!;
    }
    return double.nan;
  }

  /// INDICE TG/HDL
  ///         Se calculó la relación TG/C-HDL.
  /// Los valores respectivos para TG/C-HDL fueron 3,1 en hombres y 2,2 en mujeres.
  ///  * * Salazar et al. en base a un estudio realizado en una población de Argentina, sugirieron que tanto el diagnóstico de SM como la relación TG/C-HDL son adecuados para identificar individuos con IR.
  ///   Consulte: M.R. Salazar, H.A. Carbajal, W.G. Espeche, C.E. Leiva Sisnieguez, C.E. March, E. Balbín, et al. Comparison of the abilities of the plasma triglyceride/high-density lipoprotein cholesterol ratio and the metabolic syndrome to identify insulin resistance.
  ///   Diab Vasc Dis Res, 10 (2013), pp. 346-352
  ///
  static double get indiceTrigliceridosCHDL {
    if (Valores.trigliceridos != null && Valores.cHDL != null) {
      return Valores.trigliceridos! / Valores.cHDL!;
    }
    return double.nan;
  }

  // VARIABLES ESTATICAS
  static int porcentajeCarbohidratos = 50;
  static int porcentajeLipidos = 20;
  static int porcentajeProteinas = 30;
}
