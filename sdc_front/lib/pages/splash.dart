import "package:flutter/material.dart";
import '../uffcaronalib.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
  @override 
  State<Splash> createState() => _AnimatedContainer();
}

class _AnimatedContainer extends State<Splash> with SingleTickerProviderStateMixin{
  double _alpha=0.0;
  late AnimationController ac;
  late Animation a;

@override
void initState() {
  super.initState();
  ac=AnimationController(duration: Duration(milliseconds: 15),vsync: this);
  Animation<double> a = Tween(begin:0.0, end:1.0).animate(ac);
  ac.forward();
  ac.addListener(() {
    setState(() {
      _alpha = _alpha<=0.5 ? _alpha+=0.5 : 1;
      print(_alpha);
    });
  });
}
  void _animatedAlpha() {
  setState(() {
    _alpha = _alpha <= 1.0 ? _alpha+=0.1 : _alpha +=0.01;
  });
  }

@override
Widget build(BuildContext context) {
return Container(
  color:const Color.fromARGB(255, 100, 100, 100),
  // child:AnimatedOpacity(duration: Duration(milliseconds:5000),opacity: _alpha,onEnd: (){Navigator.push(context,MaterialPageRoute<void>(builder: (context)=>Inicio(title:'Caronas Uff')));},
  child:AnimatedOpacity(duration: Duration(milliseconds:5000),opacity: _alpha,onEnd: (){Navigator.push(context,MaterialPageRoute<void>(builder: (context)=>Login()));},
child: Image.asset('assets/car.png'),));
}}
