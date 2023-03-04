import 'package:flutter/material.dart';
import 'package:test/login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'My Flutter App',
			theme: ThemeData(
				brightness: Brightness.light
			),
			darkTheme: ThemeData(
				brightness: Brightness.dark
			),
			themeMode: ThemeMode.system,
			home: const LoginPage(),
		);
  }
}