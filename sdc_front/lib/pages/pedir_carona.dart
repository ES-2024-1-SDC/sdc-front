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
        backgroundColor: Colors.indigo, // Cor de fundo da AppBar similar à Uber
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
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _destinoController,
              decoration: InputDecoration(
                labelText: 'Destino',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _dataController,
              decoration: InputDecoration(
                labelText: 'Data',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _horaController,
              decoration: InputDecoration(
                labelText: 'Hora',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para salvar os dados
              },
              child: Text('Pedir carona', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo, // Cor do botão similar à Uber
              ),
            ),
          ],
        ),
      ),
    );
  }
}

