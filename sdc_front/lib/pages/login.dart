import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'inicio.dart';
import 'package:http/http.dart' as http;

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
  String? _email, _password;

  late int userId;
  final urlApi = 'f31a-45-65-156-212.ngrok-free.app';

  final _storage = FlutterSecureStorage();

  Future _login() async {
    // Lógica da autenticação com o servidor usando http e obter o token de autenticação
    print(urlApi);

    var url = Uri.https(urlApi, '/auth/login');

    var bd = {'email': _email, 'password': _password};
    print(_email);
    print(_password);
    print(bd);

    var response = await http.post(url, body: bd);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var decodedBody = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

      String sessionToken = decodedBody['token']['token'];
      int id = decodedBody["userId"];
      print('Token: ${sessionToken}');
      print('Token: ${id}');

      await _storage.write(key: 'auth_token', value: sessionToken);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_username', _email!);
      await prefs.setInt('userId', id);

      //Setar id, username real (e não email)
      //id vai ser importante para fazer as buscas

      _loginStatus = LoginStatus.signIn;

      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => Inicio(title: 'Caronas Uff'),
        ),
      );
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.indigo.shade50],
              ),
            ),
            child: ListView(
              children: [
                SizedBox(height: 80),
                Image.asset(
                  'assets/caronaUffLogo.png',
                  alignment: AlignmentDirectional.topCenter,
                  height: 120,
                ),
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onSaved: (newValue) => _email = newValue,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um nome de usuário.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_circle_outlined),
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        onSaved: (newValue) => _password = newValue,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira uma senha.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          labelText: "Password",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 48,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submit,
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo.shade400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Esqueceu sua Senha?',
                          style: TextStyle(color: Colors.indigo),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return RegistrationDialog();
                      },
                    );
                  },
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(color: Colors.indigo),
                  ),
                ),
              ],
            ),
          ),
        );
      case LoginStatus.signIn:
        return Inicio(
          title: 'Caronas UFF',
        );
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _login();
    }
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

  final urlApi = 'f31a-45-65-156-212.ngrok-free.app';

  Future<int> register() async {
    var url = Uri.https(urlApi, '/auth/register');
    var body = {
      'email': _emailController.text,
      'password': _passwordController.text,
      'full_name': _usernameController.text
    };

    http.Response response = await http.post(url, body: body);
    return response.statusCode;
  }

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
        _emailValidationMessage = 'Email válido';
      } else {
        _emailValidationMessage = 'Email inválido';
      }
    });
  }

  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text("Usuário registrado com sucesso."),
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
            Text(
              _emailValidationMessage,
              style: TextStyle(
                color: isEmailValid(_emailController.text)
                    ? Colors.green
                    : Colors.red,
              ),
            ),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            TextFormField(
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
          onPressed: () async {
            String email = _emailController.text;
            String username = _usernameController.text;
            String password = _passwordController.text;
            String confirmPassword = _confirmPasswordController.text;

            if (password == confirmPassword) {
              // Implementar lógica de registro aqui
              print('Email: $email');
              print('Username: $username');
              print('Password: $password');

              int resp = await register();
              if (resp == 200) {
                _showSnackBar(context);
              }
              print(resp);
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
