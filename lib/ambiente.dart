import 'dart:io';
import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';
import 'package:audioplayers/audioplayers.dart';


class Ambiente extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyAmbiente(),
    );
  }
}

class MyAmbiente extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyAmbiente> {
  //Variables de control audio
  AudioCache audioCache = AudioCache();
  AudioPlayer audioPlayer = AudioPlayer();
  ////////
  void musica(path) async {
    //int result = await audioPlayer.play('assets/result.mp3', isLocal: true,volume: 1.0);
    audioCache.play(path);
    print("le di play");
  }
  double _lon = 0;
  double _lat = 0;
  double _tilt = 0;
  int _panoId = 0;
  List<Image> panoImages = [
    //Image.asset('assets/panorama.jpg'),
    Image.asset('assets/panorama2.webp'),
    //Image.asset('assets/panorama_cropped.webp'),
  ];


  void onViewChanged(longitude, latitude, tilt) {
    setState(() {
      _lon = longitude;
      _lat = latitude;
      _tilt = tilt;
    });
  }
  @override
    void initState() {
      super.initState();
      //musica("Weightless.mp3");
    }

  Widget hotspotButton({String? text, IconData? icon, VoidCallback? onPressed}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(CircleBorder()),
            backgroundColor: MaterialStateProperty.all(Colors.black38),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: Icon(icon),
          onPressed: onPressed,
        ),
        text != null
            ? Container(
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Center(child: Text(text)),
        )
            : Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget panorama;
    switch (_panoId % panoImages.length) {
      case 0:
        panorama = Panorama(
          animSpeed: 1.0,
          sensorControl: SensorControl.Orientation,
          onViewChanged: onViewChanged,
          child: panoImages[_panoId % panoImages.length],

        );
        break;
      default:
        panorama = Panorama(
          animSpeed: 1.0,
          sensorControl: SensorControl.Orientation,
          onViewChanged: onViewChanged,
          child: panoImages[_panoId % panoImages.length],

        );
    }
    return Scaffold(

      body: Stack(
        children: [
          panorama,
          //Text('${_lon.toStringAsFixed(3)}, ${_lat.toStringAsFixed(3)}, ${_tilt.toStringAsFixed(3)}'),
        ],
      ),
    );
  }
}
