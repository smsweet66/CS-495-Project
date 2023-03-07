import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:test/profile.dart';
import 'package:test/urls.dart';

class UpdateProfilePage extends StatefulWidget
{
  final Client client;
  final String token;
  final Profile profile;
  const UpdateProfilePage({required this.client, required this.token, required this.profile, super.key});

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> with WidgetsBindingObserver
{
  final TextEditingController _profileNameController = TextEditingController();
  late String _bodySizes;

  void _updateProfile() async
  {
    widget.client.put(
      updateProfileUrl(widget.profile.id),
      headers: {"Authorization": "Token ${widget.token}"},
      body: {
        "profileName": _profileNameController.text,
        "bodySizes": _bodySizes
      }
    );
  }

  @override void initState()
  {
    super.initState();
    _profileNameController.text = widget.profile.name;
    _bodySizes = widget.profile.bodySizes.join(',');
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Profile"),),
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
                  hintText: 'Enter the name of the profile, Max length of 16',

                )
              )
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                  onPressed: () { _bodySizes = "1,2,3,4,5"; },
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
                  if(_bodySizes != "" && _profileNameController.text != "")
                  {
                    _updateProfile();
                    Navigator.pop(context);
                  }
                },
                child: const Text('Update Profile', style: TextStyle(fontSize: 25))
              )
            )
          ]
        )
      )
    );
  }
}