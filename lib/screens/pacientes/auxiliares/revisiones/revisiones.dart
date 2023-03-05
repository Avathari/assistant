import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/RoundedPanel.dart';
import 'package:assistant/widgets/ThreeLabelText.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Revisiones extends StatefulWidget {
  const Revisiones({Key? key}) : super(key: key);

  @override
  State<Revisiones> createState() => _RevisionesState();
}

class _RevisionesState extends State<Revisiones> {
  String secondText = "", otroText = "";

  @override
  Widget build(BuildContext context) {
    return RoundedPanel(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: TittlePanel(textPanel: 'Revisión General')),
          Expanded(
            flex: 9,
            child: GridView(
              padding: const EdgeInsets.all(5.0),
              controller: ScrollController(),
              gridDelegate: GridViewTools.gridDelegate(
                  crossAxisCount: 2, mainAxisExtent: 20),
              children: [
                ThreeLabelTextAline(
                  firstText: "T. Sistólica",
                  secondText: secondText,
                  thirdText: "mmHg",
                  withEditMessage: true,
                  onEdit: (value) {
                    Operadores.editActivity(
                        context: context,
                        tittle: "Editar . . . ",
                        message: "Seleccione nuevo valor para Hoa . . . ",
                        onAcept: (value) {
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            secondText = value;
                            Navigator.of(context).pop();
                          });
                        });
                  },
                ),
                ThreeLabelTextAline(
                  firstText: "T. Diastólica",
                  secondText: otroText,
                  thirdText: "mmHg",
                  withEditMessage: true,
                  onEdit: (value) {
                    Operadores.editActivity(
                        context: context,
                        tittle: "Editar . . . ",
                        message: "Seleccione nuevo valor para Hoa . . . ",
                        onAcept: (value) {
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            otroText = value;
                            Navigator.of(context).pop();
                          });
                        });
                  },
                ),
                ThreeLabelTextAline(
                  firstText: "Frec. Cardiaca",
                  secondText: secondText,
                  thirdText: "Lat/min",
                  withEditMessage: true,
                  onEdit: (value) {
                    Operadores.editActivity(
                        context: context,
                        tittle: "Editar . . . ",
                        message: "Seleccione nuevo valor para Hoa . . . ",
                        onAcept: (value) {
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            secondText = value;
                            Navigator.of(context).pop();
                          });
                        });
                  },
                ),
                ThreeLabelTextAline(
                  firstText: "Frec. Respiratoria",
                  secondText: otroText,
                  thirdText: "Resp/min",
                  withEditMessage: true,
                  onEdit: (value) {
                    Operadores.editActivity(
                        context: context,
                        tittle: "Editar . . . ",
                        message: "Seleccione nuevo valor para Hoa . . . ",
                        onAcept: (value) {
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            otroText = value;
                            Navigator.of(context).pop();
                          });
                        });
                  },
                ),
                ThreeLabelTextAline(
                  firstText: "T. Corporal",
                  secondText: secondText,
                  thirdText: "°C",
                  withEditMessage: true,
                  onEdit: (value) {
                    Operadores.editActivity(
                        context: context,
                        tittle: "Editar . . . ",
                        message: "Seleccione nuevo valor para Hoa . . . ",
                        onAcept: (value) {
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            secondText = value;
                            Navigator.of(context).pop();
                          });
                        });
                  },
                ),
                ThreeLabelTextAline(
                  firstText: "SpO2",
                  secondText: otroText,
                  thirdText: "Resp/min",
                  withEditMessage: true,
                  onEdit: (value) {
                    Operadores.editActivity(
                        context: context,
                        tittle: "Editar . . . ",
                        message: "Seleccione nuevo valor para Hoa . . . ",
                        onAcept: (value) {
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            otroText = value;
                            Navigator.of(context).pop();
                          });
                        });
                  },
                ),
                CrossLine(),
                CrossLine(),
                ThreeLabelTextAline(
                  firstText: "P. Corporal",
                  secondText: secondText,
                  thirdText: "Kg",
                  withEditMessage: true,
                  onEdit: (value) {
                    Operadores.editActivity(
                        context: context,
                        tittle: "Editar . . . ",
                        message: "Seleccione nuevo valor para Hoa . . . ",
                        onAcept: (value) {
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            secondText = value;
                            Navigator.of(context).pop();
                          });
                        });
                  },
                ),
                ThreeLabelTextAline(
                  firstText: "Estatura",
                  secondText: otroText,
                  thirdText: "mts",
                  withEditMessage: true,
                  onEdit: (value) {
                    Operadores.editActivity(
                        context: context,
                        tittle: "Editar . . . ",
                        message: "Seleccione nuevo valor para Hoa . . . ",
                        onAcept: (value) {
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            otroText = value;
                            Navigator.of(context).pop();
                          });
                        });
                  },
                ),

                ThreeLabelTextAline(
                  firstText: "Glucemia C.",
                  secondText: secondText,
                  thirdText: "mg/dL",
                  withEditMessage: true,
                  onEdit: (value) {
                    Operadores.editActivity(
                        context: context,
                        tittle: "Editar . . . ",
                        message: "Seleccione nuevo valor para Hoa . . . ",
                        onAcept: (value) {
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            secondText = value;
                            Navigator.of(context).pop();
                          });
                        });
                  },
                ),
                ThreeLabelTextAline(
                  firstText: "Horas ayuno",
                  secondText: otroText,
                  thirdText: "Horas",
                  withEditMessage: true,
                  onEdit: (value) {
                    Operadores.editActivity(
                        context: context,
                        tittle: "Editar . . . ",
                        message: "Seleccione nuevo valor para Hoa . . . ",
                        onAcept: (value) {
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            otroText = value;
                            Navigator.of(context).pop();
                          });
                        });
                  },
                ),
                CrossLine(),
                CrossLine(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
