import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/actividades/pdfGenerete/pdfGenereteComponents/PdfApiComponents.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/hospitalarios/info/Hospitalizado.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class FormatosReportes {
  static TypeReportes? indexOfReport = TypeReportes.reporteIngreso;
  bool? withIndicationReport = false;

  FormatosReportes({
    required TypeReportes indexOfReport,
    this.withIndicationReport,
  }) {
    FormatosReportes.indexOfReport = indexOfReport;
  }

  List<Widget> typeOfList(Map<String, dynamic> paraph) {
    List<List<Widget>> list = [
      reporteIngreso(paraph), // 0 : Ingreso
      reporteEvolucion(paraph), // 1 : Evolución
      reporteConsulta(paraph), // 2 : Consulta
      reporteTerapia(paraph), // 3 : Terapia
      reportePrequirurgico(paraph),
      reportePreanestesico(paraph),
      reporteEgreso(paraph),
      reporteRevision(paraph),
      reporteTraslado(paraph),
      indicacionesHospitalVertical(paraph), // 9 : Indicaciones Hospitalarias
      reporteConsultaTipado(paraph), // 10 : Consulta Tipada
      //
      procedimientoCVC(paraph), // 11 : Catéter Venoso Central
      procedimientoIOT(paraph), // 12 : Intubación Endotraqueal
      procedimientoSOP(paraph), // 13 : Sonda Endopleural
      procedimientoTEN(paraph), // 14 : Catéter Temckhoff
      //
      reporteIngreso(paraph), // 15 : Ingreso
      reporteIngreso(paraph), // 16 : Ingreso
      reporteIngreso(paraph), // 17 : Ingreso
      reporteIngreso(paraph), // 18 : Ingreso
      reporteIngreso(paraph), // 19 : Ingreso
      reporteIngreso(paraph), // 20 : Ingreso
      // 20 : Censo Hospitalario
      reporteTransfusion(paraph), // 21 : Transfusion
    ];
    print("FormatosReportes.indexOfReport! ${FormatosReportes.indexOfReport!}");

    if (withIndicationReport!) {
      return list[
          9]; // Debe ser igual a indexOfTypeReport TypeReportes.indicacionesHospitalarias.
    } else {
      switch (FormatosReportes.indexOfReport) {
        case TypeReportes.reporteIngreso:
          return list[0];
        case TypeReportes.reporteEvolucion:
          return list[1];
        case TypeReportes.reporteConsulta:
          return list[2];
        case TypeReportes.reporteTerapiaIntensiva:
          return list[3];
        case TypeReportes.reportePrequirurgica:
          return list[4];
        case TypeReportes.reportePreanestesica:
          return list[5];
        case TypeReportes.reporteEgreso:
          return list[6];
        case TypeReportes.reporteRevision:
          return list[7];
        case TypeReportes.reporteTraslado:
          return list[8];
        case TypeReportes.indicacionesHospitalarias:
          return list[9];
        case TypeReportes.reporteTipado:
          return list[10];
        case TypeReportes.procedimientoCVC:
          return list[11];
        case TypeReportes.procedimientoIntubacion:
          return list[12];
        case TypeReportes.procedimientoSondaEndopleural:
          return list[13];
        case TypeReportes.procedimientoTenckoff:
          return list[14];
        case TypeReportes.censoHospitalario:
          return list[20];
        case TypeReportes.reporteTransfusion:
          return list[21];
        default:
          return list[1];
      }
    }
  }

  static List<Widget> reporteIngreso(Map<String, dynamic> paraph) {
    String tipoReporte = "NOTA DE INGRESO HOSPITALARIO";
    // # # # # # # ### # # # # # # ###
    // Lista de apartados del documento.
    // # # # # # # ### # # # # # # ###
    List<Widget> parax = [];
    // # # # # # # ### # # # # #  # ###
    // Datos de Identificación del Paciente.
    // # # # # # # ### # # # # # # ###
    parax.add(Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Nombre completo: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text("${Pacientes.nombreCompleto}",
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Número de afiliación: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(
            "${Pacientes.Paciente['Pace_NSS']} ${Pacientes.Paciente['Pace_AGRE']}",
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Fecha Actual: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(Calendarios.completeToday(),
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      SizedBox(height: 10),
    ]));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(Divider(color: PdfColors.black));
    parax.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(tipoReporte,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 9,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold)),
    ]));
    parax.add(Divider(color: PdfColors.black));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphWithTittle(
        titulo: "Ficha de Identificación",
        subTitulo: "${paraph['Datos_Generales']}"));
    // # # # # # # ### # # # # # # ###
    if (paraph['Antecedentes_Heredofamiliares'] != "") {
      parax.add(
        paragraphWithTittleAndSeparated(
          titulo: "Antecedentes Heredofamiliares",
          subTitulo: "${paraph['Antecedentes_Heredofamiliares']}",
        ),
      );
    }
    if (paraph['Antecedentes_No_Patologicos'] != "") {
      parax.add(
        paragraphWithTittleAndSeparated(
          titulo: "Antecedentes Personales No Patológicos",
          subTitulo: "${paraph['Antecedentes_No_Patologicos']}",
        ),
      );
    }
    if (paraph['Antecedentes_Patologicos_Ingreso'] != "") {
      parax.add(
        paragraphWithTittleAndSeparated(
          titulo: "Antecedentes Personales Patológicos",
          subTitulo: "${paraph['Antecedentes_Patologicos_Ingreso']}",
        ),
      );
    }

    // parax.add(paragraphFromList(listado: [
    //   [
    //     "Antecedentes heredofamiliares ",
    //     paraph['Antecedentes_Heredofamiliares']
    //   ],
    //   ["Antecedentes hospitalarios ", paraph['Antecedentes_Hospitalarios']],
    //   ["Antecedentes alergicos ", paraph['Antecedentes_Alergicos']],
    //   ["Antecedentes patológicos ", paraph['Antecedentes_Patologicos']],
    // ]));
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphWithTittle(
        titulo: "Padecimiento Actual",
        subTitulo: "${paraph['Padecimiento_Actual']}"));
    // # # # # # # ### # # # # # # ###
    parax.add(
      paragraph(
        isBefore: true,
        anteTexto: "A la exploración física con ",
        texto: "${paraph['Signos_Vitales']}\n",
        subTexto: "${paraph['Exploracion_Fisica']}",
      ),
    );
    if (paraph['Auxiliares_Diagnosticos'] != "") {
      parax.add(
        paragraphWithTittleAndSeparated(
          titulo: "Auxiliares diagnósticos",
          subTitulo: "${paraph['Auxiliares_Diagnosticos']}",
        ),
      );
    }

    // print("paraph['Analisis_Complementarios'] ${paraph['Analisis_Complementarios']}");
    if (paraph['Analisis_Complementarios'] != "") {
      parax.add(
        paragraphWithTittleAndSeparated(
          titulo: "Análisis complementarios",
          subTitulo: "${paraph['Analisis_Complementarios']}",
        ),
      );
    }

    parax.add(
      paragraphWithBullets(
        titulo: "Impresiones diagnósticas",
        subTitulo: "${paraph['Impresiones_Diagnosticas']}",
      ),
    );
    parax.add(paragraph(
      texto: "${paraph['Analisis_Medico']}",
    ));

    parax.add(paragraph(
      texto: "${paraph['Pronostico_Medico']}",
    ));

    // if (paraph['Pronostico_Medico'] != "") {
    //   parax.add(paragraphSeparatedBy(
    //     pax: "${paraph['Pronostico_Medico']}",
    //   ));
    // }
    parax.add(
      footerParagraph(
          text:
              "Med. Gral. Romero Pantoja Luis\nCed. Prof. 12210866\nMedicina General"),
    );
    return parax;
  }

  static List<Widget> reporteEvolucion(Map<String, dynamic> paraph) {
    String tipoReporte = "NOTA DE EVOLUCIÓN HOSPITALARIA";
    // # # # # # # ### # # # # # # ###
    // Lista de apartados del documento.
    // # # # # # # ### # # # # # # ###
    List<Widget> parax = [];
    // # # # # # # ### # # # # #  # ###
    // Datos de Identificación del Paciente.
    // # # # # # # ### # # # # # # ###
    parax.add(Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Nombre completo: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text("${Pacientes.nombreCompleto}",
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Número de afiliación: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(
            "${Pacientes.Paciente['Pace_NSS']} ${Pacientes.Paciente['Pace_AGRE']}",
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Fecha Actual: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(Calendarios.completeToday(),
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      SizedBox(height: 10),
    ]));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(Divider(color: PdfColors.black));
    parax.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(tipoReporte,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 9,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold)),
    ]));
    parax.add(Divider(color: PdfColors.black));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphWithTittle(
        titulo: "Datos generales", subTitulo: "${paraph['Datos_Generales']}"));
    parax.add(
      paragraphWithBullets(
        titulo: "", // "Impresiones diagnósticas",
        subTitulo: "${paraph['Impresiones_Diagnosticas']}",
      ),
    );
    // parax.add(paragraph(texto: paraph['Subjetivo'], withJumpSpace: false)); // # # # # # # ### # # # # # # ###
    parax.add(
      paragraph(
        isBefore: true,
        anteTexto: "${paraph['Subjetivo']}\n",
        texto: "A la exploración física con  ${paraph['Signos_Vitales']}\n",
        subTexto: "${paraph['Exploracion_Fisica']}",
      ),
    );
    if (paraph['Auxiliares_Diagnosticos'] != "") {
      parax.add(
        paragraphAllBold(
          texto: "${paraph['Auxiliares_Diagnosticos']}",
        ),
      );
    }
    // if (paraph['Auxiliares_Diagnosticos'] != "") {
    //   parax.add(
    //     paragraphWithTittleAndSeparated(
    //       titulo: "Auxiliares diagnósticos",
    //       subTitulo: "${paraph['Auxiliares_Diagnosticos']}",
    //     ),
    //   );
    // }

    if (paraph['Analisis_Complementarios'] != "") {
      parax.add(
        paragraphWithBullets(
          titulo: "Análisis complementarios",
          subTitulo: "${paraph['Analisis_Complementarios']}",
        ),
      );
    }
    // parax.add(
    //   paragraphWithBullets(
    //     titulo: "Impresiones diagnósticas",
    //     subTitulo: "${paraph['Impresiones_Diagnosticas']}",
    //   ),
    // );
    parax.add(paragraph(
      texto: "${paraph['Analisis_Medico']}",
    ));
    //
    parax.add(paragraph(
      texto: "${paraph['Pronostico_Medico']}",
    ));
    // if (paraph['Pronostico_Medico'] != "") {
    //   parax.add(paragraphSeparatedBy(
    //     pax: "${paraph['Pronostico_Medico']}",
    //   ));
    // }
    parax.add(
      footerParagraph(
          text:
              "Med. Gral. Romero Pantoja Luis\nCed. Prof. 12210866\nMedicina General"),
    );
    return parax;
  }

  static List<Widget> reporteConsulta(Map<String, dynamic> paraph) {
    String tipoReporte = "NOTA DE CONSULTA EXTERNA";
    // # # # # # # ### # # # # # # ###
    // Lista de apartados del documento.
    // # # # # # # ### # # # # # # ###
    List<Widget> parax = [];
    // # # # # # # ### # # # # #  # ###
    // Datos de Identificación del Paciente.
    // # # # # # # ### # # # # # # ###
    parax.add(Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Nombre completo: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text("${Pacientes.nombreCompleto}",
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Número de afiliación: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(
            "${Pacientes.Paciente['Pace_NSS']} ${Pacientes.Paciente['Pace_AGRE']}",
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Fecha Actual: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(Calendarios.completeToday(),
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      SizedBox(height: 10),
    ]));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(Divider(color: PdfColors.black));
    parax.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(tipoReporte,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 9,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold)),
    ]));
    parax.add(Divider(color: PdfColors.black));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphWithTittle(
        titulo: "Datos generales", subTitulo: "${paraph['Datos_Generales']}"));
    // # # # # # # ### # # # # # # ###
    parax.add(paragraph(
      isBefore: true,
      anteTexto: "Motivo de consulta por ",
      texto: "${paraph['Motivo_Consulta']}",
    ));
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphFromList(listado: [
      [
        "Antecedentes heredofamiliares ",
        paraph['Antecedentes_Heredofamiliares']
      ],
      ["Antecedentes hospitalarios ", paraph['Antecedentes_Hospitalarios']],
      ["Antecedentes alergicos ", paraph['Antecedentes_Alergicos']],
      ["Antecedentes patológicos ", paraph['Antecedentes_Patologicos']],
    ]));
    // # # # # # # ### # # # # # # ###
    parax.add(
      paragraph(
        isBefore: true,
        anteTexto: "A la exploración física con ",
        texto: "${paraph['Signos_Vitales']}\n",
        subTexto: "${paraph['Exploracion_Fisica']}",
      ),
    );
    if (paraph['Auxiliares_Diagnosticos'] != "") {
      parax.add(
        paragraphWithTittleAndSeparated(
          titulo: "Auxiliares diagnósticos",
          subTitulo: "${paraph['Auxiliares_Diagnosticos']}",
        ),
      );
    }

    if (paraph['Analisis_Complementarios'] != "") {
      parax.add(
        paragraphWithBullets(
          titulo: "Análisis complementarios",
          subTitulo: "${paraph['Analisis_Complementarios']}",
        ),
      );
    }
    parax.add(
      paragraphWithBullets(
        titulo: "Impresiones diagnósticas",
        subTitulo: "${paraph['Impresiones_Diagnosticas']}",
      ),
    );
    parax.add(paragraph(
      texto: "${paraph['Analisis_Medico']}",
    ));
    // parax.add(buildListado(
    //   'Indicaciones médicas',
    //   [
    //     'Medicamentos',
    //     'Licencia médica',
    //     'Pendientes',
    //     'Citas',
    //     'Recomendaciones',
    //   ],
    //   [
    //     paraph['Medicamentos'],
    //     paraph['Licencia_Medica'],
    //     paraph['Pendientes'],
    //     paraph['Citas'],
    //     paraph['Recomendaciones'],
    //   ],
    // ));

    //
    parax.add(paragraph(
      texto: "${paraph['Pronostico_Medico']}",
    ));

    // if (paraph['Pronostico_Medico'] != "") {
    //   parax.add(paragraphSeparatedBy(
    //     pax: "${paraph['Pronostico_Medico']}",
    //   ));
    // }
    parax.add(
      footerParagraph(
          text:
              "Med. Gral. Romero Pantoja Luis\nCed. Prof. 12210866\nMedicina General"),
    );
    return parax;
  }

  static List<Widget> reporteConsultaTipado(Map<String, dynamic> paraph) {
    String tipoReporte = "NOTA DE CONSULTA - REPORTE TIPADO";
    // # # # # # # ### # # # # # # ###
    // Lista de apartados del documento.
    // # # # # # # ### # # # # # # ###
    List<Widget> parax = [];
    // # # # # # # ### # # # # #  # ###
    // Datos de Identificación del Paciente.
    // # # # # # # ### # # # # # # ###
    parax.add(Divider(color: PdfColors.black));
    parax.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(tipoReporte,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 9,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold)),
    ]));
    parax.add(Divider(color: PdfColors.black));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(
      SizedBox(height: 4),
    );
    parax.add(Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: const TableBorder(
          horizontalInside: BorderSide(width: 0.7),
          left: BorderSide(width: 0.7),
          right: BorderSide(width: 0.7),
          top: BorderSide(width: 0.7),
          bottom: BorderSide(width: 0.7),
        ), //width: 0.7),
        children: [
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                Padding(padding: const EdgeInsets.all(4.0), child: Container())
              ]),
          TableRow(
              // decoration: BoxDecoration(padding: EdgeInsets.all(4.0)),
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittle("Unidad Médica: "),
                textTittle("Servicio Médico: "),
                textTittle("Numero y Nombre del Empleado: "),
                textTittle("Consultorio: "),
                textTittle("Turno de Atención: "),
                textTittle("Fecha: "),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textLabel("CAF Bacalar"),
                textLabel("Consulta Externa"),
                textLabel("00408206 Med. Gral. Romero Pantoja Luis"),
                textLabel("CG-01"),
                textLabel("Vespertino"),
                textLabel(Calendarios.completeToday()),
              ]),
          TableRow(
              // decoration: BoxDecoration(padding: EdgeInsets.all(4.0)),
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittle(" "),
                textTittle(" "),
                textTittleWithLabel(
                    tittle: "Nombre Completo: ",
                    label: '${Pacientes.nombreCompleto}'),
                textTittleWithLabel(
                    tittle: "Teléfono: ", label: Valores.telefono),
                textTittleWithLabel(
                    tittle: "Edad: ", label: '${Valores.edad} Años'),
                textTittle(" "),
              ]),
          TableRow(
              // decoration: BoxDecoration(padding: EdgeInsets.all(4.0)),
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittle(" "),
                textTittle(" "),
                textTittleWithLabel(
                    tittle: "No. Afiliación: ",
                    label: Valores.numeroExpediente),
                textTittleWithLabel(
                    tittle: "Fecha Nacimiento: ",
                    label: Valores.fechaNacimiento),
                textTittleWithLabel(tittle: "C.U.R.P.: ", label: Valores.curp),
                textTittle(" "),
              ]),
        ]));
    // # # # # # # ### # # # # # # ###
    parax.add(
      SizedBox(height: 12),
    );
    // # # # # # # ### # # # # # # ###
    parax.add(Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: const TableBorder(
          horizontalInside: BorderSide(width: 0.7),
          left: BorderSide(width: 0.7),
          right: BorderSide(width: 0.7),
          top: BorderSide(width: 0.7),
          bottom: BorderSide(width: 0.7),
        ),
        children: [
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "T. Arterial: ",
                    label: '${Valores.tensionArterialSistemica} mmHg'),
                textTittleWithLabel(
                    tittle: "F. Cardiaca: ",
                    label: '${Valores.frecuenciaCardiaca} Lat/min'),
                textTittleWithLabel(
                    tittle: "F. Respiratoria: ",
                    label: '${Valores.frecuenciaRespiratoria} Resp/min'),
                textTittleWithLabel(
                    tittle: "T. Corporal: ",
                    label: '${Valores.temperaturCorporal} °C'),
                textTittleWithLabel(
                    tittle: "SpO2: ",
                    label: '${Valores.saturacionPerifericaOxigeno} %'),
                textTittleWithLabel(
                    tittle: "P.C.T.: ",
                    label: '${Valores.pesoCorporalTotal} Kg'),
                textTittleWithLabel(
                    tittle: "Estatura (mts): ",
                    label: '${Valores.alturaPaciente} Kg'),
              ]),
          TableRow(
              decoration: const BoxDecoration(),
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "Glucemia Capilar: ",
                    label: '${Valores.glucemiaCapilar} mg/dL'),
                textTittleWithLabel(tittle: "Observaciones: ", label: ''),
                textTittleWithLabel(tittle: " ", label: ''),
                textTittleWithLabel(tittle: " ", label: ''),
                textTittleWithLabel(tittle: " ", label: ''),
                textTittleWithLabel(tittle: " ", label: ''),
                textTittleWithLabel(
                    tittle: "I.M.C.: ",
                    label: '${Antropometrias.imc.toStringAsFixed(2)} Kg/m2'),
              ]),
        ]));
    // # # # # # # ### # # # # # # ###
    parax.add(
      SizedBox(height: 12),
    );
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphWithTittle(
        titulo: "Datos generales", subTitulo: "${paraph['Datos_Generales']}"));
    // # # # # # # ### # # # # # # ###
    parax.add(paragraph(
      isBefore: true,
      anteTexto: "Motivo de consulta por ",
      texto: "${paraph['Motivo_Consulta']}",
    ));
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphFromList(listado: [
      [
        "Antecedentes heredofamiliares ",
        paraph['Antecedentes_Heredofamiliares']
      ],
      ["Antecedentes hospitalarios ", paraph['Antecedentes_Hospitalarios']],
      ["Antecedentes alergicos ", paraph['Antecedentes_Alergicos']],
      ["Antecedentes patológicos ", paraph['Antecedentes_Patologicos']],
    ]));
    // # # # # # # ### # # # # # # ###
    parax.add(
      paragraph(
        isBefore: true,
        anteTexto: "A la exploración física con ",
        texto: "${paraph['Signos_Vitales']}\n",
        subTexto: "${paraph['Exploracion_Fisica']}",
      ),
    );

    if (paraph['Auxiliares_Diagnosticos'] != "") {
      parax.add(
        paragraphWithTittleAndSeparated(
          titulo: "Auxiliares diagnósticos",
          subTitulo: "${paraph['Auxiliares_Diagnosticos']}",
        ),
      );
    }

    if (paraph['Analisis_Complementarios'] != "") {
      parax.add(
        paragraphWithBullets(
          titulo: "Análisis complementarios",
          subTitulo: "${paraph['Analisis_Complementarios']}",
        ),
      );
    }

    parax.add(
      paragraphWithBullets(
        titulo: "Impresiones diagnósticas",
        subTitulo: "${paraph['Impresiones_Diagnosticas']}",
      ),
    );

    parax.add(buildListado(
      'Indicaciones médicas',
      [
        'Medicamentos',
        'Licencia médica',
        'Pendientes',
        'Citas',
        'Recomendaciones',
      ],
      [
        paraph['Medicamentos'],
        paraph['Licencia_Medica'] ?? [""],
        paraph['Pendientes'],
        paraph['Citas'] ?? [""],
        paraph['Recomendaciones'] ?? [""],
      ],
    ));

    parax.add(paragraph(
      texto: "${paraph['Analisis_Medico']}",
    ));
    //
    parax.add(paragraph(
      texto: "${paraph['Pronostico_Medico']}",
    ));
    // if (paraph['Pronostico_Medico'] != "") {
    //   parax.add(paragraphSeparatedBy(
    //     pax: "${paraph['Pronostico_Medico']}",
    //   ));
    // }
    parax.add(
      footerParagraph(
          text:
              "Med. Gral. Romero Pantoja Luis\nCed. Prof. 12210866\nMedicina General"),
    );
    // # # # # # # ### # # # # # # ###
    return parax;
  }

  static List<Widget> reporteConsultaTipadoSin(Map<String, dynamic> paraph) {
    String tipoReporte = "NOTA DE CONSULTA - REPORTE TIPADO";
    // # # # # # # ### # # # # # # ###
    // Lista de apartados del documento.
    // # # # # # # ### # # # # # # ###
    List<Widget> parax = [];
    // # # # # # # ### # # # # #  # ###
    // Datos de Identificación del Paciente.
    // # # # # # # ### # # # # # # ###
    parax.add(Divider(color: PdfColors.black));
    parax.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(tipoReporte,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 9,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold)),
    ]));
    parax.add(Divider(color: PdfColors.black));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(
      SizedBox(height: 4),
    );
    parax.add(Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: const TableBorder(
          horizontalInside: BorderSide(width: 0.7),
          left: BorderSide(width: 0.7),
          right: BorderSide(width: 0.7),
          top: BorderSide(width: 0.7),
          bottom: BorderSide(width: 0.7),
        ), //width: 0.7),
        children: [
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                Padding(padding: const EdgeInsets.all(4.0), child: Container())
              ]),
          TableRow(
              // decoration: BoxDecoration(padding: EdgeInsets.all(4.0)),
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittle("Unidad Médica: "),
                textTittle("Servicio Médico: "),
                textTittle("Numero y Nombre del Empleado: "),
                textTittle("Consultorio: "),
                textTittle("Turno de Atención: "),
                textTittle("Fecha: "),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textLabel("CAF Bacalar"),
                textLabel("Consulta Externa"),
                textLabel("00408206 Med. Gral. Romero Pantoja Luis"),
                textLabel("CG-01"),
                textLabel("Vespertino"),
                textLabel(Calendarios.completeToday()),
              ]),
          TableRow(
              // decoration: BoxDecoration(padding: EdgeInsets.all(4.0)),
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittle(" "),
                textTittle(" "),
                textTittleWithLabel(
                    tittle: "Nombre Completo: ",
                    label: '${Pacientes.nombreCompleto}'),
                textTittleWithLabel(
                    tittle: "Teléfono: ", label: Valores.telefono),
                textTittleWithLabel(
                    tittle: "Edad: ", label: '${Valores.edad} Años'),
                textTittle(" "),
              ]),
          TableRow(
              // decoration: BoxDecoration(padding: EdgeInsets.all(4.0)),
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittle(" "),
                textTittle(" "),
                textTittleWithLabel(
                    tittle: "No. Afiliación: ",
                    label: Valores.numeroExpediente),
                textTittleWithLabel(
                    tittle: "Fecha Nacimiento: ",
                    label: Valores.fechaNacimiento),
                textTittleWithLabel(tittle: "C.U.R.P.: ", label: Valores.curp),
                textTittle(" "),
              ]),
        ]));
    // # # # # # # ### # # # # # # ###
    parax.add(
      SizedBox(height: 12),
    );
    // # # # # # # ### # # # # # # ###
    parax.add(Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: const TableBorder(
          horizontalInside: BorderSide(width: 0.7),
          left: BorderSide(width: 0.7),
          right: BorderSide(width: 0.7),
          top: BorderSide(width: 0.7),
          bottom: BorderSide(width: 0.7),
        ),
        children: [
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "T. Arterial: ",
                    label: '${Valores.tensionArterialSistemica} mmHg'),
                textTittleWithLabel(
                    tittle: "F. Cardiaca: ",
                    label: '${Valores.frecuenciaCardiaca} Lat/min'),
                textTittleWithLabel(
                    tittle: "F. Respiratoria: ",
                    label: '${Valores.frecuenciaRespiratoria} Resp/min'),
                textTittleWithLabel(
                    tittle: "T. Corporal: ",
                    label: '${Valores.temperaturCorporal} °C'),
                textTittleWithLabel(
                    tittle: "SpO2: ",
                    label: '${Valores.saturacionPerifericaOxigeno} %'),
                textTittleWithLabel(
                    tittle: "P.C.T.: ",
                    label: '${Valores.pesoCorporalTotal} Kg'),
                textTittleWithLabel(
                    tittle: "Estatura (mts): ",
                    label: '${Valores.alturaPaciente} Kg'),
              ]),
          TableRow(
              decoration: const BoxDecoration(),
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "Glucemia Capilar: ",
                    label: '${Valores.glucemiaCapilar} mg/dL'),
                textTittleWithLabel(tittle: "Observaciones: ", label: ''),
                textTittleWithLabel(tittle: " ", label: ''),
                textTittleWithLabel(tittle: " ", label: ''),
                textTittleWithLabel(tittle: " ", label: ''),
                textTittleWithLabel(tittle: " ", label: ''),
                textTittleWithLabel(
                    tittle: "I.M.C.: ",
                    label: '${Antropometrias.imc.toStringAsFixed(2)} Kg/m2'),
              ]),
        ]));
    // # # # # # # ### # # # # # # ###
    parax.add(
      SizedBox(height: 12),
    );
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(
      Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.full,
          border: const TableBorder(
            horizontalInside: BorderSide.none,
            left: BorderSide(width: 0.7),
            right: BorderSide(width: 0.7),
            top: BorderSide(width: 0.7),
            bottom: BorderSide(width: 0.7),
          ),
          children: [
            TableRow(
                verticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: paragraphWithTittle(
                        titulo: "Datos generales",
                        subTitulo: "${paraph['Datos_Generales']}"),
                  ),
                ]),
            TableRow(
                verticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: paragraph(
                      isBefore: true,
                      anteTexto: "Motivo de consulta por ",
                      texto: "${paraph['Motivo_Consulta']}",
                    ),
                  ),
                ]),
            TableRow(
                verticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: paragraphFromList(listado: [
                      [
                        "Antecedentes heredofamiliares ",
                        paraph['Antecedentes_Heredofamiliares']
                      ],
                      [
                        "Antecedentes hospitalarios ",
                        paraph['Antecedentes_Hospitalarios']
                      ],
                      [
                        "Antecedentes alergicos ",
                        paraph['Antecedentes_Alergicos']
                      ],
                      [
                        "Antecedentes patológicos ",
                        paraph['Antecedentes_Patologicos']
                      ],
                    ]),
                  ),
                ]),
            TableRow(
                verticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: paragraph(
                      isBefore: true,
                      anteTexto: "A la exploración física ",
                      texto: "${paraph['Exploracion_Fisica']}",
                      subTexto: "",
                    ),
                  ),
                ]),
            TableRow(
                verticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  paraph['Auxiliares_Diagnosticos'] != ""
                      ? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: paragraphWithTittleAndSeparated(
                            titulo: "Auxiliares diagnósticos",
                            subTitulo: "${paraph['Auxiliares_Diagnosticos']}",
                          ),
                        )
                      : Container(),
                ]),
            TableRow(
                verticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  paraph['Analisis_Complementarios'] != ""
                      ? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: paragraphWithBullets(
                            titulo: "Análisis complementarios",
                            subTitulo: "${paraph['Analisis_Complementarios']}",
                          ),
                        )
                      : Container(),
                ]),
            TableRow(
                verticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: paragraphWithBullets(
                      titulo: "Impresiones diagnósticas",
                      subTitulo: "${paraph['Impresiones_Diagnosticas']}",
                    ),
                  ),
                ]),
            TableRow(
                verticalAlignment: TableCellVerticalAlignment.middle,
                decoration: const BoxDecoration(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: paragraph(
                      texto: "${paraph['Analisis_Medico']}",
                    ),
                  ),
                ]),
            // TableRow(
            //     //verticalAlignment: TableCellVerticalAlignment.middle,
            //     children: [
            //       Padding(
            //           padding: const EdgeInsets.all(4.0),
            //           child: buildListado(
            //             'Indicaciones médicas',
            //             [
            //               'Medicamentos',
            //               'Licencia médica',
            //               'Pendientes',
            //               'Citas',
            //               'Recomendaciones',
            //             ],
            //             [
            //               paraph['Medicamentos'],
            //               paraph['Licencia_Medica'],
            //               paraph['Pendientes'],
            //               paraph['Citas'],
            //               paraph['Recomendaciones'],
            //             ],
            //           )),
            //     ]),
            TableRow(
                verticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  paraph['Pronostico_Medico'] != ""
                      ? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: paragraphSeparatedBy(
                            pax: "${paraph['Pronostico_Medico']}",
                          ))
                      : Container(),
                ]),
            TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: footerParagraph(
                      text:
                          "Med. Gral. Romero Pantoja Luis\nCed. Prof. 12210866\nMedicina General"),
                ),
              ],
            ),
          ]),
    );
    // # # # # # # ### # # # # # # ###
    return parax;
  }

  static List<Widget> reporteTraslado(Map<String, dynamic> paraph) {
    String tipoReporte = "NOTA DE TRASLADO";
    // # # # # # # ### # # # # # # ###
    // Lista de apartados del documento.
    // # # # # # # ### # # # # # # ###
    List<Widget> parax = [];
    // # # # # # # ### # # # # #  # ###
    // Datos de Identificación del Paciente.
    // # # # # # # ### # # # # # # ###
    parax.add(Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Nombre completo: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text("${Pacientes.nombreCompleto}",
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Número de afiliación: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(
            "${Pacientes.Paciente['Pace_NSS']} ${Pacientes.Paciente['Pace_AGRE']}",
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Fecha Actual: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(Calendarios.completeToday(),
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      SizedBox(height: 10),
    ]));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(Divider(color: PdfColors.black));
    parax.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(tipoReporte,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 9,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold)),
    ]));
    parax.add(Divider(color: PdfColors.black));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphWithTittle(
        titulo: "Datos generales", subTitulo: "${paraph['Datos_Generales']}"));
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphFromList(listado: [
      [
        "Antecedentes heredofamiliares ",
        paraph['Antecedentes_Heredofamiliares']
      ],
      ["Antecedentes hospitalarios ", paraph['Antecedentes_Hospitalarios']],
      ["Antecedentes alergicos ", paraph['Antecedentes_Alergicos']],
      ["Antecedentes patológicos ", paraph['Antecedentes_Patologicos']],
    ]));
    // # # # # # # ### # # # # # # ###
    parax.add(
      paragraph(
        isBefore: true,
        anteTexto: "A la exploración física con ",
        texto: "${paraph['Signos_Vitales']}\n",
        subTexto: "${paraph['Exploracion_Fisica']}",
      ),
    );
    if (paraph['Auxiliares_Diagnosticos'] != "") {
      parax.add(
        paragraphWithTittleAndSeparated(
          titulo: "Auxiliares diagnósticos",
          subTitulo: "${paraph['Auxiliares_Diagnosticos']}",
        ),
      );
    }

    if (paraph['Analisis_Complementarios'] != "") {
      parax.add(
        paragraphWithBullets(
          titulo: "Análisis complementarios",
          subTitulo: "${paraph['Analisis_Complementarios']}",
        ),
      );
    }
    parax.add(
      paragraphWithBullets(
        titulo: "Impresiones diagnósticas",
        subTitulo: "${paraph['Impresiones_Diagnosticas']}",
      ),
    );
    parax.add(paragraph(
      texto: "${paraph['Analisis_Medico']}",
    ));
    parax.add(paragraph(
      texto: "${paraph['Pronostico_Medico']}",
    ));
    // if (paraph['Pronostico_Medico'] != "") {
    //   parax.add(paragraphSeparatedBy(
    //     pax: "${paraph['Pronostico_Medico']}",
    //   ));
    // }
    parax.add(
      footerParagraph(
          text:
              "Med. Gral. Romero Pantoja Luis\nCed. Prof. 12210866\nMedicina General"),
    );
    return parax;
  }

  static List<Widget> reportePrequirurgico(Map<String, dynamic> paraph) {
    String tipoReporte = "VALORACION PREQUIRURGICA\nMEDICINA INTERNA";
    // # # # # # # ### # # # # # # ###
    // Lista de apartados del documento.
    // # # # # # # ### # # # # # # ###
    List<Widget> parax = [];
    // # # # # # # ### # # # # #  # ###
    // Datos de Identificación del Paciente.
    // # # # # # # ### # # # # # # ###
    parax.add(Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Nombre completo: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text("${Pacientes.nombreCompleto}",
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Número de afiliación: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(
            "${Pacientes.Paciente['Pace_NSS']} ${Pacientes.Paciente['Pace_AGRE']}",
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 8)),
      ]),
      // Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      //   Text("Fecha Actual: ",
      //       textAlign: TextAlign.right,
      //       style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
      //   Text(Calendarios.completeToday(),
      //       textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      // ]),
      SizedBox(height: 5),
    ]));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(Divider(color: PdfColors.black));
    parax.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(tipoReporte,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 9,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold)),
    ]));
    parax.add(Divider(color: PdfColors.black));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    if (paraph['Motivo_Prequirurgico'] != "") {
      parax.add(
        paragraphWithTittleAndSeparated(
          titulo: "Fecha: ${Calendarios.today(format: "dd/MM/yyyy")}",
          subTitulo: "${paraph['Motivo_Prequirurgico']}",
        ),
      );
    }
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphWithTittle(
        titulo: "Datos generales", subTitulo: "${paraph['Datos_Generales']}"));
    // # # # # # # ### # # # # # # ###
    if (paraph['Antecedetes_No_Patologicos_Analisis'] != "") {
      parax.add(
        paragraphWithTittleAndSeparated(
          titulo: "Antecedentes Personales Patológicos",
          subTitulo: "${paraph['Antecedetes_No_Patologicos_Analisis']}",
        ),
      );
    }
    // # # # # # # ### # # # # # # ###
    parax.add(
      paragraph(
        isBefore: true,
        anteTexto: "A la exploración física con ",
        texto: "${paraph['Signos_Vitales']}\n",
        subTexto: "${paraph['Exploracion_Fisica']}",
      ),
    );
    if (paraph['Auxiliares_Diagnosticos'] != "") {
      parax.add(
        paragraphWithTittleAndSeparated(
          titulo: "Auxiliares diagnósticos",
          subTitulo: "${paraph['Auxiliares_Diagnosticos']}",
        ),
      );
    }

    if (paraph['Analisis_Complementarios'] != "") {
      parax.add(
        paragraphWithTittleAndSeparated(
          titulo: "Escalas de Riesgo",
          subTitulo: "${paraph['Analisis_Complementarios']}",
        ),
      );
    }

    // parax.add(
    //   paragraphWithBullets(
    //     titulo: "Impresiones diagnósticas",
    //     subTitulo: "${paraph['Impresiones_Diagnosticas']}",
    //   ),
    // );
    parax.add(paragraphWithTittle(
      titulo: "Recomendaciones Generales",
      subTitulo: "${paraph['Recomendaciones_Generales']}",
    ));
    // if (paraph['Pronostico_Medico'] != "") {
    //   parax.add(paragraphSeparatedBy(
    //     pax: "${paraph['Pronostico_Medico']}",
    //   ));
    // }
    parax.add(
      footerParagraph(
          text:
              "Med. Gral. Romero Pantoja Luis\nCed. Prof. 12210866\nMedicina General"),
    );
    return parax;
  }

  static List<Widget> reportePreanestesico(Map<String, dynamic> paraph) {
    String tipoReporte = "VALORACION PREANESTESICA";
    // # # # # # # ### # # # # # # ###
    // Lista de apartados del documento.
    // # # # # # # ### # # # # # # ###
    List<Widget> parax = [];
    // # # # # # # ### # # # # #  # ###
    // Datos de Identificación del Paciente.
    // # # # # # # ### # # # # # # ###
    parax.add(Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Nombre completo: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text("${Pacientes.nombreCompleto}",
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Número de afiliación: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(
            "${Pacientes.Paciente['Pace_NSS']} ${Pacientes.Paciente['Pace_AGRE']}",
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Fecha Actual: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(Calendarios.completeToday(),
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      SizedBox(height: 10),
    ]));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(Divider(color: PdfColors.black));
    parax.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(tipoReporte,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 9,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold)),
    ]));
    parax.add(Divider(color: PdfColors.black));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphWithTittle(
        titulo: "Datos generales", subTitulo: "${paraph['Datos_Generales']}"));
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphFromList(listado: [
      [
        "Antecedentes heredofamiliares ",
        paraph['Antecedentes_Heredofamiliares']
      ],
      ["Antecedentes hospitalarios ", paraph['Antecedentes_Hospitalarios']],
      ["Antecedentes alergicos ", paraph['Antecedentes_Alergicos']],
      ["Antecedentes patológicos ", paraph['Antecedentes_Patologicos']],
    ]));
    // # # # # # # ### # # # # # # ###
    parax.add(
      paragraph(
        isBefore: true,
        anteTexto: "A la exploración física con ",
        texto: "${paraph['Signos_Vitales']}\n",
        subTexto: "${paraph['Exploracion_Fisica']}",
      ),
    );
    if (paraph['Auxiliares_Diagnosticos'] != "") {
      parax.add(
        paragraphWithTittleAndSeparated(
          titulo: "Auxiliares diagnósticos",
          subTitulo: "${paraph['Auxiliares_Diagnosticos']}",
        ),
      );
    }

    if (paraph['Analisis_Complementarios'] != "") {
      parax.add(
        paragraphWithBullets(
          titulo: "Análisis complementarios",
          subTitulo: "${paraph['Analisis_Complementarios']}",
        ),
      );
    }
    parax.add(
      paragraphWithBullets(
        titulo: "Impresiones diagnósticas",
        subTitulo: "${paraph['Impresiones_Diagnosticas']}",
      ),
    );
    parax.add(paragraph(
      texto: "${paraph['Analisis_Medico']}",
    ));
    //
    parax.add(paragraph(
      texto: "${paraph['Pronostico_Medico']}",
    ));
    // if (paraph['Pronostico_Medico'] != "") {
    //   parax.add(paragraphSeparatedBy(
    //     pax: "${paraph['Pronostico_Medico']}",
    //   ));
    // }
    parax.add(
      footerParagraph(
          text:
              "Med. Gral. Romero Pantoja Luis\nCed. Prof. 12210866\nMedicina General"),
    );
    return parax;
  }

  static List<Widget> reporteTerapia(Map<String, dynamic> paraph) {
    String tipoReporte = "NOTA DE TERAPIA INTENSIVA";
    // # # # # # # ### # # # # # # ###
    // Lista de apartados del documento.
    // # # # # # # ### # # # # # # ###
    List<Widget> parax = [];
    // # # # # # # ### # # # # #  # ###
    // Datos de Identificación del Paciente.
    // # # # # # # ### # # # # # # ###
    parax.add(Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Nombre completo: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text("${Pacientes.nombreCompleto}",
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Número de afiliación: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(
            "${Pacientes.Paciente['Pace_NSS']} ${Pacientes.Paciente['Pace_AGRE']}",
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Fecha Actual: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(Calendarios.completeToday(),
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      SizedBox(height: 10),
    ]));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(Divider(color: PdfColors.black));
    parax.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(tipoReporte,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 9,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold)),
    ]));
    parax.add(Divider(color: PdfColors.black));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphWithTittle(
        titulo: "Datos generales", subTitulo: "${paraph['Datos_Generales']}"));
    parax.add(
      paragraphWithBullets(
        titulo: "", // "Impresiones diagnósticas",
        subTitulo: "${paraph['Impresiones_Diagnosticas']}",
      ),
    );

    // # # # # # # ### # # # # # # ###
    parax.add(paragraph(texto: paraph['Eventualidades'] ?? ""));
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphWithTittle(
        titulo: "Exploración Física".toUpperCase(),
        subTitulo: "${paraph['Exploracion_Fisica']}"));

    parax.add(paragraph(
      texto: "${paraph['Analisis_Terapia']}",
    ));

    parax.add(paragraph(
      texto: "${paraph['Pronostico_Medico']}",
    ));

    // if (paraph['Pronostico_Medico'] != "") {
    //   parax.add(paragraphSeparatedBy(
    //     pax: "${paraph['Pronostico_Medico']}",
    //   ));
    // }
    parax.add(
      footerParagraph(
          text:
              "Med. Gral. Romero Pantoja Luis\nCed. Prof. 12210866\nMedicina General"),
    );
    return parax;
  }

  static List<Widget> reporteEgreso(Map<String, dynamic> paraph) {
    String tipoReporte = "REPORTE DE EGRESO HOSPITALARIO";
    // # # # # # # ### # # # # # # ###
    // Lista de apartados del documento.
    // # # # # # # ### # # # # # # ###
    List<Widget> parax = [];
    // # # # # # # ### # # # # #  # ###
    // Datos de Identificación del Paciente.
    // # # # # # # ### # # # # # # ###
    parax.add(Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Nombre completo: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text("${Pacientes.nombreCompleto}",
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Número de afiliación: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(
            "${Pacientes.Paciente['Pace_NSS']} ${Pacientes.Paciente['Pace_AGRE']}",
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Fecha Actual: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(Calendarios.completeToday(),
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      SizedBox(height: 10),
    ]));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(Divider(color: PdfColors.black));
    parax.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(tipoReporte,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 9,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold)),
    ]));
    parax.add(Divider(color: PdfColors.black));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphWithTittle(
        titulo: "Datos generales", subTitulo: "${paraph['Datos_Generales']}"));
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphFromList(listado: [
      [
        "Antecedentes heredofamiliares ",
        paraph['Antecedentes_Heredofamiliares']
      ],
      ["Antecedentes hospitalarios ", paraph['Antecedentes_Hospitalarios']],
      ["Antecedentes alergicos ", paraph['Antecedentes_Alergicos']],
      ["Antecedentes patológicos ", paraph['Antecedentes_Patologicos']],
    ]));
    // # # # # # # ### # # # # # # ###
    parax.add(
      paragraph(
        isBefore: true,
        anteTexto: "A la exploración física con ",
        texto: "${paraph['Signos_Vitales']}\n",
        subTexto: "${paraph['Exploracion_Fisica']}",
      ),
    );
    if (paraph['Auxiliares_Diagnosticos'] != "") {
      parax.add(
        paragraphWithTittleAndSeparated(
          titulo: "Auxiliares diagnósticos",
          subTitulo: "${paraph['Auxiliares_Diagnosticos']}",
        ),
      );
    }

    if (paraph['Analisis_Complementarios'] != "") {
      parax.add(
        paragraphWithBullets(
          titulo: "Análisis complementarios",
          subTitulo: "${paraph['Analisis_Complementarios']}",
        ),
      );
    }
    parax.add(
      paragraphWithBullets(
        titulo: "Impresiones diagnósticas",
        subTitulo: "${paraph['Impresiones_Diagnosticas']}",
      ),
    );
    parax.add(paragraph(
      texto: "${paraph['Analisis_Medico']}",
    ));
    //
    parax.add(paragraph(
      texto: "${paraph['Pronostico_Medico']}",
    ));
    // if (paraph['Pronostico_Medico'] != "") {
    //   parax.add(paragraphSeparatedBy(
    //     pax: "${paraph['Pronostico_Medico']}",
    //   ));
    // }
    parax.add(
      footerParagraph(
          text:
              "Med. Gral. Romero Pantoja Luis\nCed. Prof. 12210866\nMedicina General"),
    );
    return parax;
  }

  static List<Widget> reporteRevision(Map<String, dynamic> paraph) {
    String tipoReporte = "REVISION MEDICA";
    // # # # # # # ### # # # # # # ###
    // Lista de apartados del documento.
    // # # # # # # ### # # # # # # ###
    List<Widget> parax = [];
    // # # # # # # ### # # # # #  # ###
    // Datos de Identificación del Paciente.
    // # # # # # # ### # # # # # # ###
    parax.add(Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Nombre completo: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text("${Pacientes.nombreCompleto}",
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Número de afiliación: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(
            "${Pacientes.Paciente['Pace_NSS']} ${Pacientes.Paciente['Pace_AGRE']}",
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Fecha Actual: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(Calendarios.completeToday(),
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      SizedBox(height: 10),
    ]));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(Divider(color: PdfColors.black));
    parax.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(tipoReporte,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 9,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold)),
    ]));
    parax.add(Divider(color: PdfColors.black));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphWithTittle(
        titulo: "Datos generales", subTitulo: "${paraph['Datos_Generales']}"));
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphFromList(listado: [
      [
        "Antecedentes heredofamiliares ",
        paraph['Antecedentes_Heredofamiliares']
      ],
      ["Antecedentes hospitalarios ", paraph['Antecedentes_Hospitalarios']],
      ["Antecedentes alergicos ", paraph['Antecedentes_Alergicos']],
      ["Antecedentes patológicos ", paraph['Antecedentes_Patologicos']],
    ]));
    // # # # # # # ### # # # # # # ###
    parax.add(
      paragraph(
        isBefore: true,
        anteTexto: "A la exploración física con ",
        texto: "${paraph['Signos_Vitales']}\n",
        subTexto: "${paraph['Exploracion_Fisica']}",
      ),
    );
    if (paraph['Auxiliares_Diagnosticos'] != "") {
      parax.add(
        paragraphWithTittleAndSeparated(
          titulo: "Auxiliares diagnósticos",
          subTitulo: "${paraph['Auxiliares_Diagnosticos']}",
        ),
      );
    }

    if (paraph['Analisis_Complementarios'] != "") {
      parax.add(
        paragraphWithBullets(
          titulo: "Análisis complementarios",
          subTitulo: "${paraph['Analisis_Complementarios']}",
        ),
      );
    }
    parax.add(
      paragraphWithBullets(
        titulo: "Impresiones diagnósticas",
        subTitulo: "${paraph['Impresiones_Diagnosticas']}",
      ),
    );
    parax.add(paragraph(
      texto: "${paraph['Analisis_Medico']}",
    ));
    //
    parax.add(paragraph(
      texto: "${paraph['Pronostico_Medico']}",
    ));
    // if (paraph['Pronostico_Medico'] != "") {
    //   parax.add(paragraphSeparatedBy(
    //     pax: "${paraph['Pronostico_Medico']}",
    //   ));
    // }
    parax.add(
      footerParagraph(
          text:
              "Med. Gral. Romero Pantoja Luis\nCed. Prof. 12210866\nMedicina General"),
    );
    return parax;
  }

  static List<Widget> indicacionesHospital(Map<String, dynamic> paraph) {
    String tipoReporte = "HOJA DE INDICACIONES";
    // # # # # # # ### # # # # # # ###
    // Lista de apartados del documento.
    // # # # # # # ### # # # # # # ###
    List<Widget> parax = [];
    // # # # # # # ### # # # # #  # ###
    // Datos de Identificación del Paciente.
    // # # # # # # ### # # # # # # ###
    parax.add(Divider(color: PdfColors.black));
    parax.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(tipoReporte,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 9,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold)),
    ]));
    parax.add(Divider(color: PdfColors.black));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(
      SizedBox(height: 4),
    );
    parax.add(Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: const TableBorder(
          horizontalInside: BorderSide(width: 0.7),
          left: BorderSide(width: 0.7),
          right: BorderSide(width: 0.7),
          top: BorderSide(width: 0.7),
          bottom: BorderSide(width: 0.7),
        ), //width: 0.7),
        children: [
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                Padding(padding: const EdgeInsets.all(4.0), child: Container())
              ]),
          TableRow(
              // decoration: BoxDecoration(padding: EdgeInsets.all(4.0)),
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittle("Unidad Médica: "),
                textTittle("Servicio Médico: "),
                textTittle("Numero y Nombre del Empleado: "),
                textTittle("Consultorio: "),
                textTittle("Turno de Atención: "),
                textTittle("Fecha: "),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textLabel("CAF Bacalar"),
                textLabel("Consulta Externa"),
                textLabel("00408206 Med. Gral. Romero Pantoja Luis"),
                textLabel("CG-01"),
                textLabel("Vespertino"),
                textLabel(Calendarios.completeToday()),
              ]),
          TableRow(
              // decoration: BoxDecoration(padding: EdgeInsets.all(4.0)),
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittle(" "),
                textTittle(" "),
                textTittleWithLabel(
                    tittle: "Nombre Completo: ",
                    label: '${Pacientes.nombreCompleto}'),
                textTittleWithLabel(
                    tittle: "Teléfono: ", label: Valores.telefono),
                textTittleWithLabel(
                    tittle: "Edad: ", label: '${Valores.edad} Años'),
                textTittle(" "),
              ]),
          TableRow(
              // decoration: BoxDecoration(padding: EdgeInsets.all(4.0)),
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittle(" "),
                textTittle(" "),
                textTittleWithLabel(
                    tittle: "No. Afiliación: ",
                    label: Valores.numeroExpediente),
                textTittleWithLabel(
                    tittle: "Fecha Nacimiento: ",
                    label: Valores.fechaNacimiento),
                textTittleWithLabel(tittle: "C.U.R.P.: ", label: Valores.curp),
                textTittle(" "),
              ]),
        ]));
    // # # # # # # ### # # # # # # ###
    parax.add(
      SizedBox(height: 12),
    );
    // # # # # # # ### # # # # # # ###
    parax.add(Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: const TableBorder(
          horizontalInside: BorderSide(width: 0.7),
          left: BorderSide(width: 0.7),
          right: BorderSide(width: 0.7),
          top: BorderSide(width: 0.7),
          bottom: BorderSide(width: 0.7),
        ),
        children: [
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "T. Arterial: ",
                    label: '${Valores.tensionArterialSistemica} mmHg'),
                textTittleWithLabel(
                    tittle: "F. Cardiaca: ",
                    label: '${Valores.frecuenciaCardiaca} Lat/min'),
                textTittleWithLabel(
                    tittle: "F. Respiratoria: ",
                    label: '${Valores.frecuenciaRespiratoria} Resp/min'),
                textTittleWithLabel(
                    tittle: "T. Corporal: ",
                    label: '${Valores.temperaturCorporal} °C'),
                textTittleWithLabel(
                    tittle: "SpO2: ",
                    label: '${Valores.saturacionPerifericaOxigeno} %'),
                textTittleWithLabel(
                    tittle: "P.C.T.: ",
                    label: '${Valores.pesoCorporalTotal} Kg'),
                textTittleWithLabel(
                    tittle: "Estatura (mts): ",
                    label: '${Valores.alturaPaciente} Kg'),
              ]),
          TableRow(
              decoration: const BoxDecoration(),
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "Glucemia Capilar: ",
                    label: '${Valores.glucemiaCapilar} mg/dL'),
                textTittleWithLabel(tittle: "Observaciones: ", label: ''),
                textTittleWithLabel(tittle: " ", label: ''),
                textTittleWithLabel(tittle: " ", label: ''),
                textTittleWithLabel(tittle: " ", label: ''),
                textTittleWithLabel(tittle: " ", label: ''),
                textTittleWithLabel(
                    tittle: "I.M.C.: ",
                    label: '${Antropometrias.imc.toStringAsFixed(2)} Kg/m2'),
              ]),
        ]));
    // # # # # # # ### # # # # # # ###
    parax.add(
      SizedBox(height: 12),
    );
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    List<String> tittles = [
      'Liquidos parenterales',
      'Medicamentos',
      'Pendientes',
    ];
    List<List<dynamic>> contents = [
      paraph['Hidroterapia'] ?? [""],
      paraph['Medicamentos'] ?? [""],
      paraph['Pendientes'] ?? [""],
    ];
    // # # # # # # ### # # # # # # ###
    if (paraph['Oxigenoterapia'] !=
        'Sin administración de oxígeno suplementario.\n') {
      tittles.add('Oxigenoterapia');
      contents.add(paraph['Oxigenoterapia']);
    }
    if (paraph['Insulinoterapia'] != 'Sin terapia insulinica.\n') {
      tittles.add('Insulinoterapia');
      contents.add(paraph['Insulinoterapia']);
    }
    if (paraph['Hemoterapia'] != 'Sin reposicion sanguinea.\n') {
      tittles.add('Hemoterapia y derivados');
      contents.add(paraph['Hemoterapia']);
    }
    // # # # # # # ### # # # # # # ###
    parax.add(buildListado(
      'Indicaciones médicas',
      tittles,
      contents,
    ));

    parax.add(
      footerParagraph(
          text:
              "Med. Gral. Romero Pantoja Luis\nCed. Prof. 12210866\nMedicina General"),
    );
    // # # # # # # ### # # # # # # ###
    return parax;
  }

  static List<Widget> indicacionesHospitalVertical(
      Map<String, dynamic> paraph) {
    String tipoReporte = "HOJA DE INDICACIONES - VERTICAL";
    // # # # # # # ### # # # # # # ###
    // Lista de apartados del documento.
    // # # # # # # ### # # # # # # ###
    List<Widget> parax = [];
    // # # # # # # ### # # # # #  # ###
    // Datos de Identificación del Paciente.
    // # # # # # # ### # # # # # # ###
    parax.add(Divider(color: PdfColors.black));
    parax.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(tipoReporte,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 9,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold)),
    ]));
    parax.add(Divider(color: PdfColors.black));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    //parax.add(
    //SizedBox(height: 4),
    //);

    // # # # # # # ### # # # # # # ###
    parax.add(
      SizedBox(height: 12),
    );
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    List<String> tittles = [
      'Dieta',
      'Liquidos parenterales',
      'Medicamentos',
      'Medidas Generales',
      'Pendientes',
    ];
    List<List<dynamic>> contents = [
      paraph['Dieta'] ?? [""],
      paraph['Hidroterapia'] ?? ['Sin Cateter. Ni soluciones.'],
      paraph['Medicamentos'] ?? [""],
      paraph['Medidas_Generales'] ?? [""],
      paraph['Pendientes'] ?? [""],
    ];
    // # # # # # # ### # # # # # # ###
    // print("paraph['Oxigenoterapia'] ${paraph['Oxigenoterapia']}\n"
    // "paraph['Insulinoterapia'] ${paraph['Insulinoterapia']}\n"
    // "paraph['Hemoterapia'] ${paraph['Hemoterapia']}\n");
    // # # # # # # ### # # # # # # ###
    if (paraph['Hemoterapia'][0] != 'Sin reposicion sanguinea.') {
      tittles.insert(2, 'Hemoterapia y derivados');
      contents.insert(2, paraph['Hemoterapia']);
    }
    if (paraph['Insulinoterapia'][0] != 'Sin terapia insulinica.') {
      tittles.insert(2, 'Insulinoterapia');
      contents.insert(2, paraph['Insulinoterapia']);
    }
    if (paraph['Oxigenoterapia'][0] !=
        'Sin administración de oxígeno suplementario.') {
      tittles.insert(2, 'Oxigenoterapia');
      contents.insert(2, paraph['Oxigenoterapia']);
    }
    // # # # # # # ### # # # # # # ###
    parax.add(Expanded(
        child: Row(children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // infoVertical(),
          // SizedBox(height: 12),
          vitalesVertical(),
        ],
      ),
      SizedBox(width: 12),
      Expanded(
        flex: 3,
        child: Container(
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.8,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                buildListado(
                  'Indicaciones médicas',
                  tittles,
                  contents,
                ),
                // # # # # # # ### # # # # # # ###
                SizedBox(height: 12),
                // # # # # # # ### # # # # # # ###
                footerParagraph(
                    text:
                        "Med. Gral. Romero Pantoja Luis\nCed. Prof. 12210866\nMedicina General"),
              ],
            ),
          ),
        ),
      )
    ])));
    // # # # # # # ### # # # # # # ###
    // # # # # # # ### # # # # # # ###

    // # # # # # # ### # # # # # # ###
    return parax;
  }

  static Table infoVertical() {
    return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: const TableBorder(
          horizontalInside: BorderSide(width: 0.7),
          left: BorderSide(width: 0.7),
          right: BorderSide(width: 0.7),
          top: BorderSide(width: 0.7),
          bottom: BorderSide(width: 0.7),
        ), //width: 0.7),
        children: [
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "Nombre Completo: ",
                    label: '${Pacientes.nombreCompleto}'),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "No. Afiliación: ",
                    label: Valores.numeroExpediente),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "Edad: ", label: '${Valores.edad} Años'),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "Fecha Nacimiento: ",
                    label: Valores.fechaNacimiento),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "Fecha: ", label: Calendarios.completeToday()),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(tittle: "C.U.R.P.: ", label: Valores.curp),
              ]),
        ]);
  }

  static Table vitalesVertical() {
    return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.full,
        border: const TableBorder(
          horizontalInside: BorderSide(width: 0.7),
          left: BorderSide(width: 0.7),
          right: BorderSide(width: 0.7),
          top: BorderSide(width: 0.7),
          bottom: BorderSide(width: 0.7),
        ),
        children: [
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textBoldTittle("DATOS GENERALES"),
              ]),
          // ################### # # # # # ##################
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "Nombre Completo: ",
                    label: '${Pacientes.nombreCompleto}'),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "No. Afiliación: ",
                    label: Valores.numeroExpediente),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                  tittle: "No. Cama: ",
                  label: Valores.numeroCama!,
                )
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "Edad: ", label: '${Valores.edad} Años'),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "Fecha Nacimiento: ",
                    label: Valores.fechaNacimiento),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "Fecha: ", label: Calendarios.completeToday()),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(tittle: "C.U.R.P.: ", label: Valores.curp),
              ]),
          // ################### # # # # # ##################
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(tittle: "", label: ""),
              ]),
          // ################### # # # # # ##################
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "T. Arterial: ",
                    label: '${Valores.tensionArterialSistemica} mmHg'),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "F. Cardiaca: ",
                    label: '${Valores.frecuenciaCardiaca} Lat/min'),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "F. Respiratoria: ",
                    label: '${Valores.frecuenciaRespiratoria} Resp/min'),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "T. Corporal: ",
                    label: '${Valores.temperaturCorporal} °C'),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "SpO2: ",
                    label: '${Valores.saturacionPerifericaOxigeno} %'),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "P.C.T.: ",
                    label: '${Valores.pesoCorporalTotal} Kg'),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "Estatura (mts): ",
                    label: '${Valores.alturaPaciente} Kg'),
              ]),
          TableRow(
              decoration: const BoxDecoration(),
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "Glucemia Capilar: ",
                    label: '${Valores.glucemiaCapilar} mg/dL'),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(
                    tittle: "I.M.C.: ",
                    label: '${Antropometrias.imc.toStringAsFixed(2)} Kg/m2'),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(tittle: "Observaciones: ", label: ''),
              ]),
        ]);
  }

  // Reportes de Procedimientos *********** ************ ***** ***
  static List<Widget> procedimientoCVC(Map<String, dynamic> paraph) {
    String tipoReporte = "NOTA DE PROCEDIMIENTO\nCATÉTER VENOSO CENTRAL";
    // Lista de apartados del documento. # # # # # # ### # # # # #  # ###
    List<Widget> parax = [];
    // Datos de Identificación del Paciente. # # # # # # ### # # # # #  # ###
    parax.add(Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Nombre completo: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text("${Pacientes.nombreCompleto}",
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Número de afiliación: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(
            "${Pacientes.Paciente['Pace_NSS']} ${Pacientes.Paciente['Pace_AGRE']}",
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Fecha Actual: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(Calendarios.completeToday(),
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      SizedBox(height: 10),
    ]));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(Divider(color: PdfColors.black));
    parax.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(tipoReporte,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 9,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold)),
    ]));
    parax.add(Divider(color: PdfColors.black));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphWithTittle(
        titulo: "Motivo del procedimiento",
        subTitulo: "${paraph['Motivo_Procedimiento']}"));
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphWithTittle(
        titulo: "Descripción de la técnica",
        subTitulo: "${paraph['Procedimiento_Realizado']}"));

    // # # # # # # ### # # # # # # ###
    if (paraph['Complicaciones_Procedimiento'] != "") {
      parax.add(
        paragraphWithTittleAndSeparated(
          titulo: "",
          subTitulo:
              "Complicaciones durante el procedimiento: ${paraph['Complicaciones_Procedimiento']}\n"
              "Pendientes del procedimiento: ${paraph['Pendientes_Procedimiento']}",
        ),
      );
    }
    // # # # # # # ### # # # # # # ###
    parax.add(
      footerParagraph(
          text:
              "Med. Gral. Romero Pantoja Luis\nCed. Prof. 12210866\nMedicina General"),
    );
    return parax;
  }

  static List<Widget> procedimientoIOT(Map<String, dynamic> paraph) {
    String tipoReporte = "NOTA DE PROCEDIMIENTO\nINTUBACION ENDOTRAQUEAL";
    // Lista de apartados del documento. # # # # # # ### # # # # #  # ###
    List<Widget> parax = [];
    // Datos de Identificación del Paciente. # # # # # # ### # # # # #  # ###
    parax.add(Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Nombre completo: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text("${Pacientes.nombreCompleto}",
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Número de afiliación: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(
            "${Pacientes.Paciente['Pace_NSS']} ${Pacientes.Paciente['Pace_AGRE']}",
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Fecha Actual: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(Calendarios.completeToday(),
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      SizedBox(height: 10),
    ]));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(Divider(color: PdfColors.black));
    parax.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(tipoReporte,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 9,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold)),
    ]));
    parax.add(Divider(color: PdfColors.black));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphWithTittle(
        titulo: "Motivo del procedimiento",
        subTitulo: "${paraph['Motivo_Procedimiento']}"));
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphWithTittle(
        titulo: "Descripción de la técnica",
        subTitulo: "${paraph['Procedimiento_Realizado']}"));

    // # # # # # # ### # # # # # # ###
    if (paraph['Complicaciones_Procedimiento'] != "") {
      parax.add(
        paragraphWithTittleAndSeparated(
          titulo: "",
          subTitulo:
              "Complicaciones durante el procedimiento: ${paraph['Complicaciones_Procedimiento']}\n"
              "Pendientes del procedimiento: ${paraph['Pendientes_Procedimiento']}",
        ),
      );
    }
    // # # # # # # ### # # # # # # ###
    parax.add(
      footerParagraph(
          text:
              "Med. Gral. Romero Pantoja Luis\nCed. Prof. 12210866\nMedicina General"),
    );
    return parax;
  }

  static List<Widget> procedimientoSOP(Map<String, dynamic> paraph) {
    String tipoReporte = "NOTA DE PROCEDIMIENTO\nSONDA ENDOPLEURAL";
    // Lista de apartados del documento. # # # # # # ### # # # # #  # ###
    List<Widget> parax = [];
    // Datos de Identificación del Paciente. # # # # # # ### # # # # #  # ###
    parax.add(Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Nombre completo: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text("${Pacientes.nombreCompleto}",
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Número de afiliación: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(
            "${Pacientes.Paciente['Pace_NSS']} ${Pacientes.Paciente['Pace_AGRE']}",
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Fecha Actual: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(Calendarios.completeToday(),
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      SizedBox(height: 10),
    ]));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(Divider(color: PdfColors.black));
    parax.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(tipoReporte,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 9,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold)),
    ]));
    parax.add(Divider(color: PdfColors.black));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphWithTittle(
        titulo: "Motivo del procedimiento",
        subTitulo: "${paraph['Motivo_Procedimiento']}"));
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphWithTittle(
        titulo: "Descripción de la técnica",
        subTitulo: "${paraph['Procedimiento_Realizado']}"));

    // # # # # # # ### # # # # # # ###
    if (paraph['Complicaciones_Procedimiento'] != "") {
      parax.add(
        paragraphWithTittleAndSeparated(
          titulo: "",
          subTitulo:
              "Complicaciones durante el procedimiento: ${paraph['Complicaciones_Procedimiento']}\n"
              "Pendientes del procedimiento: ${paraph['Pendientes_Procedimiento']}",
        ),
      );
    }
    // # # # # # # ### # # # # # # ###
    parax.add(
      footerParagraph(
          text:
              "Med. Gral. Romero Pantoja Luis\nCed. Prof. 12210866\nMedicina General"),
    );
    return parax;
  }

  static List<Widget> procedimientoTEN(Map<String, dynamic> paraph) {
    String tipoReporte = "NOTA DE PROCEDIMIENTO\nCATÉTER TENCHKOFF";
    // Lista de apartados del documento. # # # # # # ### # # # # #  # ###
    List<Widget> parax = [];
    // Datos de Identificación del Paciente. # # # # # # ### # # # # #  # ###
    parax.add(Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Nombre completo: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text("${Pacientes.nombreCompleto}",
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Número de afiliación: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(
            "${Pacientes.Paciente['Pace_NSS']} ${Pacientes.Paciente['Pace_AGRE']}",
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Fecha Actual: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(Calendarios.completeToday(),
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      SizedBox(height: 10),
    ]));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(Divider(color: PdfColors.black));
    parax.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(tipoReporte,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 9,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold)),
    ]));
    parax.add(Divider(color: PdfColors.black));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphWithTittle(
        titulo: "Motivo del procedimiento",
        subTitulo: "${paraph['Motivo_Procedimiento']}"));
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphWithTittle(
        titulo: "Descripción de la técnica",
        subTitulo: "${paraph['Procedimiento_Realizado']}"));

    // # # # # # # ### # # # # # # ###
    if (paraph['Complicaciones_Procedimiento'] != "") {
      parax.add(
        paragraphWithTittleAndSeparated(
          titulo: "",
          subTitulo:
              "Complicaciones durante el procedimiento: ${paraph['Complicaciones_Procedimiento']}\n"
              "Pendientes del procedimiento: ${paraph['Pendientes_Procedimiento']}",
        ),
      );
    }
    // # # # # # # ### # # # # # # ###
    parax.add(
      footerParagraph(
          text:
              "Med. Gral. Romero Pantoja Luis\nCed. Prof. 12210866\nMedicina General"),
    );
    return parax;
  }

  // Reportes de Censos Hospitalarios *********** ************ ***** ***
  static List<Widget> censoHospitalario(List<dynamic> paraph) {
    // String tipoReporte = "CENSO HOSPITALARIO - MEDICINA INTERNA";
    // Lista de apartados del documento. ***** ****** *********** *********
    List<Widget> parax = [];

    // Datos de Identificación del Paciente. . ***** ****** *********** *********
    parax.add(
      Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: const TableBorder(
          horizontalInside: BorderSide(width: 0.7),
          left: BorderSide(width: 0.7),
          right: BorderSide(width: 0.7),
          top: BorderSide(width: 0.7),
          bottom: BorderSide(width: 0.7),
        ), //width: 0.7),
        children: [
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                Container(
                    child: textBoldTittle(
                        "CENSO HOSPITALARIO - MEDICINA INTERNA")),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                Container(
                  child: textTittle(
                      "Fecha: ${Calendarios.today(format: 'dd/MM/yyyy')}",
                      textAlign: TextAlign.right),
                ),
              ]),
        ],
      ),
    );
    // Listado de Celdas. ***** ****** *********** *********
    List<TableRow> censo = [];
    censo.add(
      TableRow(
        // decoration: BoxDecoration(padding: EdgeInsets.all(4.0)),
        verticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          textTittle("ID"),
          textTittle("No Cama"),
          textTittle("N.S.S."),
          textTittle("Nombre(s) del Paciente"),
          textTittle("Sexo"),
          textTittle("Edad"),
          textTittle("Hemotipo"),
          textTittle("Fecha de Ingreso"),
          textTittle("D.E.H."),
          textTittle("Servicio Tratante"),
          textTittle("Médico Tratante"),
          textTittle("Diagnóstico(s)"),
          textTittle("Pendiente(s)"),
        ],
      ),
    );
    censo.add(
      TableRow(verticalAlignment: TableCellVerticalAlignment.middle, children: [
        Padding(padding: const EdgeInsets.all(4.0), child: Container())
      ]),
    );

    int index = 1;
    // Despliegue del listado . ***** ****** *********** *********
    for (var item in paraph) {
      print("item $item");
      String penden = "", cronicos = "", diagos = "";
      for (var i in item['Pendientes']) {
        penden = "$penden${i['Pace_Desc_PEN']}\n";
      }
      for (var i in item['Cronicos']) {
        // print("Cronicos $i");
        cronicos = "$cronicos${i['Pace_APP_DEG']}\n";
      }
      for (var i in item['Diagnosticos']) {
        // print("item $i");
        diagos = "$diagos${i['Pace_APP_DEG']}\n";
      }
      censo.add(
        TableRow(
          verticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            textLabel("$index"),
            textLabel("${item['Id_Cama']}"),
            textLabel("${item['Pace_NSS']}\n${item['Pace_AGRE']}"),
            textLabel("${item['Pace_Ape_Pat']} ${item['Pace_Ape_Mat']}"
                " ${item['Pace_Nome_PI']} ${item['Pace_Nome_SE']}"),
            textLabel("${item['Pace_Ses']}"),
            textLabel("${item['Pace_Eda']}"),
            textLabel("${item['Pace_Hemo'] ?? 'Hemotipo desconocido'}"),
            textLabel("${item['Feca_INI_Hosp']}"),
            textLabel(
                "${DateTime.now().difference(DateTime.parse(item['Feca_INI_Hosp'])).inDays}"),
            // textLabel("${item['Dia_Estan']}"),
            textLabel("${item['Serve_Trat']}"),
            textLabel("${item['Medi_Trat']}"),
            textLabel("$cronicos$diagos"),
            textLabel(penden),
          ],
        ),
      );
      index++;
    }
    // # # # # # # ### # # # # # # ###
    parax.add(
      Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: const TableBorder(
          horizontalInside: BorderSide(width: 0.7),
          left: BorderSide(width: 0.7),
          right: BorderSide(width: 0.7),
          top: BorderSide(width: 0.7),
          bottom: BorderSide(width: 0.7),
        ), //width: 0.7),
        children: censo,
      ),
    );
    // # # # # # # ### # # # # # # ###
    parax.add(
      SizedBox(height: 12),
    );
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(
      footerParagraph(
          text:
              "Med. Gral. Romero Pantoja Luis\nCed. Prof. 12210866\nMedicina General"),
    );
    // # # # # # # ### # # # # # # ###
    return parax;
  }

  static List<Widget> censoSimpleHospitalario(List<dynamic> paraph) {
    // String tipoReporte = "CENSO HOSPITALARIO - MEDICINA INTERNA";
    // Lista de apartados del documento. ***** ****** *********** *********
    List<Widget> parax = [];

    // Datos de Identificación del Paciente. . ***** ****** *********** *********
    parax.add(
      Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: const TableBorder(
          horizontalInside: BorderSide(width: 0.7),
          left: BorderSide(width: 0.7),
          right: BorderSide(width: 0.7),
          top: BorderSide(width: 0.7),
          bottom: BorderSide(width: 0.7),
        ), //width: 0.7),
        children: [
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                Container(child: textBoldTittle("CENSO HOSPITALARIO ")),
              ]),
        ],
      ),
    );
    // Listado de Celdas. ***** ****** *********** *********
    List<TableRow> censo = [];
    //
    censo.add(
      TableRow(
        // decoration: BoxDecoration(padding: EdgeInsets.all(4.0)),
        verticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          // textTittle("ID"),
          textTittle("Cama".toUpperCase(), fontSize: 4),
          textTittle("Datos Generales".toUpperCase(), fontSize: 4),
          textTittle("Diagnóstico(s)".toUpperCase(), fontSize: 4),
          textTittle("Auxiliares Diagnósticos".toUpperCase(), fontSize: 4),
          textTittle("Pendientes".toUpperCase(), fontSize: 4),
        ],
      ),
    );
    // Salto de Línea
    censo.add(
      TableRow(verticalAlignment: TableCellVerticalAlignment.middle, children: [
        Padding(padding: const EdgeInsets.all(4.0), child: Container())
      ]),
    );

    int index = 1;
    // Despliegue del listado . ***** ****** *********** *********
    for (var item in paraph) {
      Terminal.printNotice(message: "Vuelta : : $index");
      //
      String pades = "No hay padecimiento Descrito\n",
          penden = "",
          previos = "",
          ventilaciones = "No MAVA",
          cronicos = "",
          diagos = "",
          auxiliary = "",
          balances = "",
          imagenologicos = "",
          electrocardiogramas = "",
          situaciones = "";
      // Terminal.printExpected(
      //     message:
      //         "Pendientes : : ${item['Pendientes']} ${item['Pendientes'].runtimeType}");

      penden = Pendientes.getPendiente(item.pendientes);

// Ventilaciones de los Pacientes Hospitalizados ************************************* * * * * *
      if (item.ventilaciones.isNotEmpty) {
        ventilaciones = "\n"
            "IOT ${item.ventilaciones.last['Feca_VEN']}  : : :  . . . \n"
            "      ${Ventilaciones.modoVentilatorio(modalidadVentilatoria: item.ventilaciones.last['VM_Mod'].toString())} : : . . . \n"
            "            Vt ${item.ventilaciones.last['Pace_Vt']} mL\n"
            "            Fr ${item.ventilaciones.last['Pace_Fr']} Vent/min\n"
            "            FiO2 ${item.ventilaciones.last['Pace_Fio']} %\n"
            "            PEEP ${item.ventilaciones.last['Pace_Peep']} cmH2O [ . . . ] "
            "\n";
      } else {
        ventilaciones = "";
      }
      // Balances de los Pacientes Hospitalizados ************************************* * * * * *
      Terminal.printExpected(message: "${item.balances}");
      if (item.balances.isNotEmpty && item.vitales.isNotEmpty) {
        int horario = item.balances.last['Pace_bala_HOR'] ?? 24;
        double ingresos =
            (item.balances.last['Pace_bala_Oral']?.toDouble() ?? 0.0) +
                (item.balances.last['Pace_bala_Sonda']?.toDouble() ?? 0.0) +
                (item.balances.last['Pace_bala_Hemo']?.toDouble() ?? 0.0) +
                (item.balances.last['Pace_bala_NPT']?.toDouble() ?? 0.0) +
                (item.balances.last['Pace_bala_Sol']?.toDouble() ?? 0.0) +
                (item.balances.last['Pace_bala_Dil']?.toDouble() ?? 0.0);

        double egresos =
            (item.balances.last['Pace_bala_Uresis']?.toDouble() ?? 0.0) +
                (item.balances.last['Pace_bala_Evac']?.toDouble() ?? 0.0) +
                (item.balances.last['Pace_bala_Hemo']?.toDouble() ?? 0.0) +
                (item.balances.last['Pace_bala_Sangrado']?.toDouble() ?? 0.0) +
                (item.balances.last['Pace_bala_Succion']?.toDouble() ?? 0.0) +
                (item.balances.last['Pace_bala_Drenes']?.toDouble() ?? 0.0) +
                (item.balances.last['Pace_bala_PER']?.toDouble() ?? 0.0);

        int perdidasInsensibles = item.balances.last['Pace_bala_PER'];
        double diuresis = item.balances.last['Pace_bala_Uresis'] /
            item.vitales.last['Pace_SV_pct'] /
            horario;
        int uresis = item.balances.last['Pace_bala_Uresis'];

        balances = "\n"
            "BALLA ${item.balances.last['Pace_bala_Fecha']}  : : :  . . . \n"
            "     ING $ingresos mL \n"
            "     ENG $egresos mL \n"
            "DIU $uresis mL/$horario (${diuresis.toStringAsFixed(2)} mL/$horario Hrs)\n"
            "     PINS $perdidasInsensibles mL [ . . . ] "
            "\n";
      } else {
        balances = "";
      }
// ************************************** //       Terminal.printExpected(message: "BALLA : : ${item.balances}");

//       if (item['Situaciones']['CVP'] != 0) {
//         situaciones = "$situaciones\nCVP";
//       }
//       if (item['Situaciones']['CVLP'] != 0) {
//         situaciones = "$situaciones\nCVLP";
//       }
//       if (item['Situaciones']['CVC'] != 0) {
//         situaciones = "$situaciones\nCVC";
//       }
//       if (item['Situaciones']['MAH'] != 0) {
//         situaciones = "$situaciones\nMAH";
//       }
//       if (item['Situaciones']['S_Foley'] != 0) {
//         situaciones = "$situaciones\nFOL";
//       }
//       if (item['Situaciones']['SNG'] != 0) {
//         situaciones = "$situaciones\nSNG";
//       }
//       if (item['Situaciones']['SOG'] != 0) {
//         situaciones = "$situaciones\nSOG";
//       }
//       if (item['Situaciones']['Drenaje'] != 0) {
//         situaciones = "$situaciones\nDRE";
//       }
//       if (item['Situaciones']['Pleuro_Vac'] != 0) {
//         situaciones = "$situaciones\nSEP";
//       }
//       if (item['Situaciones']['Colostomia'] != 0) {
//         situaciones = "$situaciones\nCOL";
//       }
//       if (item['Situaciones']['Gastrostomia'] != 0) {
//         situaciones = "$situaciones\nGAS";
//       }
//       if (item['Situaciones']['Dialisis_Peritoneal'] != 0) {
//         situaciones = "$situaciones\nDP";
//       }
// **************************************
      if (item.patologicos == null || item.patologicos.isEmpty) {
        cronicos = 'Sin Antecedentes Crónicos Documentados';
      } else {
        cronicos = ''; // importante reiniciarlo
        for (var i in item.patologicos) {
          if (i['Pace_APP_DEG_com'] != null && i['Pace_APP_DEG_com'] != '') {
            cronicos += "${i['Pace_APP_DEG_com'].toString().toUpperCase()}, "
                "${i['Pace_APP_DEG_tra'] ?? ''} \n";
          }
        }
        if (cronicos.trim().isEmpty) {
          cronicos = 'Sin Antecedentes Crónicos Documentados';
        }
      }


      for (var i in item.patologicos) {
        previos = "$previos"
            // "${i['Pace_APP_DEG'].toUpperCase()} -\n"
            "\t${i['Pace_APP_DEG_com']}\n";
      }
      for (var i in item.diagnosticos) {
        String deg = (i['Pace_APP_DEG'] ?? '').toString().toUpperCase();
        String comentario = i['Pace_APP_DEG_com'] ?? '';
        if (deg.isNotEmpty) {
          diagos += "$deg -\n\t$comentario\n";
        }
      }

      // Auxiliares Diagnósticos . ***** ****** *********** *********
      if (item.paraclinicos != [] && item.paraclinicos != null) {
        auxiliary =
            "${Internado.getUltimo(listadoFrom: item.paraclinicos, esAbreviado: true)}"
            "${Internado.getGasometrico(listadoFrom: item.paraclinicos, esAbreviado: true)}"
            "${Internado.getEspeciales(listadoFrom: item.paraclinicos) != "" ? "___________________________________________\n\n" : ""}"
            "${Internado.getEspeciales(listadoFrom: item.paraclinicos, esAbreviado: true)}\n"
            "${Internado.getReactantes(listadoFrom: item.paraclinicos, esAbreviado: true)}\n"
            "${Internado.getCoagulacion(listadoFrom: item.paraclinicos, esAbreviado: true)}\n"
            "${Internado.getCultivos(listadoFrom: item.paraclinicos) != "" ? "___________________________________________\n\n" : ""}"
            "${Internado.getCultivos(listadoFrom: item.paraclinicos)}";

        // var fechar = Listas.listWithoutRepitedValues(
        //   Listas.listFromMapWithOneKey(
        //     item.paraclinicos!,
        //     keySearched: 'Fecha_Registro',
        //   ),
        // );
        // // Terminal.printExpected(message: "${item['Auxiliares']} ${item['Auxiliares'].runtimeType}");
        // for (var element in fechar) {
        //   String fecha = "          Paraclínicos ($element)", max = "";
        //
        //   List<dynamic>? alam = item.paraclinicos;
        //   var aux = alam!
        //       .where((user) => user["Fecha_Registro"].contains(element))
        //       .toList();
        //
        //   for (var element in aux) {
        //     // ***************************** *****************
        //     if (max == "") {
        //       max =
        //           "${Auxiliares.abreviado(estudio: element['Estudio'], tipoEstudio: element['Tipo_Estudio'])} ${element['Resultado']} ${element['Unidad_Medida']}";
        //     } else {
        //       max =
        //           "$max, ${Auxiliares.abreviado(estudio: element['Estudio'], tipoEstudio: element['Tipo_Estudio'])} ${element['Resultado']} ${element['Unidad_Medida']}";
        //     }
        //   }
        //   auxiliary = "$auxiliary$fecha: ${Sentences.capitalize(max)}\n";
        // }
      }

      // Terminal.printExpected(
      //     message:
      //     "Imagenologicos : : ${item.imagenologicos} ${item.imagenologicos.runtimeType}");
      // if (item.imagenologicos != [] && item.imagenologicos != null) {
      //   for (var element in item.imagenologicos) {
      //     // ***************************** *****************
      //     if (imagenologicos == "") {
      //       imagenologicos = ""
      //           "${element['Pace_GAB_RA_typ']} del ${element['Pace_GAB_RA_Feca']} de "
      //           "${element['Pace_GAB_RA_reg']},  ${element['Pace_GAB_RA_hal']}. "
      //           "Conclusiones: "
      //           "${element['Pace_GAB_RA_con']}\n";
      //     } else {
      //       imagenologicos = "$imagenologicos"
      //           "${element['Pace_GAB_RA_typ']} del ${element['Pace_GAB_RA_Feca']} de "
      //           "${element['Pace_GAB_RA_reg']},  ${element['Pace_GAB_RA_hal']}. "
      //           "Conclusiones: "
      //           "${element['Pace_GAB_RA_con']}\n";
      //     }
      //   }
      // } else {
      //   imagenologicos = "Sin Estudios Imagenológicos";
      // }
      // if (item.electrocardiogramas != [] &&
      //     item.electrocardiogramas != null) {
      //   for (var element in item.electrocardiogramas) {
      //     Electrocardiogramas.fromJson(element);
      //     // ***************************** *****************
      //     if (electrocardiogramas == "") {
      //       electrocardiogramas = ""
      //           "${Auxiliares.electrocardiogramaAbreviado()}\n";
      //     } else {
      //       electrocardiogramas = "$electrocardiogramas"
      //           "${Auxiliares.electrocardiogramaAbreviado()}\n";
      //     }
      //   }
      // } else {
      //   electrocardiogramas = "Sin Estudios Electrocardiográficos";
      // }

      // Padecimiento Actual . ***** ****** *********** *********
      if (item.padecimientoActual != null) {
        if (item.padecimientoActual['Padecimiento_Actual'] != null &&
            item.padecimientoActual['Padecimiento_Actual'] != [] &&
            item.padecimientoActual['Padecimiento_Actual'] != "") {
          // Terminal.printExpected(message: "Padecimiento : : ${item..padecimientoActual['Padecimiento_Actual']} ${item..padecimientoActual['Padecimiento_Actual'].runtimeType}");
          pades = "${item.padecimientoActual['Padecimiento_Actual']}\n";
        } else {
          pades = "No hay padecimiento Descrito\n";
        }
      }
      // Datos Generales . ***** ****** *********** *********
      String nombre =
          "${item.generales['Pace_Ape_Pat']} ${item.generales['Pace_Ape_Mat']} "
          "${item.generales['Pace_Nome_PI']} ${item.generales['Pace_Nome_SE']}\n";
      // Adición al Censo . ***** ****** *********** *********
      censo.add(
        TableRow(
          verticalAlignment: TableCellVerticalAlignment.top,
          children: [
            textLabel("${item.hospitalizedData['Id_Cama']}\n"
                "___\n"
                "$situaciones\n"
                "___\n"),
            textLabel(
                "${item.generales['Pace_NSS']} ${item.generales['Pace_AGRE']}\n"
                "${nombre.toUpperCase()}"
                "Edad ${item.generales['Pace_Eda']} Años\n"
                "FN: ${item.hospitalizedData['Feca_INI_Hosp']} : "
                "${DateTime.now().difference(DateTime.parse(item.hospitalizedData['Feca_INI_Hosp'])).inDays} DEH"
                "\n____________________________\n\n"
                "$cronicos\n"),
            textLabel(
                "$pades"
                "___________________________________________\n"
                "\n$diagos"
                "$previos",
                textAlign: TextAlign.justify),
            textLabel(
                "$auxiliary"
                "___________________________________________"
                // "___________________________________________"
                "\n\n"
                "$imagenologicos"
                // "___________________________________________"
                "\n\n"
                "$electrocardiogramas",
                textAlign: TextAlign.justify),
            textLabel(
                "$ventilaciones"
                "_______________________\n\n"
                "$balances"
                "_______________________\n\n"
                "PENDIENTE(s)\n"
                "$penden",
                textAlign: TextAlign.justify),
          ],
        ),
      );
      index++;
    }
    // # # # # # # ### # # # # # # ###
    parax.add(
      Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {
          0: const IntrinsicColumnWidth(flex: 2), // 2
          1: const IntrinsicColumnWidth(flex: 14), // 8
          2: const IntrinsicColumnWidth(flex: 19), // 16
          3: const IntrinsicColumnWidth(flex: 26), // 26
          4: const IntrinsicColumnWidth(flex: 8), //8
        },
        border: const TableBorder(
          horizontalInside: BorderSide(width: 0.7),
          left: BorderSide(width: 0.7),
          right: BorderSide(width: 0.7),
          top: BorderSide(width: 0.7),
          bottom: BorderSide(width: 0.7),
        ), //width: 0.7),
        children: censo,
      ),
    );

    // index ++;
    return parax;
  }

  // Otros Reportes ************** *************** **********
  static List<Widget> reporteTransfusion(Map<String, dynamic> paraph) {
    String tipoReporte = "NOTA DE TRANSFUSIÓN";
    // # # # # # # ### # # # # # # ###
    // Lista de apartados del documento.
    // # # # # # # ### # # # # # # ###
    List<Widget> parax = [];
    // # # # # # # ### # # # # #  # ###
    // Datos de Identificación del Paciente.
    // # # # # # # ### # # # # # # ###
    parax.add(Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Nombre completo: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text("${Pacientes.nombreCompleto}",
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Número de afiliación: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(
            "${Pacientes.Paciente['Pace_NSS']} ${Pacientes.Paciente['Pace_AGRE']}",
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 8)),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("Fecha Actual: ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(Calendarios.completeToday(),
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 8)),
      ]),
      SizedBox(height: 10),
    ]));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(Divider(color: PdfColors.black));
    parax.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(tipoReporte,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 9,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold)),
    ]));
    parax.add(Divider(color: PdfColors.black));
    // # # # # # # ### # # # # # # ###
    //
    // # # # # # # ### # # # # # # ###
    parax.add(paragraphWithTittle(
        titulo: "Resumen Clínico".toUpperCase(),
        subTitulo: "${paraph['Datos_Generales']}"));
    parax.add(
      paragraphWithBullets(
        titulo: "", // "Impresiones diagnósticas",
        subTitulo: "${paraph['Impresiones_Diagnosticas']}",
      ),
    );
    // # # # # # # ### # # # # # # ###
    parax.add(paragraph(texto: paraph['Motivo_Transfusion'] ?? ""));

    // # # # # # # ### # # # # # # ###
    parax.add(paragraph(
        isBefore: true,
        anteTexto: "Hemotipo Administrado: ".toUpperCase(),
        texto: paraph['Hemotipo_Admnistrado'],
        withJumpSpace: false));
    parax.add(paragraph(
        isBefore: true,
        anteTexto: "Cantidad de Unidades Administradas: ".toUpperCase(),
        texto: paraph['Cantidad_Unidades'],
        withJumpSpace: false));
    parax.add(paragraph(
        isBefore: true,
        anteTexto: "Volumen Administrado: ".toUpperCase(),
        texto: paraph['Volumen_Administrado'],
        withJumpSpace: false));
    parax.add(paragraph(
        isBefore: true,
        anteTexto: "Número de Identifación del Hemoderivado: ".toUpperCase(),
        texto: paraph['Num_Identificacion'],
        withJumpSpace: false));

    parax.add(paragraph(
        isBefore: true,
        anteTexto: "Fecha y Hora de Inicio: ".toUpperCase(),
        texto: paraph['Inicio_Transfusion'],
        withJumpSpace: false));
    parax.add(paragraph(
        isBefore: true,
        anteTexto: "Fecha y Hora de Término: ".toUpperCase(),
        texto: paraph['Termino_Transfusion'],
        withJumpSpace: false));

    parax.add(paragraphWithTittleAndSeparated(
        titulo: "Seguimiento de Signos Vitales: ".toUpperCase(),
        subTitulo: paraph['Seguimiento_Vitales'] ?? ""));

    parax.add(paragraph(
        isBefore: true,
        anteTexto: "Estado General del Paciente: ".toUpperCase(),
        texto: paraph['Motivo_Transfusion'] ?? "",
        withJumpSpace: false));
    parax.add(paragraph(
        isBefore: true,
        anteTexto: "Reacciones Adversas presentadas: ".toUpperCase(),
        texto: paraph['Reacciones_Presentadas'] ?? "",
        withJumpSpace: false));

    // # # # # # # ### # # # # # # ###
    parax.add(
      footerParagraph(
          text:
              "Med. Gral. Romero Pantoja Luis\nCed. Prof. 12210866\nMedicina General"),
    );
    return parax;
  }
}

class CopiasReportes {
  static String reporteIngreso(Map<String, dynamic> paraph) {
    print(paraph);
    //
    String tipoReporte = "NOTA DE INGRESO HOSPITALARIO\n";
    tipoReporte = "${tipoReporte}FICHA DE IDENTIFICACIÓN\n"
        "${paraph['Datos_Generales']}\n";

    // # # # # # # ### # # # # # # ###
    if (paraph['Antecedentes_Heredofamiliares'] != "") {
      tipoReporte = "${tipoReporte}ANTECEDENTES HEREDOFAMILIARES\n"
          "${paraph['Antecedentes_Heredofamiliares']}\n\n";
    }
    if (paraph['Antecedentes_No_Patologicos'] != "") {
      tipoReporte = "${tipoReporte}ANTECEDENTES PERSONALES NO PATOLÓGICOS\n"
          "${paraph['Antecedentes_No_Patologicos']}";
    }
    if (paraph['Antecedentes_Quirurgicos'] != "") {
      tipoReporte = "${tipoReporte}RELEVANTES : "
          "${paraph['Antecedentes_Quirurgicos']}\n\n";
    }

    if (paraph['Antecedentes_Patologicos_Ingreso'] != "") {
      tipoReporte = "${tipoReporte}ANTECEDENTES PERSONALES PATOLÓGICOS\n"
          "${paraph['Antecedentes_Patologicos_Ingreso']}\n";
    }

    tipoReporte = "$tipoReporte\nPADECIMIENTO ACTUAL\n"
        "${paraph['Padecimiento_Actual']}\n\n";

    // # # # # # # ### # # # # # # ###
    tipoReporte =
        "${tipoReporte}A la ingreso a hospitalización de medicina interna se encuentra al paciente con: \n"
        "${paraph['Signos_Vitales']}\n"
        "${paraph['Exploracion_Fisica']}\n\n";

    if (paraph['Auxiliares_Diagnosticos'] != "") {
      tipoReporte = "${tipoReporte}AUXILIARES DIAGNÓSTICOS\n"
          "${paraph['Auxiliares_Diagnosticos']}\n\n";
    }

    if (paraph['Analisis_Complementarios'] != "" &&
        paraph['Analisis_Complementarios'] != null) {
      tipoReporte = "${tipoReporte}ANALISIS COMPLEMENTARIOS\n"
          "${paraph['Analisis_Complementarios']}\n\n";
    }

    tipoReporte = "${tipoReporte}IMPRESIONES DIAGNÓSTICAS\n"
        "${paraph['Impresiones_Diagnosticas']}\n\n";

    tipoReporte = "$tipoReporte"
        "ANÁLISIS\n"
        "${paraph['Analisis_Medico']}\n";

    // tipoReporte = "$tipoReporte\n"
    //     "INDICACIONES MÉDICAS\n"
    //     "DIETAS\n"
    //     "${Listas.stringFromList(listValues: paraph['Dieta'])}\n"
    //     "SOLUCIONES PARENTERALES\n"
    //     "${Listas.stringFromList(listValues: paraph['Hidroterapia'])}\n"
    //     "MEDICAMENTOS\n"
    //     "${Listas.stringFromList(listValues: paraph['Medicamentos'])}\n";
    //
    // if (paraph['Hemoterapia'][0] != 'Sin reposicion sanguinea.') {
    //   tipoReporte = "$tipoReporte"
    //       "HEMOTRANSFUSION\n"
    //       "${Listas.stringFromList(listValues: paraph['Hemoterapia'])}\n";
    // }
    //
    // if (paraph['Insulinoterapia'][0] != 'Sin terapia insulinica.') {
    //   tipoReporte = "$tipoReporte"
    //       "INSULINOTERAPIA\n"
    //       "${Listas.stringFromList(listValues: paraph['Insulinoterapia'])}\n";
    // }
    // if (paraph['Oxigenoterapia'][0] !=
    //     'Sin administración de oxígeno suplementario.') {
    //   tipoReporte = "$tipoReporte"
    //       "OXIGENOTERAPIA\n"
    //       "${Listas.stringFromList(listValues: paraph['Oxigenoterapia'])}\n";
    // }
    //
    // tipoReporte = "$tipoReporte"
    //     "MEDIDAS GENERALES\n"
    //     "${Listas.stringFromList(listValues: paraph['Medidas_Generales'])}\n"
    //     "PENDIENTES\n"
    //     "${Listas.stringFromList(listValues: paraph['Pendientes'])}\n"
    //     "GRACIAS\n";
    tipoReporte = "$tipoReporte"
        "${paraph['Pronostico_Medico']}";

    // if (paraph['Pronostico_Medico'] != "") {
    //   tipoReporte = "$tipoReporte\n"
    //       "${paraph['Pronostico_Medico']}";
    // }

    tipoReporte = "$tipoReporte\n\n"
        "Med. Gral. Romero Pantoja Luis Ced. Prof. 12210866 Medicina General";

    return tipoReporte;
  }

  static String reporteEvolucion(Map<String, dynamic> paraph,
      {bool esAbreviado = false}) {
    String tipoReporte = "NOTA DE EVOLUCIÓN HOSPITALARIA\n";
    tipoReporte = "$tipoReporte"
        "${paraph['Datos_Generales']}";

    tipoReporte = "$tipoReporte"
        "${paraph['Impresiones_Diagnosticas']}\n\n";

    // # # # # # # ### # # # # # # ###
    tipoReporte = "$tipoReporte"
        "S. ${paraph['Subjetivo']}";
    if (esAbreviado) {
      tipoReporte = "$tipoReporte"
          "${paraph['Signos_Vitales']}\n"
          "${paraph['Exploracion_Fisica']}\n\n";
    } else {
      tipoReporte = "$tipoReporte" //A la exploración física con: \n"
          "${paraph['Signos_Vitales']}\n"
          "${paraph['Exploracion_Fisica']}\n";
    }

    if (paraph['Auxiliares_Diagnosticos'] != "") {
      tipoReporte = "$tipoReporte"
          "${paraph['Auxiliares_Diagnosticos']}\n";
    }

    if (paraph['Analisis_Complementarios'] != "" &&
        paraph['Analisis_Complementarios'] != null) {
      tipoReporte = "$tipoReporte\nANALISIS COMPLEMENTARIOS\n"
          "${paraph['Analisis_Complementarios']}\n\n";
    }

    tipoReporte = "$tipoReporte${paraph['Analisis_Medico']}";

    if (paraph['Pronostico_Medico'] != "") {
      tipoReporte = "$tipoReporte\n"
          "${paraph['Pronostico_Medico']}";
    }

    // tipoReporte = "$tipoReporte\n\n"
    //     "Med. Gral. Romero Pantoja Luis Ced. Prof. 12210866 Medicina General";

    return tipoReporte;
  }

  static String reporteConsulta(Map<String, dynamic> paraph) {
    String tipoReporte = "NOTA DE CONSULTA EXTERNA\n";
    tipoReporte = "$tipoReporte"
        "${paraph['Datos_Generales']}";

    tipoReporte = "$tipoReporte"
        "Motivo de consulta por ${paraph['Motivo_Consulta']}\n";

    tipoReporte = "$tipoReporte"
        "Antecedentes heredofamiliares ${paraph['Antecedentes_Heredofamiliares']}\n"
        "Antecedentes hospitalarios ${paraph['Antecedentes_Hospitalarios']}\n"
        "Antecedentes alérgicos ${paraph['Antecedentes_Alergicos']}\n"
        "Antecedentes patológicos ${paraph['Antecedentes_Patologicos']}\n\n";

    // # # # # # # ### # # # # # # ###
    tipoReporte = "${tipoReporte}A la exploración física con: \n"
        "${paraph['Signos_Vitales']}\n"
        "${paraph['Exploracion_Fisica']}\n\n";

    if (paraph['Auxiliares_Diagnosticos'] != "") {
      tipoReporte = "$tipoReporte"
          "${paraph['Auxiliares_Diagnosticos']}\n\n";
    }

    if (paraph['Analisis_Complementarios'] != "" &&
        paraph['Analisis_Complementarios'] != null) {
      tipoReporte = "${tipoReporte}ANALISIS COMPLEMENTARIOS\n"
          "${paraph['Analisis_Complementarios']}\n\n";
    }

    tipoReporte = "$tipoReporte"
        "IMPRESIONES DIAGNÓSTICAS\n"
        "${paraph['Impresiones_Diagnosticas']}\n\n";

    tipoReporte = "$tipoReporte"
        "${paraph['Analisis_Medico']}\n\n";

    tipoReporte = "$tipoReporte"
        "INDICACIONES MÉDICAS\n"
        "MEDICAMENTOS\n"
        "${Listas.stringFromList(listValues: paraph['Medicamentos'])}\n"
        "LICENCIA MÉDICA\n"
        "${Listas.stringFromList(listValues: paraph['Licencia_Medica'])}\n"
        "PENDIENTES\n"
        "${Listas.stringFromList(listValues: paraph['Pendientes'])}\n"
        "CITAS\n"
        "${Listas.stringFromList(listValues: paraph['Citas'])}\n"
        "RECOMENDACIONES\n"
        "${Listas.stringFromList(listValues: paraph['Recomendaciones'])}\n";

    if (paraph['Pronostico_Medico'] != "") {
      tipoReporte = "$tipoReporte\n"
          "${paraph['Pronostico_Medico']}";
    }

    tipoReporte = "$tipoReporte\n\n"
        "Med. Gral. Romero Pantoja Luis Ced. Prof. 12210866 Medicina General";

    return tipoReporte;
  }

  static String reporteTerapia(Map<String, dynamic> paraph) {
    String tipoReporte = "NOTA DE GRAVEDAD \n";
    tipoReporte = "$tipoReporte"
        "${paraph['Datos_Generales']}";

    tipoReporte = "$tipoReporte"
        "${paraph['Impresiones_Diagnosticas']}\n\n";
    // ************************************
    // if (paraph['Eventualidades'] != "") {
    //   tipoReporte = "$tipoReporte"
    //       "${paraph['Eventualidades']}\n\n";
    // }
    // # # # # # # ### # # # # # # ###
    tipoReporte = "${tipoReporte}EXPLORACION FÍSICA\n"
        "${paraph['Exploracion_Fisica']}\n\n";

    tipoReporte = "$tipoReporte"
        "${paraph['Analisis_Terapia']}\n";

    if (paraph['Pronostico_Medico'] != "") {
      tipoReporte = "$tipoReporte"
          "${paraph['Pronostico_Medico']}";
    }
    //
    // tipoReporte = "$tipoReporte\n\n"
    //     "Med. Gral. Romero Pantoja Luis Ced. Prof. 12210866 Medicina General";

    return tipoReporte;
  }

  static String reporteRevision(Map<String, dynamic> paraph) {
    Terminal.printAlert(
        message: "${paraph['Antecedentes_Patologicos_Ingreso']}");
    //
    String tipoReporte = "NOTA DE REVISION HOSPITALARIO\n";
    tipoReporte = "${tipoReporte}DIAGNOSTICOS ACTUALES\n"
        "${paraph['Impresiones_Diagnosticas']} . ";

    tipoReporte = "$tipoReporte\n"
        "RESUMEN CLINICO\n"
        "${paraph['Datos_Generales_Simple'].substring(0, paraph['Datos_Generales_Simple'].length - 1)} ";

    // # # # # # # ### # # # # # # ###
    if (paraph['Antecedentes_Patologicos_Ingreso'] != "") {
      tipoReporte = "${tipoReporte}ANTECEDENTES: "
          "${paraph['Antecedentes_Patologicos_Ingreso']}\n";
      // "RELEVANTES. ${paraph['Antecedentes_Relevantes']}\n";
    }

    tipoReporte = "${tipoReporte}MOTIVO DE INGRESO: "
        "${paraph['Padecimiento_Actual']}\n"
        "     . Durante su estancia : \n"
        "${paraph['Hitos_Hospitalarios']}\n";

    // # # # # # # ### # # # # # # ###
    tipoReporte = "${tipoReporte}Actualmente : " //${paraph['Subjetivo']}"
        "     ${paraph['Signos_Vitales']}\n"
        "${paraph['Exploracion_Fisica']}\n\n";

    if (paraph['Auxiliares_Diagnosticos'] != "") {
      tipoReporte = "${tipoReporte}AUXILIARES DIAGNÓSTICOS\n"
          "${paraph['Auxiliares_Diagnosticos']}\n\n";
    }

    if (paraph['Analisis_Complementarios'] != "" &&
        paraph['Analisis_Complementarios'] != null) {
      tipoReporte = "${tipoReporte}ANALISIS COMPLEMENTARIOS\n"
          "${paraph['Analisis_Complementarios']}\n\n";
    }

    tipoReporte = "$tipoReporte"
        "ANÁLISIS\n"
        "${paraph['Analisis_Medico']}\n";
    //
    // tipoReporte = "$tipoReporte\n"
    //     "INDICACIONES MÉDICAS\n"
    //     "DIETAS\n"
    //     "${Listas.stringFromList(listValues: paraph['Dieta'])}\n"
    //     "SOLUCIONES PARENTERALES\n"
    //     "${Listas.stringFromList(listValues: paraph['Hidroterapia'])}\n"
    //     "MEDICAMENTOS\n"
    //     "${Listas.stringFromList(listValues: paraph['Medicamentos'])}\n";
    //
    // if (paraph['Hemoterapia'][0] != 'Sin reposicion sanguinea.') {
    //   tipoReporte = "$tipoReporte"
    //       "HEMOTRANSFUSION\n"
    //       "${Listas.stringFromList(listValues: paraph['Hemoterapia'])}\n";
    // }
    //
    // if (paraph['Insulinoterapia'][0] != 'Sin terapia insulinica.') {
    //   tipoReporte = "$tipoReporte"
    //       "INSULINOTERAPIA\n"
    //       "${Listas.stringFromList(listValues: paraph['Insulinoterapia'])}\n";
    // }
    // if (paraph['Oxigenoterapia'][0] !=
    //     'Sin administración de oxígeno suplementario.') {
    //   tipoReporte = "$tipoReporte"
    //       "OXIGENOTERAPIA\n"
    //       "${Listas.stringFromList(listValues: paraph['Oxigenoterapia'])}\n";
    // }
    //
    // tipoReporte = "$tipoReporte"
    //     "MEDIDAS GENERALES\n"
    //     "${Listas.stringFromList(listValues: paraph['Medidas_Generales'])}\n"
    //     "PENDIENTES\n"
    //     "${Listas.stringFromList(listValues: paraph['Pendientes'])}\n"
    //     "GRACIAS\n";

    if (paraph['Pronostico_Medico'] != "") {
      tipoReporte = "$tipoReporte\n"
          "${paraph['Pronostico_Medico']}";
    }

    // tipoReporte = "$tipoReporte\n\n"
    //     "Med. Gral. Romero Pantoja Luis Ced. Prof. 12210866 Medicina General";

    return tipoReporte;
  }

  static String reporteTraslado(Map<String, dynamic> paraph) {
    String tipoReporte = "";

    tipoReporte = "$tipoReporte"
        "${paraph['Datos_Generales_Simple'].substring(0, paraph['Datos_Generales_Simple'].length - 1)} ";

    // # # # # # # ### # # # # # # ###
    if (paraph['Antecedentes_Patologicos_Ingreso'] != "") {
      tipoReporte = "${tipoReporte}ANTECEDENTES: "
          "${paraph['Antecedentes_Patologicos_Ingreso']}\n";
    }

    tipoReporte = "${tipoReporte}MOTIVO DE INGRESO: "
        "${paraph['Padecimiento_Actual']}\n";

    // # # # # # # ### # # # # # # ###
    if (paraph['Motivo_Traslado'] != "") {
      tipoReporte = "$tipoReporte\n"
          "${paraph['Motivo_Traslado']}";
    }

    // tipoReporte = "$tipoReporte\n\n"
    //     "Med. Gral. Romero Pantoja Luis Ced. Prof. 12210866 Medicina General";

    return tipoReporte;
  }

  //
  static String reporteEgreso(Map<String, dynamic> paraph) {
    print(paraph);
    //
    String tipoReporte = "NOTA DE EGRESO HOSPITALARIO\n";
    tipoReporte = "${tipoReporte}DIAGNÓSTICO(s) DE EGRESO\n"
        "${paraph['Impresiones_Diagnosticas']}\n"
        "RESUMEN CLÍNICO\n"
        "${paraph['Datos_Generales']}"
        "ANTECEDENTES: ";
    // # # # # # # ### # # # # # # ###
    if (paraph['Antecedentes_Patologicos_Ingreso'] != "") {
      tipoReporte = "$tipoReporte"
          "${paraph['Antecedentes_Patologicos_Ingreso']}\n";
    }

    tipoReporte = "$tipoReporte\nMOTIVO DE INGRESO - "
        "${paraph['Padecimiento_Actual']} ";

    // # # # # # # ### # # # # # # ###
    tipoReporte = "$tipoReporte"
        "${paraph['Analisis_Medico']}\n";

    // tipoReporte = "$tipoReporte\n\n"
    //     "Med. Gral. Romero Pantoja Luis Ced. Prof. 12210866 Medicina General";

    return tipoReporte;
  }

  //
  static String reportePrequirurgica(Map<String, dynamic> paraph) {
    Terminal.printAlert(
        message: "${paraph['Antecedentes_Patologicos_Ingreso']}");
    //
    String tipoReporte = "NOTA DE REVISION HOSPITALARIO\n";

    tipoReporte = "$tipoReporte"
        "${paraph['Datos_Generales_Simple'].substring(0, paraph['Datos_Generales_Simple'].length - 1)} ";

    // # # # # # # ### # # # # # # ###
    if (paraph['Antecedentes_Patologicos_Ingreso'] != "") {
      tipoReporte = "${tipoReporte}ANTECEDENTES: "
          "${paraph['Antecedentes_Patologicos_Ingreso']}\n";
    }

    tipoReporte = "${tipoReporte}MOTIVO DE INGRESO: "
        "${paraph['Padecimiento_Actual']}\n\n";

    // # # # # # # ### # # # # # # ###
    tipoReporte =
        "${tipoReporte}A la ingreso a hospitalización de medicina interna se encuentra al paciente con: \n"
        "${paraph['Signos_Vitales']}\n"
        "${paraph['Exploracion_Fisica']}\n\n";

    if (paraph['Auxiliares_Diagnosticos'] != "") {
      tipoReporte = "${tipoReporte}AUXILIARES DIAGNÓSTICOS\n"
          "${paraph['Auxiliares_Diagnosticos']}\n\n";
    }

    if (paraph['Analisis_Complementarios'] != "") {
      tipoReporte = "${tipoReporte}ANALISIS COMPLEMENTARIOS\n"
          "${paraph['Analisis_Complementarios']}\n\n";
    }

    tipoReporte = "${tipoReporte}IMPRESIONES DIAGNÓSTICAS\n"
        "${paraph['Impresiones_Diagnosticas']}\n\n";

    tipoReporte = "$tipoReporte"
        "ANÁLISIS\n"
        "${paraph['Analisis_Medico']}\n";
    //
    // tipoReporte = "$tipoReporte\n"
    //     "INDICACIONES MÉDICAS\n"
    //     "DIETAS\n"
    //     "${Listas.stringFromList(listValues: paraph['Dieta'])}\n"
    //     "SOLUCIONES PARENTERALES\n"
    //     "${Listas.stringFromList(listValues: paraph['Hidroterapia'])}\n"
    //     "MEDICAMENTOS\n"
    //     "${Listas.stringFromList(listValues: paraph['Medicamentos'])}\n";
    //
    // if (paraph['Hemoterapia'][0] != 'Sin reposicion sanguinea.') {
    //   tipoReporte = "$tipoReporte"
    //       "HEMOTRANSFUSION\n"
    //       "${Listas.stringFromList(listValues: paraph['Hemoterapia'])}\n";
    // }
    //
    // if (paraph['Insulinoterapia'][0] != 'Sin terapia insulinica.') {
    //   tipoReporte = "$tipoReporte"
    //       "INSULINOTERAPIA\n"
    //       "${Listas.stringFromList(listValues: paraph['Insulinoterapia'])}\n";
    // }
    // if (paraph['Oxigenoterapia'][0] !=
    //     'Sin administración de oxígeno suplementario.') {
    //   tipoReporte = "$tipoReporte"
    //       "OXIGENOTERAPIA\n"
    //       "${Listas.stringFromList(listValues: paraph['Oxigenoterapia'])}\n";
    // }
    //
    // tipoReporte = "$tipoReporte"
    //     "MEDIDAS GENERALES\n"
    //     "${Listas.stringFromList(listValues: paraph['Medidas_Generales'])}\n"
    //     "PENDIENTES\n"
    //     "${Listas.stringFromList(listValues: paraph['Pendientes'])}\n"
    //     "GRACIAS\n";

    if (paraph['Pronostico_Medico'] != "") {
      tipoReporte = "$tipoReporte\n"
          "${paraph['Pronostico_Medico']}";
    }

    // tipoReporte = "$tipoReporte\n\n"
    //     "Med. Gral. Romero Pantoja Luis Ced. Prof. 12210866 Medicina General";

    return tipoReporte;
  }
}

enum TypeReportes {
  reporteEvolucion,
  reporteIngreso,
  reporteConsulta,
  reporteTipado,
  reporteTerapiaIntensiva,
  valoracionPreoperatoria,
  valoracionPrequirurgica,
  procedimientoIntubacion,
  procedimientoCVC,
  procedimientoSondaEndopleural,
  procedimientoTenckoff,
  procedimientoLumbar,
  procedimientoToracocentesis,
  indicacionesHospitalarias,
  reportePrequirurgica,
  reportePreanestesica,
  reporteEgreso,
  reporteRevision,
  reporteTraslado,
  censoHospitalario,
  reporteTransfusion,
}
