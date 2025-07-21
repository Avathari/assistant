import 'package:flutter/material.dart';
import 'dart:math';

class HemodialysisReportScreen extends StatefulWidget {
  const HemodialysisReportScreen({super.key});

  @override
  State<HemodialysisReportScreen> createState() => _HemodialysisReportScreenState();
}

class _HemodialysisReportScreenState extends State<HemodialysisReportScreen> {
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _tallaController = TextEditingController();
  final TextEditingController _duracionSesionController = TextEditingController();
  final TextEditingController _flujoSangreController = TextEditingController();

  double? imc;
  double? ktvEstimado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Reporte Mensual de Hemodiálisis')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: [
                      _datosGenerales(),
                      _accesoVascular(),
                      _vacunasRecibidas(),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: [
                      _prescripcion(),
                      _adecuacionDialisis(),
                      _observaciones(),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: [
                      _caracteristicasHD(),
                      _evaluacionNutricional(),
                      _laboratorios(),
                      _resumenAntropometrico(),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  _datosGenerales(),
                  _prescripcion(),
                  _accesoVascular(),
                  _caracteristicasHD(),
                  _laboratorios(),
                  _adecuacionDialisis(),
                  _vacunasRecibidas(),
                  _evaluacionNutricional(),
                  _observaciones(),
                  _resumenAntropometrico(),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _datosGenerales() {
    return ExpansionTile(
      title: const Text('I. Datos Generales', style: TextStyle(color: Colors.white)),
      children: [
        _textField('Nombre del paciente'),
        _textField('Edad'),
        _textField('Sexo'),
        _textField('Fecha de ingreso'),
        _textField('No. de afiliación'),
        _textField('Diagnóstico'),
        _textField('Número de sesiones'),
        _textField('Serología (HBV, HCV, VIH)'),
        CheckboxListTile(value: false, onChanged: (_) {}, title: const Text('Candidato a Trasplante')),
      ],
    );
  }

  Widget _prescripcion() {
    return ExpansionTile(
      title: const Text('II. Prescripción', style: TextStyle(color: Colors.white)),
      children: [
        _textField('Tecnología'),
        _textField('Dializador'),
        _textField('Bicarbonato'),
        TextFormField(
          controller: _flujoSangreController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Qb (ml/min)', border: OutlineInputBorder()),
          style: const TextStyle(color: Colors.grey),
          onChanged: (_) => _calcularKtv(),
        ),
        _textField('Qd'),
        _textField('Ultrafiltración'),
        TextFormField(
          controller: _duracionSesionController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Duración sesión (min)', border: OutlineInputBorder()),
          style: const TextStyle(color: Colors.grey),
          onChanged: (_) => _calcularKtv(),
        ),
        _textField('Heparina estándar'),
        _textField('Bolo'),
        _textField('Infusión'),
        _textField('Sodio'),
        _textField('Potasio'),
        _textField('Calcio'),
        _textField('Dextrosa'),
      ],
    );
  }

  Widget _accesoVascular() {
    return ExpansionTile(
      title: const Text('III. Acceso Vascular', style: TextStyle(color: Colors.white)),
      children: [
        _textField('Vía de acceso'),
        _textField('Estado del acceso'),
        Row(
          children: [
            Expanded(child: CheckboxListTile(value: false, onChanged: (_) {}, title: const Text('IMSS'))),
            Expanded(child: CheckboxListTile(value: true, onChanged: (_) {}, title: const Text('CARE'))),
          ],
        ),
      ],
    );
  }

  Widget _caracteristicasHD() {
    return ExpansionTile(
      title: const Text('IV. Características de la HD', style: TextStyle(color: Colors.white)),
      children: [
        TextFormField(
          controller: _pesoController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Peso seco (kg)', border: OutlineInputBorder()),
          style: const TextStyle(color: Colors.grey),
          onChanged: (_) => _calcularIMC(),
        ),
        TextFormField(
          controller: _tallaController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Talla (m)', border: OutlineInputBorder()),
          style: const TextStyle(color: Colors.grey),
          onChanged: (_) => _calcularIMC(),
        ),
        _textField('UF promedio'),
        _textField('TA prediálisis'),
        _textField('TA postdiálisis'),
        _textField('FC promedio'),
        CheckboxListTile(value: true, onChanged: (_) {}, title: const Text('Sin medicamentos')),
        CheckboxListTile(value: true, onChanged: (_) {}, title: const Text('Sin complicaciones')),
        CheckboxListTile(value: false, onChanged: (_) {}, title: const Text('Alergias')),
      ],
    );
  }

  Widget _laboratorios() {
    return ExpansionTile(
      title: const Text('V. Laboratorios', style: TextStyle(color: Colors.white)),
      children: [
        _textField('Hemoglobina (Hb)'),
        _textField('Leucocitos'),
        _textField('Plaquetas'),
        _textField('Creatinina'),
        _textField('BUN'),
        _textField('Calcio'),
        _textField('Potasio'),
        _textField('Fósforo'),
        _textField('Producto Ca*P'),
        _textField('URR'),
      ],
    );
  }

  Widget _adecuacionDialisis() {
    return ExpansionTile(
      title: const Text('VI. Adecuación de la Diálisis', style: TextStyle(color: Colors.white)),
      children: [
        _textField('Kt/V'),
        _textField('% URR'),
      ],
    );
  }

  Widget _vacunasRecibidas() {
    return ExpansionTile(
      title: const Text('VII. Vacunas Recibidas', style: TextStyle(color: Colors.white)),
      children: [
        CheckboxListTile(value: false, onChanged: (_) {}, title: const Text('Hepatitis B')),
        CheckboxListTile(value: true, onChanged: (_) {}, title: const Text('Influenza')),
      ],
    );
  }

  Widget _evaluacionNutricional() {
    return ExpansionTile(
      title: const Text('VIII. Evaluación Nutricional', style: TextStyle(color: Colors.white)),
      children: [
        _textField('IMC'),
        DropdownButtonFormField(
          decoration: const InputDecoration(labelText: 'EGS'),
          items: const [
            DropdownMenuItem(value: 'bien', child: Text('Bien nutrido')),
            DropdownMenuItem(value: 'leve', child: Text('Malnutrición leve/moderada')),
            DropdownMenuItem(value: 'grave', child: Text('Malnutrición grave')),
          ],
          onChanged: (_) {},
        ),
      ],
    );
  }

  Widget _observaciones() {
    return ExpansionTile(
      title: const Text('IX. Observaciones', style: TextStyle(color: Colors.white)),
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Observaciones generales',
            border: OutlineInputBorder(),
          ),
          maxLines: 5,
        )
      ],
    );
  }

  Widget _resumenAntropometrico() {
    return Card(
      color: Colors.blueGrey[800],
      margin: const EdgeInsets.only(top: 20),
      child: ListTile(
        title: const Text('Resumen de Cálculos', style: TextStyle(color: Colors.white)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('IMC: ${imc?.toStringAsFixed(2) ?? "-"}', style: const TextStyle(color: Colors.white)),
            Text('Kt/V estimado: ${ktvEstimado?.toStringAsFixed(2) ?? "-"}', style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  void _calcularIMC() {
    final peso = double.tryParse(_pesoController.text);
    final talla = double.tryParse(_tallaController.text);
    if (peso != null && talla != null && talla > 0) {
      setState(() => imc = peso / pow(talla, 2));
    }
  }

  void _calcularKtv() {
    final qb = double.tryParse(_flujoSangreController.text);
    final duracion = double.tryParse(_duracionSesionController.text);
    if (qb != null && duracion != null) {
      // Fórmula simple estimada: Kt/V = (Qb x t x 0.55) / V
      final k = qb * duracion * 0.55;
      const v = 40000.0; // Volumen estándar en ml (ej. 40 L)
      setState(() => ktvEstimado = k / v);
    }
  }

  Widget _textField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

// Para usar esta pantalla: MaterialApp(home: HemodialysisReportScreen());