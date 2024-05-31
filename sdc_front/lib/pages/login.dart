// import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  final _storage = FlutterSecureStorage();

  Future<void> _login() async {
    // Lógica da autenticação com o servidor usando http e obter o token de autenticação

    await _storage.write(key: 'auth_token', value: sessionToken);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_username', _username!);

    Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (context) => Inicio(title: 'Caronas Uff')));
  }

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
            padding: EdgeInsets.only(left: 40, right: 40, top: 40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.indigo.shade50
                ], // Define your gradient colors here
              ),
            ),
            child: ListView(
              children: [
                Image.asset(
                  'assets/caronaUffLogo.png',
                  alignment: AlignmentDirectional.topCenter,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(children: [
                              Icon(Icons.account_circle_outlined),
                              Text('Nome de Usuário')
                            ]),
                            Padding(
                                padding: EdgeInsets.all(5),
                                child: TextFormField(
                                    onSaved: ((newValue) =>
                                        _username = newValue),
                                    decoration: InputDecoration(
                                      labelText: "Username",
                                      border: OutlineInputBorder(),
                                    ))),
                            Row(children: [
                              Icon(Icons.lock_outline),
                              Text('Senha')
                            ]),
                            Padding(
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
                        child: TextButton(
                            onPressed: () {},
                            child: Text('Esqueceu sua Senha?'))),
                    Container(
                      height: 60,
                      width: double.infinity
                      // ,decoration: BoxDecoration(color: Colors.indigo.shade400)
                      ,
                      child: ElevatedButton(
                        onPressed: _submit,
                        child: Text("Login"),
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.indigo.shade400,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 60,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Login com Google'),
                              Icon(Icons.g_mobiledata)
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo.shade400,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0))),
                        ))
                  ],
                ),
                SizedBox(height: 20),
                TextButton(
                  child: Text('Cadastrar'),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return RegistrationDialog();
                        });
                  },
                )
              ],
            ),
          ),
        );
      case LoginStatus.signIn:
        return Login();
    }
  }

  void _submit() {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (context) => Inicio(title: 'Caronas Uff')));
  }
}

class RegistrationDialog extends StatefulWidget {
  @override
  _RegistrationDialogState createState() => _RegistrationDialogState();
}

class _RegistrationDialogState extends State<RegistrationDialog> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _emailValidationMessage = '';

  bool isEmailValid(String email) {
    String pattern =
        r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateEmail);
    _emailController.dispose();
    super.dispose();
  }

  void _validateEmail() {
    setState(() {
      if (isEmailValid(_emailController.text)) {
        _emailValidationMessage = 'Email válido!';
      } else {
        _emailValidationMessage = 'Email inválido';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Register'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            Text(_emailValidationMessage,
                style: TextStyle(
                  color: isEmailValid(_emailController.text)
                      ? Colors.green
                      : Colors.red,
                )),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
              ),
              obscureText: true,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Register'),
          onPressed: () {
            String email = _emailController.text;
            String username = _usernameController.text;
            String password = _passwordController.text;
            String confirmPassword = _confirmPasswordController.text;

            if (password == confirmPassword) {
              // Implementar lógica de registro aqui
              print('Email: $email');
              print('Username: $username');
              print('Password: $password');

              Navigator.of(context).pop();
            } else {
              // Mostrar erro de confirmação de senha
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Passwords do not match'),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
