import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/hepatometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';

class Hepatometricos extends StatefulWidget {
  const Hepatometricos({super.key});

  @override
  State<Hepatometricos> createState() => _HepatometriasState();
}

class _HepatometriasState extends State<Hepatometricos> {

  @override
  void initState() {
    Archivos.readJsonToMap(filePath: Vitales.fileAssocieted)
        .then((onValue) => Vitales.fromJson(onValue!.last)).whenComplete(() => setState(() => {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ValuePanel(
            firstText: "",
            secondText: Valores.fechaHepaticos.toString(),
            thirdText: "",
            fontSize: 8,
            heigth: 36,
          ),
          Expanded(
            flex: isDesktop(context) ? 3 : 4,
            child: GridView(
              padding: const EdgeInsets.all(5.0),
              controller: ScrollController(),
              gridDelegate: GridViewTools.gridDelegate(
                  crossAxisCount: isMobile(context) ? 3 : 5,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  mainAxisExtent: 50), //46
              children: [
                // ValuePanel(
                //   secondText: Valores.fechaHepaticos ?? '',
                // ),
                ValuePanel(
                  firstText: "BT",
                  secondText: Valores.bilirrubinasTotales!.toStringAsFixed(2),
                  thirdText: "mg/dL",
                ),
                ValuePanel(
                  firstText: "BD",
                  secondText: Valores.bilirrubinaDirecta!.toStringAsFixed(2),
                  thirdText: "mg/dL",
                ),
                ValuePanel(
                  firstText: "BI",
                  secondText: Valores.bilirrubinaIndirecta!.toStringAsFixed(2),
                  thirdText: "mg/dL",
                ),
                ValuePanel(
                  firstText: "GGT",
                  secondText: Valores.glutrailtranspeptidasa!.toStringAsFixed(0),
                  thirdText: "UI/L",
                ),
                ValuePanel(
                  firstText: "FA",
                  secondText: Valores.fosfatasaAlcalina!.toStringAsFixed(0),
                  thirdText: "UI/L",
                ),
                CrossLine(),
                ValuePanel(
                  firstText: "Alb",
                  secondText: Valores.albuminaSerica!.toStringAsFixed(1),
                  thirdText: "g/dL",
                ),
                ValuePanel(
                  firstText: "Prot-",
                  secondText: Valores.proteinasTotales!.toStringAsFixed(1),
                  thirdText: "g/dL",
                ),
                CrossLine(),
                ValuePanel(
                  firstText: "AST",
                  secondText:
                  Valores.aspartatoaminotransferasa!.toStringAsFixed(1),
                  thirdText: "UI/L",
                ),
                ValuePanel(
                  firstText: "ALT",
                  secondText: Valores.alaninoaminotrasferasa!.toStringAsFixed(1),
                  thirdText: "UI/L",
                ),
              ],
            ),
          ),
          CrossLine(height: 1),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                ValuePanel(
                  padding: 0.0,
                  firstText: "Factor R",
                  secondText: Hepatometrias.factorR.toStringAsFixed(2),
                  thirdText: "",
                  fontSize: 9,
                  heigth: 36,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ValuePanel(
                        firstText: "AST/ALT",
                        secondText:
                        Hepatometrias.relacionASTALT.toStringAsFixed(2),
                        thirdText: "",
                      ),
                    ),
                    Expanded(
                      child: ValuePanel(
                        firstText: "ALT/FA",
                        secondText:
                        Hepatometrias.relacionALTFA.toStringAsFixed(2),
                        thirdText: "",
                      ),
                    ),
                    Expanded(
                      child: ValuePanel(
                        firstText: "ALT/DHL",
                        secondText:
                        Hepatometrias.relacionALTDHL.toStringAsFixed(2),
                        thirdText: "",
                      ),
                    ),
                    Expanded(
                      child: ValuePanel(
                        firstText: "GGT/FA",
                        secondText:
                        Hepatometrias.relacionGGTFA.toStringAsFixed(2),
                        thirdText: "",
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ValuePanel(
                        firstText: "BD/BI",
                        secondText: Hepatometrias.relacionBDBI.toStringAsFixed(2),
                        thirdText: "",
                      ),
                    ),
                    Expanded(
                      child: ValuePanel(
                        firstText: "BD/BT",
                        secondText: Hepatometrias.relacionBDBT.toStringAsFixed(2),
                        thirdText: "",
                      ),
                    ),
                    // Expanded(
                    //   child: ValuePanel(
                    //     firstText: "ALT/DHL",
                    //     secondText: Hepatometrias.relacionALTDHL.toStringAsFixed(2),
                    //     thirdText: "",
                    //   ),
                    // ),
                    // Expanded(
                    //   child: ValuePanel(
                    //     firstText: "GGT/FA",
                    //     secondText: Hepatometrias.relacionGGTFA.toStringAsFixed(2),
                    //     thirdText: "",
                    //   ),
                    // ),
                  ],
                ),
                CrossLine(),
                Row(
                  children: [
                    Expanded(
                      child: ValuePanel(
                        firstText: "iAPRI",
                        secondText: Hepatometrias.APRI.toStringAsFixed(2),
                        thirdText: "",
                      ),
                    ),
                    Expanded(
                      child: ValuePanel(
                        firstText: "FIB-4",
                        secondText: Hepatometrias.Fib4.toStringAsFixed(2),
                        thirdText: "",
                      ),
                    ),
                  ],
                ),
                GrandButton(
                    height: 40,
                    fontSize: 8.0,
                    labelButton: "Análisis Hepáticos",
                    onPress: () => Datos.portapapeles(
                        context: context, text: Hepatometrias.hepaticos())),
              ],
            ),
          )
        ],
      ),
    );
  }
}
