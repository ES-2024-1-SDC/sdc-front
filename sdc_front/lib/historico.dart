import "package:flutter/material.dart";
import 'uffcaronalib.dart';

class Historico extends StatelessWidget {
  const Historico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Historico'),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,),
      body: 
      Container( 
      alignment: Alignment.center,
      child: Column(
        children:[
        Row(children: [
        Text('Corrida #1:'),
        Text('data : 25/04/2024 07:00'),
        Text('de: minha casa para: uff praia vermelha'),
      ]),

      ]),
    ));
  }
}
