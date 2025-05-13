import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/detalles/menus.dart';
import 'package:assistant/screens/pacientes/auxiliares/hospitalarios/quirurgicos/cirugias.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/diagnosticados.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/expedientes.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/hospitalizacion.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/padecimientoActual.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/situacionesHospitalizacion.dart';
import 'package:assistant/screens/pacientes/intensiva/contenidos/concentraciones.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/hitosHospitalarios.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleIcon.dart';

import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';

class Hospitalizado extends StatefulWidget {
  bool? isVertical;

  Hospitalizado({this.isVertical = false, super.key});

  @override
  State<Hospitalizado> createState() => _HospitalizadoState();
}

class _HospitalizadoState extends State<Hospitalizado> {
  @override
  void initState() {
    // Cargar análisis si hay hospitalización activa
    if (Pacientes.ID_Hospitalizacion != 0) Repositorios.consultarAnalisis();

    setState(() {
      Valores.diasEstancia;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => TittleContainer(
      color:
          widget.isVertical == true ? Colores.backgroundWidget : Colors.black,
      padding: !isMobile(context) ? 5.0 : 4.0,
      centered: !isMobile(context) ? true : false,
      tittle: widget.isVertical == true
          ? "  . : : * * * : : .  "
          : "Hospitalización del paciente",
      child: widget.isVertical == true ? _verticalView() : _generalView());

  _verticalView() {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        children: [
          ValuePanel(
            margin: 1,
            padding: 1,
            withBorder: false,
            firstText: 'Folio',
            secondText: Pacientes.ID_Hospitalizacion.toString(),
          ),
          ValuePanel(
            margin: 1,
            padding: 1,
            withBorder: false,
            firstText: 'NG.: ',
            secondText: Valores.fechaIngresoHospitalario,
          ),
          ValuePanel(
            margin: 1,
            padding: 1,
            firstText: 'Cama',
            secondText: Valores.numeroCama, // .toString(),
          ),
          ValuePanel(
            margin: 1,
            padding: 1,
            firstText: 'D.E.H.',
            secondText: Valores.diasEstancia.toString(),
          ),
          CrossLine(
            height: 1,
            color: Colors.grey,
          ),
          CircleIcon(
              iconed: Icons.receipt_outlined,
              radios: 30,
              difRadios: 5,
              onChangeValue: () => Repositorios.consultarAnalisis()),
          CrossLine(
            height: 1,
            color: Colors.grey,
            thickness: 2,
          ),
          CircleIcon(
              iconed: Icons.local_hospital_outlined,
              onChangeValue: () => Cambios.toNextActivity(context,
                  chyld: OperacionesHospitalizaciones(
                      operationActivity: Constantes.Update))),
          const SizedBox(height: 25),
          CircleIcon(
              iconed: Icons.balance,
              onChangeValue: () => Operadores.openDialog(
                  context: context, chyldrim: const Concentraciones())),
        ],
      ),
    );
  }

  _generalView() {
    if (!isMobile(context)) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: isMobile(context) ? 6 : 6,
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: component(context),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Acciones en la Hos pitalización.
                  GrandIcon(
                    iconData: Icons.upload_file,
                    labelButton: 'Configurar registro de la atención',
                    onPress: () {
                      if (isDesktop(context)) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              GestionHospitalizaciones(),
                        ));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              OperacionesHospitalizaciones(
                            retornar: true,
                            operationActivity: Constantes.Update,
                          ),
                        ));
                      }
                    },
                  ),
                  GrandIcon(
                      iconData: Icons.medical_information_outlined,
                      labelButton: 'Padecimiento Actual',
                      onPress: () {
                        // ScaffoldMessenger.of(context).clearMaterialBanners();
                        //
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PadecimientoActual()));
                      }),
                  GrandIcon(
                      iconData: Icons.airline_seat_flat,
                      labelButton: 'Protocolo Quirúrgico',
                      onPress: () =>
                          Cambios.toNextPage(context, GestionCirugias())),
                  GrandIcon(
                      iconData: Icons.report_problem_outlined,
                      labelButton:
                          'Conflictos relacionados a la Hospitalización',
                      onPress: () {}),
                  GrandIcon(
                      iconData: Icons.data_array,
                      labelButton: 'Situación del Expediente Clínico',
                      onPress: () {
                        Operadores.openActivity(
                            context: context,
                            chyldrim: const ExpedientesClinicos(),
                            onAction: () {
                              setState(() {
                                Expedientes.actualizarRegistro();
                              });
                            });
                      }),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Menus.accionesHospitalizacion(context),
                    GrandIcon(
                      iconData: Icons.history_edu,
                      labelButton: 'Hitos de la Hospialización . . . ',
                      onPress: () async {
                        Cambios.toNextActivity(context, chyld: Hitoshospitalarios(),);
                      },
                    ),
                  ],
                ),
              ),
            )
          ]);
    } else {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: isMobile(context) ? 18 : 3,
              child: Wrap(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: component(context)),
            ),
            Expanded(child: CrossLine(thickness: 3)),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Acciones en la Hospitalización.
                    GrandIcon(
                      iconData: Icons.upload_file,
                      labelButton: 'Configurar registro de la atención',
                      onPress: () {
                        if (isDesktop(context)) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                GestionHospitalizaciones(),
                          ));
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                OperacionesHospitalizaciones(
                              retornar: true,
                              operationActivity: Constantes.Update,
                            ),
                          ));
                        }
                      },
                    ),
                    GrandIcon(
                        iconData: Icons.medical_information_outlined,
                        labelButton: 'Padecimiento Actual',
                        onPress: () {
                          // ScaffoldMessenger.of(context).clearMaterialBanners();
                          //
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PadecimientoActual()));
                        }),
                    GrandIcon(
                        iconData: Icons.medication_sharp,
                        labelButton: 'Situación de la Hospitalización',
                        onPress: () {
                          Cambios.toNextActivity(context,
                              chyld: const SituacionesHospitalizacion());
                        }),
                    GrandIcon(
                        iconData: Icons.restore_page_outlined,
                        labelButton: 'Diagnósticos de la Hospitalización',
                        onPress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                GestionDiagnosticos(),
                          ));
                        }),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GrandIcon(
                          iconData: Icons.airline_seat_flat,
                          labelButton: 'Protocolo Quirúrgico',
                          onPress: () {}),
                      GrandIcon(
                          iconData: Icons.report_problem_outlined,
                          labelButton:
                              'Conflictos relacionados a la Hospitalización',
                          onPress: () {}),
                      GrandIcon(
                          iconData: Icons.data_array,
                          labelButton: 'Situación del Expediente Clínico',
                          onPress: () {
                            Operadores.openActivity(
                                context: context,
                                chyldrim: const ExpedientesClinicos(),
                                onAction: () {
                                  setState(() {
                                    Expedientes.actualizarRegistro();
                                  });
                                });
                          }),
                    ],
                  ),
                )),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Menus.accionesHospitalizacion(context),
                    GrandIcon(
                      iconData: Icons.history_edu,
                      labelButton: 'Hitos de la Hospialización . . . ',
                      onPress: () async {
                        Cambios.toNextActivity(context, chyld: Hitoshospitalarios(),);
                      },
                    ),
                  ],
                ),
              ),
            )
          ]);
    }
  }

  component(BuildContext context) {
    return [
      Row(
        children: [
          Expanded(
            child: ValuePanel(
              margin: 1,
              padding: 1,
              withBorder: false,
              firstText: 'Folio',
              secondText: Pacientes.ID_Hospitalizacion.toString(),
            ),
          ),
          Expanded(
            child: ValuePanel(
              margin: 1,
              padding: 1,
              withBorder: false,
              firstText: 'NG . :',
              secondText: Valores.fechaIngresoHospitalario ?? "",
            ),
          ),
          if (!isMobile(context))
            Expanded(
              child: ValuePanel(
                margin: 1,
                padding: 1,
                firstText: 'Cama . : ',
                secondText: Valores.numeroCama ?? "", // .toString(),
              ),
            ),
          if (!isMobile(context))
            Expanded(
              child: ValuePanel(
                margin: 1,
                padding: 1,
                firstText: 'D.E.H.',
                secondText: Valores.diasEstancia.toString() ?? "",
              ),
            ),
        ],
      ),
      if (isMobile(context))
        Row(
          children: [
            Expanded(
              child: ValuePanel(
                margin: 1,
                padding: 1,
                firstText: 'Cama . : ',
                secondText: Valores.numeroCama ?? "", // .toString(),
              ),
            ),
            Expanded(
              child: ValuePanel(
                margin: 1,
                padding: 1,
                firstText: 'D.E.H.',
                secondText: Valores.diasEstancia.toString() ?? "",
              ),
            ),
          ],
        ),
      ValuePanel(
        margin: 1,
        padding: 1,
        withBorder: false,
        firstText: 'Médico Tratante',
        secondText: Valores.medicoTratante ?? "",
      ),
      Row(
        children: [
          Expanded(
            child: ValuePanel(
              padding: 2.0,
              firstText: 'S. Trat. ',
              secondText: Valores.servicioTratante ?? "",
            ),
          ),
          Expanded(
            child: ValuePanel(
              padding: 2.0,
              firstText: 'S. Ing. ',
              secondText: Valores.servicioTratanteInicial ?? "",
            ),
          ),
        ],
      ),
      CrossLine(height: 1),
      isMobile(context)
          ? Wrap(
              children: [
                ValuePanel(
                  margin: 1,
                  padding: 1,
                  firstText: 'C. Programada',
                  secondText: '', // Valores.servicioTratanteInicial,
                ),
                ValuePanel(
                  margin: 1,
                  padding: 1,
                  firstText: 'E. Prolongada',
                  secondText: Valores
                      .isEstanciaProlongada, // Valores.servicioTratanteInicial,
                ),
                ValuePanel(
                  margin: 1,
                  padding: 1,
                  firstText: 'I. Pendiente',
                  secondText: '', // Valores.servicioTratanteInicial,
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ValuePanel(
                    margin: 1,
                    padding: 1,
                    firstText: 'C. Programada',
                    secondText: '', // Valores.servicioTratanteInicial,
                  ),
                  ValuePanel(
                    margin: 1,
                    padding: 1,
                    firstText: 'E. Prolongada',
                    secondText: Valores
                        .isEstanciaProlongada, // Valores.servicioTratanteInicial,
                  ),
                  ValuePanel(
                    margin: 1,
                    padding: 1,
                    firstText: 'I. Pendiente',
                    secondText: '', // Valores.servicioTratanteInicial,
                  ),
                ],
              ),
            ),
    ];
  }
}

// **************************************************************** * * *

class OpcionesHospitalizacion extends StatefulWidget {
  const OpcionesHospitalizacion({super.key});

  @override
  State<OpcionesHospitalizacion> createState() =>
      _OpcionesHospitalizacionState();
}

class _OpcionesHospitalizacionState extends State<OpcionesHospitalizacion> {
  List<String> auxiliarServicios = [];

  var servicioTratanteValue;
  var servicioTratanteInicialValue;

  @override
  void initState() {
    super.initState();
    for (var element in Escalas.serviciosHospitalarios) {
      auxiliarServicios.add(element.toString());
    }
    //
    servicioTratanteValue = auxiliarServicios
        .firstWhere((element) => element.contains('Medicina interna'));
    servicioTratanteInicialValue = auxiliarServicios
        .firstWhere((element) => element.contains('Urgencias'));
    //
    setState(() {
      Valores.servicioTratante = servicioTratanteValue;
      Valores.servicioTratanteInicial = servicioTratanteInicialValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      controller: ScrollController(),
      child: Column(
        children: [
          TittlePanel(textPanel: 'Seleccione Servicio de Ingreso'),
          Spinner(
              tittle: "Servicio Tratante",
              onChangeValue: (String value) {
                setState(() {
                  servicioTratanteValue = value;
                  Valores.servicioTratante = value;
                });
              },
              items: auxiliarServicios,
              width: isTablet(context)
                  ? 200
                  : isMobile(context)
                      ? 120
                      : 200,
              initialValue: servicioTratanteValue),
          Spinner(
              tittle: "Servicio Que Inicia Tratamiento",
              onChangeValue: (String value) {
                setState(() {
                  servicioTratanteInicialValue = value;
                  Valores.servicioTratanteInicial = value;
                });
              },
              items: auxiliarServicios,
              width: isTablet(context)
                  ? 200
                  : isMobile(context)
                      ? 120
                      : 200,
              initialValue: servicioTratanteInicialValue),
        ],
      ),
    );
  }
}
