import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var arrImage = [
      'images/1',
      'images/2',
      'images/3',
    ];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          centerTitle: true,
          title: const Text('Home Page'),
        ),
        body: Column(
          children: <Widget>[
            Text(
              'Featured today',
              style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'Anton',
                  color: Colors.amberAccent[700]),
            ),
            ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  height: 100,
                  child: Card(
                    child: Wrap(
                      children: <Widget>[
                        Image.network(
                            'https://www.google.com/imgres?imgurl=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZDA0OGQxNTItMDZkMC00N2UyLTg3MzMtYTJmNjg3Nzk5MzRiXkEyXkFqcGdeQXVyMjUzOTY1NTc%40._V1_.jpg&imgrefurl=https%3A%2F%2Fwww.imdb.com%2Ftitle%2Ftt0499549%2F&tbnid=mQv7B_XaftjoDM&vet=12ahUKEwimvtqxsYj9AhWswzgGHYOWDQ0QMygAegUIARDgAQ..i&docid=Zn19HiGjooaZRM&w=1965&h=2902&q=avatar&ved=2ahUKEwimvtqxsYj9AhWswzgGHYOWDQ0QMygAegUIARDgAQ'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
