import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/model/game.dart';

import '../util/constantes.dart';
import 'element_info.dart';
import 'package:http/http.dart' as http;
class Basket extends StatefulWidget {
  const Basket({Key? key}) : super(key: key);

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  //var
  final List<Game> games = [];
  late Future<bool> fetchedData;

  //actions
  Future<bool> fetchData(String user_id) async {
    //url
    Uri fetchUri = Uri.parse("$BASE_URL/library/$user_id");

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
  @override
  void initState() {
    super.initState();
    fetchedData = fetchData("6398bce84e25681b1b23c052");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text(
                "Total : 500 TND",
                textScaleFactor: 1.5,
              )
            ],
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: const Divider(color: Colors.red)),



                /* ElementInfo(
                    Game("dmc5.jpg", "Devil May Cry 5", 200, quantity: 1)),
                ElementInfo(
                    Game("re8.jpg", "Resident Evil VIII", 200, quantity: 1)),
                ElementInfo(
                    Game("nfs.jpg", "Need For Speed Heat", 200, quantity: 1))
               */
          FutureBuilder(
            future: fetchedData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: games.length,
                    itemBuilder: (context, index) {
                      return ElementInfo(games[index]);
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),


        ],
      ),
    );
  }
}
