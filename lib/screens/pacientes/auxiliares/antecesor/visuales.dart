import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/gasometricos.dart'
    as Gas;
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/dashboard.dart';
import 'package:assistant/screens/pacientes/auxiliares/detalles/detalles.dart';
import 'package:assistant/screens/pacientes/auxiliares/detalles/estadisticasVitales.dart';
import 'package:assistant/screens/pacientes/auxiliares/hospitalarios/hospitalizados.dart';
import 'package:assistant/screens/pacientes/auxiliares/presentaciones/antecedentesPersonales.dart';

import 'package:assistant/screens/pacientes/auxiliares/presentaciones/presentaciones.dart';
import 'package:assistant/screens/pacientes/auxiliares/revisiones/generales.dart';
import 'package:assistant/screens/pacientes/auxiliares/revisiones/revisiones.dart';
import 'package:assistant/screens/pacientes/epidemiologicos/documentacion.dart';
import 'package:assistant/screens/pacientes/epidemiologicos/licencias.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/hospitalizacion.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/hospitalizado.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/hematinicos.dart';
import 'package:assistant/screens/pacientes/intensiva/herramientas.dart';
import 'package:assistant/screens/pacientes/pacientes.dart';
import 'package:assistant/screens/pacientes/paraclinicos/paraclinicos.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/semiologicos.dart';
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
import 'package:flutter/services.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/antropometricos.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/cardiovasculares.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/gasometricos.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/hidricos.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/metabolometrias.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/ventilatorios.dart';

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
    // Pacientes.getValores();
    // Pacientes.getParaclinicosHistorial();
    //
    super.initState();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    /// ENFORCE DEVICE ORIENTATION PORTRAIT ONLY
    if (isMobile(context)) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    }

    return Scaffold(
      key: _key,
      resizeToAvoidBottomInset: true,
      drawer:
          isMobile(context) || isTablet(context) ? drawerHome(context) : null,
      endDrawer: _drawerForm(context),
      appBar: AppBar(
          foregroundColor: Colors.white,
          leading: isDesktop(context) || isLargeDesktop(context)
              ? IconButton(
                  icon: const Icon(
                    color: Colors.white,
                    Icons.arrow_back
                  ),
                  tooltip: 'Regresar',
                  onPressed: () => cerrarCasoPaciente())
              : null,
          backgroundColor: Colors.black,
          centerTitle: true,
          toolbarHeight: isLargeDesktop(context) ? 60.0 : 80.0,
          elevation: 0,
          title: isLargeDesktop(context)
              ? AppBarText(Sentences.app_bar_usuarios)
              : CircleIcon(
                  iconed: Icons.person,
                  tittle: Sentences.app_bar_usuarios,
                  onChangeValue: () => ScaffoldMessenger.of(context)
                      .showMaterialBanner(_presentacionPaciente(context)),
                ),
          actions: <Widget>[
            GrandIcon(
                iconData: Icons.menu_open_outlined,
                onPress: () => _key.currentState!.openEndDrawer()),
            CrossLine(
              height: 15,
              thickness: 1,
              isHorizontal: false,
            ),
          ]),
      body:
          isMobile(context) || isTablet(context) ? mobileView() : desktopView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: isDesktop(context) || isLargeDesktop(context)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: floatingWidgets(context))
          : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  backgroundColor: Theming.terciaryColor,
                  child:
                      const Icon(Icons.menu_open_outlined, color: Colors.grey),
                  onPressed: () => _key.currentState!.openEndDrawer(),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  backgroundColor: Theming.terciaryColor,
                  child: const Icon(Icons.list_alt_sharp, color: Colors.grey),
                  onPressed: () => _key.currentState!.openDrawer(),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  backgroundColor: Theming.terciaryColor,
                  child: const Icon(Icons.filter_list, color: Colors.grey),
                  onPressed: () {
                    // Pacientes.getValores();
                    // Pacientes.getParaclinicosHistorial();
                    //
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Theming.cuaternaryColor,
                        builder: (BuildContext context) {
                          return modalBottomPanel(context);
                        });
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    scrollListController.dispose();

    /// ENFORCE DEVICE ORIENTATION PORTRAIT ONLY
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  // ****************************************************
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
          flex: isLargeDesktop(context)
              ? 14
              : isDesktop(context)
                  ? 8
                  : 7,
          child: pantallasAuxiliares(widget.actualPage)),
    ]);
  }

  //
  void toNextScreen({context, int? index, screen}) {
    if (isMobile(context) || isTablet(context)) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
    } else {
      setState(() {
        widget.actualPage = index!;
      });
    }
  }

  void cerrarCasoPaciente({bool toHospitized = false}) {
    Pacientes.close();
    dispose();

    if (toHospitized) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Hospitalizados()));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const GestionPacientes()));
    }
  }

  // PANELES ************************************************
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
      Dashboard(), // 0
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
      GestionDocumentacion(
        withAppBar: false,
      ),
      // const Center(
      //   child: Text('Body 7'),
      // ),
      GestionHospitalizaciones(
        withAppBar: false,
      ),
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
      ), // 0
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
      ), // 6
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
              style:
                  TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
          onTap: () {
            if (isMobile(context) || isTablet(context)) {
              Navigator.of(context).pop();
            }
            // Update the state of the app
            toNextScreen(
                context: context,
                index: 8,
                screen: GestionDocumentacion(
                  withAppBar: true,
                ));
          }), // 8
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
              context: context,
              index: 9,
              screen: GestionHospitalizaciones(
                withAppBar: true,
              ));
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
      Valores.sexo != null
          ? Valores.sexo! == 'Femenino'
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
              : Container()
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

  // COMPONENTES ************************************
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
                  Cambios.toNextPage(context, const Generales());
                  // Cambios.toNextActivity(context, chyld: const Generales());
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
                iconed: Icons.circle_outlined,
                onChangeValue: () {
                  Cambios.toNextPage(context, AnalisisRevisorios());
                },
              ),
            ],
          ),
          CrossLine(height: 20, thickness: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GrandIcon(
                  iconData: Icons.water_drop,
                  labelButton: 'Análisis Hidrico',
                  onPress: () =>
                      Cambios.toNextActivity(context, chyld: Hidricos())),
              GrandIcon(
                iconData: Icons.bubble_chart,
                labelButton: 'Análisis Metabólico',
                onPress: () {
                  Operadores.openDialog(
                      context: context, chyldrim: const Metabolicos());
                },
              ),
              GrandIcon(
                iconData: Icons.horizontal_rule_sharp,
                labelButton: 'Análisis Antropométrico',
                onPress: () => Cambios.toNextActivity(context,
                    chyld: const Antropometricos()),
              ),
              GrandIcon(
                  iconData: Icons.monitor_heart_outlined,
                  labelButton: 'Análisis Cardiovascular',
                  onPress: () => Cambios.toNextActivity(context,
                      chyld: Cardiovasculares())),
              GrandIcon(
                iconData: Icons.all_inclusive_rounded,
                labelButton: 'Análisis Ventilatorio',
                onPress: () => Cambios.toNextActivity(context,
                    chyld: Ventilatorios()),
              ),
              GrandIcon(
                iconData: Icons.g_mobiledata,
                labelButton: 'Análisis Gasométrico',
                onPress: () {
                  Cambios.toNextActivity(context, chyld: const Gasometricos());
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GrandIcon(
                iconData: Icons.accessibility,
                labelButton: 'Análisis de Hemáticos',
                onPress: () {
                  Cambios.toNextActivity(context, chyld: const Hematinicos());
                },
              ),
              GrandIcon(
                labelButton: 'Análisis Renal',
                onPress: () {
                  Operadores.alertActivity(
                      context: context,
                      tittle: "¡Disculpas!",
                      message: "Actividad en construcción");
                  // Operadores.openDialog(
                  //     context: context, chyldrim: const Hidricos());
                },
              ),
              GrandIcon(
                labelButton: 'Análisis Sanguíneo Circulante',
                onPress: () {
                  Operadores.alertActivity(
                      context: context,
                      tittle: "¡Disculpas!",
                      message: "Actividad en construcción");
                  // Operadores.openDialog(
                  //     context: context, chyldrim: const Hidricos());
                },
              ),
              GrandIcon(
                labelButton: 'Análisis Pulmonar',
                onPress: () {
                  Operadores.alertActivity(
                      context: context,
                      tittle: "¡Disculpas!",
                      message: "Actividad en construcción");
                  // Operadores.openDialog(
                  //     context: context, chyldrim: const Hidricos());
                },
              ),
              GrandIcon(
                labelButton: 'Edad Corregida',
                onPress: () {
                  Operadores.alertActivity(
                      context: context,
                      tittle: "¡Disculpas!",
                      message: "Actividad en construcción");
                  // Operadores.openDialog(
                  //     context: context, chyldrim: const Hidricos());
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
              GrandIcon(
                iconData: Icons.linear_scale_rounded,
                labelButton: "Actual e Historial",
                onPress: () {
                  Datos.portapapeles(
                      context: context,
                      text: Auxiliares.getUltimo(withoutInsighs: true));
                },
                onLongPress: () {
                  Datos.portapapeles(
                      context: context,
                      text: Auxiliares.historial(withoutInsighs: true));
                },
              ),
            ],
          ),
          CrossLine(height: 20, thickness: 3),
          // ESPECIALES
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GrandIcon(
                iconData: Icons.speaker,
                labelButton: "Estudios Especiales . . . ",
                onPress: () {
                  Datos.portapapeles(
                      context: context, text: Auxiliares.getEspeciales());
                },
                onLongPress: () {
                  Datos.portapapeles(
                      context: context, text: Auxiliares.getEspeciales());
                },
              ),
              GrandIcon(
                iconData: Icons.hourglass_bottom,
                labelButton: "Cultivos Recabados . . . ",
                onPress: () {
                  Datos.portapapeles(
                      context: context, text: Auxiliares.getCultivos());
                },
                onLongPress: () {
                  Datos.portapapeles(
                      context: context, text: Auxiliares.getCultivos());
                },
              ),
              GrandIcon(
                iconData: Icons.linear_scale,
                labelButton: "Marcadores Cardiacos . . . ",
                onPress: () {
                  Datos.portapapeles(
                      context: context, text: Auxiliares.getCurvaCardiaca());
                },
                onLongPress: () {
                  Datos.portapapeles(
                      context: context, text: Auxiliares.getCurvaCardiaca());
                },
              ),
            ],
          ),
          CrossLine(height: 20, thickness: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GrandIcon(
                  iconData: Icons.g_mobiledata,
                  labelButton: "Gasometricos",
                  onPress: () => Datos.portapapeles(
                      context: context, text: Gas.Gasometricos.gasometricos)),
              GrandIcon(
                  iconData: Icons.gesture,
                  labelButton: "Gasometricos Completo",
                  onPress: () => Datos.portapapeles(
                      context: context,
                      text: Gas.Gasometricos.gasometricosCompleto)),
              GrandIcon(
                  iconData: Icons.grain_sharp,
                  labelButton: "Gasometricos Medial",
                  onPress: () => Datos.portapapeles(
                      context: context,
                      text: Gas.Gasometricos.gasometricosMedial)),
              GrandIcon(
                  iconData: Icons.blinds_closed,
                  labelButton: "Reposición de Bicarbonato",
                  onPress: () => Datos.portapapeles(
                      context: context,
                      text: Gas.Gasometricos.gasometricosBicarbonato)),
              GrandIcon(
                  iconData: Icons.nest_cam_wired_stand_outlined,
                  labelButton: "Gasometricos Nombrado",
                  onPress: () => Datos.portapapeles(
                      context: context,
                      text: Gas.Gasometricos.gasometricosNombrado)),
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
                  }).whenComplete(() => setState(() {}));
                },
              ),
            ],
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              CrossLine(height: 20, thickness: 6),
              // CERRAR
              Positioned(
                child: CircleIcon(
                  tittle: 'Hospitalizados . . . ',
                  iconed: Icons.bed_sharp,
                  onChangeValue: () {
                    cerrarCasoPaciente(toHospitized: true);
                    dispose();
                    //
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              CrossLine(height: 20, thickness: 6),
              // CERRAR
              Positioned(
                child: CircleIcon(
                  radios: 35,
                  tittle: 'Revisorio',
                  iconed: Icons.close_sharp,
                  onChangeValue: () {
                    cerrarCasoPaciente();
                    dispose();
                    //
                  },
                ),
              ),
            ],
          ),
          CrossLine(height: 20, thickness: 3),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                "Cerrar",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              )),
        ],
      );

  _drawerForm(BuildContext context) => Drawer(
        width: 100,
        backgroundColor: Theming.terciaryColor,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.grey),
                bottom: BorderSide(color: Colors.grey),
                left: BorderSide(color: Colors.grey)),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16), topLeft: Radius.circular(16)),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: DrawerHeader(
                  child: CircleIcon(
                      difRadios: 15,
                      iconed: Icons.line_weight_sharp,
                      onChangeValue: () {
                        _key.currentState!.closeEndDrawer();
                        ScaffoldMessenger.of(context)
                            .showMaterialBanner(_presentacionPaciente(context));
                      }),
                ),
              ),
              Expanded(flex: 10, child: Column(children: sidePanel(context))),
              CrossLine(thickness: 3, height: 20, color: Colors.grey),
              Expanded(
                  flex: 1,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.question_answer,
                          ),
                          tooltip: 'Mensajería',
                          onPressed: () {
                            _key.currentState!.closeEndDrawer();
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return alertDialog("Manejo de registro",
                                      "El registro ha sido actualizado / creado",
                                      () {
                                    Navigator.of(context).pop();
                                  }, () {});
                                });
                          },
                        ),
                        IconButton(
                            icon: const Icon(
                              Icons.safety_check,
                            ),
                            tooltip: '',
                            onPressed: () {
                              _key.currentState!.closeEndDrawer();
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return emergentDialog(
                                        context,
                                        Phrases.demoTittle,
                                        Phrases.demoPhrase, () {
                                      Navigator.of(context).pop();
                                    });
                                  }));
                            }),
                      ])),
              CrossLine(thickness: 3, height: 20, color: Colors.grey),
              Expanded(
                flex: 2,
                child: CircleIcon(
                  iconed: Icons.query_stats,
                  radios: 30,
                  difRadios: 5,
                  tittle: "Exploraciones y Analisis . . . ",
                  onChangeValue: () {
                    _key.currentState!.closeEndDrawer();
                    Cambios.toNextPage(context, Semiologicos());
                  },
                ),
              ),
            ],
          ),
        ),
      );

  sidePanel(BuildContext context) => <Widget>[
        CrossLine(
          thickness: 0,
          height: 7,
        ),
        CrossLine(
          thickness: 1,
          height: 15,
        ),
        Expanded(
          flex: 2,
          child: Wrap(
            runSpacing: 10,
            children: [
              CircleIcon(
                  radios: 30,
                  difRadios: 8,
                  iconed: Icons.medical_information,
                  tittle: "Datos Generales . . . ",
                  onChangeValue: () {
                    _key.currentState!.closeEndDrawer();
                    Datos.portapapeles(
                        context: context, text: Pacientes.nombreCompleto!);
                  }),
              CircleIcon(
                  radios: 30,
                  difRadios: 8,
                  iconed: Icons.numbers,
                  tittle: "Número de Seguro Social . . . ",
                  onChangeValue: () {
                    _key.currentState!.closeEndDrawer();
                    Datos.portapapeles(
                        context: context, text: Pacientes.numeroAfiliacion!);
                  }),
              CircleIcon(
                  radios: 30,
                  difRadios: 8,
                  iconed: Icons.nat,
                  tittle: "Número de Seguro Social . . . ",
                  onChangeValue: () {
                    _key.currentState!.closeEndDrawer();
                    Datos.portapapeles(
                        context: context, text: Pacientes.numeroPaciente!);
                  }),
              CircleIcon(
                  radios: 30,
                  difRadios: 8,
                  iconed: Icons.medical_information,
                  tittle: "Vitales abreviado . . . ",
                  onChangeValue: () {
                    _key.currentState!.closeEndDrawer();
                    Datos.portapapeles(
                        context: context,
                        text: Antropometrias.vitalesAbreviado);
                  }),
            ],
          ),
        ),
        CrossLine(thickness: 1, height: 15),
      ];

  downPanel(BuildContext context) {}

  floatingWidgets(BuildContext context) {
    return [
      FloatingActionButton(
        backgroundColor: Colors.black87,
        foregroundColor: Colors.grey,
        tooltip: 'Vista Previa',
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: Theming.cuaternaryColor,
                  border: Border(
                      top: BorderSide(color: Colors.grey),
                      right: BorderSide(color: Colors.grey),
                      left: BorderSide(color: Colors.grey)),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16)),
                ),
                child: modalBottomPanel(context),
              );
            }),
        heroTag: null,
        child: const Icon(
          Icons.scale,
          color: Colors.grey,
        ),
      ),
      const SizedBox(height: 10),
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
    ];
  }

  MaterialBanner _presentacionPaciente(BuildContext context) => MaterialBanner(
        padding: const EdgeInsets.all(5.0),
        content: Detalles(withImage: isMobile(context) ? false : true),
        backgroundColor: Colors.black,
        forceActionsBelow: true,
        overflowAlignment: OverflowBarAlignment.center,
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                ScaffoldMessenger.of(context).clearMaterialBanners(),
            child: const Text('Cerrar . . . '),
          ),
        ],
      );

  MaterialBanner _hospitalizacion(BuildContext context) => MaterialBanner(
        padding: const EdgeInsets.all(5.0),
        content: Pacientes.esHospitalizado == true
            ? Hospitalizado()
            : const EstadisticasVitales(),
        backgroundColor: Colors.black,
        forceActionsBelow: true,
        overflowAlignment: OverflowBarAlignment.center,
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                ScaffoldMessenger.of(context).clearMaterialBanners(),
            child: const Text('Cerrar . . . '),
          ),
        ],
      );

// onChangeValue: () => showModalBottomSheet(
//     context: context,
//     backgroundColor: Colors.black,
//     builder: (BuildContext context) {
//       return const Center(child: Detalles());
//     })
}
