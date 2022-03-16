import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cuideam/videoplayer.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'menu.dart';
import 'player/PlayingControls.dart';
import 'player/PositionSeekWidget.dart';
import 'player/SongsSelector.dart';

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
        appBar: AppBar(title: const Text('Videos'),
            actions: [ //add
              IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute
                      (builder: (context) => Menu()));
                  }
              )
            ]
        ),
        backgroundColor: Colors.blueGrey,
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
                          color: Colors.lightBlueAccent,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Text(_items[index]["sab"],style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25
                                ),),
                                title: Text(_items[index]["name"],style: const TextStyle(
                                    fontWeight: FontWeight.bold,
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
                                },child:  Image.asset(_items[index]["img"],
                                  width: 150, height: 150, fit: BoxFit.contain,),),

                              )
                            ],
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
