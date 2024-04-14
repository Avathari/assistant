import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/semiologia/semiotica.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/balancesHidrico.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/WidgetsModels.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// # Clase .dart para la creación predeterminada de interfaces de registro, consulta y actualización.
// Contiene un botón que enn _OperacionesBalancesState.build que desplega una ventana emergente,
// de la cual es posible elegir desde un catálogo de opciones.
// # # INSTRUCCIONES DE USO
// # # # Reemplazar .Balances por el valor
// # # # Reemplazar Balances. por la clase que contiene el mapa .balance con las claves
// # # # # consultIdQuery
// # # # # registerQuery
// # # # # updateQuery
// # # # Reemplazar .balance por el nombre del Map() correspondiente.
//
class OperacionesBalances extends StatefulWidget {
  String? operationActivity;

  String _operationButton = 'Nulo';

  OperacionesBalances({Key? key, this.operationActivity = Constantes.Nulo})
      : super(key: key);

  @override
  State<OperacionesBalances> createState() => _OperacionesBalancesState();
}

class _OperacionesBalancesState extends State<OperacionesBalances> {
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
            Calendarios.today(format: "yyyy/MM/dd");
        Exploracion.tipoSondaVesical = Items.foley[0];
        //
        setState(() {
          Valores.otrosIngresosBalances  = Valores.otrosIngresosBalances! + Valores.aguaMetabolica;
          //
          viaOtrosIngresosTextController.text = Valores.aguaMetabolica.toStringAsFixed(2);
          viaPerdidaTextController.text = Valores.perdidasInsensibles.toString();
        });
        break;
      case Constantes.Update:
        setState(() {
          Balances.fromJson(Balances.Balance);
          widget._operationButton = 'Actualizar';
          //
          idOperation = Balances.Balance['ID_Bala'];
          fechaRealizacionTextController.text =
              Balances.Balance['Pace_bala_Fecha'];
//
          isHorarioValue = Balances.Balance['Pace_bala_HOR'].toString();
          Exploracion.tipoSondaVesical =
              Balances.Balance['Pace_Foley'].toString() ?? '';

          viaOralTextController.text =
              Balances.Balance['Pace_bala_Oral'].toString();
          viaOrogasTextController.text =
              Balances.Balance['Pace_bala_Sonda'].toString();
          viaHemosTextController.text =
              Balances.Balance['Pace_bala_Hemo'].toString();
          viaNutrianTextController.text =
              Balances.Balance['Pace_bala_NPT'].toString();
          viaParesTextController.text =
              Balances.Balance['Pace_bala_Sol'].toString();
          viaDilucionesTextController.text =
              Balances.Balance['Pace_bala_Dil'].toString();
          viaOtrosIngresosTextController.text =
              Balances.Balance['Pace_bala_ING'].toString();
          //
          viaUresisTextController.text =
              Balances.Balance['Pace_bala_Uresis'].toString();
          viaEvacTextController.text =
              Balances.Balance['Pace_bala_Evac'].toString();
          viaSangTextController.text =
              Balances.Balance['Pace_bala_Sangrado'].toString();
          viaSucciTextController.text =
              Balances.Balance['Pace_bala_Succion'].toString();
          viaDreneTextController.text =
              Balances.Balance['Pace_bala_Drenes'].toString();
          viaPerdidaTextController.text =
              Balances.Balance['Pace_bala_PER'].toString();
          viaOtrosEgresosTextController.text =
              Balances.Balance['Pace_bala_ENG'].toString();
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
          : AppBar(
              foregroundColor: Colors.white,
              backgroundColor: Theming.primaryColor,
              title: AppBarText(appBarTitile),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
                tooltip: Sentences.regresar,
                onPressed: () {
                  onClose(context);
                },
              ),
              actions: isTablet(context)
                  ? [
                      GrandIcon(
                        iconData: Icons.paste,
                        onPress: () {
                          Datos.portapapeles(
                              context: context, text: Formatos.balances);
                        },
                      ),
                      GrandIcon(
                        iconData: Icons.bar_chart,
                        onPress: () {
                          Operadores.openDialog(
                              context: context,
                              chyldrim: const BalanceHidrico());
                        },
                      )
                    ]
                  : [
                      GrandIcon(
                        iconData: Icons.paste,
                        onPress: () {
                          Datos.portapapeles(
                              context: context, text: Formatos.balances);
                        },
                      ),
                      GrandIcon(
                        iconData: Icons.bar_chart,
                        onPress: () {
                          Operadores.openDialog(
                              context: context,
                              chyldrim: const BalanceHidrico());
                        },
                      )
                    ]),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: ContainerDecoration.roundedDecoration(),
        child: Column(
          children: [
            EditTextArea(
              labelEditText: "Fecha de realización",
              numOfLines: 1,
              textController: fechaRealizacionTextController,
              keyBoardType: TextInputType.datetime,
              withShowOption: true,
              selection: true,
              iconData: Icons.calculate_outlined,
              onSelected: () {
                setState(() {
                  fechaRealizacionTextController.text =
                      Calendarios.today(format: "yyyy/MM/dd");
                });
              },
              inputFormat: MaskTextInputFormatter(
                  mask: '####/##/##',
                  filter: {"#": RegExp(r'[0-9]')},
                  type: MaskAutoCompletionType.lazy),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: ContainerDecoration.roundedDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GrandButton(
                          weigth: isMobile(context) ? 50 : 200,
                          labelButton: "Ingresos",
                          onPress: () {
                            setState(() {
                              carouselController.jumpToPage(0);
                            });
                          }),
                    ),
                    Expanded(
                      child: GrandButton(
                          weigth: isMobile(context) ? 50 : 200,
                          labelButton: "Egresos",
                          onPress: () {
                            setState(() {
                              carouselController.jumpToPage(1);
                            });
                          }),
                    ),
                    isDesktop(context)
                        ? Expanded(
                            child: GrandButton(
                                weigth: isMobile(context) ? 50 : 200,
                                labelButton: "Balance Total",
                                onPress: () {
                                  setState(() {
                                    carouselController.jumpToPage(2);
                                  });
                                }),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Spinner(
                isRow: true,
                tittle: 'Sonda Vesical',
                width: isDesktop(context)
                    ? 300
                    : isTablet(context)
                        ? 200
                        : isMobile(context)
                            ? 170
                            : 200,
                items: Items.foley,
                initialValue: Exploracion.tipoSondaVesical,
                onChangeValue: (value) {
                  setState(() {
                    Exploracion.tipoSondaVesical = value;
                  });
                },
              ),
            ),
            Expanded(
              flex: isTablet(context) ? 4 : 9,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10.0),
                decoration: ContainerDecoration.roundedDecoration(),
                child: CarouselSlider(
                    items: [
                      TittleContainer(
                        child: SingleChildScrollView(
                            controller: ScrollController(),
                            child: Column(children: component(context))),
                      ),
                      TittleContainer(
                        child: SingleChildScrollView(
                            controller: ScrollController(),
                            child: Column(children: secondComponent(context))),
                      ),
                      const BalanceHidrico(),
                    ],
                    carouselController: carouselController,
                    options: Carousel.carouselOptions(context: context)),
              ),
            ),
            isTablet(context)
                ? const Expanded(flex: 5, child: BalanceHidrico())
                : Container(),
            Column(
              children: [
                CrossLine(),
                GrandButton(
                    labelButton: widget._operationButton,
                    weigth: 2000,
                    onPress: () {
                      operationMethod(context);
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }

  // *************************************************************************
  List<Widget> component(BuildContext context) {
    return [
      Spinner(
          isRow: true,
          tittle: "Intervalo de Horario",
          onChangeValue: (String value) {
            setState(() {
              isHorarioValue = value;
              Valores.horario = int.parse(value);
            });
          },
          items: Opciones.horarios(),
          width: isTablet(context) ? 40 : 60,
          initialValue: isHorarioValue),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Via Oral (mL)',
        textController: viaOralTextController,
        numOfLines: 1,
        selection: true,
        withShowOption: true,
        onSelected: () {
          Operadores.editTwoValuesDialog(
              context: context,
              onAcept: (value) {
                Navigator.of(context).pop();
                viaOralTextController.text = value;
              });
        },
        onChange: (value) {
          setState(() {
            Valores.viaOralBalances = double.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Vía Sonda Orogástrica (mL)',
        textController: viaOrogasTextController,
        numOfLines: 1,
        selection: true,
        withShowOption: true,
        onSelected: () {
          Operadores.editTwoValuesDialog(
              context: context,
              onAcept: (value) {
                Navigator.of(context).pop();
                viaOrogasTextController.text = value;
              });
        },
        onChange: (value) {
          setState(() {
            Valores.sondaOrogastricaBalances = double.parse(value);
          });
        },
      ),
      // CrossLine(),
      //
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Vía Hemoderivados (mL)',
        textController: viaHemosTextController,
        numOfLines: 1,
        selection: true,
        withShowOption: true,
        onSelected: () {
          Operadores.editTwoValuesDialog(
              context: context,
              onAcept: (value) {
                Navigator.of(context).pop();
                viaHemosTextController.text = value;
              });
        },
        onChange: (value) {
          setState(() {
            Valores.hemoderivadosBalances = double.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Vía N.P.T. (mL)',
        textController: viaNutrianTextController,
        numOfLines: 1,
        selection: true,
        withShowOption: true,
        onSelected: () {
          Operadores.editTwoValuesDialog(
              context: context,
              onAcept: (value) {
                Navigator.of(context).pop();
                viaNutrianTextController.text = value;
              });
        },
        onChange: (value) {
          setState(() {
            Valores.nutricionParenteralBalances = double.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Vía Sol. Parenterales (mL)',
        textController: viaParesTextController,
        numOfLines: 1,
        selection: true,
        withShowOption: true,
        onSelected: () {
          Operadores.editTwoValuesDialog(
              context: context,
              onAcept: (value) {
                Navigator.of(context).pop();
                viaParesTextController.text = value;
              });
        },
        onChange: (value) {
          setState(() {
            Valores.parenteralesBalances = double.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Vía Diluciones (mL)',
        textController: viaDilucionesTextController,
        numOfLines: 1,
        selection: true,
        withShowOption: true,
        onSelected: () {
          Operadores.editTwoValuesDialog(
              context: context,
              onAcept: (value) {
                Navigator.of(context).pop();
                viaDilucionesTextController.text = value;
              });
        },
        onChange: (value) {
          setState(() {
            Valores.dilucionesBalances = double.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Otros Ingresos (mL)',
        textController: viaOtrosIngresosTextController,
        numOfLines: 1,
        selection: true,
        withShowOption: true,
        onSelected: () {
          Operadores.editTwoValuesDialog(
              context: context,
              onAcept: (value) {
                Navigator.of(context).pop();
                viaOtrosIngresosTextController.text = value;
              });
        },
        onChange: (value) {
          setState(() {
            Valores.otrosIngresosBalances = double.parse(value);
          });
        },
      ),
    ];
  }

  List<Widget> secondComponent(BuildContext context) {
    return [
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Vía Uresis (mL)',
        textController: viaUresisTextController,
        numOfLines: 1,
        selection: true,
        withShowOption: true,
        onSelected: () {
          Operadores.editTwoValuesDialog(
              context: context,
              onAcept: (value) {
                Navigator.of(context).pop();
                viaUresisTextController.text = value;
              });
        },
        onChange: (value) {
          Valores.uresisBalances = double.parse(value);
          setState(() {});
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Vía Evacuacionees. (mL)',
        textController: viaEvacTextController,
        numOfLines: 1,
        selection: true,
        withShowOption: true,
        onSelected: () {
          Operadores.editTwoValuesDialog(
              context: context,
              onAcept: (value) {
                Navigator.of(context).pop();
                viaEvacTextController.text = value;
              });
        },
        onChange: (value) {
          setState(() {
            Valores.evacuacionesBalances = double.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Vía Sangrados (mL)',
        textController: viaSangTextController,
        numOfLines: 1,
        selection: true,
        withShowOption: true,
        onSelected: () {
          Operadores.editTwoValuesDialog(
              context: context,
              onAcept: (value) {
                Navigator.of(context).pop();
                viaSangTextController.text = value;
              });
        },
        onChange: (value) {
          setState(() {
            Valores.sangradosBalances = double.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Vía Succión (mL)',
        textController: viaSucciTextController,
        numOfLines: 1,
        selection: true,
        withShowOption: true,
        onSelected: () {
          Operadores.editTwoValuesDialog(
              context: context,
              onAcept: (value) {
                Navigator.of(context).pop();
                viaSucciTextController.text = value;
              });
        },
        onChange: (value) {
          setState(() {
            Valores.succcionBalances = double.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Perdidas Insensibles (mL)',
        textController: viaPerdidaTextController,
        numOfLines: 1,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Otros Egresos (mL)',
        textController: viaOtrosEgresosTextController,
        numOfLines: 1,
        selection: true,
        withShowOption: true,
        onSelected: () {
          Operadores.editTwoValuesDialog(
              context: context,
              onAcept: (value) {
                Navigator.of(context).pop();
                viaOtrosEgresosTextController.text = value;
              });
        },
        onChange: (value) {
          setState(() {
            Valores.otrosEgresosBalances = double.parse(value);
          });
        },
      ),
      CrossLine(height: 15, thickness: 3),
      Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: [
          CircleIcon(
              radios: 20,
              tittle: '0.4',
              onChangeValue: () {
                Valores.constantePerdidasInsensibles = 0.2;
                viaPerdidaTextController.text =
                    Valores.perdidasInsensibles.toStringAsFixed(2);
              }),
          CircleIcon(
              radios: 20,
              tittle: '0.5',
              onChangeValue: () {
                Valores.constantePerdidasInsensibles = 0.2;
                viaPerdidaTextController.text =
                    Valores.perdidasInsensibles.toStringAsFixed(2);
              }),
          CircleIcon(
              radios: 20,
              tittle: '0.6',
              onChangeValue: () {
                Valores.constantePerdidasInsensibles = 0.6;
                viaPerdidaTextController.text =
                    Valores.perdidasInsensibles.toStringAsFixed(2);
              }),
          CircleIcon(
              radios: 20,
              tittle: '0.5',
              onChangeValue: () {
                Valores.constantePerdidasInsensibles = 0.7;
                viaPerdidaTextController.text =
                    Valores.perdidasInsensibles.toStringAsFixed(2);
              }),
          CircleIcon(
              radios: 20,
              tittle: '0.8',
              onChangeValue: () {
                Valores.constantePerdidasInsensibles = 0.8;
                viaPerdidaTextController.text =
                    Valores.perdidasInsensibles.toStringAsFixed(2);
              }),
          CircleIcon(
              radios: 20,
              tittle: '0.9',
              onChangeValue: () {
                Valores.constantePerdidasInsensibles = 0.9;
                viaPerdidaTextController.text =
                    Valores.perdidasInsensibles.toStringAsFixed(2);
              }),
          CircleIcon(
              radios: 20,
              tittle: '1.1',
              onChangeValue: () {
                Valores.constantePerdidasInsensibles = 1.1;
                viaPerdidaTextController.text =
                    Valores.perdidasInsensibles.toStringAsFixed(2);
              }),
          CircleIcon(
              radios: 20,
              tittle: '1.2',
              onChangeValue: () {
                Valores.constantePerdidasInsensibles = 1.2;
                viaPerdidaTextController.text =
                    Valores.perdidasInsensibles.toStringAsFixed(2);
              }),
        ],
      ),
    ];
  }

  // *************************************************************************
  void operationMethod(BuildContext context) {
    try {
      listOfValues = [
        idOperation,
        Pacientes.ID_Paciente,
        fechaRealizacionTextController.text,
        DateTime.now().toString(),
        // hora
        viaOralTextController.text,
        viaOrogasTextController.text,
        viaHemosTextController.text,
        viaNutrianTextController.text,
        viaParesTextController.text,
        viaDilucionesTextController.text,
        viaOtrosIngresosTextController.text,
        //
        viaUresisTextController.text,
        viaEvacTextController.text,
        viaSangTextController.text,
        viaSucciTextController.text,
        viaDreneTextController.text,
        viaPerdidaTextController.text,
        viaOtrosEgresosTextController.text,
        //
        isHorarioValue,
        //
        Exploracion.tipoSondaVesical,
        //
        idOperation
      ];

      print(
          "${widget.operationActivity} listOfValues $listOfValues ${listOfValues!.length}");

      switch (widget.operationActivity) {
        case Constantes.Nulo:
          // ******************************************** *** *
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(Databases.siteground_database_reghosp,
                  registerQuery!, listOfValues!.removeLast())
              .then((value) {
            Archivos.deleteFile(filePath: Balances.fileAssocieted);
            reiniciar().then((value) => Operadores.alertActivity(
                context: context,
                tittle: "Anexión de registros",
                message: "Registros Agregados",
                onAcept: () {
                  onClose(context);
                }));
          });
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
                    Pacientes.Balances = value;
                    Constantes.reinit(value: value);
                    // ******************************************** *** *
                  }).then((value) {
                    Archivos.deleteFile(filePath: Balances.fileAssocieted);
                    reiniciar()
                        .then((value) => Operadores.alertActivity(
                            context: context,
                            tittle: "Anexión de registros",
                            message: "Registros Agregados",
                            onAcept: () {
                              onClose(context);
                            }))
                        .then((value) => onClose(context));
                  }));
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
                    Pacientes.Balances = value;
                    Constantes.reinit(value: value);
                    // ******************************************** *** *
                  }).then((value) {
                    Archivos.deleteFile(filePath: Balances.fileAssocieted);
                    reiniciar()
                        .then((value) => Operadores.alertActivity(
                            context: context,
                            tittle: "Actualización de registros",
                            message: "Registros Actualizados",
                            onAcept: () {
                              onClose(context);
                            }))
                        .then((value) => onClose(context));
                  }));
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

  Future<void> reiniciar() async {
    Terminal.printExpected(message: "Reinicio de los valores . . .");

    Pacientes.Balances!.clear();
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            Balances.balance['consultIdQuery'], Pacientes.ID_Paciente)
        .then((value) {
      setState(() {
        Pacientes.Balances = value;
        Terminal.printSuccess(
            message:
                "Actualizando Repositorio de Balances del Paciente . . . ${Pacientes.Balances}");

        Archivos.createJsonFromMap(Pacientes.Balances!,
            filePath: Balances.fileAssocieted);
      });
    });
  }

  void onClose(BuildContext context) {
    switch (isMobile(context)) {
      case true:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionBalances()));
        break;
      case false:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionBalances()));
        break;
      default:
    }
  }

  reValue() {
    //
    Valores.viaOralBalances = double.parse(viaOralTextController.text);
    Valores.sondaOrogastricaBalances =
        double.parse(viaOrogasTextController.text);
    Valores.hemoderivadosBalances = double.parse(viaHemosTextController.text);
    Valores.nutricionParenteralBalances =
        double.parse(viaNutrianTextController.text);
    Valores.parenteralesBalances = double.parse(viaParesTextController.text);
    Valores.dilucionesBalances = double.parse(viaDilucionesTextController.text);
    Valores.otrosIngresosBalances =
        double.parse(viaOtrosIngresosTextController.text);

    Valores.uresisBalances = double.parse(viaUresisTextController.text);
    Valores.evacuacionesBalances = double.parse(viaEvacTextController.text);
    Valores.sangradosBalances = double.parse(viaSangTextController.text);
    Valores.succcionBalances = double.parse(viaSucciTextController.text);
    Valores.drenesBalances = double.parse(viaDreneTextController.text);
    Valores.otrosEgresosBalances =
        double.parse(viaOtrosEgresosTextController.text);
  }

  // VARIABLES *************************************************************
  String appBarTitile = "Gestión de Balances";
  String? consultIdQuery = Balances.balance['consultIdQuery'];
  String? registerQuery = Balances.balance['registerQuery'];
  String? updateQuery = Balances.balance['updateQuery'];

  int idOperation = 0;

  List<dynamic>? listOfValues;

  var fechaRealizacionTextController = TextEditingController();
  var isHorarioValue = Balances.actualDiagno[6];

  var viaOralTextController = TextEditingController();
  var viaOrogasTextController = TextEditingController();
  var viaHemosTextController = TextEditingController();
  var viaNutrianTextController = TextEditingController();
  var viaParesTextController = TextEditingController();
  var viaDilucionesTextController = TextEditingController();
  var viaOtrosIngresosTextController = TextEditingController();
  //
  var viaUresisTextController = TextEditingController();
  var viaEvacTextController = TextEditingController();
  var viaSangTextController = TextEditingController();
  var viaSucciTextController = TextEditingController();
  var viaDreneTextController = TextEditingController();
  var viaPerdidaTextController = TextEditingController();
  var viaOtrosEgresosTextController = TextEditingController();
  //
  var carouselController = CarouselController();
}

class GestionBalances extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Pace_APP_ALE";
  // ****************** *** ****** **************

  GestionBalances({Key? key, this.actualSidePage}) : super(key: key);

  @override
  State<GestionBalances> createState() => _GestionBalancesState();
}

class _GestionBalancesState extends State<GestionBalances> {
  String appTittle = "Gestion de balances hídricos del paciente";
  String searchCriteria = "Buscar por Fecha";

  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  var fileAssocieted = Balances.fileAssocieted;

  @override
  void initState() {
    iniciar();
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
            IconButton(
              icon: const Icon(
                Icons.replay_outlined,
              ),
              tooltip: Sentences.reload,
              onPressed: () {
                reiniciar(); // _pullListRefresh();
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
                flex: 9,
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
                          ? GridView.builder(
                              controller: ScrollController(),
                              padding: const EdgeInsets.all(4.0),
                              gridDelegate: GridViewTools.gridDelegate(
                                  crossAxisCount: isMobile(context) ? 1 : 3,
                                  mainAxisExtent:
                                      isMobile(context) ? 150 : 160),
                              shrinkWrap: false,
                              itemCount: snapshot.data == null
                                  ? 0
                                  : snapshot.data.length,
                              itemBuilder: (context, posicion) {
                                return itemListView(
                                    context: context,
                                    snapshot: snapshot,
                                    posicion: posicion);
                              })
                          : Container();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        isDesktop(context)
            ? widget.actualSidePage != null
                ? Expanded(
                    flex: 1,
                    child: Container(
                        decoration: ContainerDecoration.roundedDecoration(),
                        child: widget.actualSidePage!))
                : Expanded(flex: 1, child: Container())
            : Container()
      ]),
    );
  }

  void iniciar() {
    Terminal.printWarning(
        message:
            " . . . Iniciando Actividad - Repositorio Balances del Pacientes"
                .toUpperCase());
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        foundedItems = value[0];
        Pacientes.Balances = value;
        Terminal.printSuccess(
            message: 'Repositorio Balances del Pacientes Obtenido');
      });
    }).onError((error, stackTrace) {
      Terminal.printAlert(
          message:
              'ERROR : No se abrio repositorio local - $error : : $stackTrace');
      reiniciar();
    });
    Terminal.printOther(message: " . . . Actividad Iniciada");
  }

  Future<void> reiniciar() async {
    Terminal.printExpected(message: "Reinicio de los valores . . .");
    Actividades.consultarAllById(Databases.siteground_database_reghosp,
            Balances.balance['consultIdQuery'], Pacientes.ID_Paciente)
        .then((value) {
      setState(() {
        Terminal.printAlert(message: "VALUE $value");
        foundedItems = value;
        Archivos.createJsonFromMap(foundedItems!, filePath: fileAssocieted);
      });
    }).onError((error, stackTrace) {
      Terminal.printAlert(
          message:
              'ERROR : No se realizó conexión con base de datos - $error : : $stackTrace');
      Operadores.alertActivity(
          context: context,
          tittle: "Error al Consultar Información",
          message: 'ERROR :  $error : : $stackTrace',
          onAcept: () {
            Navigator.of(context).pop();
          });
    });
  }

  GestureDetector itemListView(
      {required AsyncSnapshot snapshot,
      required int posicion,
      required BuildContext context}) {
    // print("posicion ${snapshot.data}");
    return GestureDetector(
      onTap: () {
        Balances.fromJson(snapshot.data[posicion]);
        Operadores.openDialog(
            context: context, chyldrim: const BalanceHidrico());
      },
      onDoubleTap: () {
        onSelected(snapshot, posicion, context, Constantes.Update);
      },
      child: Container(
        padding:
            const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 2.0, left: 2.0),
        margin:
            const EdgeInsets.only(top: 2.5, bottom: 2.5, right: 2.0, left: 2.0),
        decoration: ContainerDecoration.roundedDecoration(),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.all(5.0),
                decoration: ContainerDecoration.roundedDecoration(),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Text(
                    snapshot.data[posicion]['ID_Bala'].toString(),
                    style: Styles.textSyle,
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: CrossLine(
                  isHorizontal: false,
                  thickness: 3,
                )),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${snapshot.data[posicion]['Pace_bala_Fecha']}",
                    style: Styles.textSyleGrowth(fontSize: 18),
                  ),
                  Text(
                    "${snapshot.data[posicion]['Pace_bala_time']}",
                    style: Styles.textSyleGrowth(fontSize: 16),
                  ),
                  CrossLine(
                    thickness: 2,
                  ),
                  Row(
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
            ),
          ],
        ),
      ),
    );
  }

  void onSelected(AsyncSnapshot<dynamic> snapshot, int posicion,
      BuildContext context, String operaciones) {
    Balances.Balance = snapshot.data[posicion];
    // Balances.selectedDiagnosis = Balances.balance['Pace_APP_ALE'];
    Pacientes.Balances = snapshot.data;
    //
    Balances.fromJson(Balances.Balance);
    // ************** ********** ************
    toOperaciones(context, operaciones);
  }

  void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void deleteRegister(
      AsyncSnapshot<dynamic> snapshot, int posicion, BuildContext context) {
    try {
      Actividades.eliminar(Databases.siteground_database_reghosp,
          Balances.balance['deleteQuery'], snapshot.data[posicion]['ID_Bala']);
      setState(() {
        snapshot.data.removeAt(posicion);
      });
    } finally {
      Navigator.of(context).pop();
    }
  }

  void toOperaciones(BuildContext context, String operationActivity) {
    init();
    // *********** ************* ********
    if (isDesktop(context)) {
      Constantes.operationsActividad = operationActivity;
      Constantes.reinit(value: foundedItems!);
      _pullListRefresh();
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => OperacionesBalances(
                operationActivity: operationActivity,
              )));
    }
  }

  void _runFilterSearch(String enteredKeyword) {
    List? results = [];

    if (enteredKeyword.isEmpty) {
      _pullListRefresh();
    } else {
      Actividades.consultar(Databases.siteground_database_reghosp,
              Balances.balance['consultByIdPrimaryQuery']!)
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
            pageBuilder: (a, b, c) => GestionBalances(
                  actualSidePage: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OperacionesBalances(
                      operationActivity: Constantes.operationsActividad,
                    ),
                  ),
                ),
            transitionDuration: const Duration(seconds: 0)));
  }

  init() {
    Valores.viaOralBalances = 0;
    Valores.sondaOrogastricaBalances = 0;
    Valores.hemoderivadosBalances = 0;
    Valores.nutricionParenteralBalances = 0;
    Valores.parenteralesBalances = 0;
    Valores.dilucionesBalances = 0;
    Valores.otrosIngresosBalances = 0;

    Valores.uresisBalances = 0;
    Valores.evacuacionesBalances = 0;
    Valores.sangradosBalances = 0;
    Valores.succcionBalances = 0;
    Valores.drenesBalances = 0;
    Valores.otrosEgresosBalances = 0;
  }
}
