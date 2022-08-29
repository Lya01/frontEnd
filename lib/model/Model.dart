import 'dart:async';
import 'dart:convert';

import 'package:progectcommerce/model/objects/Acquisto.dart';
import 'package:progectcommerce/model/support/Constants.dart';
import 'package:progectcommerce/model/support/LogInResult.dart';
import 'manager/RestManager.dart';

import 'objects/Autenticazione.dart';
import 'objects/Prodotto.dart';
import 'objects/User.dart';

class Model {
  static Model sharedInstance = Model();

  RestManager _restManager = RestManager();
  late Autenticazione _autenticazione;


  Future<LogInResult> logIn(String email, String password) async {
    try{
      Map<String, String> params = Map();
      params["grant_type"] = "password";
      params["client_id"] = Constants.CLIENT_ID;
      params["client_secret"] = Constants.CLIENT_SECRET;
      params["username"] = email;
      params["password"] = password;
      //chiamo il manager
      String result = await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGIN, params, type: TypeHeader.urlencoded);
      _autenticazione = Autenticazione.fromJson(jsonDecode(result));
      if ( _autenticazione.hasError() ) {
        if ( _autenticazione.error == "Invalid user credentials" ) {
          return LogInResult.error_wrong_credentials;
        }
        else if ( _autenticazione.error == "Account is not fully set up" ) {
          return LogInResult.error_not_fully_setupped;
        }
        else {
          return LogInResult.error_unknown;
        }
      }//if
      _restManager.token = _autenticazione.accessToken;
      Timer.periodic(Duration(seconds: (_autenticazione.expiresIn - 50)), (Timer t) {
        _refreshToken();
      });
      return LogInResult.logged;
    }
    catch (e) {
      return LogInResult.error_unknown;
    }
  }//logIn

  Future<bool> _refreshToken() async {
    try {
      Map<String, String> params = Map();
      params["grant_type"] = "refresh_token";
      params["client_id"] = Constants.CLIENT_ID;
      params["client_secret"] = Constants.CLIENT_SECRET;
      params["refresh_token"] = _autenticazione.refreshToken;
      String result = await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGIN, params, type: TypeHeader.urlencoded);
      _autenticazione = Autenticazione.fromJson(jsonDecode(result));
      if ( _autenticazione.hasError() ) {
        return false;
      }
      _restManager.token = _autenticazione.accessToken;
      return true;
    }
    catch (e) {
      return false;
    }
  }//refreshToken

  Future<bool> logOut() async {
    try{
      Map<String, String> params = Map();
      _restManager.token =""; //null;
      params["client_id"] = Constants.CLIENT_ID;
      params["client_secret"] = Constants.CLIENT_SECRET;
      params["refresh_token"] = _autenticazione.refreshToken;
      await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGOUT, params, type: TypeHeader.urlencoded);
      return true;
    }
    catch (e) {
      return false;
    }
  }//logOut


  Future<List<Prodotto>> getAll(int pageNumber, int pageSize, String sortBy) async {
    Map<String,String> params=Map();
    params["pageNumber"]=pageNumber.toString();
    params["pageSize"]=pageSize.toString();
    params["sortBy"]=sortBy;
    try{
      return List<Prodotto>.from(json.decode(
          await _restManager.makeGetRequest(
              Constants.ADDRESS_STORE_SERVER,
              Constants.REQUEST_SEARCH_PRODUCTS_PAGED,
              params)).map((i) => Prodotto.fromJson(i)).toList());
    }catch(e){
      throw Exception("Errore nella restituzione dei prodotti paged");
    }
  }

  Future<List<Prodotto>?> searchProduct(String name) async {
    Map<String, String> params = Map();
    params["name"] = name;
    try {
      return List<Prodotto>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_SEARCH_PRODUCTS, params)).map((i) => Prodotto.fromJson(i)).toList());
    }
    catch (e) {
      return null; // not the best solution
    }
  }//searchProdotto


  //sei arrivata qui vedi se devi aggiungere getAll()

  Future<User?> addUser(User user) async {
    try {
      String rawResult = await _restManager.makePostRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER, user);
      if ( rawResult.contains(Constants.RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS) ) {
        return null; // not the best solution
      }
      else {
        return User.fromJson(jsonDecode(rawResult));
      }
    }
    catch (e) {
      return null; // not the best solution
    }
  }

  Future<List<Acquisto>> getMyOrdini(String email) async{
    try{
      print("getMyOrdini");
      Map<String,String> params=Map();
      params["email"]=email;
      String res=await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER,Constants.REQUEST_GET_ACQUISTI,params);
      List acquisti=jsonDecode(res);
      print("acquisti: "); print(acquisti);
      List<Acquisto> ret=acquisti.map((e) => new Acquisto.fromJson(e)).toList();
      print("ret: "); print(ret);
      return ret;
    }catch(err){
      print(err);
      return[];

    }
  }//getMyOrdini

  Future<String> registraUtente(User u) async{
    return await _restManager.makePostRequest(Constants.ADDRESS_STORE_SERVER, "/r", u);
  }//registraUtente


}
