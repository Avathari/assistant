import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/actividades/pdfGenerete/pdfGenereteComponents/PdfApiComponents.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

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
  indicacionesHospitalarias
}

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
      reporteEvolucion(paraph), // 0 : Ingreso
      reporteEvolucion(paraph), // 1 : Evolución
      reporteConsulta(paraph), // 2 : Consulta
      reporteConsultaTipado(paraph), // 3 : Consulta Tipada
      indicacionesHospitalVertical(paraph), // 4 : Indicaciones Hospitalarias
    ];
    print("FormatosReportes.indexOfReport! ${FormatosReportes.indexOfReport!}");

    if (withIndicationReport!) {
      return list[4];
    } else {
      switch (FormatosReportes.indexOfReport) {
        case TypeReportes.reporteIngreso:
          return list[0];
        case TypeReportes.reporteEvolucion:
          return list[1];
        case TypeReportes.reporteConsulta:
          return list[2];
        case TypeReportes.reporteTipado:
          return list[3];
        case TypeReportes.indicacionesHospitalarias:
          return list[4];

        default:
          return list[1];
      }
    }
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
    if (paraph['Pronostico_Medico'] != "") {
      parax.add(paragraphSeparatedBy(
        pax: "${paraph['Pronostico_Medico']}",
      ));
    }
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
        paraph['Licencia_Medica'],
        paraph['Pendientes'],
        paraph['Citas'],
        paraph['Recomendaciones'],
      ],
    ));

    parax.add(paragraph(
      texto: "${paraph['Analisis_Medico']}",
    ));
    if (paraph['Pronostico_Medico'] != "") {
      parax.add(paragraphSeparatedBy(
        pax: "${paraph['Pronostico_Medico']}",
      ));
    }
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
              decoration: BoxDecoration(),
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
                    label: '${Valores.imc.toStringAsFixed(2)} Kg/m2'),
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
        paraph['Licencia_Medica'],
        paraph['Pendientes'],
        paraph['Citas'],
        paraph['Recomendaciones'],
      ],
    ));

    parax.add(paragraph(
      texto: "${paraph['Analisis_Medico']}",
    ));
    if (paraph['Pronostico_Medico'] != "") {
      parax.add(paragraphSeparatedBy(
        pax: "${paraph['Pronostico_Medico']}",
      ));
    }
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
              decoration: BoxDecoration(),
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
                    label: '${Valores.imc.toStringAsFixed(2)} Kg/m2'),
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
                decoration: BoxDecoration(),
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
              decoration: BoxDecoration(),
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
                    label: '${Valores.imc.toStringAsFixed(2)} Kg/m2'),
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
      paraph['Hidroterapia'],
      paraph['Medicamentos'],
      paraph['Pendientes'],
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
      'Liquidos parenterales',
      'Medicamentos',
      'Medidas Generales',
      'Pendientes',
    ];
    List<List<dynamic>> contents = [
      paraph['Hidroterapia'],
      paraph['Medicamentos'],
      paraph['Medidas_Generales'],
      paraph['Pendientes'],
    ];
    // # # # # # # ### # # # # # # ###
    print("paraph['Oxigenoterapia'] ${paraph['Oxigenoterapia']}\n"
        "paraph['Insulinoterapia'] ${paraph['Insulinoterapia']}\n"
        "paraph['Hemoterapia'] ${paraph['Hemoterapia']}\n");
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
      ]),
    ));
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
              decoration: BoxDecoration(),
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
                    label: '${Valores.imc.toStringAsFixed(2)} Kg/m2'),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                textTittleWithLabel(tittle: "Observaciones: ", label: ''),
              ]),
        ]);
  }
}
