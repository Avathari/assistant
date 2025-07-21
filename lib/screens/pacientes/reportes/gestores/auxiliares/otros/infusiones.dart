import 'dart:convert';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InfusionesCriticas extends StatefulWidget {
  const InfusionesCriticas({super.key});

  @override
  State<InfusionesCriticas> createState() => _InfusionesCriticasState();
}

class _InfusionesCriticasState extends State<InfusionesCriticas> {
  double pesoCorporal = Valores.pesoCorporalTotal ?? 70.0; // kg
  var textPCTController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    textPCTController.text = pesoCorporal.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: EditTextArea(
                  numOfLines: 1,
                  labelEditText: "Peso Corporal Total (kG)",
                  textController: textPCTController,
                  keyBoardType: TextInputType.number,
                  inputFormat: MaskTextInputFormatter(),
                  onChange: (value) {
                    setState(() {
                      pesoCorporal = double.tryParse(value) ?? 70.0;
                      Valores.pesoCorporalTotal = double.tryParse(value) ?? 70.0;
                      //
                      for (int i = 0;
                      i < Parenterales.infusiones.length;
                      i++) {
                        Parenterales.calcularMCGKGMin(i);
                      }
                    });
                  },
                ),
              ),
              //
              const SizedBox(height: 10),
              !isMobile(context) ? Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text("Agregar Fármaco"),
                        onPressed: () {
                          setState(() {
                            Parenterales.agregarInfusion();
                          });
                        },
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text("Generar prosa . . . "),
                        onPressed: () {
                          Datos.portapapeles(
                              context: context,
                              text:
                              "${Parenterales.generarProsaSedantes()} . . . ${Parenterales.generarProsaAnalgesicos()}");
                        },
                      ),
                    ],
                  ),
                ),
              ) : Container(),
              // const SizedBox(height: 10),
              // Expanded(
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: ElevatedButton.icon(
              //       icon: const Icon(Icons.add),
              //       label: const Text("Agregar Fármaco"),
              //       onPressed: agregarInfusion,
              //     ),
              //   ),
              // ),
              // Expanded(
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: ElevatedButton.icon(
              //       icon: const Icon(Icons.add),
              //       label: const Text("Guardar JSON"),
              //       onPressed: () {
              //         // Archivos.createJsonFromMap(exportarInfusionesComoJson());
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        isMobile(context) ? Align(
          alignment: Alignment.centerRight,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text("Agregar Fármaco"),
                  onPressed: () {
                    setState(() {
                      Parenterales.agregarInfusion();
                    });
                  },
                ),
              ),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text("Generar prosa . . . "),
                  onPressed: () {
                    Datos.portapapeles(
                        context: context,
                        text:
                        "${Parenterales.generarProsaSedantes()} . . . ${Parenterales.generarProsaAnalgesicos()}");
                  },
                ),
              ),
            ],
          ),
        ) : Container(),
        const SizedBox(height: 10),
        Container(
          decoration: ContainerDecoration.roundedDecoration(
            colorBackground: Theming.bdColor,
          ),
          child: GridView.builder(
            shrinkWrap: true,
            reverse: true,
            // physics: const NeverScrollableScrollPhysics(),
            itemCount: Parenterales.infusiones.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile(context)
                  ? 1
                  : isTablet(context)
                  ? 2
                  : 3, // Número de columnas
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: isDesktop(context)
                  ? 1.35
                  : 0.85, // Ajusta la altura de las tarjetas
            ),
            itemBuilder: (context, index) {
              return Card(
                color: Theming.bdColor,
                shadowColor: Colors.black,
                elevation: 10.0,
                margin: const EdgeInsets.all(8.0),
                child: FocusTraversalGroup(
                  policy: WidgetOrderTraversalPolicy(), // orden natural
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                      labelText: "Fármaco",
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  value: Parenterales.infusiones[index]
                                      .farmaco.isNotEmpty
                                      ? Parenterales
                                      .infusiones[index].farmaco
                                      : null,
                                  items: Parenterales
                                      .categoriasFarmacos.entries
                                      .expand((entry) {
                                    final categoria = entry.key;
                                    final farmacos = entry.value;

                                    return [
                                      DropdownMenuItem<String>(
                                        enabled: false,
                                        child: Text(
                                          categoria,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      ...farmacos.map(
                                            (f) => DropdownMenuItem<String>(
                                          value: f,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 12.0),
                                            child: Text(f,
                                                style: const TextStyle(
                                                  fontWeight:
                                                  FontWeight.normal,
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ];
                                  }).toList(),
                                  onChanged: (value) => setState(() =>
                                  Parenterales.infusiones[index]
                                      .farmaco = value ?? ''),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.white),
                                onPressed: () => setState(() {
                                  Parenterales.eliminarInfusion(index);
                                }),
                              ),
                            ],
                          ),
                        ),
                         SizedBox(height: isDesktop(context) ? 16 : 10),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  initialValue: Parenterales
                                      .infusiones[index]
                                      .concentracionMg,
                                  decoration: const InputDecoration(
                                      labelText: "Concentración (mg)",
                                      labelStyle: TextStyle(
                                          color: Colors.white)),
                                  onChanged: (value) {
                                    setState(() {
                                      Parenterales.infusiones[index]
                                          .concentracionMg = value;
                                      Parenterales.calcularMCGKGMin(
                                          index);
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  initialValue: Parenterales
                                      .infusiones[index].volumenMl,
                                  decoration: const InputDecoration(
                                      labelText: "Volumen Total (ml)",
                                      labelStyle: TextStyle(
                                          color: Colors.white)),
                                  onChanged: (value) {
                                    setState(() {
                                      Parenterales.infusiones[index]
                                          .volumenMl = value;
                                      Parenterales.calcularMCGKGMin(
                                          index);
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  initialValue: Parenterales
                                      .infusiones[index].velocidad,
                                  decoration: const InputDecoration(
                                      labelText: "Velocidad (ml/h)",
                                      labelStyle: TextStyle(
                                          color: Colors.white)),
                                  onChanged: (value) {
                                    setState(() {
                                      Parenterales.infusiones[index]
                                          .velocidad = value;
                                      Parenterales.calcularMCGKGMin(
                                          index);
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Concentración estimada: '
                                        '${((double.tryParse(Parenterales.infusiones[index].concentracionMg) ?? 0.0) * 1000 / (double.tryParse(Parenterales.infusiones[index].volumenMl) ?? 1)).toStringAsFixed(2)} mcg/ml',
                                    style: const TextStyle(
                                        color: Colors.teal),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Expanded(
                                  child: Text(
                                    'Resultado final: '
                                        '${Parenterales.infusiones[index].resultadoCalculado} mcg/kg/min',
                                    style: const TextStyle(
                                        color: Colors.blueGrey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );

  }

  String exportarInfusionesComoJson() {
    final List<Map<String, dynamic>> data =
        Parenterales.infusiones.map((i) => i.toJson()).toList();
    return const JsonEncoder.withIndent('  ').convert(data);
  }

  void cargarDesdeJson(String jsonString) {
    final List<dynamic> data = jsonDecode(jsonString);
    final nuevasInfusiones =
        data.map((e) => InfusionCritica.fromJson(e)).toList();

    setState(() {
      Parenterales.infusiones = nuevasInfusiones;
    });
  }

  String obtenerCategoria(String farmaco) {
    for (var entry in Parenterales.categoriasFarmacos.entries) {
      if (entry.value.contains(farmaco)) {
        return entry.key;
      }
    }
    return 'Otros';
  }

  void mostrarResumenProsa() {
    // Clona y ordena la lista
    final listaOrdenada = List<InfusionCritica>.from(Parenterales.infusiones);
    listaOrdenada.sort((a, b) {
      const ordenCategorias = ['Sedantes', 'Vasopresores', 'Inotrópicos'];
      final catA = obtenerCategoria(a.farmaco);
      final catB = obtenerCategoria(b.farmaco);
      final idxA = ordenCategorias.indexOf(catA);
      final idxB = ordenCategorias.indexOf(catB);
      return idxA.compareTo(idxB);
    });

    String resumen = listaOrdenada
        .asMap()
        .entries
        .map((e) =>
            '• Infusión ${e.key + 1}: Se administró ${e.value.farmaco}, '
            'concentración de ${e.value.concentracionMg} mg en ${e.value.volumenMl} ml, '
            'a una velocidad de ${e.value.velocidad} ml/h. '
            'Equivalente a ${e.value.resultadoCalculado.toStringAsFixed(2)} mcg/kg/min.')
        .join('\n\n');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Resumen Ordenado'),
        content: SingleChildScrollView(child: Text(resumen)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  String generarProsa(InfusionCritica i, int index) {
    return '• Infusión ${index + 1}: Se administró ${i.farmaco}, '
        'concentración de ${i.concentracionMg} mg en ${i.volumenMl} ml, '
        'a una velocidad de ${i.velocidad} ml/h. '
        'Esto equivale a una dosis de ${i.resultadoCalculado.toStringAsFixed(2)} mcg/kg/min.';
  }

  String generarResumenProsa() {
    return Parenterales.infusiones
        .asMap()
        .entries
        .map((e) => generarProsa(e.value, e.key))
        .join('\n');
  }

  String generarProsaPorCategoria(String categoria) {
    final farmacosDeCategoria =
        Parenterales.categoriasFarmacos[categoria] ?? [];

    final listaFiltrada = Parenterales.infusiones
        .where((i) => farmacosDeCategoria.contains(i.farmaco))
        .toList();

    if (listaFiltrada.isEmpty)
      return 'No se encontraron infusiones de $categoria.\n';

    return listaFiltrada
        .asMap()
        .entries
        .map((e) => '${e.value.farmaco} '
            '${e.value.resultadoCalculado.toStringAsFixed(2)} mcg/kg/min')
        .join(', ');

    // return '🔹 $categoria:\n${listaFiltrada.asMap().entries.map((e) => '${e.value.farmaco} '
    //     '${e.value.resultadoCalculado.toStringAsFixed(2)} mcg/kg/min.').join('\n\n')}';

    //     .map((e) =>
    // '• Infusión ${e.key + 1}: Se administró ${e.value.farmaco}, '
    //     'concentración de ${e.value.concentracionMg} mg en ${e.value.volumenMl} ml, '
    //     'a una velocidad de ${e.value.velocidad} ml/h. '
    //     'Equivalente a ${e.value.resultadoCalculado.toStringAsFixed(2)} mcg/kg/min.')
    //     .join('\n\n')}\n';
  }

  String generarProsaSedantes() => generarProsaPorCategoria('Sedantes');

  String generarProsaVasopresores() => generarProsaPorCategoria('Vasopresores');

  String generarProsaInotropicos() => generarProsaPorCategoria('Inotrópicos');

  String generarProsaAnalgesicos() => generarProsaPorCategoria('Analgésicos');
}
