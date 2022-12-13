import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/arguments/game_argument.dart';
import 'package:myapp/util/constantes.dart';
import 'package:http/http.dart' as http;

class DetailsScreen extends StatefulWidget {
  //var
  static const String routeName = "/Details";
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  //var

  //actions
  //verify game
  Future<bool> verifyGameOwnership(String user_id, String game_id) async {
    //var
    bool isOwned = false;

    //url
    Uri verifyUri =
        Uri.parse("$BASE_URL/library/$user_id/$game_id");

    //headers
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    //request
    await http.get(verifyUri, headers: headers).then((response) {
      if (response.statusCode == 200) {
        var jsonObject = json.decode(response.body);
        var count = jsonObject['count'];
        if (count > 0) {
          isOwned = true;
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Information"),
              content: const Text("Verify : Server error! Try again later"),
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

    return isOwned;
  }

  //buy game
  Future<bool> buyGame(String user_id, String game_id) async {
    //url
    Uri buyUri = Uri.parse("$BASE_URL/library");

    //headers
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    //Object
    Map<String, dynamic> buyObject = {"user": user_id, "game": game_id};

    //request
    await http
        .post(buyUri, headers: headers, body: json.encode(buyObject))
        .then((response) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Information"),
            content: const Text("Game added to library successfully!"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Dismiss"))
            ],
          );
        },
      );
    }).onError((error, stackTrace) => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Information"),
                  content: const Text("Verify : Server error! Try again later"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Dismiss"))
                  ],
                );
              },
            ));

    return true;
  }

  //build
  @override
  Widget build(BuildContext context) {
    final GameArgument args =
        ModalRoute.of(context)?.settings.arguments as GameArgument;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            //1
            Image.network("$BASE_URL/img/${args.game.image}"),
            const SizedBox(
              height: 20,
            ),
            //2
            Text(
              args.game.description,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 50,
            ),
            //3
            Center(
              child: Text(
                "${args.game.price.floor().toString()} TND",
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
                    "Exemplaires disponible : ${args.game.quantity.toString()}")),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  verifyGameOwnership("61708cdd7ea3ce4718f392a8", args.game.id)
                      .then((isOwned) {
                    if (isOwned) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Information"),
                            content:
                                const Text("Game already added to library!"),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Dismiss"))
                            ],
                          );
                        },
                      );
                    } else {
                      buyGame("61708cdd7ea3ce4718f392a8", args.game.id);
                      setState(() {
                        if (args.game.quantity > 0) {
                          args.game.quantity--;
                        }
                      });
                    }
                  });
                },
                icon: const Icon(CupertinoIcons.shopping_cart),
                label: const Text("Acheter"))
          ],
        ),
      ),
    );
  }
}
