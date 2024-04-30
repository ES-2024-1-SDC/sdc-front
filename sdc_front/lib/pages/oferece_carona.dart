import "package:flutter/material.dart";
import '../uffcaronalib.dart';

class OfereceCarona extends StatelessWidget {
  const OfereceCarona({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Oferecer carona'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Text("Página para oferecer carona"));
  }
}
