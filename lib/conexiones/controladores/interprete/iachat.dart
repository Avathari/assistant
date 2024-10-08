import 'dart:convert'; // Para manejar JSON
import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:http/http.dart' as http;

class IAChat {
  static Future sendMessage(String message) async {
    const String apiKey =
        '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'; // Reemplaza con tu clave API

    Terminal.printExpected(message: message);
    //
    final url = Uri.parse('https://api.openai.com/v1/completions');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",  // Cambia al modelo gpt-3.5-turbo
        "messages": [
          {"role": "system", "content": "Eres un asistente útil."},
          {"role": "user", "content": message}
        ],
        "max_tokens": 50,
        "temperature": 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['text'];
    } else {
      return "Error: ${response.statusCode} . . . ${response.body}";
    }
  }
}
