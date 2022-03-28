import 'package:cuideam/nivelstres.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_to_speech/text_to_speech.dart';




class Encuesta extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyEncuesta(),
    );
  }
}

class MyEncuesta extends StatefulWidget {

  @override
  State<MyEncuesta> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyEncuesta> with TickerProviderStateMixin  {
  final _formKey = GlobalKey<FormState>();
  TextToSpeech tts = TextToSpeech();
  String p1 = "01 ¿Durmes toda la noche de corrido?",
         p2 = "02 ¿Te has mudado recientemente?",
         p3 = "03 ¿Estás decaído y agotado?",
         p4 = "04 ¿Sientes dolores de cabeza con frecuencia?",
         p5 = "05 ¿La vida te resulta una lucha?",
         p6 = "06 ¿Tienes problemas económicos?",
         p7 = "07 ¿Crees que la vida no merece la pena vivirse?",
         p8 = "08 ¿Te has distanciado de algún/a amigo/a?",
         p9 = "09 ¿Sientes a veces que tu cabeza va a estallar?",
         p10 = "10 ¿Ha fallecido recientemente algún familiar muy cercano?",
         p11 = "11 ¿Sientes ansiedad e irritación durante todo el día?";

  bool n11 = false,
      n12 = false;
  bool n21 = false,
      n22 = false;
  bool n31 = false,
      n32 = false;
  bool n41 = false,
      n42 = false;
  bool n51 = false,
      n52 = false;
  bool n61 = false,
      n62 = false;
  bool n71 = false,
      n72 = false;
  bool n81 = false,
      n82 = false;
  bool n91 = false,
      n92 = false;
  bool n101 = false,
      n102 = false;
  bool n111 = false,
      n112 = false;

  int vali1 = 0,
      vali2 = 0,
      vali3 = 0,
      vali4 = 0,
      vali5 = 0,
      vali6 = 0,
      vali7 = 0,
      vali8 = 0,
      vali9 = 0,
      vali10 = 0,
      vali11 = 0;

  int puntos = 0;

  @override
  void initState() {
    super.initState();
    _GetData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover
          )
      ),

      child:  Scaffold(
        backgroundColor: Colors.transparent,
        body:  ListView(
          children: [
            Padding(padding: const EdgeInsets.all(25),
              child: Card(
                elevation: 15,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                margin: const EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 25),


                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset('assets/logo.png',width: 100,),
                        const Text('Nivel de estrés', style: TextStyle(
                            fontWeight:  FontWeight.w700,
                            fontSize: 30,
                            color: Color.fromRGBO(33, 33, 33, 1)
                        ),),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(1),
                      child: const Text('Llena el test y veamos el resultado', style: TextStyle(
                        fontSize: 20,
                        fontWeight:  FontWeight.w300,
                      ),),
                    ),

                    const SizedBox(height: 40,),
                    Padding(padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                        child: Column(
                          children: <Widget> [
                            ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Text(p1,style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                  ),),
                                ),
                                onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p1);
                                },
                                trailing: GestureDetector(onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p1);
                                },
                                    child:  const Icon(Icons.volume_up,color: Colors.grey))

                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    Text("Si"),
                                    Checkbox(
                                      value: n11,
                                      onChanged: (value){
                                        setState(() {
                                          n11 = value!;
                                          n12 = false;
                                          vali1= 1;
                                          puntos = puntos + 2;
                                        });
                                      }
                                  ),
                                   Padding(padding: EdgeInsets.only(left: 10)),
                                    Text("No"),
                                    Checkbox(
                                      value: n12,
                                      onChanged: (value){
                                        setState(() {
                                          n12 = value!;
                                          n11 = false;
                                          vali1= 1;
                                        });
                                      }),
                                ]

                            ),
                            ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Text(p2,style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                  ),),
                                ),
                                onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p2);
                                },
                                trailing: GestureDetector(onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p2);
                                },
                                    child:  const Icon(Icons.volume_up,color: Colors.grey))

                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Si"),
                                  Checkbox(
                                      value: n21,
                                      onChanged: (value){
                                        setState(() {
                                          n21 = value!;
                                          n22 = false;
                                          vali2= 1;
                                          puntos = puntos + 2;
                                        });
                                      }
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Text("No"),
                                  Checkbox(
                                      value: n22,
                                      onChanged: (value){
                                        setState(() {
                                          n22 = value!;
                                          n21 = false;
                                          vali2= 1;
                                        });
                                      }),
                                ]

                            ),
                            ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Text(p3,style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                  ),),
                                ),
                                onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p3);
                                },
                                trailing: GestureDetector(onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p3);
                                },
                                    child:  const Icon(Icons.volume_up,color: Colors.grey))

                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Si"),
                                  Checkbox(
                                      value: n31,
                                      onChanged: (value){
                                        setState(() {
                                          n31 = value!;
                                          n32 = false;
                                          vali3= 1;
                                          puntos = puntos + 2;
                                        });
                                      }
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Text("No"),
                                  Checkbox(
                                      value: n32,
                                      onChanged: (value){
                                        setState(() {
                                          n32 = value!;
                                          n31 = false;
                                          vali3= 1;
                                        });
                                      }),
                                ]

                            ),
                            ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Text(p4,style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                  ),),
                                ),
                                onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p4);
                                },
                                trailing: GestureDetector(onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p4);
                                },
                                    child:  const Icon(Icons.volume_up,color: Colors.grey))

                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Si"),
                                  Checkbox(
                                      value: n41,
                                      onChanged: (value){
                                        setState(() {
                                          n41 = value!;
                                          n42 = false;
                                          vali4= 1;
                                          puntos = puntos + 2;
                                        });
                                      }
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Text("No"),
                                  Checkbox(
                                      value: n42,
                                      onChanged: (value){
                                        setState(() {
                                          n42 = value!;
                                          n41 = false;
                                          vali4= 1;
                                        });
                                      }),
                                ]

                            ),
                            ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Text(p5,style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                  ),),
                                ),
                                onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p5);
                                },
                                trailing: GestureDetector(onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p5);
                                },
                                    child:  const Icon(Icons.volume_up,color: Colors.grey))

                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Si"),
                                  Checkbox(
                                      value: n51,
                                      onChanged: (value){
                                        setState(() {
                                          n51 = value!;
                                          n52 = false;
                                          vali5= 1;
                                          puntos = puntos + 2;
                                        });
                                      }
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Text("No"),
                                  Checkbox(
                                      value: n52,
                                      onChanged: (value){
                                        setState(() {
                                          n52 = value!;
                                          n51 = false;
                                          vali5= 1;
                                        });
                                      }),
                                ]

                            ),
                            ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Text(p6,style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                  ),),
                                ),
                                onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p6);
                                },
                                trailing: GestureDetector(onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p6);
                                },
                                    child:  const Icon(Icons.volume_up,color: Colors.grey))

                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Si"),
                                  Checkbox(
                                      value: n61,
                                      onChanged: (value){
                                        setState(() {
                                          n61 = value!;
                                          n62 = false;
                                          vali6= 1;
                                          puntos = puntos + 2;
                                        });
                                      }
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Text("No"),
                                  Checkbox(
                                      value: n62,
                                      onChanged: (value){
                                        setState(() {
                                          n62 = value!;
                                          n61 = false;
                                          vali6= 1;
                                        });
                                      }),
                                ]

                            ),
                            ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Text(p7,style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                  ),),
                                ),
                                onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p7);
                                },
                                trailing: GestureDetector(onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p7);
                                },
                                    child:  const Icon(Icons.volume_up,color: Colors.grey))

                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Si"),
                                  Checkbox(
                                      value: n71,
                                      onChanged: (value){
                                        setState(() {
                                          n71 = value!;
                                          n72 = false;
                                          vali7= 1;
                                          puntos = puntos + 2;
                                        });
                                      }
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Text("No"),
                                  Checkbox(
                                      value: n72,
                                      onChanged: (value){
                                        setState(() {
                                          n72 = value!;
                                          n71 = false;
                                          vali7= 1;
                                        });
                                      }),
                                ]

                            ),
                            ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Text(p8,style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                  ),),
                                ),
                                onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p8);
                                },
                                trailing: GestureDetector(onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p8);
                                },
                                    child:  const Icon(Icons.volume_up,color: Colors.grey))

                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Si"),
                                  Checkbox(
                                      value: n81,
                                      onChanged: (value){
                                        setState(() {
                                          n81 = value!;
                                          n82 = false;
                                          vali8= 1;
                                          puntos = puntos + 2;
                                        });
                                      }
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Text("No"),
                                  Checkbox(
                                      value: n82,
                                      onChanged: (value){
                                        setState(() {
                                          n82 = value!;
                                          n81 = false;
                                          vali8= 1;
                                        });
                                      }),
                                ]

                            ),
                            ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Text(p9,style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                  ),),
                                ),
                                onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p9);
                                },
                                trailing: GestureDetector(onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p9);
                                },
                                    child:  const Icon(Icons.volume_up,color: Colors.grey))

                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Si"),
                                  Checkbox(
                                      value: n91,
                                      onChanged: (value){
                                        setState(() {
                                          n91 = value!;
                                          n92 = false;
                                          vali9= 1;
                                          puntos = puntos + 2;
                                        });
                                      }
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Text("No"),
                                  Checkbox(
                                      value: n92,
                                      onChanged: (value){
                                        setState(() {
                                          n92 = value!;
                                          n91 = false;
                                          vali9= 1;
                                        });
                                      }),
                                ]

                            ),
                            ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Text(p10,style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                  ),),
                                ),
                                onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p10);
                                },
                                trailing: GestureDetector(onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p10);
                                },
                                    child:  const Icon(Icons.volume_up,color: Colors.grey))

                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Si"),
                                  Checkbox(
                                      value: n101,
                                      onChanged: (value){
                                        setState(() {
                                          n101 = value!;
                                          n102 = false;
                                          vali10= 1;
                                          puntos = puntos + 2;
                                        });
                                      }
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Text("No"),
                                  Checkbox(
                                      value: n102,
                                      onChanged: (value){
                                        setState(() {
                                          n102 = value!;
                                          n101 = false;
                                          vali10= 1;
                                        });
                                      }),
                                ]

                            ),
                            ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Text(p11,style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                  ),),
                                ),
                                onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p11);
                                },
                                trailing: GestureDetector(onTap: (){
                                  double volume = 1.0;
                                  tts.setVolume(volume);
                                  tts.speak(p11);
                                },
                                    child:  const Icon(Icons.volume_up,color: Colors.grey))

                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Si"),
                                  Checkbox(
                                      value: n111,
                                      onChanged: (value){
                                        setState(() {
                                          n111 = value!;
                                          n112 = false;
                                          vali11= 1;
                                          puntos = puntos + 2;
                                        });
                                      }
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Text("No"),
                                  Checkbox(
                                      value: n112,
                                      onChanged: (value){
                                        setState(() {
                                          n112 = value!;
                                          n111 = false;
                                          vali11= 1;
                                        });
                                      }),
                                ]

                            ),
                            ],
                        ),

                    ),

                    const SizedBox(height: 60,),
                    InkWell(
                      onTap: (){
                        if( vali1 == 1 && vali2 == 1 && vali3 == 1 && vali4 == 1 && vali5 == 1
                            && vali6 == 1 && vali7 == 1 && vali8 == 1 && vali9 == 1 && vali10 == 1 && vali11 == 1){
                            _putData(puntos.toDouble());
                            Navigator.of(context).push(MaterialPageRoute
                              (builder: (context) => Nivel()));
                        }else {
                          mensaje();
                        }
                      },

                      child: Container(
                        margin: const EdgeInsets.only(top: 0, left: 55, right: 55, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Text('Guardar', style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black
                              ),
                              ),
                            )
                          ],
                        ),

                        decoration:  BoxDecoration(
                          color: Colors.lightGreen.shade100,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

  }
  mensaje(){
    double volume = 1.0;
    tts.setVolume(volume);
    tts.speak("No lleno una pregunta");
    Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(10),
      borderRadius: 10,
      icon: const Icon(
        Icons.check,
        color: Colors.greenAccent,
      ),
      title:  "Error",
      message:  "No lleno una pregunta",
      duration:   Duration(seconds: 5),
    ).show(context);
  }
  Future<void> _GetData() async {
    final sharedprefs = await SharedPreferences.getInstance();
    double punto = sharedprefs.getDouble('puntos') ?? 30;
    setState(() {
      if(  30 == punto ){
        print("te faltan datos");
      }else{
        print("todo bien");
      }
    });
  }
  Future<void> _putData(double puntos) async {
    final sharedprefs = await SharedPreferences.getInstance();
    await sharedprefs.setDouble("puntos", puntos);
    //setState(() {Navigator.of(context).push(MaterialPageRoute(builder: (context) => introduction()),);});
  }
  }


