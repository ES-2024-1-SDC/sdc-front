import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:expandable_menu/expandable_menu.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const CaronaUff());
}

class CaronaUff extends StatelessWidget {
  const CaronaUff({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carona Uff',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 28, 184)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Carona Uff'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String textLabel1='De: ';
  String textLabel2='Para: ';
  String textInputDe='';
  String textInputPara='';
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title,textAlign: TextAlign.center)
      ),
      
      body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [ Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(textLabel1),
                Expanded(child: 
                TextField(decoration: InputDecoration(
                    border: OutlineInputBorder(),hintText: 'Meu Endereço Atual'),controller: _controller1)),
                SizedBox(width:80,height: 60,child: IconButton(icon: Icon(Icons.location_on_sharp),color: Colors.red,onPressed: gpsButton1))
                ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(textLabel2),
                Expanded(child: 
                TextField(decoration: InputDecoration(
                    border: OutlineInputBorder(),hintText: 'Endereço de Destino'),controller: _controller2))
                    ,
                SizedBox(
                  width: 80,
                  height: 60,
                  child: ElevatedButton(onPressed: (){okButton1();}, child: Text('Ok'),
                  style: ElevatedButton.styleFrom( foregroundColor: Colors.white,backgroundColor:Colors.green,shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),),
                )
              ],
            ),
            Text('MAPA'),
            Expanded(
            child: Image(image:AssetImage('../assets/mapa_uff.png'),fit: BoxFit.fill))
              ]
          )
          ),)
          
      ,

      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(label: 'Home',icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: 'Historico',icon: Icon(Icons.history))
      ]),
    );
  }

void okButton1(){
  textInputDe=_controller1.text;
  textInputPara=_controller2.text;
  _controller1.clear();_controller2.clear();
  setState(() { });
  print(textInputDe+textInputPara);
  return;
}
void gpsButton1(){
  return;
}


}
