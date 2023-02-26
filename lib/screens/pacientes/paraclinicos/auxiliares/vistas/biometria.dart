import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Biometrias extends StatefulWidget {
  const Biometrias({Key? key}) : super(key: key);

  @override
  State<Biometrias> createState() => _BiometriasState();
}

class _BiometriasState extends State<Biometrias> {
  static var index = 0; // Biometrias

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(7.0),
      controller: ScrollController(),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Hemoglobina',
                  style: Styles.textSyleGrowth(fontSize: 12),
                ),
              ),
              Expanded(
                flex: 2,
                child: EditTextArea(
                  textController: textHemoglobinaResultController,
                  keyBoardType: TextInputType.number,
                  inputFormat: MaskTextInputFormatter(),
                  labelEditText: "Resultado",
                  numOfLines: 1,
                ),
              ),
              Expanded(
                flex: 2,
                child: Spinner(
                    width: isTabletAndDesktop(context) ? 60 : 60, // 90
                    tittle: "Unidad de Medida",
                    initialValue: unidadMedidaHemoglobina!,
                    items: Auxiliares.Medidas[Auxiliares.Categorias[index]],
                    onChangeValue: (String? newValue) {
                      setState(() {
                        unidadMedidaHemoglobina = newValue!;
                      });
                    }),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Eritrocitos',
                  style: Styles.textSyleGrowth(fontSize: 12),
                ),
              ),
              Expanded(
                flex: 2,
                child: EditTextArea(
                  textController: textEritrocitosResultController,
                  keyBoardType: TextInputType.number,
                  inputFormat: MaskTextInputFormatter(),
                  labelEditText: "Resultado",
                  numOfLines: 1,
                ),
              ),
              Expanded(
                flex: 2,
                child: Spinner(
                    width: isTabletAndDesktop(context) ? 60 : 60, // 90
                    tittle: "Unidad de Medida",
                    initialValue: unidadMedidaEritrocitos!,
                    items: Auxiliares.Medidas[Auxiliares.Categorias[index]],
                    onChangeValue: (String? newValue) {
                      setState(() {
                        unidadMedidaEritrocitos = newValue!;
                      });
                    }),
              ),
            ],
          ),
          // Botton ***** ******* ****** * ***
          CrossLine(
            color: Colors.grey,
          ),
          Container(
            margin: const EdgeInsets.all(5.0),
            decoration: ContainerDecoration.roundedDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GrandButton(
                      labelButton: "Agregar Datos", weigth: 2000, onPress: () {}),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  List<List<String>> listOfValues() {
    return [
      [
        // 0,
        Pacientes.ID_Paciente.toString(),
        Calendarios.today(format: "yyyy/MM/dd"),
        Auxiliares.Categorias[index],
        "Hemoglobina",
        textHemoglobinaResultController.text,
        unidadMedidaHemoglobina!
        //0,
      ],
    ];
  }

  // VARIABLES DE LA INTERFAZ
  var textHemoglobinaResultController = TextEditingController();
  String? unidadMedidaHemoglobina =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textEritrocitosResultController = TextEditingController();
  String? unidadMedidaEritrocitos =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][4];
}
