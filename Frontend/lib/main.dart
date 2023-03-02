import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

	@override
	Widget build(BuildContext context) {
		return const MaterialApp(
			title: 'My Flutter App',
			home: MyHomePage(title: 'Home'),
		);
  }
}

class MyHomePage extends StatefulWidget {
	const MyHomePage({Key? key, required this.title}) : super(key: key);

	final String title;

	@override
	MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
		with SingleTickerProviderStateMixin {
	late TabController _tabController;

	@override
	void initState() {
		super.initState();
		_tabController = TabController(length: 2, vsync: this);
	}

	@override
	void dispose() {
		_tabController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
			),
			drawer: Drawer(
				child: ListView(
					padding: EdgeInsets.zero,
					children: <Widget>[
						const DrawerHeader(
							decoration: BoxDecoration(
								color: Colors.lightBlue,
							),
							child: Text('Menu'),
						),
						ListTile(
							title: const Text('Profile'),
							onTap: () {
								// TODO: Implement profile screen.
							},
						),
						ListTile(
							title: const Text('Settings'),
							onTap: () {
								// TODO: Implement settings screen.
							},
						),
						ListTile(
							title: const Text('About'),
							onTap: () {
								// TODO: Implement about screen.
							},
						),
					],
				),
			),
			body: TabBarView(
				controller: _tabController,
				children: const <Widget>[
					Center(
						child: Text('Home Screen'),
					),
					Center(
						child: Text('Store Screen'),
					),
				],
			),
			bottomNavigationBar: Container(
				decoration: const BoxDecoration(
					color: Colors.lightBlue,
				),
				child: TabBar(
					controller: _tabController,
					tabs: const <Tab>[
						Tab(
							text: 'Home',
							icon: Icon(Icons.home),
						),
						Tab(
							text: 'Store',
							icon: Icon(Icons.shopping_bag),
						),
					],
				),
			),
		);
	}
}
