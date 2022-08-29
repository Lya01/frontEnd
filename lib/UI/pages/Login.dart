
import 'package:flutter/material.dart';
import 'package:progectcommerce/UI/pages/Home.dart';
import 'package:progectcommerce/UI/pages/Layout.dart';
import 'package:progectcommerce/model/support/Constants.dart';
import 'package:progectcommerce/model/support/LogInResult.dart';
import '../../model/Model.dart';
import '../../model/objects/Cliente.dart';
import '../../model/objects/User.dart';

class Login extends StatefulWidget{
  Login({Key? key}):super(key:key);

  @override
  _LoginState createState()=>_LoginState();
}//login

enum page{
  login,registration,logging
}

//pagina di Login per utenti già registrati
class _LoginState extends State<Login>{
  Text _avviso=Text("");
  page p=page.login;
  bool _passwordVisible=false;//bool sta per boolean

//controller di testo che viene modificato, così che siamo al corrente di ciò che digita l'utente

TextEditingController _controllerEmail=TextEditingController();
TextEditingController _controllerPass=TextEditingController();

  TextEditingController _regControllerEmail=TextEditingController();
  TextEditingController _regControllerUser=TextEditingController();
  TextEditingController _regControllerPass=TextEditingController();
  TextEditingController _regControllerNome=TextEditingController();
  TextEditingController _regControllerCognome=TextEditingController();
  TextEditingController _regControllerTelefono=TextEditingController();
  TextEditingController _regControllerIndirizzo=TextEditingController();
  TextEditingController _regControllerCf=TextEditingController();

  @override
  Widget build(BuildContext context){
    return p==page.login?
    _LoginPage():
        p==page.registration?
            _UserRegister():
            const Center(
              child:SizedBox(
                width:50,
                height:50,
                child:CircularProgressIndicator()
              ),
            );
  }//build

Widget _LoginPage(){
    return Scaffold(
      body:SingleChildScrollView(
        child:Container(
          height:MediaQuery.of(context).size.height,
          width:MediaQuery.of(context).size.width,
          decoration:BoxDecoration(
            gradient:LinearGradient(
              begin:Alignment.topLeft,
              end:Alignment.bottomRight,
              colors:[
                Color(0xFFBA68C8),
                Color(0xFF9C27B0),
                Color(0xFF6A1B9A),
              ]
            )
          ),
          child:Column(
            crossAxisAlignment:CrossAxisAlignment.
              center,
            children:[
              SizedBox(height:100,),
              Icon(Icons.login,size:31),
              SizedBox(height:15,),
              Text('BookShop',
              style:TextStyle(
                color:Colors.white,
                fontSize:29,
                fontStyle:FontStyle.italic,
                fontWeight:FontWeight.bold,
              ),),
              SizedBox(height:30,),
              Container(
                height:480,
                width:325,
                decoration:BoxDecoration(
                  color:Colors.purple.shade50,
                  borderRadius:BorderRadius.circular(10)
                ),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height:30,),
                    Text('Welcome',
                    style:TextStyle(
                      fontSize: 35,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height:10,),
                    Text('Log into your Account',
                    style:TextStyle(
                      fontSize:15,
                      color:Colors.black87,
                    ),),
                    SizedBox(height:20,),
                    Container(
                      width:250,
                      child:TextFormField(
                        validator:(input)=>!input!.contains("@")
                            ?"enter a valid email"
                            :null,
                        decoration:InputDecoration(
                          labelText:"Email Address",
                          suffixIcon: Icon(
                            Icons.email,
                            size:17,
                          ),
                        ),
                        controller:_controllerEmail,
                      ),
                    ),
                    Container(
                      width:250,
                      child:TextFormField(
                        validator:(input)=>
                            input==null?"enter a password":null,
                        obscureText:!_passwordVisible,
                        decoration:InputDecoration(
                          labelText:'Password',
                          hintText: 'enter your password',
                          suffixIcon:IconButton(
                            icon:Icon(
                              //cambio l'icon in base alla visibilità della password
                              _passwordVisible
                              ?Icons.remove_red_eye
                                  :Icons.remove_red_eye_outlined,
                              size:17,
                            ),
                            onPressed:(){
                              //Aggiorno lo stato ad ogni click dell'utente
                              setState((){
                                _passwordVisible=!_passwordVisible;
                              });
                            },
                          ),
                        ),
                        controller:_controllerPass,
                        onFieldSubmitted:login,
                      ),
                    ),
                    SizedBox(height:20,),
                    GestureDetector(
                      onTap:()=>{loginDc()},
                      child:Container(
                        alignment: Alignment.center,
                          width:250,
                          decoration:BoxDecoration(
                            borderRadius:BorderRadius.circular(50),
                            gradient:LinearGradient(
                              begin:Alignment.centerLeft,
                              end:Alignment.centerRight,
                              colors:[
                                Color(0xFF00ACC1),
                                Color(0xFF4DD0E1),
                                Color(0xFF006064),
                              ]
                            )
                          ),
                        child:Padding(
                          padding:EdgeInsets.all(13.0),
                          child:Text('Login',
                            style:TextStyle(
                              color:Colors.white,
                              fontSize:20,
                              fontWeight: FontWeight.bold
                            ),
                              ),
                        ),
                      ),
                    ),
                    SizedBox(height:30,),
                    Text('If you are not registered yet, Register!',
                    style:TextStyle(
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height:20,),
                    GestureDetector(
                      onTap:(){
                        setState((){p=page.registration;});
                      },
                      child:Container(
                        alignment:Alignment.center,
                        width:250,
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient:LinearGradient(
                            begin:Alignment.centerLeft,
                            end:Alignment.centerRight,
                            colors:[
                              Color(0xFFFFFF00),
                              Color(0xFFFFFF8D),
                              Color(0xFFFFD600),
                            ]
                          )
                        ),
                        child:Padding(
                          padding:EdgeInsets.all(13.0),
                          child:Text('Sign Up',
                          style:TextStyle(
                            color:Colors.white,
                            fontSize:20,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
}//loginPage

  void login(String s){
    loginDc();
  }//login

  void loginDc() async{
    setState((){
      p=page.logging;
    });
    LogInResult result=await Model.sharedInstance.logIn(_controllerEmail.text,_controllerPass.text);
    if(result==LogInResult.logged){
      Constants.EMAIL=_controllerEmail.text;
      print("Constants:"+Constants.EMAIL);
      setState((){
        p=page.login;
      });
      Layout.setLogState(LogInResult.logged);
      print("Hai effettuato l'accesso");

    }else{
      setState((){
        p=page.login;
        _avviso=const Text(
          "Error! Try login again",
          style:TextStyle(
            color:Colors.red
          ),
        );
      });
    }//loginDc


  }

Widget _UserRegister(){
  print("USERREGISTRATION");
  return Scaffold(
      body: SingleChildScrollView(
      child: Container(
      height: MediaQuery.of(context).size.height,
  width: MediaQuery.of(context).size.width,
  decoration: BoxDecoration(
  gradient: LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
  Color(0xFFFFCDD2),
  Color(0xFFE57373),
  Color(0xFFEF5350),
  ],
  ),
  ),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
  SizedBox(height: 100),
  Icon(Icons.door_back_door_outlined,size: 31),
  SizedBox(height: 15,),
  Text('Registrati',
  style: TextStyle(
  color: Colors.black87,
  fontSize: 31,
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.bold,
  ),
  ),
  SizedBox(height: 30,),
  Container(
  height: 530,
  width: 325,
  decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(17)
  ),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
  SizedBox(height: 20,),
  Container(
  width: 250,
  child: TextFormField(
  decoration: InputDecoration(
  labelText: 'Codice Fiscale',
  ),
  controller: _regControllerCf,
  ),
  ),
  SizedBox(height: 5,),
  Container(
  width: 250,
  child: TextFormField(
  decoration: InputDecoration(
  labelText: 'Nome',
  ),
  controller: _regControllerNome,
  ),
  ),
  Container(
  width: 250,
  child: TextFormField(
  decoration: InputDecoration(
  labelText: 'Cognome',
  ),
  controller: _regControllerCognome,
  ),
  ),
  Container(
  width: 250,
  child: TextFormField(
  decoration: InputDecoration(
  labelText: 'Telefono',
  ),
  controller: _regControllerTelefono,
  ),
  ),
  Container(
  width: 250,
  child: TextFormField(
  decoration: InputDecoration(
  labelText: 'Indirizzo',
  ),
  controller: _regControllerIndirizzo,
  ),
  ),
  Container(
  width: 250,
  child: TextFormField(
  validator: (input) => !input!.contains("@")
  ? "Enter valid email"
      : null,
  decoration: InputDecoration(
  labelText: 'Email',
  suffixIcon: Icon(
  Icons.email,
  size:17,
  ),
  ),
  controller: _regControllerEmail,
  ),
  ),
  Container(
  width: 250,
  child: TextFormField(
  decoration: InputDecoration(
  labelText: 'Username',
  suffixIcon: Icon(
  Icons.person,
  size: 17,
  ),
  ),
  controller: _regControllerUser,
  ),
  ),

  Container(
  width: 250,
  child: TextFormField(
  validator: (input) =>
  input == null ? "Enter a password" : null,
  obscureText: !_passwordVisible,
  decoration: InputDecoration(
  labelText: 'Password',
  hintText: 'Enter your password',
  suffixIcon: IconButton(
  icon: Icon(
  //Cambio l'icon in base alla visibilità della password
  _passwordVisible
  ?Icons.remove_red_eye_outlined
      :Icons.remove_red_eye,
  size:17,
  ),
  onPressed: () {
  //Aggiorno lo stato ad ogni click dell'utente
  setState(() {
  _passwordVisible=!_passwordVisible;
  });
  },
  ),
  ),
  controller: _regControllerPass,
  onFieldSubmitted: registrati,
  ),
  ),
  SizedBox(height: 20,),
  GestureDetector(
  onTap: () => {registratiDc()},
  child: Container(
  alignment: Alignment.center,
  width: 250,
  decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(50),
  gradient: LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
  Color(0xFF69F0AE),
  Color(0xFF00E676),
  Color(0xFF00C853),
  ]
  )
  ),
    child: Padding(
      padding: EdgeInsets.all(13.0),
      child: Text('Registrati',
        style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
      ),
    ),
  ),
  ),
  ],//children
  ),
  ),
  ],//children
  ),
      ),
      ),
  );

}//userRegister

  void registrati(String s){
    registratiDc();
  }//registrati

  void registratiDc() {
    setState(() {
      p = page.logging;
    });
    User u = User(
        email: _regControllerEmail.text,
        username: _regControllerUser.text,
        password: _regControllerPass.text,
        cliente: Cliente(
            codice: _regControllerCf.text,
            nome: _regControllerNome.text,
            cognome: _regControllerCognome.text,
            indirizzo: _regControllerIndirizzo.text,
            email: _regControllerEmail.text,
            telefono: _regControllerTelefono.text
        )
    );
    Model.sharedInstance.registraUtente(u).then((value) {
      if (value.compareTo("registrazione completata") == 0) {
        setState(() {
          _regControllerCf.clear();
          _regControllerNome.clear();
          _regControllerCognome.clear();
          _regControllerTelefono.clear();
          _regControllerIndirizzo.clear();
          _regControllerEmail.clear();
          _regControllerUser.clear();
          _regControllerPass.clear();
          _avviso = Text("");
          p = page.login;
        });
      } else {
        setState(() {
          p = page.registration;
          _avviso = const Text(
            "Error in registration",
            style: TextStyle(
                color: Colors.red
            ),
          );
        });
      }
    }); //registraUtente
  }








}