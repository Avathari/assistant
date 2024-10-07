import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/ventometr%C3%ADas.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/operativity/pacientes/valores/semiologia/semiotica.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/ventilaciones.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/WidgetsModels.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// # Clase .dart para la creación predeterminada de interfaces de registro, consulta y actualización.
// Contiene un botón que enn _OperacionesVentilacionesState.build que desplega una ventana emergente,
// de la cual es posible elegir desde un catálogo de opciones.
// # # INSTRUCCIONES DE USO
// # # # Reemplazar .Ventilaciones por el valor
// # # # Reemplazar Ventilaciones. por la clase que contiene el mapa .ventilacion con las claves
// # # # # consultIdQuery
// # # # # registerQuery
// # # # # updateQuery
// # # # Reemplazar .ventilacion por el nombre del Map() correspondiente.
//
class OperacionesVentilaciones extends StatefulWidget {
  String? operationActivity;

  String _operationButton = 'Nulo';
  int actualView = 0;

  OperacionesVentilaciones({super.key, this.operationActivity = Constantes.Nulo});

  @override
  State<OperacionesVentilaciones> createState() =>
      _OperacionesVentilacionesState();
}

class _OperacionesVentilacionesState extends State<OperacionesVentilaciones> {
  @override
  void initState() {
    //
    switch (widget.operationActivity) {
      case Constantes.Nulo:
        break;
      case Constantes.Consult:
        break;
      case Constantes.Register:
        widget._operationButton = 'Registrar';
        fechaRealizacionTextController.text =
            Calendarios.today(format: 'yyyy-MM-dd HH:mm:ss');

        Exploracion.tuboEndotraqueal = Items.tuboendotraqueal[0];
        Exploracion.haciaArcadaDentaria = Items.arcadaDentaria[0];

        fioTextController.text = Valores.fraccionInspiratoriaOxigeno!.toString();
        sensInspTextController.text = '1';
        sensEspTextController.text = '2';
        break;
      case Constantes.Update:
        setState(() {
          widget._operationButton = 'Actualizar';
          //
          idOperation = Ventilaciones.Ventilacion['ID_Ventilacion'];
          fechaRealizacionTextController.text =
              Ventilaciones.Ventilacion['Feca_VEN'];
          Valores.fechaVentilaciones = fechaRealizacionTextController.text;
          //
          modoVentilatorioValue =
              Ventilaciones.Ventilacion['VM_Mod'].toString();
          Valores.modalidadVentilatoria = Ventilaciones.modoVentilatorio(
              modalidadVentilatoria: modoVentilatorioValue!);
          //
          Exploracion.tuboEndotraqueal =
              Ventilaciones.Ventilacion['Pace_TET'].toString();
          Exploracion.haciaArcadaDentaria =
              Ventilaciones.Ventilacion['Pace_DAC'].toString();
          //
          //
          volTidalTextController.text =
              Ventilaciones.Ventilacion['Pace_Vt'].toString();
          Valores.volumenTidal = double.parse(volTidalTextController.text);
          //
          peepTextController.text =
              Ventilaciones.Ventilacion['Pace_Peep'].toString();
          Valores.presionFinalEsiracion = int.parse(peepTextController.text);
          //
          respTextController.text =
              Ventilaciones.Ventilacion['Pace_Fr'].toString();
          Valores.frecuenciaVentilatoria = int.parse(respTextController.text);
          //
          fioTextController.text =
              Ventilaciones.Ventilacion['Pace_Fio'].toString();
          Valores.fraccionInspiratoriaOxigeno = Valores.fraccionInspiratoriaVentilatoria =
              int.parse(fioTextController.text);
          //
          sensInspTextController.text =
              Ventilaciones.Ventilacion['Pace_Insp'].toString();
          Valores.sensibilidadInspiratoria =
              int.parse(sensInspTextController.text);
          //
          sensEspTextController.text =
              Ventilaciones.Ventilacion['Pace_Espi'].toString();
          Valores.sensibilidadEspiratoria =
              int.parse(sensEspTextController.text);
          //
          //
          pControlTextController.text =
              Ventilaciones.Ventilacion['Pace_Pc'].toString();
          Valores.presionControl = int.parse(pControlTextController.text);
          //
          pMaximaTextController.text =
              Ventilaciones.Ventilacion['Pace_Pm'].toString();
          Valores.presionMaxima = int.parse(pMaximaTextController.text);
          //
          volTidalEspTextController.text =
              Ventilaciones.Ventilacion['Pace_V'].toString();
          Valores.volumenVentilatorio =
              int.parse(volTidalEspTextController.text);
          //
          flujoTextController.text =
              Ventilaciones.Ventilacion['Pace_F'].toString();
          Valores.flujoVentilatorio = int.parse(flujoTextController.text);
          //
          pSoporteTextController.text =
              Ventilaciones.Ventilacion['Pace_Ps'].toString();
          Valores.presionSoporte = int.parse(pSoporteTextController.text);
          //
          pPlatTextController.text =
              Ventilaciones.Ventilacion['Pace_Pmet'].toString();
          Valores.presionPlateau = int.parse(pPlatTextController.text);
          //
          pInspirattoriaTextController.text =
              Ventilaciones.Ventilacion['Pace_Pip'].toString();
          Valores.presionInspiratoriaPico =
              int.parse(pInspirattoriaTextController.text);
          //

          selectModal();
        });
        super.initState();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: isDesktop(context)
            ? null
            : isTabletAndDesktop(context)
                ? null
                : AppBar(
                    foregroundColor: Colors.white,
                    backgroundColor: Theming.primaryColor,
                    title: Text(
                      appBarTitile,
                      style: Styles.textSyle,
                    ),
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                      tooltip: Sentences.regresar,
                      onPressed: () {
                        onClose(context);
                      },
                    ),
                    actions: isMobile(context)
                        ? <Widget>[
                            GrandIcon(
                              iconData: Icons.candlestick_chart,
                              labelButton: 'Análisis de Parámetros',
                              onPress: () {
                                Operadores.openDialog(
                                    context: context,
                                    chyldrim: const AnalisisVentilatorio());
                              },
                            ),
                          ]
                        : isTablet(context)
                            ? <Widget>[
                                GrandIcon(
                                  iconData: Icons.candlestick_chart,
                                  labelButton: 'Análisis de Parámetros',
                                  onPress: () {
                                    Operadores.openDialog(
                                        context: context,
                                        chyldrim: const AnalisisVentilatorio());
                                  },
                                ),
                              ]
                            : null,
                  ),
        body: isDesktop(context) || isTablet(context)
            ? DeskTopView()
            : MobileView());
  }

  // *************************************************************************
  Container DeskTopView() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(6.0),
      decoration: ContainerDecoration.roundedDecoration(),
      child: Column(
        children: [
          Expanded(
              flex: !isDesktop(context) ?1:2,
              child: Row(
            children: [
              Expanded(
                flex: 2,
                child: EditTextArea(
                  keyBoardType: TextInputType.number,
                  inputFormat: TextFormat.dateFormat,
                  numOfLines: 1,
                  optionEqui: 4,
                  labelEditText: 'Fecha de realización',
                  textController: fechaRealizacionTextController,
                  iconData: Icons.calendar_today,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaRealizacionTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd HH:mm:ss');
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: Spinner(
                  width: SpinnersValues.maximumWidth(context: context),
                  tittle: 'Fase ventilatoria',
                  onChangeValue: (value) {
                    setState(() {
                      Exploracion.faseVentilatoria = value;
                    });
                  },
                  items: Items.ventilatorio,
                  initialValue: Exploracion.faseVentilatoria,
                ),
              ),
            ],
          )),
          CrossLine(
            height: 15,
            thickness: 4
          ),
          Expanded(
              flex: 2,
              child: Spinner(
                width: isTablet(context) || isDesktop(context)
                    ? 500
                    : isMobile(context)
                        ? 250
                        : 150,
                tittle: 'M. Ventilatorio',
                onChangeValue: (value) {
                  setState(() {
                    modoVentilatorioValue = value;
                    Valores.modalidadVentilatoria =
                        Ventilaciones.modoVentilatorio(
                            modalidadVentilatoria: modoVentilatorioValue!);
                    selectModal();
                  });
                },
                items: Ventilaciones.modalidades,
                initialValue: modoVentilatorioValue,
              )),
          Expanded(
              flex: 2,
              child: Row(
            children: [
              Expanded(
                child: Spinner(
                  width: isTablet(context)
                      ? 500
                      : isDesktop(context)
                          ? 315
                          : isMobile(context)
                              ? 250
                              : 150,
                  tittle: 'Tubo Endotraqueal',
                  onChangeValue: (value) {
                    setState(() {
                      Exploracion.tuboEndotraqueal = value;
                    });
                  },
                  items: Items.tuboendotraqueal,
                  initialValue: Exploracion.tuboEndotraqueal,
                ),
              ),
              Expanded(
                child: Spinner(
                  width: isTablet(context)
                      ? 500
                      : isDesktop(context)
                          ? 315
                          : isMobile(context)
                              ? 250
                              : 150,
                  tittle: 'Distancia a arcada',
                  onChangeValue: (value) {
                    setState(() {
                      Exploracion.haciaArcadaDentaria = value;
                    });
                  },
                  items: Items.arcadaDentaria,
                  initialValue: Exploracion.haciaArcadaDentaria,
                ),
              ),
            ],
          )),
          CrossLine(
            height: 10,
            thickness: 2,
          ),
          Expanded(
            flex: isTabletAndDesktop(context)
                ? 9
                : isDesktop(context)
                    ? 10
                    : isTablet(context)
                        ? 6
                        : 6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                          controller: ScrollController(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: component(context),
                          ))),
                  Expanded(
                    flex: 2,
                      child: Column(
                    children: [
                      Expanded(
                        flex: isMobile(context) ? 2 : 1,
                        child: Container(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          margin: const EdgeInsets.all(8.0),
                          decoration: ContainerDecoration.roundedDecoration(),
                          child: SingleChildScrollView(
                              controller: ScrollController(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: getView(widget.actualView),
                              )),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: EditTextArea(
                                keyBoardType: TextInputType.number,
                                inputFormat: MaskTextInputFormatter(),
                                labelEditText: 'Presión Platteu (mmHg)',
                                textController: pPlatTextController,
                                numOfLines: 1,
                                onChange: (value) {
                                  setState(() {
                                    Valores.presionPlateau = int.parse(value);
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: EditTextArea(
                                keyBoardType: TextInputType.number,
                                inputFormat: MaskTextInputFormatter(),
                                labelEditText: 'Presión Máxima (mmHg)',
                                textController: pMaximaTextController,
                                numOfLines: 1,
                                onChange: (value) {
                                  setState(() {
                                    Valores.presionMaxima = int.parse(value);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
          CrossLine(

          ),
          Expanded(
            flex: !isDesktop(context) ?1:2,
            child: GrandButton(
                weigth: 1000,
                labelButton: widget._operationButton,
                onPress: () {
                  operationMethod(context);
                }),
          ),
        ],
      ),
    );
  }

  Container MobileView() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: ContainerDecoration.roundedDecoration(),
      child: Column(
        children: [
          Expanded(
              flex: Keyboard.isDesktopOpen(context) ? 6 : 4,
              child: Column(
                children: [
                  Expanded(
                    flex: Keyboard.isDesktopOpen(context) ? 2 : 1,
                    child: EditTextArea(
                      keyBoardType: TextInputType.number,
                      inputFormat: TextFormat.dateFormat,
                      numOfLines: 1,
                      labelEditText: 'Fecha de realización',
                      textController: fechaRealizacionTextController,
                      iconData: Icons.calendar_today,
                      iconColor: Colors.white,
                      withShowOption: true,
                      selection: true,
                      onSelected: () {
                        fechaRealizacionTextController.text =
                            Calendarios.today(format: 'yyyy-MM-dd');
                      },
                    ),
                  ),
                  Expanded(
                    flex: Keyboard.isDesktopOpen(context) ? 3 : 1,
                    child: Spinner(
                      isRow: true,
                      width: SpinnersValues.maximumWidth(context: context),
                      tittle: 'Fase ventilatoria',
                      onChangeValue: (value) {
                        setState(() {
                          Exploracion.faseVentilatoria = value;
                        });
                      },
                      items: Items.ventilatorio,
                      initialValue: Exploracion.faseVentilatoria,
                    ),
                  ),
                ],
              )),
          CrossLine(
            height: Keyboard.isDesktopOpen(context) ? 5 : 10,
            thickness: 2,
          ),
          // *****************************************************
          Expanded(
              flex: Keyboard.isDesktopOpen(context) ? 6 : 4,
              child: Column(
                children: [
                  Expanded(
                    child: Spinner(
                      isRow: true,
                      width: isTablet(context) || isDesktop(context)
                          ? 500
                          : isMobile(context)
                              ? 170
                              : 150,
                      tittle: 'Modo',
                      onChangeValue: (value) {
                        setState(() {
                          modoVentilatorioValue = value;
                          Valores.modalidadVentilatoria =
                              Ventilaciones.modoVentilatorio(
                                  modalidadVentilatoria:
                                      modoVentilatorioValue!);
                          selectModal();
                        });
                      },
                      items: Ventilaciones.modalidades,
                      initialValue: modoVentilatorioValue,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Spinner(
                            isRow: true,
                            width: isTablet(context) || isDesktop(context)
                                ? 500
                                : isMobile(context)
                                    ? 170
                                    : 150,
                            tittle: 'TET',
                            onChangeValue: (value) {
                              setState(() {
                                Exploracion.tuboEndotraqueal = value;
                              });
                            },
                            items: Items.tuboendotraqueal,
                            initialValue: Exploracion.tuboEndotraqueal,
                          ),
                        ),
                        Expanded(
                          child: Spinner(
                            isRow: true,
                            width: isTablet(context) || isDesktop(context)
                                ? 500
                                : isMobile(context)
                                    ? 170
                                    : 150,
                            tittle: 'Dis.',
                            onChangeValue: (value) {
                              setState(() {
                                Exploracion.haciaArcadaDentaria = value;
                              });
                            },
                            items: Items.arcadaDentaria,
                            initialValue: Exploracion.haciaArcadaDentaria,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          CrossLine(
            height: Keyboard.isDesktopOpen(context) ? 5 : 10,
            thickness: 2,
          ),
          Expanded(
            flex: isTabletAndDesktop(context)
                ? 9
                : isDesktop(context)
                    ? 7
                    : isTablet(context)
                        ? 6
                        : 8,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                          controller: ScrollController(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: component(context),
                          ))),
                  Expanded(
                      child: Column(
                    children: [
                      Expanded(
                        flex: isMobile(context) ? 2: 3,
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          margin: const EdgeInsets.all(2.0),
                          decoration: ContainerDecoration.roundedDecoration(),
                          child: SingleChildScrollView(
                              controller: ScrollController(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: getView(widget.actualView),
                              )),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: EditTextArea(
                                keyBoardType: TextInputType.number,
                                inputFormat: TextFormat.standardFormat,
                                labelEditText: 'Presión Platteu (mmHg)',
                                textController: pPlatTextController,
                                numOfLines: 1,
                                onChange: (value) {
                                  setState(() {
                                    Valores.presionPlateau = int.parse(value);
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: EditTextArea(
                                keyBoardType: TextInputType.number,
                                inputFormat: TextFormat.standardFormat,
                                labelEditText: 'Presión Máxima (mmHg)',
                                textController: pMaximaTextController,
                                numOfLines: 1,
                                onChange: (value) {
                                  setState(() {
                                    Valores.presionMaxima = int.parse(value);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GrandButton(
                weigth: 1000,
                labelButton: widget._operationButton,
                onPress: () {
                  operationMethod(context);
                }),
          ),
        ],
      ),
    );
  }

// *************************************************************************
  List<Widget> getView(int actualView) {
    List<List<Widget>> list = [
      [const Text('Ninguna modalidad ventilatoria')],
      presionComponent(context),
      volumenComponent(context),
      intermitenteComponent(context),
      espontaneoComponent(context),
    ];
    return list[actualView];
  }

// *************************************************************************
  List<Widget> component(BuildContext context) {
    return [
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.standardFormat,
        labelEditText: 'Vol. Tidal (mL)',
        textController: volTidalTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.volumenTidal = double.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.standardFormat,
        labelEditText: 'P.E.E.P. (cmH2O)',
        textController: peepTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.presionFinalEsiracion = int.parse(value);
          });
        },
      ),
      CrossLine(),
      //
      Row(
        children: [
          Expanded(
            child: EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: TextFormat.standardFormat,
              labelEditText: 'F. Resp (Vent/min)',
              textController: respTextController,
              numOfLines: 1,
              onChange: (value) {
                setState(() {
                  Valores.frecuenciaVentilatoria = int.parse(value);
                });
              },
            ),
          ),
          Expanded(
            child: EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: TextFormat.standardFormat,
              labelEditText: 'FiO2 (%)',
              textController: fioTextController,
              numOfLines: 1,
              onChange: (value) {
                setState(() {
                  Valores.fraccionInspiratoriaOxigeno = Valores.fraccionInspiratoriaVentilatoria = int.parse(value);
                });
              },
            ),
          ),
        ],
      ),
      CrossLine(),
      Row(
        children: [
          Expanded(
            child: EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: TextFormat.standardFormat,
              labelEditText: 'Sens. Insp. (Seg)',
              textController: sensInspTextController,
              numOfLines: 1,
              onChange: (value) {
                setState(() {
                  Valores.sensibilidadInspiratoria = int.parse(value);
                });
              },
            ),
          ),
          Expanded(
            child: EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: TextFormat.standardFormat,
              labelEditText: 'Sens. Esp. (Seg)',
              textController: sensEspTextController,
              numOfLines: 1,
              onChange: (value) {
                setState(() {
                  Valores.sensibilidadEspiratoria = int.parse(value);
                });
              },
            ),
          ),
        ],
      ),

      CrossLine(),
    ];
  }

  List<Widget> presionComponent(BuildContext context) {
    return [
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Presión Control (mmHg)',
        textController: pControlTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.presionControl = int.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Presión Máxima (mmHg)',
        textController: pMaximaTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.presionMaxima = int.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Presión Platteu (mmHg)',
        textController: pPlatTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.presionPlateau = int.parse(value);
          });
        },
      ),
      CrossLine(),
    ];
  }

  List<Widget> volumenComponent(BuildContext context) {
    return [
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Volumen Tidal Espiratorio (mL)',
        textController: volTidalEspTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.volumenVentilatorio = int.parse(value);
            flujoTextController.text = Ventometrias.flujoVentilatorioMedido.toStringAsFixed(2);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Flujo (L/min)',
        textController: flujoTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.flujoVentilatorio = int.parse(value);
          });
        },
      ),
      CrossLine(),
    ];
  }

  List<Widget> intermitenteComponent(BuildContext context) {
    return [
      Row(
        children: [
          Expanded(
            child: EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: TextFormat.numberFourFormat,
              labelEditText: 'Presión Inspiratoria (mmHg)',
              textController: pInspirattoriaTextController,
              numOfLines: 1,
              onChange: (value) {
                setState(() {
                  Valores.presionInspiratoriaPico = int.parse(value);
                });
              },
            ),
          ),
          Expanded(
            child: EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: TextFormat.numberFourFormat,
              labelEditText: 'Volumen Tidal Espiratorio (mL)',
              textController: volTidalEspTextController,
              numOfLines: 1,
              onChange: (value) {
                setState(() {
                  Valores.volumenVentilatorio = int.parse(value);
                });
              },
            ),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: TextFormat.numberFourFormat,
              labelEditText: 'Presión Máxima (mmHg)',
              textController: pMaximaTextController,
              numOfLines: 1,
              onChange: (value) {
                setState(() {
                  Valores.presionMaxima = int.parse(value);
                });
              },
            ),
          ),
          Expanded(
            child: EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: TextFormat.numberFourFormat,
              labelEditText: 'Flujo (L/min)',
              textController: flujoTextController,
              numOfLines: 1,
              onChange: (value) {
                setState(() {
                  Valores.flujoVentilatorio = int.parse(value);
                });
              },
            ),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: TextFormat.numberFourFormat,
              labelEditText: 'Presión Platteu (mmHg)',
              textController: pPlatTextController,
              numOfLines: 1,
              onChange: (value) {
                setState(() {
                  Valores.presionPlateau = int.parse(value);
                });
              },
            ),
          ),
          Expanded(
            child: EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: TextFormat.numberFourFormat,
              labelEditText: 'Presión Soporte (mmHg)',
              textController: pSoporteTextController,
              numOfLines: 1,
              onChange: (value) {
                setState(() {
                  Valores.presionSoporte = int.parse(value);
                });
              },
            ),
          ),
        ],
      ),
      CrossLine(),
    ];
  }

  List<Widget> espontaneoComponent(BuildContext context) {
    return [
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Presión Soporte (mmHg)',
        textController: pSoporteTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.presionSoporte = int.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Presión Inspiratoria Pico (mmHg)',
        textController: pInspirattoriaTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.presionInspiratoriaPico = int.parse(value);
          });
        },
      ),
      CrossLine(),
    ];
  }

  // *************************************************************************
  void operationMethod(BuildContext context) {
    try {
      listOfValues = [
        idOperation,
        Pacientes.ID_Paciente,
        fechaRealizacionTextController.text,
        volTidalTextController.text,
        respTextController.text,
        fioTextController.text,
        peepTextController.text,
        sensInspTextController.text,
        sensEspTextController.text,
        //
        pControlTextController.text,
        pMaximaTextController.text,
        volTidalEspTextController.text,
        flujoTextController.text,
        pSoporteTextController.text,
        pInspirattoriaTextController.text,
        pPlatTextController.text,
        //
        modoVentilatorioValue,
        //
        Exploracion.tuboEndotraqueal,
        Exploracion.haciaArcadaDentaria,
        //
        idOperation
      ];

      //print("${widget.operationActivity} listOfValues $listOfValues ${listOfValues!.length}");

      switch (widget.operationActivity) {
        case Constantes.Nulo:
          // ******************************************** *** *
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(Databases.siteground_database_reghosp,
              registerQuery!, listOfValues!.removeLast());
          break;
        case Constantes.Consult:
          break;
        case Constantes.Register:
          // ******************************************** *** *
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(Databases.siteground_database_reghosp,
                  registerQuery!, listOfValues!)
              .then((value) => Actividades.consultarAllById(
                          Databases.siteground_database_reghosp,
                          consultIdQuery!,
                          Pacientes.ID_Paciente) // idOperation)
                      .then((value) {
                    // ******************************************** *** *
                    Pacientes.Alergicos = value;
                    Constantes.reinit(value: value);
                    // ******************************************** *** *
                  }).then((value) => onClose(context)));
          break;
        case Constantes.Update:
          Actividades.actualizar(Databases.siteground_database_reghosp,
                  updateQuery!, listOfValues!, idOperation)
              .then((value) => Actividades.consultarAllById(
                          Databases.siteground_database_reghosp,
                          consultIdQuery!,
                          Pacientes.ID_Paciente) // idOperation)
                      .then((value) {
                    // ******************************************** *** *
                    Pacientes.Alergicos = value;
                    Constantes.reinit(value: value);
                    // ******************************************** *** *
                  }).then((value) => onClose(context)));
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
    }
  }

  void selectModal() {
    int index = Ventilaciones.modalidades.indexOf(modoVentilatorioValue!);
    // //print(index);
    switch (index) {
      case 1:
        widget.actualView = 1;
        break;
      case 2:
        widget.actualView = 2;
        break;
      case 3:
        widget.actualView = 3;
        break;
      case 4:
        widget.actualView = 3;
        break;
      case 5:
        widget.actualView = 4;
        break;
      case 6:
        widget.actualView = 4;
        break;
      default:
        widget.actualView = 0;
    }
    //
  }

  void onClose(BuildContext context) {
    switch (isMobile(context)) {
      case true:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionVentilaciones()));
        break;
      case false:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionVentilaciones()));
        break;
      default:
    }
  }

  // VARIABLES ************************************************************
  String appBarTitile = "Gestión de Ventilaciones";
  String? consultIdQuery = Ventilaciones.ventilacion['consultIdQuery'];
  String? registerQuery = Ventilaciones.ventilacion['registerQuery'];
  String? updateQuery = Ventilaciones.ventilacion['updateQuery'];

  int idOperation = 0;

  List<dynamic>? listOfValues;

  var fechaRealizacionTextController = TextEditingController();
  String? modoVentilatorioValue = Ventilaciones.modalidades[0];

  var volTidalTextController = TextEditingController();
  var peepTextController = TextEditingController();
  var respTextController = TextEditingController();
  var fioTextController = TextEditingController();
  var sensInspTextController = TextEditingController();
  var sensEspTextController = TextEditingController();
  var viaOtrosIngresosTextController = TextEditingController();
  //
  var pControlTextController = TextEditingController();
  var pMaximaTextController = TextEditingController();
  var pPlatTextController = TextEditingController();
  var volTidalEspTextController = TextEditingController();
  var viaDreneTextController = TextEditingController();
  var flujoTextController = TextEditingController();
  var pInspirattoriaTextController = TextEditingController();
  var pSoporteTextController = TextEditingController();
  //
  var carouselController = CarouselSliderController();
//
}

class GestionVentilaciones extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Pace_APP_ALE";
  // ****************** *** ****** **************

  GestionVentilaciones({super.key, this.actualSidePage});

  @override
  State<GestionVentilaciones> createState() => _GestionVentilacionesState();
}

class _GestionVentilacionesState extends State<GestionVentilaciones> {
  @override
  void initState() {
    if (Constantes.dummyArray!.isNotEmpty) {
      if (Constantes.dummyArray![0] == "Vacio") {
        Actividades.consultarAllById(Databases.siteground_database_reghosp,
                consultQuery!, Pacientes.ID_Paciente)
            .then((value) {
          setState(() {
            //print(" . . . Buscando items \n $value");
            foundedItems = value;
          });
        });
      } else {
        //print(" . . . Ventilaciones array iniciado");
        foundedItems = Constantes.dummyArray;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Theming.primaryColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            tooltip: Sentences.regresar,
            onPressed: () {
              Constantes.reinit();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => VisualPacientes(actualPage: 6)));
            },
          ),
          title: AppBarText(appTittle),
          actions: <Widget>[
            isTabletAndDesktop(context)
                ? GrandIcon(
                    iconData: Icons.candlestick_chart,
                    labelButton: 'Análisis de Parámetros',
                    onPress: () {
                      Operadores.openDialog(
                          context: context,
                          chyldrim: const AnalisisVentilatorio());
                    },
                  )
                : isDesktop(context)
                    ? GrandIcon(
                        iconData: Icons.candlestick_chart,
                        labelButton: 'Análisis de Parámetros',
                        onPress: () {
                          Operadores.openDialog(
                              context: context,
                              chyldrim: const AnalisisVentilatorio());
                        },
                      )
                    : Container(),
            IconButton(
              icon: const Icon(
                Icons.replay_outlined,
              ),
              tooltip: Sentences.reload,
              onPressed: () {
                // _pullListRefresh();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.add_card,
              ),
              tooltip: Sentences.add_vitales,
              onPressed: () {
                toOperaciones(context, Constantes.Register);
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
                flex: 8,
                child: RefreshIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.black,
                  onRefresh: _pullListRefresh,
                  child: FutureBuilder<List>(
                    initialData: foundedItems!,
                    future: Future.value(foundedItems!),
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
                                return itemListView(
                                    snapshot, posicion, context);
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
            ? widget.actualSidePage != null
                ? Expanded(flex: 2, child: widget.actualSidePage!)
                : Expanded(flex: 1, child: Container())
            : isDesktop(context)
                ? widget.actualSidePage != null
                    ? Expanded(flex: 3, child: Row(
                      children: [
                        Expanded(child: widget.actualSidePage!),
                        const Expanded(child: AnalisisVentilatorio()),
                      ],
                    ))
                    : Expanded(flex: 1, child: Container())
                : Container()
      ]),
    );
  }

  Container itemListView(
      AsyncSnapshot snapshot, int posicion, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(10.0),
      decoration: ContainerDecoration.roundedDecoration(),
      child: GestureDetector(
        onTap: () {
          onSelected(snapshot, posicion, context, Constantes.Update);
        },
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "ID : ${snapshot.data[posicion]['ID_Ventilacion'].toString()}",
                      //   style: const TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.grey,
                      //       fontSize: 12),
                      // ),
                      Text(
                        "${snapshot.data[posicion]['Feca_VEN']}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 14),
                      ),
                      Text(
                        "${snapshot.data[posicion]['VM_Mod']}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      color: Colors.grey,
                      icon: const Icon(Icons.update_rounded),
                      onPressed: () {
                        //
                        onSelected(
                            snapshot, posicion, context, Constantes.Update);
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      color: Colors.grey,
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alertDialog(
                                'Eliminar registro',
                                '¿Esta seguro de querer eliminar el registro?',
                                () {
                                  closeDialog(context);
                                },
                                () {
                                  deleteRegister(snapshot, posicion, context);
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
      ),
    );
  }

  void onSelected(AsyncSnapshot<dynamic> snapshot, int posicion,
      BuildContext context, String operaciones) {
    Ventilaciones.Ventilacion = snapshot.data[posicion];
    // Ventilaciones.selectedDiagnosis = Ventilaciones.ventilacion['Pace_APP_ALE'];
    Pacientes.Ventilaciones = snapshot.data;
    //
    toOperaciones(context, operaciones);
  }

  void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void deleteRegister(
      AsyncSnapshot<dynamic> snapshot, int posicion, BuildContext context) {
    try {
      Actividades.eliminar(
          Databases.siteground_database_reghosp,
          Ventilaciones.ventilacion['deleteQuery'],
          snapshot.data[posicion]['ID_Ventilacion']);
      setState(() {
        snapshot.data.removeAt(posicion);
      });
    } finally {
      Navigator.of(context).pop();
    }
  }

  void toOperaciones(BuildContext context, String operationActivity) {
    if (isTabletAndDesktop(context) || isDesktop(context)) {
      Constantes.operationsActividad = operationActivity;
      Constantes.reinit(value: foundedItems!);
      _pullListRefresh();
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => OperacionesVentilaciones(
                operationActivity: operationActivity,
              )));
    }
  }

  void _runFilterSearch(String enteredKeyword) {
    List? results = [];

    if (enteredKeyword.isEmpty) {
      _pullListRefresh();
    } else {
      Actividades.consultar(
              Databases.siteground_database_reghosp, consultQuery!)
          .then((value) {
        results = value
            .where((user) => user[widget.keySearch].contains(enteredKeyword))
            .toList();

        setState(() {
          foundedItems = results;
        });
      });
    }
  }

  Future<Null> _pullListRefresh() async {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (a, b, c) => GestionVentilaciones(
                  actualSidePage: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OperacionesVentilaciones(
                      operationActivity: Constantes.operationsActividad,
                    ),
                  ),
                ),
            transitionDuration: const Duration(seconds: 0)));
  }

  // VARIABLES **********************************************************
  String appTittle =
      "Gestion de registros de parámetros ventilatorios del paciente";
  String searchCriteria = "Buscar por Fecha";
  String? consultQuery = Ventilaciones.ventilacion['consultIdQuery'];

  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();
}

