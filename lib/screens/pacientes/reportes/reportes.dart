import 'package:assistant/conexiones/actividades/pdfGenerete/PdfApi.dart';
import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';

import 'package:assistant/screens/pacientes/auxiliares/presentaciones/presentaciones.dart';
import 'package:assistant/screens/pacientes/pacientes.dart';
import 'package:assistant/screens/pacientes/reportes/formatos/reporteConsulta.dart';
import 'package:assistant/screens/pacientes/reportes/formatos/reporteEvolucion.dart';
import 'package:assistant/screens/pacientes/reportes/formatos/reporteTerapia.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/auxiliaresReportes.dart';
import 'package:assistant/conexiones/actividades/pdfGenerete/pdfGenereteFormats/formatosReportes.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/ListValue.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';

class ReportesMedicos extends StatefulWidget {
  int actualPage = 0;

  ReportesMedicos({super.key});

  @override
  State<ReportesMedicos> createState() => _ReportesMedicosState();
}

class _ReportesMedicosState extends State<ReportesMedicos> {
  @override
  void initState() {
    // # # # ############## #### ######## #### ########
    // Llamado a los ultimos registros agregados.
    // # # # ############## #### ######## #### ########
    setState(() {
      Reportes.consultarRegistros();
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
              title: const Text(Sentences.app_bar_reportes),
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
    Reportes.close();
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
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colores.backgroundPanel,
                    borderRadius: BorderRadius.circular(20)),
                child: pantallasReportesMedicos(widget.actualPage),
              ),
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
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colores.backgroundPanel,
                    borderRadius: BorderRadius.circular(20)),
                child: pantallasReportesMedicos(widget.actualPage),
              ),
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
                      child: TittlePanel(
                          padding: isTablet(context) ? 4 : 2,
                          textPanel: "Tipo de Nota Médica")),
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
          const CrossLine(),
          TittlePanel(textPanel: "Tipo de Nota Médica"),
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView(
                  controller: ScrollController(),
                  children: tiposReportes(),
                ),
              )),
          const SizedBox(height: 20, child: CrossLine()),
          ListValue(
            title: "",
            onPress: () {},
          ),
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
              child: GrandButton(
                  weigth: 100,
                  labelButton: "Vista previa",
                  onPress: () async {
                    await imprimirDocumento();
                  }),
            ),
          ],
        ),
      ));
    } else {
      return Column(
        children: [
          SizedBox(
            height: 60,
            child: GrandButton(labelButton: "", onPress: () {}),
          ),
          const SizedBox(
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
          const SizedBox(
            height: 20,
            child: CrossLine(),
          ),
          GrandButton(
              labelButton: "Vista previa",
              onPress: () async {
                await imprimirDocumento();
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
        return TypeReportes.reporteTipado;
      case 4:
        return TypeReportes.indicacionesHospitalarias;
      case 5:
        return TypeReportes.reporteTipado;
      default:
        return TypeReportes.reporteIngreso;
    }
  }

  Widget pantallasReportesMedicos(int actualPage) {
    List<Widget> list = [
      Container(),
      const ReporteEvolucion(),
      const ReporteConsulta(),
      const ReporteTerapia(), // Reporte tipado
      Container(),
      Container(),
      Container(),
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
          setState(() {
            // showDialog(
            //     context: context,
            //     builder: ((context) => AlertDialog(
            //         title: const Text("Nota de Consulta"),
            //         content: Text("${widget.actualPage}"))));
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
    ];
  }

  List<Widget> actionsReportes() {
    return [
      GrandButton(
          labelButton: "Indicaciones Médicas",
          onPress: () {
            showDialog(
                useSafeArea: true,
                context: context,
                builder: (context) {
                  return const Dialog(
                    child: IndicacionesHospital(),
                  ); // IndicacionesConsulta(),);
                });
          }),
      GrandButton(labelButton: "Licencia médica", onPress: () {}),
      GrandButton(labelButton: "Licencia médica", onPress: () {}),
      GrandButton(labelButton: "Licencia médica", onPress: () {}),
      GrandButton(labelButton: "Licencia médica", onPress: () {}),
      GrandButton(labelButton: "Licencia médica", onPress: () {}),
      GrandButton(labelButton: "Licencia médica", onPress: () {}),
      GrandButton(labelButton: "Licencia médica", onPress: () {}),
    ];
  }
}
