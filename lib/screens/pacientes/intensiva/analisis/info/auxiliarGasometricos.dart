import 'package:assistant/operativity/pacientes/valores/Valorados/gasometricos.dart'
    as Gas;
import 'package:assistant/operativity/pacientes/valores/Valorados/hidrometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';

class AuxiliarGasometricos {

  static Widget conclusionesGasometricos() {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        children: [
          TittlePanel(
              textPanel:
              "Trastorno Primario \n${Gas.Gasometricos.trastornoPrimario} (pH ${Valores.pHArteriales})"),
          TittlePanel(
              textPanel:
              "Trastorno Secundario \n${Gas.Gasometricos.trastornoSecundario} (PCO2 ${Valores.pcoArteriales!.toStringAsFixed(0)})"),
          CrossLine(
            thickness: 4,
          ),
          TittlePanel(
              textPanel:
              "Alteración del Oxígeno \n${Gas.Gasometricos.trastornoTerciario} (pO2 ${Valores.poArteriales!.toStringAsFixed(0)})"),
          TittlePanel(
              textPanel:
              "Alteración del CO2 \n${Gas.Gasometricos.alteracionRespiratoria} (HCO3- ${Valores.pcoArteriales})"),
          TittlePanel(
              textPanel:
              "Alteración por Bases \n${Gas.Gasometricos.trastornoBases} (EB ${Gas.Gasometricos.EB.toStringAsFixed(2)})"),
          TittlePanel(
              textPanel:
              "Alteración del Anion Gap \n${Gas.Gasometricos.trastornoGap} (GAP ${Gas.Gasometricos.GAP.toStringAsFixed(0)})"),
        ],
      ),
    );
  }

  static Widget analisisOxigenacion() {
return SingleChildScrollView(
  controller: ScrollController(),
  child: Column(
      children: [
        ValuePanel(
          firstText: "PAFI",
          secondText: Gas.Gasometricos.PAFI.toStringAsFixed(0),
          thirdText: "",
        ),
        ValuePanel(
          firstText: "SAFI",
          secondText: Gas.Gasometricos.SAFI.toStringAsFixed(2),
          thirdText: "",
        ),
        Row(
          children: [
            Expanded(
              child: ValuePanel(
                firstText: "PAO2",
                secondText: Gas.Gasometricos.PAO.toStringAsFixed(2),
                thirdText: "mmHg",
              ),
            ),
            Expanded(
              child: ValuePanel(
                firstText: "PiO2",
                secondText: Gas.Gasometricos.PIO.toStringAsFixed(2),
                thirdText: "mmHg",
              ),
            ),
          ],
        ),
        ValuePanel(
          firstText: "Aa-O2",
          secondText: Gas.Gasometricos.GAA.toStringAsFixed(2),
          thirdText: "mmHg",
        ),
        CrossLine(),
        Row(
          children: [
            Expanded(
              child: ValuePanel(
                firstText: "CaO2",
                secondText: Gas.Gasometricos.CAO.toStringAsFixed(2),
                thirdText: "mmHg",
              ),
            ),
            Expanded(
              child: ValuePanel(
                firstText: "CcO2",
                secondText: Gas.Gasometricos.CCO.toStringAsFixed(2),
                thirdText: "mmHg",
              ),
            ),
            Expanded(
              child: ValuePanel(
                firstText: "CvO2",
                secondText: Gas.Gasometricos.CVO.toStringAsFixed(2),
                thirdText: "mmHg",
              ),
            ),
          ],
        ),
        CrossLine(),
        ValuePanel(
          firstText: "DAa-O2",
          secondText: Gas.Gasometricos.DAA.toStringAsFixed(2),
          thirdText: "mmHg",
        ),
        ValuePanel(
          firstText: "PaO2/PAO2",
          secondText: Gas.Gasometricos.PaO2PAO2.toStringAsFixed(2),
          thirdText: "mmHg",
        ),
      ]),
);
  }

  static Widget analisisAcidoBase() {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        children: [
          ValuePanel(
            firstText: "aGap",
            secondText: Gas.Gasometricos.GAP.toStringAsFixed(0),
            thirdText: "",
          ),
          Row(
            children: [
              Expanded(
                child: ValuePanel(
                  firstText: "ΔGap",
                  secondText: Gas.Gasometricos.d_GAP.toStringAsFixed(2),
                  thirdText: "",
                ),
              ),
              Expanded(
                child: ValuePanel(
                  firstText: "ΔHCO3-",
                  secondText: Gas.Gasometricos.d_HCO.toStringAsFixed(2),
                  thirdText: "",
                ),
              ),
            ],
          ),
          ValuePanel(
            firstText: "Δ-Δ Gap/HCO3-",
            secondText: Gas.Gasometricos.D_d_GAP.toStringAsFixed(2),
            thirdText: "",
          ),
          CrossLine(),
          Row(
            children: [
              Expanded(
                child: ValuePanel(
                  firstText: "OSMc",
                  secondText:
                  Hidrometrias.osmolaridadSerica.toStringAsFixed(0),
                  thirdText: "mOsm//L",
                ),
              ),
              Expanded(
                child: ValuePanel(
                  firstText: "ΔOsm",
                  secondText: Gas.Gasometricos.GAPO.toStringAsFixed(0),
                  thirdText: "mOsm/L",
                ),
              ),
            ],
          ),

          CrossLine(),
          Row(
            children: [
              Expanded(
                child: ValuePanel(
                  firstText: "DIFa",
                  secondText: Gas.Gasometricos.diferenciaIonesFuertesAparente.toStringAsFixed(0),
                  thirdText: "",
                ),
              ),
              Expanded(
                child: ValuePanel(
                  firstText: "DIFe",
                  secondText: Gas.Gasometricos.diferenciaIonesFuertesEfectiva.toStringAsFixed(0),
                  thirdText: "",
                ),
              ),
              Expanded(
                child: ValuePanel(
                  firstText: "Atot",
                  secondText: Gas.Gasometricos.aTOT.toStringAsFixed(2),
                  thirdText: "",
                ),
              ),
            ],
          ),
          ValuePanel(
            firstText: "GIF Iones",
            secondText: Gas.Gasometricos.GIF.toStringAsFixed(2),
            thirdText: "",
          ),
          CrossLine(),
          ValuePanel(
            firstText: "Efecto Buffer",
            secondText: Gas.Gasometricos.EBvGilFix.toStringAsFixed(2),
            thirdText: "",
          ),
          ValuePanel(
            firstText: "ΔEb",
            secondText: Gas.Gasometricos.DA.toStringAsFixed(2),
            thirdText: "",
          ),
          ValuePanel(
            firstText: "Verdaero Déf Base",
            secondText: Gas.Gasometricos.VDb.toStringAsFixed(2),
            thirdText: "",
          ),
          CrossLine(),
          Row(
            children: [
              Expanded(
                child: ValuePanel(
                  firstText: "[H+]",
                  secondText: Gas.Gasometricos.H.toStringAsFixed(2),
                  thirdText: "",
                ),
              ),
              Expanded(
                child: ValuePanel(
                  firstText: "pH[]",
                  secondText: Gas.Gasometricos.PH.toStringAsFixed(2),
                  thirdText: "",
                ),
              ),
            ],
          ),
          CrossLine(),
          ValuePanel(
            firstText: "Na2+/Cl-",
            secondText: Gas.Gasometricos.NaClindex.toStringAsFixed(2),
            thirdText: "",
          ),
        ],
      ),
    );

  }

  static Widget analisisBicarbonato() {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ValuePanel(
                  firstText: "1ra HCO3-",
                  secondText: Gas.Gasometricos.HCOR_a.toStringAsFixed(2),
                  thirdText: "",
                ),
              ),
              Expanded(
                child: ValuePanel(
                  firstText: "2da HCO3-",
                  secondText: Gas.Gasometricos.HCOR_b.toStringAsFixed(2),
                  thirdText: "",
                ),
              ),
            ],
          ),
          ValuePanel(
            firstText: "3ra HCO3-",
            secondText: Gas.Gasometricos.HCOR_c.toStringAsFixed(2),
            thirdText: "mEq/L",
          ),
          CrossLine(),
          ValuePanel(
            firstText: "Def. HCO3-",
            secondText:
            Gas.Gasometricos.deficitBicarbonato.toStringAsFixed(2),
            thirdText: "mEq/L",
          ),
          CrossLine(),
          Row(
            children: [
              Expanded(
                child: ValuePanel(
                  firstText: "Astrup",
                  secondText: Gas.Gasometricos.HCOAM.toStringAsFixed(2),
                  thirdText: "mEq/L",
                ),
              ),
              Expanded(
                child: ValuePanel(
                  firstText: "Rep. HCO3-",
                  secondText: Gas.Gasometricos.VHCOAM.toStringAsFixed(2),
                  thirdText: "mEq/L",
                ),
              ),
            ],
          ),
          CrossLine(),
          ValuePanel(
            firstText: "No. Amp. HCO3-",
            secondText: Gas.Gasometricos.NOAMP.toStringAsFixed(0),
            thirdText: "amp al 7.5%",
          ),
        ],
      ),
    );

  }
}