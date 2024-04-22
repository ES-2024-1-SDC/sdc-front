import 'package:flutter/material.dart';
import 'package:expandable_menu/expandable_menu.dart';

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

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title,textAlign: TextAlign.center)
      ),
      
      body: Center(
          child: SizedBox(
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
                ElevatedButton(onPressed: gpsButton1, child: Text('gps'))
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
                ElevatedButton(onPressed: (){okButton1();}, child: Text('Ok'))
              ],
            ),
            Text('MAPA')])
          ),)
          
      ,
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
