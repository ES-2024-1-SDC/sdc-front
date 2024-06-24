import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sdc_front/pages/cadastrar_veiculo.dart';
import 'package:sdc_front/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'veiculos_registrados.dart';
import 'package:http/http.dart' as http;
import '../constants.dart' as Constants;

class Perfil extends StatelessWidget {
  Perfil({super.key});

  Future<Map<String, dynamic>> _getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt("userId");
    var url = Uri.parse("${Constants.url}users/${userId}");
    final storage = FlutterSecureStorage();
    var token = await storage.read(key: 'auth_token');

    http.Response response = await http.get(headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    }, url);

    var obj = jsonDecode(response.body);
    print(obj);

    String userName = obj['fullName'];
    String email = obj['email'];
    double avaliacoes =
        4.9; // Substitua por sua lógica para obter as avaliações
    return {'userName': userName, 'email': email, 'avaliacoes': avaliacoes};
  }

  Future<void> _logout(BuildContext context) async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'auth_token');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Colors.indigo, // Cor de fundo da AppBar similar à Uber
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getInfo(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar dados'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum dado encontrado'));
          } else {
            final userName = snapshot.data!['userName'] as String;
            final email = snapshot.data!['email'] as String;
            final avaliacoes = snapshot.data!['avaliacoes'] as double;
            return Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Nome de Usuário: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Email: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        email,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Avaliações: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '$avaliacoes (900)',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VehicleRegistrationPage()),
                      );
                    },
                    child: Text('Cadastrar veículo'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisteredVehiclesPage()),
                      );
                    },
                    child: Text('Veículos'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _logout(context),
                    child: Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Cor do botão de logout
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
