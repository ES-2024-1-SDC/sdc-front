import 'package:flutter/material.dart';
import '../uffcaronalib.dart';

class PedirCarona extends StatefulWidget {
  const PedirCarona({Key? key}) : super(key: key);

  @override
  _PedirCaronaState createState() => _PedirCaronaState();
}

class _PedirCaronaState extends State<PedirCarona> {
  TextEditingController _origemController = TextEditingController();
  TextEditingController _destinoController = TextEditingController();
  TextEditingController _dataController = TextEditingController();
  TextEditingController _horaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedir carona'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _origemController,
              decoration: InputDecoration(
                labelText: 'Origem',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _destinoController,
              decoration: InputDecoration(
                labelText: 'Destino',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _dataController,
              decoration: InputDecoration(
                labelText: 'Data',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _horaController,
              decoration: InputDecoration(
                labelText: 'Hora',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //Lógica para salvar os dados
              },
              child: Text('Pedir carona'),
            ),
          ],
        ),
      ),
    );
  }
}

