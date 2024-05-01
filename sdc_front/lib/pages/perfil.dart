import "package:flutter/material.dart";
import '../uffcaronalib.dart';

class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil'),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,),
      body: 
      Container( 
      alignment: Alignment.center,
      child: Column(
        children:[
        Row(children: [
        Text('Nome de Usuario: '),
        Text('User'),
      ]),
      Row(children: [
        Text('Avaliaçôes: '),
        Text('4.98 (900)'),
      ])
      
      
      




      ]),
    ));
  }
}
