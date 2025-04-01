import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Insulinas extends StatefulWidget {
  const Insulinas({super.key});

  @override
  State<Insulinas> createState() => _InsulinasState();
}

class _InsulinasState extends State<Insulinas> {
  double? pesoCorporalTotal = 0;
  double? dtd1 = 0, dtd2 = 0, dtd3 = 0, dtd4 = 0, dtd5 = 0, dtd6 = 0;
  double? fsiRapida = 0, fsiRegular = 0; // FSI : IAR . . 1800 ; IGR . . 1500
  double? dosisInsulinaPrevia = 10;
  double? ajusteActualInsulina = 0, glucosaActual = 0;

  @override
  void initState() {
    setState(() {
      if (Valores.pesoCorporalTotal != null) {
        pesoCorporalTotal = Valores.pesoCorporalTotal;
      } else {
        pesoCorporalTotal = 70;
      }

      operation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            CrossLine(height: 15),
            EditTextArea(
              labelEditText: "Peso Corporal Total(kG)",
              textController: pesoCorporalTotalTextController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              numOfLines: 1,
              onChange: (value) {
                setState(() {
                  Terminal.printExpected(
                      message: "Value : $value");
                  pesoCorporalTotal =
                      double.parse(value);
                  operation();
                });
              },
            ),
            // Row(
            //   children: [
            //     Expanded(
            //       flex: 3,
            //       child: ValuePanel(
            //         firstText: 'P.C.T.',
            //         secondText: pesoCorporalTotal!.toStringAsFixed(2),
            //         thirdText: 'Kg',
            //         withEditMessage: true,
            //         onEdit: (value) {
            //           Operadores.editActivity(
            //               context: context,
            //               tittle: "Editar . . . ",
            //               message: "¿Peso Corporal Total? . . . ",
            //               onAcept: (value) {
            //                 // Terminal.printSuccess(
            //                 //     message:
            //                 //         "recieve $value");
            //                 setState(() {
            //                   pesoCorporalTotal = double.parse(value);
            //                   operation();
            //                   Navigator.of(context).pop();
            //                 });
            //               });
            //         },
            //       ),
            //     ),
            //     CrossLine(height: 8, isHorizontal: false, color: Colors.grey),
            //     // Expanded(
            //     //   child: ValuePanel(
            //     //     firstText: "DTD(0.4)",
            //     //     secondText: dtd4!.round().toString(),
            //     //     thirdText: "UI/Día",
            //     //   ),
            //     // ),
            //     // Expanded(
            //     //   child: ValuePanel(
            //     //     firstText: "DTD(0.5)",
            //     //     secondText: dtd5!.round().toString(),
            //     //     thirdText: "UI/Día",
            //     //   ),
            //     // ),
            //     // Expanded(
            //     //   child: ValuePanel(
            //     //     firstText: "DTD(0.6)",
            //     //     secondText: dtd6!.round().toString(),
            //     //     thirdText: "UI/Día",
            //     //   ),
            //     // ),
            //   ],
            // ),
            //
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: ValuePanel(
                    firstText: "DTD(0.4)",
                    secondText: dtd4!.round().toString(),
                    thirdText: "UI/Día",
                  ),
                ),
                Expanded(
                  child: ValuePanel(
                    firstText: "DTD(0.5)",
                    secondText: dtd5!.round().toString(),
                    thirdText: "UI/Día",
                  ),
                ),
                Expanded(
                  child: ValuePanel(
                    firstText: "DTD(0.6)",
                    secondText: dtd6!.round().toString(),
                    thirdText: "UI/Día",
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: ValuePanel(
                    firstText: "DTD(0.1)",
                    secondText: dtd1!.round().toString(),
                    thirdText: "UI/Día",
                  ),
                ),
                Expanded(
                  child: ValuePanel(
                    firstText: "DTD(0.2)",
                    secondText: dtd2!.round().toString(),
                    thirdText: "UI/Día",
                  ),
                ),
                Expanded(
                  child: ValuePanel(
                    firstText: "DTD(0.3)",
                    secondText: dtd3!.round().toString(),
                    thirdText: "UI/Día",
                  ),
                ),
              ],
            ),
            CrossLine(thickness: 3),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ValuePanel(
                    firstText: 'DBB',
                    secondText: "", // pesoCorporalTotal!.toStringAsFixed(2),
                    thirdText: '',
                  ),
                ),
              ],
            ),
            EditTextArea(
              labelEditText: "Insulina Basal Previa (UI/Dia)",
              textController: insulinaPreviaTextController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              numOfLines: 1,
              onChange: (value) {
                setState(() {
                  Terminal.printExpected(
                      message: "Value : $value");
                  dosisInsulinaPrevia =
                      double.parse(value);
                  operation();
                });
              },
            ),
            EditTextArea(
              labelEditText: "Glucemia Actual (mg/dL)",
              textController: glucemiaActualTextController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              numOfLines: 1,
              onChange: (value) {
                setState(() {
                  Terminal.printExpected(
                      message: "Value : $value");
                  glucosaActual =
                      double.parse(value);
                  operation();
                });
              },
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ValuePanel(
                    firstText: 'F.S.I (IAR)',
                    secondText: fsiRapida!
                        .round()
                        .toString(), // pesoCorporalTotal!.toStringAsFixed(2),
                    thirdText: 'mg/dL/UI ',
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ValuePanel(
                    firstText: 'F.S.I (IGR)',
                    secondText: fsiRegular!
                        .round()
                        .toString(), // pesoCorporalTotal!.toStringAsFixed(2),
                    thirdText: 'mg/dL/UI ',
                  ),
                ),
              ],
            ),
            ValuePanel(
              firstText: 'Ajuste de Insulina Basal',
              secondText: ajusteActualInsulina!
                  .round()
                  .toString(), // pesoCorporalTotal!.toStringAsFixed(2),
              thirdText: 'UI/Dia ',
            ),
            ValuePanel(
              firstText: 'Insulina Basal Actual',
              secondText: (ajusteActualInsulina! + dosisInsulinaPrevia!)
                  .round()
                  .toString(), // pesoCorporalTotal!.toStringAsFixed(2),
              thirdText: 'UI/Dia ',
            ),
            CrossLine(height: 20,thickness: 4,),
            GrandButton(labelButton: "Copiar análisis . . . ",
                onPress: (){
              Datos.portapapeles(context: context, text: analisisString());
            }),
          ],
        ),
      ),
    );
  }

  void operation() {
    dtd1 = pesoCorporalTotal! * 0.1;
    dtd2 = pesoCorporalTotal! * 0.2;
    dtd3 = pesoCorporalTotal! * 0.3;
    dtd4 = pesoCorporalTotal! * 0.4;
    dtd5 = pesoCorporalTotal! * 0.5;
    dtd6 = pesoCorporalTotal! * 0.6;
    //
    fsiRapida = 1800 / dosisInsulinaPrevia!;
    fsiRegular = 1600 / dosisInsulinaPrevia!;
    //
    ajusteActualInsulina = (glucosaActual! - 130) / fsiRegular!;
  }

  var pesoCorporalTotalTextController = TextEditingController();
  var insulinaPreviaTextController = TextEditingController();
  var glucemiaActualTextController = TextEditingController();

  String analisisString() {
    return "Insulina basal previa ${dosisInsulinaPrevia!.toStringAsFixed(0)} UI/Día, con glucosa actual ${glucosaActual!.toStringAsFixed(0)} mg/dL, "
        "para F.S.I. ${fsiRegular!.toStringAsFixed(0)} mg/dL por cada UI administrada, "
        "por lo que recomendamos ajuste de insulina de ${ajusteActualInsulina!.toStringAsFixed(0)} UI "
        "para insulina total actual ${ajusteActualInsulina! + dosisInsulinaPrevia!} UI/Día. ";
  }

}
