import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wallapaper/screen/category.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List categories = [
    'Nature',
    'Sports',
    'Flower',
    'Person',
    'Places',
    'Food',
    'Adventure',
    'Train',
    'Building',
    'Art',
    'Technology',
    'Illustration',
    'Army',
    'Coding'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Wallapaper"),
      ),
      body: Container(
        child: GridView.builder(
            itemCount: categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return category_page(abc: categories[index]);
                  }));
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  color: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                  child: Center(
                    child: Text(
                      categories[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white70),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
