import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/revisiones/auxiliares/auxiliaresRevisiones.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Embarazadas extends StatefulWidget {
  const Embarazadas({super.key});

  @override
  State<Embarazadas> createState() => _EmbarazadasState();
}

class _EmbarazadasState extends State<Embarazadas> {
  String? _fechaUltimaMestruacion = Calendarios.today();
  double? _alturaFondoUterino = 0.0;

  var AFUtextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TittleContainer(
      padding: 5.0,
      tittle: "Evaluación Iniciar",
      child: Column(
        children: [
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Dispositivos(
                  dispositivoName: "FUR",
                  otherName: _fechaUltimaMestruacion,
                  onChangeValue: (esSelected) async {
                    //
                    if (esSelected) {
                      final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2055),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                                data: ThemeData.dark().copyWith(
                                    dialogBackgroundColor:
                                        Theming.cuaternaryColor),
                                child: child!);
                          });
                      if (picked != null && picked != _fechaUltimaMestruacion) {
                        setState(() {
                          _fechaUltimaMestruacion =
                              DateFormat("yyyy/MM/dd").format(picked);
                        });
                      }
                    } else {
                      setState(() {
                        _fechaUltimaMestruacion = "";
                      });
                    }
                  },
                ),
              ), //
              Expanded(
                child: ValuePanel(
                  firstText: "FPP",
                  secondText: Valores.fechaProbableParto(),
                ),
              ),
            ],
          ),
          CrossLine(),
          EditTextArea(
            labelEditText: "Altura del Fondo Uterino (cm)",
            numOfLines: 1,
            textController: AFUtextController,
            keyBoardType: TextInputType.number,
            inputFormat: MaskTextInputFormatter(),
            onChange: (String value) {
              setState(() {
                _alturaFondoUterino = double.parse(value);
              });
            },
          ),
          ValuePanel(
            firstText: "Edad Gestacional Estimada",
            secondText:
                Valores.edadGestacionalEstimada(_alturaFondoUterino).toString(),
            thirdText: "SDG",
          ),
          Spinner(
              tittle: "K",
              onChangeValue: (value) {},
              items: const ["10", "11", "12", "13"],
              initialValue: "12"),
          ValuePanel(
            firstText: "Peso Fetal Estimado",
            secondText: Valores.pesoFetalEstimado(_alturaFondoUterino).toString(),
            thirdText: "+/- 183 gr",
          ),
        ],
      ),
    );
  }
}
