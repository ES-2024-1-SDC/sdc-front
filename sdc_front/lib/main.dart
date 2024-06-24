import 'package:flutter/material.dart';
import 'uffcaronalib.dart';

void main() {
  debugPrint = (String? message, {int? wrapWidth}) {};
  runApp(const CaronaUff());
}

class CaronaUff extends StatelessWidget {
  const CaronaUff({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carona Uff',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 28, 184)),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Carona Uff'),
      // home: const Inicio(title: 'Carona Uff'),
      home: const Login(),
    );
  }
}
