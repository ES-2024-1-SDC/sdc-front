import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Carona {
  late int motoristaId;
  late int veiculoId;
  late String origem;
  late String destino;
  late String data;
  late String hora;

  Carona({
    required this.motoristaId,
    required this.veiculoId,
    required this.origem,
    required this.destino,
    required this.data,
    required this.hora,
  });

  Map<String, dynamic> toMap() {
    return {
      'driverId': motoristaId.toString(),
      'veichleId': veiculoId.toString(),
      'dateTime': '$data $hora',
      'originLat': '0.0',
      'originLng': '0.0',
      'origin': origem,
      'destinationLat': '0.0',
      'destinationLng': '0.0',
      'destination': destino,
      'maxPassenger': '4',
      'automaticAllowance': '0'
    };
  }
}

class OfereceCarona extends StatefulWidget {
  const OfereceCarona({Key? key}) : super(key: key);

  @override
  _OfereceCaronaState createState() => _OfereceCaronaState();
}

class _OfereceCaronaState extends State<OfereceCarona> {
  final _formKey = GlobalKey<FormState>();
  final _origemController = TextEditingController();
  final _destinoController = TextEditingController();
  final _dataController = TextEditingController();
  final _horaController = TextEditingController();
  int? _selectedVeiculoId;

  Future<List<Map<String, String>>> getVeiculos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');
    var storage = FlutterSecureStorage();
    var token = await storage.read(key: 'auth_token');

    final url = Uri.parse(
        'https://f31a-45-65-156-212.ngrok-free.app/users/$userId/veichles');

    http.Response response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });

    List<dynamic> data = jsonDecode(response.body);
    List<Map<String, String>> vehicles = data.map((vehicle) {
      return {
        'id': vehicle['id'].toString(),
        'nome': vehicle['brand'] as String,
      };
    }).toList();
    return vehicles;
  }

  @override
  void dispose() {
    _origemController.dispose();
    _destinoController.dispose();
    _dataController.dispose();
    _horaController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() && _selectedVeiculoId != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var storage = FlutterSecureStorage();
      var token = await storage.read(key: 'auth_token');
      int? userId = prefs.getInt('userId');

      Carona carona = Carona(
        motoristaId: userId!,
        veiculoId: _selectedVeiculoId!,
        origem: _origemController.text,
        destino: _destinoController.text,
        data: _dataController.text,
        hora: _horaController.text,
      );

      var caronaObj = {
        'driverId': userId.toString(),
        'veichleId': _selectedVeiculoId.toString(),
        'dateTime': '${_dataController.text} ${_horaController.text}',
        'originLat': '0.0',
        'originLng': '0.0',
        'origin': _origemController.text,
        'destinationLat': '0.0',
        'destinationLng': '0.0',
        'destination': _destinoController.text,
        'maxPassenger': '4',
        'automaticAllowance': '0',
      };

      print(caronaObj);
      print(token);
      sleep(Duration(seconds: 2));
      var url = Uri.parse('https://f31a-45-65-156-212.ngrok-free.app/rides');

      http.Response response = await http.post(
        url,
        body: caronaObj,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Carona criada com sucesso!')),
        );
      }

      // Limpa os campos do formulário
      _formKey.currentState!.reset();
      setState(() {
        _selectedVeiculoId = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, selecione um veículo.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oferecer Carona'),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: getVeiculos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Erro ao carregar veículos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum veículo disponível'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration:
                          InputDecoration(labelText: 'Selecione o Veículo'),
                      value: _selectedVeiculoId?.toString(),
                      items: snapshot.data!.map((veiculo) {
                        return DropdownMenuItem<String>(
                          value: veiculo['id']!,
                          child: Text(veiculo['nome']!),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedVeiculoId = int.parse(value!)!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Por favor, selecione um veículo';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _origemController,
                      decoration: InputDecoration(labelText: 'Origem'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a origem';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _destinoController,
                      decoration: InputDecoration(labelText: 'Destino'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o destino';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _dataController,
                      decoration:
                          InputDecoration(labelText: 'Data (dd/mm/aaaa)'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a data';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _horaController,
                      decoration: InputDecoration(labelText: 'Hora (hh:mm)'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a hora';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Criar Carona'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
