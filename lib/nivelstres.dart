import 'package:cuideam/encuesta.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'menu.dart';
class Nivel extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyNivel(),
    );
  }
}

class MyNivel extends StatefulWidget {

  @override
  State<MyNivel> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyNivel> with TickerProviderStateMixin {

    double puntos = 0;
    double sin = 0;
    String txt = "";

    Future<void> _GetData() async {
      final sharedprefs = await SharedPreferences.getInstance();
      double punto = sharedprefs.getDouble('puntos') ?? 30;
      setState(() {
        if (punto == 30) {
          puntos = 30;
          print("aqui");
          txt = "";
        }
        else if (punto == 30) {
          print("te faltan datos");
        } else {
          print("todo bien");
          if (punto >= 0 && punto <= 10) {
            txt = "Estrés moderado";
            puntos = .3;
            sin = .6;
          } else if (punto >= 11 && punto <= 20) {
            txt = "Estrés intenso";
            puntos = .6;
            sin = .3;
          } else {
            txt = "Estrés muy intenso";
            puntos = .9;
            sin = .1;
          }
        }
      });
    }
    @override
    void initState() {
      super.initState();
      _GetData();
    }
    @override
    Widget build(BuildContext context) {
      List<_PieData> data = [
        _PieData("" + puntos.toString()+"%", puntos, "Estrés"),
        _PieData("" + sin.toString()+"%", sin, "Alivio"),
      ];
      return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover
            )
        ),

        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              Padding(padding: const EdgeInsets.all(25),
                child: Card(
                  elevation: 15,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  margin: const EdgeInsets.only(
                      left: 5, top: 10, right: 5, bottom: 25),


                  child: puntos == 30 ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40,),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15, top: 1, right: 15, bottom: 15),
                          child: const Text(
                            'No hay información', style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 30,
                              color: Color.fromRGBO(33, 33, 33, 1)
                          ),),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          child: const Text(
                            'Estas a un botón de saber tu nivel de estrés',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),),
                        ),
                        const SizedBox(height: 40,),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute
                              (builder: (context) => Encuesta()));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 5, left: 55, right: 55, bottom: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Padding(padding: EdgeInsets.all(15),
                                  child: Text(
                                    'Hagamos tu test', style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black
                                  ),),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Colors.lightGreen.shade300,
                              borderRadius: BorderRadius.circular(25),
                            ),

                          ),
                        ),
                      ]): Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 15, top: 10, right: 15, bottom: 0),
                        child: const Text('Tienes un:', style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                            color: Color.fromRGBO(33, 33, 33, 1)
                        ),),
                      ),

                      Container(
                        padding: const EdgeInsets.all(1),
                        child: Text(txt, style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),),
                      ),

                      const SizedBox(height: 40,),
                      Padding(padding: EdgeInsets.symmetric(
                          vertical: 0, horizontal: 30),

                          child: Column(
                            children: <Widget>[
                              SfCircularChart(
                                  title: ChartTitle(text: 'Nivel de estrés'),
                                  legend: Legend(isVisible: true),
                                  series: <PieSeries<_PieData, String>>[
                                    PieSeries<_PieData, String>(
                                        explode: true,
                                        explodeIndex: 0,
                                        dataSource: data,
                                        xValueMapper: (_PieData data, _) =>
                                        data.xData,
                                        yValueMapper: (_PieData data, _) =>
                                        data.yData,
                                        dataLabelMapper: (_PieData data,
                                            _) => data.text,
                                        dataLabelSettings: DataLabelSettings(
                                            isVisible: true)),
                                  ]
                              )
                            ],
                          )
                      ),


                      const SizedBox(height: 20,),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute
                            (builder: (context) => Menu()));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 5, left: 55, right: 55, bottom: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(padding: EdgeInsets.all(15),
                                child: Text('Regresar', style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black
                                ),),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.lightGreen.shade300,
                            borderRadius: BorderRadius.circular(25),
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

class _PieData {
  _PieData(this.xData, this.yData, this.text);
  final String xData;
  final num yData;
  final String text;
}
