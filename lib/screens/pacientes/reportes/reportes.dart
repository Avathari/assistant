import 'package:assistant/conexiones/actividades/pdfGenerete/PdfApi.dart';
import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';

import 'package:assistant/screens/pacientes/auxiliares/presentaciones/presentaciones.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/padecimientoActual.dart';
import 'package:assistant/screens/pacientes/intensiva/procedimientos/cateterTenckhoff.dart';
import 'package:assistant/screens/pacientes/intensiva/procedimientos/cateterVenosoCentral.dart';
import 'package:assistant/screens/pacientes/intensiva/procedimientos/intubacionEndotraqueal.dart';
import 'package:assistant/screens/pacientes/intensiva/procedimientos/sondaEndopleural.dart';
import 'package:assistant/screens/pacientes/intensiva/valoraciones/aereos.dart';
import 'package:assistant/screens/pacientes/intensiva/valoraciones/prequirurgicos.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/auxiliaresReportes.dart';
import 'package:assistant/conexiones/actividades/pdfGenerete/pdfGenereteFormats/formatosReportes.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/indicaciones.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/terapias.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/operadores/reporteConsulta.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/operadores/reporteEvolucion.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/operadores/reporteIngreso.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/operadores/reportePrequirurgico.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/operadores/reporteTerapia.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/operadores/reporteTransfusion.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/ListValue.dart';
import 'package:flutter/material.dart';

class ReportesMedicos extends StatefulWidget {
  int actualPage = 6;

  ReportesMedicos({super.key});

  @override
  State<ReportesMedicos> createState() => _ReportesMedicosState();
}

class _ReportesMedicosState extends State<ReportesMedicos> {

  @override
  void initState() {
    // Llamado a los ultimos registros agregados.
    setState(() {
      Reportes.consultarRegistros();
      Diagnosticos.consultarRegistro();
      Repositorios.consultarAnalisis();

      Terminal.printExpected(message: "Analisis Previos : : ${Reportes.analisisAnteriores}");
    });
    // # # # ############## #### ######## #### ########
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: //isMobile(context)
          AppBar(
              backgroundColor: Theming.primaryColor,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
                tooltip: Sentences.regresar,
                onPressed: () {
                  onClose(context);
                },
              ),
              title: Text(Sentences.app_bar_reportes, style: Styles.textSyleGrowth(),),
              actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.help,
              ),
              tooltip: Sentences.find_usuario,
              onPressed: () {
                //
              },
            ),
          ]), //: null,
      body:
          isMobile(context) || isTablet(context) ? mobileView() : desktopView(),
    );
  }

  void onClose(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => VisualPacientes(
              actualPage: 0,
            )));
  }

  Column mobileView() {
    return Column(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colores.backgroundPanel,
                borderRadius: BorderRadius.circular(20)),
            child: sideLeft(),
          ),
        )),
        Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: ContainerDecoration.roundedDecoration(),
              child: pantallasReportesMedicos(widget.actualPage),
            )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colores.backgroundPanel,
                borderRadius: BorderRadius.circular(20)),
            child: sideRight(),
          ),
        )),
      ],
    );
  }

  Row desktopView() {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          decoration: ContainerDecoration.containerDecoration(),
          child: sideLeft(),
        )),
        Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.all(8.0),
              decoration: ContainerDecoration.containerDecoration(),
              child: pantallasReportesMedicos(widget.actualPage),
            )),
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          decoration: ContainerDecoration.containerDecoration(),
          child: sideRight(),
        )),
      ],
    );
  }

  Widget sideLeft() {
    if (isMobile(context) || isTablet(context)) {
      return Expanded(
        child: Row(
          children: [
            isTablet(context)
                ? const Expanded(flex: 3, child: PresentacionPacientesSimple())
                : Container(),
            Expanded(
              flex: isTablet(context) ? 7 : 2,
              child: Column(
                children: [
                  Expanded(
                    child: GrandButton(
                        weigth: 2000,
                        labelButton: "Tipo de Nota Médica",
                        onPress: () {}),
                    //     child: Container(
                    //   decoration: ContainerDecoration.roundedDecoration(),
                    //   child: TittlePanel(
                    //       padding: isTablet(context) ? 4 : 2,
                    //       textPanel: "Tipo de Nota Médica"),
                    // ),
                  ),
                  Expanded(
                      flex: isTablet(context) ? 2 : 1,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        controller: ScrollController(),
                        child: Column(
                          children: tiposReportes(),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: [
          isMobile(context)
              ? const PresentacionPacientesSimple()
              : isTabletAndDesktop(context)
                  ? const PresentacionPacientesSimple()
                  : isDesktop(context)
                      ? const PresentacionPacientes()
                      : Container(),
          CrossLine(),
          GrandButton(
              weigth: 2000, labelButton: "Tipo de Nota Médica", onPress: () {}),
          CrossLine(),
          // TittlePanel(textPanel: "Tipo de Nota Médica"),
          Expanded(
              flex: 8,
              child: ListView(
                padding: const EdgeInsets.all(12.0),
                controller: ScrollController(),
                children: tiposReportes(),
              )),
          Expanded(child: CrossLine()),
          // ListValue(
          //   title: "",
          //   onPress: () {},
          // ),
        ],
      );
    }
  }

  Widget sideRight() {
    if (isMobile(context) || isTablet(context)) {
      return Expanded(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                  controller: ScrollController(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: actionsReportes(),
                  )),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: GrandButton(
                        weigth: 200,
                        labelButton: "Indicaciones Médicas",
                        onPress: () {
                          setState(() {
                            widget.actualPage = 9;
                          });
                        }),
                  ),
                  Expanded(
                    child: GrandButton(
                        weigth: 200,
                        labelButton: "Vista previa",
                        onPress: () async {
                          await imprimirDocumento();
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
    } else {
      return Column(
        children: [
          SizedBox(
            height: 80,
            child: GrandButton(
                labelButton: "Indicaciones Médicas",
                onPress: () {
                  setState(() {
                    widget.actualPage = 9;
                  });
                }),
          ),
           SizedBox(
            height: 20,
            child: CrossLine(),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: actionsReportes(),
                    ),
                  ),
                ),
              ),
            ),
          ),
           SizedBox(
            height: 20,
            child: CrossLine(),
          ),
          GrandButton(
              labelButton: "Vista previa",
              onPress: () async {
                await imprimirDocumento().then((value) => Operadores.alertActivity(context: context, onAcept: (){
                  Repositorios.registrarAnalisis();
                }));
              }),
        ],
      );
    }
  }

  Future<void> imprimirDocumento() async {
    Contextos.contexto = context;
    // final pdfFile = await PdfApi.generateCenterText("Prueba");
    final pdfFile = await PdfParagraphsApi.generate(
        withIndicationReport: false,
        indexOfTypeReport: getTypeReport(),
        paraph: Reportes.reportes,
        name: Reportes.nombreReporte(indefOfReport: widget.actualPage));
    final pdfFileTwo = await PdfParagraphsApi.generate(
        withIndicationReport: true,
        indexOfTypeReport: TypeReportes.indicacionesHospitalarias,
        paraph: Reportes.reportes,
        name:
            "(IH) - ${Pacientes.nombreCompleto} - (${Calendarios.today()}).pdf");

    // ignore: use_build_context_synchronously
    Operadores.listOptionsActivity(
        context: context,
        tittle: 'Seleccione un reporte . . . ',
        options: [
          ["Nota Médica", pdfFile.path, Calendarios.today()],
          ["Indicaciones Médicas", pdfFileTwo.path, Calendarios.today()],
        ],
        onClose: () {
          Navigator.of(context).pop();
        });
    // PdfApi.openFile(pdfFile);
    // PdfApi.openFile(pdfFileTwo);
  }

  TypeReportes getTypeReport() {
    switch (widget.actualPage) {
      case 0:
        return TypeReportes.reporteIngreso;
      case 1:
        return TypeReportes
            .reporteEvolucion; // return TypeReportes.reporteIngreso;
      case 2:
        return TypeReportes.reporteConsulta;
      case 3:
        return TypeReportes.reporteTerapiaIntensiva;
      case 4:
        return TypeReportes.reportePrequirurgica;
      case 5:
        return TypeReportes.reportePreanestesica;
      case 6:
        return TypeReportes.reporteEgreso;
      case 7:
        return TypeReportes.reporteRevision;
      case 8:
        return TypeReportes.reporteTraslado;
      case 9:
        return TypeReportes.reportePreanestesica;
      case 10:
        return TypeReportes.reportePreanestesica;
      case 11:
        return TypeReportes.reportePreanestesica;
      case 12:
        return TypeReportes.procedimientoCVC;
      case 13:
        return TypeReportes.procedimientoIntubacion;
      case 14:
        return TypeReportes.procedimientoSondaEndopleural;
      case 15:
        return TypeReportes.procedimientoTenckoff;
      case 16:
        return TypeReportes.procedimientoLumbar; // 16 : Punción Lumbar
      case 17:
        return TypeReportes.reporteTransfusion; // 17 : Transfusión
      default:
        return TypeReportes.reporteIngreso;
    }
  }

  Widget pantallasReportesMedicos(int actualPage) {
    List<Widget> list = [
      const ReporteIngreso(), // 0 : Reporte de
      const ReporteEvolucion(), // 1 : Reporte de
      const ReporteConsulta(), // 2 : Reporte de
      const ReporteTerapia(), // 3 : Reporte de Reporte tipado
      const ReportePrequirurgico(), // 4 : Reporte de
      Container(), // 5 : Reporte de Preanestésico
      Container(), // 6 : Reporte de Egreso
      Container(), // 7 : Reporte de Revisión
      Container(), // 8 : Reporte de Traslado
      Pacientes.esHospitalizado == true
          ? const IndicacionesHospital()
          : const IndicacionesConsulta(), // Container(),
      const Prequirurgicos(), // 10 :
      const Aereas(), // 11 :
      const CateterVenosoCentral(), // 12 :
      const IntubacionEndotraqueal(), // 13 :
      const SondaEndopleural(), // 14 :
      const CateterTenckhoff(), // 15 :
      Container(),  // 16 : Punción Lumbar
      const ReporteTransfusion(),  // 17 : Reporte de Transfusión
      const TerapiasItems(), // 18: Evaluación de Terapia
    ];

    return list[actualPage];
  }

  List<Widget> tiposReportes() {
    return [
      ListValue(
        title: "Nota de Ingreso Hospitalario",
        onPress: () {
          setState(() {
            widget.actualPage = 0;
          });
        },
      ),
      ListValue(
        title: "Nota de Evolución",
        onPress: () {
          setState(() {
            widget.actualPage = 1;
          });
        },
      ),
      ListValue(
        title: "Nota de Consulta",
        onPress: () {
          Licencias.consultarRegistro();
          setState(() {
            widget.actualPage = 2;
          });
        },
      ),
      ListValue(
        title: "Nota de Terapia Intensiva",
        onPress: () {
          setState(() {
            widget.actualPage = 3;
          });
        },
      ),
      ListValue(
        title: "Nota de Valoración Prequirúrgica",
        onPress: () {
          setState(() {
            widget.actualPage = 4;
          });
        },
      ),
      ListValue(
        title: "Nota de Valoración Preanestésica",
        onPress: () {
          setState(() {
            widget.actualPage = 5;
          });
        },
      ),
      ListValue(
        title: "Nota de Egreso",
        onPress: () {
          setState(() {
            widget.actualPage = 6;
          });
        },
      ),
      ListValue(
        title: "Nota de Revisión",
        onPress: () {
          setState(() {
            widget.actualPage = 7;
          });
        },
      ),
      ListValue(
        title: "Nota de Traslado",
        onPress: () {
          setState(() {
            widget.actualPage = 8;
          });
        },
      ),
      ListValue(
        title: "Nota de Transfusión",
        onPress: () {
          setState(() {
            widget.actualPage = 17;
          });
        },
      ),
    ];
  }

  List<Widget> actionsReportes() {
    return [
      GrandButton(
          weigth: 2000,
          labelButton: "Padecimiento Actual",
          onPress: () {
            Operadores.openDialog(
                context: context, chyldrim: const PadecimientoActual());
          }),
      GrandButton(
          weigth: 2000,
          labelButton: "Valoración Prequirúrgica",
          onPress: () {
            setState(() {
              widget.actualPage = 10;
            });
          }),
      GrandButton(
          weigth: 2000,
          labelButton: "Valoración de Terapia",
          onPress: () {
            setState(() {
              widget.actualPage = 18;
            });
          }),
      GrandButton(
          weigth: 2000,
          labelButton: "Valoración de la Vía Aerea",
          onPress: () {
            setState(() {
              widget.actualPage = 11;
            });
          }),
      GrandButton(
          weigth: 2000,
          labelButton: "Catéter Venoso Central",
          onPress: () {
            setState(() {
              widget.actualPage = 12;
            });
          }),
      GrandButton(
          weigth: 2000,
          labelButton: "Intubación Endotraqueal",
          onPress: () {
            setState(() {
              widget.actualPage = 13;
            });
          }),
      GrandButton(
          weigth: 2000,
          labelButton: "Sonda Endopleural",
          onPress: () {
            setState(() {
              widget.actualPage = 14;
            });
          }),
      GrandButton(
          weigth: 2000,
          labelButton: "Catéter Tenckhoff",
          onPress: () {
            setState(() {
              widget.actualPage = 15;
            });
          }),
      GrandButton(
          weigth: 2000,
          labelButton: "Punción Lumbar",
          onPress: () {
            setState(() {
              widget.actualPage = 16;
            });
          }),
      GrandButton(
          weigth: 2000,
          labelButton: "Licencia médica",
          onPress: () {
            // print("Pacientes.Licencias ${Pacientes.Licencias}\n ");
            // print("Reportes.licenciasMedicas ${Reportes.licenciasMedicas}");
            // Consultar última licencia médica.
            // setState(() {
            //   Reportes.licenciasMedicas.clear();
            //   Licencias.ultimoRegistro();
            //   Reportes.licenciasMedicas.add(Formatos.licenciaMedica);
            // });

            // Consultar todas las Incapacidades
            // for (var item in Pacientes.Licencias!) {
            //   print("item ${item.runtimeType} $item");
            //   Licencias.fromJson(item);
            //   Reportes.licenciasMedicas.add(Formatos.licenciaMedica);
            // }
            // ****************** *************************
            var opciones = Listas.listWithoutRepitedValues(
              Listas.listFromMapWithOneKey(Pacientes.Licencias!,
                  keySearched: "Fecha_Realizacion"),
            );
            opciones.add('Sin licencia médica otorgada.');
            // ****************** *************************
            Operadores.selectOptionsActivity(
              context: context,
              tittle: "Elija la fecha de la incapacidad a anexar . . . ",
              options: opciones,
              onClose: (value) {
                setState(() {
                  Reportes.licenciasMedicas.clear();
                  if (value == 'Sin licencia médica otorgada.') {
                    Reportes.licenciasMedicas.add(value);
                  } else {
                    for (var element in Pacientes.Licencias!) {
                      if (value == element['Fecha_Realizacion']) {
                        Licencias.fromJson(element);
                        Reportes.licenciasMedicas.add(Formatos.licenciaMedica);
                      }
                    }
                  }
                });
                // ****************** *************************
                Navigator.of(context).pop();
              },
            );
          }),
    ];
  }

}
