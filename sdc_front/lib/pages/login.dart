// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'inicio.dart';

enum LoginStatus { notSignIn, signIn }

class Login extends StatefulWidget {
  const Login({super.key});
  static const String routeName = "/login";

  String getRouteName() {
    return routeName;
  }

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String? _username, _password;
  late String sessionToken;
  late int userId;

  //USER_ID E SESSION TOKEN SERÃO RETORNADOS PELO SERVIDOR

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          
          // appBar: AppBar(
          //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          //   title: Text("Login / Cadastro"),
          // ),
          body: Container(
            padding: EdgeInsets.only(left: 40,right:40,top:40)
            ,decoration: BoxDecoration( 
              gradient: LinearGradient( 
      colors: [Colors.white, Colors.indigo.shade50], // Define your gradient colors here
    ), ),
            child: ListView(
              children: [ 
                Image.asset('caronaUffLogo.png',alignment: AlignmentDirectional.topCenter,)
                ,Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Row(children:[
                                Icon(Icons.account_circle_outlined)
                                ,Text('Nome de Usuário')
                              ]),
                              Padding(
                                  padding: EdgeInsets.all(5),
                                  child: TextFormField(
                                      onSaved: ((newValue) => _username = newValue),
                                      decoration: InputDecoration(
                                        labelText: "Username",
                                        border: OutlineInputBorder(),
                                      ))),
                              Row(children:[
                                Icon(Icons.lock_outline)
                                ,Text('Senha')
                                
                              ])
                              ,Padding(
                                padding: EdgeInsets.all(5),
                                child: TextFormField(
                                  obscureText: true,
                                  onSaved: (newValue) => _password = newValue,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              )
                            ],
                          )),
                           Container(
                            alignment: Alignment.centerRight,
                            child: TextButton(onPressed: (){}, child: Text('Esqueceu sua Senha?'))
                            )
                      ,Container(
                        height:60
                        ,width:double.infinity
                        // ,decoration: BoxDecoration(color: Colors.indigo.shade400)
                        ,child: ElevatedButton(
                            onPressed: _submit,
                            child: Text("Login"),
                            style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.indigo.shade400,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0))),
                        ),
                      )
                      ,SizedBox(height: 20,)
                      ,Container(height:60,width:double.infinity,child: ElevatedButton(onPressed: (){}, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center
                        ,children: [
                          Text('Login com Google'),
                          Icon(Icons.g_mobiledata)
                        ],
                      ),style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo.shade400,foregroundColor: Colors.white,shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0))),))
                    ],
                                  ),
                    SizedBox(height:20),
                    TextButton(child:Text('Cadastrar'),onPressed: (){},)
                  ],
                ),
            ),
        );
            case LoginStatus.signIn:
                return Login();

    }
  }

  void _submit() {
    Navigator.push(context,MaterialPageRoute<void>(builder: (context)=>Inicio(title:'Caronas Uff')));
  }
}
