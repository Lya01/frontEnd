




import 'package:flutter/material.dart';
import 'package:progectcommerce/UI/pages/Home.dart';
import 'package:progectcommerce/UI/pages/Login.dart';
import 'package:progectcommerce/model/support/LogInResult.dart';

import 'Loggato.dart';

class Layout extends StatefulWidget {
  final String title;

  Layout({ Key? key, required  String this.title}) : super(key: key);

  static _LayoutState layout=_LayoutState();


  @override
  _LayoutState createState() => layout;

  static void setLogState(LogInResult log){layout.setLogResult(log);}
}//Layout

class _LayoutState extends State<Layout> {
  String title="BookShop";
  LogInResult logInResult=LogInResult.error_wrong_credentials;

  @override
  Widget build(BuildContext context) {
    print("sono nel build di layout");
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent.shade700,
        shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.vertical(
        bottom:Radius.elliptical(5,5),
    ),
    ),
      title:
      Text(title,style:TextStyle(
    color:Colors.white,
    fontStyle:FontStyle.italic,
    fontWeight:FontWeight.bold,
    fontSize:41,
    )) ,
    actions:<Widget>[
      IconButton(
        icon:const Icon(Icons.person),
        tooltip:"Login",
        onPressed:(){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content:Text("this is a snackbar"))
          );
        }
      ),
      IconButton(
        icon:const Icon(Icons.shopping_cart),
        tooltip:"Cart",
        onPressed:(){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content:Text("This is a cart buttom"))
          );
        }
      )
    ],
    bottom:const TabBar(
    tabs:[
      Tab(text:"All products",icon: Icon(Icons.book)),
      Tab(text:"Search products",icon:Icon(Icons.search_outlined)),
    ],
    ),
    ),


    body:getBody(),
      ),
      
    );
    }

    Widget getBody(){
   return logInResult==LogInResult.logged?
     TabBarView(
       children:[
      Home(),
         Loggato(),
    ]):
       TabBarView(children:[
         Home(),
         Login(),
       ]);
    }

    void setLogResult(LogInResult l){
    setState((){
      this.logInResult=l;
    });
    }
  }//LayoutState



