import 'package:flutter/material.dart';

import '../navigations/bottom_nav_bar.dart';
import '../util/constantes.dart';
import 'package:http/http.dart' as http;

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late String? _username;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  //actions
  void ResetPasswordAction() {
    //url
    Uri addUri = Uri.parse("$BASE_URL/user/pwd/$_username");



    //data to send
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    //request
    http
        .patch(addUri, headers: headers)
        .then((response) {
      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, BottomNavScreen.routeName);
      } else if (response.statusCode == 401) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Information"),
              content: const Text("username is incorrect!"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Dismiss"))
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Information"),
              content: const Text("Server error! Try again later"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Dismiss"))
              ],
            );
          },
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Réinitialiser le mot de passe"),
      ),
      body: Form(
        key: _keyForm,
        child: ListView(
          children: [
            Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Image.asset("assets/images/minecraft.jpg", width: 460, height: 215)
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 50, 10, 10),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Username"),
                onSaved: (String? value) {
                  _username = value;
                },
                validator: (String? value) {
                  if(value == null || value.isEmpty) {
                    return "Le username ne doit pas etre vide";
                  }
                  else if(value.length < 5) {
                    return "Le username doit avoir au moins 5 caractères";
                  }
                  else {
                    return null;
                  }
                },
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ElevatedButton(
                  child: const Text("Réinitialiser le mot de passe"),
                  onPressed: () {
                    if(_keyForm.currentState!.validate()) {
                      _keyForm.currentState!.save();
                      ResetPasswordAction();
                    }
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
}
