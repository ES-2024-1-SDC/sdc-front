import 'dart:async';
import 'dart:ffi';

import "package:flutter/material.dart";
// import 'package:google_maps/google_maps_drawing.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../uffcaronalib.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key, required this.title});
  final String title;
  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int _selectedPage = 0;
  List<Widget> _listaPaginas = <Widget>[
    Splash(),
    PedirCarona(),
    OfereceCarona(),
    Historico()
  ];

  String textLabel1 = 'De: ';
  String textLabel2 = 'Para: ';
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  late GoogleMapController mapController;
  LatLng _selectedLocation = LatLng(-22.904585778723078, -43.13149503863926);
  LatLng deLocation = LatLng(-22.904585778723078, -43.13149503863926);
  LatLng paraLocation = LatLng(-22.902397827002222, -43.172449059784405);
  late Marker markerA;
  late Marker markerB;
  bool isMarkerVisible = false;
  late GoogleMap gMapWidget;
  String strOrigem='Origem';
  String strDestino='Destino';

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
      Widget build(BuildContext context) {
      updateMarkers();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title, textAlign: TextAlign.center),
          actions: [
            IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (context) => Perfil()));
                }),
          ]),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(textLabel1),
                  Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Meu Endereço Atual'),
                          controller: _controller1)),
                  SizedBox(
                      width: 80,
                      height: 60,
                      child: IconButton(
                          icon: Icon(Icons.location_on_sharp),
                          color: Colors.red,
                          onPressed: gpsButton1))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(textLabel2),
                  Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Endereço de Destino'),
                          controller: _controller2)),
                  SizedBox(
                    width: 80,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        okButton1();
                      },
                      child: Text('Ok'),
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0))),
                    ),
                  )
                ],
              ),
              Text('Mapa'),
              Expanded(
                child: gMapWidget=GoogleMap(
                  onMapCreated: _onMapCreated,
                  onTap: _onMapTap,
                  initialCameraPosition: CameraPosition(
                    target: _selectedLocation,
                    zoom: 15, )
                  ,markers: Set.of([markerA,markerB]),
                ),
              ),
            ],
          ),
        ),
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
                icon: Icon(Icons.home),
                backgroundColor: Color.fromRGBO(0, 0, 155, 1.0)),
            BottomNavigationBarItem(
                label: 'Pedir carona',
                icon: Icon(Icons.directions_car),
                backgroundColor: Color.fromRGBO(0, 0, 155, 1.0)),
            BottomNavigationBarItem(
                label: 'Oferecer carona',
                icon: Icon(Icons.car_rental),
                backgroundColor: Color.fromRGBO(0, 0, 155, 1.0)),
            BottomNavigationBarItem(
              label: 'Historico',
              icon: Icon(Icons.history),
              backgroundColor: Color.fromRGBO(0, 0, 155, 1.0),
            )
          ],
          showUnselectedLabels: true),
    );
  }

  void okButton1() {
    strOrigem = _controller1.text;
    strDestino = _controller2.text;
    print(strOrigem);
    updateMarkers();
    // _controller1.clear();
    // _controller2.clear();
    setState(() {});
    print(strOrigem+strDestino);
    return;
  }

  void gpsButton1() {
    // 060524 - TODO SELECTEDLOCATION DEVE RECEBER A LOCALIZAÇÃO ATUAL DO USUARIO
    // PROVAVELMENTE SERA NECESSARIO MUDANCAS NO PERMISSIOHANDLER PARA CONSEGUIR
    // PERMISSOES DE LOCALIZACAO ATUAL QUE TAMBEM DEVEM SER ADICIONADAS NO INICIO
    // DO CREATESTATE
    _selectedLocation=LatLng(-22.902397827002222, -43.172449059784405);
    refreshMap();
    // return;
  }

  void refreshMap() async {
    isMarkerVisible=!isMarkerVisible;
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _selectedLocation
      ,zoom: await mapController.getZoomLevel() )));
    setState(() {});
  }
  void _onMapTap(LatLng l){
    print(l);
  }

  void updateMarkers(){
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
