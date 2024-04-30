import "package:flutter/material.dart";
import '../uffcaronalib.dart';

class PedirCarona extends StatelessWidget {
  const PedirCarona({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pedir carona'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Text("Página para pedir carona"));
  }
}
