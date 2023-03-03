import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:test/homePage.dart';
import 'package:test/urls.dart';

class LoginPage extends StatefulWidget
{
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
{
  final Client client = Client();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<String?> _login() async
  {
    Map response = json.decode((await client.post(loginUrl, body:
    {
      'username': usernameController.text,
      'password': passwordController.text
    })).body);

    return response['token'].toString();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  hintText: 'Enter your username'
                )
              )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 0),
              child: TextField(
                controller: passwordController,
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
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20)
              ),
              child: ElevatedButton(
                onPressed: (){
                  _login().then((token)
                  {
                    if(token != null)
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage(title: "Home", client: client, token: token))
                      );
                    }
                  });
                },
                child: const Text('Login', style: TextStyle(color: Colors.white, fontSize: 25))
              )
            )
          ]
        )
      )
    );
  }
}