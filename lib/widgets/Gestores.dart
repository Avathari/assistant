// import 'package:assistant/conexiones/auxiliares/auxiliares.dart';
// import 'package:assistant/conexiones/usuarios/Pacientes.dart';
// import 'package:assistant/screens/operadores/Cie.dart';
// import 'package:assistant/screens/pacientes/pacientes.dart';
// import 'package:assistant/values/SizingInfo.dart';
// import 'package:assistant/values/Strings.dart';
// import 'package:assistant/values/WidgetValues.dart';
// import 'package:assistant/widgets/CrossLine.dart';
// import 'package:assistant/widgets/EditTextArea.dart';
// import 'package:assistant/widgets/GrandButton.dart';
// import 'package:assistant/widgets/GrandIcon.dart';
// import 'package:assistant/widgets/Spinner.dart';
// import 'package:assistant/widgets/WidgetsModels.dart';
// import 'package:flutter/material.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// import '../../../conexiones/conexiones.dart';

// class OperacionesActivity extends StatefulWidget {
//   String? appBarTitile = "Gestión de Activity";
//   String? consultIdQuery;
//   String? registerQuery;
//   String? updateQuery;
//   //
//   int? idOperation;
//   String? operationActivity;
//   void Function()? initialValues;
//   List<Widget> Function(BuildContext)? components;
//   List<dynamic>? listOfValues;

//   //
//   String _operationButton = 'Nulo';
  
//   Widget? activityOnClose;

//   OperacionesActivity(
//       {Key? key,
//       this.appBarTitile,
//       required this.consultIdQuery,
//       required this.registerQuery,
//       required this.updateQuery,
//       required this.listOfValues,
//       required this.activityOnClose,
//       this.operationActivity = Constantes.Nulo})
//       : super(key: key) {
//     throw UnimplementedError();
//   }

//   @override
//   State<OperacionesActivity> createState() => _OperacionesActivityState();
// }

// class _OperacionesActivityState extends State<OperacionesActivity> {
//   int idOperation = 0;

//   //
//   var gestionScroller = ScrollController();

//   @override
//   void initState() {
//     //
//     switch (widget.operationActivity) {
//       case Constantes.Nulo:
//         break;
//       case Constantes.Consult:
//         break;
//       case Constantes.Register:
//         widget._operationButton = 'Registrar';

//         break;
//       case Constantes.Update:
//         setState(() {
//           widget._operationButton = 'Actualizar';
//           idOperation = widget.idOperation!;

//           widget.initialValues!();
//         });
//         super.initState();
//         break;
//       default:
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: isMobile(context)
//           ? AppBar(
//               backgroundColor: Theming.primaryColor,
//               title: Text(widget.appBarTitile!),
//               leading: IconButton(
//                 icon: const Icon(
//                   Icons.arrow_back,
//                 ),
//                 tooltip: Sentences.regresar,
//                 onPressed: () {
//                   onClose(context);
//                 },
//               ))
//           : null,
//       body: Card(
//         color: const Color.fromARGB(255, 61, 57, 57),
//         child: Column(
//           children: [
//             Expanded(
//               flex: 3,
//               child: SingleChildScrollView(
//                   controller: gestionScroller,
//                   child: Column(
//                     children: widget.components!(context),
//                   )),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             GrandButton(
//                 labelButton: widget._operationButton,
//                 onPress: () {
//                   operationMethod(context);
//                 })
//           ],
//         ),
//       ),
//     );
//   }

//   // List<Widget> component(BuildContext context) {
//   //   return [
//   //     Spinner(
//   //         tittle: "¿Diagnóstico actual?",
//   //         onChangeValue: (String value) {
//   //           setState(() {
//   //             isActualDiagoValue = value;
//   //           });
//   //         },
//   //         items: Dicotomicos.dicotomicos(),
//   //         initialValue: isActualDiagoValue),
//   //     Row(
//   //       children: [
//   //         Expanded(
//   //           flex: 2,
//   //           child: EditTextArea(
//   //             keyBoardType: TextInputType.text,
//   //             inputFormat: MaskTextInputFormatter(),
//   //             numOfLines: 1,
//   //             labelEditText: 'Diagnóstico (CIE)',
//   //             textController: cieDiagnoTextController,
//   //           ),
//   //         ),
//   //         GrandIcon(
//   //           labelButton: "CIE-10",
//   //           weigth: 5,
//   //           onPress: () {
//   //             cieDialog();
//   //           },
//   //         ),
//   //       ],
//   //     ),
//   //     EditTextArea(
//   //       keyBoardType: TextInputType.text,
//   //       inputFormat: MaskTextInputFormatter(),
//   //       labelEditText: 'Comentario de diagnóstico',
//   //       textController: comenDiagnoTextController,
//   //       numOfLines: 1,
//   //     ),
//   //     EditTextArea(
//   //       keyBoardType: TextInputType.number,
//   //       inputFormat: MaskTextInputFormatter(
//   //           mask: '##',
//   //           filter: {"#": RegExp(r'[0-9]')},
//   //           type: MaskAutoCompletionType.lazy),
//   //       labelEditText: 'Años de diagnóstico',
//   //       textController: ayoDiagoTextController,
//   //       numOfLines: 1,
//   //     ),
//   //     CrossLine(),
//   //     Spinner(
//   //         tittle: "¿Tratamiento actual?",
//   //         onChangeValue: (String value) {
//   //           setState(() {
//   //             isTratamientoDiagoValue = value;
//   //             if (value == Dicotomicos.dicotomicos()[0]) {
//   //               tratamientoTextController.text = "";
//   //             } else {
//   //               tratamientoTextController.text = "Sin tratamiento actual";
//   //             }
//   //           });
//   //         },
//   //         items: Dicotomicos.dicotomicos(),
//   //         initialValue: isTratamientoDiagoValue),
//   //     EditTextArea(
//   //       keyBoardType: TextInputType.text,
//   //       inputFormat: MaskTextInputFormatter(),
//   //       labelEditText: 'Comentario del tratamiento',
//   //       textController: tratamientoTextController,
//   //       numOfLines: 3,
//   //     ),
//   //     CrossLine(),
//   //     Spinner(
//   //         tittle: "¿Suspensión reciente?",
//   //         onChangeValue: (String value) {
//   //           setState(() {
//   //             isSuspendTratoValue = value;
//   //             if (value == Dicotomicos.dicotomicos()[0]) {
//   //               suspensionesTextController.text =
//   //                   "Con suspensiones en el tratamiento";
//   //             } else {
//   //               suspensionesTextController.text =
//   //                   "Sin suspensiones en el tratamiento";
//   //             }
//   //           });
//   //         },
//   //         items: Dicotomicos.dicotomicos(),
//   //         initialValue: isSuspendTratoValue),
//   //     EditTextArea(
//   //       keyBoardType: TextInputType.text,
//   //       inputFormat: MaskTextInputFormatter(),
//   //       labelEditText: 'Comentario de la suspensión',
//   //       textController: suspensionesTextController,
//   //       numOfLines: 3,
//   //     ),
//   //   ];
//   // }

//   void operationMethod(BuildContext context) {
//     try {
//       print(
//           "${widget.operationActivity} listOfValues ${widget.listOfValues} ${widget.listOfValues!.length}");

//       switch (widget.operationActivity) {
//         case Constantes.Nulo:
//           // ******************************************** *** *
//           widget.listOfValues!.removeAt(0);
//           widget.listOfValues!.removeLast();
//           // ******************************************** *** *
//           Actividades.registrar(Databases.siteground_database_regpace,
//               widget.registerQuery!, widget.listOfValues!.removeLast());
//           break;
//         case Constantes.Consult:
//           break;
//         case Constantes.Register:
//           // ******************************************** *** *
//           widget.listOfValues!.removeAt(0);
//           widget.listOfValues!.removeLast();
//           // ******************************************** *** *
//           Actividades.registrar(Databases.siteground_database_regpace,
//                   widget.registerQuery!, widget.listOfValues!)
//               .then((value) => Actividades.consultarAllById(
//                           Databases.siteground_database_regpace,
//                           widget.consultIdQuery!,
//                           Pacientes.ID_Paciente) // idOperation)
//                       .then((value) {
//                     // ******************************************** *** *
//                     Pacientes.Activity = value;
//                     Constantes.reinit(value: value);
//                     // ******************************************** *** *
//                   }).then((value) => onClose(context)));
//           break;
//         case Constantes.Update:
//           Actividades.actualizar(Databases.siteground_database_regpace,
//                   widget.updateQuery!, widget.listOfValues!, idOperation)
//               .then((value) => Actividades.consultarAllById(
//                           Databases.siteground_database_regpace,
//                           widget.consultIdQuery!,
//                           Pacientes.ID_Paciente) // idOperation)
//                       .then((value) {
//                     // ******************************************** *** *
//                     Pacientes.Activity = value;
//                     Constantes.reinit(value: value);
//                     // ******************************************** *** *
//                   }).then((value) => onClose(context)));
//           break;
//         default:
//       }
//     } catch (ex) {
//       showDialog(
//           context: context,
//           builder: (context) {
//             return alertDialog("Error al operar con los valores", "$ex", () {
//               Navigator.of(context).pop();
//             }, () {});
//           });
//     }
//   }

//   void onClose(BuildContext context) {
//     switch (isMobile(context)) {
//       case true:
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 // maintainState: false,
//                 builder: (context) => widget.activityOnClose!));
//         break;
//       case false:
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 // maintainState: false,
//                 builder: (context) => widget.activityOnClose!));
//         break;
//       default:
//     }
//   }

//   cieDialog() {
//     showDialog(
//         useSafeArea: true,
//         context: context,
//         builder: (context) {
//           return Dialog(
//               child: CieSelector(
//             keyMapSearch: 'Diagnostico_CIE',
//             onSelected: ((value) {
//               setState(() {
//                 Activity.selectedDiagnosis = value;
//                 cieDiagnoTextController.text = Activity.selectedDiagnosis;
//               });
//             }),
//           ));
//         });
//   }
// }

// class GestionActivity extends StatefulWidget {
//   Widget? actualSidePage = Container();
//   // ****************** *** ****** **************
//   var keySearch = "Pace_APP_DEG";
//   // ****************** *** ****** **************

//   GestionActivity({Key? key, this.actualSidePage}) : super(key: key);

//   @override
//   State<GestionActivity> createState() => _GestionActivityState();
// }

// class _GestionActivityState extends State<GestionActivity> {
//   String appTittle = "Gestion de patologías del paciente";
//   String searchCriteria = "Buscar por Fecha";
//   String? consultQuery = Activity.patologicos['consultIdQuery'];

//   late List? foundedItems = [];
//   var gestionScrollController = ScrollController();
//   var searchTextController = TextEditingController();

//   @override
//   void initState() {
//     print(" . . . Iniciando array ");
//     if (Constantes.dummyArray![0] == "Vacio") {
//       Actividades.consultarAllById(Databases.siteground_database_regpace,
//               consultQuery!, Pacientes.ID_Paciente)
//           .then((value) {
//         setState(() {
//           print(" . . . Buscando items \n");
//           foundedItems = value;
//         });
//       });
//     } else {
//       print(" . . . Dummy array iniciado");
//       foundedItems = Constantes.dummyArray;
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//           backgroundColor: Theming.primaryColor,
//           leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back,
//             ),
//             tooltip: Sentences.regresar,
//             onPressed: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => VisualPacientes(actualPage: 2)));
//             },
//           ),
//           title: Text(appTittle),
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(
//                 Icons.replay_outlined,
//               ),
//               tooltip: Sentences.reload,
//               onPressed: () {
//                 // _pullListRefresh();
//               },
//             ),
//             IconButton(
//               icon: const Icon(
//                 Icons.add_card,
//               ),
//               tooltip: Sentences.add_vitales,
//               onPressed: () {
//                 toOperaciones(context, Constantes.Register);
//               },
//             ),
//           ]),
//       body: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//         Expanded(
//           child: Column(
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                       onChanged: (value) {
//                         _runFilterSearch(value);
//                       },
//                       controller: searchTextController,
//                       autofocus: false,
//                       keyboardType: TextInputType.text,
//                       autocorrect: true,
//                       obscureText: false,
//                       style: const TextStyle(
//                         color: Colors.white,
//                       ),
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                         helperStyle: const TextStyle(
//                           color: Colors.white,
//                         ),
//                         labelText: searchCriteria,
//                         labelStyle: const TextStyle(
//                           color: Colors.white,
//                         ),
//                         contentPadding: const EdgeInsets.all(20),
//                         enabledBorder: const OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(color: Colors.white, width: 0.5),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(20))),
//                         focusColor: Colors.white,
//                         suffixIcon: IconButton(
//                           icon: const Icon(
//                             Icons.replay_outlined,
//                             color: Colors.white,
//                           ),
//                           tooltip: Sentences.reload,
//                           onPressed: () {
//                             _pullListRefresh();
//                           },
//                         ),
//                       )),
//                 ),
//               ),
//               Expanded(
//                 flex: 9,
//                 child: RefreshIndicator(
//                   color: Colors.white,
//                   backgroundColor: Colors.black,
//                   onRefresh: _pullListRefresh,
//                   child: FutureBuilder<List>(
//                     initialData: foundedItems!,
//                     future: Future.value(foundedItems!),
//                     builder: (context, AsyncSnapshot snapshot) {
//                       if (snapshot.hasError) print(snapshot.error);
//                       return snapshot.hasData
//                           ? ListView.builder(
//                               controller: gestionScrollController,
//                               shrinkWrap: true,
//                               itemCount: snapshot.data == null
//                                   ? 0
//                                   : snapshot.data.length,
//                               itemBuilder: (context, posicion) {
//                                 return itemListView(
//                                     snapshot, posicion, context);
//                               },
//                             )
//                           : Center(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const CircularProgressIndicator(),
//                                   const SizedBox(height: 50),
//                                   Text(
//                                     snapshot.hasError
//                                         ? snapshot.error.toString()
//                                         : snapshot.error.toString(),
//                                     style: const TextStyle(
//                                         color: Colors.white, fontSize: 10),
//                                   ),
//                                 ],
//                               ),
//                             );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         isTabletAndDesktop(context)
//             ? widget.actualSidePage != null
//                 ? Expanded(flex: 1, child: widget.actualSidePage!)
//                 : Expanded(flex: 1, child: Container())
//             : Container()
//       ]),
//     );
//   }

//   Container itemListView(
//       AsyncSnapshot snapshot, int posicion, BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(2.0),
//       child: GestureDetector(
//         onTap: () {
//           onSelected(snapshot, posicion, context, Constantes.Update);
//         },
//         child: Card(
//           color: const Color.fromARGB(255, 54, 50, 50),
//           child: Container(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "ID : ${snapshot.data[posicion]['ID_PACE_APP_DEG'].toString()}",
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.grey,
//                                 fontSize: 12),
//                           ),
//                           Text(
//                             "${snapshot.data[posicion]['Pace_APP_DEG']}",
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.grey,
//                                 fontSize: 14),
//                           ),
//                           Text(
//                             "${snapshot.data[posicion]['Pace_APP_DEG_com']}",
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.grey,
//                                 fontSize: 14),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         IconButton(
//                           color: Colors.grey,
//                           icon: const Icon(Icons.update_rounded),
//                           onPressed: () {
//                             //
//                             onSelected(
//                                 snapshot, posicion, context, Constantes.Update);
//                           },
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         IconButton(
//                           color: Colors.grey,
//                           icon: const Icon(Icons.delete),
//                           onPressed: () {
//                             showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return alertDialog(
//                                     'Eliminar registro',
//                                     '¿Esta seguro de querer eliminar el registro?',
//                                     () {
//                                       closeDialog(context);
//                                     },
//                                     () {
//                                       deleteRegister(
//                                           snapshot, posicion, context);
//                                     },
//                                   );
//                                 });
//                           },
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void onSelected(AsyncSnapshot<dynamic> snapshot, int posicion,
//       BuildContext context, String operaciones) {
//     Activity.Degenerativos = snapshot.data[posicion];
//     Activity.selectedDiagnosis = Activity.Degenerativos['Pace_APP_DEG'];
//     Pacientes.Activity = snapshot.data;
//     //
//     toOperaciones(context, operaciones);
//   }

//   void closeDialog(BuildContext context) {
//     Navigator.of(context).pop();
//   }

//   void deleteRegister(
//       AsyncSnapshot<dynamic> snapshot, int posicion, BuildContext context) {
//     try {
//       Actividades.eliminar(
//           Databases.siteground_database_regpace,
//           Activity.patologicos['deleteQuery'],
//           snapshot.data[posicion]['ID_PACE_APP_DEG']);
//       setState(() {
//         snapshot.data.removeAt(posicion);
//       });
//     } finally {
//       Navigator.of(context).pop();
//     }
//   }

//   void toOperaciones(BuildContext context, String operationActivity) {
//     if (isMobile(context)) {
//       Navigator.of(context).push(MaterialPageRoute(
//           builder: (BuildContext context) => OperacionesActivity(
//                 operationActivity: operationActivity,
//               )));
//     } else {
//       Constantes.operationsActividad = operationActivity;
//       Constantes.dummyArray = foundedItems!;
//       _pullListRefresh();
//     }
//   }

//   void _runFilterSearch(String enteredKeyword) {
//     List? results = [];

//     if (enteredKeyword.isEmpty) {
//       _pullListRefresh();
//     } else {
//       Actividades.consultar(
//               Databases.siteground_database_regpace, consultQuery!)
//           .then((value) {
//         results = value
//             .where((user) => user[widget.keySearch].contains(enteredKeyword))
//             .toList();

//         setState(() {
//           foundedItems = results;
//         });
//       });
//     }
//   }

//   Future<Null> _pullListRefresh() async {
//     Navigator.pushReplacement(
//         context,
//         PageRouteBuilder(
//             pageBuilder: (a, b, c) => GestionActivity(
//                   actualSidePage: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: OperacionesActivity(
//                       operationActivity: Constantes.operationsActividad,
//                     ),
//                   ),
//                 ),
//             transitionDuration: const Duration(seconds: 0)));
//   }
// }
