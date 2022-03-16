import 'package:cuideam/mp3.dart';
import 'package:cuideam/videos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ambiente.dart';

class Menu extends StatelessWidget {


  // This widget is the root of your application.
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
        title: const Text("Bienvenido"),
        bottom:  TabBar(
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                icon: Icon(Icons.book,color: Colors.black,),
                text: "Información",
              ),
              Tab(
                icon: Icon(Icons.art_track,color: Colors.black,),
                text: "Ambiente",
              ),
              Tab(
                icon: Icon(Icons.music_note,color: Colors.black,),
                text: "Música",
              )
            ]),
        automaticallyImplyLeading: true,),


      body:  TabBarView(
        controller: _tabController,
        children:  [
          const Center(child:  Text("Muy pronto..."),),
          MyAmbiente(),
          Musica()

        ],
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
           const UserAccountsDrawerHeader(
              accountName: const Text('Más que ver',style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
              accountEmail: const Text('V 0.6.4',style: TextStyle(fontSize: 15,
                fontWeight: FontWeight.bold,
              ),),
              //currentAccountPicture: CircleAvatar(radius:150, child: Image.asset("assets/lago.jpg"),),
              //decoration: const BoxDecoration(
               // color: Colors.blue,
             // ),
            ),


            ListTile(
              title: const Text('Videos'),
              onTap: () {

                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Video()),
                );
              },
            ),
            ListTile(
              title: const Text('Salir'),
              onTap: () {
                // Update the state of the app.
                // ...
                SystemNavigator.pop();
              },
            ),
          ],
        ),
      )  ,
    );

  }




}
