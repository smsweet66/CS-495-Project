import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:test/homePage.dart';
import 'package:test/registerPage.dart';
import 'package:test/urls.dart';

class LoginPage extends StatefulWidget
{
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver
{
  final Client _client = Client();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<String?> _login() async
  {
    Map response = json.decode((await _client.post(loginUrl, body:
    {
      'username': _usernameController.text,
      'password': _passwordController.text
    })).body);

    return response['token'].toString();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 150,
                  child: Image.asset('assets/pictures/logo.png'),
                )
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  hintText: 'Enter your username'
                )
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter secure password'
                )
              )
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: ()
                {
                  _login().then((token)
                  {
                    if(token != null)
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: "Home", client: _client, token: token)));
                    }
                  });
                },
                child: const Text('Login', style: TextStyle(fontSize: 25))
              )
            ),
            TextButton(
              onPressed: ()
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()));
              },
              child: const Text('Sign Up')
            )
          ]
        )
      )
    );
  }
}