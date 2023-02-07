import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/detalles/dettallesVitales.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/GridLayout.dart';
import 'package:assistant/widgets/RoundedPanel.dart';
import 'package:assistant/widgets/ShowText.dart';
import 'package:flutter/material.dart';

class Analisis extends StatefulWidget {
  int? actualItem = 0;

  Analisis({super.key});

  @override
  State<Analisis> createState() => _AnalisisState();
}

class _AnalisisState extends State<Analisis> {
  @override
  void initState() {
    super.initState();

    // Pacientes.Valores.addAll(Pacientes.Vital);
    // Pacientes.Valores.addAll(Pacientes.Auxiliar);
    // Pacientes.Valores.addAll(Pacientes.Electrocardiogramas);
    //
    // print("Pacientes.Valores ${Pacientes.Valores}");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          vitalesPanel(),
          gadgets.sizedBox,
          Row(
            children: [
              GrandIcon(
                labelButton: 'Antropometrías',
                iconData: Icons.person,
                onPress: () {
                  setState(() {
                    widget.actualItem = 0;
                  });
                },
              ),
              GrandIcon(
                labelButton: 'Hidricos',
                iconData: Icons.water,
                onPress: () {
                  setState(() {
                    widget.actualItem = 1;
                  });
                },
              ),
              GrandIcon(
                labelButton: 'Cardiológicos',
                iconData: Icons.heat_pump_sharp,
                onPress: () {
                  setState(() {
                    widget.actualItem = 2;
                  });
                },
              ),
              GrandIcon(
                labelButton: 'Metabolometrías',
                iconData: Icons.energy_savings_leaf,
                onPress: () {
                  setState(() {
                    widget.actualItem = 3;
                  });
                },
              ),
            ],
          ),
          gadgets.sizedBox,
          getView(widget.actualItem!)
        ],
      ),
    );
  }

  Widget getView(int actualItem) {
    List<Widget> list = [
      antropometricos(),
      hidricos(),
      cardiovasculares(),
      metabolometrias()
    ];

    return list[actualItem];
  }

  // ######### # # # # # ############################# # # # # # # ###########
  Expanded antropometricos() {
    return Expanded(
      flex: 3,
      child: GridLayout(
        // childAspectRatio: isMobile(context) ? 4.5 : 1.9,
        columnCount: isMobile(context) ? 2 : isTablet(context) ? 3: 6,
        children: [
          ShowText(
            title: 'Peso Corporal Ideal',
            data: Valores.pesoCorporalPredicho.roundToDouble(),
            medida: 'Kg',
          ),
          ShowText(
            title: 'Grasa C. Esencial',
            data: Valores.grasaCorporalEsencial.roundToDouble(),
            medida: '%',
            minVal: 12,
            maxVal: 14,
          ),
          ShowText(
            title: 'E. Peso Corporal',
            data: Valores.excesoPesoCorporal.roundToDouble(),
            medida: 'Kg',
            minVal: 34,
            maxVal: 42,
            // typeShow: TypeValueShow.fromInner,
          ),
          ShowText(
            title: 'Porcentaje C. Magro',
            data: Valores.porcentajeCorporalMagro.roundToDouble(),
            medida: '%',
          ),
          ShowText(
            title: 'Peso C. Ajustado',
            data: Valores.pesoCorporalAjustado.roundToDouble(),
            medida: 'Kg',
          ),
          ShowText(
            title: 'Superficie Corporal',
            data: Valores.SC.roundToDouble(),
            medida: 'm2',
          ),
          ShowText(
            title: 'Gasto Energético Total',
            data: Valores.gastoEnergeticoTotal.roundToDouble(),
            medida: 'kCal/Día',
          ),
        ],
      ),
    );
  }

  Expanded hidricos() {
    return Expanded(
      child: GridLayout(
        columnCount: 6,
        children: [
          ShowText(
            title: 'Peso Corporal Ideal',
            data: Valores.pesoCorporalPredicho.roundToDouble(),
            medida: 'Kg',
          ),
          ShowText(
            title: 'Hemoglobina',
            data: Valores.hemoglobina,
            medida: 'g/dL',
            minVal: 12,
            maxVal: 14,
          ),
          ShowText(
            title: 'Hematocrito',
            data: Valores.hematocrito,
            medida: '%',
            minVal: 34,
            maxVal: 42,
            typeShow: TypeValueShow.fromInner,
          ),
          ShowText(
            title: 'Agua Corporal Total',
            data: Valores.aguaCorporalTotal.roundToDouble(),
            medida: 'Lts',
          ),
          ShowText(
            title: 'Requerimiento Hídrico',
            data: Valores.requerimientoHidrico,
            medida: 'Lts',
          ),
          ShowText(
            title: 'Presión Arterial Media',
            data: Valores.presionArterialMedia.roundToDouble(),
            medida: 'mmHg',
          ),
          ShowText(
            title: 'Exceso de Peso C.',
            data: Valores.excesoPesoCorporal.roundToDouble(),
            medida: 'Kg',
          ),
          ShowText(
            title: 'Grasa Corporal E.',
            data: Valores.grasaCorporalEsencial.roundToDouble(),
            medida: '%',
          ),
          ShowText(
            title: 'Edad metabólica',
            data: Valores.edadMetabolica.roundToDouble(),
            medida: 'Años',
          ),
          ShowText(
            title: 'Gasto Energético Total',
            data: Valores.gastoEnergeticoTotal.roundToDouble(),
            medida: 'kCal/Día',
          ),
        ],
      ),
    );
  }

  Expanded cardiovasculares() {
    return Expanded(
      child: GridLayout(
        columnCount: 6,
        children: [
          ShowText(
            title: 'Peso Corporal Ideal',
            data: Valores.pesoCorporalPredicho.roundToDouble(),
            medida: 'Kg',
          ),
          ShowText(
            title: 'Hemoglobina',
            data: Valores.hemoglobina,
            medida: 'g/dL',
            minVal: 12,
            maxVal: 14,
          ),
          ShowText(
            title: 'Hematocrito',
            data: Valores.hematocrito,
            medida: '%',
            minVal: 34,
            maxVal: 42,
            typeShow: TypeValueShow.fromInner,
          ),
          ShowText(
            title: 'Agua Corporal Total',
            data: Valores.aguaCorporalTotal.roundToDouble(),
            medida: 'Lts',
          ),
          ShowText(
            title: 'Requerimiento Hídrico',
            data: Valores.requerimientoHidrico,
            medida: 'Lts',
          ),
          ShowText(
            title: 'Presión Arterial Media',
            data: Valores.presionArterialMedia.roundToDouble(),
            medida: 'mmHg',
          ),
          ShowText(
            title: 'Exceso de Peso C.',
            data: Valores.excesoPesoCorporal.roundToDouble(),
            medida: 'Kg',
          ),
          ShowText(
            title: 'Grasa Corporal E.',
            data: Valores.grasaCorporalEsencial.roundToDouble(),
            medida: '%',
          ),
          ShowText(
            title: 'Edad metabólica',
            data: Valores.edadMetabolica.roundToDouble(),
            medida: 'Años',
          ),
          ShowText(
            title: 'Gasto Energético Total',
            data: Valores.gastoEnergeticoTotal.roundToDouble(),
            medida: 'kCal/Día',
          ),
        ],
      ),
    );
  }

  Expanded metabolometrias() {
    return Expanded(
      child: GridLayout(
        columnCount: 6,
        children: [
          ShowText(
            title: 'Gasto Energético Total',
            data: Valores.gastoEnergeticoTotal.roundToDouble(),
            medida: 'Kcal/Dia',
          ),
          ShowText(
            title: 'Gasto Energético Basal',
            data: Valores.gastoEnergeticoBasal.roundToDouble(),
            medida: 'Kcal',
          ),
          ShowText(
            title: 'E. Térmico Alimentos',
            data: Valores.efectoTermicoAlimentos.roundToDouble(),
            medida: 'Kcal',
          ),
          ShowText(
            title: 'F. Actividad',
            data: Valores.factorActividad,
            medida: '',
          ),
          ShowText(
            title: 'F. Estres',
            data: Valores.factorEstres,
            medida: '',
          ),
        ],
      ),
    );
  }

  RoundedPanel vitalesPanel() {
    return RoundedPanel(
      child: const DetallesVitales(),
    );
  }
}
