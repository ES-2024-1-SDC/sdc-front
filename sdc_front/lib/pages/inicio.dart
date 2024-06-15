import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../uffcaronalib.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int _selectedPage = 0;
  List<Widget> _listaPaginas = <Widget>[
    Splash(),
    PedirCarona(),
    OfereceCarona(),
    Historico()
  ];

  late GoogleMapController mapController;
  LatLng _selectedLocation = LatLng(-22.904585778723078, -43.13149503863926);
  LatLng deLocation = LatLng(-22.902397827002222, -43.172449059784405);
  LatLng paraLocation = LatLng(-22.904585778723078, -43.13149503863926);
  late Marker markerA;
  late Marker markerB;
  bool isMarkerVisible = true;
  String strOrigem = 'Origem';
  String strDestino = 'Destino';

  @override
  void initState() {
    super.initState();
    updateMarkers();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.black87),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Perfil()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _selectedLocation,
                    zoom: 15,
                  ),
                  markers: Set.of([markerA, markerB]),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        color: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Meu Endereço Atual',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                ),
                                onChanged: (value) {
                                  // Atualizar localização atual conforme o usuário digita
                                },
                              ),
                            ),
                            SizedBox(width: 8),
                            IconButton(
                              icon: Icon(Icons.location_on, color: Colors.red),
                              onPressed: () {
                                // Implementar ação de obter localização atual
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        color: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Endereço de Destino',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                ),
                                onChanged: (value) {
                                  // Atualizar endereço de destino conforme o usuário digita
                                },
                              ),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                // Ação do botão 'Ok'
                                okButton1();
                              },
                              child: Text('Ok'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (context) => _listaPaginas[value]));
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home, color: Colors.black87),
          ),
          BottomNavigationBarItem(
            label: 'Pedir carona',
            icon: Icon(Icons.directions_car, color: Colors.black87),
          ),
          BottomNavigationBarItem(
            label: 'Oferecer carona',
            icon: Icon(Icons.car_rental, color: Colors.black87),
          ),
          BottomNavigationBarItem(
            label: 'Histórico',
            icon: Icon(Icons.history, color: Colors.black87),
          ),
        ],
        showUnselectedLabels: true,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey, // Cor dos itens não selecionados
      ),
    );
  }

  void okButton1() {
    // Lógica para processar o clique no botão 'Ok'
    strOrigem = ''; // Atualizar com o valor do campo de origem
    strDestino = ''; // Atualizar com o valor do campo de destino
    updateMarkers();
    setState(() {});
  }

  void updateMarkers() {
    markerA = Marker(
      markerId: MarkerId('markerA'),
      position: deLocation,
      infoWindow: InfoWindow(title: strOrigem),
      visible: isMarkerVisible,
    );

    markerB = Marker(
      markerId: MarkerId('markerB'),
      position: paraLocation,
      infoWindow: InfoWindow(title: strDestino),
      visible: isMarkerVisible,
    );
  }
}
