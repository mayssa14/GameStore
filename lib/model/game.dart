import 'package:flutter/material.dart';

class Game {
  //att
  final String id;
  final String image;
  final String title;
  final String description;
  final int price;
  late int quantity;

  //constuctor
  Game(this.id, this.image, this.title, this.description, this.price,
      {required this.quantity});
}
