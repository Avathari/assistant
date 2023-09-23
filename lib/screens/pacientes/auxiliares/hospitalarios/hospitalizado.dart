import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/dummy/dummy.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/diagnosticados.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/expedientes.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/hospitalizacion.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/padecimientoActual.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/situacionesHospitalizacion.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';

import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/GridLayout.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/ThreeLabelText.dart';
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
          if (isMobile(context))
            GrandButton(
              weigth: 1000,
              labelButton: 'Datos de hospitalización del paciente',
              onPress: () {
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const PadecimientoActual()));
                            // Operadores.openActivity(
                            //     context: context,
                            //     chyldrim: const PadecimientoActual(),
                            //     onAction: () {
                            //       Repositorios.actualizarRegistro();
                            //     });
                          }),
                      GrandIcon(
                          iconData: Icons.medication_sharp,
                          labelButton: 'Situación de la Hospitalización',
                          onPress: () {
                            Cambios.toNextActivity(context,
                                chyld: const SituacionesHospitalizacion());
                            // Operadores.openActivity(
                            //     context: context,
                            //     chyldrim: const SituacionesHospitalizacion(),
                            //     onAction: () {
                            //       setState(() {
                            //         Situaciones.actualizarRegistro();
                            //       });
                            //     });
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
                );
              },
            )
          else
            TittlePanel(
                padding: 2, textPanel: 'Datos de hospitalización del paciente', fontSize: 12,),
          if (isMobile(context))
            mobileView()
          else
            isTablet(context) ? tabletView() : tabletView() // deskTopView()
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const PadecimientoActual()));
                    // Operadores.openActivity(
                    //     context: context,
                    //     chyldrim: const PadecimientoActual(),
                    //     onAction: () {
                    //       Repositorios.actualizarRegistro();
                    //     });
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
                      builder: (BuildContext context) => GestionDiagnosticos(),
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
    if (widget.isVertical!) {
      return Expanded(
        child: Column(
          children: [
            Expanded(
                flex: isTablet(context)
                    ? 3
                    : isMobile(context)
                    ? 3
                    : 5,
                child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: component(context),
                    ))),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Acciones en la Hospitalización.
                  Expanded(
                    child: GrandIcon(
                      iconData: Icons.upload_file,
                      labelButton: 'Configurar registro de la atención',
                      onPress: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              GestionHospitalizaciones(),
                        ));
                      },
                    ),
                  ),
                  Expanded(
                    child: GrandIcon(
                        iconData: Icons.medical_information_outlined,
                        labelButton: 'Padecimiento Actual',
                        onPress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                              const PadecimientoActual()));
                          // Operadores.openActivity(
                          //     context: context,
                          //     labelButton: 'Actualizar',
                          //     chyldrim: const PadecimientoActual(),
                          //     onAction: () {
                          //       Repositorios.actualizarRegistro();
                          //     });
                        }),
                  ),
                  Expanded(
                    child: GrandIcon(
                        iconData: Icons.medication_sharp,
                        labelButton: 'Situación de la Hospitalización',
                        onPress: () {
                          Cambios.toNextActivity(context,
                              chyld: const SituacionesHospitalizacion());
                        }),
                  ),
                  Expanded(
                    child: GrandIcon(
                        iconData: Icons.restore_page_outlined,
                        labelButton: 'Diagnósticos de la Hospitalización',
                        onPress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                GestionDiagnosticos(),
                          ));
                        }),
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
    } else {
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
          isTablet(context) || isDesktop(context)
              ? Expanded(
            flex: isTablet(context) || isDesktop(context) ? 1 : 0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              decoration: ContainerDecoration.roundedDecoration(),
              child: GridLayout(
                childAspectRatio: isDesktop(context) ? 1.0 : 0.9,
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                            const PadecimientoActual()));
                        // Operadores.openActivity(
                        //     context: context,
                        //     chyldrim: const PadecimientoActual(),
                        //     onAction: () {
                        //       Repositorios.actualizarRegistro();
                        //     });
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
  }

  deskTopView() {
    if (widget.isVertical!) {
      return Expanded(
        child: Column(
          children: [
            Expanded(
                flex: isTablet(context)
                    ? 3
                    : isMobile(context)
                        ? 3
                        : 3,
                child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: component(context),
                    ))),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Acciones en la Hospitalización.
                  Expanded(
                    child: GrandIcon(
                      iconData: Icons.upload_file,
                      labelButton: 'Configurar registro de la atención',
                      onPress: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              GestionHospitalizaciones(),
                        ));
                      },
                    ),
                  ),
                  Expanded(
                    child: GrandIcon(
                        iconData: Icons.medical_information_outlined,
                        labelButton: 'Padecimiento Actual',
                        onPress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const PadecimientoActual()));
                          // Operadores.openActivity(
                          //     context: context,
                          //     labelButton: 'Actualizar',
                          //     chyldrim: const PadecimientoActual(),
                          //     onAction: () {
                          //       Repositorios.actualizarRegistro();
                          //     });
                        }),
                  ),
                  Expanded(
                    child: GrandIcon(
                        iconData: Icons.medication_sharp,
                        labelButton: 'Situación de la Hospitalización',
                        onPress: () {
                          Cambios.toNextActivity(context,
                              chyld: const SituacionesHospitalizacion());
                        }),
                  ),
                  Expanded(
                    child: GrandIcon(
                        iconData: Icons.restore_page_outlined,
                        labelButton: 'Diagnósticos de la Hospitalización',
                        onPress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                GestionDiagnosticos(),
                          ));
                        }),
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
    } else {
      return Expanded(
        child: Column(
          children: [
            Expanded(
                flex: isTablet(context)
                    ? 3
                    : isMobile(context)
                        ? 3
                        : 3,
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
                                    GestionHospitalizaciones(),
                              ));
                            },
                          ),
                        ),
                        Expanded(
                          child: GrandIcon(
                              iconData: Icons.medical_information_outlined,
                              labelButton: 'Padecimiento Actual',
                              onPress: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const PadecimientoActual()));
                                // Operadores.openActivity(
                                //     context: context,
                                //     labelButton: 'Actualizar',
                                //     chyldrim: const PadecimientoActual(),
                                //     onAction: () {
                                //       Repositorios.actualizarRegistro();
                                //     });
                              }),
                        ),
                        Expanded(
                          child: GrandIcon(
                              iconData: Icons.medication_sharp,
                              labelButton: 'Situación de la Hospitalización',
                              onPress: () {
                                Cambios.toNextActivity(context,
                                    chyld: const SituacionesHospitalizacion());
                              }),
                        ),
                        Expanded(
                          child: GrandIcon(
                              iconData: Icons.restore_page_outlined,
                              labelButton: 'Diagnósticos de la Hospitalización',
                              onPress: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      GestionDiagnosticos(),
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
              margin: 1,
              padding: 1,
              firstText: 'Cama Asignada',
              secondText: Valores.numeroCama, // .toString(),
            ),
          ),
          Expanded(
            child: ValuePanel(
              margin: 1,
              padding: 1,
              firstText: 'D.E.H.',
              secondText: Valores.diasEstancia.toString(),
            ),
          ),
        ],
      ),
      ValuePanel(
        margin: 1,
        padding: 1,
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
      CrossLine(
        height: 1,
      ),
      Row(
        children: [
          Expanded(
            child: ValuePanel(
              margin: 1,
              padding: 1,
              firstText: 'C. Programada',
              secondText: '', // Valores.servicioTratanteInicial,
            ),
          ),
          Expanded(
            child: ValuePanel(
              margin: 1,
              padding: 1,
              firstText: 'E. Prolongada',
              secondText: Valores
                  .isEstanciaProlongada, // Valores.servicioTratanteInicial,
            ),
          ),
          Expanded(
            child: ValuePanel(
              margin: 1,
              padding: 1,
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
