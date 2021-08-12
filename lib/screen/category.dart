import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallapaper/screen/fullscreen.dart';

// ignore: camel_case_types
class category_page extends StatefulWidget {
  final String abc;
  const category_page({Key? key, required this.abc}) : super(key: key);

  @override
  _category_pageState createState() => _category_pageState();
}

// ignore: camel_case_types
class _category_pageState extends State<category_page> {
  List images = [];
  int pages = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchapi();
  }

  Future fetchapi() async {
    String categoryName = widget.abc;
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$categoryName&per_page=80"),
        headers: {
          "Authorization":
              "563492ad6f917000010000015caa9c29641441a18871d61256afe82d"
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
      print(images[0]);
    });
  }

  // ignore: non_constant_identifier_names
  load_more() async {
    String categoryName = widget.abc;
    setState(() {
      pages = pages + 1;
    });
    String url =
        "https://api.pexels.com/v1/search?query=$categoryName&per_page=80+page=" +
            pages.toString();
    await http.get(Uri.parse(url), headers: {
      "Authorization":
          "563492ad6f917000010000015caa9c29641441a18871d61256afe82d"
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 28.0, bottom: 3, left: 10, right: 0),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    widget.abc,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
            child: Container(
          child: GridView.builder(
              itemCount: images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 2,
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 2),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FullScreen(
                          image_url: images[index]['src']['large2x']);
                    }));
                  },
                  child: Container(
                      margin: EdgeInsets.all(5),
                      color: Colors.white,
                      child: Image.network(
                        images[index]['src']['tiny'],
                        fit: BoxFit.cover,
                      )),
                );
              }),
        )),
        GestureDetector(
          onTap: () {
            load_more();
          },
          child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.black,
              child: Center(
                child: Text('Load More',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    )),
              )),
        )
      ],
    );
  }
}
