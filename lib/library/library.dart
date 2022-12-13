import 'package:flutter/material.dart';
import 'package:myapp/model/game.dart';
import 'package:myapp/library/grid_cell.dart';

class GridHome extends StatefulWidget {
  GridHome({super.key});
  //var
  final List<Game> games = [
/*     Game("dmc5.jpg", "Devil May Cry 5", 200, quantity: 1),
    Game("fifa.jpg", "Fifa 22", 220, quantity: 1),
    Game("minecraft.jpg", "Minecraft", 150, quantity: 1),
    Game("nfs.jpg", "Need For Speed", 100, quantity: 1),
    Game("rdr2.jpg", "Red Dead 2", 150, quantity: 1),
    Game("re8.jpg", "Resident Evil 8", 120, quantity: 1) */
  ];

  @override
  State<GridHome> createState() => _GridHomeState();
}

class _GridHomeState extends State<GridHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
          itemCount: widget.games.length,
          itemBuilder: (context, index) {
            return GridCell(widget.games[index]);
          }),

      /* GridView.count(crossAxisCount: 2, children: [
        //1
        GridCell(
          Game("dmc5.jpg", "Devil May Cry 5", 200),
        ),
        //2
        GridCell(
          Game("fifa.jpg", "Fifa 22", 220),
        ),
        //3
        GridCell(
          Game("minecraft.jpg", "Minecraft", 150),
        ),
        //4
        GridCell(
          Game("nfs.jpg", "Need For Speed", 100),
        ),
      ]), */
    );
  }
}
