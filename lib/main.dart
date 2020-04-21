import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: Login(),
  ));
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username, password;
  final _key = new GlobalKey<FormState>();

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
      // print("$username, $password");
    }
  }

  login() async {
    final response = await http.post("http://192.168.1.5/test2.php", body: {
      "user": username,
      "pass": password,
    });

    // final data = jsonDecode(response.body);
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(15ta),
          children: <Widget>[
            TextFormField(
              validator: (e) {
                if (e.isEmpty) {
                  return "Username cannot be blank!";
                }
              },
              onSaved: (e) => username = e,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextFormField(
              onSaved: (e) => password = e,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            MaterialButton(
                onPressed: () {
                  check();
                },
                child: Text("Login"))
          ],
        ),
      ),
    );
  }
}
