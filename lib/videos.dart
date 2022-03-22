import 'dart:async';
import 'dart:convert';
import 'package:cuideam/videoplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'menu.dart';

class Video extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Myvideo(),
    );
  }
}

class Myvideo extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Myvideo> {
  List _items = [];
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/videos.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["videos"];

    });
  }

  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Videos'),
        ),
            actions: [ //add
              IconButton(
                  icon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute
                      (builder: (context) => Menu()));
                  }
              )
            ]
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 20)),
              // Display the data loaded from sample.json
              _items.isNotEmpty
                  ? Expanded(
                child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        Card(
                          elevation: 15,
                          color: Colors.lightGreen.shade100,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          margin: const EdgeInsets.only(left: 5, top: 15, right: 5, bottom: 15),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 40.0, top: 40, right: 1, left: 1),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(_items[index]["sab"],style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25
                                    ),),
                                  ),
                                  title: Text(_items[index]["name"],style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20
                                  ),),
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute
                                      (builder: (context) => MyVideoPlayerPage
                                      (_items[index]["text"],_items[index]["name"])));
                                  },
                                  trailing: GestureDetector(onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute
                                      (builder: (context) => MyVideoPlayerPage
                                      (_items[index]["text"],_items[index]["name"])));
                                    print(_items[index]["text"]);
                                  },
                                    child:  Image.asset(_items[index]["img"],
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.contain,

                                    ),
                                    ),),
                              ],
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 15))
                      ],
                    );
                  },
                ),
              )
                  : Container()
            ],
          ),
        ),

    );
  }
}
