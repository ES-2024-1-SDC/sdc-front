import 'package:flutter/material.dart';
import 'package:sdc_front/pages/cadastrar_veiculo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Perfil extends StatelessWidget {
  Perfil({super.key});

  Future<Map<String, dynamic>> _getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('user_username') ?? '';
    double avaliacoes =
        4.9; // Substitua por sua lógica para obter as avaliações
    return {'userName': userName, 'avaliacoes': avaliacoes};
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
                      child: Text('Cadastrar veículo'))
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
