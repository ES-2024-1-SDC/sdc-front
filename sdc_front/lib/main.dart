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
      
      body: const Center(
        child: Column(
          children: [
          Text('Para: '),
          Text('DE: '),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Uff Praia Vermelha'
          )
          )
        ],)

          
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(label: 'Home',icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: 'Settings',icon: Icon(Icons.arrow_back))
      ]),
    );
  }
}
