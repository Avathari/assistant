// import 'dart:ui';
//
// import 'package:syncfusion_flutter_xlsio/xlsio.dart';
// import 'dart:io';
// import 'package:open_file/open_file.dart';
//
// class ExcelApi {
//   static Future<void> generateExcel() async {
//     //Get directory path
//     final String path = 'lib';
//     //Create a Excel document.
//
//     // Create a new Excel document.
//     final Workbook workbook = new Workbook();
//
// //Accessing worksheet via index.
//     final Worksheet sheet = workbook.worksheets[0];
//
// //Defining a global style with all properties.
//     Style globalStyle = workbook.styles.add('style');
// //set back color by hexa decimal.
//     globalStyle.backColor = '#37D8E9';
// //set font name.
//     globalStyle.fontName = 'Times New Roman';
// //set font size.
//     globalStyle.fontSize = 20;
// //set font color by hexa decimal.
//     globalStyle.fontColor = '#C67878';
// //set font italic.
//     globalStyle.italic = true;
// //set font bold.
//     globalStyle.bold = true;
// //set font underline.
//     globalStyle.underline = true;
// //set wraper text.
//     globalStyle.wrapText = true;
// //set indent value.
//     globalStyle.indent = 1;
// //set horizontal alignment type.
//     globalStyle.hAlign = HAlignType.left;
// //set vertical alignment type.
//     globalStyle.vAlign = VAlignType.bottom;
// //set text rotation.
//     globalStyle.rotation = 90;
// //set all border line style.
//     globalStyle.borders.all.lineStyle = LineStyle.thick;
// //set border color by hexa decimal.
//     globalStyle.borders.all.color = '#9954CC';
// //set number format.
//     globalStyle.numberFormat = '_(\$* #,##0_)';
//
// //Apply GlobalStyle to 'A1'.
//     sheet.getRangeByName('A1').cellStyle = globalStyle;
//
// //Defining Gloabl style.
//     globalStyle = workbook.styles.add('style1');
// //set back color by RGB value.
//     globalStyle.backColorRgb = Color.fromARGB(245, 22, 44, 144);
// //set font color by RGB value.
//     globalStyle.fontColorRgb = Color.fromARGB(255, 244, 22, 44);
//     //set border line style.
//     globalStyle.borders.all.lineStyle = LineStyle.double;
//     //set border color by RGB value.
//     globalStyle.borders.all.colorRgb = Color.fromARGB(255, 44, 200, 44);
//
//     //Apply GlobalStyle to 'A4';
//     sheet.getRangeByName('A4').cellStyle = globalStyle;
//
//     // Save the document.
//     final List<int> bytes = workbook.saveAsStream();
//     File('ApplyGlobalStyle.xlsx').writeAsBytes(bytes);
//     //Dispose the workbook.
//     workbook.dispose();
//
//     //Get the storage folder location using path_provider package.
//     // final Directory? directory = await getExternalStorageDirectory();
//     //directory!.path;
//     //Create an empty file to write Excel data
//     final File file = File('$path/output.xlsx');
//     //Write Excel data
//     await file.writeAsBytes(bytes, flush: true);
//     //Launch the file (used open_file package)
//     await OpenFile.open('$path/output.xlsx');
//   }
// }
