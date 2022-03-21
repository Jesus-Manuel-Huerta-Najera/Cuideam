import 'dart:async';
import 'dart:convert';

import 'package:cuideam/videoplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:text_to_speech/text_to_speech.dart';



class Frases extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Myfrases(),
    );
  }
}

class Myfrases extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Myfrases> {
  TextToSpeech tts = TextToSpeech();
  List _items = [];
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/videos.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["Motivacion"];

    });
  }

  void initState() {
    super.initState();
    readJson();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Videos'), actions: [IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => Menu()));})]),
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
                                double volume = 1.0;
                                tts.setVolume(volume);
                                tts.speak(_items[index]["text"]);
                              },
                                subtitle: Text(_items[index]["text"],style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),),
                              trailing: GestureDetector(onTap: (){
                                double volume = 1.0;
                                tts.setVolume(volume);
                                tts.speak(_items[index]["text"]);
                              },child:  const Icon(Icons.volume_up_outlined,color: Colors.black,))

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
