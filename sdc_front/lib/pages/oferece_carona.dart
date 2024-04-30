import 'package:flutter/material.dart';
import '../uffcaronalib.dart';

// Jogar para model depois
class Carona {
  late String origem;
  late String destino;
  late String data;
  late String hora;

  Carona({
    required this.origem,
    required this.destino,
    required this.data,
    required this.hora,
  });
}

class OfereceCarona extends StatelessWidget {
  const OfereceCarona({Key? key}) : super(key: key);

  // Função que vai chmar o controller para pegar as caronas disponíveis
  void getCaronas(){

  }

  @override
  Widget build(BuildContext context) {
    // Chama a função (provavelmente uma função assíncrona) para pegar as caronas disponíveis

    List<Carona> caronasPedidas = []; 
    Carona exemploCarona = Carona(
        data: '30/04/2024',
        hora: '19:00',
        origem: 'Terminal de Niteroi',
        destino: 'Praia vermelha');

    caronasPedidas.add(exemploCarona);

    return Scaffold(
      appBar: AppBar(
        title: Text('Oferecer carona'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Caronas Pedidas:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: caronasPedidas.length,
                itemBuilder: (context, index) {
                  Carona carona = caronasPedidas[index];
                  return Card(
                    child: ListTile(
                      title: Text('Origem: ${carona.origem}'),
                      subtitle: Text(
                          'Destino: ${carona.destino}\nData: ${carona.data}\nHora: ${carona.hora}'),
                      // Aqui você pode adicionar mais informações da carona se necessário
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Aqui você pode adicionar a lógica para oferecer a carona
                        },
                        child: Text('Oferecer'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

