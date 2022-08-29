import 'dart:convert';

import 'Acquisto.dart';
import 'Prodotto.dart';
import 'Cliente.dart';

ProdottoAcquistato acquistoFromJson(String s)=>ProdottoAcquistato.fromJson(json.decode(s));
String acquistoToJson(ProdottoAcquistato p)=>json.encode(p.toJson());

class ProdottoAcquistato{
  dynamic id;
  Acquisto acquisto;
  int quantita;
  Prodotto prodotto;

  ProdottoAcquistato({
    this.id,
    required this.acquisto,
    required this.quantita,
    required this.prodotto
});

  Map<String,dynamic>toJson()=>{
    "id":id,
    "acquisto":acquisto.toJson(),
    "quantita":quantita,
    "prodotto":prodotto.toJson(),
  };

  factory ProdottoAcquistato.fromJson(Map<String,dynamic>json)=>ProdottoAcquistato(
    id:json['id'],
    acquisto:Acquisto.fromJson(json['acquisto']),
    quantita:json['quantita'],
    prodotto:Prodotto.fromJson(json['prodotto']),
  );
}