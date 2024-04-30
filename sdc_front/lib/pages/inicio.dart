import "package:flutter/material.dart";
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
  String textInputDe = '';
  String textInputPara = '';
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            child: Column(children: [
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
              Text('MAPA'),
              Expanded(
                  child: Image(
                      image: AssetImage('assets/mapa_uff.png'),
                      fit: BoxFit.fill))
            ])),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
              Navigator.push(context,
                  MaterialPageRoute<void>(builder: (context) => _listaPaginas[value]));
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
    textInputDe = _controller1.text;
    textInputPara = _controller2.text;
    _controller1.clear();
    _controller2.clear();
    setState(() {});
    print(textInputDe + textInputPara);
    return;
  }

  void gpsButton1() {
    return;
  }
}
