import 'dart:math';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/info/info.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';

class Hepatometrias {
  // ANALISIS
  static String hepaticos() {
    return ""
        "TP ${Valores.tiempoProtrombina} seg, \n"
        "TPt ${Valores.tiempoTromboplastina} seg, \n"
        "INR ${Valores.INR} seg, \n"
        "BT ${Valores.bilirrubinasTotales} mg/dL, \n"
        "- - -  \n"
        "Relacion BD:BT ${Hepatometrias.relacionBDBT}, considerar : ${infoHepatometrias.clusterDiagnosticos_BD_BT}"
        "Relacion BD:BI ${Hepatometrias.relacionBDBI}, considerar : ${infoHepatometrias.clusterDiagnosticos_BD_BI}"
        "Relacion ALT:FA ${Hepatometrias.relacionALTFA}, considerar : ${infoHepatometrias.clusterDiagnosticos_ALT_FA}"
        "Relacion AST:ALT ${Hepatometrias.relacionASTALT}, considerar : ${infoHepatometrias.clusterDiagnosticos_AST_ALT}"
        "Relacion GGT:FA ${Hepatometrias.relacionGGTFA}, considerar : ${infoHepatometrias.clusterDiagnosticos_GGT_FA}"
        "- - -  \n"
        "APRi ${APRI.toStringAsFixed(2)}; "
        "Fib4 ${Fib4.toStringAsFixed(2)}; "
        "Puntaje de Maddrey ${funcionDiscriminanteMaddrey.toStringAsFixed(2)}; "
        "Lille ${modeloLille(evolucionBilirrubina: 1.2, renalInsufficiency: true).toStringAsFixed(2)}";
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

  static double get relacionALTFA {
    if (Valores.alaninoaminotrasferasa! != 0 &&
        Valores.fosfatasaAlcalina! != 0) {
      return (Valores.alaninoaminotrasferasa! / Valores.fosfatasaAlcalina!);
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
}

// Puntaje de Maddrey : si Mayor a 32 : : Hepatitis Grave (Mort mayor 50%) , Menor 32 : : Hepatitis Moderada (Mort 10%)
