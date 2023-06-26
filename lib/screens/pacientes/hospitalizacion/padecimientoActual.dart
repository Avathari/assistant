import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PadecimientoActual extends StatefulWidget {
  const PadecimientoActual({Key? key}) : super(key: key);

  @override
  State<PadecimientoActual> createState() => _PadecimientoActualState();
}

class _PadecimientoActualState extends State<PadecimientoActual> {
  var fechaPadecimientoTextController = TextEditingController();
  var padecimientoActualTextController = TextEditingController();

  @override
  void initState() {
    Actividades.consultarId(
            Databases.siteground_database_reghosp,
            Repositorios.repositorio['consultPadecimientoQuery'],
            Pacientes.ID_Hospitalizacion)
        .then((response) {
      print("RESPUESTA $response");
      if (response['Error'] == 'Hubo un error') {
        Operadores.alertActivity(
            context: context,
            tittle: 'Error en la Consulta',
            message:
                'ERROR - No se pudo consultar el Padecimiento Actual . . . \n'
                'Creando nuevo padecimiento actual',
        onAcept: (){
              Navigator.of(context).pop();
              Navigator.of(context).pop();
        });
        Repositorios.registrarRegistro();
      } else {
        setState(() {
          fechaPadecimientoTextController.text =
              response['FechaPadecimiento'] ??
                  Calendarios.today(format: 'yyyy/MM/dd');
          padecimientoActualTextController.text = response['Contexto'] ?? '';
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TittlePanel(textPanel: 'Padecimiento Actual'),
        EditTextArea(
          keyBoardType: TextInputType.datetime,
          inputFormat: MaskTextInputFormatter(
              mask: '####/##/##', filter: {"#": RegExp(r'[0-9]')}),
          labelEditText: 'Fecha de Inicio Padecimiento',
          textController: fechaPadecimientoTextController,
          withShowOption: true,
          selection: true,
          onSelected: () {
            fechaPadecimientoTextController.text =
                Calendarios.today(format: 'yyyy/MM/dd');
          },
          numOfLines: 1,
          onChange: (value) {
            setState(() {
              fechaPadecimientoTextController.text = value;
            });
          },
        ),
        EditTextArea(
          keyBoardType: TextInputType.text,
          inputFormat: MaskTextInputFormatter(),
          labelEditText: 'Descripción del Padecimiento Actual',
          textController: padecimientoActualTextController,
          numOfLines: isTablet(context) ? 10 : 15,
          onChange: (value) {
            setState(() {
              Valores.padecimientoActual = value;
            });
          },
        ),
        // EditTextArea(
        //   keyBoardType: TextInputType.text,
        //   inputFormat: MaskTextInputFormatter(),
        //   labelEditText: 'Descripción del Padecimiento Actual',
        //   textController: padecimientoActualTextController,
        //   numOfLines: isTablet(context) ? 10 : 15,
        //   onChange: (value) {
        //     setState(() {
        //       Valores.padecimientoActual = value;
        //     });
        //   },
        // ),
        // EditTextArea(
        //   keyBoardType: TextInputType.text,
        //   inputFormat: MaskTextInputFormatter(),
        //   labelEditText: 'Descripción del Padecimiento Actual',
        //   textController: padecimientoActualTextController,
        //   numOfLines: isTablet(context) ? 15 : 15,
        //   onChange: (value) {
        //     setState(() {
        //       Valores.padecimientoActual = value;
        //     });
        //   },
        // ),
      ],
    );
  }

}
