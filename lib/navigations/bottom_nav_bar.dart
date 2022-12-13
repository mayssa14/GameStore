import 'package:flutter/material.dart';
import 'package:myapp/basket/basket.dart';
import 'package:myapp/home/home_screen.dart';
import 'package:myapp/library/library.dart';
import 'package:myapp/navigations/tab_bar.dart';

class BottomNavScreen extends StatefulWidget {
  static const String routeName = "/BottomNav";
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  //var
  int index = 0;
  List<Widget> interfaces = [const HomeScreen(), GridHome(), const Basket()];
  //build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("G-Esprit Store"),
      ),
      drawer: Drawer(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("WELCOME BACK"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                //1
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      //1
                      Icon(Icons.edit),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Modifier profil"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                //2
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, CustomTabbar.routeName);
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      //1
                      Icon(Icons.navigation_outlined),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Navigation par Tabbar"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: const [
            //1
            BottomNavigationBarItem(
                icon: Icon(Icons.storefront_outlined), label: "Store"),
            //2
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_added_outlined), label: "Library"),
            //3
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket_outlined), label: "Basket"),
          ]),
      body: interfaces[index],
    );
  }
}
