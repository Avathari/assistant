import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/citometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/hepatometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';

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
                            text: Auxiliares.porFecha(fechaActual: value));
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
        ),
      ],
    );
  }


  //
  static Widget biometrias(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(child: ValuePanel(
            firstText: "",
            secondText: Valores.fechaBiometria.toString(),
            thirdText: "",
          ),),
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
                          secondText: Valores.concentracionMediaHemoglobina.toString(),
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
                          secondText: Valores.hemoglobinaCorpuscularMedia.toString(),
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
                          secondText: Valores.volumenCorpuscularMedio.toString(),
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
                          secondText: Valores.leucocitosTotales!.toStringAsFixed(2),
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
                        secondText: Citometrias.indiceMetzner.toStringAsFixed(2),
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
            Expanded(child: Column(children: [
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
            ],)),
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
                          secondText: Valores.bilirrubinasTotales!.toStringAsFixed(2),
                          thirdText: "mg/dL",
                        ),
                        ValuePanel(
                          firstText: "BD",
                          secondText: Valores.bilirrubinaDirecta!.toStringAsFixed(2),
                          thirdText: "mg/dL",
                        ),
                        ValuePanel(
                          firstText: "BI",
                          secondText: Valores.bilirrubinaIndirecta!.toStringAsFixed(2),
                          thirdText: "mg/dL",
                        ),
                        ValuePanel(
                          firstText: "ALT / TGA",
                          secondText: Valores.alaninoaminotrasferasa!.toStringAsFixed(0),
                          thirdText: "UI/L",
                        ),
                        ValuePanel(
                          firstText: "AST / TGO",
                          secondText:
                          Valores.aspartatoaminotransferasa!.toStringAsFixed(0),
                          thirdText: "UI/L",
                        ),
                        ValuePanel(
                          firstText: "GGT",
                          secondText: Valores.glutrailtranspeptidasa!.toStringAsFixed(0),
                          thirdText: "UI/L",
                        ),
                        ValuePanel(
                          firstText: "FA",
                          secondText: Valores.fosfatasaAlcalina!.toStringAsFixed(0),
                          thirdText: "UI/L",
                        ),
                        ValuePanel(
                          firstText: "Albúmina",
                          secondText: Valores.albuminaSerica!.toStringAsFixed(1),
                          thirdText: "g/dL",
                        ),
                        ValuePanel(
                          firstText: "Proteínas Totales",
                          secondText: Valores.proteinasTotales!.toStringAsFixed(1),
                          thirdText: "g/dL",
                        ),
                        CrossLine(),

                      ],
                    ),
                  ),
                  Expanded(child: Column(
                    children: [
                      ValuePanel(
                        firstText: "AST/ALT",
                        secondText: Hepatometrias.relacionASTALT.toStringAsFixed(2),
                        thirdText: "",
                      ),
                      ValuePanel(
                        firstText: "ALT/FA",
                        secondText: Hepatometrias.relacionALTFA.toStringAsFixed(2),
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