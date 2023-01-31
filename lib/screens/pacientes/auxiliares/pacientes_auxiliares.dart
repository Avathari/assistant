import 'dart:convert';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/expedientes.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/hospitalizacion.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/padecimientoActual.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/situacionesHospitalizacion.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/pendientes.dart';
import 'package:assistant/screens/pacientes/vitales/vitales.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/ChartLine.dart';

import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/GrandLabel.dart';
import 'package:assistant/widgets/GridLayout.dart';
import 'package:assistant/widgets/ImageDialog.dart';
import 'package:assistant/widgets/RoundedPanel.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/ThreeLabelText.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';

class PresentacionPacientes extends StatefulWidget {
  const PresentacionPacientes({super.key});

  @override
  State<PresentacionPacientes> createState() => _PresentacionPacientesState();
}

class _PresentacionPacientesState extends State<PresentacionPacientes> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(6.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => ImageDialog(
                      tittle: Pacientes.nombreCompleto,
                      stringImage: Pacientes.Paciente['Pace_FIAT'],
                      onClose: () {
                        Navigator.of(context).pop();
                      }));
            },
            child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 40,
                child: Pacientes.Paciente['Pace_FIAT'] != ""
                    ? ClipOval(
                        child: Image.memory(
                        base64Decode(Pacientes.Paciente['Pace_FIAT']),
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ))
                    : const ClipOval(child: Icon(Icons.person))),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${Pacientes.Paciente['Pace_Ape_Pat']} ${Pacientes.Paciente['Pace_Ape_Mat']} \n"
                "${Pacientes.Paciente['Pace_Nome_PI']} ${Pacientes.Paciente['Pace_Nome_SE']}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                "${Pacientes.Paciente['Pace_NSS']} ${Pacientes.Paciente['Pace_AGRE']}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                "Edad: ${Pacientes.Paciente['Pace_Eda'].toString()} Años",
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 20,
                child: CrossLine(),
              ),
              Text(
                "Estado actual: ${Pacientes.Paciente['Pace_Stat']}",
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                "Turno de Atención: ${Pacientes.Paciente['Pace_Turo']}",
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ]));
  }
}

class PresentacionPacientesSimple extends StatefulWidget {
  const PresentacionPacientesSimple({super.key});

  @override
  State<PresentacionPacientesSimple> createState() =>
      _PresentacionPacientesSimpleState();
}

class _PresentacionPacientesSimpleState
    extends State<PresentacionPacientesSimple> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(6.0),
        child: GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => ImageDialog(
                    tittle: Pacientes.nombreCompleto,
                    stringImage: Pacientes.Paciente['Pace_FIAT'],
                    onClose: () {
                      Navigator.of(context).pop();
                    }));
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${Pacientes.Paciente['Pace_Ape_Pat']} ${Pacientes.Paciente['Pace_Ape_Mat']} \n"
                  "${Pacientes.Paciente['Pace_Nome_PI']} ${Pacientes.Paciente['Pace_Nome_SE']}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "${Pacientes.Paciente['Pace_NSS']} ${Pacientes.Paciente['Pace_AGRE']}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "Edad: ${Pacientes.Paciente['Pace_Eda'].toString()} Años",
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 20,
                  child: CrossLine(),
                ),
                Text(
                  "Estado actual: ${Pacientes.Paciente['Pace_Stat']}",
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "Turno de Atención: ${Pacientes.Paciente['Pace_Turo']}",
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class Dashboard extends StatefulWidget {
  List<List> dymValues = [];
  List tittles = [
    'T. Sistólica',
    'T. Diastólica',
    'F. Cardiaca',
    'F. Respiratoria',
    'T. Corporal',
    'SPO2 %',
  ];

  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    //
    List list = [];
    //widget.dymValues.clear();

    if (Pacientes.Vitales!.isNotEmpty) {
      for (var i = 0; i < Pacientes.Vitales!.length; i++) {
        list.clear();
        //
        widget.dymValues.insert(i, [
          Pacientes.Vitales![i]['Pace_Feca_SV'],
          Pacientes.Vitales![i]['Pace_SV_tas'],
          Pacientes.Vitales![i]['Pace_SV_tad'],
          Pacientes.Vitales![i]['Pace_SV_fc'],
          Pacientes.Vitales![i]['Pace_SV_fr'],
          Pacientes.Vitales![i]['Pace_SV_tc'],
          Pacientes.Vitales![i]['Pace_SV_spo']
        ]);
      }
    } else {
      widget.dymValues.insert(0, ["0000/00/00", 0, 0, 0, 0, 0, 0]);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return desktopView();
    return isMobile(context)
        ? mobileView()
        : isTablet(context)
            ? mobileView()
            : desktopView();
  }

  ListView mobileView() {
    return ListView(
      shrinkWrap: true,
      controller: ScrollController(),
      padding: const EdgeInsets.all(4.0),
      children: [
        RoundedPanel(
          child: const Detalles(),
        ),
        const SizedBox(height: 6),
        RoundedPanel(
          child: Pacientes.esHospitalizado == true
              ? const Hospitalizado()
              : const EstadisticasVitales(),
        ),
        const SizedBox(height: 6),
        Expanded(
            child: RoundedPanel(
                // child: const Degenerativos()
                )),
        const SizedBox(height: 6),
        Expanded(
            child: RoundedPanel(
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                GrandLabel(
                  iconData: Icons.padding,
                  fontSized: 14,
                  labelButton: 'Pendientes de la Atención',
                  onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => GestionPendiente(),
                    ));
                  },
                ),
                TittlePanel(
                  textPanel: Pacientes.modoAtencion,
                ),
                GrandLabel(
                  iconData: Icons.local_hospital,
                  fontSized: 14,
                  labelButton: Pacientes.esHospitalizado == true
                      ? 'Egresar paciente'
                      : 'Hospitalizar paciente',
                  onPress: () async {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (BuildContext context) =>
                    //       GestionPendiente(),
                    // ));
                    final respo = await Pacientes.hospitalizar();
                    // Actualizar vista.
                    setState(() {
                      if (respo) {
                        Valores.modoAtencion = 'Hospitalización';
                        Pacientes.modoAtencion = 'Hospitalización';
                        // Actualizar valores de Hospitalización.
                        Valores.isHospitalizado = respo;
                        Pacientes.esHospitalizado = respo;

                        // asyncHospitalizar(context);
                        Operadores.openActivity(
                          context: context,
                          chyldrim: const OpcionesHospitalizacion(),
                          onAction: () {
                            print('ON ACTION!!! ${Valores.servicioTratante}');
                          },
                        );
                      } else {
                        Valores.modoAtencion = 'Consulta Externa';
                        Pacientes.modoAtencion = 'Consulta Externa';
                        // Actualizar valores de Hospitalización.
                        Valores.isHospitalizado = respo;
                        Pacientes.esHospitalizado = respo;
                      }
                      print("Pacientes.esHospitalizado "
                          "${Pacientes.esHospitalizado} ${Valores.isHospitalizado} : : \n"
                          "${Pacientes.modoAtencion} ${Valores.modoAtencion}");
                    });
                    //
                  },
                ),
                const CrossLine(),
                GrandLabel(
                  iconData: Icons.padding,
                  fontSized: 14,
                  labelButton: 'Registro de Hospitalizaciones',
                  onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          GestionHospitalizaciones(),
                    ));
                  },
                ),
              ],
            ),
          ),
        )),
        const SizedBox(height: 6),
      ],
    );

    // RoundedPanel(
    //   child: ChartLine(
    //     dymValues: widget.dymValues,
    //     withTittles: true,
    //     tittles: widget.tittles,
    //   ),
    // ),
    // RoundedPanel(
    //   child: const Degenerativos(),
    // ),
  }

  Padding desktopView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: RoundedPanel(
                    child: const Detalles(),
                  )),
                  const SizedBox(width: 6),
                  Expanded(
                    flex: 2,
                    child: RoundedPanel(
                      child: ChartLine(
                        dymValues: widget.dymValues,
                        withTittles: true,
                        tittles: widget.tittles,
                      ),
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 6),
          Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: RoundedPanel(
                    padding: 2,
                    child: Pacientes.esHospitalizado == true
                        ? const Hospitalizado()
                        : const EstadisticasVitales(),
                  )),
                  const SizedBox(width: 6),
                  Expanded(
                      child: RoundedPanel(
                    child: const Degenerativos(),
                  )),
                  const SizedBox(width: 6),
                  Expanded(
                      child: RoundedPanel(
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: Column(
                        children: [
                          GrandLabel(
                            iconData: Icons.padding,
                            fontSized: 14,
                            labelButton: 'Pendientes de la Atención',
                            onPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    GestionPendiente(),
                              ));
                            },
                          ),
                          TittlePanel(
                            textPanel: Pacientes.modoAtencion,
                          ),
                          GrandLabel(
                            iconData: Icons.local_hospital,
                            fontSized: 14,
                            labelButton: Pacientes.esHospitalizado == true
                                ? 'Egresar paciente'
                                : 'Hospitalizar paciente',
                            onPress: () async {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (BuildContext context) =>
                              //       GestionPendiente(),
                              // ));
                              final respo = await Pacientes.hospitalizar();
                              // Actualizar vista.
                              setState(() {
                                if (respo) {
                                  Valores.modoAtencion = 'Hospitalización';
                                  Pacientes.modoAtencion = 'Hospitalización';
                                  // Actualizar valores de Hospitalización.
                                  Valores.isHospitalizado = respo;
                                  Pacientes.esHospitalizado = respo;

                                  // asyncHospitalizar(context);
                                  Operadores.openActivity(
                                    context: context,
                                    chyldrim: const OpcionesHospitalizacion(),
                                    onAction: () {
                                      print('ON ACTION!!!');
                                      print(
                                          'ON ACTION!!! ${Valores.servicioTratante}');
                                    },
                                  );
                                } else {
                                  Valores.modoAtencion = 'Consulta Externa';
                                  Pacientes.modoAtencion = 'Consulta Externa';
                                  // Actualizar valores de Hospitalización.
                                  Valores.isHospitalizado = respo;
                                  Pacientes.esHospitalizado = respo;
                                }
                                print("Pacientes.esHospitalizado "
                                    "${Pacientes.esHospitalizado} ${Valores.isHospitalizado} : : \n"
                                    "${Pacientes.modoAtencion} ${Valores.modoAtencion}");
                              });
                              //
                            },
                          ),
                          const CrossLine(),
                          GrandLabel(
                            iconData: Icons.padding,
                            fontSized: 14,
                            labelButton: 'Registro de Hospitalizaciones',
                            onPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    GestionHospitalizaciones(),
                              ));
                            },
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ))
        ],
      ),
    );
  }
}

class Degenerativos extends StatefulWidget {
  const Degenerativos({super.key});

  @override
  State<Degenerativos> createState() => _DegenerativosState();
}

class _DegenerativosState extends State<Degenerativos> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TittlePanel(padding: 5, textPanel: 'Diagnóstico(s)'),
        Expanded(
            flex: 3,
            child: ListView.separated(
                controller: ScrollController(),
                itemBuilder: ((context, index) {
                  return ListTile(
                    isThreeLine: false,
                    title: Text(
                      Pacientes.Patologicos![index]['Pace_APP_DEG'],
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      Pacientes.Patologicos![index]['Pace_APP_DEG_com'],
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  );
                }),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 0,
                    ),
                itemCount: Pacientes.Patologicos!.length))
      ],
    );
  }
}

class Detalles extends StatefulWidget {
  const Detalles({super.key});

  @override
  State<Detalles> createState() => _DetallesState();
}

class _DetallesState extends State<Detalles> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TittlePanel(padding: 5, textPanel: 'Datos generales del paciente'),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: isTablet(context) ? 3 : 1,
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ThreeLabelTextAline(
                        padding: 2.0,
                        firstText: 'Fecha Nacimiento',
                        secondText: Pacientes.Paciente['Pace_Nace'],
                      ),
                      ThreeLabelTextAline(
                        padding: 2.0,
                        firstText: 'Edad',
                        secondText: '${Pacientes.Paciente['Pace_Eda']} Años',
                      ),
                      ThreeLabelTextAline(
                        padding: 2.0,
                        firstText: 'Sexo',
                        secondText: Pacientes.Paciente['Pace_Ses'],
                      ),
                      ThreeLabelTextAline(
                        padding: 2.0,
                        firstText: 'Teléfono',
                        secondText: Pacientes.Paciente['Pace_Tele'],
                      ),
                      ThreeLabelTextAline(
                        padding: 2.0,
                        firstText: 'Modo Atención',
                        secondText: Pacientes.Paciente['Pace_Hosp'],
                      ),
                      ThreeLabelTextAline(
                        padding: 2.0,
                        firstText: 'Estado Civil',
                        secondText: Pacientes.Paciente['Pace_Edo_Civ'],
                      ),
                      ThreeLabelTextAline(
                        padding: 2.0,
                        firstText: 'Ocupación',
                        secondText: Pacientes.Paciente['Pace_Ocupa'],
                      ),
                      ThreeLabelTextAline(
                        padding: 2.0,
                        firstText: 'Religión',
                        secondText: Pacientes.Paciente['Pace_Reli'],
                      ),
                      ThreeLabelTextAline(
                        padding: 2.0,
                        firstText: 'C.U.R.P.',
                        secondText: Pacientes.Paciente['Pace_Curp'],
                      ),
                      ThreeLabelTextAline(
                        padding: 2.0,
                        firstText: 'R.F.C.',
                        secondText: Pacientes.Paciente['Pace_RFC'],
                      ),
                    ],
                  ),
                ),
              ),
              isTablet(context)
                  ? Expanded(
                      flex: isTablet(context) ? 1 : 0,
                      child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 100,
                          child: ClipOval(
                              child: Image.memory(
                            base64Decode(Pacientes.imagenPaciente!),
                            fit: BoxFit.cover,
                          ))),
                    )
                  : Container()
            ],
          )
        ]);
  }
}

class Hospitalizado extends StatefulWidget {
  const Hospitalizado({super.key});

  @override
  State<Hospitalizado> createState() => _HospitalizadoState();
}

class _HospitalizadoState extends State<Hospitalizado> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TittlePanel(
              padding: 5, textPanel: 'Datos de hospitalización del paciente'),
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: isTablet(context) ? 3 : 1,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ThreeLabelTextAline(
                          padding: 2.0,
                          firstText: 'Fecha de Ingreso Hospitalario',
                          secondText: Valores.fechaIngresoHospitalario,
                        ),
                        ThreeLabelTextAline(
                          padding: 2.0,
                          firstText: 'Cama Asignada',
                          secondText: Valores.numeroCama.toString(),
                        ),
                        ThreeLabelTextAline(
                          padding: 2.0,
                          firstText: 'Médico Tratante',
                          secondText: Valores.medicoTratante,
                        ),
                        ThreeLabelTextAline(
                          padding: 2.0,
                          firstText: 'Servicio Tratante',
                          secondText: Valores.servicioTratante,
                        ),
                        ThreeLabelTextAline(
                          padding: 2.0,
                          firstText: 'Servicio de Ingreso',
                          secondText: Valores.servicioTratanteInicial,
                        ),
                        const CrossLine(),
                        ThreeLabelTextAline(
                          padding: 2.0,
                          firstText: 'Cirugia programada',
                          secondText: '', // Valores.servicioTratanteInicial,
                        ),
                        ThreeLabelTextAline(
                          padding: 2.0,
                          firstText: 'Estancia Prolongada',
                          secondText: '', // Valores.servicioTratanteInicial,
                        ),
                        ThreeLabelTextAline(
                          padding: 2.0,
                          firstText: 'Interconsulta Pendiennte',
                          secondText: '', // Valores.servicioTratanteInicial,
                        ),
                      ],
                    ),
                  ),
                ),
                isTablet(context)
                    ? Expanded(
                        flex: isTablet(context) ? 1 : 0,
                        child: GridLayout(
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
                                      chyldrim:
                                          const SituacionesHospitalizacion(),
                                      onAction: () {
                                        setState(() {
                                          Situaciones.actualizarRegistro();
                                        });
                                      });
                                }),
                            GrandIcon(
                                iconData: Icons.restore_page_outlined,
                                labelButton:
                                    'Diagnósticos de la Hospitalización',
                                onPress: () {}),
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
                      )
                    : Container()
              ])
        ]);
  }
}

class DetallesVitales extends StatefulWidget {
  const DetallesVitales({super.key});

  @override
  State<DetallesVitales> createState() => _DetallesVitalesState();
}

class _DetallesVitalesState extends State<DetallesVitales> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TittlePanel(padding: 5, textPanel: 'Signos vitales del paciente'),
      SingleChildScrollView(
        controller: ScrollController(),
        child: isMobile(context) ? mobileView() : desktopView(),
      )
    ]);
  }

  Row desktopView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Fecha Nacimiento',
              secondText: Pacientes.Paciente['Pace_Nace'],
            ),
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Edad',
              secondText: '${Pacientes.Paciente['Pace_Eda']} Años',
            ),
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Sexo',
              secondText: Pacientes.Paciente['Pace_Ses'],
            ),
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Tensión arterial sistémica',
              secondText:
                  "${Valores.tensionArterialSystolica}/ ${Valores.tensionArterialDyastolica} mmHg",
            ),
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Frecuencia cardiaca',
              secondText: "${Valores.frecuenciaCardiaca} L/min",
            ),
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Frecuencia respiratoria',
              secondText: "${Valores.frecuenciaRespiratoria} Resp/min",
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Saturación periférica de oxígeno',
              secondText: "${Valores.saturacionPerifericaOxigeno} %",
            ),
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Peso corporal toral',
              secondText: '${Valores.pesoCorporalTotal} Kg',
            ),
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Estatura',
              secondText: '${Valores.alturaPaciente} mts',
            ),
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'I.M.C.',
              secondText: '${Valores.imc.toStringAsFixed(2)} Kg/m2',
            ),
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Glucemia capilar',
              secondText: '${Valores.glucemiaCapilar} mg/dL',
            ),
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Horas de ayuno',
              secondText: "${Valores.horasAyuno} Hrs",
            ),
          ],
        ),
      ],
    );
  }

  Row mobileView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        firstComponent(),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Tooltip(
              message: "Signos Vitales",
              child: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return Dialog(
                            backgroundColor: Colors.black,
                            child: secondComponent(),
                          );
                        }));
                  },
                  icon: const Icon(
                    Icons.view_agenda,
                    color: Colors.grey,
                  )),
            )
          ],
        )
      ],
    );
  }

  Column firstComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Fecha Nacimiento',
          secondText: Pacientes.Paciente['Pace_Nace'],
        ),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Edad',
          secondText: '${Pacientes.Paciente['Pace_Eda']} Años',
        ),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Sexo',
          secondText: Pacientes.Paciente['Pace_Ses'],
        ),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Tensión arterial sistémica',
          secondText:
              "${Valores.tensionArterialSystolica}/ ${Valores.tensionArterialDyastolica} mmHg",
        ),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Frecuencia cardiaca',
          secondText: "${Valores.frecuenciaCardiaca} L/min",
        ),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Frecuencia respiratoria',
          secondText: "${Valores.frecuenciaRespiratoria} Resp/min",
        ),
      ],
    );
  }

  Column secondComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TittlePanel(textPanel: "Signos Vitales"),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Saturación periférica de oxígeno',
          secondText: "${Valores.saturacionPerifericaOxigeno} %",
        ),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Peso corporal toral',
          secondText: '${Valores.pesoCorporalTotal} Kg',
        ),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Estatura',
          secondText: '${Valores.alturaPaciente} mts',
        ),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'I.M.C.',
          secondText: '${Valores.imc.toStringAsFixed(2)} Kg/m2',
        ),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Glucemia capilar',
          secondText: '${Valores.glucemiaCapilar} mg/dL',
        ),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Horas de ayuno',
          secondText: "${Valores.horasAyuno} Hrs",
        ),
      ],
    );
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
