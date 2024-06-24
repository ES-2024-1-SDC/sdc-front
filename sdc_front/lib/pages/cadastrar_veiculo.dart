import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VehicleRegistrationPage extends StatefulWidget {
  @override
  _VehicleRegistrationPageState createState() =>
      _VehicleRegistrationPageState();
}

class _VehicleRegistrationPageState extends State<VehicleRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  int idUser = -1;
  String _marca = '';
  String _modelo = '';
  int _ano = 0;
  String _placa = '';

  Future<void> _cadastrarVeiculo() async {
    final url = Uri.parse('https://f31a-45-65-156-212.ngrok-free.app/veichles');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');

    final storage = FlutterSecureStorage();
    var acessToken = await storage.read(key: 'auth_token');
    print(acessToken);
    //acessToken = 'Bearer ${acessToken}';

    var body = {
      'userId': userId.toString(),
      "licensePlate": _placa,
      "brand": _marca,
      "model": _modelo,
      "color": "azul" //_color
    };

    final response = await http.post(
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${acessToken!}',
      },
      url,
      body: body,
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Veículo cadastrado com sucesso.')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar o veículo.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Veículos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Marca'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a marca do veículo';
                  }
                  return null;
                },
                onSaved: (value) {
                  _marca = value ?? '';
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Modelo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o modelo do veículo';
                  }
                  return null;
                },
                onSaved: (value) {
                  _modelo = value ?? '';
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ano'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o ano do veículo';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor, insira um ano válido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _ano = int.parse(value ?? '0');
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Placa'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a placa do veículo';
                  }
                  return null;
                },
                onSaved: (value) {
                  _placa = value ?? '';
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    _cadastrarVeiculo();
                  }
                },
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
