import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../uffcaronalib.dart';

class PedirCarona extends StatefulWidget {
  const PedirCarona({Key? key}) : super(key: key);

  @override
  _PedirCaronaState createState() => _PedirCaronaState();
}

class _PedirCaronaState extends State<PedirCarona> {
  Future _getCaronas() async {
    final url = Uri.parse('https://f31a-45-65-156-212.ngrok-free.app/rides');

    final storage = FlutterSecureStorage();
    var token = await storage.read(key: 'auth_token');
    http.Response response = await http.get(headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${token!}',
    }, url);

    var body = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    var data = body['data'];
    print(data);

    return data;
  }

  Future<void> _participarCarona(int caronaId) async {
    final url = Uri.parse(
        'https://f31a-45-65-156-212.ngrok-free.app/rides/$caronaId/join');

    final storage = FlutterSecureStorage();
    var token = await storage.read(key: 'auth_token');
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${token!}',
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Você participou da carona com sucesso!'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Falha ao participar da carona.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedir Carona'),
      ),
      body: FutureBuilder(
        future: _getCaronas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar as caronas'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return Center(child: Text('Nenhuma carona disponível'));
          } else {
            var caronas = snapshot.data as List;
            return ListView.builder(
              itemCount: caronas.length,
              itemBuilder: (context, index) {
                var carona = caronas[index];
                var dateTime = carona['dateTime'].toString();
                dateTime = dateTime.replaceAll('Z', '');
                dateTime = dateTime.replaceAll('T', ' ');
                return ListTile(
                  title: Text('Carona ${carona['id']}'),
                  subtitle: Text(
                      'De: ${carona['origin']}\nPara: ${carona['destination']}\nHorário: ${dateTime}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      _participarCarona(carona['id']);
                    },
                    child: Text('Participar'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
