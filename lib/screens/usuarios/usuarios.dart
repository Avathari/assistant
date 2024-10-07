
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Usuarios.dart';
import 'package:assistant/screens/home.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fl_chart/fl_chart.dart';

import 'dart:convert';

import '../../widgets/WidgetsModels.dart';

class GestionUsuarios extends StatefulWidget {
  const GestionUsuarios({super.key});

  @override
  State<GestionUsuarios> createState() => _GestionUsuariosState();
}

class _GestionUsuariosState extends State<GestionUsuarios> {
  String? consultQuery = Usuarios.usuarios['consultQuery'];

  late List? foundedUsuarios = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  String searchCriteria = "Buscar por Apellido";

  @override
  void initState() {
    Actividades.consultar(Databases.siteground_database_regusua, consultQuery!)
        .then((value) {
      setState(() {
        foundedUsuarios = value;
      });
    });

    super.initState();
  }

  void _runFilterSearch(String enteredKeyword) {
    List? results = [];

    if (enteredKeyword.isEmpty) {
      _pullListRefresh();
    } else {
      Actividades.consultar(
              Databases.siteground_database_regusua, consultQuery!)
          .then((value) {
        results = value
            .where((user) => user["Us_Ape_Pat"].contains(enteredKeyword))
            .toList();

        setState(() {
          foundedUsuarios = results;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Theming.primaryColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            tooltip: Sentences.regresar,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Home()));
            },
          ),
          title: const Text(Sentences.app_usuarios_tittle),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.replay_outlined,
              ),
              tooltip: Sentences.reload,
              onPressed: () {
                _pullListRefresh();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.add_card,
              ),
              tooltip: Sentences.add_usuario,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => OperacionesUsuario(
                    operationActivity: Constantes.Register,
                  ),
                ));
              },
            ),
          ]),
      body: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      onChanged: (value) {
                        _runFilterSearch(value);
                      },
                      controller: searchTextController,
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      autocorrect: true,
                      obscureText: false,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        helperStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        labelText: searchCriteria,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        contentPadding: const EdgeInsets.all(20),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        focusColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.replay_outlined,
                            color: Colors.white,
                          ),
                          tooltip: Sentences.reload,
                          onPressed: () {
                            _pullListRefresh();
                          },
                        ),
                      )),
                ),
              ),
              Expanded(
                flex: 9,
                child: RefreshIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.black,
                  onRefresh: _pullListRefresh,
                  child: FutureBuilder<List>(
                    initialData: foundedUsuarios!,
                    future: Future.value(foundedUsuarios!),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? ListView.builder(
                              controller: gestionScrollController,
                              shrinkWrap: true,
                              itemCount: snapshot.data == null
                                  ? 0
                                  : snapshot.data.length,
                              itemBuilder: (context, posicion) {
                                return Container(
                                  padding: const EdgeInsets.all(2.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Usuarios.ID_Usuario =
                                          snapshot.data[posicion]['ID_Usuario'];
                                      Usuarios.Usuario =
                                          snapshot.data[posicion];
                                      toVisual(context, Constantes.Update);
                                    },
                                    child: Card(
                                      color:
                                          const Color.fromARGB(255, 54, 50, 50),
                                      child: Container(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    CircleAvatar(
                                                        backgroundColor:
                                                            const Color
                                                                    .fromARGB(
                                                                255, 0, 0, 0),
                                                        radius: 50,
                                                        child: ClipOval(
                                                            child: Image.memory(
                                                          base64Decode(
                                                              snapshot.data[
                                                                      posicion]
                                                                  ['Us_Fiat']),
                                                          width: 100,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        ))),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 10.0,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "ID Usuario : ${snapshot.data[posicion]['ID_Usuario']}",
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 12),
                                                        ),
                                                        Text(
                                                          "${snapshot.data[posicion]['Us_Ape_Pat']} ${snapshot.data[posicion]['Us_Ape_Mat']} \n${snapshot.data[posicion]['Us_Nome']} ",
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 14),
                                                        ),
                                                        Text(
                                                          "${snapshot.data[posicion]['Us_EspeL']}",
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 12),
                                                        ),
                                                        Text(
                                                          "Estado : ${snapshot.data[posicion]['Us_Stat']}",
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        IconButton(
                                                          color: Colors.grey,
                                                          icon: const Icon(
                                                              Icons.person),
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return imageDialog(
                                                                      "${snapshot.data[posicion]['Us_Ape_Pat']} "
                                                                      "${snapshot.data[posicion]['Us_Ape_Mat']} "
                                                                      "\n${snapshot.data[posicion]['Us_Nome']} ",
                                                                      snapshot.data[
                                                                              posicion]
                                                                          [
                                                                          'Us_Fiat'],
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  });
                                                                });
                                                          },
                                                        ),
                                                        IconButton(
                                                          color: Colors.grey,
                                                          icon: const Icon(Icons
                                                              .update_rounded),
                                                          onPressed: () {
                                                            Usuarios.ID_Usuario =
                                                                snapshot.data[
                                                                        posicion]
                                                                    [
                                                                    'ID_Usuario'];
                                                            Usuarios.Usuario =
                                                                snapshot.data[
                                                                    posicion];
                                                            toOperaciones(
                                                                context,
                                                                posicion,
                                                                snapshot,
                                                                Constantes
                                                                    .Update);
                                                          },
                                                        ),
                                                        IconButton(
                                                          color: Colors.grey,
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return alertDialog(
                                                                    'Eliminar registro',
                                                                    '¿Esta seguro de querer eliminar el registro?',
                                                                    () {
                                                                      closeDialog(
                                                                          context);
                                                                    },
                                                                    () {
                                                                      deleteRegister(
                                                                          snapshot,
                                                                          posicion,
                                                                          context);
                                                                    },
                                                                  );
                                                                });
                                                          },
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircularProgressIndicator(),
                                  const SizedBox(height: 50),
                                  Text(
                                    snapshot.hasError
                                        ? snapshot.error.toString()
                                        : snapshot.error.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        isTabletAndDesktop(context)
            ? const Expanded(flex: 1, child: EstadisticasUsuario())
            : Container()
      ]),
    );
  }

  void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void deleteRegister(
      AsyncSnapshot<dynamic> snapshot, int posicion, BuildContext context) {
    try {
      Actividades.eliminar(
          Databases.siteground_database_regusua,
          Usuarios.usuarios['deleteQuery'],
          snapshot.data[posicion]['ID_Usuario']);
      setState(() {
        snapshot.data.removeAt(posicion);
      });
    } finally {
      Navigator.of(context).pop();
    }
  }

  void toVisual(BuildContext context, String operationActivity) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => const VisualUsuarios(),
    ));
  }

  void toOperaciones(BuildContext context, int posicion,
      AsyncSnapshot<dynamic> snapshot, String operationActivity) {
    // print("SELECCIONADO : : : ${posicion + 1} : ${snapshot.data[posicion]}");
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => OperacionesUsuario(
        operationActivity: operationActivity,
      ),
    ));
  }

  Future<Null> _pullListRefresh() async {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (a, b, c) => const GestionUsuarios(),
            transitionDuration: const Duration(seconds: 0)));
  }
}

class OperacionesUsuario extends StatefulWidget {
  //const OperacionesUsuario({super.key});
  // final Map<String, dynamic> lista;
  // final int index;
  final String operationActivity;

  String _operation_button = 'Nulo';

  OperacionesUsuario({super.key, required this.operationActivity});

  @override
  State<OperacionesUsuario> createState() => _OperacionesUsuarioState();
}

class _OperacionesUsuarioState extends State<OperacionesUsuario> {
  final picker = ImagePicker();

  String consultIdQuery = Usuarios.usuarios['consultIdQuery'];
  String registerQuery = Usuarios.usuarios['registerQuery'];
  String updateQuery = Usuarios.usuarios['updateQuery'];

  int idOperation = 0;
  bool _isObscure = true;
  final nameController = TextEditingController();
  final firstNameTextController = TextEditingController();
  final secondNameTextController = TextEditingController();

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String permiValue = Usuarios.Permisos[0];
  String categoriaValue = Usuarios.Categorias[0];
  String areaValue = Usuarios.Areas[0];
  String statusValue = Usuarios.Status[0];

  late String img = "";

  List<dynamic>? listOfValues;

  @override
  void initState() {
    switch (widget.operationActivity) {
      case Constantes.Nulo:
        break;
      case Constantes.Consult:
        break;
      case Constantes.Register:
        widget._operation_button = 'Registrar';

        toBaseImage();

        break;
      case Constantes.Update:
        widget._operation_button = 'Actualizar';
        idOperation = Usuarios.Usuario['ID_Usuario'];
        nameController.text = Usuarios.Usuario['Us_Nome'];
        firstNameTextController.text = Usuarios.Usuario['Us_Ape_Pat'];
        secondNameTextController.text = Usuarios.Usuario['Us_Ape_Mat'];

        usernameTextController.text = Usuarios.Usuario['Us_Usuario'];
        passwordTextController.text = Usuarios.Usuario['Us_Passe'];

        permiValue = Usuarios.Usuario['Us_Permi'];
        categoriaValue = Usuarios.Usuario['Us_EspeL'];
        areaValue = Usuarios.Usuario['Us_Area'];
        statusValue = Usuarios.Usuario['Us_Stat'];

        img = Usuarios.Usuario['Us_Fiat'];

        super.initState();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 61, 57, 57),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isMobile(context)
                  ? returnOperationUserButton(context)
                  : Container(),
              userPresentation(context),
              userForm(context)
            ],
          ),
        ),
      ),
    );
  }

  void returnGestion(BuildContext context) {
    switch (widget.operationActivity) {
      case Constantes.Nulo:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const GestionUsuarios()));
        break;
      case Constantes.Consult:
        break;
      case Constantes.Register:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const GestionUsuarios()));
        break;
      case Constantes.Update:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const VisualUsuarios()));
        break;
      default:
    }
  }

  Padding spinnerCategoria(String tittle, List<String> items) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.white,
                width: Ratios.borderRadius), //border of dropdown button
            borderRadius: BorderRadius.circular(20),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Colores.backgroundWidget, //shadow for button
                  blurRadius: 5) //blur radius of shadow
            ]),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$tittle:", style: const TextStyle(color: Colors.white)),
              DropdownButton(
                value: categoriaValue,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 30,
                elevation: 8,
                dropdownColor: Colores.backgroundWidget,
                style: const TextStyle(color: Colors.white),
                onChanged: (String? newValue) {
                  setState(() {
                    categoriaValue = newValue!;
                  });
                },
                items: items.map<DropdownMenuItem<String>>((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: SizedBox(
                        width: isMobile(context) ? 150 : 300, child: Text(val)),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding spinnerPermisos(String tittle, List<String> items) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.white,
                width: Ratios.borderRadius), //border of dropdown button
            borderRadius: BorderRadius.circular(20),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Colores.backgroundWidget, //shadow for button
                  blurRadius: 5) //blur radius of shadow
            ]),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$tittle:", style: const TextStyle(color: Colors.white)),
              DropdownButton(
                value: permiValue,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 30,
                elevation: 16,
                dropdownColor: Colores.backgroundWidget,
                style: const TextStyle(color: Colors.white),
                onChanged: (String? newValue) {
                  setState(() {
                    permiValue = newValue!;
                  });
                },
                items: items.map<DropdownMenuItem<String>>((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: SizedBox(
                        width: isMobile(context) ? 150 : 300, child: Text(val)),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding spinnerArea(String tittle, List<String> items) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.white,
                width: Ratios.borderRadius), //border of dropdown button
            borderRadius: BorderRadius.circular(20),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Colores.backgroundWidget, //shadow for button
                  blurRadius: 5) //blur radius of shadow
            ]),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$tittle:", style: const TextStyle(color: Colors.white)),
              DropdownButton(
                value: areaValue,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 30,
                elevation: 16,
                dropdownColor: Colores.backgroundWidget,
                style: const TextStyle(color: Colors.white),
                onChanged: (String? newValue) {
                  setState(() {
                    areaValue = newValue!;
                  });
                },
                items: items.map<DropdownMenuItem<String>>((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: SizedBox(
                        width: isMobile(context) ? 150 : 300, child: Text(val)),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding spinnerStatus(String tittle, List<String> items) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.white,
                width: Ratios.borderRadius), //border of dropdown button
            borderRadius: BorderRadius.circular(20),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Colores.backgroundWidget, //shadow for button
                  blurRadius: 5) //blur radius of shadow
            ]),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$tittle:", style: const TextStyle(color: Colors.white)),
              DropdownButton(
                value: statusValue,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 30,
                elevation: 16,
                dropdownColor: Colores.backgroundWidget,
                style: const TextStyle(color: Colors.white),
                onChanged: (String? newValue) {
                  setState(() {
                    statusValue = newValue!;
                  });
                },
                items: items.map<DropdownMenuItem<String>>((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: SizedBox(
                        width: isMobile(context) ? 150 : 300, child: Text(val)),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  choiseFromCamara() async {
    XFile? xFileImage = await picker.pickImage(source: ImageSource.camera);
    if (xFileImage != null) {
      Uint8List bytes = await xFileImage.readAsBytes();
      setState(() {
        img = base64.encode(bytes);
      });
    }
  }

  choiseFromDirectory() async {
    XFile? xFileImage = await picker.pickImage(source: ImageSource.gallery);
    if (xFileImage != null) {
      Uint8List bytes = await xFileImage.readAsBytes();
      setState(() {
        img = base64.encode(bytes);
      });
    }
  }

  toBaseImage() async {
    ByteData bytes = await rootBundle.load('assets/images/person.png');
    var buffer = bytes.buffer;

    setState(() {
      img = base64.encode(Uint8List.view(buffer));
    });
  }

  Padding returnOperationUserButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.grey, backgroundColor: Colores.backgroundWidget,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  minimumSize: const Size(50, 50)),
              onPressed: () {
                returnGestion(context);
              },
              child: const Icon(Icons.arrow_back))
        ],
      ),
    );
  }

  Padding userPresentation(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: isMobile(context)
            ? Column(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 27, 32, 30),
                    radius: 150,
                    // ignore: unnecessary_null_comparison
                    child: img != ""
                        ? ClipOval(
                            child: Image.memory(
                            base64Decode(img),
                            width: 250,
                            height: 250,
                            fit: BoxFit.cover,
                          ))
                        : const ClipOval(child: Icon(Icons.person)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.grey, backgroundColor: Colores.backgroundWidget,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              minimumSize: const Size(75, 75)),
                          onPressed: () {
                            choiseFromCamara();
                          },
                          child: const Icon(Icons.camera)),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.grey, backgroundColor: Colores.backgroundWidget,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              minimumSize: const Size(50, 50)),
                          onPressed: () {
                            toBaseImage();
                          },
                          child: const Icon(Icons.person)),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.grey, backgroundColor: Colores.backgroundWidget,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              minimumSize: const Size(75, 75)),
                          onPressed: () {
                            choiseFromDirectory();
                          },
                          child: const Icon(Icons.file_open))
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              )
            : Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 27, 32, 30),
                    radius: 150,
                    // ignore: unnecessary_null_comparison
                    child: img != ""
                        ? ClipOval(
                            child: Image.memory(
                            base64Decode(img),
                            width: 250,
                            height: 250,
                            fit: BoxFit.cover,
                          ))
                        : const ClipOval(child: Icon(Icons.person)),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.grey, backgroundColor: Colores.backgroundWidget,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                minimumSize: const Size(75, 75)),
                            onPressed: () {
                              choiseFromCamara();
                            },
                            child: const Icon(Icons.camera)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.grey, backgroundColor: Colores.backgroundWidget,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                minimumSize: const Size(50, 50)),
                            onPressed: () {
                              toBaseImage();
                            },
                            child: const Icon(Icons.person)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.grey, backgroundColor: Colores.backgroundWidget,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                minimumSize: const Size(75, 75)),
                            onPressed: () {
                              choiseFromDirectory();
                            },
                            child: const Icon(Icons.file_open)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        editText(
                            false, 'Nombre del Usuario', nameController, false),
                        editText(false, 'Apellido Paterno',
                            firstNameTextController, false),
                        editText(false, 'Apellido Materno',
                            secondNameTextController, false),
                        editText(false, 'Clave de Usuario',
                            usernameTextController, false),
                        editPassword(false, "Contraseña",
                            passwordTextController, false, _isObscure, () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }),
                      ],
                    ),
                  )
                ],
              ));
  }

  userForm(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: isMobile(context)
            ? Column(children: [
                editText(false, 'Nombre del Usuario', nameController, false),
                editText(
                    false, 'Apellido Paterno', firstNameTextController, false),
                editText(
                    false, 'Apellido Materno', secondNameTextController, false),
                editText(
                    false, 'Clave de Usuario', usernameTextController, false),
                editPassword(false, "Contraseña", passwordTextController, false,
                    _isObscure, () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                }),
                spinnerPermisos("Permisos", Usuarios.Permisos),
                spinnerCategoria("Categoria", Usuarios.Categorias),
                spinnerArea("Área", Usuarios.Areas),
                spinnerStatus("Estado", Usuarios.Status),
                const SizedBox(height: 20),
                grandButton(context, widget._operation_button, () {
                  operationMethod(context);
                }),
              ])
            : Column(
                children: [
                  GridView.count(
                      childAspectRatio: 7.0,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      shrinkWrap: true,
                      children: [
                        spinnerPermisos("Permisos", Usuarios.Permisos),
                        spinnerCategoria("Categoria", Usuarios.Categorias),
                        spinnerArea("Área", Usuarios.Areas),
                        spinnerStatus("Estado", Usuarios.Status),
                      ]),
                  const SizedBox(height: 10),
                  grandButton(context, widget._operation_button, () {
                    operationMethod(context);
                  }),
                ],
              ));
  }

  void operationMethod(BuildContext context) {
    try {
      listOfValues = [
        idOperation,
        nameController.text,
        firstNameTextController.text,
        secondNameTextController.text,
        usernameTextController.text,
        passwordTextController.text,
        permiValue,
        categoriaValue,
        areaValue,
        statusValue,
        img,
        "Romero Pantoja Luis (Administrador)",
        idOperation
      ];

      switch (widget.operationActivity) {
        case Constantes.Nulo:
          Actividades.registrar(Databases.siteground_database_regusua,
              registerQuery, listOfValues!.removeLast());
          break;
        case Constantes.Consult:
          break;
        case Constantes.Register:
          Actividades.registrar(Databases.siteground_database_regusua,
                  registerQuery, listOfValues!.removeLast())
              .then((value) => returnGestion(context));
          break;
        case Constantes.Update:
          Actividades.actualizar(Databases.siteground_database_regusua,
                  updateQuery, listOfValues!, idOperation)
              .then((value) => Actividades.consultarId(
                          Databases.siteground_database_regusua,
                          consultIdQuery,
                          idOperation)
                      .then((value) {
                    Usuarios.Usuario = value;
                  }).then((value) => returnGestion(context)));
          break;
        default:
      }
    } catch (ex) {
      showDialog(
          context: context,
          builder: (context) {
            return alertDialog("Error al operar con los valores", "$ex", () {
              Navigator.of(context).pop();
            }, () {});
          });
    } finally {
      returnGestion(context);
    }
  }
}

class VisualUsuarios extends StatefulWidget {
  const VisualUsuarios({super.key});

  @override
  State<VisualUsuarios> createState() => _VisualUsuariosState();
}

class _VisualUsuariosState extends State<VisualUsuarios> {
  var scrollController = ScrollController();
  var scrollListController = ScrollController();

  int _actualPage = 0;

  String? areaUsuario,
      statusUsuario,
      nombreUsuario,
      apellidoPaternoUsuario,
      apellidoMaternoUsuario,
      permisosUsuario,
      especialidadUsuario;
  late String imgUsuario = "";

  @override
  void initState() {
    setState(() {
      nombreUsuario = Usuarios.Usuario['Us_Nome'];
      apellidoPaternoUsuario = Usuarios.Usuario['Us_Ape_Pat'];
      apellidoMaternoUsuario = Usuarios.Usuario['Us_Ape_Mat'];

      permisosUsuario = Usuarios.Usuario['Us_Permi'];
      especialidadUsuario = Usuarios.Usuario['Us_EspeL'];
      imgUsuario = Usuarios.Usuario['Us_Fiat'];

      statusUsuario = Usuarios.Usuario['Us_Stat'];
      areaUsuario = Usuarios.Usuario['Us_Area'];

      Usuarios(nombreUsuario, apellidoPaternoUsuario, apellidoMaternoUsuario,
          imgUsuario);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: isMobile(context) ? drawerHome(context) : null,
      appBar: AppBar(
          leading: isTabletAndDesktop(context)
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  tooltip: 'Regresar',
                  onPressed: () {
                    cerrarUsuario();
                  },
                )
              : null,
          backgroundColor: Colors.black,
          title: const Text(
            Sentences.app_bar_usuarios,
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.question_answer,
              ),
              tooltip: 'Mensajería',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return alertDialog("Manejo de registro",
                          "El registro ha sido actualizado / creado", () {
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
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return emergentDialog(
                            context, Phrases.demoTittle, Phrases.demoPhrase,
                            () {
                          Navigator.of(context).pop();
                        });
                      }));
                }),
            IconButton(
                icon: const Icon(Icons.person),
                tooltip: '',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return imageDialog(
                            Usuarios.nombreCompleto, Usuarios.imagenUsuario,
                            () {
                          Navigator.of(context).pop();
                        });
                      });
                }),
          ]),
      body: Row(children: [
        Expanded(
            flex: isTabletAndDesktop(context)
                ? 2
                : isDesktop(context)
                    ? 1
                    : 0,
            child: isTabletAndDesktop(context) ? sideBar() : Container()),
        Expanded(
            flex: isTabletAndDesktop(context) ? 7 : 4,
            child: pantallasAuxiliares(_actualPage)),
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

  void toOperaciones(context) {
    if (isMobile(context)) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OperacionesUsuario(
                    operationActivity: Constantes.Update,
                  )));
    } else {
      setState(() {
        _actualPage = 1;
      });
    }
  }

  void cerrarUsuario() {
    Usuarios.Usuario = {};
    Usuarios.ID_Usuario = 0;
    Usuarios.nombreCompleto = "";
    Usuarios.imagenUsuario = "";

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const GestionUsuarios()));
  }

  Widget presentationUser() {
    if (isTablet(context)) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 60,
              child: imgUsuario != ""
                  ? ClipOval(
                      child: Image.memory(
                      base64Decode(imgUsuario),
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ))
                  : const ClipOval(child: Icon(Icons.person))),
          const SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "$apellidoPaternoUsuario $apellidoMaternoUsuario \n$nombreUsuario",
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
              Text(
                "$especialidadUsuario",
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
              Text(
                "$permisosUsuario",
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "$statusUsuario",
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
              Text(
                "$areaUsuario",
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ],
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            width: 10,
          ),
          CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 60,
              child: imgUsuario != ""
                  ? ClipOval(
                      child: Image.memory(
                      base64Decode(imgUsuario),
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ))
                  : const ClipOval(child: Icon(Icons.person))),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "$apellidoPaternoUsuario $apellidoMaternoUsuario \n$nombreUsuario",
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
              Text(
                "$especialidadUsuario",
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
              Text(
                "$permisosUsuario",
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "$statusUsuario",
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
              Text(
                "$areaUsuario",
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ],
          ),
        ],
      );
    }
  }

  Drawer drawerHome(BuildContext context) {
    return Drawer(
      backgroundColor: Colores.backgroundWidget,
      child: ListView(
        controller: scrollListController,
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.black),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 55,
                      child: imgUsuario != ""
                          ? ClipOval(
                              child: Image.memory(
                              base64Decode(imgUsuario),
                              width: 220,
                              height: 220,
                              fit: BoxFit.cover,
                            ))
                          : const ClipOval(child: Icon(Icons.person))),
                  const SizedBox(
                    height: 20,
                    width: 13,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "$apellidoPaternoUsuario $apellidoMaternoUsuario \n$nombreUsuario",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      Text(
                        "$especialidadUsuario",
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      Text(
                        "$permisosUsuario",
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "$statusUsuario",
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      Text(
                        "$areaUsuario",
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          ),
          Container(
            decoration: const BoxDecoration(color: Theming.terciaryColor),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: userActivities(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container sideBar() {
    return Container(
      color: Colors.black,
      child: ListView(
        controller: scrollListController,
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(color: Colors.black),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  isTabletAndDesktop(context)
                      ? presentationUser()
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
                children: userActivities(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pantallasAuxiliares(int actualPage) {
    var list = [
      const Center(
        child: Text('Dashboard'),
      ),
      OperacionesUsuario(operationActivity: Constantes.Update),
      const Center(
        child: Text('Body 1'),
      ),
      const Center(
        child: Text('Body 2'),
      ),
      const Center(
        child: Text('Body 3'),
      ),
      const Center(
        child: Text('Body 4'),
      ),
      const Center(
        child: Text('Body 5'),
      ),
      const Center(
        child: Text('Body 6'),
      ),
      const Center(
        child: Text('Body 7'),
      ),
      const Center(
        child: Text('Body 8'),
      ),
      const Center(
        child: Text('Body 9'),
      ),
      const Center(
        child: Text('Body 10'),
      )
    ];
    return list[actualPage];
  }

  List<Widget> userActivities() {
    return [
      ListTile(
        leading: const Icon(
          Icons.dashboard,
          color: Colors.grey,
        ),
        title: const Text('Dashboard',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          // Update the state of the app
          setState(() {
            _actualPage = 0;
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
          // Update the state of the app
          toOperaciones(context);
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
          setState(() {
            _actualPage = 2;
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
          // Update the state of the app
          setState(() {
            _actualPage = 3;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.medical_services,
          color: Colors.grey,
        ),
        title: const Text('Registro de Consultas',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          // Update the state of the app
          setState(() {
            _actualPage = 4;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.settings,
          color: Colors.grey,
        ),
        title: const Text('Auxiliares Diagnósticos',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          // Update the state of the app
          setState(() {
            _actualPage = 5;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.settings,
          color: Colors.grey,
        ),
        title: const Text('Herramientas de Terapia Intensiva',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          // Update the state of the app
          setState(() {
            _actualPage = 6;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.settings,
          color: Colors.grey,
        ),
        title: const Text('Reportes y Notas Médicas',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          // Update the state of the app
          setState(() {
            _actualPage = 7;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.settings,
          color: Colors.grey,
        ),
        title: const Text('Archivos y Documentos',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          // Update the state of the app
          setState(() {
            _actualPage = 8;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.settings,
          color: Colors.grey,
        ),
        title: const Text('Registro de Hospitalización',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          // Update the state of the app
          setState(() {
            _actualPage = 9;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.settings,
          color: Colors.grey,
        ),
        title: const Text('Licencias Médicas',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          // Update the state of the app
          setState(() {
            _actualPage = 10;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.settings,
          color: Colors.grey,
        ),
        title: const Text('Registro de Embarazos',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          // Update the state of the app
          setState(() {
            _actualPage = 11;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.exit_to_app,
          color: Colors.grey,
        ),
        title: const Text('Regresar',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          cerrarUsuario();
        },
      ),
    ];
  }
}

class EstadisticasUsuario extends StatefulWidget {
  const EstadisticasUsuario({super.key});

  @override
  State<EstadisticasUsuario> createState() => _EstadisticasUsuarioState();
}

class _EstadisticasUsuarioState extends State<EstadisticasUsuario> {
  Map<String, dynamic> data = {
    "Total_Usuarios": 0,
    "Total_Activos": 0,
    "Total_Inactivos": 0
  };
  var statScrollController = ScrollController();

  @override
  void initState() {
    Actividades.detalles(Databases.siteground_database_regusua,
            Usuarios.usuarios['usuariosStadistics'])
        .then((value) {
      setState(() {
        data = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 58, 55, 55)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(),
              child: const Text(
                'Estadisticas de Usuarios',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  Flexible(
                      flex: 2,
                      child: data['Total_Usuarios'] != 0
                          ? PieChart(PieChartData(
                              sections:
                                  listChartSections(data['Total_Usuarios'])))
                          : Container()),
                  Flexible(
                      flex: 3,
                      child: Column(
                        children: [
                          tileStat(Icons.person, "Total de Usuarios",
                              data['Total_Usuarios']),
                          tileStat(Icons.person_add_outlined,
                              "Total de Activos", data['Total_Activos']),
                          tileStat(Icons.person_off_outlined,
                              "Total de Inactivos", data['Total_Inactivos'])
                        ],
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
                flex: 2,
                //fit: FlexFit.tight,
                child: ListView.builder(
                    //shrinkWrap: true,
                    controller: statScrollController,
                    itemCount: Usuarios.Categorias.length,
                    itemBuilder: (BuildContext context, index) {
                      // print("INDEX BUILDER $index ${Usuarios.Categorias[index]} ${data!.values.toList().elementAt(index)}");
                      print(data);
                      return tileStat(Icons.list, Usuarios.Categorias[index],
                          data.values.toList().elementAt(index));
                    }))
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> listChartSections(int total) {
    List<PieChartSectionData> list = [];
    Indices.indice = 0;

    data.forEach((key, value) {
      list.add(PieChartSectionData(
        color: Colores.locales[Indices.indice],
        value: (value! / total),
        title: "${(value! / total).roundToDouble()} %",
        radius: 20,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ));
      Indices.indice++;
    });
    return list;
  }

  Padding tileStat(IconData? icon, String tittle, int stat) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      child: ListTile(
        leading: Icon(icon!, color: Colors.white),
        title: Text(
          tittle,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          "$stat usuarios",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
