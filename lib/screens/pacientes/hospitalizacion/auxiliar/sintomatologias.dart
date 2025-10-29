import 'package:flutter/material.dart';

class Sintomatologias extends StatefulWidget {
  const Sintomatologias({super.key});

  @override
  State<Sintomatologias> createState() => _SintomatologiasState();
}

class _SintomatologiasState extends State<Sintomatologias> {
  String? selectedSymptom;
  final List<Map<String, dynamic>> sintomasDelPaciente = [];

  final List<String> sintomasDisponibles = [
    'Disnea',
    'Dolor',
    'Fiebre',
    'Tos',
    'Ictericia',
    'Palpitaciones',
    'Edema',
    'Pérdida de peso',
    'Fatiga',
    'Alteración del estado de conciencia'
  ];

  void agregarSintoma(Map<String, dynamic> nuevoSintoma) {
    setState(() {
      sintomasDelPaciente.add(nuevoSintoma);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Padecimiento Actual")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedSymptom,
              decoration: const InputDecoration(labelText: "Síntoma guía"),
              items: sintomasDisponibles
                  .map((sintoma) =>
                      DropdownMenuItem(value: sintoma, child: Text(sintoma)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedSymptom = value;
                });
              },
            ),
            const SizedBox(height: 20),
            if (selectedSymptom != null)
              Expanded(
                child: SymptomForm(
                  symptom: selectedSymptom!,
                  onSaved: agregarSintoma,
                ),
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final resumen = generarResumenProsa(sintomasDelPaciente);
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Resumen clínico"),
                    content: Text(resumen),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cerrar"))
                    ],
                  ),
                );
              },
              child: const Text("Generar resumen"),
            )
          ],
        ),
      ),
    );
  }

  String generarResumenProsa(List<Map<String, dynamic>> sintomas) {
    sintomas.sort((a, b) => a["fechaInicio"].compareTo(b["fechaInicio"]));
    List<String> frases = [];

    for (var sintoma in sintomas) {
      final nombre = sintoma["sintoma"];
      final fecha = sintoma["fechaInicio"] as DateTime;
      final caracteristicas =
          sintoma["caracteristicas"] as Map<String, dynamic>;

      String descripcion =
          "$nombre iniciado el ${fecha.day}/${fecha.month}/${fecha.year}, ";
      descripcion +=
          caracteristicas.entries.map((e) => "${e.key}: ${e.value}").join(", ");
      frases.add("$descripcion.");
    }

    return frases.join(" ");
  }
}

class SymptomForm extends StatefulWidget {
  final String symptom;
  final Function(Map<String, dynamic>) onSaved;

  const SymptomForm({super.key, required this.symptom, required this.onSaved});

  @override
  State<SymptomForm> createState() => _SymptomFormState();
}

class _SymptomFormState extends State<SymptomForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> fields = {};
  DateTime fechaInicio = DateTime.now();

  @override
  Widget build(BuildContext context) {
    List<Widget> campos = [];

    switch (widget.symptom.toLowerCase()) {
      case 'disnea':
        campos = [
          TextFormField(
            decoration: const InputDecoration(labelText: "Evolución"),
            onSaved: (val) => fields["evolucion"] = val,
          ),
          TextFormField(
            decoration:
                const InputDecoration(labelText: "Grado funcional (NYHA)"),
            onSaved: (val) => fields["NYHA"] = val,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "Desencadenantes"),
            onSaved: (val) => fields["desencadenantes"] = val,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "Alivio"),
            onSaved: (val) => fields["alivio"] = val,
          ),
          TextFormField(
            decoration:
                const InputDecoration(labelText: "Síntomas acompañantes"),
            onSaved: (val) => fields["acompañantes"] = val,
          ),
        ];
        break;

      case 'fiebre':
        campos = [
          TextFormField(
            decoration: const InputDecoration(labelText: "Patrón"),
            onSaved: (val) => fields["patron"] = val,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "Temperatura máxima"),
            onSaved: (val) => fields["temperaturaMax"] = val,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "Horario"),
            onSaved: (val) => fields["horario"] = val,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "Alivio"),
            onSaved: (val) => fields["alivio"] = val,
          ),
        ];
        break;

      // Agrega más síntomas aquí con sus campos...

      default:
        campos = [
          const Text("Formulario aún no implementado para este síntoma")
        ];
    }

    return Form(
      key: _formKey,
      child: ListView(
        children: [
          const SizedBox(height: 10),
          Text("Inicio del síntoma:"),
          ElevatedButton(
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: fechaInicio,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
              );
              if (picked != null) setState(() => fechaInicio = picked);
            },
            child: Text(
                "Seleccionar: ${fechaInicio.day}/${fechaInicio.month}/${fechaInicio.year}"),
          ),
          const Divider(),
          ...campos,
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                widget.onSaved({
                  "sintoma": widget.symptom,
                  "fechaInicio": fechaInicio,
                  "caracteristicas": fields,
                });
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${widget.symptom} guardado.")));
              }
            },
            child: const Text("Guardar síntoma"),
          )
        ],
      ),
    );
  }
}
