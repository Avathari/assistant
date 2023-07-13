import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/diagnosticados.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/expedientes.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/hospitalizacion.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/padecimientoActual.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/situacionesHospitalizacion.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';

import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/GridLayout.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/ThreeLabelText.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';

class Hospitalizado extends StatefulWidget {
  const Hospitalizado({super.key});

  @override
  State<Hospitalizado> createState() => _HospitalizadoState();
}

class _HospitalizadoState extends State<Hospitalizado> {
  @override
  void initState() {
    setState(() {
      print(Valores.diasEstancia);
      Valores.diasEstancia;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TittlePanel(
              padding: 5, textPanel: 'Datos de hospitalización del paciente'),
          if (isMobile(context)) mobileView() else isTablet(context)
              ? tabletView()
              : tabletView()// deskTopView()
        ]);
  }

  mobileView() {
    return GestureDetector(
      onDoubleTap: () {
        Operadores.openActivity(
          context: context,
          chyldrim: GridLayout(
            // childAspectRatio: ,
            columnCount: 2,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Acciones en la Hospitalización.
              GrandIcon(
                iconData: Icons.upload_file,
                labelButton: 'Configurar registro de la atención',
                onPress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        OperacionesHospitalizaciones(
                          retornar: true,
                          operationActivity: Constantes.Update,
                        ),
                  ));
                },
              ),
              GrandIcon(
                  iconData: Icons.medical_information_outlined,
                  labelButton: 'Padecimiento Actual',
                  onPress: () {
                    Operadores.openActivity(
                        context: context,
                        chyldrim: const PadecimientoActual(),
                        onAction: () {
                          Repositorios.actualizarRegistro();
                        });
                  }),
              GrandIcon(
                  iconData: Icons.medication_sharp,
                  labelButton: 'Situación de la Hospitalización',
                  onPress: () {
                    Operadores.openActivity(
                        context: context,
                        chyldrim: const SituacionesHospitalizacion(),
                        onAction: () {
                          setState(() {
                            Situaciones.actualizarRegistro();
                          });
                        });
                  }),
              GrandIcon(
                  iconData: Icons.restore_page_outlined,
                  labelButton: 'Diagnósticos de la Hospitalización',
                  onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          GestionDiagnosticos(
                          ),
                    ));
                  }),
              GrandIcon(
                  iconData: Icons.airline_seat_flat,
                  labelButton: 'Protocolo Quirúrgico',
                  onPress: () {}),
              GrandIcon(
                  iconData: Icons.report_problem_outlined,
                  labelButton: 'Conflictos relacionados a la Hospitalización',
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
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: component(context),
      ),
    );
  }

  tabletView() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: isTablet(context) || isDesktop(context) ? 3 : 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: component(context),
              ),
            ),
          ),
          isTablet(context)|| isDesktop(context)
              ? Expanded(
            flex: isTablet(context) || isDesktop(context) ? 1 : 0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              decoration: ContainerDecoration.roundedDecoration(),
              child: GridLayout(
                childAspectRatio: isDesktop(context) ? 1.0: 0.9,
                columnCount: 2,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Acciones en la Hospitalización.
                  GrandIcon(
                    iconData: Icons.upload_file,
                    labelButton: 'Configurar registro de la atención',
                    onPress: () {
                      if (isDesktop(context)) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              GestionHospitalizaciones(
                              ),
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
                        Operadores.openActivity(
                            context: context,
                            chyldrim: const PadecimientoActual(),
                            onAction: () {
                              Repositorios.actualizarRegistro();
                            });
                      }),
                  GrandIcon(
                      iconData: Icons.medication_sharp,
                      labelButton: 'Situación de la Hospitalización',
                      onPress: () {
                        Operadores.openActivity(
                            context: context,
                            chyldrim: const SituacionesHospitalizacion(),
                            onAction: () {
                              setState(() {
                                Situaciones.actualizarRegistro();
                              });
                            });
                      }),
                  GrandIcon(
                      iconData: Icons.restore_page_outlined,
                      labelButton: 'Diagnósticos de la Hospitalización',
                      onPress: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              GestionDiagnosticos(
                              ),
                        ));
                      }),
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
            ),
          )
              : Container()
        ]);
  }

  deskTopView() {
    return Expanded(
      child: Column(
        children: [
          Expanded(
              flex: isTablet(context) ? 3 : isMobile(context) ? 3 : 3,
              child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: component(context),
                  ))),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Acciones en la Hospitalización.
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: GrandIcon(
                          iconData: Icons.upload_file,
                          labelButton: 'Configurar registro de la atención',
                          onPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    GestionHospitalizaciones(
                                    ),
                              ));

                          },
                        ),
                      ),
                      Expanded(
                        child: GrandIcon(
                            iconData: Icons.medical_information_outlined,
                            labelButton: 'Padecimiento Actual',
                            onPress: () {
                              Operadores.openActivity(
                                  context: context,
                                  labelButton: 'Actualizar',
                                  chyldrim: const PadecimientoActual(),
                                  onAction: () {
                                    Repositorios.actualizarRegistro();
                                  });
                            }),
                      ),
                      Expanded(
                        child: GrandIcon(
                            iconData: Icons.medication_sharp,
                            labelButton: 'Situación de la Hospitalización',
                            onPress: () {
                              Operadores.openActivity(
                                  context: context,
                                  chyldrim: const SituacionesHospitalizacion(),
                                  labelButton: 'Actualizar',
                                  onAction: () {
                                    Situaciones.actualizarRegistro();
                                  });
                            }),
                      ),
                      Expanded(
                        child: GrandIcon(
                            iconData: Icons.restore_page_outlined,
                            labelButton: 'Diagnósticos de la Hospitalización',
                            onPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    GestionDiagnosticos(
                                    ),
                              ));
                            }),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                          labelButton: 'Actualizar',
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
        ],
      ),
    );
  }

  component(BuildContext context) {
    return [
      Row(
        children: [
          Expanded(
            child: ValuePanel(
              withBorder: false,
              firstText: 'Folio',
              secondText: Pacientes.ID_Hospitalizacion.toString(),
            ),
          ),
          Expanded(
            child: ValuePanel(
              withBorder: false,
              firstText: 'Ingreso Hospitalario',
              secondText: Valores.fechaIngresoHospitalario,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: ValuePanel(
              firstText: 'Cama Asignada',
              secondText: Valores.numeroCama, // .toString(),
            ),
          ),
          Expanded(
            child: ValuePanel(
              firstText: 'D.E.H.',
              secondText: Valores.diasEstancia.toString(),
            ),
          ),
        ],
      ),
      ValuePanel(
        withBorder: false,
        firstText: 'Médico Tratante',
        secondText: Valores.medicoTratante,
      ),
      Row(
        children: [
          Expanded(
            child: ValuePanel(
              padding: 2.0,
              firstText: 'Servicio Tratante',
              secondText: Valores.servicioTratante,
            ),
          ),
          Expanded(
            child: ValuePanel(
              padding: 2.0,
              firstText: 'Servicio de Ingreso',
              secondText: Valores.servicioTratanteInicial,
            ),
          ),
        ],
      ),
      CrossLine(),
      Row(
        children: [
          Expanded(
            child: ValuePanel(
              firstText: 'C. Programada',
              secondText: '', // Valores.servicioTratanteInicial,
            ),
          ),
          Expanded(
            child: ValuePanel(
              firstText: 'E. Prolongada',
              secondText: Valores.isEstanciaProlongada, // Valores.servicioTratanteInicial,
            ),
          ),
          Expanded(
            child: ValuePanel(
              firstText: 'I. Pendiente',
              secondText: '', // Valores.servicioTratanteInicial,
            ),
          ),
        ],
      ),
    ];
  }
}


class OpcionesHospitalizacion extends StatefulWidget {
  const OpcionesHospitalizacion({Key? key}) : super(key: key);

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
