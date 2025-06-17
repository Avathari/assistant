import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/citometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/hepatometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AuxiliaresRevisiones {
  static Widget pendientesLaboratorios(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 5,
            child: TittleContainer(
              tittle: "Paraclínicos",
              child: GridView.builder(
                  controller: ScrollController(),
                  padding: const EdgeInsets.all(2),
                  gridDelegate: GridViewTools.gridDelegate(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5.0,
                      mainAxisExtent: 55),
                  itemCount: Listas.listWithoutRepitedValues(
                          Listas.listFromMapWithOneKey(Pacientes.Paraclinicos!))
                      .length,
                  // snapshot.data[posicion]['Auxiliares'].length,
                  itemBuilder: (BuildContext context, index) {
                    var list = Listas.listWithoutRepitedValues(
                        Listas.listFromMapWithOneKey(Pacientes.Paraclinicos!));
                    return ValuePanel(
                      fontSize: 8,
                      secondText: "${list[index]}", // Resultado
                      withEditMessage: true,
                      onEdit: (value) {
                        Datos.portapapeles(
                            context: context,
                            text: Auxiliares.porFecha(
                                fechaActual: value, esAbreviado: true));
                      },
                    );
                  }),
            )),
        CrossLine(),
        Expanded(
          flex: 5,
          child: TittleContainer(
              tittle: "Pendientes",
              child: GridView.builder(
                  controller: ScrollController(),
                  padding: const EdgeInsets.all(2),
                  gridDelegate: GridViewTools.gridDelegate(
                      crossAxisCount: 1,
                      mainAxisSpacing: 5.0,
                      mainAxisExtent: 55),
                  itemCount: Pacientes.Pendiente!.length,
                  // snapshot.data[posicion]['Auxiliares'].length,
                  itemBuilder: (BuildContext context, index) {
                    if (Pacientes.Pendiente![index]['Pace_PEN'] !=
                        "Procedimientos") {
                      return ValuePanel(
                        fontSize: 8,
                        firstText:
                            "${Pacientes.Pendiente![index]['Pace_Desc_PEN']}",
                        // Resultado
                        secondText:
                            "${Pacientes.Pendiente![index]['Pace_PEN']}",
                        // Resultado
                        withEditMessage: true,
                        onEdit: (value) {
                          Datos.portapapeles(
                              context: context,
                              text:
                                  "${Pacientes.Pendiente![index]['Pace_PEN']} "
                                  ": ${Pacientes.Pendiente![index]['Pace_Desc_PEN']} "
                                  ": : ${Dicotomicos.fromInt(Pacientes.Pendiente![index]['Pace_PEN_realized'])} Realizado. ");
                        },
                      );
                    }
                    return null;
                  })),
        ),
      ],
    );
  }

  static Widget pendientesDesglose(BuildContext context) {
    return Expanded(
      flex: 5,
      child: TittleContainer(
          tittle: "Pendientes",
          child: GridView.builder(
              controller: ScrollController(),
              padding: const EdgeInsets.all(2),
              gridDelegate: GridViewTools.gridDelegate(
                  crossAxisCount: 1, mainAxisSpacing: 5.0, mainAxisExtent: 55),
              itemCount: Pacientes.Pendiente!.length,
              // snapshot.data[posicion]['Auxiliares'].length,
              itemBuilder: (BuildContext context, index) {
                return ValuePanel(
                  fontSize: 8,
                  firstText:
                      "${Pacientes.Pendiente![index]['Pace_Desc_PEN']}", // Resultado
                  secondText:
                      "${Pacientes.Pendiente![index]['Pace_PEN']}", // Resultado
                  withEditMessage: true,
                  onEdit: (value) {
                    Datos.portapapeles(
                        context: context,
                        text: "${Pacientes.Pendiente![index]['Pace_PEN']} "
                            ": ${Pacientes.Pendiente![index]['Pace_Desc_PEN']} "
                            ": : ${Dicotomicos.fromInt(Pacientes.Pendiente![index]['Pace_PEN_realized'])} Realizado. ");
                  },
                );
              })),
    );
  }

  //
  static Widget biometrias(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: ValuePanel(
              firstText: "",
              secondText: Valores.fechaBiometria.toString(),
              thirdText: "",
            ),
          ),
          CrossLine(),
          Expanded(
            flex: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ValuePanel(
                          firstText: "Hemoglobina",
                          secondText: Valores.hemoglobina.toString(),
                          thirdText: "g/dL",
                          withEditMessage: true,
                          onEdit: (value) {
                            // Operadores.editActivity(
                            //     context: context,
                            //     keyBoardType: TextInputType.number,
                            //     tittle: "Editar . . . ",
                            //     message: "¿Hemoglobina? . . . ",
                            //     onAcept: (value) {
                            //       Terminal.printSuccess(message: "recieve $value");
                            //       setState(() {
                            //         Valores.hemoglobina = double.parse(value);
                            //         Navigator.of(context).pop();
                            //       });
                            //     });
                          },
                        ),
                        ValuePanel(
                          firstText: "Eritrocitos",
                          secondText: Valores.eritrocitos.toString(),
                          thirdText: "K/uL",
                          withEditMessage: true,
                          // onEdit: (value) {
                          //   Operadores.editActivity(
                          //       context: context,
                          //       tittle: "Editar . . . ",
                          //       message: "¿Eritrocitos? . . . ",
                          //       onAcept: (value) {
                          //         Terminal.printSuccess(message: "recieve $value");
                          //         setState(() {
                          //           Valores.eritrocitos = double.parse(value);
                          //           Navigator.of(context).pop();
                          //         });
                          //       });
                          // },
                        ),
                        ValuePanel(
                          firstText: "Hematocrito",
                          secondText: Valores.hematocrito.toString(),
                          thirdText: "%",
                          withEditMessage: true,
                          // onEdit: (value) {
                          //   Operadores.editActivity(
                          //       context: context,
                          //       tittle: "Editar . . . ",
                          //       message: "¿Hematocrito? . . . ",
                          //       onAcept: (value) {
                          //         Terminal.printSuccess(message: "recieve $value");
                          //         setState(() {
                          //           Valores.hematocrito = double.parse(value);
                          //           Navigator.of(context).pop();
                          //         });
                          //       });
                          // },
                        ),
                        ValuePanel(
                          firstText: "CMHC",
                          secondText:
                              Valores.concentracionMediaHemoglobina.toString(),
                          thirdText: "g/dL",
                          withEditMessage: true,
                          // onEdit: (value) {
                          //   Operadores.editActivity(
                          //       context: context,
                          //       keyBoardType: TextInputType.number,
                          //       tittle: "Editar . . . ",
                          //       message: "¿C. Media Hemoglobina Corpuscular? . . . ",
                          //       onAcept: (value) {
                          //         Terminal.printSuccess(message: "recieve $value");
                          //         setState(() {
                          //           Valores.concentracionMediaHemoglobina =
                          //               double.parse(value);
                          //           Navigator.of(context).pop();
                          //         });
                          //       });
                          // },
                        ),
                        ValuePanel(
                          firstText: "HCM",
                          secondText:
                              Valores.hemoglobinaCorpuscularMedia.toString(),
                          thirdText: "fL",
                          withEditMessage: true,
                          // onEdit: (value) {
                          //   Operadores.editActivity(
                          //       context: context,
                          //       keyBoardType: TextInputType.number,
                          //       tittle: "Editar . . . ",
                          //       message: "¿Hemoglobina Corpuscular Media? . . . ",
                          //       onAcept: (value) {
                          //         Terminal.printSuccess(message: "recieve $value");
                          //         setState(() {
                          //           Valores.hemoglobinaCorpuscularMedia =
                          //               double.parse(value);
                          //           Navigator.of(context).pop();
                          //         });
                          //       });
                          // },
                        ),
                        ValuePanel(
                          firstText: "VCM",
                          secondText:
                              Valores.volumenCorpuscularMedio.toString(),
                          thirdText: "pg",
                          withEditMessage: true,
                          // onEdit: (value) {
                          //   Operadores.editActivity(
                          //       context: context,
                          //       keyBoardType: TextInputType.number,
                          //       tittle: "Editar . . . ",
                          //       message: "¿Volumen Corpuscular Medio? . . . ",
                          //       onAcept: (value) {
                          //         Terminal.printSuccess(message: "recieve $value");
                          //         setState(() {
                          //           Valores.volumenCorpuscularMedio = double.parse(value);
                          //           Navigator.of(context).pop();
                          //         });
                          //       });
                          // },
                        ),
                        ValuePanel(
                          firstText: "Plaquetas",
                          secondText: Valores.plaquetas.toString(),
                          thirdText: "K/uL",
                          withEditMessage: true,
                          // onEdit: (value) {
                          //   Operadores.editActivity(
                          //       context: context,
                          //       tittle: "Editar . . . ",
                          //       message: "¿Plaquetas? . . . ",
                          //       onAcept: (value) {
                          //         Terminal.printSuccess(message: "recieve $value");
                          //         setState(() {
                          //           Valores.plaquetas = double.parse(value);
                          //           Navigator.of(context).pop();
                          //         });
                          //       });
                          // },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ValuePanel(
                          firstText: "Leucocitos",
                          secondText:
                              Valores.leucocitosTotales!.toStringAsFixed(2),
                          thirdText: "K/uL",
                          withEditMessage: true,
                          // onEdit: (value) {
                          //   Operadores.editActivity(
                          //       context: context,
                          //       tittle: "Editar . . . ",
                          //       message: "¿Leucocitos? . . . ",
                          //       onAcept: (value) {
                          //         Terminal.printSuccess(message: "recieve $value");
                          //         setState(() {
                          //           Valores.leucocitosTotales = double.parse(value);
                          //           Navigator.of(context).pop();
                          //         });
                          //       });
                          // },
                        ),
                        ValuePanel(
                          firstText: "Neutrofilos",
                          secondText: Valores.leucocitosTotales.toString(),
                          thirdText: "K/uL",
                          withEditMessage: true,
                          // onEdit: (value) {
                          //   Operadores.editActivity(
                          //       context: context,
                          //       tittle: "Editar . . . ",
                          //       message: "¿Neutrofilos? . . . ",
                          //       onAcept: (value) {
                          //         Terminal.printSuccess(message: "recieve $value");
                          //         setState(() {
                          //           Valores.leucocitosTotales = double.parse(value);
                          //           Navigator.of(context).pop();
                          //         });
                          //       });
                          // },
                        ),
                        ValuePanel(
                          firstText: "Linfocitos",
                          secondText: Valores.linfocitosTotales.toString(),
                          thirdText: "K/uL",
                          withEditMessage: true,
                          // onEdit: (value) {
                          //   Operadores.editActivity(
                          //       context: context,
                          //       tittle: "Editar . . . ",
                          //       message: "¿Linfocitos? . . . ",
                          //       onAcept: (value) {
                          //         Terminal.printSuccess(message: "recieve $value");
                          //         setState(() {
                          //           Valores.linfocitosTotales = double.parse(value);
                          //           Navigator.of(context).pop();
                          //         });
                          //       });
                          // },
                        ),
                        ValuePanel(
                          firstText: "Monocitos",
                          secondText: Valores.monocitosTotales.toString(),
                          thirdText: "K/uL",
                          withEditMessage: true,
                          // onEdit: (value) {
                          //   Operadores.editActivity(
                          //       context: context,
                          //       tittle: "Editar . . . ",
                          //       message: "¿Monocitos? . . . ",
                          //       onAcept: (value) {
                          //         Terminal.printSuccess(message: "recieve $value");
                          //         setState(() {
                          //           Valores.monocitosTotales = double.parse(value);
                          //           Navigator.of(context).pop();
                          //         });
                          //       });
                          // },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ValuePanel(
                        firstText: "",
                        secondText: Citometrias.esAnemia(),
                        thirdText: "",
                      ),
                      ValuePanel(
                        firstText: "",
                        secondText: Citometrias.aspectoEritrocitario(),
                        thirdText: "",
                      ),
                      ValuePanel(
                        firstText: "",
                        secondText: Citometrias.tamanoEritrocitario(),
                        thirdText: "",
                      ),
                      ValuePanel(
                        firstText: "Indice Metzner",
                        secondText:
                            Citometrias.indiceMetzner.toStringAsFixed(2),
                        thirdText: "",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CrossLine(),
        ],
      ),
    );
  }

  static Widget quimicas(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  ValuePanel(
                    firstText: "",
                    secondText: Valores.fechaQuimicas.toString(),
                    thirdText: "",
                  ),
                  CrossLine(),
                  ValuePanel(
                    firstText: "Glucosa Sérica",
                    secondText: Valores.glucosa.toString(),
                    thirdText: "mg/dL",
                    withEditMessage: true,
                    // onEdit: (value) {
                    //   Operadores.editActivity(
                    //       context: context,
                    //       tittle: "Editar . . . ",
                    //       message: "¿Glucosa Sérica? . . . ",
                    //       onAcept: (value) {
                    //         Terminal.printSuccess(message: "recieve $value");
                    //         setState(() {
                    //           Valores.glucosa = double.parse(value);
                    //           Navigator.of(context).pop();
                    //         });
                    //       });
                    // },
                  ),
                  ValuePanel(
                    firstText: "Urea",
                    secondText: Valores.urea.toString(),
                    thirdText: "mg/dL",
                    withEditMessage: true,
                    // onEdit: (value) {
                    //   Operadores.editActivity(
                    //       context: context,
                    //       tittle: "Editar . . . ",
                    //       message: "¿Urea? . . . ",
                    //       onAcept: (value) {
                    //         Terminal.printSuccess(message: "recieve $value");
                    //         setState(() {
                    //           Valores.urea = double.parse(value);
                    //           Navigator.of(context).pop();
                    //         });
                    //       });
                    // },
                  ),
                  ValuePanel(
                    firstText: "Creatinina",
                    secondText: Valores.creatinina.toString(),
                    thirdText: "mg/dL",
                    withEditMessage: true,
                    // onEdit: (value) {
                    //   Operadores.editActivity(
                    //       context: context,
                    //       tittle: "Editar . . . ",
                    //       message: "¿Creatinina? . . . ",
                    //       onAcept: (value) {
                    //         Terminal.printSuccess(message: "recieve $value");
                    //         setState(() {
                    //           Valores.creatinina = double.parse(value);
                    //           Navigator.of(context).pop();
                    //         });
                    //       });
                    // },
                  ),
                  ValuePanel(
                    firstText: "Nitrógeno Uréico",
                    secondText: Valores.nitrogenoUreico.toString(),
                    thirdText: "mg/gL",
                    withEditMessage: true,
                    // onEdit: (value) {
                    //   Operadores.editActivity(
                    //       context: context,
                    //       tittle: "Editar . . . ",
                    //       message: "¿Nitrógeno Uréico? . . . ",
                    //       onAcept: (value) {
                    //         Terminal.printSuccess(message: "recieve $value");
                    //         setState(() {
                    //           Valores.nitrogenoUreico = double.parse(value);
                    //           Navigator.of(context).pop();
                    //         });
                    //       });
                    // },
                  ),
                  CrossLine(),
                  CrossLine(),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  ValuePanel(
                    firstText: "",
                    secondText: Valores.fechaElectrolitos.toString(),
                    thirdText: "",
                  ),
                  CrossLine(),
                  ValuePanel(
                    firstText: "Sodio Sérico",
                    secondText: Valores.sodio.toString(),
                    thirdText: "mEq/L",
                    withEditMessage: true,
                    // onEdit: (value) {
                    //   Operadores.editActivity(
                    //       context: context,
                    //       tittle: "Editar . . . ",
                    //       message: "¿Sodio Sérico? . . . ",
                    //       onAcept: (value) {
                    //         Terminal.printSuccess(message: "recieve $value");
                    //         setState(() {
                    //           Valores.sodio = double.parse(value);
                    //           Navigator.of(context).pop();
                    //         });
                    //       });
                    // },
                  ),
                  ValuePanel(
                    firstText: "Potasio Sérico",
                    secondText: Valores.potasio.toString(),
                    thirdText: "mEq/L",
                    withEditMessage: true,
                    // onEdit: (value) {
                    //   Operadores.editActivity(
                    //       context: context,
                    //       tittle: "Editar . . . ",
                    //       message: "¿Potasio Sérico? . . . ",
                    //       onAcept: (value) {
                    //         Terminal.printSuccess(message: "recieve $value");
                    //         setState(() {
                    //           Valores.potasio = double.parse(value);
                    //           Navigator.of(context).pop();
                    //         });
                    //       });
                    // },
                  ),
                  ValuePanel(
                    firstText: "Cloro Sérico",
                    secondText: Valores.cloro.toString(),
                    thirdText: "mg/dL",
                    withEditMessage: true,
                    // onEdit: (value) {
                    //   Operadores.editActivity(
                    //       context: context,
                    //       tittle: "Editar . . . ",
                    //       message: "¿Cloro Sérico? . . . ",
                    //       onAcept: (value) {
                    //         Terminal.printSuccess(message: "recieve $value");
                    //         setState(() {
                    //           Valores.cloro = double.parse(value);
                    //           Navigator.of(context).pop();
                    //         });
                    //       });
                    // },
                  ),
                  ValuePanel(
                    firstText: "Calcio Sérico",
                    secondText: Valores.calcio.toString(),
                    thirdText: "mg/gL",
                    withEditMessage: true,
                    // onEdit: (value) {
                    //   Operadores.editActivity(
                    //       context: context,
                    //       tittle: "Editar . . . ",
                    //       message: "¿Calcio Sérico? . . . ",
                    //       onAcept: (value) {
                    //         Terminal.printSuccess(message: "recieve $value");
                    //         setState(() {
                    //           Valores.calcio = double.parse(value);
                    //           Navigator.of(context).pop();
                    //         });
                    //       });
                    // },
                  ),
                  ValuePanel(
                    firstText: "Fósforo Sérico",
                    secondText: Valores.fosforo.toString(),
                    thirdText: "mg/dL",
                    withEditMessage: true,
                    // onEdit: (value) {
                    //   Operadores.editActivity(
                    //       context: context,
                    //       tittle: "Editar . . . ",
                    //       message: "¿Fósforo Sérico? . . . ",
                    //       onAcept: (value) {
                    //         Terminal.printSuccess(message: "recieve $value");
                    //         setState(() {
                    //           Valores.fosforo = double.parse(value);
                    //           Navigator.of(context).pop();
                    //         });
                    //       });
                    // },
                  ),
                  ValuePanel(
                    firstText: "Magnesio Sérico",
                    secondText: Valores.magnesio.toString(),
                    thirdText: "mg/gL",
                    withEditMessage: true,
                    // onEdit: (value) {
                    //   Operadores.editActivity(
                    //       context: context,
                    //       tittle: "Editar . . . ",
                    //       message: "¿Magnesio Sérico? . . . ",
                    //       onAcept: (value) {
                    //         Terminal.printSuccess(message: "recieve $value");
                    //         setState(() {
                    //           Valores.magnesio = double.parse(value);
                    //           Navigator.of(context).pop();
                    //         });
                    //       });
                    // },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Column electrolitos(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: isMobile(context) ? 2 : 1,
          child: ValuePanel(
            firstText: "",
            secondText: Valores.fechaElectrolitos.toString(),
            thirdText: "",
          ),
        ),
        Expanded(
          flex: 8,
          child: GridView(
            padding: const EdgeInsets.all(5.0),
            controller: ScrollController(),
            gridDelegate: GridViewTools.gridDelegate(
                crossAxisCount: isMobile(context) ? 2 : 5,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                mainAxisExtent: 66), //46
            children: [
              Container(),
              ValuePanel(
                firstText: "Sodio Sérico",
                secondText: Valores.sodio.toString(),
                thirdText: "mEq/L",
                withEditMessage: true,
                // onEdit: (value) {
                //   Operadores.editActivity(
                //       context: context,
                //       tittle: "Editar . . . ",
                //       message: "¿Sodio Sérico? . . . ",
                //       onAcept: (value) {
                //         Terminal.printSuccess(message: "recieve $value");
                //         setState(() {
                //           Valores.sodio = double.parse(value);
                //           Navigator.of(context).pop();
                //         });
                //       });
                // },
              ),
              Container(),
              ValuePanel(
                firstText: "Potasio Sérico",
                secondText: Valores.potasio.toString(),
                thirdText: "mEq/L",
                withEditMessage: true,
                // onEdit: (value) {
                //   Operadores.editActivity(
                //       context: context,
                //       tittle: "Editar . . . ",
                //       message: "¿Potasio Sérico? . . . ",
                //       onAcept: (value) {
                //         Terminal.printSuccess(message: "recieve $value");
                //         setState(() {
                //           Valores.potasio = double.parse(value);
                //           Navigator.of(context).pop();
                //         });
                //       });
                // },
              ),
              Container(),
              Container(),
              Container(),
              ValuePanel(
                firstText: "Cloro Sérico",
                secondText: Valores.cloro.toString(),
                thirdText: "mg/dL",
                withEditMessage: true,
                // onEdit: (value) {
                //   Operadores.editActivity(
                //       context: context,
                //       tittle: "Editar . . . ",
                //       message: "¿Cloro Sérico? . . . ",
                //       onAcept: (value) {
                //         Terminal.printSuccess(message: "recieve $value");
                //         setState(() {
                //           Valores.cloro = double.parse(value);
                //           Navigator.of(context).pop();
                //         });
                //       });
                // },
              ),
              Container(),
              Container(),
              Container(),
              ValuePanel(
                firstText: "Calcio Sérico",
                secondText: Valores.calcio.toString(),
                thirdText: "mg/gL",
                withEditMessage: true,
                // onEdit: (value) {
                //   Operadores.editActivity(
                //       context: context,
                //       tittle: "Editar . . . ",
                //       message: "¿Calcio Sérico? . . . ",
                //       onAcept: (value) {
                //         Terminal.printSuccess(message: "recieve $value");
                //         setState(() {
                //           Valores.calcio = double.parse(value);
                //           Navigator.of(context).pop();
                //         });
                //       });
                // },
              ),
              ValuePanel(
                firstText: "Fósforo Sérico",
                secondText: Valores.fosforo.toString(),
                thirdText: "mg/dL",
                withEditMessage: true,
                // onEdit: (value) {
                //   Operadores.editActivity(
                //       context: context,
                //       tittle: "Editar . . . ",
                //       message: "¿Fósforo Sérico? . . . ",
                //       onAcept: (value) {
                //         Terminal.printSuccess(message: "recieve $value");
                //         setState(() {
                //           Valores.fosforo = double.parse(value);
                //           Navigator.of(context).pop();
                //         });
                //       });
                // },
              ),
              ValuePanel(
                firstText: "Magnesio Sérico",
                secondText: Valores.magnesio.toString(),
                thirdText: "mg/gL",
                withEditMessage: true,
                // onEdit: (value) {
                //   Operadores.editActivity(
                //       context: context,
                //       tittle: "Editar . . . ",
                //       message: "¿Magnesio Sérico? . . . ",
                //       onAcept: (value) {
                //         Terminal.printSuccess(message: "recieve $value");
                //         setState(() {
                //           Valores.magnesio = double.parse(value);
                //           Navigator.of(context).pop();
                //         });
                //       });
                // },
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Container arteriales(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  ValuePanel(
                    firstText: "",
                    secondText: Valores.fechaGasometriaArterial.toString(),
                    thirdText: "",
                  ),
                  CrossLine(),
                  ValuePanel(
                    firstText: "pH Arterial",
                    secondText: Valores.pHArteriales.toString(),
                    thirdText: "",
                    withEditMessage: true,
                    onEdit: (value) {
                      Operadores.editActivity(
                          context: context,
                          keyBoardType: TextInputType.number,
                          tittle: "Editar . . . ",
                          message: "¿pH Arterial? . . . ",
                          onAcept: (value) {
                            Valores.pHArteriales = double.parse(value);
                          });
                    },
                  ),
                  ValuePanel(
                    firstText: "pCO2 Arterial",
                    secondText: Valores.pcoArteriales.toString(),
                    thirdText: "mmHg",
                    withEditMessage: true,
                    // onEdit: (value) {
                    //   Operadores.editActivity(
                    //       context: context,
                    //       tittle: "Editar . . . ",
                    //       message: "¿pCO2 Arterial? . . . ",
                    //       onAcept: (value) {
                    //         Terminal.printSuccess(message: "recieve $value");
                    //         setState(() {
                    //           Valores.pcoArteriales = double.parse(value);
                    //           Navigator.of(context).pop();
                    //         });
                    //       });
                    // },
                  ),
                  ValuePanel(
                    firstText: "pO2 Arterial",
                    secondText: Valores.poArteriales.toString(),
                    thirdText: "mmHg",
                    withEditMessage: true,
                    // onEdit: (value) {
                    //   Operadores.editActivity(
                    //       context: context,
                    //       tittle: "Editar . . . ",
                    //       message: "¿pO2 Arteriales? . . . ",
                    //       onAcept: (value) {
                    //         Terminal.printSuccess(message: "recieve $value");
                    //         setState(() {
                    //           Valores.poArteriales = double.parse(value);
                    //           Navigator.of(context).pop();
                    //         });
                    //       });
                    // },
                  ),
                  ValuePanel(
                    firstText: "HCO3- Arterial",
                    secondText: Valores.bicarbonatoArteriales.toString(),
                    thirdText: "mmol/L",
                    withEditMessage: true,
                    // onEdit: (value) {
                    //   Operadores.editActivity(
                    //       context: context,
                    //       keyBoardType: TextInputType.number,
                    //       tittle: "Editar . . . ",
                    //       message: "¿HCO3- Arterial? . . . ",
                    //       onAcept: (value) {
                    //         Terminal.printSuccess(message: "recieve $value");
                    //         setState(() {
                    //           Valores.bicarbonatoArteriales = double.parse(value);
                    //           Navigator.of(context).pop();
                    //         });
                    //       });
                    // },
                  ),
                  ValuePanel(
                    firstText: "SaO2",
                    secondText: Valores.soArteriales.toString(),
                    thirdText: "%",
                    withEditMessage: true,
                    // onEdit: (value) {
                    //   Operadores.editActivity(
                    //       context: context,
                    //       keyBoardType: TextInputType.number,
                    //       tittle: "Editar . . . ",
                    //       message: "¿SO2 Arterial? . . . ",
                    //       onAcept: (value) {
                    //         Terminal.printSuccess(message: "recieve $value");
                    //         setState(() {
                    //           Valores.soArteriales = double.parse(value);
                    //           Navigator.of(context).pop();
                    //         });
                    //       });
                    // },
                  ),
                ],
              ),
            ),
            Expanded(
                child: Column(
              children: [
                ValuePanel(
                  firstText: "",
                  secondText: Valores.fechaGasometriaVenosa.toString(),
                  thirdText: "",
                ),
                CrossLine(),
                ValuePanel(
                  firstText: "pH Venoso",
                  secondText: Valores.pHVenosos.toString(),
                  thirdText: "",
                  withEditMessage: true,
                  // onEdit: (value) {
                  //   Operadores.editActivity(
                  //       context: context,
                  //       keyBoardType: TextInputType.number,
                  //       tittle: "Editar . . . ",
                  //       message: "¿pH Venoso? . . . ",
                  //       onAcept: (value) {
                  //         Terminal.printSuccess(message: "recieve $value");
                  //         setState(() {
                  //           Valores.pHVenosos = double.parse(value);
                  //           Navigator.of(context).pop();
                  //         });
                  //       });
                  // },
                ),
                ValuePanel(
                  firstText: "pCO2 Venoso",
                  secondText: Valores.pcoVenosos.toString(),
                  thirdText: "mmHg",
                  withEditMessage: true,
                  // onEdit: (value) {
                  //   Operadores.editActivity(
                  //       context: context,
                  //       tittle: "Editar . . . ",
                  //       message: "¿pCO2 Venoso? . . . ",
                  //       onAcept: (value) {
                  //         Terminal.printSuccess(message: "recieve $value");
                  //         setState(() {
                  //           Valores.pcoVenosos = double.parse(value);
                  //           Navigator.of(context).pop();
                  //         });
                  //       });
                  // },
                ),
                ValuePanel(
                  firstText: "pO2 Venoso",
                  secondText: Valores.poVenosos.toString(),
                  thirdText: "mmHg",
                  withEditMessage: true,
                  // onEdit: (value) {
                  //   Operadores.editActivity(
                  //       context: context,
                  //       tittle: "Editar . . . ",
                  //       message: "¿pO2 Venosos? . . . ",
                  //       onAcept: (value) {
                  //         Terminal.printSuccess(message: "recieve $value");
                  //         setState(() {
                  //           Valores.poVenosos = double.parse(value);
                  //           Navigator.of(context).pop();
                  //         });
                  //       });
                  // },
                ),
                ValuePanel(
                  firstText: "HCO3- Venoso",
                  secondText: Valores.bicarbonatoVenosos.toString(),
                  thirdText: "mmol/L",
                  withEditMessage: true,
                  // onEdit: (value) {
                  //   Operadores.editActivity(
                  //       context: context,
                  //       keyBoardType: TextInputType.number,
                  //       tittle: "Editar . . . ",
                  //       message: "¿HCO3- Venoso? . . . ",
                  //       onAcept: (value) {
                  //         Terminal.printSuccess(message: "recieve $value");
                  //         setState(() {
                  //           Valores.bicarbonatoVenosos = double.parse(value);
                  //           Navigator.of(context).pop();
                  //         });
                  //       });
                  // },
                ),
                ValuePanel(
                  firstText: "SaO2",
                  secondText: Valores.soVenosos.toString(),
                  thirdText: "%",
                  withEditMessage: true,
                  // onEdit: (value) {
                  //   Operadores.editActivity(
                  //       context: context,
                  //       keyBoardType: TextInputType.number,
                  //       tittle: "Editar . . . ",
                  //       message: "¿SO2 Venoso? . . . ",
                  //       onAcept: (value) {
                  //         Terminal.printSuccess(message: "recieve $value");
                  //         setState(() {
                  //           Valores.soVenosos = double.parse(value);
                  //           Navigator.of(context).pop();
                  //         });
                  //       });
                  // },
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  static Column balances(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: isMobile(context) ? 2 : 1,
          child: ValuePanel(
            firstText: "",
            secondText: Valores.fechaRealizacionBalances.toString(),
            thirdText: "",
          ),
        ),
        Expanded(
          flex: 8,
          child: GridView(
            padding: const EdgeInsets.all(5.0),
            controller: ScrollController(),
            gridDelegate: GridViewTools.gridDelegate(
                crossAxisCount: isMobile(context) ? 2 : 5,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                mainAxisExtent: 66), //46
            children: [
              ValuePanel(
                secondText: Valores.fechaRealizacionBalances,
              ),
              ValuePanel(
                firstText: "Ingresos",
                secondText: Valores.ingresosBalances.toStringAsFixed(0),
                thirdText: "mL",
              ),
              ValuePanel(
                firstText: "Egresos",
                secondText: Valores.egresosBalances.toStringAsFixed(0),
                thirdText: "mL",
              ),
              ValuePanel(
                firstText: "Balance Total",
                secondText: Valores.balanceTotal.toStringAsFixed(0),
                thirdText: "mL",
              ),
              CrossLine(),
              ValuePanel(
                firstText: "P. Insensibles",
                secondText: Valores.perdidasInsensibles.toStringAsFixed(0),
                thirdText: "mL",
              ),
              ValuePanel(
                firstText: "Uresis",
                secondText: Valores.uresis!.toStringAsFixed(0),
                thirdText: "mL",
              ),
              ValuePanel(
                firstText: "Diuresis",
                secondText: Valores.diuresis.toStringAsFixed(2),
                thirdText: "mL",
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Container hepaticos(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ValuePanel(
            firstText: "",
            secondText: Valores.fechaHepaticos.toString(),
            thirdText: "",
          ),
          CrossLine(),
          Expanded(
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ValuePanel(
                          firstText: "BT",
                          secondText:
                              Valores.bilirrubinasTotales!.toStringAsFixed(2),
                          thirdText: "mg/dL",
                        ),
                        ValuePanel(
                          firstText: "BD",
                          secondText:
                              Valores.bilirrubinaDirecta!.toStringAsFixed(2),
                          thirdText: "mg/dL",
                        ),
                        ValuePanel(
                          firstText: "BI",
                          secondText:
                              Valores.bilirrubinaIndirecta!.toStringAsFixed(2),
                          thirdText: "mg/dL",
                        ),
                        ValuePanel(
                          firstText: "ALT / TGA",
                          secondText: Valores.alaninoaminotrasferasa!
                              .toStringAsFixed(0),
                          thirdText: "UI/L",
                        ),
                        ValuePanel(
                          firstText: "AST / TGO",
                          secondText: Valores.aspartatoaminotransferasa!
                              .toStringAsFixed(0),
                          thirdText: "UI/L",
                        ),
                        ValuePanel(
                          firstText: "GGT",
                          secondText: Valores.glutrailtranspeptidasa!
                              .toStringAsFixed(0),
                          thirdText: "UI/L",
                        ),
                        ValuePanel(
                          firstText: "FA",
                          secondText:
                              Valores.fosfatasaAlcalina!.toStringAsFixed(0),
                          thirdText: "UI/L",
                        ),
                        ValuePanel(
                          firstText: "Albúmina",
                          secondText:
                              Valores.albuminaSerica!.toStringAsFixed(1),
                          thirdText: "g/dL",
                        ),
                        ValuePanel(
                          firstText: "Proteínas Totales",
                          secondText:
                              Valores.proteinasTotales!.toStringAsFixed(1),
                          thirdText: "g/dL",
                        ),
                        CrossLine(),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      ValuePanel(
                        firstText: "AST/ALT",
                        secondText:
                            Hepatometrias.relacionASTALT.toStringAsFixed(2),
                        thirdText: "",
                      ),
                      ValuePanel(
                        firstText: "ALT/FA",
                        secondText:
                            Hepatometrias.relacionALTFA.toStringAsFixed(2),
                        thirdText: "",
                      ),
                      ValuePanel(
                        firstText: "Factor R",
                        secondText: Hepatometrias.factorR.toStringAsFixed(2),
                        thirdText: "",
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // **** ********** ********* *****************
  static Column ventilaciones(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: isMobile(context) ? 3 : 1,
          child: ValuePanel(
            firstText: "",
            secondText: Valores.fechaVentilaciones.toString(),
            thirdText: "",
          ),
        ),
        Expanded(
            flex: isMobile(context) ? 4 : 1,
            child: ValuePanel(
              firstText: "",
              secondText: Valores.modalidadVentilatoria.toString(),
              thirdText: "",
              withEditMessage: true,
              onEdit: (value) {},
            )),
        Expanded(
          flex: 8,
          child: GridView(
            padding: const EdgeInsets.all(5.0),
            controller: ScrollController(),
            gridDelegate: GridViewTools.gridDelegate(
                crossAxisCount: isMobile(context) ? 2 : 5,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                mainAxisExtent: 66), //46
            children: [
              ValuePanel(
                firstText: "Vt",
                secondText: Valores.volumenTidal.toString(),
                thirdText: "mL/min",
                withEditMessage: true,
                // onEdit: (value) {
                //   Operadores.editActivity(
                //       context: context,
                //       keyBoardType: TextInputType.number,
                //       tittle: "Editar . . . ",
                //       message: "¿Volumen Tidal? . . . ",
                //       onAcept: (value) {
                //         Terminal.printSuccess(message: "recieve $value");
                //         setState(() {
                //           Valores.volumenTidal = double.parse(value);
                //           Navigator.of(context).pop();
                //         });
                //       });
                // },
              ),
              ValuePanel(
                firstText: "F. Vent.",
                secondText: Valores.frecuenciaVentilatoria.toString(),
                thirdText: "Vent/min",
                withEditMessage: true,
                // onEdit: (value) {
                //   Operadores.editActivity(
                //       context: context,
                //       tittle: "Editar . . . ",
                //       message: "¿Frecuencia Ventilatoria? . . . ",
                //       onAcept: (value) {
                //         Terminal.printSuccess(message: "recieve $value");
                //         setState(() {
                //           Valores.frecuenciaVentilatoria = int.parse(value);
                //           Navigator.of(context).pop();
                //         });
                //       });
                // },
              ),
              ValuePanel(
                firstText: "P.E.E.P.",
                secondText: Valores.presionFinalEsiracion.toString(),
                thirdText: "cmH2O",
                withEditMessage: true,
                // onEdit: (value) {
                //   Operadores.editActivity(
                //       context: context,
                //       tittle: "Editar . . . ",
                //       message: "¿P.E.E.P.? . . . ",
                //       onAcept: (value) {
                //         Terminal.printSuccess(message: "recieve $value");
                //         setState(() {
                //           Valores.presionFinalEsiracion = int.parse(value);
                //           Navigator.of(context).pop();
                //         });
                //       });
                // },
              ),
              ValuePanel(
                firstText: "FiO2",
                secondText: Valores.fraccionInspiratoriaVentilatoria.toString(),
                thirdText: "%",
                withEditMessage: true,
                // onEdit: (value) {
                //   Operadores.editActivity(
                //       context: context,
                //       tittle: "Editar . . . ",
                //       message: "¿FiO2 Programado? . . . ",
                //       onAcept: (value) {
                //         Terminal.printSuccess(message: "recieve $value");
                //         setState(() {
                //           Valores.fraccionInspiratoriaVentilatoria =
                //               int.parse(value);
                //           Navigator.of(context).pop();
                //         });
                //       });
                // },
              ),
              ValuePanel(
                firstText: "Presión Control",
                secondText: Valores.presionControl.toString(),
                thirdText: "cmH2O",
                withEditMessage: true,
                // onEdit: (value) {
                //   Operadores.editActivity(
                //       context: context,
                //       tittle: "Editar . . . ",
                //       message: "¿Presión Control? . . . ",
                //       onAcept: (value) {
                //         Terminal.printSuccess(message: "recieve $value");
                //         setState(() {
                //           Valores.presionControl = int.parse(value);
                //           Navigator.of(context).pop();
                //         });
                //       });
                // },
              ),
              ValuePanel(
                firstText: "P. Peak",
                secondText: Valores.presionInspiratoriaPico.toString(),
                thirdText: "cmH2O",
                withEditMessage: true,
                // onEdit: (value) {
                //   Operadores.editActivity(
                //       context: context,
                //       tittle: "Editar . . . ",
                //       message: "¿P. Peak? . . . ",
                //       onAcept: (value) {
                //         Terminal.printSuccess(message: "recieve $value");
                //         setState(() {
                //           Valores.presionInspiratoriaPico = int.parse(value);
                //           Navigator.of(context).pop();
                //         });
                //       });
                // },
              ),
              ValuePanel(
                firstText: "V. Vent. ",
                secondText: Valores.volumenVentilatorio.toString(),
                thirdText: "mL/min",
                withEditMessage: true,
                // onEdit: (value) {
                //   Operadores.editActivity(
                //       context: context,
                //       tittle: "Editar . . . ",
                //       message: "¿Volumen Ventilatorio? . . . ",
                //       onAcept: (value) {
                //         Terminal.printSuccess(message: "recieve $value");
                //         setState(() {
                //           Valores.volumenVentilatorio = int.parse(value);
                //           Navigator.of(context).pop();
                //         });
                //       });
                // },
              ),
            ],
          ),
        ),
        // Expanded(
        //   flex: 4,
        //   child: GridView(
        //     padding: const EdgeInsets.all(5.0),
        //     controller: ScrollController(),
        //     gridDelegate: GridViewTools.gridDelegate(
        //         crossAxisCount: isMobile(context) ? 4 : 5, mainAxisExtent: 66), //46
        //     children: [
        //
        //       ValuePanel(
        //         firstText: "Vt",
        //         secondText: Valores.volumenTidal.toString(),
        //         thirdText: "mL/min",
        //         withEditMessage: true,
        //         onEdit: (value) {
        //           Operadores.editActivity(
        //               context: context,
        //               keyBoardType: TextInputType.number,
        //               tittle: "Editar . . . ",
        //               message: "¿Volumen Tidal? . . . ",
        //               onAcept: (value) {
        //                 Terminal.printSuccess(message: "recieve $value");
        //                 setState(() {
        //                   Valores.volumenTidal = double.parse(value);
        //                   Navigator.of(context).pop();
        //                 });
        //               });
        //         },
        //       ),
        //       ValuePanel(
        //         firstText: "F. Vent.",
        //         secondText: Valores.frecuenciaVentilatoria.toString(),
        //         thirdText: "Vent/min",
        //         withEditMessage: true,
        //         onEdit: (value) {
        //           Operadores.editActivity(
        //               context: context,
        //               tittle: "Editar . . . ",
        //               message: "¿Frecuencia Ventilatoria? . . . ",
        //               onAcept: (value) {
        //                 Terminal.printSuccess(message: "recieve $value");
        //                 setState(() {
        //                   Valores.frecuenciaVentilatoria = int.parse(value);
        //                   Navigator.of(context).pop();
        //                 });
        //               });
        //         },
        //       ),
        //       ValuePanel(
        //         firstText: "P.E.E.P.",
        //         secondText: Valores.presionFinalEsiracion.toString(),
        //         thirdText: "cmH2O",
        //         withEditMessage: true,
        //         onEdit: (value) {
        //           Operadores.editActivity(
        //               context: context,
        //               tittle: "Editar . . . ",
        //               message: "¿P.E.E.P.? . . . ",
        //               onAcept: (value) {
        //                 Terminal.printSuccess(message: "recieve $value");
        //                 setState(() {
        //                   Valores.presionFinalEsiracion = int.parse(value);
        //                   Navigator.of(context).pop();
        //                 });
        //               });
        //         },
        //       ),
        //       ValuePanel(
        //         firstText: "FiO2",
        //         secondText: Valores.fraccionInspiratoriaVentilatoria.toString(),
        //         thirdText: "%",
        //         withEditMessage: true,
        //         onEdit: (value) {
        //           Operadores.editActivity(
        //               context: context,
        //               tittle: "Editar . . . ",
        //               message: "¿FiO2 Programado? . . . ",
        //               onAcept: (value) {
        //                 Terminal.printSuccess(message: "recieve $value");
        //                 setState(() {
        //                   Valores.fraccionInspiratoriaVentilatoria = int.parse(value);
        //                   Navigator.of(context).pop();
        //                 });
        //               });
        //         },
        //       ),
        //       ValuePanel(
        //         firstText: "Presión Control",
        //         secondText: Valores.presionControl.toString(),
        //         thirdText: "cmH2O",
        //         withEditMessage: true,
        //         onEdit: (value) {
        //           Operadores.editActivity(
        //               context: context,
        //               tittle: "Editar . . . ",
        //               message: "¿Presión Control? . . . ",
        //               onAcept: (value) {
        //                 Terminal.printSuccess(message: "recieve $value");
        //                 setState(() {
        //                   Valores.presionControl = int.parse(value);
        //                   Navigator.of(context).pop();
        //                 });
        //               });
        //         },
        //       ),
        //       ValuePanel(
        //         firstText: "P. Peak",
        //         secondText: Valores.presionInspiratoriaPico.toString(),
        //         thirdText: "cmH2O",
        //         withEditMessage: true,
        //         onEdit: (value) {
        //           Operadores.editActivity(
        //               context: context,
        //               tittle: "Editar . . . ",
        //               message: "¿P. Peak? . . . ",
        //               onAcept: (value) {
        //                 Terminal.printSuccess(message: "recieve $value");
        //                 setState(() {
        //                   Valores.presionInspiratoriaPico = int.parse(value);
        //                   Navigator.of(context).pop();
        //                 });
        //               });
        //         },
        //       ),
        //       ValuePanel(
        //         firstText: "V. Vent. ",
        //         secondText: Valores.volumenVentilatorio.toString(),
        //         thirdText: "mL/min",
        //         withEditMessage: true,
        //         onEdit: (value) {
        //           Operadores.editActivity(
        //               context: context,
        //               tittle: "Editar . . . ",
        //               message: "¿Volumen Ventilatorio? . . . ",
        //               onAcept: (value) {
        //                 Terminal.printSuccess(message: "recieve $value");
        //                 setState(() {
        //                   Valores.volumenVentilatorio = int.parse(value);
        //                   Navigator.of(context).pop();
        //                 });
        //               });
        //         },
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

class Dispositivos extends StatefulWidget {
  bool? isSelected;
  String? dispositivoName, otherName, specyficName;
  Function? onChangeValue, onDoubleTap;

  Dispositivos({
    super.key,
    this.dispositivoName = "",
    this.otherName = "",
    this.specyficName = "",
    this.isSelected = false,
    required this.onChangeValue,
    this.onDoubleTap,
  });

  @override
  State<Dispositivos> createState() => _DispositivosState();
}

class _DispositivosState extends State<Dispositivos> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 0.0, left: 1.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CircleIcon(
                radios: 20,
                difRadios: 4,
                tittle: "${widget.dispositivoName}",
                iconed: widget.isSelected == true
                    ? Icons.circle
                    : widget.isSelected == false
                        ? Icons.circle_outlined
                        : Icons.abc,
                onChangeValue: () {
                  setState(() {
                    //
                    if (widget.otherName != "") {
                      widget.onChangeValue!(widget.isSelected = false);
                    } else {
                      widget.onChangeValue!(widget.isSelected = true);
                    }
                  });
                }),
          ),
          const SizedBox(width: 2.0),
          Expanded(
            child: Tooltip(
              message: widget.specyficName,
              child: GestureDetector(
                onDoubleTap: () {
                  Operadores.editActivity(
                      context: context,
                      keyBoardType: TextInputType.text,
                      onAcept: (String? value) {
                        setState(() {
                          widget.specyficName = value!;
                          // widget.onDoubleTap!(value);
                          // Terminal.printExpected(message: "${widget.specyficName}");
                          Navigator.of(context).pop();
                        });
                      });
                },
                child: Text(
                  "${widget.dispositivoName} : ${widget.otherName} \n : : ${widget.specyficName}",
                  style: Styles.textSyleGrowth(fontSize: 8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
    );
  }
}

//
class RevisionDispositivos extends StatefulWidget {
  const RevisionDispositivos({super.key});

  @override
  State<RevisionDispositivos> createState() => _RevisionDispositivosState();
}

class _RevisionDispositivosState extends State<RevisionDispositivos> {
  @override
  void initState() {
    super.initState(); // ✅ siempre primero
    Pacientes.getDispositivosHistorial().whenComplete(() {
      if (!mounted) return; // ✅ <- importante
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      controller: ScrollController(),
      child: Column(
        children: [
          CircleIcon(
              iconed: Icons.move_up_outlined,
              tittle: "Actualizar Información",
              onChangeValue: () => _operationMethod()),
          CrossLine(height: 15),
          Dispositivos(
            dispositivoName: "CVP",
            otherName: Valores.withCVP,
            onChangeValue: (esSelected) async {
              //
              if (esSelected) {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2055),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                          data: ThemeData.dark().copyWith(
                              dialogBackgroundColor: Theming.cuaternaryColor),
                          child: child!);
                    });
                if (picked != null && picked != Valores.withCVP) {
                  setState(() {
                    Valores.withCVP = DateFormat("yyyy/MM/dd").format(picked);
                  });
                }
              } else {
                setState(() {
                  Valores.withCVP = "";
                });
              }
            },
          ), // "CVP",
          Dispositivos(
            dispositivoName: "CVLP",
            otherName: Valores.withCVLP,
            onChangeValue: (esSelected) async {
              //
              if (esSelected) {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2055),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                          data: ThemeData.dark().copyWith(
                              dialogBackgroundColor: Theming.cuaternaryColor),
                          child: child!);
                    });
                if (picked != null && picked != Valores.withCVLP) {
                  setState(() {
                    Valores.withCVLP = DateFormat("yyyy/MM/dd").format(picked);
                  });
                }
              } else {
                setState(() {
                  Valores.withCVLP = "";
                });
              }
            },
          ), // "CVLP",
          Dispositivos(
            dispositivoName: "CVC",
            otherName: Valores.withCVC,
            onChangeValue: (esSelected) async {
              //
              if (esSelected) {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2055),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                          data: ThemeData.dark().copyWith(
                              dialogBackgroundColor: Theming.cuaternaryColor),
                          child: child!);
                    });
                if (picked != null && picked != Valores.withCVC) {
                  setState(() {
                    Valores.withCVC = DateFormat("yyyy/MM/dd").format(picked);
                  });
                }
              } else {
                setState(() {
                  Valores.withCVC = "";
                });
              }
            },
          ), // "CVC",
          Dispositivos(
            dispositivoName: "MAH",
            otherName: Valores.withMahurkar,
            onChangeValue: (esSelected) async {
              //
              if (esSelected) {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2055),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                          data: ThemeData.dark().copyWith(
                              dialogBackgroundColor: Theming.cuaternaryColor),
                          child: child!);
                    });
                if (picked != null && picked != Valores.withMahurkar) {
                  setState(() {
                    Valores.withMahurkar =
                        DateFormat("yyyy/MM/dd").format(picked);
                  });
                }
              } else {
                setState(() {
                  Valores.withMahurkar = "";
                });
              }
            },
          ), // "MAHA",
          Dispositivos(
            dispositivoName: "FOL",
            otherName: Valores.withFOL,
            onChangeValue: (esSelected) async {
              //
              if (esSelected) {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2055),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                          data: ThemeData.dark().copyWith(
                              dialogBackgroundColor: Theming.cuaternaryColor),
                          child: child!);
                    });
                if (picked != null && picked != Valores.withFOL) {
                  setState(() {
                    Valores.withFOL = DateFormat("yyyy/MM/dd").format(picked);
                  });
                }
              } else {
                setState(() {
                  Valores.withFOL = "";
                });
              }
            },
          ), // "FOL",
          Dispositivos(
            dispositivoName: "SNG",
            otherName: Valores.withSNG,
            onChangeValue: (esSelected) async {
              //
              if (esSelected) {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2055),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                          data: ThemeData.dark().copyWith(
                              dialogBackgroundColor: Theming.cuaternaryColor),
                          child: child!);
                    });
                if (picked != null && picked != Valores.withSNG) {
                  setState(() {
                    Valores.withSNG = DateFormat("yyyy/MM/dd").format(picked);
                  });
                }
              } else {
                setState(() {
                  Valores.withSNG = "";
                });
              }
            },
          ), // "SNG",
          Dispositivos(
            dispositivoName: "SOG",
            otherName: Valores.withSOG,
            onChangeValue: (esSelected) async {
              //
              if (esSelected) {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2055),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                          data: ThemeData.dark().copyWith(
                              dialogBackgroundColor: Theming.cuaternaryColor),
                          child: child!);
                    });
                if (picked != null && picked != Valores.withSOG) {
                  setState(() {
                    Valores.withSOG = DateFormat("yyyy/MM/dd").format(picked);
                  });
                }
              } else {
                setState(() {
                  Valores.withSOG = "";
                });
              }
            },
          ), // "SOG",
          Dispositivos(
            dispositivoName: "PEN",
            otherName: Valores.withPEN,
            onChangeValue: (esSelected) async {
              //
              if (esSelected) {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2055),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                          data: ThemeData.dark().copyWith(
                              dialogBackgroundColor: Theming.cuaternaryColor),
                          child: child!);
                    });
                if (picked != null && picked != Valores.withPEN) {
                  setState(() {
                    Valores.withPEN = DateFormat("yyyy/MM/dd").format(picked);
                  });
                }
              } else {
                setState(() {
                  Valores.withPEN = "";
                });
              }
            },
          ), // "PEN",
          Dispositivos(
            dispositivoName: "COL",
            otherName: Valores.withCOL,
            onChangeValue: (esSelected) async {
              //
              if (esSelected) {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2055),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                          data: ThemeData.dark().copyWith(
                              dialogBackgroundColor: Theming.cuaternaryColor),
                          child: child!);
                    });
                if (picked != null && picked != Valores.withCOL) {
                  setState(() {
                    Valores.withCOL = DateFormat("yyyy/MM/dd").format(picked);
                  });
                }
              } else {
                setState(() {
                  Valores.withCOL = "";
                });
              }
            },
          ), // "COL",
          Dispositivos(
            dispositivoName: "SEP",
            otherName: Valores.withSEP,
            onChangeValue: (esSelected) async {
              //
              if (esSelected) {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2055),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                          data: ThemeData.dark().copyWith(
                              dialogBackgroundColor: Theming.cuaternaryColor),
                          child: child!);
                    });
                if (picked != null && picked != Valores.withSEP) {
                  setState(() {
                    Valores.withSEP = DateFormat("yyyy/MM/dd").format(picked);
                  });
                }
              } else {
                setState(() {
                  Valores.withSEP = "";
                });
              }
            },
          ), // "SEP",
          Dispositivos(
            dispositivoName: "GAS",
            otherName: Valores.withGAS,
            onChangeValue: (esSelected) async {
              //
              if (esSelected) {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2055),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                          data: ThemeData.dark().copyWith(
                              dialogBackgroundColor: Theming.cuaternaryColor),
                          child: child!);
                    });
                if (picked != null && picked != Valores.withGAS) {
                  setState(() {
                    Valores.withGAS = DateFormat("yyyy/MM/dd").format(picked);
                  });
                }
              } else {
                setState(() {
                  Valores.withGAS = "";
                });
              }
            },
          ), // "GAS",
          Dispositivos(
            dispositivoName: "TNK",
            otherName: Valores.withTNK,
            onChangeValue: (esSelected) async {
              //
              if (esSelected) {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2055),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                          data: ThemeData.dark().copyWith(
                              dialogBackgroundColor: Theming.cuaternaryColor),
                          child: child!);
                    });
                if (picked != null && picked != Valores.withTNK) {
                  setState(() {
                    Valores.withTNK = DateFormat("yyyy/MM/dd").format(picked);
                  });
                }
              } else {
                setState(() {
                  Valores.withTNK = "";
                });
              }
            },
          ), // "TNK"
        ],
      ),
    );
  }

  List<List<dynamic>> listOfValues() {
    return [
      [
        Valores.initCVP,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withCVP, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withCVP == "" ? false : true,
        Pendientes.typesPendientes[3], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[3][0],
        "",
        Valores.initCVP,
      ], // CVP
      [
        Valores.initCVLP,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withCVLP, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withCVLP == "" ? false : true,
        Pendientes.typesPendientes[3], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[3][1],
        "",
        Valores.initCVLP,
      ], // CVLP
      [
        Valores.initCVC,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withCVC, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withCVC == "" ? false : true,
        Pendientes.typesPendientes[3], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[3][2],
        "",
        Valores.initCVC,
      ], // CVC
      [
        Valores.initMahurkar,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withMahurkar, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withMahurkar == "" ? false : true,
        Pendientes.typesPendientes[3], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[3][3],
        "",
        Valores.initMahurkar,
      ], // MAHA
      [
        Valores.initFOL,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withFOL, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withFOL == "" ? false : true,
        Pendientes.typesPendientes[3], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[3][4],
        "",
        Valores.initFOL,
      ], // FOL
      [
        Valores.initSNG,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withSNG, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withSNG == "" ? false : true,
        Pendientes.typesPendientes[3], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[3][5],
        "",
        Valores.initSNG,
      ], // SNG
      [
        Valores.initSOG,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withSOG, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withSOG == "" ? false : true,
        Pendientes.typesPendientes[3], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[3][6],
        "",
        Valores.initSOG,
      ], // SOG
      [
        Valores.initPEN,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withPEN, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withPEN == "" ? false : true,
        Pendientes.typesPendientes[3], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[3][7],
        "",
        Valores.initPEN,
      ], // PEN
      [
        Valores.initCOL,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withCOL, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withCOL == "" ? false : true,
        Pendientes.typesPendientes[3], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[3][8],
        "",
        Valores.initCOL,
      ], // COL
      [
        Valores.initSEP,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withSEP, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withSEP == "" ? false : true,
        Pendientes.typesPendientes[3], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[3][9],
        "",
        Valores.initSEP,
      ], // SEP
      [
        Valores.initGAS,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withGAS, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withGAS == "" ? false : true,
        Pendientes.typesPendientes[3], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[3][10],
        "",
        Valores.initGAS,
      ], // GAS
      [
        Valores.initTNK, // 0,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withTNK, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withTNK == "" ? false : true,
        Pendientes.typesPendientes[3], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[3][11],
        "",
        Valores.initTNK, // 0,
      ], // TNK
    ];
  }

  _operationMethod() async {
    Operadores.loadingActivity(
        context: context,
        tittle: "Actualizando información . . .",
        message: "Información de Dispositivos actualizándose . . . ",
        onCloss: () {
          Navigator.of(context).pop();
        });
    //
    await Actividades.registrarAnidados(
      Databases.siteground_database_reghosp,
      Pendientes.pendientes['updateQuery'],
      listOfValues(), // Pacientes.ID_Paciente,
    ).onError((onError, stackTrace) {
      Pacientes.getDispositivosHistorial().whenComplete(() {
        Terminal.printAlert(message: "ERROR - $onError : : : $stackTrace");
        Operadores.alertActivity(
          context: context,
          tittle: "$onError . . .",
          message: "$stackTrace",
          onAcept: ()=>Navigator.of(context).pop(),
        );
      });
      return "$onError";
    }).whenComplete(() {
      Pacientes.getDispositivosHistorial().then((onValue) {
        // Terminal.printAlert(message: "ON_VALUE : $onValue");
      }).whenComplete(() {
        //
        Navigator.of(context).pop(); // Cierre del LoadActivity
        Operadores.alertActivity(
            context: context,
            tittle: "Actualizando información . . .",
            message: "Información actualizada",
            onAcept: () {
              // Se emplean 3 Navigator.of(context).pop(); para cerrar cada una de
              //    las ventanas emergentes y la interfaz inicial.
              Navigator.of(context).pop(); // Cierre de la Interfaz Inicial
              Navigator.of(context).pop(); // Cierre del AlertActivity
            });
      });
    });
    //
    // Future.forEach(listOfValues(), (element) async {
    //   var aux = element as List<dynamic>;
    //
    //   Terminal.printData(message: "$aux : :  ${aux[3]}");
    //   //
    //   await Actividades.actualizar(
    //     Databases.siteground_database_reghosp,
    //     Pendientes.pendientes['updateQuery'],
    //     element,
    //     Pacientes.ID_Paciente,
    //   );
    //   // if (aux[3] != '' && aux[3] != null)
    // }).whenComplete(() {
    //   Pacientes.getDispositivosHistorial().then((onValue) {
    //     // Terminal.printAlert(message: "ON_VALUE : $onValue");
    //   }).whenComplete(() {
    //     //
    //     Navigator.of(context).pop(); // Cierre del LoadActivity
    //     Operadores.alertActivity(
    //         context: context,
    //         tittle: "Actualizando información . . .",
    //         message: "Información actualizada",
    //         onAcept: () {
    //           // Se emplean 3 Navigator.of(context).pop(); para cerrar cada una de
    //           //    las ventanas emergentes y la interfaz inicial.
    //           Navigator.of(context).pop(); // Cierre de la Interfaz Inicial
    //           Navigator.of(context).pop(); // Cierre del AlertActivity
    //         });
    //   });
    //   //
    // }).onError((error, stackTrace) {
    //   Pacientes.getDispositivosHistorial().whenComplete(() {
    //     Terminal.printAlert(message: "ERROR - $error : : : $stackTrace");
    //     Operadores.alertActivity(
    //       context: context,
    //       tittle: "$error . . .",
    //       message: "$stackTrace",
    //     );
    //   });
    //   //
    // });
  }
}

//
class RevisionPrevios extends StatefulWidget {
  const RevisionPrevios({super.key});

  @override
  State<RevisionPrevios> createState() => _RevisionPreviosState();
}

class _RevisionPreviosState extends State<RevisionPrevios> {
  @override
  void initState() {
    super.initState(); // ✅ siempre primero
    Pacientes.getPreviosHistorial().whenComplete(() {
      if (!mounted) return; // ✅ <- importante
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      controller: ScrollController(),
      child: Column(
        children: [
          Dispositivos(
            dispositivoName: "MAVA\n",
            otherName: Valores.withMAVA,
            onChangeValue: (esSelected) async {
              //
              if (esSelected) {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2055),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                          data: ThemeData.dark().copyWith(
                              dialogBackgroundColor: Theming.cuaternaryColor),
                          child: child!);
                    });
                if (picked != null && picked != Valores.withMAVA) {
                  setState(() {
                    Valores.withMAVA = DateFormat("yyyy/MM/dd").format(picked);
                  });
                }
              } else {
                setState(() {
                  Valores.withMAVA = "";
                });
              }
            },
          ), // "MAVA",
          Dispositivos(
            dispositivoName: "IOT\n",
            otherName: Valores.withIOT,
            onChangeValue: (esSelected) async {
              //
              if (esSelected) {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2055),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                          data: ThemeData.dark().copyWith(
                              dialogBackgroundColor: Theming.cuaternaryColor),
                          child: child!);
                    });
                if (picked != null && picked != Valores.withIOT) {
                  setState(() {
                    Valores.withIOT = DateFormat("yyyy/MM/dd").format(picked);
                  });
                }
              } else {
                setState(() {
                  Valores.withIOT = "";
                });
              }
            },
          ), // "IOT",
          Dispositivos(
            dispositivoName: "EXT\n",
            otherName: Valores.withEXT,
            onChangeValue: (esSelected) async {
              //
              if (esSelected) {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2055),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                          data: ThemeData.dark().copyWith(
                              dialogBackgroundColor: Theming.cuaternaryColor),
                          child: child!);
                    });
                if (picked != null && picked != Valores.withEXT) {
                  setState(() {
                    Valores.withEXT = DateFormat("yyyy/MM/dd").format(picked);
                  });
                }
              } else {
                setState(() {
                  Valores.withEXT = "";
                });
              }
            },
          ), // "EXT",
          Dispositivos(
            dispositivoName: "MAH\n",
            otherName: Valores.withTRAN,
            onChangeValue: (esSelected) async {
              //
              if (esSelected) {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2055),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                          data: ThemeData.dark().copyWith(
                              dialogBackgroundColor: Theming.cuaternaryColor),
                          child: child!);
                    });
                if (picked != null && picked != Valores.withTRAN) {
                  setState(() {
                    Valores.withTRAN = DateFormat("yyyy/MM/dd").format(picked);
                  });
                }
              } else {
                setState(() {
                  Valores.withTRAN = "";
                });
              }
            },
          ), // "TRAN",
          Dispositivos(
            dispositivoName: "HEMO\n",
            otherName: Valores.withHEMO,
            onChangeValue: (esSelected) async {
              //
              if (esSelected) {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2055),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                          data: ThemeData.dark().copyWith(
                              dialogBackgroundColor: Theming.cuaternaryColor),
                          child: child!);
                    });
                if (picked != null && picked != Valores.withHEMO) {
                  setState(() {
                    Valores.withHEMO = DateFormat("yyyy/MM/dd").format(picked);
                  });
                }
              } else {
                setState(() {
                  Valores.withHEMO = "";
                });
              }
            },
          ), // "HEMO",
          Dispositivos(
            dispositivoName: "QUIR\n",
            otherName: Valores.withQUIR,
            onChangeValue: (esSelected) async {
              //
              if (esSelected) {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2055),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                          data: ThemeData.dark().copyWith(
                              dialogBackgroundColor: Theming.cuaternaryColor),
                          child: child!);
                    });
                if (picked != null && picked != Valores.withQUIR) {
                  setState(() {
                    Valores.withQUIR = DateFormat("yyyy/MM/dd").format(picked);
                  });
                }
              } else {
                setState(() {
                  Valores.withQUIR = "";
                });
              }
            },
          ), // "QUIR",
          CrossLine(height: 15),
          CircleIcon(
              iconed: Icons.move_up_outlined,
              tittle: "Actualizar Información",
              onChangeValue: () => _operationMethod()),
        ],
      ),
    );
  }

  List<List<dynamic>> listOfValues() {
    return [
      [
        Valores.initMAVA,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withMAVA, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withMAVA == "" ? false : true,
        Pendientes.typesPendientes[0], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[0][0],
        "",
        Valores.initMAVA,
      ], // MAVA
      [
        Valores.initIOT,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withIOT, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withIOT == "" ? false : true,
        Pendientes.typesPendientes[0], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[0][1],
        "",
        Valores.initIOT,
      ], // IOT
      [
        Valores.initEXT,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withEXT, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withEXT == "" ? false : true,
        Pendientes.typesPendientes[0], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[0][2],
        "",
        Valores.initEXT,
      ], // EXT
      [
        Valores.initTRAN,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withTRAN, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withTRAN == "" ? false : true,
        Pendientes.typesPendientes[0], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[0][0],
        "",
        Valores.initTRAN,
      ], // TRAN
      [
        Valores.initHEMO,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withHEMO, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withHEMO == "" ? false : true,
        Pendientes.typesPendientes[0], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[0][4],
        "",
        Valores.initHEMO,
      ], // HEMO
      [
        Valores.initQUIR,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withQUIR, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withQUIR == "" ? false : true,
        Pendientes.typesPendientes[0], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[0][5],
        "",
        Valores.initQUIR,
      ], // QUIR
    ];
  }

  //    "updateQuery": "UPDATE pace_pen "
  //         "SET ID_Pace_Pen = ?,  ID_Pace = ?,  ID_Hosp = ?,  "
  //         "Feca_PEN = ?,  "
  //         "Pace_PEN_realized = ?, "
  //         "Pace_PEN = ?,  Pace_Desc_PEN = ?, "
  //         "Pace_Commen_PEN = ? "
  //         "WHERE ID_Pace_Pen = ?",
  _operationMethod() async {
    Operadores.loadingActivity(
        context: context,
        tittle: "Actualizando información . . .",
        message: "Información de Previos actualizándose . . . ",
        onCloss: () {
          Navigator.of(context).pop();
        });
    //
    await Actividades.registrarAnidados(
      Databases.siteground_database_reghosp,
      Pendientes.pendientes['updateQuery'],
      listOfValues(), // Pacientes.ID_Paciente,
    ).onError((onError, stackTrace) {
      Pacientes.getDispositivosHistorial().whenComplete(() {
        Terminal.printAlert(message: "ERROR - $onError : : : $stackTrace");
        Operadores.alertActivity(
          context: context,
          tittle: "$onError . . .",
          message: "$stackTrace",
          onAcept: ()=>Navigator.of(context).pop(),
        );
      });
      return "$onError";
    }).whenComplete(() {
      Pacientes.getDispositivosHistorial().then((onValue) {
        // Terminal.printAlert(message: " . . : Pacientes.getDispositivosHistorial "
        //     ": : ON_VALUE : ${onValue!.toString()}");
      }).whenComplete(() {
        //
        Navigator.of(context).pop(); // Cierre del LoadActivity
        Operadores.alertActivity(
            context: context,
            tittle: "Actualizando información . . .",
            message: "Información actualizada",
            onAcept: () {
              // Se emplean 3 Navigator.of(context).pop(); para cerrar cada una de
              //    las ventanas emergentes y la interfaz inicial.
              Navigator.of(context).pop(); // Cierre de la Interfaz Inicial
              Navigator.of(context).pop(); // Cierre del AlertActivity
            });
      });
    });
    //
    // Future.forEach(listOfValues(), (element) async {
    //   var aux = element as List<dynamic>;
    //
    //   Terminal.printData(message: "$aux : :  ${aux[3]}");
    //   //
    //   await Actividades.actualizar(
    //     Databases.siteground_database_reghosp,
    //     Pendientes.pendientes['updateQuery'],
    //     element,
    //     Pacientes.ID_Paciente,
    //   );
    //   // if (aux[3] != '' && aux[3] != null)
    // }).whenComplete(() {
    //   Pacientes.getDispositivosHistorial().then((onValue) {
    //     // Terminal.printAlert(message: "ON_VALUE : $onValue");
    //   }).whenComplete(() {
    //     //
    //     Navigator.of(context).pop(); // Cierre del LoadActivity
    //     Operadores.alertActivity(
    //         context: context,
    //         tittle: "Actualizando información . . .",
    //         message: "Información actualizada",
    //         onAcept: () {
    //           // Se emplean 3 Navigator.of(context).pop(); para cerrar cada una de
    //           //    las ventanas emergentes y la interfaz inicial.
    //           Navigator.of(context).pop(); // Cierre de la Interfaz Inicial
    //           Navigator.of(context).pop(); // Cierre del AlertActivity
    //         });
    //   });
    //   //
    // }).onError((error, stackTrace) {
    //   Pacientes.getDispositivosHistorial().whenComplete(() {
    //     Terminal.printAlert(message: "ERROR - $error : : : $stackTrace");
    //     Operadores.alertActivity(
    //       context: context,
    //       tittle: "$error . . .",
    //       message: "$stackTrace",
    //     );
    //   });
    //   //
    // });
  }
}

//
class RevisionCultivos extends StatefulWidget {
  List? listado;

  RevisionCultivos({super.key, required this.listado});

  @override
  State<RevisionCultivos> createState() => _RevisionCultivosState();
}

class _RevisionCultivosState extends State<RevisionCultivos> {
  @override
  void initState() {
    // TODO: implement initState
    // Terminal.printNotice(message: widget.listado!.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TittleContainer(
      tittle: "Cultivo(s) . . . ",
      color: Theming.cuaternaryColor,
      centered: false,
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: ListView.builder(
                controller: ScrollController(),
                padding: const EdgeInsets.all(1),
                itemCount: widget.listado!.length,
                itemBuilder: (BuildContext context, index) {
                  return ValuePanel(
                    fontSize: 10,
                    firstText:
                        "${widget.listado![index]['Estudio']}", // Resultado
                    secondText:
                        "${widget.listado![index]['Fecha_Registro']}", // Resultado
                    thirdText:
                        "${widget.listado![index]['Resultado']}", // Resultado
                    withEditMessage: true,
                    onEdit: (value) {
                      Datos.portapapeles(
                          context: context,
                          text: Auxiliares.porFecha(
                              fechaActual: value, esAbreviado: true));
                    },
                  );
                }),
          ),
          Expanded(
            child: CircleIcon(
                iconed: Icons.copy_all_rounded,
                onChangeValue: () => Datos.portapapeles(
                    context: context, text: Auxiliares.getCultivos())),
          ),
        ],
      ),
    );
  }
}

//
class RevisionIndicacioness extends StatefulWidget {
  List? listado = [];

  RevisionIndicacioness({super.key});

  @override
  State<RevisionIndicacioness> createState() => _RevisionIndicacionessState();
}

class _RevisionIndicacionessState extends State<RevisionIndicacioness> {
  @override
  void initState() {
    // TODO: implement initState
    Actividades.consultarAllById(
            Databases.siteground_database_reghosp,
            Pendientes.pendientes['consultIndicacionesByIdPrimaryQuery'],
            Pacientes.ID_Hospitalizacion)
        .then((onValue) {
      // Terminal.printExpected(message: onValue.toString());
      setState(() {
        widget.listado = onValue;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TittleContainer(
      tittle: "Indicaciones(s) . . . ",
      color: Theming.cuaternaryColor,
      centered: true,
      child: ListView.builder(
          controller: ScrollController(),
          padding: const EdgeInsets.all(1),
          itemCount: widget.listado!.length,
          itemBuilder: (BuildContext context, index) {
            return ValuePanel(
              fontSize: 10,
              firstText: "${widget.listado![index]['Feca_PEN']}", // Resultado
              secondText:
                  "${widget.listado![index]['Pace_Desc_PEN']}", // Resultado
              withEditMessage: true,
              onEdit: (value) {
                Datos.portapapeles(
                    context: context,
                    text: Auxiliares.porFecha(
                        fechaActual: value, esAbreviado: true));
              },
            );
          }),
    );
  }
}

//
class RevisionInfusiones extends StatefulWidget {
  const RevisionInfusiones({super.key});

  @override
  State<RevisionInfusiones> createState() => _RevisionInfusionesState();
}

class _RevisionInfusionesState extends State<RevisionInfusiones> {
  @override
  void initState() {
    // TODO: implement initState
    Pacientes.getInfusionesHistorial().whenComplete(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      controller: ScrollController(),
      child: Column(
        children: [
          Dispositivos(
            dispositivoName: "SEDA\n",
            otherName: Valores.withSedacion,
            onChangeValue: (esSelected) async {
              //
              if (esSelected) {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2055),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                          data: ThemeData.dark().copyWith(
                              dialogBackgroundColor: Theming.cuaternaryColor),
                          child: child!);
                    });
                if (picked != null && picked != Valores.withSedacion) {
                  setState(() {
                    Valores.withSedacion =
                        DateFormat("yyyy/MM/dd").format(picked);
                  });
                }
              } else {
                setState(() {
                  Valores.withSedacion = "";
                });
              }
            },
            onDoubleTap: (comenttary) => Valores.commenSedacion = comenttary,
          ), // "SEDA",
          Dispositivos(
            dispositivoName: "VASA\n",
            otherName: Valores.withSedacion,
            onChangeValue: (esSelected) async {
              //
              if (esSelected) {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2055),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                          data: ThemeData.dark().copyWith(
                              dialogBackgroundColor: Theming.cuaternaryColor),
                          child: child!);
                    });
                if (picked != null && picked != Valores.withSedacion) {
                  setState(() {
                    Valores.withSedacion =
                        DateFormat("yyyy/MM/dd").format(picked);
                  });
                }
              } else {
                setState(() {
                  Valores.withSedacion = "";
                });
              }
            },
            onDoubleTap: (comenttary) => Valores.commenSedacion = comenttary,
          ), // "VASA",
          CrossLine(height: 15),
          CircleIcon(
              iconed: Icons.move_up_outlined,
              tittle: "Actualizar Información",
              onChangeValue: () => _operationMethod()),
        ],
      ),
    );
  }

  List<List<dynamic>> listOfValues() {
    return [
      [
        Valores.initSedacion,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withSedacion, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withSedacion == "" ? false : true,
        Pendientes.typesPendientes[5], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[5][3],
        Valores.commenSedacion,
        Valores.initSedacion,
      ], // SEDA
      [
        Valores.initVasopresor,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withVasopresor, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withVasopresor == "" ? false : true,
        Pendientes.typesPendientes[5], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[5][5],
        Valores.commenVasopresor,
        Valores.initVasopresor,
      ], // VASA
      [
        Valores.initInotropico,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withInotropico, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withInotropico == "" ? false : true,
        Pendientes.typesPendientes[5], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[5][6],
        Valores.commenInotropico,
        Valores.initInotropico,
      ], // IONO
      [
        Valores.initParalisis,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withParalisis, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withParalisis == "" ? false : true,
        Pendientes.typesPendientes[5], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[5][7],
        Valores.commenParalisis,
        Valores.initParalisis,
      ], // PARA
      [
        Valores.initAntiarritmico,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withAntiarritmico, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withAntiarritmico == "" ? false : true,
        Pendientes.typesPendientes[5], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[5][4],
        Valores.commenAntiarritmico,
        Valores.initAntiarritmico,
      ], // ARRI
      [
        Valores.initAnticoagulante,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Valores
            .withAnticoagulante, // Fecha de Procedimiento : Determina si existe o no dispositivo.
        Valores.withAnticoagulante == "" ? false : true,
        Pendientes.typesPendientes[5], // Categoria de Procedimientos . . .
        Pendientes.subTypesPendientes[5][1],
        Valores.commenAnticoagulante,
        Valores.initAnticoagulante,
      ], // COAN
    ];
  }

  _operationMethod() async {
    Operadores.loadingActivity(
        context: context,
        tittle: "Actualizando información . . .",
        message: "Información de Infusiones actualizándose . . . ",
        onCloss: () {
          Navigator.of(context).pop();
        });
    //
    await Actividades.registrarAnidados(
      Databases.siteground_database_reghosp,
      Pendientes.pendientes['updateQuery'],
      listOfValues(), // Pacientes.ID_Paciente,
    ).onError((onError, stackTrace) {
      Pacientes.getDispositivosHistorial().whenComplete(() {
        Terminal.printAlert(message: "ERROR - $onError : : : $stackTrace");
        Operadores.alertActivity(
          context: context,
          tittle: "$onError . . .",
          message: "$stackTrace",
          onAcept: ()=>Navigator.of(context).pop(),
        );
      });
      return "$onError";
    }).whenComplete(() {
      Pacientes.getDispositivosHistorial().then((onValue) {
        // Terminal.printAlert(message: "ON_VALUE : $onValue");
      }).whenComplete(() {
        //
        Navigator.of(context).pop(); // Cierre del LoadActivity
        Operadores.alertActivity(
            context: context,
            tittle: "Actualizando información . . .",
            message: "Información actualizada",
            onAcept: () {
              // Se emplean 3 Navigator.of(context).pop(); para cerrar cada una de
              //    las ventanas emergentes y la interfaz inicial.
              Navigator.of(context).pop(); // Cierre de la Interfaz Inicial
              Navigator.of(context).pop(); // Cierre del AlertActivity
            });
      });
    });
    //
    // Future.forEach(listOfValues(), (element) async {
    //   var aux = element as List<dynamic>;
    //
    //   Terminal.printData(message: "$aux : :  ${aux[3]}");
    //   //
    //   await Actividades.actualizar(
    //     Databases.siteground_database_reghosp,
    //     Pendientes.pendientes['updateQuery'],
    //     element,
    //     Pacientes.ID_Paciente,
    //   );
    //   // if (aux[3] != '' && aux[3] != null)
    // }).whenComplete(() {
    //   Pacientes.getDispositivosHistorial().then((onValue) {
    //     // Terminal.printAlert(message: "ON_VALUE : $onValue");
    //   }).whenComplete(() {
    //     //
    //     Navigator.of(context).pop(); // Cierre del LoadActivity
    //     Operadores.alertActivity(
    //         context: context,
    //         tittle: "Actualizando información . . .",
    //         message: "Información actualizada",
    //         onAcept: () {
    //           // Se emplean 3 Navigator.of(context).pop(); para cerrar cada una de
    //           //    las ventanas emergentes y la interfaz inicial.
    //           Navigator.of(context).pop(); // Cierre de la Interfaz Inicial
    //           Navigator.of(context).pop(); // Cierre del AlertActivity
    //         });
    //   });
    //   //
    // }).onError((error, stackTrace) {
    //   Pacientes.getDispositivosHistorial().whenComplete(() {
    //     Terminal.printAlert(message: "ERROR - $error : : : $stackTrace");
    //     Operadores.alertActivity(
    //       context: context,
    //       tittle: "$error . . .",
    //       message: "$stackTrace",
    //     );
    //   });
    //   //
    // });
  }
}
