import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:test/profile.dart';
import 'package:test/urls.dart';

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

  List<Profile> profiles = [];

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

  _retrieveProfiles() async
  {
    profiles = [];

    List response = json.decode((await widget.client.get(profileUrl)).body);
    for (var element in response) { profiles.add(Profile.fromMap(element)); }
    setState(() {});
  }

  void _deleteProfile(int id)
  {
    widget.client.delete(deleteProfileUrl(id));
    _retrieveProfiles();
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