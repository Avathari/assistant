import 'package:assistant/screens/home.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Asistente',
      theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          interactive: true,
          // thumbVisibility: true,
          radius: const Radius.circular(10.0),
          thumbColor: WidgetStateProperty.all(Colors.grey),
          thickness: WidgetStateProperty.all(5.0),
          minThumbLength: 100,
        ),
        
        scaffoldBackgroundColor: Theming.bdColor,
        iconTheme: const IconThemeData(color: Colors.white),
        primaryIconTheme: const IconThemeData(color: Colors.white),
        colorSchemeSeed: const Color(0xff6750a4),
        useMaterial3: true,
        cardColor: Theming.bdColor,
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(),
          textTheme: ButtonTextTheme.accent,
        ),
      ),
      // darkTheme: ThemeData(primarySwatch: Colors.grey),
      // color: Colors.grey,
      // supportedLocales: {const Locale('en', ' ')},
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        // '/create': (context) => Create(),
      },
    );
  }
}
