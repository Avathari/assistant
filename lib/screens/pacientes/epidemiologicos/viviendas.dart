import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/Switched.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Viviendas extends StatefulWidget {
  const Viviendas({Key? key}) : super(key: key);

  @override
  State<Viviendas> createState() => _ViviendasState();
}

class _ViviendasState extends State<Viviendas> {
  // ************ *********** *********
  var cohabitantesTextController = TextEditingController();
  var pasatiemposTextController = TextEditingController();
  var materialesTextController = TextEditingController();
  var viajesRecientesTextController = TextEditingController();

  var carouselController = CarouselController();

  var vacunosTextController = TextEditingController();
  var ovinosTextController = TextEditingController();
  var porcinosTextController = TextEditingController();
  var avesTextController = TextEditingController();

  var caninosTextController = TextEditingController();
  var felinosTextController = TextEditingController();
  var reptilesTextController = TextEditingController();
  var parvadaTextController = TextEditingController();
  // ************ *********** *********

  @override
  void initState() {
    setState(() {
      // ************ *********** *********
      cohabitantesTextController.text = '';
      // ************ *********** *********
      cohabitantesTextController.text = Valores.otrosCohabitantes!;
      // ************ *********** *********
      vacunosTextController.text = Valores.viviendaCantidadVacunos!;
      ovinosTextController.text = Valores.viviendaCantidadOvinos!;
      porcinosTextController.text = Valores.viviendaCantidadPorcinos!;
      avesTextController.text = Valores.viviendaCantidadAves!;

      caninosTextController.text = Valores.viviendaCantidadCaninos!;
      felinosTextController.text = Valores.viviendaCantidadFelinos!;
      reptilesTextController.text = Valores.viviendaCantidadReptiles!;
      parvadaTextController.text = Valores.viviendaCantidadParvada!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TittlePanel(textPanel: 'Conformación de la Vivienda'),
        SingleChildScrollView(
          controller: ScrollController(),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GrandIcon(
                iconData: Icons.family_restroom,
                labelButton: 'Propiedad y Co-Habitantes',
                onPress: () {
                  setState(() {
                    carouselController.jumpToPage(0);
                  });
                },
              ),
              GrandIcon(
                iconData: Icons.home_repair_service_outlined,
                labelButton: 'Servicios Domiciliarios',
                onPress: () {
                  setState(() {
                    carouselController.jumpToPage(1);
                  });
                },
              ),
              GrandIcon(
                iconData: Icons.maps_home_work_sharp,
                labelButton: 'Conformación General',
                onPress: () {
                  setState(() {
                    carouselController.jumpToPage(2);
                  });
                },
              ),
              GrandIcon(
                iconData: Icons.home_mini,
                labelButton: 'Conformación Interna',
                onPress: () {
                  setState(() {
                    carouselController.jumpToPage(3);
                  });
                },
              ),
              GrandIcon(
                iconData: Icons.fence,
                labelButton: 'Animales de Corral',
                onPress: () {
                  setState(() {
                    carouselController.jumpToPage(4);
                  });
                },
              ),
              GrandIcon(
                iconData: Icons.pets,
                labelButton: 'Animales de Compañía',
                onPress: () {
                  setState(() {
                    carouselController.jumpToPage(5);
                  });
                },
              ),
            ],
          ),
        ),
        const CrossLine(),
        CarouselSlider(
            carouselController: carouselController,
            options: Carousel.carouselOptions(context: context),
            items: [
              SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: [
                    Spinner(
                      tittle: 'Propiedad',
                      width: SpinnersValues.mediumWidth(context: context),
                      onChangeValue: (value) {
                        setState(() {
                          Valores.propiedadVivienda = value;
                        });
                      },
                      items: Items.propiedad,
                      initialValue: Valores.propiedadVivienda, //Items.propiedad[0],
                    ),
                    const CrossLine(),
                    TittlePanel(textPanel: 'Co-Habitantes'),
                    Row(
                      children: [
                        Expanded(
                          child: Switched(
                            tittle: 'Padre',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.cohabitaPadre = value;
                              });
                            },
                            isSwitched: Valores.cohabitaPadre,
                          ),
                        ),
                        Expanded(
                          child: Switched(
                            tittle: 'Madre',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.cohabitaMadre = value;
                              });
                            },
                            isSwitched: Valores.cohabitaMadre,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Switched(
                            tittle: 'Hijos',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.cohabitaHijos = value;
                              });
                            },
                            isSwitched: Valores.cohabitaHijos,
                          ),
                        ),
                        Expanded(
                          child: Switched(
                            tittle: 'Familiares',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.cohabitaFamiliares = value;
                              });
                            },
                            isSwitched: Valores.cohabitaFamiliares,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Switched(
                            tittle: 'Otros',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.cohabitaOtros = value;
                              });
                            },
                            isSwitched: Valores.cohabitaOtros,
                          ),
                        ),
                        Expanded(
                          child: EditTextArea(
                            keyBoardType: TextInputType.text,
                            inputFormat: MaskTextInputFormatter(),
                            labelEditText: 'Otros Co-Habitantes',
                            textController: cohabitantesTextController,
                            numOfLines: 1,
                            onChange: (value) {
                              Valores.otrosCohabitantes = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    const CrossLine(),
                  ],
                ),
              ),
              SingleChildScrollView(
                controller: ScrollController(),
                child: Column(children: [
                  TittlePanel(textPanel: 'Servicios Públicos'),
                  Row(
                    children: [
                      Expanded(
                        child: Switched(
                          tittle: 'Electricidad',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.viviendaElectricidad = value;
                            });
                          },
                          isSwitched: Valores.viviendaElectricidad,
                        ),
                      ),
                      Expanded(
                        child: Switched(
                          tittle: 'Agua Potable',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.viviendaAguaPotable = value;
                            });
                          },
                          isSwitched: Valores.viviendaAguaPotable,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Switched(
                          tittle: 'Alcantarillado',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.viviendaAlcantarillado = value;
                            });
                          },
                          isSwitched: Valores.viviendaAlcantarillado,
                        ),
                      ),
                      Expanded(
                        child: Switched(
                          tittle: 'Drenaje',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.viviendaDrenaje = value;
                            });
                          },
                          isSwitched: Valores.viviendaDrenaje,
                        ),
                      ),
                    ],
                  ),
                  const CrossLine(),
                  TittlePanel(textPanel: 'Servicios Domiciliarios'),
                  Row(
                    children: [
                      Expanded(
                        child: Switched(
                          tittle: 'Televisión',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.viviendaTelevision = value;
                            });
                          },
                          isSwitched: Valores.viviendaTelevision,
                        ),
                      ),
                      Expanded(
                        child: Switched(
                          tittle: 'Estufa / Horno',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.viviendaEstufa = value;
                            });
                          },
                          isSwitched: Valores.viviendaEstufa,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Switched(
                          tittle: 'Horno de Leña',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.viviendaHornoLena = value;
                            });
                          },
                          isSwitched: Valores.viviendaHornoLena,
                        ),
                      ),
                    ],
                  ),
                  const CrossLine(),
                ]),
              ),
              SingleChildScrollView(
                controller: ScrollController(),
                child: Column(children: [
                  TittlePanel(textPanel: 'Conformación General'),
                  Spinner(
                    tittle: 'Material del Piso',
                    width: SpinnersValues.mediumWidth(context: context),
                    onChangeValue: (value) {
                      setState(() {
                        Valores.materialPiso = value;
                      });
                    },
                    items: Items.materialesPiso,
                    initialValue: Items.materialesPiso[0],
                  ),
                  Spinner(
                    tittle: 'Material de las Paredes',
                    width: SpinnersValues.mediumWidth(context: context),
                    onChangeValue: (value) {
                      setState(() {
                        Valores.materialParedes = value;
                      });
                    },
                    items: Items.materialesParedes,
                    initialValue: Items.materialesParedes[0],
                  ),
                  Spinner(
                    tittle: 'Material del Techo',
                    width: SpinnersValues.mediumWidth(context: context),
                    onChangeValue: (value) {
                      setState(() {
                        Valores.materialTecho = value;
                      });
                    },
                    items: Items.materialesTecho,
                    initialValue: Items.materialesTecho[0],
                  ),
                  const CrossLine(),
                ]),
              ),
              SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: [
                    TittlePanel(textPanel: 'Conformación Intradomiciliaria'),
                    Row(
                      children: [
                        Expanded(
                          child: Switched(
                            tittle: 'Sala',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.viviendaSala = value;
                              });
                            },
                            isSwitched: Valores.viviendaSala,
                          ),
                        ),
                        Expanded(
                          child: Switched(
                            tittle: 'Sala / Comedor',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.viviendaComedor = value;
                              });
                            },
                            isSwitched: Valores.viviendaComedor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Switched(
                            tittle: 'Baño',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.viviendaBano = value;
                              });
                            },
                            isSwitched: Valores.viviendaBano,
                          ),
                        ),
                        Expanded(
                          child: Switched(
                            tittle: 'Habitaciones Separadas',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.viviendaHabitacionesSeparadas = value;
                              });
                            },
                            isSwitched: Valores.viviendaHabitacionesSeparadas,
                          ),
                        ),
                      ],
                    ),
                    const CrossLine(),
                    TittlePanel(textPanel: 'Conformación Extradomiciliaria'),
                    Row(
                      children: [
                        Expanded(
                          child: Switched(
                            tittle: 'Patio Delantero',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.viviendaPatioDelantero = value;
                              });
                            },
                            isSwitched: Valores.viviendaPatioDelantero,
                          ),
                        ),
                        Expanded(
                          child: Switched(
                            tittle: 'Patio Trasero',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.viviendaPatioTrasero = value;
                              });
                            },
                            isSwitched: Valores.viviendaPatioTrasero,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: [
                    TittlePanel(textPanel: 'Presencia de Animales de Corral'),
                    Switched(
                      tittle: 'Animales de Corral',
                      onChangeValue: (value) {
                        setState(() {
                          Valores.viviendaAnimalesCorral = value;
                        });
                      },
                      isSwitched: Valores.viviendaAnimalesCorral,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Switched(
                            tittle: 'Vacunos',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.viviendaVacunos = value;
                                if (value) {
                                  vacunosTextController.text = '';
                                } else {
                                  vacunosTextController.text = '0';
                                  Valores.viviendaCantidadVacunos =
                                      vacunosTextController.text;
                                }
                              });
                            },
                            isSwitched: Valores.viviendaVacunos,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: EditTextArea(
                            keyBoardType: TextInputType.text,
                            inputFormat: MaskTextInputFormatter(),
                            labelEditText: 'Vacunos',
                            textController: vacunosTextController,
                            numOfLines: 2,
                            onChange: (value) {
                              Valores.viviendaCantidadVacunos = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Switched(
                            tittle: 'Ovinos',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.viviendaOvinos = value;
                                if (value) {
                                  ovinosTextController.text = '';
                                } else {
                                  ovinosTextController.text = '0';
                                  Valores.viviendaCantidadOvinos =
                                      ovinosTextController.text;
                                }
                              });
                            },
                            isSwitched: Valores.viviendaOvinos,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: EditTextArea(
                            keyBoardType: TextInputType.text,
                            inputFormat: MaskTextInputFormatter(),
                            labelEditText: 'Ovinos',
                            textController: ovinosTextController,
                            numOfLines: 2,
                            onChange: (value) {
                              Valores.viviendaCantidadOvinos = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Switched(
                            tittle: 'Porcinos',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.viviendaPorcinos = value;
                                if (value) {
                                  porcinosTextController.text = '';
                                } else {
                                  porcinosTextController.text = '0';
                                  Valores.viviendaCantidadPorcinos =
                                      porcinosTextController.text;
                                }
                              });
                            },
                            isSwitched: Valores.viviendaPorcinos,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: EditTextArea(
                            keyBoardType: TextInputType.text,
                            inputFormat: MaskTextInputFormatter(),
                            labelEditText: 'Porcinos',
                            textController: porcinosTextController,
                            numOfLines: 2,
                            onChange: (value) {
                              Valores.viviendaCantidadPorcinos = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Switched(
                            tittle: 'Averío',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.viviendaAves = value;
                                if (value) {
                                  avesTextController.text = '';
                                } else {
                                  avesTextController.text = '0';
                                  Valores.viviendaCantidadAves =
                                      avesTextController.text;
                                }
                              });
                            },
                            isSwitched: Valores.viviendaAves,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: EditTextArea(
                            keyBoardType: TextInputType.text,
                            inputFormat: MaskTextInputFormatter(),
                            labelEditText: 'Averío',
                            textController: avesTextController,
                            numOfLines: 2,
                            onChange: (value) {
                              Valores.viviendaCantidadAves = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    const CrossLine(),
                  ],
                ),
              ),
              SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: [
                    TittlePanel(textPanel: 'Presencia de Animales de Compañia'),
                    Switched(
                      tittle: 'Animales de Compañia',
                      onChangeValue: (value) {
                        setState(() {
                          Valores.viviendaAnimalesCompania = value;
                        });
                      },
                      isSwitched: Valores.viviendaAnimalesCompania,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Switched(
                            tittle: 'Caninos',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.viviendaCaninos = value;
                                if (value) {
                                  caninosTextController.text = '';
                                } else {
                                  caninosTextController.text = '0';
                                  Valores.viviendaCantidadCaninos =
                                      caninosTextController.text;
                                }
                              });
                            },
                            isSwitched: Valores.viviendaCaninos,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: EditTextArea(
                            keyBoardType: TextInputType.text,
                            inputFormat: MaskTextInputFormatter(),
                            labelEditText: 'Caninos',
                            textController: caninosTextController,
                            numOfLines: 2,
                            onChange: (value) {
                              Valores.viviendaCantidadCaninos = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Switched(
                            tittle: 'Felinos',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.viviendaFelinos = value;
                                if (value) {
                                  felinosTextController.text = '';
                                } else {
                                  felinosTextController.text = '0';
                                  Valores.viviendaCantidadFelinos =
                                      felinosTextController.text;
                                }
                              });
                            },
                            isSwitched: Valores.viviendaFelinos,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: EditTextArea(
                            keyBoardType: TextInputType.text,
                            inputFormat: MaskTextInputFormatter(),
                            labelEditText: 'Felinos',
                            textController: felinosTextController,
                            numOfLines: 2,
                            onChange: (value) {
                              Valores.viviendaCantidadFelinos = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Switched(
                            tittle: 'Réptiles',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.viviendaReptiles = value;
                                if (value) {
                                  reptilesTextController.text = '';
                                } else {
                                  reptilesTextController.text = '0';
                                  Valores.viviendaCantidadReptiles =
                                      reptilesTextController.text;
                                }
                              });
                            },
                            isSwitched: Valores.viviendaReptiles,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: EditTextArea(
                            keyBoardType: TextInputType.text,
                            inputFormat: MaskTextInputFormatter(),
                            labelEditText: 'Réptiles',
                            textController: reptilesTextController,
                            numOfLines: 2,
                            onChange: (value) {
                              Valores.viviendaCantidadReptiles = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Switched(
                            tittle: 'Averío',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.viviendaParvada = value;
                                if (value) {
                                  parvadaTextController.text = '';
                                } else {
                                  parvadaTextController.text = '0';
                                  Valores.viviendaCantidadParvada =
                                      parvadaTextController.text;
                                }
                              });
                            },
                            isSwitched: Valores.viviendaParvada,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: EditTextArea(
                            keyBoardType: TextInputType.text,
                            inputFormat: MaskTextInputFormatter(),
                            labelEditText: 'Averío',
                            textController: parvadaTextController,
                            numOfLines: 2,
                            onChange: (value) {
                              Valores.viviendaCantidadParvada = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    const CrossLine(),
                  ],
                ),
              ),
            ]),
      ],
    );
  }
}
