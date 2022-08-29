import 'Cliente.dart';

class User{
  Cliente cliente;
  String username;
  String email;
  String password;

  User({required this.cliente,required this.email, required this.username,required this.password});

  Map<String,dynamic>toJson()=>{
    'cliente':cliente.toJson(),
    'username':username,
    'email':email,
    'password':password
  };

  factory User.fromJson(Map<String,dynamic> json){
    return User(
      cliente:Cliente.fromJson(json['cliente']),
      username:json['username'],
      email:json['email'],
      password:json['password']
    );
  }

  @override
  String toString(){
    return email;
  }
}