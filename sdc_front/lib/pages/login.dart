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
  int? user_id;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          appBar: AppBar(
            title: Text("Login page"),
          ),
          body: Container(
            child: Center(
                child: Column(
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                                onSaved: ((newValue) => _username = newValue),
                                decoration: InputDecoration(
                                  labelText: "Username",
                                  border: OutlineInputBorder(),
                                ))),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            obscureText: true,
                            onSaved: (newValue) => _password = newValue,
                            decoration: InputDecoration(
                              labelText: "Password",
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        )
                      ],
                    )),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text("Login"),
                ),
              ],
            )),
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
