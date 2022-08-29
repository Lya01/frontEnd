import 'dart:convert';

import 'Cliente.dart';

Acquisto acquistoFromJson(String s)=>Acquisto.fromJson(json.decode(s));
String purchaseToJson(Acquisto a)=>json.encode(a.toJson());

class Acquisto{
  dynamic id;
  DateTime data_acquisto;
  Cliente acquirente;

  Acquisto({
    this.id,
    required this.data_acquisto,
    required this.acquirente
});

  factory Acquisto.fromJson(Map<String,dynamic>json){
    return Acquisto(
      id:json['id'],
      data_acquisto:DateTime.parse(json['data_acquisto'].split(" ")[0]),
      acquirente:Cliente.fromJson(json["acquirente"]),
    );
  }

  Map<String,dynamic>toJson()=>{
    "id":id,
    "data_acquisto":data_acquisto.toIso8601String(),
    "acquirente":acquirente.toJson(),
  };

  DateTime getDataAcquisto(){
    return data_acquisto;
  }
}
