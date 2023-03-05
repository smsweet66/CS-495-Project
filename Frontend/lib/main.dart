import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test/loginPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

	@override
	Widget build(BuildContext context)
	{
		return MaterialApp(
			title: 'My Flutter App',
			theme: ThemeData(brightness: Brightness.light),
			darkTheme: ThemeData(brightness: Brightness.dark),
			themeMode: ThemeMode.system,
			home: _SplashScreen(),
		);
  }
}

class _SplashScreen extends StatefulWidget
{
	@override
	_SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<_SplashScreen>
{
	@override
	void initState()
	{
		super.initState();
		Timer(const Duration(seconds: 3),
			()=>Navigator.pushReplacement(context,
				MaterialPageRoute(builder: (context) => const LoginPage()))
		);
	}

	@override
	Widget build(BuildContext context)
	{
		return Center(child: Image.asset('assets/pictures/logo.png'));
	}
}