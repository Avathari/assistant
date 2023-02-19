import 'dart:io';

import 'package:assistant/conexiones/actividades/pdfGenerete/PdfApi.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Padding footerParagraph({String? text}) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text(text!,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
        ]),
      ]));
}

Container imageWidget(
    {String? name = "assets/images/issste_logo.png",
    bool? isNetwork = false,
    required File imageHeader,
    double? width = 70,
    double? height = 70}) {
  if (isNetwork == false) {
    return Container(
        width: width!,
        height: height!,
        child: Image(MemoryImage(imageHeader.readAsBytesSync())));
  } else {
    return Container(
        width: width!,
        height: height!,
        child: Image(MemoryImage(File(name!).readAsBytesSync())));
  }
}

Column header({required File imageHeader, String? titulo, String? subTitulo}) {
  // var valax = Container();

  return Column(children: [
    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: imageWidget(imageHeader: imageHeader)),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(titulo!,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
        //Divider(color: PdfColors.black),
        Text(subTitulo!,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.normal)),
      ]),
    ]),
    SizedBox(height: 10)
  ]);
}

Table headerInTable(
    {required File imageHeader,
    File? secondImageHeader,
    String? titulo,
    String? subTitulo}) {
  // var valax = Container();

  return Table(children: [
    TableRow(verticalAlignment: TableCellVerticalAlignment.middle, children: [
      imageWidget(imageHeader: imageHeader),
      Column(children: [
        Text(titulo!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
        Text(subTitulo!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.normal)),
      ]),
      imageWidget(imageHeader: secondImageHeader ?? imageHeader),
    ]),
    TableRow(verticalAlignment: TableCellVerticalAlignment.middle, children: [
      SizedBox(
        height: 12,
      ),
    ]),
  ]);
}

Column paragraph(
    {String? anteTexto,
    bool isBefore = false,
    String? texto,
    String? subTexto}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    isBefore
        ? RichText(
            // ignore: prefer_const_constructors
            textAlign: TextAlign.justify,
            text: TextSpan(
              style: const TextStyle(
                fontSize: 8.0,
                color: PdfColors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: anteTexto,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: texto,
                ),
                TextSpan(
                    text: subTexto,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic)),
              ],
            ))
        : Paragraph(
            text: texto!,
            textAlign: TextAlign.justify,
            margin: const EdgeInsets.only(bottom: 2.0 * PdfPageFormat.mm),
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.normal)),
    SizedBox(height: PdfApi.height),
  ]);
}

Column paragraphFromList({
  List<List>? listado,
}) {
  List<TextSpan> textSpan = [];
  for (var element in listado!) {
    textSpan.add(
      TextSpan(
          text: element[0],
          style: TextStyle(
              fontSize: 8.0,
              color: PdfColors.black,
              fontWeight: FontWeight.bold)),
    );
    textSpan.add(TextSpan(
        text: "${element[1]}. ",
        style: TextStyle(
            fontSize: 8.0,
            color: PdfColors.black,
            fontWeight: FontWeight.normal)));
  }

  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    RichText(textAlign: TextAlign.justify, text: TextSpan(children: textSpan)),
    SizedBox(height: PdfApi.height),
  ]);
}

Column paragraphSeparatedBy({
  String split = '\n',
  String comma = ':',
  String? pax,
}) {
  List<TextSpan> textSpan = [];
  //
  List aux = pax!.split(split);
  for (var element in aux) {
    var elem = element.split(comma);
    textSpan.add(
      TextSpan(
          text: "${elem[0]}$comma",
          style: TextStyle(
              fontSize: 8.0,
              color: PdfColors.black,
              fontWeight: FontWeight.bold)),
    );
    textSpan.add(TextSpan(
        text: "${elem[1]}$split",
        style: TextStyle(
            fontSize: 8.0,
            color: PdfColors.black,
            fontWeight: FontWeight.normal)));
  }

  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    RichText(textAlign: TextAlign.justify, text: TextSpan(children: textSpan)),
    SizedBox(height: 4),
  ]);
}

Column paragraphWithTittle({String? titulo, String? subTitulo}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(titulo!,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
    Paragraph(
        text: subTitulo!,
        textAlign: TextAlign.justify,
        margin: const EdgeInsets.only(bottom: 2.0 * PdfPageFormat.mm),
        style: TextStyle(fontSize: 8, fontWeight: FontWeight.normal)),
    //SizedBox(height: PdfApi.height),
  ]);
}

Row paragraphWithTittleAline({String? titulo, String? subTitulo}) {
  return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text("${titulo!}: ",
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
    Text(subTitulo!,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 8, fontWeight: FontWeight.normal)),
  ]);
}

Column paragraphWithTittleAndSeparated(
    {String? titulo, String? subTitulo, String comma = ':'}) {
  List<TextSpan> textSpan = [];

  if (subTitulo != "") {
    for (String element in subTitulo!.split('\n')) {

      var elem = element.split(comma);
      // print("Elem ${elem.length} SubTitulo $subTitulo");
      if (elem.length > 1) {
        if (elem[0] != "") {
          textSpan.add(
            TextSpan(
                text: "${elem[0]}$comma",
                style: TextStyle(
                    fontSize: 8.0,
                    color: PdfColors.black,
                    fontWeight: FontWeight.bold)),
          );
        }
        if (elem[1] != "") {
          textSpan.add(TextSpan(
              text: "${elem[1]}\n",
              style: TextStyle(
                  fontSize: 8.0,
                  color: PdfColors.black,
                  fontWeight: FontWeight.normal)));
        }
      } else {
        textSpan.add(TextSpan(
            text: "${elem[0]}\n",
            style: TextStyle(
                fontSize: 8.0,
                color: PdfColors.black,
                fontWeight: FontWeight.normal)));
      }
    }
  }

  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(titulo!,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
    RichText(textAlign: TextAlign.justify, text: TextSpan(children: textSpan)),
    SizedBox(height: PdfApi.height),
  ]);
}

Row allInOneParagraph({String? titulo, String? subTitulo}) {
  return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text("${titulo!} ",
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
    Paragraph(
        text: subTitulo!,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 8, fontWeight: FontWeight.normal)),
  ]);
}

Column paragraphWithBullets({String? titulo, String? subTitulo}) {
  if (subTitulo != "") {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(titulo!,
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
      ...buildBulletPoints(subTitulo!),
      SizedBox(height: PdfApi.height),
    ]);
  } else {
    return Column();
  }
}

Column paragraphWithDoubleBullets(
    {String? titulo, String? subTitulo, String? postTitulo}) {
  if (subTitulo != "") {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(titulo!,
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
      buildDoubleBulletPoints(subTitulo!),
      //...buildDoubleBulletPoints(postTitulo!),
      SizedBox(height: PdfApi.height),
    ]);
  } else {
    return Column();
  }
}

Column buildDoubleBulletPoints(String para) {
  // List<Widget> bullets = [];
  // Column container = Column();
  // ****************** ******* ********************* ************** ********
  String titulo = '';
  List<Widget> inBullets = [];
  // ****************** ******* ********************* ************** ********
  var aux = para.split("\n");
  titulo = aux[0];
  //
  var elementos = aux[1].split('\t');
  elementos.removeAt(0);
  // //print("para $para \nAuxiliar $aux \nElemento $element \nOtro $other");
  inBullets.clear();
  for (var element in elementos) {
    // ****************** ******* ********************* ************** ********
    inBullets.add(
      Bullet(
        text: element,
        margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
        bulletSize: 1.0 * PdfPageFormat.mm,
        bulletMargin: const EdgeInsets.only(
          top: 1.0 * PdfPageFormat.mm,
          left: 5.0 * PdfPageFormat.mm,
          right: 2.0 * PdfPageFormat.mm,
        ),
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
  //
  // print("inBullets $inBullets");
  // print("titulos $titulo");
  //
  return Column(children: [
    Bullet(
      text: titulo,
      margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
      bulletSize: 1.0 * PdfPageFormat.mm,
      bulletMargin: const EdgeInsets.only(
        top: 1.0 * PdfPageFormat.mm,
        left: 5.0 * PdfPageFormat.mm,
        right: 2.0 * PdfPageFormat.mm,
      ),
      style: TextStyle(
        fontSize: 8,
        fontWeight: FontWeight.normal,
      ),
    ),
    Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          children: inBullets,
        ))
  ]);
}

Column buildListado(
    String? titulo, List<String> titulos, List<List> contenidos) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(titulo!,
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
      buildInnerPoints(titulos, contenidos, ""),
      SizedBox(height: 12),
    ],
  );
}

Column buildInnerPoints(
    List<String> titulos, List<List> contenidos, String para) {
  // * * * ******* * * *  *    * * * ******* * * *
  List<Widget> bullets = [];
  List<List<Widget>> inBullets = [];
  // * * * ******* * * *  *    * * * ******* * * *
  for (var i = 0; i < titulos.length; i++) {
    inBullets.add([]);
  }
  // * * * ******* * * *  *    * * * ******* * * *
  for (var i = 0; i < titulos.length; i++) {
    for (var element in contenidos[i]) {
      inBullets[i].add(
        Bullet(
          text: element,
          margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
          bulletSize: 1.0 * PdfPageFormat.mm,
          bulletMargin: const EdgeInsets.only(
            top: 1.0 * PdfPageFormat.mm,
            left: 5.0 * PdfPageFormat.mm,
            right: 2.0 * PdfPageFormat.mm,
          ),
          style: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.normal,
          ),
        ),
      );
    }
    // * * * ******* * * *  *    * * * ******* * * *
    bullets.add(
      Column(children: [
        Bullet(
          text: titulos[i],
          margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
          bulletSize: 1.0 * PdfPageFormat.mm,
          bulletMargin: const EdgeInsets.only(
            top: 1.0 * PdfPageFormat.mm,
            left: 5.0 * PdfPageFormat.mm,
            right: 2.0 * PdfPageFormat.mm,
          ),
          style: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              children: inBullets[i],
            )),
      ]),
    );
  }
  return Column(children: bullets);
}

List<Widget> buildBulletPoints(String para) {
  List<Widget> bullets = [];
  var aux = para.split("\n");

  for (var element in aux) {
    bullets.add(Bullet(
        text: element,
        margin: const EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
        bulletSize: 1.0 * PdfPageFormat.mm,
        bulletMargin: const EdgeInsets.only(
          top: 1.0 * PdfPageFormat.mm,
          left: 5.0 * PdfPageFormat.mm,
          right: 2.0 * PdfPageFormat.mm,
        ),
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.normal,
        )));
  }
  return bullets;
}

Padding textTittle(String label) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Text(label,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 6, fontWeight: FontWeight.bold)),
  );
}

Padding textBoldTittle(String label) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Text(label,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 6, fontWeight: FontWeight.bold)),
  );
}

Padding textLabel(String label) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Text(label,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 6, fontWeight: FontWeight.normal)),
  );
}

Padding textTittleWithLabel({String? tittle, String? label}) {
  return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(tittle ?? "",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 6, fontWeight: FontWeight.bold)),
        Text(label ?? "",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 6, fontWeight: FontWeight.normal)),
      ]));
}
