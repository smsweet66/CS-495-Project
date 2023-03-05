import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:test/urls.dart';

class AddProfilePage extends StatefulWidget
{
  final Client client;
  final String token;
  const AddProfilePage({required this.client, required this.token, super.key});

  @override
  _AddProfilePageState createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<AddProfilePage> with WidgetsBindingObserver
{
  final _profileNameController = TextEditingController();
  String bodySizes = "";

  void _createProfile() async
  {
    widget.client.post(
      createProfileUrl,
      headers: {"Authorization": "Token ${widget.token}"},
      body: {
        "profileName": _profileNameController.text,
        "bodySizes": bodySizes
      }
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Profile"),),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: TextField(
                controller: _profileNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Profile Name',
                  hintText: 'Enter the name of the profile'
                )
              )
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () { bodySizes = "1,2,3,4,5"; },
                child: const Text('Scan Body', style: TextStyle(fontSize: 25))
              )
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: ()
                {
                  if(bodySizes != "" && _profileNameController.text != "")
                  {
                    _createProfile();
                    Navigator.pop(context);
                  }
                },
                child: const Text('Create Profile', style: TextStyle(fontSize: 25))
              )
            ),
          ],
        )
      )
    );
  }
}