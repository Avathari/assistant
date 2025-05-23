import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';

class BalanceHidrico extends StatefulWidget {
  const BalanceHidrico({super.key});

  @override
  State<BalanceHidrico> createState() => _BalanceHidricoState();
}

class _BalanceHidricoState extends State<BalanceHidrico> {

  double ingresos = 0, egresos = 0,balanceTotal = 0, uresis = 0;
  double diuresis = 0;

  @override
  void initState() {
      Archivos.readJsonToMap(filePath: Vitales.fileAssocieted)
          .then((onValue) => Vitales.fromJson(onValue!.last)).whenComplete(() => setState(() => {}));
      //
    setState(() {
      //
      ingresos = Valores.ingresosBalances;
      egresos = Valores.egresosBalances;
      balanceTotal = Valores.balanceTotal;
      uresis = Valores.uresisBalances!;
      diuresis = Valores.diuresis;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: ContainerDecoration.roundedDecoration(),
      child:
      Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: ValuePanel(
                    firstText: "",
                    secondText: Valores.fechaRealizacionBalances.toString(),
                    thirdText: "",
                  ),
                ),
                Expanded(
                  child: GrandIcon(labelButton: "Actualizar",onPress: () {
                    setState(() {

                    });
                  },),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5,),
          Expanded(
            flex: 8,
            child: GridView(
              controller: ScrollController(),
              gridDelegate: GridViewTools.gridDelegate(
                  crossAxisCount: isMobile(context)
                      ? 1
                      : isTablet(context)
                      ? 2
                      : 2,
                  mainAxisExtent: 65
              ),
              children: [
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
                  secondText: Valores.uresisBalances!.toStringAsFixed(0),
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
          Expanded(
            flex: 2,
            child: GrandButton(
              weigth: 2000,
              labelButton: "Copiar en Portapapeles",
              onPress: () {
                Datos.portapapeles(
                    context: context, text: Formatos.balances);
              },
            ),
          ),
        ],
      ),
    );
  }
}
