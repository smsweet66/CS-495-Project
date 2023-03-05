import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:test/addProfilePage.dart';
import 'package:test/profile.dart';
import 'package:test/urls.dart';

class ProfilePage extends StatefulWidget
{
  final Client client;
  final String token;
  const ProfilePage({required this.client, required this.token, super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
{
  List<Profile> profiles = [];

  void _retrieveProfiles() async
  {
    profiles = [];

    List response = json.decode((await widget.client.get(profileUrl,
        headers: {"Authorization": "Token ${widget.token}"})).body);
    for (var element in response) { profiles.add(Profile.fromMap(element)); }
    setState(() {});
  }

  void _deleteProfile(int id)
  {
    widget.client.delete(deleteProfileUrl(id),
        headers: {"Authorization": "Token ${widget.token}"});
    _retrieveProfiles();
  }

  @override
  void initState()
  {
    _retrieveProfiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: const Text("Profiles")),
      body: RefreshIndicator(
        onRefresh: () async { _retrieveProfiles(); },
        child: ListView.builder(
          itemCount: profiles.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(profiles[index].name),
              onTap: () {}, //TODO implement profile update
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _deleteProfile(profiles[index].id)
              )
            );
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddProfilePage(client: widget.client, token: widget.token))),
        tooltip: 'Create Profile',
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}