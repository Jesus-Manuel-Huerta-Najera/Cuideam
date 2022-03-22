import 'package:cuideam/frases.dart';
import 'package:cuideam/mp3.dart';
import 'package:cuideam/videos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ambiente.dart';

void main() {
  runApp( Menu());
}
class Menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin  {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cuideam"),
        bottom:  TabBar(
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                icon: Icon(Icons.book,color: Colors.white60,),
                text: "Información",
              ),
              Tab(
                icon: Icon(Icons.ac_unit_sharp,color: Colors.white60,),
                text: "Ambiente",
              ),
              Tab(
                icon: Icon(Icons.music_note,color: Colors.white60,),
                text: "Música",
              )
            ]),
        automaticallyImplyLeading: true,),


      body:  TabBarView(
        controller: _tabController,
        children:  [
          Frases(),
          MyAmbiente(),
          Musica()
        ],
      ),


      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text('Descubre también...',style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
              accountEmail: Text('V 0.8.5',style: TextStyle(fontSize: 15,
                fontWeight: FontWeight.bold,
              ),),
              //currentAccountPicture: CircleAvatar(radius:150, child: Image.asset("assets/lago.jpg"),),
              //decoration: const BoxDecoration(
              // color: Colors.blue,
              // ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: const Text('Videos'),
                onTap: () {

                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Video()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: const Text('Salir'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  SystemNavigator.pop();
                },
              ),
            ),
          ],
        ),
      )  ,
    );

  }
}
