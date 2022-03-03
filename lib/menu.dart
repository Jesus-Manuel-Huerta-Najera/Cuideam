import 'package:flutter/material.dart';

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
         const Center(child: Text("Muy pronto"),),
          MyAmbiente(),
          const Center(child: Text("Muy pronto"),)

        ],
      ),
    );

  }




}
