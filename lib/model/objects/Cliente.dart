class Cliente{
  String codice;
  String nome;

  String cognome;
  String telefono;
  String indirizzo;
  String email;

  Cliente({required this.codice,required this.nome,required this.cognome,required this.telefono,required this.email,required this.indirizzo});

  factory Cliente.fromJson(Map<String,dynamic>json){
    return Cliente(
      codice:json['codice'],
      nome:json['nome'],
      cognome:json['cognome'],
      telefono:json['telefono'],
      indirizzo:json['indirizzo'],
      email:json['email'],
    );
  }

  Map<String,dynamic>toJson()=>{
    'codice':codice,
    'nome':nome,
    'cognome':cognome,
    'telefono':telefono,
    'indirizzo':indirizzo,
    'email':email,
  };

}