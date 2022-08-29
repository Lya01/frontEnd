



import 'package:flutter/material.dart';
import 'package:progectcommerce/UI/pages/Layout.dart';
import 'package:progectcommerce/model/support/Constants.dart';

class App extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    print('Sono nel build di app');
    return MaterialApp(
      title: Constants.APP_NAME,

      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent.shade700,
        //backgroundColor: Colors.deepOrangeAccent.shade400,
        //buttonColor: Colors.deepOrangeAccent,
      ),
      debugShowCheckedModeBanner: false,
      /*darkTheme: ThemeData(
        primaryColor: Colors.lightGreenAccent,
        backgroundColor: Colors.black,
        canvasColor: Colors.black,
        buttonColor: Colors.lightGreenAccent.shade400,
        cardColor: Colors.grey[800],
      ),*/
      home: Layout(title: Constants.APP_NAME),

    );
  }//build


}//app


