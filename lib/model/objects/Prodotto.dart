import 'dart:convert';
Prodotto prodottoFromJson(String s)=>Prodotto.fromJson(json.decode(s));
String prodottoToJson(Prodotto p)=>json.encode(p.toJson());

class Prodotto {

  dynamic id;
  String nome;

  String bar_code;

  String descrizione;

  double prezzo;
  int quantita;



  Prodotto({
    this.id,
    required this.nome,
    required this.bar_code,
    required this.descrizione,
    required this.prezzo,
    required this.quantita,

});

  factory Prodotto.fromJson(Map<String,dynamic> json)=>Prodotto(
    id:json['id'],
      nome:json['nome'],

      bar_code:json['bar_code'],

      descrizione:json['descrizione'],

      prezzo:json['prezzo'],
      quantita:json['quantita'],


  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "bar_code":bar_code,
    "descrizione": descrizione,
    "prezzo": prezzo,
    "quantita": quantita,

  }; //toJson

  @override
  String toString() {
    return 'Prodotto{'
        'id: $id,'
        ' nome: $nome,'
    'bar_code:$bar_code,'
        ' descrizione: $descrizione,'
        ' prezzo: $prezzo,'
        ' quantita: $quantita}';
  }


}