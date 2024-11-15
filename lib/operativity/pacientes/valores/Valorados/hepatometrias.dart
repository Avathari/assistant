import 'dart:math';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/info/info.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';

class Hepatometrias {
  // ANALISIS
  static String hepaticos() {
    return ""
        "Valores Iniciales: "
        "TP ${Valores.tiempoProtrombina} seg, "
        "TPt ${Valores.tiempoTromboplastina} seg, "
        "INR ${Valores.INR} seg, "
        "BT ${Valores.bilirrubinasTotales} mg/dL, "
        "- - -  \n"
        "Analítica: "
        "Factor R ${Hepatometrias.factorR.toStringAsFixed(2)}, "
        "Relacion BD:BT ${Hepatometrias.relacionBDBT.toStringAsFixed(2)}, considerar : ${infoHepatometrias.clusterDiagnosticos_BD_BT}"
        "Relacion BD:BI ${Hepatometrias.relacionBDBI.toStringAsFixed(2)}, considerar : ${infoHepatometrias.clusterDiagnosticos_BD_BI}"
        "Relacion ALT:FA ${Hepatometrias.relacionALTFA.toStringAsFixed(2)}, considerar : ${infoHepatometrias.clusterDiagnosticos_ALT_FA}"
        "Relacion AST:ALT ${Hepatometrias.relacionASTALT.toStringAsFixed(2)}, considerar : ${infoHepatometrias.clusterDiagnosticos_AST_ALT}"
        "Relacion GGT:FA ${Hepatometrias.relacionGGTFA.toStringAsFixed(2)}, considerar : ${infoHepatometrias.clusterDiagnosticos_GGT_FA}"
        "- - -  "
        // "\n"
        "APRi ${APRI.toStringAsFixed(2)}, "
        "Fib4 ${Fib4.toStringAsFixed(2)}, "
        "Puntaje de Maddrey ${funcionDiscriminanteMaddrey.toStringAsFixed(2)}, "
        "Módelo Lille ${modeloLille(evolucionBilirrubina: 1.2, renalInsufficiency: true).toStringAsFixed(2)}";
  }

  // ECUACIONES
  static double get funcionDiscriminanteMaddrey =>
      ((4.5 * Valores.tiempoProtrombina!) - 12) +
      Valores.bilirrubinasTotales!; // TP control = 12 seg

  static double modeloLille(
      {required double evolucionBilirrubina,
      required bool renalInsufficiency}) {
    return 3.19 -
        (0.101 * Valores.edad!) +
        (0.147 * Valores.albuminaSerica!) +
        (0.0165 * (evolucionBilirrubina)) -
        (0.206 * (Dicotomicos.toInt(renalInsufficiency.toString()))) -
        (0.0065 * (Valores.bilirrubinasTotales!)) -
        (0.0096 * (Valores.tiempoProtrombina!));
  }

  static double get MELD =>
      (3.8 * log(Valores.bilirrubinasTotales!)) +
      (1.2 * log(Valores.INR!) + (9.6 * log(Valores.creatinina!)));
  static double get APRI =>
      ((Valores.aspartatoaminotransferasa! / 40) / Valores.plaquetas!) * 100;
  static double get Fib4 =>
      (Valores.edad! * Valores.aspartatoaminotransferasa!) /
      (Valores.plaquetas! * sqrt(Valores.alaninoaminotrasferasa!));
  //
  static double get relacionASTALT {
    if (Valores.alaninoaminotrasferasa! != 0 &&
        Valores.aspartatoaminotransferasa! != 0) {
      return (Valores.alaninoaminotrasferasa! /
          Valores.aspartatoaminotransferasa!);
    } else {
      return double.nan;
    }
  }

  ///
  /// VN: Mayor a 2.5: Consumo de Alcohol
  ///
  static double get relacionGGTFA {
    if (Valores.glutrailtranspeptidasa! != 0 &&
        Valores.fosfatasaAlcalina! != 0) {
      return (Valores.glutrailtranspeptidasa! / Valores.fosfatasaAlcalina!);
    } else {
      return double.nan;
    }
  }

  static double get factorR {
    if (Valores.aspartatoaminotransferasa! != 0 &&
        Valores.fosfatasaAlcalina! != 0) {
      return (Valores.aspartatoaminotransferasa! / 40) /
          (Valores.fosfatasaAlcalina! / 104);
    } else {
      return double.nan;
    }
  }

  ///
  /// VN: Mayor a 5: Hepatocelular
  ///         2-5: Mixto
  ///         Menor a 2: Colestásico
  ///
  ///
  ///
  static double get relacionALTFA {
    if (Valores.alaninoaminotrasferasa! != 0 &&
        Valores.fosfatasaAlcalina! != 0) {
      return (Valores.alaninoaminotrasferasa! / Valores.fosfatasaAlcalina!);
    } else {
      return double.nan;
    }
  }

  ///
  /// VN: Menor a 1: Hepatitis Viral
  ///         Mayor a 2: Hepatitis por alcohol, cirrosis de cualquier etiología
  ///         Mayor a 4: FHA, Enf. Wilson Agudo
  ///         Mayor a 1: Fibrosis o Enfermedad Avanzada EHNA / Cirrosis por VHC
  ///
  static double get relacionALTAST {
    if (Valores.alaninoaminotrasferasa! != 0 &&
        Valores.aspartatoaminotransferasa! != 0) {
      return (Valores.alaninoaminotrasferasa! /
          Valores.aspartatoaminotransferasa!);
    } else {
      return double.nan;
    }
  }

  ///
  /// VN: Mayor a 1.5: Hepatitis Viral
  ///         Menor a 1.5: Isquemica, toxicidad por paracetamol
  ///
  ///
  ///
  static double get relacionALTDHL {
    if (Valores.alaninoaminotrasferasa! != 0 &&
        Valores.deshidrogenasaLactica! != 0) {
      return (Valores.alaninoaminotrasferasa! / Valores.deshidrogenasaLactica!);
    } else {
      return double.nan;
    }
  }

  static double get relacionBDBT {
    if (Valores.bilirrubinaDirecta! != 0 && Valores.bilirrubinasTotales! != 0) {
      return (Valores.bilirrubinaDirecta! / Valores.bilirrubinasTotales!);
    } else {
      return double.nan;
    }
  }

  static double get relacionBDBI {
    if (Valores.bilirrubinaDirecta! != 0 &&
        Valores.bilirrubinaIndirecta! != 0) {
      return (Valores.bilirrubinaDirecta! / Valores.bilirrubinaIndirecta!);
    } else {
      return double.nan;
    }
  }

  static double get aniNASH {
    // ANI = -58,5 + 0,637 (MCV) + 3,91 (AST/BD) – 0,406 (IMC) + 6,35 para hombres
    if (Valores.sexo == 'Masculino') {
      return (-58.5 + (0.637 * Valores.volumenCorpuscularMedio!)) +
          (3.91 *
              (Valores.aspartatoaminotransferasa! /
                  Valores.alaninoaminotrasferasa!)) -
          ((0.406 * Antropometrias.imc) + 6.35); //  para hombres
    } else if (Valores.sexo == 'Femenino') {
      return (-58.5 + (0.637 * Valores.volumenCorpuscularMedio!)) +
          (3.91 *
              (Valores.aspartatoaminotransferasa! /
                  Valores.alaninoaminotrasferasa!)) -
          ((0.406 * Antropometrias.imc) + 6.35); //  para hombres
    } else {
      return double.nan;
    }
  }

  static double get globulinas {
    return (Valores.proteinasTotales! - Valores.albuminaSerica!);
  }
}

// Puntaje de Maddrey : si Mayor a 32 : : Hepatitis Grave (Mort mayor 50%) , Menor 32 : : Hepatitis Moderada (Mort 10%)
