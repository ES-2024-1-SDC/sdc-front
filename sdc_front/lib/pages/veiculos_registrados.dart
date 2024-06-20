import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisteredVehiclesPage extends StatelessWidget {
  RegisteredVehiclesPage({super.key});

  Future<List<Map<String, String>>> _getRegisteredVehicles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');

    final url = Uri.parse(
        'https://f31a-45-65-156-212.ngrok-free.app/users/$userId/veichles');
    final storage = FlutterSecureStorage();
    var token = await storage.read(key: 'auth_token');
    http.Response response = await http.get(headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${token!}',
    }, url);
    List<dynamic> data = jsonDecode(response.body);
    List<Map<String, String>> vehicles = data.map((vehicle) {
      return {
        'brand': vehicle['brand'] as String,
        'model': vehicle['model'] as String,
        'licensePlate': vehicle['licensePlate'] as String,
      };
    }).toList();
    return vehicles;

    //await Future.delayed(Duration(seconds: 2)); // Simula um tempo de espera
    //return [
    //  {
    //    'marca': 'Toyota',
    //    'modelo': 'Corolla',
    //    'ano': '2020',
    //    'placa': 'ABC-1234'
    //  },
    //  {'marca': 'Honda', 'modelo': 'Civic', 'ano': '2019', 'placa': 'XYZ-5678'},
    //  // Adicione mais veículos conforme necessário
    //];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Veículos Registrados'),
        backgroundColor: Colors.indigo,
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: _getRegisteredVehicles(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            print(snapshot.data);
            return Center(child: Text('Erro ao carregar dados'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum veículo registrado encontrado'));
          } else {
            final vehicles = snapshot.data!;
            return ListView.builder(
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                final vehicle = vehicles[index];
                print(vehicles);
                return ListTile(
                  title: Text('${vehicle['brand']} ${vehicle['model']}'),
                  subtitle: Text('Placa: ${vehicle['licensePlate']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
