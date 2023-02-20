import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/Switched.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';

class SituacionesHospitalizacion extends StatefulWidget {
  const SituacionesHospitalizacion({Key? key}) : super(key: key);

  @override
  State<SituacionesHospitalizacion> createState() =>
      _SituacionesHospitalizacionState();
}

class _SituacionesHospitalizacionState
    extends State<SituacionesHospitalizacion> {
  var dispositivoOxigenoValue = Items.dispositivosOxigeno[0];

  // bool? isCateterPeriferico = false,
  //     isCateterLargoPeriferico = false,
  //     isCateterCentral = false,
  // isSondaFoley = false,
  // isSondaNasogastrica = false,
  // isSondaOrogastrica = false,
  // isDrenajePenrose = false,
  // isPleuroVac = false,
  // isColostomia = false,
  // isGastrostomia = false,
  // isDialisisPeritoneal = false;

  @override
  void initState() {
    dispositivoOxigenoValue = Valores.dispositivoOxigeno!;
    // *********** ********* *********
    Actividades.consultarId(Databases.siteground_database_reghosp,
            Situaciones.situacion['consultQuery'], Pacientes.ID_Hospitalizacion)
        .then((response) {
      print("RESPUESTA $response");
      setState(() {
        dispositivoOxigenoValue = response['Disp_Oxigen'];
        // *********** ********* *********
        Valores.isCateterPeriferico =
            Dicotomicos.fromInt(response['CVP'], toBoolean: true) as bool?;
        Valores.isCateterLargoPeriferico =
            Dicotomicos.fromInt(response['CVLP'], toBoolean: true) as bool?;
        Valores.isCateterVenosoCentral =
            Dicotomicos.fromInt(response['CVC'], toBoolean: true) as bool?;
        Valores.isSondaFoley =
            Dicotomicos.fromInt(response['S_Foley'], toBoolean: true) as bool?;
        Valores.isSondaNasogastrica =
            Dicotomicos.fromInt(response['SNG'], toBoolean: true) as bool?;
        Valores.isSondaOrogastrica =
            Dicotomicos.fromInt(response['SOG'], toBoolean: true) as bool?;
        Valores.isDrenajePenrose =
            Dicotomicos.fromInt(response['Drenaje'], toBoolean: true) as bool?;
        Valores.isPleuroVac =
            Dicotomicos.fromInt(response['Pleuro_Vac'], toBoolean: true)
                as bool?;
        Valores.isColostomia =
            Dicotomicos.fromInt(response['Colostomia'], toBoolean: true)
                as bool?;
        Valores.isGastrostomia =
            Dicotomicos.fromInt(response['Gastrostomia'], toBoolean: true)
                as bool?;
        Valores.isDialisisPeritoneal = Dicotomicos.fromInt(
            response['Dialisis_Peritoneal'],
            toBoolean: true) as bool?;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isMobile(context) ? mobileView() : otherView();
  }

  otherView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      controller: ScrollController(),
      child: Column(
        children: [
          TittlePanel(textPanel: 'Situación General en la Hospitalización'),
          Spinner(
              tittle: 'Dispositivo de Oxígeno',
              width: isDesktop(context) || isTabletAndDesktop(context)? 400 : isTablet(context) ? 200 : 100,
              onChangeValue: (value) {
                setState(() {
                  dispositivoOxigenoValue = value;
                  Valores.dispositivoOxigeno = value;
                });
              },
              items: Items.dispositivosOxigeno,
              initialValue: dispositivoOxigenoValue),
          const CrossLine(),
          Row(
            children: [
              Switched(
                  tittle: 'Cáteter Venoso Periférico',
                  onChangeValue: (value) {
                    setState(() {
                      Valores.isCateterPeriferico = value;
                    });
                  },
                  isSwitched: Valores.isCateterPeriferico),
              Switched(
                tittle: 'Cáteter Largo Periférico',
                onChangeValue: (value) {
                  setState(() {
                    Valores.isCateterLargoPeriferico = value;
                    Valores.isCateterLargoPeriferico = value;
                  });
                },
                isSwitched: Valores.isCateterLargoPeriferico,
              ),
            ],
          ),
          Switched(
              tittle: 'Cáteter Venoso Central',
              onChangeValue: (value) {
                setState(() {
                  Valores.isCateterVenosoCentral = value;
                  Valores.isCateterVenosoCentral = value;
                });
              },
              isSwitched: Valores.isCateterVenosoCentral),
          const CrossLine(),
          Row(
            children: [
              Switched(
                  tittle: 'Sonda Orogástrica',
                  onChangeValue: (value) {
                    setState(() {
                      Valores.isSondaOrogastrica = value;
                      Valores.isSondaOrogastrica = value;
                    });
                  },
                  isSwitched: Valores.isSondaOrogastrica),
              Switched(
                tittle: 'Sonda Nasogástrica',
                onChangeValue: (value) {
                  setState(() {
                    Valores.isSondaNasogastrica = value;
                    Valores.isSondaNasogastrica = value;
                  });
                },
                isSwitched: Valores.isSondaNasogastrica,
              ),
            ],
          ),
          Switched(
              tittle: 'Sonda Foley',
              onChangeValue: (value) {
                setState(() {
                  Valores.isSondaFoley = value;
                  Valores.isSondaFoley = value;
                });
              },
              isSwitched: Valores.isSondaFoley),
          const CrossLine(),
          Row(
            children: [
              Switched(
                  tittle: 'Drenaje Penrose',
                  onChangeValue: (value) {
                    setState(() {
                      Valores.isDrenajePenrose = value;
                      Valores.isDrenajePenros = value;
                    });
                  },
                  isSwitched: Valores.isDrenajePenrose),
              Switched(
                tittle: 'Sello Pleural',
                onChangeValue: (value) {
                  setState(() {
                    Valores.isPleuroVac = value;
                    Valores.isPleuroVac = value;
                  });
                },
                isSwitched: Valores.isPleuroVac,
              ),
            ],
          ),
          Row(
            children: [
              Switched(
                  tittle: 'Colostomía',
                  onChangeValue: (value) {
                    setState(() {
                      Valores.isColostomia = value;
                      Valores.isColostomia = value;
                    });
                  },
                  isSwitched: Valores.isColostomia),
              Switched(
                tittle: 'Gaastrostomia',
                onChangeValue: (value) {
                  setState(() {
                    Valores.isGastrostomia = value;
                  });
                },
                isSwitched: Valores.isGastrostomia,
              ),
            ],
          ),
          Switched(
              tittle: 'Diálisis Peritoneal',
              onChangeValue: (value) {
                setState(() {
                  Valores.isDialisisPeritoneal = value;
                });
              },
              isSwitched: Valores.isDialisisPeritoneal),
        ],
      ),
    );
  }

  mobileView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      controller: ScrollController(),
      child: Column(
        children: [
          TittlePanel(textPanel: 'Situación General en la Hospitalización'),
          Spinner(
              tittle: 'Dispositivo de Oxígeno',
              width: isTablet(context) ? 200 : 100,
              onChangeValue: (value) {
                setState(() {
                  dispositivoOxigenoValue = value;
                  Valores.dispositivoOxigeno = value;
                });
              },
              items: Items.dispositivosOxigeno,
              initialValue: dispositivoOxigenoValue),
          const CrossLine(),
          Switched(
              tittle: 'Cáteter Venoso Periférico',
              onChangeValue: (value) {
                setState(() {
                  Valores.isCateterPeriferico = value;
                });
              },
              isSwitched: Valores.isCateterPeriferico),
          Switched(
            tittle: 'Cáteter Largo Periférico',
            onChangeValue: (value) {
              setState(() {
                Valores.isCateterLargoPeriferico = value;
                Valores.isCateterLargoPeriferico = value;
              });
            },
            isSwitched: Valores.isCateterLargoPeriferico,
          ),
          Switched(
              tittle: 'Cáteter Venoso Central',
              onChangeValue: (value) {
                setState(() {
                  Valores.isCateterVenosoCentral = value;
                  Valores.isCateterVenosoCentral = value;
                });
              },
              isSwitched: Valores.isCateterVenosoCentral),
          const CrossLine(),
          Switched(
              tittle: 'Sonda Orogástrica',
              onChangeValue: (value) {
                setState(() {
                  Valores.isSondaOrogastrica = value;
                  Valores.isSondaOrogastrica = value;
                });
              },
              isSwitched: Valores.isSondaOrogastrica),
          Switched(
            tittle: 'Sonda Nasogástrica',
            onChangeValue: (value) {
              setState(() {
                Valores.isSondaNasogastrica = value;
                Valores.isSondaNasogastrica = value;
              });
            },
            isSwitched: Valores.isSondaNasogastrica,
          ),
          Switched(
              tittle: 'Sonda Foley',
              onChangeValue: (value) {
                setState(() {
                  Valores.isSondaFoley = value;
                  Valores.isSondaFoley = value;
                });
              },
              isSwitched: Valores.isSondaFoley),
          const CrossLine(),
          Switched(
              tittle: 'Drenaje Penrose',
              onChangeValue: (value) {
                setState(() {
                  Valores.isDrenajePenrose = value;
                  Valores.isDrenajePenros = value;
                });
              },
              isSwitched: Valores.isDrenajePenrose),
          Switched(
            tittle: 'Sello Pleural',
            onChangeValue: (value) {
              setState(() {
                Valores.isPleuroVac = value;
                Valores.isPleuroVac = value;
              });
            },
            isSwitched: Valores.isPleuroVac,
          ),
          Switched(
              tittle: 'Colostomía',
              onChangeValue: (value) {
                setState(() {
                  Valores.isColostomia = value;
                  Valores.isColostomia = value;
                });
              },
              isSwitched: Valores.isColostomia),
          Switched(
            tittle: 'Gaastrostomia',
            onChangeValue: (value) {
              setState(() {
                Valores.isGastrostomia = value;
              });
            },
            isSwitched: Valores.isGastrostomia,
          ),
          Switched(
              tittle: 'Diálisis Peritoneal',
              onChangeValue: (value) {
                setState(() {
                  Valores.isDialisisPeritoneal = value;
                });
              },
              isSwitched: Valores.isDialisisPeritoneal),
        ],
      ),
    );
  }
}
