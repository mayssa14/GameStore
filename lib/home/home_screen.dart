import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/home/cell.dart';
import 'package:myapp/model/game.dart';
import 'package:myapp/util/constantes.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  //var
  static const String routeName = "/Home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //var
  final List<Game> games = [];
  late Future<bool> fetchedData;

  //actions
  Future<bool> fetchData() async {
    //url
    Uri fetchUri = Uri.parse("$BASE_URL/game");

    //data to send
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    //request
    await http.get(fetchUri, headers: headers).then((response) {
      if (response.statusCode == 200) {
        //Selialization
        List<dynamic> data = json.decode(response.body);
        for (var item in data) {
          games.add(Game(item['_id'], item['image'], item['title'],
              item['description'], item['price'],
              quantity: item['quantity']));
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Information"),
              content: const Text("Server Error! Try agaim later."),
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

    return true;
  }

  //life cycle
  @override
  void initState() {
    super.initState();
    fetchedData = fetchData();
  }

  //build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchedData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  return Cell(games[index]);
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
