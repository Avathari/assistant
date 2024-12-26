import 'dart:convert';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/ventometr%C3%ADas.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/hospitalarios/hospitalizados.dart';
import 'package:assistant/screens/pacientes/auxiliares/hospitalarios/info/Hospitalizado.dart';
import 'package:assistant/screens/pacientes/auxiliares/revisiones/auxiliares/auxiliaresGenerales.dart';
import 'package:assistant/screens/pacientes/auxiliares/revisiones/generales.dart';
import 'package:assistant/screens/pacientes/epidemiologicos/licencias.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/pendientes.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';

class Paneles {
  static Widget fichaIdentificacion(
      BuildContext context, AsyncSnapshot snapshot, int index) {
    Terminal.printAlert(message: "indexx $index");
    //
    if (snapshot.hasData) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: GestureDetector(
          onTap: () => Datos.portapapeles(
              context: context, text: snapshot.data![index].nssPaciente),
          onDoubleTap: () => Datos.portapapeles(
              context: context,
              text: snapshot.data![index].nssAgregadoPaciente),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "${snapshot.data![index].generales['Pace_Ape_Pat'] ?? ''} "
                  "${snapshot.data![index].generales['Pace_Ape_Mat'] ?? ''} "
                  "${snapshot.data![index].generales['Pace_Nome_PI'] ?? ''} "
                  "${snapshot.data![index].generales['Pace_Nome_SE'] ?? ''}",
                  maxLines: 2,
                  style: Styles.textSyleGrowth(fontSize: 14)),
              Text(
                "Ocupación: ${snapshot.data![index].generales['Pace_Ocupa'] ?? ''}",
                maxLines: 2,
                style: Styles.textSyleGrowth(fontSize: 10),
              ),
              Text(
                "Edad ${snapshot.data[index].generales['Pace_Eda'] ?? ''} Años . ",
                maxLines: 1,
                style: Styles.textSyleGrowth(fontSize: 10),
              ),
              // Text(
              //   "Hemotipo: ${snapshot.data[index].hospitalizedData['Pace_Hemo'] ?? ''}",
              //   maxLines: 2,
              //   style: Styles.textSyleGrowth(fontSize: 10),
              // ),
              // Text(
              //   "Servicio: ${snapshot.data[index].hospitalizedData['Serve_Trat'] ?? ''}",
              //   maxLines: 2,
              //   style: Styles.textSyleGrowth(fontSize: 10),
              // ),
              // Text(
              //   "${snapshot.data[index].hospitalizedData['Medi_Trat'] ?? ''}",
              //   maxLines: 2,
              //   overflow: TextOverflow.ellipsis,
              //   style: Styles.textSyleGrowth(fontSize: 10),
              // ),
              Text(
                  "NG.: ${snapshot.data[index].hospitalizedData['Feca_INI_Hosp'] ?? ''} - "
                  "D.E.H.: ${Calendarios.differenceInDaysToNow(snapshot.data[index].hospitalizedData['Feca_INI_Hosp'] ?? DateTime.now().toString())}",
                  style: Styles.textSyleGrowth(fontSize: 12)),
              CrossLine()
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  static Widget padesView(
      BuildContext context, AsyncSnapshot snapshot, int index) {
    if (snapshot.data![index].padecimientoActual.isEmpty) {
      return GestureDetector(
          onDoubleTap: () {
            Operadores.openWindow(
                context: context,
                chyldrim: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data![index].padecimientoActual == null
                          ? 'Sin Padecimiento Actual'
                          : "Padecimiento Actual:\n ${snapshot.data![index].padecimientoActual['Padecimiento_Actual'] ?? ''}",
                      maxLines: isMobile(context) ? 20 : 10,
                      softWrap: true,
                      style: Styles.textSyleGrowth(fontSize: 10),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ));
          },
          child: Text(
            "PA: Sin padecimiento actual registrado . . . ",
            maxLines: isLargeDesktop(context) ? 65 : 45,
            style: Styles.textSyleGrowth(fontSize: 8),
            textAlign: TextAlign.start,
          ));
    } else {
      return GestureDetector(
        onDoubleTap: () {
          Operadores.openWindow(
              context: context,
              chyldrim: Column(
                children: [
                  TittleContainer(
                    color: Colors.black,
                    tittle: 'Padecimiento Actual',
                    child: Text(
                      snapshot.data![index].padecimientoActual == null
                          ? 'Sin Padecimiento Actual'
                          : " ${snapshot.data![index].padecimientoActual['Padecimiento_Actual'] ?? ''}",
                      maxLines: isMobile(context) ? 85 : 45,
                      softWrap: true,
                      style: Styles.textSyleGrowth(fontSize: 10),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
              onAction: () {});
        },
        child: TittleContainer(
          tittle: 'Padecimiento Actual',
          color: Theming.cuaternaryColor,
          child: Text(
            "${snapshot.data![index].padecimientoActual['Padecimiento_Actual'] ?? 'Sin padecimiento actual registrado . . . '}",
            maxLines: isLargeDesktop(context)
                ? 65
                : isDesktop(context)
                    ? 95
                    : 65,
            style: Styles.textSyleGrowth(fontSize: 8),
            textAlign: TextAlign.start,
          ),
        ),
      );
    }
  }

  static Widget auxiliarPanel(AsyncSnapshot snapshot, int index) {
    return GridView.builder(
        padding: const EdgeInsets.all(4),
        gridDelegate:
            GridViewTools.gridDelegate(crossAxisCount: 1, mainAxisExtent: 55),
        itemCount: Listas.listWithoutRepitedValues(
                Listas.listFromMapWithOneKey(snapshot.data[index].paraclinicos))
            .length,
        // snapshot.data[index].paraclinicos.length,
        itemBuilder: (BuildContext context, int posit) {
          var list = Listas.listWithoutRepitedValues(
              Listas.listFromMapWithOneKey(snapshot.data[index].paraclinicos));
          return ValuePanel(
            secondText: "${list[posit]}", // Resultado
            withEditMessage: false,
            onEdit: (value) {
              Pacientes.Paraclinicos = snapshot.data[index].paraclinicos;
              Terminal.printExpected(
                  message:
                      "snapshot.data[index].paraclinicos ${snapshot.data[index].paraclinicos}");

              Datos.portapapeles(
                  context: context,
                  text: Auxiliares.porFecha(fechaActual: value));
            },
          );
        });
  }

  static Widget cronicosPanel(
      BuildContext context, AsyncSnapshot snapshot, int index) {
    return TittleContainer(
        color: isMobile(context) ? Theming.cuaternaryColor : Colors.black,
        tittle: "Crónico(s) ",
        child: ListView.separated(
          itemCount: snapshot.data![index].patologicos.length,
          itemBuilder: (BuildContext context, ind) {
            return ElevatedButton(
              onPressed: () {
                Pacientes.Diagnosticos = snapshot.data![index].patologicos;
                Operadores.optionsActivity(
                    context: context,
                    tittle: "Diagnóstico seleccionado . . . ",
                    message: Patologicos.getPatologicos(
                        snapshot.data![index].patologicos[ind]),
                    onClose: () => Navigator.of(context).pop(),
                    textOptionA: "Copiar antecedente en portapapeles . . . ",
                    optionA: () => Datos.portapapeles(
                        context: context,
                        text: Patologicos.getPatologicos(
                            snapshot.data![index].patologicos[ind])));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: Text(
                snapshot.data![index].patologicos[ind]['Pace_APP_DEG'],
                style: Styles.textSyleGrowth(fontSize: 8),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 8);
          },
        ));
  }

  static Widget diagnosticosPanel(
      BuildContext context, AsyncSnapshot snapshot, int index) {
    return TittleContainer(
        color: isMobile(context) ? Theming.cuaternaryColor : Colors.black,
        tittle: "Diagnóstico(s) ",
        child: ListView.builder(
            itemCount: snapshot.data![index].diagnosticos.length,
            itemBuilder: (BuildContext context, ind) {
              return ElevatedButton(
                onPressed: () {
                  Pacientes.Diagnosticos = snapshot.data![index].diagnosticos;
                  Operadores.alertActivity(
                      context: context,
                      tittle: "Diagnóstico seleccionado . . . ",
                      message:
                          snapshot.data![index].diagnosticos[ind].toString(),
                      onAcept: () => Navigator.of(context).pop());
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: Text(
                  snapshot.data![index].diagnosticos[ind]['Pace_APP_DEG'],
                  style: Styles.textSyleGrowth(fontSize: 8),
                ),
              );
              return Text(
                snapshot.data![index].diagnosticos[ind]['Pace_APP_DEG'],
                style: Styles.textSyleGrowth(fontSize: 9),
              );
            }));
  }

  static Widget pendientesPanel(
      BuildContext context, AsyncSnapshot snapshot, int index) {
    return TittleContainer(
      tittle: 'Pendiente(s)',
      color: isMobile(context) ? Theming.cuaternaryColor : Colors.black,
      child: Column(
        children: [
          Expanded(
              flex: 5,
              child: ListView.builder(
                  itemCount: snapshot.data![index].pendientes.length,
                  itemBuilder: (BuildContext context, int ind) {
                    if (snapshot.data![index].pendientes[ind]['Pace_PEN'] !=
                        'Procedimientos') {
                      if (snapshot.data![index].pendientes[ind]
                                  ['Pace_PEN_realized'] ==
                              true ||
                          snapshot.data![index].pendientes[ind]
                                  ['Pace_PEN_realized'] ==
                              1) {
                        return ElevatedButton(
                          onPressed: () {
                            Pacientes.Pendiente =
                                snapshot.data![index].pendientes;
                            Operadores.optionsActivity(
                                context: context,
                                tittle: "Diagnóstico seleccionado . . . ",
                                message: Pendientes.getPendiente(
                                    snapshot.data![index].pendientes[ind]),
                                onClose: () => Navigator.of(context).pop(),
                                textOptionA:
                                    "Copiar antecedente en portapapeles . . . ",
                                optionA: () => Datos.portapapeles(
                                    context: context,
                                    text: Pendientes.getPendiente(snapshot
                                        .data![index].pendientes[ind])));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          child: Text(
                            snapshot.data![index].pendientes[ind]
                                ['Pace_Desc_PEN'],
                            style: Styles.textSyleGrowth(fontSize: 8),
                          ),
                        );
                      }
                    }
                    return null;
                  })),
        ],
      ),
    );
  }

  static Widget signosVitales(
          BuildContext context, AsyncSnapshot snapshot, int index) =>
      TittleContainer(
          color: isMobile(context) ? Theming.cuaternaryColor : Colors.black,
          tittle: 'Signos Vitales . . . ',
          child: snapshot.data![index].vitales.isNotEmpty
              ? Wrap(
                  children: [
                    ValuePanel(
                      firstText: snapshot
                          .data![index].vitales.last['Pace_SV_tas']
                          .toString(),
                    ),
                    ValuePanel(
                      firstText: snapshot
                          .data![index].vitales.last['Pace_SV_tad']
                          .toString(),
                    ),
                    ValuePanel(
                      firstText: snapshot
                          .data![index].vitales.last['Pace_SV_fc']
                          .toString(),
                    ),
                    ValuePanel(
                      firstText: snapshot
                          .data![index].vitales.last['Pace_SV_fr']
                          .toString(),
                    ),
                    ValuePanel(
                      firstText: snapshot
                          .data![index].vitales.last['Pace_SV_tc']
                          .toString(),
                    ),
                    ValuePanel(
                      firstText: snapshot
                          .data![index].vitales.last['Pace_SV_spo']
                          .toString(),
                    ),
                    ValuePanel(
                      firstText: snapshot
                          .data![index].vitales.last['Pace_SV_est']
                          .toString(),
                    ),
                    ValuePanel(
                      firstText: snapshot
                          .data![index].vitales.last['Pace_SV_pct']
                          .toString(),
                    ),
                    ValuePanel(
                      firstText: snapshot
                          .data![index].vitales.last['Pace_SV_glu']
                          .toString(),
                    ),
                    ValuePanel(
                      firstText: snapshot
                          .data![index].vitales.last['Pace_SV_glu_ayu']
                          .toString(),
                    ),
                  ],
                )
              : Container());

  static opcionesPanel(BuildContext context, List? foundedItems, int index) {
    return Wrap(
      alignment: WrapAlignment.center,
      runSpacing: 10,
      spacing: 5,
      children: [
        CircleIcon(
          radios: 30,
          difRadios: 5,
          iconed: Icons.medical_services_outlined,
          onChangeValue: () async {
            Pacientes.ID_Paciente = foundedItems![index].idPaciente;
            Terminal.printWarning(
                message: "ID (Opcion Panel) : ${Pacientes.ID_Paciente}");
            //
            if (foundedItems[index].vitales.isNotEmpty) {
              Valores.alturaPaciente =
                  foundedItems[index].vitales.last['Pace_SV_est'];
              Valores.pesoCorporalTotal = double.parse(
                  foundedItems[index].vitales.last['Pace_SV_pct'].toString());
            } else {
              Valores.alturaPaciente = 0;
              Valores.pesoCorporalTotal = 0;
            }

            Pacientes.localRepositoryPath =
                foundedItems[index].localRepositoryPath;
            //
            Cambios.toNextActivity(context,
                tittle: "Signos Vitales del Paciente . . . ",
                chyld: SingleChildScrollView(
                    controller: ScrollController(), child: AuxiliarVitales()));
          },
          onLongChangeValue: () async {
            Pacientes.ID_Paciente = foundedItems![index].idPaciente;
            Terminal.printWarning(
                message: "ID (Opcion Panel) : ${Pacientes.ID_Paciente}");
            //
            // Pacientes(
            //   "",
            //   "",
            //   foundedItems[index].generales['Pace_Ape_Pat'] ?? '',
            //   foundedItems[index].generales['Pace_Ape_Mat'] ?? '',
            //   foundedItems[index].generales['Pace_Nome_PI'] ?? '',
            //   foundedItems[index].generales['Pace_Nome_SE'] ?? '',
            //   "",
            // );
            //
            if (foundedItems[index].vitales.isNotEmpty) {
              Valores.alturaPaciente =
                  foundedItems[index].vitales.last['Pace_SV_est'];
              Valores.pesoCorporalTotal = double.parse(
                  foundedItems[index].vitales.last['Pace_SV_pct'].toString());
            } else {
              Valores.alturaPaciente = 0;
              Valores.pesoCorporalTotal = 0;
            }

            Pacientes.localRepositoryPath =
                foundedItems[index].localRepositoryPath;
            //
            Cambios.toNextPage(context, Generales());
          },
        ), // Signos Vitales
        CircleIcon(
            radios: 25,
            difRadios: 5,
            iconed: Icons.list_alt_sharp,
            onChangeValue: () {
              Pacientes.ID_Paciente = foundedItems![index].idPaciente;
              Pacientes.ID_Hospitalizacion =
                  foundedItems[index].idHospitalizado =
                      foundedItems[index].hospitalizedData['ID_Hosp'];
              // Agregarr a Pacientes.nombreCompleto sus variables correspondientes . . .
              Pacientes.nombreCompleto = foundedItems[index].nombreCompleto;
              // ******************* * * * * * * *** *
              Cambios.toNextPage(
                  context,
                  GestionPendiente(
                      withReturn: true,
                      actualSidePage: OperacionesPendiente(
                        withReturn: true,
                        operationActivity: Constantes.Register,
                      )));
            }), // Pendientes
        CircleIcon(
            radios: 25,
            difRadios: 5,
            onChangeValue: () {
              try {
                Pacientes.ID_Paciente = foundedItems![index].idPaciente;
                Pacientes.ID_Hospitalizacion =
                    foundedItems[index].idHospitalizado;
                // //
                Cambios.toNextActivity(context,
                    backgroundColor: Theming.cuaternaryColor,
                    chyld: const AuxiliaresDispositivos());
              } catch (onError, stackTrace) {
                // TODO
                Operadores.alertActivity(
                    context: context,
                    tittle: "Error al Cargar Valores . . . ",
                    message: "ERROR : : $onError \n: $stackTrace",
                    onAcept: () => Navigator.of(context).pop());
              }
            }), // AuxiliarVitales // Subjetivos
      ],
    );
  }

//
  static paraclinicosPanel(
      BuildContext context, AsyncSnapshot snapshot, int index) {
    return TittleContainer(
        centered: isMobile(context) ? true : false,
        tittle: isMobile(context) ? "LAB's" : 'Laboratorios',
        padding: 3.0,
        color: isMobile(context)
            ? Theming.cuaternaryColor
            : Theming.cuaternaryColor,
        child: ListView.separated(
            controller: ScrollController(),
            padding: const EdgeInsets.only(top: 10.0),
            itemCount: Listas.listWithoutRepitedValues(
                    Listas.listFromMapWithOneKey(
                        snapshot.data[index].paraclinicos))
                .length,
            itemBuilder: (BuildContext context, ind) {
              var list = Listas.listWithoutRepitedValues(
                  Listas.listFromMapWithOneKey(
                      snapshot.data[index].paraclinicos));
              //
              return ElevatedButton(
                onPressed: () {
                  Pacientes.Paraclinicos = snapshot.data![index].paraclinicos;

                  Terminal.printExpected(
                      message:
                          "snapshot.data![index].paraclinicos ${snapshot.data![index].paraclinicos}");

                  Datos.portapapeles(
                      context: context,
                      text: Auxiliares.porFecha(
                          fechaActual: list[ind], esAbreviado: true));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: Text(
                  Calendarios.formatDate(list[ind]),
                  style: Styles.textSyleGrowth(fontSize: 8),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 8)));
  }

  //
  static licenciasPanel(
      BuildContext context, AsyncSnapshot snapshot, int index) {
    return TittleContainer(
      tittle: 'Licencias(s)',
      padding: 2,
      color: isMobile(context) ? Theming.cuaternaryColor : Colors.black,
      child: isDesktop(context) || isLargeDesktop(context)
          ? Column(
              children: [
                Expanded(
                    flex: 5,
                    child: ListView.builder(
                        itemCount: snapshot.data![index].licencias.length,
                        itemBuilder: (BuildContext context, int ind) {
                          return ListTile(
                            title: Text(
                              snapshot.data![index].licencias[ind]['Folio'],
                              style: Styles.textSyleGrowth(fontSize: 9),
                            ),
                            subtitle: Text(
                              snapshot.data![index].licencias[ind]
                                      ['Fecha_Inicio'] +
                                  " : " +
                                  snapshot.data![index].licencias[ind]
                                      ['Fecha_Termino'] +
                                  " : : " +
                                  "${snapshot.data![index].licencias[ind]['Dias_Otorgados']} Días",
                              style: Styles.textSyleGrowth(fontSize: 9),
                            ),
                            onTap: () {
                              Operadores.openWindow(
                                  context: context,
                                  chyldrim: Center(
                                    child: snapshot.data![index].licencias[ind]
                                                ['Licencia_FIAT'] !=
                                            null
                                        ? Image.memory(base64Decode(snapshot
                                            .data![index]
                                            .licencias[ind]['Licencia_FIAT']))
                                        : Container(),
                                  ));
                            },
                          );
                        })),
                CrossLine(thickness: 3),
                CircleIcon(
                    radios: 25,
                    difRadios: 5,
                    iconed: Icons.list_alt_sharp,
                    onChangeValue: () {
                      Pacientes.ID_Paciente = snapshot.data![index].idPaciente;
                      Pacientes.ID_Hospitalizacion =
                          snapshot.data![index].idHospitalizado =
                              snapshot.data![index].hospitalizedData['ID_Hosp'];
                      //
                      Cambios.toNextActivity(context,
                          chyld: OperacionesLicencia());
                    }),
              ],
            )
          : Row(
              children: [
                Expanded(
                    flex: 5,
                    child: ListView.separated(
                      itemCount: snapshot.data![index].licencias.length,
                      itemBuilder: (BuildContext context, int ind) {
                        return ListTile(
                          title: Text(
                            snapshot.data![index].licencias[ind]['Folio'],
                            style: Styles.textSyleGrowth(fontSize: 10),
                          ),
                          subtitle: Text(
                            snapshot.data![index].licencias[ind]
                                    ['Fecha_Inicio'] +
                                " : " +
                                snapshot.data![index].licencias[ind]
                                    ['Fecha_Termino'] +
                                "\n : : " +
                                "${snapshot.data![index].licencias[ind]['Dias_Otorgados']} Días",
                            style: Styles.textSyleGrowth(fontSize: 7),
                          ),
                          onTap: () {
                            Operadores.openWindow(
                                context: context,
                                chyldrim: Center(
                                  child: snapshot.data![index].licencias[ind]
                                              ['Licencia_FIAT'] !=
                                          null
                                      ? Image.memory(base64Decode(snapshot
                                          .data![index]
                                          .licencias[ind]['Licencia_FIAT']))
                                      : Container(),
                                ));
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return CrossLine(height: 7, thickness: 2);
                      },
                    )),
                // CrossLine(thickness: 3),
                CircleIcon(
                    radios: 25,
                    difRadios: 5,
                    iconed: Icons.list_alt_sharp,
                    onChangeValue: () {
                      Pacientes.ID_Paciente = snapshot.data![index].idPaciente;
                      Pacientes.ID_Hospitalizacion =
                          snapshot.data![index].idHospitalizado =
                              snapshot.data![index].hospitalizedData['ID_Hosp'];
                      //
                      Cambios.toNextActivity(context,
                          chyld: OperacionesLicencia(
                            withAppBar: false,
                            operationActivity: Constantes.Register,
                          ));
                    }),
              ],
            ),
    );
  }

  static middlePanel(BuildContext context, AsyncSnapshot snapshot, int index) {
    return TittleContainer(child: Container());
  }

  // ESTADÍSTICAS ***************************************************
  static HospitalaryNewbies(BuildContext context, List? foundedItems) {
    // VARIABLES ************************
    // paraclinicos
    List<Widget> widgets = [];
    String param = "";
    for (var element in foundedItems!) {
      Pacientes.Paraclinicos = element.paraclinicos;
      //
      param = "$param CAMA ${element.hospitalizedData['Id_Cama']} : : "
          "${Auxiliares.getUltimo(esAbreviado: true)}"
          "${Auxiliares.getEspeciales(esAbreviado: true)}\n";
      //
      widgets.add(
        TittleContainer(
          tittle: element.hospitalizedData['Id_Cama'],
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Text(
              Auxiliares.getUltimo(esAbreviado: true) + "\n"
                  +Auxiliares.getEspeciales(esAbreviado: true) ,
              overflow: TextOverflow.ellipsis,
              style: Styles.textSyleGrowth(fontSize: 12),
              maxLines: 7,
            ),
          ),
        ),
      );
    }
    // RETORNO *********************************
    return Container(
      child: Row(
        children: [
          Expanded(flex: 4,
            child: ListView(
              children: widgets,
            ),
          ),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            CircleIcon(onChangeValue: () {
              Datos.portapapeles(context: context, text: param);
            }),
          ],))
        ],
      ),
    );
  }

  static HospitalaryStadystics(BuildContext context, List? foundedItems) {
    // VARIABLES ************************
    int hombres = 0, mujeres = 0;
    int cortaEstancia = 0, largaEstancia = 0;
    List<List<String>> nssPacientes = [];

    for (var element in foundedItems!) {
      nssPacientes.add([
        element.generales['Pace_Ape_Pat'] +
            " " +
            element.generales['Pace_Ape_Mat'] +
            " " +
            element.generales['Pace_Nome_PI'] +
            " " +
            element.generales['Pace_Nome_SE'],
        element.generales['Pace_NSS'].replaceAll(" ", ""),
      ]);
    }
    // Terminal.printExpected(message: nssPacientes.toString());

    /// Total de Registros : : Hombres y Mujeres . . .
    for (var element in foundedItems!) {
      if (element.generales['Pace_Ses'] == 'Masculino') {
        hombres++;
      } else if (element.generales['Pace_Ses'] == 'Femenino') {
        mujeres++;
      }
    }

    /// DIAS DE ESTANCIA . . .
    for (var element in foundedItems) {
      print(element.generales);
      // print(Calendarios.differenceInDaysToNow(element.hospitalizedData['Feca_INI_Hosp'] ?? Calendarios.today(format: "yyyy-MM-dd")));

      if (element.hospitalizedData['Dia_Estan'] != null) {
        if (int.parse(element.hospitalizedData['Dia_Estan'].toString()) <= 7) {
          cortaEstancia++;
        } else if (int.parse(element.hospitalizedData['Dia_Estan'].toString()) >
            7) {
          largaEstancia++;
        }
      }
    }

    Terminal.printExpected(
        message: "ESTADISTICAS ********************** \n"
            "TOTAL : : ${foundedItems.length} . . . \n "
            " . . . : Hombres : $hombres\n"
            " . . . : Mujeres : $mujeres\n"
            "**************************************** \n"
            " . . . : Corta Estancia : $cortaEstancia\n"
            " . . . : Larga Estancia : $largaEstancia\n"
            "**************************************** \n");
    // RETORNO *********************************
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: TittleContainer(
                    tittle: " . . . # . . . ",
                    padding: 2.0,
                    color: Colors.black,
                    child: Column(
                      children: [
                        ValuePanel(
                          firstText: "Hombres",
                          secondText: hombres.toString(),
                        ),
                        ValuePanel(
                          firstText: "Mujeres",
                          secondText: mujeres.toString(),
                        ),
                        CrossLine(),
                        ValuePanel(
                          firstText: "Total",
                          secondText: (hombres + mujeres).toStringAsFixed(0),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TittleContainer(
                    tittle: " . . . # Larga Estancia # . . . ",
                    padding: 4.0,
                    color: Colors.black,
                    child: Column(
                      children: [
                        ValuePanel(
                          firstText: "Corta Estancia",
                          secondText: cortaEstancia.toString(),
                        ),
                        ValuePanel(
                          firstText: "Larga Estancia",
                          secondText: largaEstancia.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                //
                CrossLine(),
                Expanded(
                  child: GrandIcon(
                      iconData: Icons.numbers,
                      onPress: () => Operadores.selectWithTittleOptionsActivity(
                            context: context,
                            options: nssPacientes,
                            onClose: (value) => Datos.portapapeles(
                                context: context, text: value.toString()),
                          )),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: HospitalaryPendientes(context, foundedItems),
          ),
        ],
      ),
    );
  }

  static Widget HospitalaryPendientes(
      BuildContext context, List? foundedItems) {
    // LIST OF WIDGETS
    List<Widget> widgets = [];
    int idCama = 0;

    // Terminal.printWarning(message: "PENDIENTES : ${foundedItems![0].hospitalizedData.keys.toString()}");
    for (int index = 0; index < foundedItems!.length; index++) {
      //
      if (foundedItems[index].hospitalizedData['Id_Cama'] != "N/A") {
        idCama =
            int.parse(foundedItems[index].hospitalizedData['Id_Cama'] ?? "0");
      }
      //

      //
      List<Widget> pendientes = [];
      for (var pendiente in foundedItems[index].pendientes) {
        //
        // if (pendiente['Pace_PEN_realized'] == 1) {
        if (pendiente['Pace_PEN_realized'] == 0 &&
            (pendiente['Pace_PEN'] == Pendientes.typesPendientes[1] ||
                pendiente['Pace_PEN'] == Pendientes.typesPendientes[2])) {
          // Terminal.printExpected(message: "${foundedItems![index].pendientes}");
          pendientes.add(Text(
            "${pendiente['Feca_PEN']} : : ${pendiente['Pace_Desc_PEN']}",
            textAlign: TextAlign.left,
            style: Styles.textSyleGrowth(fontSize: 8),
          ));
        }
        // if (pendiente['Pace_PEN'] =='Procedimientos') {
        //
        // }
      }
      // BUSQUEDA DE CULTIVOS . . .
      pendientes.add(CrossLine());
      pendientes.add(Text(
        Internado.getCultivos(listadoFrom: foundedItems[index].paraclinicos),
        // overflow: TextOverflow,
        maxLines: 5,
        style: Styles.textSyleGrowth(fontSize: 8),
      ));
      pendientes.add(CrossLine());
      pendientes.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GrandIcon(
            labelButton: "Auxiliares Pendientes . . . ",
            iconData: Icons.newspaper_rounded,
            onPress: () {
              String pendientario = "";
              for (var pendiente in foundedItems[index].pendientes) {
                //
                if (pendiente['Pace_PEN_realized'] == 0 &&
                    (pendiente['Pace_PEN'] == Pendientes.typesPendientes[1] ||
                        pendiente['Pace_PEN'] ==
                            Pendientes.typesPendientes[2])) {
                  pendientario =
                      "$pendientario${pendiente['Feca_PEN']} : : ${pendiente['Pace_Desc_PEN']}\n";
                  //
                  // if (pendiente['Pace_PEN'] == Pendientes.typesPendientes[1]){
                  //   pendientario =
                  //   "$pendientario${pendiente['Feca_PEN']} : : ${pendiente['Pace_Desc_PEN']}\n";
                  // } else if (pendiente['Pace_PEN'] ==
                  // Pendientes.typesPendientes[2]){
                  //
                  // } else {
                  //   pendientario = pendientario;
                  // }

                  // Terminal.printExpected(message: "${foundedItems![index].pendientes}");
                }
              }
              Datos.portapapeles(context: context, text: pendientario);
            },
          ),
          GrandIcon(
            labelButton: "Cultivos Recabados . . . ",
            iconData: Icons.hourglass_bottom,
            onPress: () {
              Datos.portapapeles(
                  context: context,
                  text: Internado.getCultivos(
                      listadoFrom: foundedItems[index].paraclinicos));
            },
          ),
        ],
      ));
      //
      widgets.add(TittleContainer(
          tittle: "$idCama",
          padding: 10.0,
          child: Column(
            children: pendientes,
          )));
    }
    return Column(
      children: [
        Expanded(
          child: TittleContainer(
            tittle: "Pendientes Recabados . . . ",
            padding: 2.0,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 8.0),
              controller: ScrollController(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widgets,
              ),
            ),
          ),
        ),
        CrossLine(),
        SizedBox(
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GrandIcon(
                  labelButton: "Pendientes recabados . . . ",
                  iconData: Icons.newspaper_rounded,
                  onPress: () {
                    // OBTENER TODOS LOS PENDIENTES REGISTRADOS
                    String pendientes0 = "";
                    //
                    for (int index = 0; index < foundedItems.length; index++) {
                      //
                      if (foundedItems[index].hospitalizedData['Id_Cama'] !=
                          "N/A") {
                        idCama = int.parse(
                            foundedItems[index].hospitalizedData['Id_Cama'] ??
                                "0");
                      }
                      //
                      String pendie = "";
                      //
                      for (var pendiente in foundedItems[index].pendientes) {
                        //
                        if (pendiente['Pace_PEN_realized'] == 0 &&
                            (pendiente['Pace_PEN'] ==
                                    Pendientes.typesPendientes[1] ||
                                pendiente['Pace_PEN'] ==
                                    Pendientes.typesPendientes[2])) {
                          // Terminal.printExpected(message: "${foundedItems![index].pendientes}");
                          pendie =
                              "$pendie${pendiente['Feca_PEN']} : : ${pendiente['Pace_Commen_PEN']}\n"; // Pace_Commen_PEN Pace_Desc_PEN
                        }
                      }
                      pendientes0 = "$pendientes0$idCama : : $pendie\n";
                    }
                    //
                    Datos.portapapeles(context: context, text: pendientes0);
                  }),
              GrandIcon(
                  labelButton: "Cultivos Recabados",
                  iconData: Icons.hourglass_bottom,
                  onPress: () {
                    // OBTENER TODOS LOS CULTIVOS REGISTRADOS
                    String cultivos = "";
                    //
                    for (int index = 0; index < foundedItems.length; index++) {
                      if (foundedItems[index].hospitalizedData['Id_Cama'] !=
                          "N/A") {
                        idCama = int.parse(
                            foundedItems[index].hospitalizedData['Id_Cama'] ??
                                "0");
                      }

                      cultivos =
                          "$cultivos\n$idCama : : ${Internado.getCultivos(listadoFrom: foundedItems[index].paraclinicos)}";
                      //
                    }
                    //
                    Datos.portapapeles(context: context, text: cultivos);
                  }),
            ],
          ),
        ),
      ],
    );
  }
}

class HospitalaryStrings {
  static String vitalesString(last) {
    return "${last['Pace_Feca_SV']} : "
        "${last['Pace_SV_tas']}/"
        "${last['Pace_SV_tad']} mmHg, "
        "FC ${last['Pace_SV_fc']} Lat/min, "
        "FR ${last['Pace_SV_fr']} Resp/min, "
        "Temp ${last['Pace_SV_tc']}°C, "
        "SpO2 ${last['Pace_SV_spo']}%, "
        "PCT ${last['Pace_SV_pct']} Kg, "
        "EST ${last['Pace_SV_est']} mts, "
        "Glucemia ${last['Pace_SV_glu']} mg/dL "
        "(${last['Pace_SV_glu_ayu']} Horas)";
  }

  static String balancesString(last, List? foundedItems, int index) {
    Terminal.printAlert(message: "${last[0].runtimeType}");
    //
    if (last[0].runtimeType is List<dynamic>) {
      Balances.fromJson(last[0]);
    } else if (last[0].runtimeType is Map<String, dynamic>) {
      Balances.fromJson(last);
    } else {
      Balances.fromJson(last);
    }

    //
    Valores.pesoCorporalTotal = double.parse(
        foundedItems![index].vitales.last["Pace_SV_pct"].toString() ?? '0');
    //
    return "${last['Pace_bala_Fecha']} : "
        "Ingresos ${Valores.ingresosBalances.toStringAsFixed(1)} mL, "
        "Egresos ${Valores.egresosBalances.toStringAsFixed(1)} mL . "
        "[Perdidas Insensibles ${Valores.perdidasInsensibles.toStringAsFixed(1)} mL]"
        " :  BT ${Valores.balanceTotal.toStringAsFixed(2)} mL ("
        "Uresis ${Valores.uresisBalances!.toStringAsFixed(2)} mL : "
        "UKH ${Valores.diuresis.toStringAsFixed(2)} mL/Kg/${Valores.horario} Hr "
        ")";
  }

  static String ventilacionesString(last, List? foundedItems) {
    Terminal.printAlert(message: "${last.runtimeType}");
    Ventilaciones.fromJson(last);
    return "${Valores.fechaVentilaciones!} : : ${Ventometrias.ventiladorCorto}";
  }
}

class HospitalaryMethods {
  static void orderByCamas(List? foundedItems) {
    foundedItems!.sort((alfa, betta) {
      return Items.orderOfCamas
              .indexOf(alfa.hospitalizedData['Id_Cama'].toString()) -
          Items.orderOfCamas
              .indexOf(betta.hospitalizedData['Id_Cama'].toString());
    });
  }

  static List? descompose(value) {
    List auxiliar = [];
    for (int i = 0; i < value.length; i++) {
      Terminal.printWarning(message: " . . . Value ${value[i].keys}");
      //
      Internado atreidys =
          Internado(value[i]['generales']['ID_Pace'], value[i]['generales']);
      atreidys.hospitalizedData =
          value[i]['hospitalizedData']['Error'] == 'Hubo un error'
              ? Hospitalizados.dummy(value[i]['generales']['ID_Pace'])
              : value[i]['hospitalizedData'];
      atreidys.padecimientoActual = value[i]['padecimientoActual'];
      //
      atreidys.vitales = value[i]['vitales'];
      atreidys.patologicos = value[i]['patologicos'];
      atreidys.diagnosticos = value[i]['diagnosticos'];
      atreidys.paraclinicos = value[i]['paraclinicos'];
      //
      atreidys.pendientes = value[i]['pendientes'];
      atreidys.licencias = value[i]['licencias'];
      //
      atreidys.ventilaciones = value[i]['ventilaciones'];
      // Otros valores . . .
      atreidys.imagenologicos = value[i]['imagenologicos'];
      atreidys.electrocardiogramas = value[i]['electrocardiogramas'];
      //
      //
      auxiliar.add(atreidys);
    }
    return auxiliar;
  }
}
