import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/hospitalarios/hospitalizado.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/hospitalizacion.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/pendientes.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandLabel.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';

class ActividadesHospitalarias extends StatefulWidget {
  const ActividadesHospitalarias({Key? key}) : super(key: key);

  @override
  State<ActividadesHospitalarias> createState() => _ActividadesHospitalariasState();
}

class _ActividadesHospitalariasState extends State<ActividadesHospitalarias> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GrandLabel(
                  iconData: Icons.padding,
                  fontSized: isMobile(context) ? 8 : 14,
                  labelButton: 'Registro de Hospitalizaciones',
                  onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          GestionHospitalizaciones(),
                    ));
                  },
                ),
              ),
              Expanded(
                child: GrandLabel(
                  iconData: Icons.padding,
                  fontSized: isMobile(context) ? 8 : 14,
                  labelButton: 'Pendientes de la Atención',
                  onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => GestionPendiente(),
                    ));
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TittlePanel(
                  textPanel: Pacientes.modoAtencion,
                ),
              ),
              Expanded(
                child: GrandLabel(
                  iconData: Icons.local_hospital,
                  fontSized: isMobile(context) ? 8 : 14,
                  labelButton: Pacientes.esHospitalizado == true
                      ? 'Egresar paciente'
                      : 'Hospitalizar paciente',
                  onPress: () async {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (BuildContext context) =>
                    //       GestionPendiente(),
                    // ));
                    // final respo = await Pacientes.hospitalizar();
                    // // Actualizar vista.
                    // setState(() {
                    //   if (respo) {
                    //     Valores.modoAtencion = 'Hospitalización';
                    //     Pacientes.modoAtencion = 'Hospitalización';
                    //     // Actualizar valores de Hospitalización.
                    //     Valores.isHospitalizado = respo;
                    //     Pacientes.esHospitalizado = respo;
                    //
                    //     // asyncHospitalizar(context);
                    //     Operadores.openActivity(
                    //       context: context,
                    //       chyldrim: const OpcionesHospitalizacion(),
                    //       onAction: () {},
                    //     );
                    //   } else {
                    //     Valores.modoAtencion = 'Consulta Externa';
                    //     Pacientes.modoAtencion = 'Consulta Externa';
                    //     // Actualizar valores de Hospitalización.
                    //     Valores.isHospitalizado = respo;
                    //     Pacientes.esHospitalizado = respo;
                    //   }
                    // });
                    // //
                  },
                ),
              ),
            ],
          ),
          CrossLine(),
          
        ],
      ),
    );
  }
}
