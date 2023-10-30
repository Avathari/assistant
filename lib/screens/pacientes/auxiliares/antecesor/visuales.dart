import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/dashboard.dart';
import 'package:assistant/screens/pacientes/auxiliares/hospitalarios/hospitalizados.dart';
import 'package:assistant/screens/pacientes/auxiliares/presentaciones/antecedentesPersonales.dart';

import 'package:assistant/screens/pacientes/auxiliares/presentaciones/presentaciones.dart';
import 'package:assistant/screens/pacientes/auxiliares/revisiones/generales.dart';
import 'package:assistant/screens/pacientes/auxiliares/revisiones/revisiones.dart';
import 'package:assistant/screens/pacientes/epidemiologicos/licencias.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/hospitalizacion.dart';
import 'package:assistant/screens/pacientes/intensiva/herramientas.dart';
import 'package:assistant/screens/pacientes/pacientes.dart';
import 'package:assistant/screens/pacientes/paraclinicos/paraclinicos.dart';
import 'package:assistant/screens/pacientes/reportes/reportes.dart';

import 'package:assistant/screens/pacientes/vitales/vitales.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/WidgetsModels.dart';

import 'package:assistant/conexiones/conexiones.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';
import 'package:assistant/screens/pacientes/auxiliares/revisiones/revisorios.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/diagnosticados.dart';
import 'package:assistant/screens/pacientes/intensiva/contenidos/balances.dart';
import 'package:assistant/screens/pacientes/intensiva/contenidos/concentraciones.dart';
import 'package:assistant/screens/pacientes/paraclinicos/auxiliares/conmutadorParaclinicos.dart';
import 'package:assistant/screens/pacientes/paraclinicos/operadores/laboratorios.dart';
import 'package:assistant/screens/pacientes/patologicos/epidemiologicos.dart';
import 'package:assistant/screens/pacientes/patologicos/patologicos.dart';

// ignore: must_be_immutable
class VisualPacientes extends StatefulWidget {
  int actualPage = 6;

  VisualPacientes({Key? key, required this.actualPage}) : super(key: key);

  @override
  State<VisualPacientes> createState() => _VisualPacientesState();
}

class _VisualPacientesState extends State<VisualPacientes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer:
          isMobile(context) || isTablet(context) ? drawerHome(context) : null,
      appBar: AppBar(
          foregroundColor: Colors.white,
          //shape: CircularShapeBorder(),
          leading: isDesktop(context)
              ? IconButton(
                  icon: const Icon(
                    color: Colors.white,
                    Icons.arrow_back,
                  ),
                  tooltip: 'Regresar',
                  onPressed: () {
                    cerrarCasoPaciente();
                  },
                )
              : null,
          backgroundColor: Colors.black,
          centerTitle: true,
          toolbarHeight: 80.0,
          elevation: 0,
          title: CircleIcon(
              iconed: Icons.person,
              tittle: Sentences.app_bar_usuarios,
              onChangeValue: () {}),
          actions: <Widget>[
            isMobile(context)
                ? Container()
                : IconButton(
                    icon: const Icon(
                      color: Colors.white,
                      Icons.account_tree,
                    ),
                    tooltip: 'Revisiones . . . ',
                    onPressed: () {
                      setState(() {
                        widget.actualPage = 11;
                      });
                    },
                  ),
            //
            // IconButton(
            //   icon: const Icon(
            //     Icons.question_answer,
            //   ),
            //   tooltip: 'Mensajería',
            //   onPressed: () {
            //     showDialog(
            //         context: context,
            //         builder: (context) {
            //           return alertDialog("Manejo de registro",
            //               "El registro ha sido actualizado / creado", () {
            //                 Navigator.of(context).pop();
            //               }, () {});
            //         });
            //   },
            // ),
            // IconButton(
            //     icon: const Icon(
            //       Icons.safety_check,
            //     ),
            //     tooltip: '',
            //     onPressed: () {
            //       showDialog(
            //           context: context,
            //           builder: ((context) {
            //             return emergentDialog(
            //                 context, Phrases.demoTittle, Phrases.demoPhrase,
            //                     () {
            //                   Navigator.of(context).pop();
            //                 });
            //           }));
            //     }),
            IconButton(
                icon: const Icon(
                  Icons.image_outlined,
                  color: Colors.white,
                ),
                tooltip: '',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return imageDialog(
                            Pacientes.nombreCompleto, Pacientes.imagenPaciente,
                            () {
                          Navigator.of(context).pop();
                        });
                      });
                }),
          ]),
      body:
          isMobile(context) || isTablet(context) ? mobileView() : desktopView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: isDesktop(context) || isLargeDesktop(context)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: floatingWidgets(context))
          : FloatingActionButton(
              backgroundColor: Theming.terciaryColor,
              child: const Icon(Icons.filter_list, color: Colors.grey),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: Theming.cuaternaryColor,
                    builder: (BuildContext context) {
                      return modalBottomPanel(context);
                    });
              },
            ),
    );
  }

  Row mobileView() {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        flex: 0,
        child: Container(),
      ),
      Expanded(flex: 4, child: pantallasAuxiliares(widget.actualPage)),
    ]);
  }

  Row desktopView() {
    return Row(children: [
      Expanded(
        flex: isLargeDesktop(context) ? 3 : 2,
        child: isTablet(context)
            ? sideBarTablet(context)
            : sideBarDesktop(context),
      ),
      Expanded(
          flex: isLargeDesktop(context) ? 14 : 7,
          child: pantallasAuxiliares(widget.actualPage)),
    ]);
  }

  void toNextScreen({context, int? index, screen}) {
    if (isMobile(context) || isTablet(context)) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
    } else {
      setState(() {
        widget.actualPage = index!;
      });
    }
  }

  void cerrarCasoPaciente() {
    Pacientes.close();
    Reportes.close();

    if (Directrices.coordenada!) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Hospitalizados()));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const GestionPacientes()));
    }
  }

  Drawer drawerHome(BuildContext context) {
    return Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        ),
        backgroundColor: Colores.backgroundWidget,
        child: Column(
          children: [
            const Expanded(
              flex: 3,
              child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.black),
                  child: PresentacionPacientes()),
            ),
            Expanded(
              flex: 8,
              child: Container(
                decoration: const BoxDecoration(color: Theming.terciaryColor),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: userActivities(context),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Column sideBarDesktop(BuildContext context) {
    return Column(
      children: [
        Container(color: Colors.black, child: const PresentacionPacientes()),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(color: Theming.terciaryColor),
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: userActivities(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container sideBarTablet(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: ListView(
        controller: scrollListController,
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(color: Colors.black),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  isTabletAndDesktop(context)
                      ? const PresentacionPacientes()
                      : Container(),
                ]),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: const BoxDecoration(color: Theming.terciaryColor),
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: userActivities(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pantallasAuxiliares(int actualPage) {
    var list = [
      Dashboard(),
      OperacionesPacientes(operationActivity: Constantes.Update),
      const MenuPersonales(),
      const GestionVitales(),
      const Center(
        child: Text('Body 3'),
      ),
      const Paraclinicos(),
      Intensiva(), // Analisis(),
      ReportesMedicos(),
      // GestionBalances(),
      const Center(
        child: Text('Body 7'),
      ),
      GestionHospitalizaciones(),
      GestionLicencia(),
      Container(margin: const EdgeInsets.all(10), child: Revisiones()),
      const Center(
        child: Text('Body 10'),
      )
    ];
    return list[actualPage];
  }

  List<Widget> userActivities(BuildContext context) {
    return [
      ListTile(
        leading: const Icon(
          Icons.dashboard,
          color: Colors.grey,
        ),
        title: const Text('Dashboard',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          if (isMobile(context) || isTablet(context)) {
            Navigator.of(context).pop();
          }
          // Update the state of the app
          setState(() {
            widget.actualPage = 0;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.person,
          color: Colors.grey,
        ),
        title: const Text(
          'Datos Generales',
          style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey),
        ),
        onTap: () {
          if (isMobile(context) || isTablet(context)) {
            Navigator.of(context).pop();
          }
          // Update the state of the app
          toNextScreen(
              context: context,
              index: 1,
              screen: OperacionesPacientes(
                operationActivity: Constantes.Update,
              ));
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.family_restroom,
          color: Colors.grey,
        ),
        title: const Text('Antecedentes Personales',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          // Update the state of the app
          if (isMobile(context) || isTablet(context)) {
            Navigator.of(context).pop();
          }
          setState(() {
            widget.actualPage = 2;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.medical_information,
          color: Colors.grey,
        ),
        title: const Text('Registro de Signos Vitales',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          if (isMobile(context) || isTablet(context)) {
            Navigator.of(context).pop();
          }
          // Update the state of the app
          toNextScreen(
              context: context, index: 3, screen: const GestionVitales());
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.segment_rounded,
          color: Colors.grey,
        ),
        title: const Text('Registro de Consultas',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          if (isMobile(context) || isTablet(context)) {
            Navigator.of(context).pop();
          }
          // Update the state of the app
          setState(() {
            widget.actualPage = 4;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.account_tree_outlined,
          color: Colors.grey,
        ),
        title: const Text('Auxiliares Diagnósticos',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          if (isMobile(context) || isTablet(context)) {
            Navigator.of(context).pop();
          }
          setState(() {
            widget.actualPage = 5;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.schema_outlined,
          color: Colors.grey,
        ),
        title: const Text('Herramientas de Terapia Intensiva',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          if (isMobile(context) || isTablet(context)) {
            Navigator.of(context).pop();
          }
          // Update the state of the app
          setState(() {
            widget.actualPage = 6;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.bookmarks_outlined,
          color: Colors.grey,
        ),
        title: const Text('Reportes y Notas Médicas',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ReportesMedicos()));
          // Pacientes.loadingActivity(context: context).then((value) {
          //   if (value == true) {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => ReportesMedicos()));
          //   }
          // });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.file_present_sharp,
          color: Colors.grey,
        ),
        title: const Text('Archivos y Documentos',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          if (isMobile(context) || isTablet(context)) {
            Navigator.of(context).pop();
          }
          // Update the state of the app
          setState(() {
            widget.actualPage = 8;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.medical_services_outlined,
          color: Colors.grey,
        ),
        title: const Text('Registro de Hospitalización',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          if (isMobile(context) || isTablet(context)) {
            Navigator.of(context).pop();
          }
          // Update the state of the app
          toNextScreen(
              context: context, index: 9, screen: GestionHospitalizaciones());
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.book_outlined,
          color: Colors.grey,
        ),
        title: const Text('Licencias Médicas',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          // Update the state of the app
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => GestionLicencia()));
        },
      ),
      Valores.sexo! == 'Femenino'
          ? ListTile(
              leading: const Icon(
                Icons.pregnant_woman_sharp,
                color: Colors.grey,
              ),
              title: const Text('Registro de Embarazos',
                  style: TextStyle(
                      fontSize: Font.fontTileSize, color: Colors.grey)),
              onTap: () {
                if (isMobile(context) || isTablet(context)) {
                  Navigator.of(context).pop();
                }
                // Update the state of the app
                setState(() {
                  widget.actualPage = 11;
                });
              },
            )
          : Container(),
      ListTile(
        leading: const Icon(
          Icons.exit_to_app,
          color: Colors.grey,
        ),
        title: const Text('Regresar',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          cerrarCasoPaciente();
        },
      ),
    ];
  }

  // Variables
  var scrollController = ScrollController();
  var scrollListController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    scrollListController.dispose();

    super.dispose();
  }

  Widget modalBottomPanel(BuildContext context) => ListView(
        padding: const EdgeInsets.all(10),
        children: [
          TittlePanel(
              textPanel: "Opciones . . . ", color: Theming.cuaternaryColor),
          GrandIcon(
              labelButton: isMobile(context)
                  ? "Antecedentes Personales Patológicos"
                  : "Revisiones",
              iconData: isMobile(context)
                  ? Icons.medical_services_outlined
                  : Icons.account_tree,
              onPress: () {
                if (isMobile(context)) {
                  Cambios.toNextPage(context, GestionPatologicos());
                } else {
                  Cambios.toNextPage(context, const LaboratoriosGestion());
                }
              }),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleIcon(
                tittle: 'Revisorio',
                iconed: Icons.ac_unit,
                onChangeValue: () {
                  Cambios.toNextActivity(context, chyld: const Generales());
                },
              ),
              CrossLine(height: 20),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GrandIcon(
                            labelButton:
                                "Antecedentes Personales No Patológicos",
                            iconData: Icons.medication,
                            onPress: () {
                              Cambios.toNextPage(
                                  context, const GestionNoPatologicos());
                            }),
                        GrandIcon(
                            labelButton: "Diagnósticos de la Hospitalización",
                            iconData: Icons.restore_page_outlined,
                            onPress: () {
                              Cambios.toNextPage(
                                  context, GestionDiagnosticos());
                            }),
                        GrandIcon(
                          labelButton: "Concentraciones y Diluciones",
                          iconData: Icons.balance,
                          onPress: () {
                            Cambios.toNextActivity(context,
                                chyld: const Concentraciones());
                          },
                        ),
                      ],
                    ),
                    CrossLine(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GrandIcon(
                          labelButton: "Balances Hidricos",
                          iconData: Icons.waterfall_chart,
                          onPress: () {
                            Cambios.toNextPage(context, GestionBalances());
                          },
                        ),
                        GrandIcon(
                            labelButton: "Paraclinicos",
                            iconData: Icons.account_tree_outlined,
                            onPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) =>
                                      const LaboratoriosGestion())));
                            }),
                        GrandIcon(
                            labelButton: "Rutina",
                            iconData: Icons.ad_units,
                            onPress: () {
                              Cambios.toNextActivity(context,
                                  tittle: 'Anexión de la Rutina',
                                  chyld: ConmutadorParaclinicos(
                                      categoriaEstudio: "Rutina"));
                            }),
                      ],
                    ),
                  ],
                ),
              ),
              CrossLine(height: 5),
              CircleIcon(
                tittle: 'Revisorio',
                iconed: Icons.ac_unit,
                onChangeValue: () {
                  Cambios.toNextPage(context, GestionRevisorios());
                },
              ),
            ],
          ),
          CrossLine(height: 20, thickness: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GrandIcon(
                iconData: Icons.checklist_rtl,
                labelButton: "Laboratorios",
                onPress: () {
                  Operadores.selectOptionsActivity(
                    context: context,
                    tittle: "Elija la fecha de los estudios . . . ",
                    options: Listas.listWithoutRepitedValues(
                      Listas.listFromMapWithOneKey(
                        Pacientes.Paraclinicos!,
                        keySearched: 'Fecha_Registro',
                      ),
                    ),
                    onClose: (value) {
                      setState(() {
                        Datos.portapapeles(
                            context: context,
                            text: Auxiliares.porFecha(fechaActual: value));
                        Navigator.of(context).pop();
                      });
                    },
                  );
                },
              ),
              GrandIcon(
                iconData: Icons.list_alt_sharp,
                labelButton: "Laboratorios",
                onPress: () {
                  Datos.portapapeles(
                      context: context, text: Auxiliares.historial());
                },
                onLongPress: () {
                  Datos.portapapeles(
                      context: context,
                      text: Auxiliares.historial(esAbreviado: true));
                },
              ),
              GrandIcon(
                iconData: Icons.line_style,
                labelButton: "Laboratorios",
                onPress: () {
                  Datos.portapapeles(
                      context: context, text: Auxiliares.getUltimo());
                },
                onLongPress: () {
                  Datos.portapapeles(
                      context: context,
                      text: Auxiliares.getUltimo(esAbreviado: true));
                },
              ),
            ],
          ),
          CrossLine(height: 20, thickness: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.remove_from_queue,
                  color: Colors.white,
                ),
                tooltip: 'Refrescar . . . ',
                onPressed: () async {
                  setState(() {});
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.system_update_alt,
                  color: Colors.white,
                ),
                tooltip: 'Cargando . . . ',
                onPressed: () async {
                  Pacientes.loadingActivity(context: context).then((value) {
                    if (value == true) {
                      Terminal.printAlert(
                          message:
                              'Archivo ${Pacientes.localPath} Re-Creado $value');
                      Navigator.of(context).pop();
                    }
                  }).onError((error, stackTrace) {
                    Terminal.printAlert(
                        message:
                            "ERROR - toVisual : : $error : : Descripción : $stackTrace");
                    Operadores.alertActivity(
                        message: "ERROR - toVisual : : $error",
                        context: context,
                        tittle: 'Error al Inicial Visual');
                  });
                },
              ),
            ],
          ),
          CrossLine(height: 20, thickness: 3),
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                "Cerrar",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              )),
        ],
      );
  // String? turnoPaciente,
  //     statusPaciente,
  //     numeroPaciente,
  //     agregadoPaciente,
  //     primerNombrePaciente,
  //     segundoNombrePaciente,
  //     apellidoPaternoPaciente,
  //     apellidoMaternoPaciente,
  //     edadPaciente;
  // late String imgPaciente = "";
}

floatingWidgets(BuildContext context) {
  return [
    FloatingActionButton(
      backgroundColor: Colors.black87,
      foregroundColor: Colors.grey,
      tooltip: 'Indicaciones Médicas',
      onPressed: () {
        //...
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            )));
      },
      heroTag: null,
      child: const Icon(
        Icons.line_weight,
        color: Colors.grey,
      ),
    ),
    const SizedBox(height: 10),
    FloatingActionButton(
      backgroundColor: Colors.black87,
      foregroundColor: Colors.grey,
      tooltip: 'Vista Previa',
      onPressed: () async {},
      heroTag: null,
      child: const Icon(
        Icons.scale,
        color: Colors.grey,
      ),
    )
  ];
}

class CircularShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {

    const double innerCircleRadius = 50.0;
    const int constant = 10;
    
    final double height = rect.height - 10;

    Path path = Path();

    path.lineTo(0, height);
    path.quadraticBezierTo(rect.width / 2 - (innerCircleRadius / 2) - 15, rect.height, rect.width / 2 - 75, rect.height + 10);
    path.cubicTo(
        rect.width / 2 - constant, height + innerCircleRadius - constant,
        rect.width / 2 + constant, height + innerCircleRadius - constant,
        rect.width / 2 + 75, height + 20
    );
    path.quadraticBezierTo(rect.width / 2 + (innerCircleRadius / 2) + 15, rect.height, rect.width, rect.height);
    path.lineTo(rect.width, 0.0);
    path.close();

    return path;
  }
}

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {

    const double innerCircleRadius = 150.0;

    Path path = Path();
    path.lineTo(0, rect.height);
    path.quadraticBezierTo(rect.width / 2 - (innerCircleRadius / 2) - 30, rect.height + 15, rect.width / 2 - 75, rect.height + 50);
    path.cubicTo(
        rect.width / 2 - 40, rect.height + innerCircleRadius - 40,
        rect.width / 2 + 40, rect.height + innerCircleRadius - 40,
        rect.width / 2 + 75, rect.height + 50
    );
    path.quadraticBezierTo(rect.width / 2 + (innerCircleRadius / 2) + 30, rect.height + 15, rect.width, rect.height);
    path.lineTo(rect.width, 0.0);
    path.close();

    return path;
  }
}