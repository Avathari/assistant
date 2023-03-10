import 'package:assistant/conexiones/actividades/Compuesto.dart';
import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/bibiliotecarios/bibliotecas.dart';
import 'package:assistant/screens/pacientes/auxiliares/hospitalarios/hospitalizados.dart';
import 'package:assistant/screens/pacientes/pacientes.dart';
import 'package:assistant/screens/usuarios/usuarios.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/FtpAccount.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/HomeButton.dart';
import 'package:assistant/widgets/ReproductorVideos.dart';
import 'package:flutter/material.dart';

import '../values/Strings.dart';
import '../values/WidgetValues.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _actual_page = 1;

  List<Widget> screens = [
    const UsuariosPanel(),
    const PacientesPanel(),
    const Center(
      child: Image(
          image: NetworkImage(
              'http://192.168.0.12:8080/flutter_api/imagenes/demi-rose.png')),
    ),
    const Center(
      child: OthersPanel(),
    ),
    Center(
      child: ReproductorVideo(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: isMobile(context) ? drawerHome(context) : null,
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            Sentences.app_bar_tittle,
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.question_answer,
              ),
              tooltip: 'Quejas y Comentarios',
              onPressed: () {},
            ),
            IconButton(
                icon: const Icon(
                  Icons.help,
                ),
                tooltip: 'Informaci??n de la Aplicaci??n',
                onPressed: () {
                  showAboutDialog(
                    context: context,
                  );
                }),
          ]),
      body: Row(children: [
        Expanded(
            flex: isTablet(context)
                ? 3
                : isDesktop(context)
                    ? 2
                    : isMobile(context)
                        ? 0
                        : 2,
            child: isTablet(context)
                ? sideBar()
                : isDesktop(context)
                    ? sideBar()
                    : isMobile(context)
                        ? Container()
                        : sideBar()),
        Expanded(
            flex: isTablet(context)
                ? 7
                : isDesktop(context)
                    ? 7
                    : 7,
            child: screens[_actual_page])
      ]),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (_) {
            // return const Home();
            // return Create();
            //}));
          },
          child: const Icon(Icons.add)),
    );
  }

  Container sideBar() {
    return Container(
      color: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(color: Colors.black),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  isTablet(context)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/Luis.jpg'),
                              backgroundColor: Colors.grey,
                              radius: 60,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const <Widget>[
                                Text(
                                  "Luis Romero Pantoja",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                Text(
                                  "Medicina General",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                                Text(
                                  "Ced. Prof. 12210866",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "CAF Bacalar",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                                Text(
                                  "ISSSTE Quintana Roo",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        )
                      : isDesktop(context)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/Luis.jpg'),
                                  backgroundColor: Colors.grey,
                                  radius: 60,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const <Widget>[
                                    Text(
                                      "Luis Romero Pantoja",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    Text(
                                      "Medicina General",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    Text(
                                      "Ced. Prof. 12210866",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "CAF Bacalar",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                    Text(
                                      "ISSSTE Quintana Roo",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : isMobile(context)
                              ? Container()
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    const CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/images/Luis.jpg'),
                                      backgroundColor: Colors.grey,
                                      radius: 60,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const <Widget>[
                                        Text(
                                          "Luis Romero Pantoja",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "Medicina General",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "Ced. Prof. 12210866",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "CAF Bacalar",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "ISSSTE Quintana Roo",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                ]),
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    'Usuarios',
                    style: TextStyle(
                        fontSize: Font.fontTileSize, color: Colors.grey),
                  ),
                  onTap: () {
                    // Update the state of the app
                    setState(() {
                      _actual_page = 0;
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person_rounded,
                    color: Colors.grey,
                  ),
                  title: const Text('Pacientes',
                      style: TextStyle(
                          fontSize: Font.fontTileSize, color: Colors.grey)),
                  onTap: () {
                    // Update the state of the app
                    setState(() {
                      _actual_page = 1;
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.medical_information,
                    color: Colors.grey,
                  ),
                  title: const Text('Diagn??sticos y Estad??sticas',
                      style: TextStyle(
                          fontSize: Font.fontTileSize, color: Colors.grey)),
                  onTap: () {
                    // Update the state of the app
                    setState(() {
                      _actual_page = 2;
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.grey,
                  ),
                  title: const Text('Configuraci??n',
                      style: TextStyle(
                          fontSize: Font.fontTileSize, color: Colors.grey)),
                  onTap: () {
                    // Update the state of the app
                    setState(() {
                      _actual_page = 3;
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.grey,
                  ),
                  title: const Text('Cerrar sesi??n',
                      style: TextStyle(
                          fontSize: Font.fontTileSize, color: Colors.grey)),
                  onTap: () {
                    // Then close the drawer
                    //Navigator.push(
                    //  context,
                    //MaterialPageRoute(
                    //  builder: (context) => const Inicio()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Drawer drawerHome(BuildContext context) {
    return Drawer(
      backgroundColor: Colores.backgroundWidget,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.black),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/Luis.jpg'),
                        backgroundColor: Colors.grey,
                        radius: 60,
                      ),
                      const SizedBox(
                        height: 20,
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            "Luis Romero Pantoja",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          Text(
                            "Medicina General",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          Text(
                            "Ced. Prof. 12210866",
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "CAF Bacalar",
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                          Text(
                            "ISSSTE Quintana Roo",
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    'Usuarios',
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    // Update the state of the app
                    setState(() {
                      _actual_page = 0;
                    });
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person_rounded,
                    color: Colors.grey,
                  ),
                  title: const Text('Pacientes',
                      style: TextStyle(color: Colors.grey)),
                  onTap: () {
                    // Update the state of the app
                    setState(() {
                      _actual_page = 1;
                    });
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.medical_information,
                    color: Colors.grey,
                  ),
                  title: const Text('Diagn??sticos y Estad??sticas',
                      style: TextStyle(color: Colors.grey)),
                  onTap: () {
                    // Update the state of the app
                    setState(() {
                      _actual_page = 2;
                    });
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.grey,
                  ),
                  title: const Text('Configuraci??n',
                      style: TextStyle(color: Colors.grey)),
                  onTap: () {
                    // Update the state of the app
                    setState(() {
                      _actual_page = 3;
                    });
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.grey,
                  ),
                  title: const Text('Cerrar sesi??n',
                      style: TextStyle(color: Colors.grey)),
                  onTap: () {
                    // Then close the drawer
                    //Navigator.push(
                    //  context,
                    //MaterialPageRoute(
                    //  builder: (context) => const Inicio()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UsuariosPanel extends StatelessWidget {
  const UsuariosPanel({super.key});

  @override
  Widget build(BuildContext context) {
    late int axisCount = isMobile(context) ? 1 : 2;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.black54,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                mainAxisExtent: 150),
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colores.backgroundWidget,
                      onPrimary: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: const Size(50, 50)),
                  onPressed: () {
                    toUsuarios(context);
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.person,
                          size: 70,
                        ),
                        SizedBox(height: 10),
                        Text('Usuarios', style: TextStyle(color: Colors.white))
                      ])),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colores.backgroundWidget,
                      onPrimary: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: const Size(50, 50)),
                  onPressed: () {
                    // PdfParagraphsApi.generate(indexOfTypeReport: TypeReportes.reporteTipado, paraph: "Parrafo");
                    // showDialog(
                    //     useSafeArea: true,
                    //     context: context,
                    //     builder: (context) {
                    //       return Dialog(
                    //           child: DialogSelector(
                    //         tittle: 'Selecciona esquema antirretroviral',
                    //         searchCriteria:
                    //             'Busqueda por esquema antirretroviral',
                    //         onSelected: ((value) {
                    //           // setState(() {
                    //           //   Patologicos.selectedDiagnosis = value;
                    //           //   cieDiagnoTextController.text = Patologicos.selectedDiagnosis;
                    //           //});
                    //         }),
                    //       ));
                    //     });
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.medical_services,
                          size: 70,
                        ),
                        SizedBox(height: 10),
                        Text('to Excel Create',
                            style: TextStyle(color: Colors.white))
                      ])),
            ],
          ),
        ),
      ),
    );
  }

  void toUsuarios(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const GestionUsuarios()));
  }

  void toCreateExcelWidget(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => CreateExcelWidget()));
  }
}

class PacientesPanel extends StatelessWidget {
  const PacientesPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.black54,
      child: SingleChildScrollView(
        controller: ScrollController(),
        padding: const EdgeInsets.all(10),
        child: GridView(
          gridDelegate: GridViewTools.gridDelegate(
              crossAxisCount: 2, mainAxisExtent: 150),
          shrinkWrap: true,
          children: [
            HomeButton(
              iconData: Icons.person,
              labelButton: "Paciente",
              onPress: () {
                toNextScreen(
                    context: context, screen: const GestionPacientes());
              },
            ),
            HomeButton(
              iconData: Icons.airline_seat_individual_suite_outlined,
              labelButton: "Pacientes Hospitalizados",
              onPress: () {
                toNextScreen(context: context, screen: Hospitalizados());
                // Operadores.alertActivity(
                //     context: context,
                //     tittle: "Error",
                //     message: "Interfaz en contrucci??n");
              },
            ),
            HomeButton(
              iconData: Icons.book_outlined,
              labelButton: "Bibliotecario",
              onPress: () {
                toNextScreen(context: context, screen: GestionBibliotecas());
              },
            ),
            HomeButton(
              iconData: Icons.warning_amber,
              labelButton: "",
              onPress: () {
                // toNextScreen(context: context, screen: const GestionPacientes());
                Operadores.alertActivity(
                    context: context,
                    tittle: "Error",
                    message: "Interfaz en contrucci??n");
              },
            ),
          ],
        ),
      ),
    );
  }

  void toNextScreen({required BuildContext context, required screen}) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => screen));
  }
}

class OthersPanel extends StatelessWidget {
  const OthersPanel({super.key});

  @override
  Widget build(BuildContext context) {
    late int axisCount = isMobile(context) ? 1 : 2;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.black54,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                mainAxisExtent: 150),
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            children: [
              GrandButton(
                labelButton: 'Reproductor de Video',
                onPress: () {
                  toVideoPlayer(context);
                },
              ),
              GrandButton(
                labelButton: 'Conectar a Ftp',
                onPress: () {
                  toFtpConnect(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void toVideoPlayer(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ReproductorVideo()));
  }

  void toFtpConnect(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const FtpAccount()));
  }
}
