import 'package:flutter/material.dart';

class Home extends StatefulWidget {


  Home({Key ?key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    print("sono nel build di Home");
    return Scaffold(
      body:Center(
      child: Column(
        children:[
          Padding(
            padding:EdgeInsets.fromLTRB(0,10,0,10),
            child:Text(
              'BookShop...buy your books online',
              style:TextStyle(
                fontSize:31,
                color:Theme.of(context).primaryColor,
              ),
            ),
          ),
        top(),
        ],
      )

      ),
    );
  }

  Widget top() {

    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
    child: Row(

    children:[Container(
      margin: const EdgeInsets.all(10),
      color:Colors.amber[600],
      width:48.0,
      height:48.0,
    ),
      const Icon(
      Icons.audiotrack,
        color:Colors.green,
        size:30.0,
      ),
    ],
    ),
  );
  }
}