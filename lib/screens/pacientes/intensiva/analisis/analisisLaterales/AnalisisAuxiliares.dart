import 'package:assistant/operativity/pacientes/valores/Valorados/hidrometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/metabolometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/renometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/ventometr%C3%ADas.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';

class AnalisisAuxiliares {
  static Widget parametrosNutricionales(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ValuePanel(
                  firstText: 'Gasto Energético Basal',
                  secondText:
                      Metabolometrias.gastoEnergeticoBasal.toStringAsFixed(2),
                  thirdText: 'kCal/Día',
                ),
              ),
              Expanded(
                child: ValuePanel(
                  firstText: 'Metabolismo Basal',
                  secondText:
                      Metabolometrias.metabolismoBasal.toStringAsFixed(2),
                  thirdText: 'kCal/Día',
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ValuePanel(
                  firstText: 'E.T.A.',
                  secondText:
                  Metabolometrias.efectoTermicoAlimentos.toStringAsFixed(2),
                  thirdText: 'kCal/Día',
                ),
              ),
              Expanded(
                child: ValuePanel(
                  firstText: 'Gasto Energético Total',
                  secondText:
                  Metabolometrias.gastoEnergeticoTotal.toStringAsFixed(2),
                  thirdText: 'kCal/Día',
                ),
              ),
              // CrossLine(),
            ],
          ),
          CrossLine(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ValuePanel(
                  firstText: 'GEB (20..D1-3).',
                  secondText:
                  Metabolometrias.gastoEnergeticoBasal_A.toStringAsFixed(2),
                  thirdText: 'kCal/Día',
                ),
              ),
              Expanded(
                child: ValuePanel(
                  firstText: 'GEB (25..D4).',
                  secondText:
                  Metabolometrias.gastoEnergeticoBasal_B.toStringAsFixed(2),
                  thirdText: 'kCal/Día',
                ),
              ),
              Expanded(
                child: ValuePanel(
                  firstText: 'Req. Prot.',
                  secondText:
                  Metabolometrias.requerimientoProteico.toStringAsFixed(2),
                  thirdText: 'gr/Día',
                ),
              ),
              // CrossLine(),
            ],
          ),
          CrossLine(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ValuePanel(
                  firstText: 'Prot. Tot',
                  secondText: Valores.proteinasTotales.toString(),
                  thirdText: 'g/dL',
                ),
              ),
              Expanded(
                child: ValuePanel(
                  firstText: 'Albúmina',
                  secondText: Valores.proteinasTotales.toString(),
                  thirdText: 'g/dL',
                ),
              ),
              // CrossLine(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ValuePanel(
                  firstText: 'Lynf Total',
                  secondText: Valores.linfocitosTotales.toString(),
                  thirdText: 'K/uL',
                ),
              ),
              Expanded(
                child: ValuePanel(
                  firstText: 'Nitrogeno Urinario',
                  secondText: Valores.nitrogenoUrinario.toString(),
                  thirdText: 'mg/dL',
                ),
              ),
              // CrossLine(),
            ],
          ),
        ],
      ),
    );
  }

  static Widget parametrosNefrologicos(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        children: [
          ValuePanel(
            firstText: 'In. Falla Renal',
            secondText:
            Renometrias.indiceFallaRenal.toString(),
            thirdText: '',
          ),
          ValuePanel(
            firstText: 'CKD-EPI',
            secondText:
            Renometrias.tasaRenalCKDEPI.toString(),
            thirdText: 'mL/min/1.72 m2',
          ),
          ValuePanel(
            firstText: 'MDRD',
            secondText:
            Renometrias.tasaRenalMDRD.toString(),
            thirdText: 'mL/min/1.72 m2',
          ),
          ValuePanel(
            firstText: 'Urea/Cr',
            secondText:
            Renometrias.ureaCreatinina.toString(),
            thirdText: 'mg/dL',
          ),
          CrossLine(),
          ValuePanel(
            firstText: '',
            secondText:
            Renometrias.uremia.toString(),
            thirdText: '',
          ),
          ValuePanel(
            firstText: 'OsmEf',
            secondText:
            Hidrometrias.osmolaridadSerica.toString(),
            thirdText: 'mOsm/L',
          ),


        ],
      ),
    );
  }

  static Widget parametrosExtubacion(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        children: [
          ValuePanel(
            firstText: 'V.T. (mL)',
            secondText:
            Valores.volumenTidal.toString(),
            thirdText: 'mL',
          ),
          ValuePanel(
            firstText: 'VM (mL)',
            secondText:
            Ventometrias.volumenMinuto.toString(),
            thirdText: 'mL',
          ),
          ValuePanel(
            firstText: 'FR (Resp/min)',
            secondText:
            Valores.frecuenciaRespiratoria.toString(),
            thirdText: 'Resp/min',
          ),
          ValuePanel(
            firstText: 'FC (Lat/min)',
            secondText:
            Valores.frecuenciaCardiaca.toString(),
            thirdText: 'Lat/min',
          ),
          CrossLine(),
          ValuePanel(
            firstText: 'fr/Vt',
            secondText:
            Ventometrias.indiceTobinYang.toString(),
            thirdText: 'resp/L/seg',
          ),
          ValuePanel(
            firstText: 'P.01',
            secondText:
            "",
            thirdText: '',
          ),
          ValuePanel(
            firstText: 'Cap Vit. Funcional',
            secondText:
            "",
            thirdText: '',
          ),

        ],
      ),
    );
  }
}
