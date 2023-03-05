import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:test/profilePage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.client, required this.token}) : super(key: key);

  final String title;
  final Client client;
  final String token;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
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
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage(client: widget.client, token: widget.token)))
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