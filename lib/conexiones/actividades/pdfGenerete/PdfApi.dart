import 'dart:io';
import 'dart:typed_data';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/actividades/pdfGenerete/pdfGenereteFormats/formatosReportes.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../conexiones.dart';
import 'pdfGenereteComponents/PdfApiComponents.dart';

String? name = "assets/images/issste_logo.png";
String? escudoNacional = "assets/images/escudoNacional.jpg";
String? isssteHorizontal = "assets/images/logoIsssteHorizontal.png";
String? imssLogo = "assets/images/imss_logo.png";

class PdfApi {
  static double? height = 6;

  static Future<File> generateCenterText(String text) async {
    final pdf = Document();
    pdf.addPage(Page(
        build: (context) =>
            Center(child: Text(text, style: const TextStyle(fontSize: 18)))));
    return saveDocument(name: "my_example.pdf", pdf: pdf);
  }

  static Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    var dir, file;

    try {
      dir = await getApplicationDocumentsDirectory();
      file = File('${dir.path}/$name');
      final bytes = await pdf.save();

      await file.writeAsBytes(bytes);

      return file;
    } catch (e) {
      Alertas.showAlert(context: Contextos.contexto, error: 'Error $e');
      print('Error $e');
    } finally {
      return file;
    }
  }

  static Future<void> openFile(File pdfFile) async {
    final ur = pdfFile.path;
    // Alertas.showAlert(
    //     context: Contextos.contexto, error: 'Contenido creado $ur');
    await OpenFile.open(ur);
  }

}

class PdfParagraphsApi {
  static Future<File> generate(
      {double? topMargin = 20,
      double? rightMargin = 30,
      double? leftMargin = 30,
      double? bottomMargin = 10,
      String? imageHeader = "assets/images/issste_logo.png",
      required TypeReportes indexOfTypeReport,
      bool withIndicationReport = false,
      required Map<String, dynamic> paraph,
      String? name = "my_example.pdf"}) async {
    final pdf = Document();

    // # # # # # # # ### #  # # # # # # # ### #
    // Carga del logotipo del documento para el Header.
    Uint8List logobytes =
        (await rootBundle.load(imageHeader!)).buffer.asUint8List();
    Uint8List logoSecondbytes =
        (await rootBundle.load("assets/images/logoIsssteHorizontal.png"))
            .buffer
            .asUint8List();
    Uint8List logoShieldbytes =
        (await rootBundle.load("assets/images/logoNacional.png"))
            .buffer
            .asUint8List();

    final tempDir = await getTemporaryDirectory();
    // # # # # # # ### # # # # # # ### # # # # # # ###
    final file = await File('${tempDir.path}/logo_image.png').create();
    file.writeAsBytesSync(logobytes);
    // # # # # # # ### # # # # # # ### # # # # # # ###
    final fileSecond =
        await File('${tempDir.path}/logoIsssteHorizontal.png').create();
    fileSecond.writeAsBytesSync(logoSecondbytes);
    // # # # # # # ### # # # # # # ### # # # # # # ###
    final fileShield = await File('${tempDir.path}/logoNacional.png').create();
    fileShield.writeAsBytesSync(logoShieldbytes);
    // # # # # # # ### # # # # # # ### # # # # # # ###
    // Creación de documento en base al paraph.
    // # # # # # # ### # # # # # # ### # # # # # # ###
    try {
      print("indexOfTypeReport $indexOfTypeReport");
      pdf.addPage(MultiPage(
        margin: EdgeInsets.only(
            top: topMargin!,
            right: rightMargin!,
            left: leftMargin!,
            bottom: bottomMargin!),
        header: (context) => headerInTable(
            imageHeader: fileSecond,
            secondImageHeader: fileShield,
            titulo:
                "Instituto de Seguridad y Servicios Sociales\npara los Trabajadores\ndel Estado"
                    .toUpperCase(),
            subTitulo: "Subdelegación de Quintana Roo\nCAF Bacalar"),
        build: ((context) => FormatosReportes(
              withIndicationReport: withIndicationReport,
              indexOfReport: indexOfTypeReport,
            ).typeOfList(paraph)),
        footer: (context) {
          final text = "Pagina ${context.pageNumber} de ${context.pagesCount}";
          return Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.mm),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Divider(color: PdfColors.black),
                Text(text,
                    style: const TextStyle(fontSize: 8, color: PdfColors.black))
              ]));
        },
      ));
      return PdfApi.saveDocument(name: name!, pdf: pdf);
    } on Exception catch (e) {
      Alertas.showAlert(
          context: Contextos.contexto,
          error: "Error al generar documento PDF ${e.toString()}");
      return PdfApi.saveDocument(name: name!, pdf: pdf);
    }
  }

  static Future<File> generateFromList(
      {double? topMargin = 20,
        double? rightMargin = 30,
        double? leftMargin = 30,
        double? bottomMargin = 10,
        bool? withHeader = true,
        required List<Widget> content,
        String? imageHeader = "assets/images/issste_logo.png",
        required TypeReportes indexOfTypeReport,
        bool withIndicationReport = false,
        required List<dynamic> paraph,
        String? name = "my_example.pdf"}) async {
    final pdf = Document();

    if (content == null) {
      FormatosReportes.censoHospitalario(
          paraph);
    }
    // # # # # # # # ### #  # # # # # # # ### #
    // Carga del logotipo del documento para el Header.
    Uint8List logobytes =
    (await rootBundle.load(imageHeader!)).buffer.asUint8List();
    Uint8List logoSecondbytes =
    (await rootBundle.load("assets/images/logoIsssteHorizontal.png"))
        .buffer
        .asUint8List();
    Uint8List logoShieldbytes =
    (await rootBundle.load("assets/images/logoNacional.png"))
        .buffer
        .asUint8List();

    final tempDir = await getTemporaryDirectory();
    // # # # # # # ### # # # # # # ### # # # # # # ###
    final file = await File('${tempDir.path}/logo_image.png').create();
    file.writeAsBytesSync(logobytes);
    // # # # # # # ### # # # # # # ### # # # # # # ###
    final fileSecond =
    await File('${tempDir.path}/logoIsssteHorizontal.png').create();
    fileSecond.writeAsBytesSync(logoSecondbytes);
    // # # # # # # ### # # # # # # ### # # # # # # ###
    final fileShield = await File('${tempDir.path}/logoNacional.png').create();
    fileShield.writeAsBytesSync(logoShieldbytes);
    // # # # # # # ### # # # # # # ### # # # # # # ###
    // Creación de documento en base al paraph.
    // # # # # # # ### # # # # # # ### # # # # # # ###
    try {
      print("indexOfTypeReport $indexOfTypeReport");
      pdf.addPage(MultiPage(
        orientation: PageOrientation.landscape,
        margin: EdgeInsets.only(
            top: topMargin!,
            right: rightMargin!,
            left: leftMargin!,
            bottom: bottomMargin!),
        header: (context) => withHeader == true ? Container() : headerInTable(
    imageHeader: fileSecond,
    secondImageHeader: fileShield,
    titulo:
    "Instituto de Seguridad y Servicios Sociales\npara los Trabajadores\ndel Estado"
        .toUpperCase(),
    subTitulo: "Subdelegación de Quintana Roo\nCAF Bacalar"),
        build: ((context) => content),
        footer: (context) {
          final text = "Pagina ${context.pageNumber} de ${context.pagesCount}";
          return Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.mm),
              child:
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Divider(height: 3, color: PdfColors.black),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(
                    "Fecha: ${Calendarios.today(format: 'dd/MM/yyyy')}",
                    style: const TextStyle(fontSize: 5, color: PdfColors.black)),
                  Text(text,
                      style: const TextStyle(fontSize: 5, color: PdfColors.black))])
              ]));
        },
      ));
      return PdfApi.saveDocument(name: name!, pdf: pdf);
    } on Exception catch (e) {
      Alertas.showAlert(
          context: Contextos.contexto,
          error: "Error al generar documento PDF ${e.toString()}");
      return PdfApi.saveDocument(name: name!, pdf: pdf);
    }
  }
}
