import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {
  // app info
  static final String APP_VERSION = "0.0.1";
  static final String APP_NAME = "BookShop";

  // addresses
  static final String ADDRESS_STORE_SERVER = "localhost:8000";
  static final String ADDRESS_AUTHENTICATION_SERVER = "localhost:8080";

  // authentication
  static final String REALM = "***";
  static final String CLIENT_ID = "***";
  static final String CLIENT_SECRET = "***";
  static final String REQUEST_LOGIN = "/auth/realms/" + REALM + "/protocol/openid-connect/token";
  static final String REQUEST_LOGOUT = "/auth/realms/" + REALM + "/protocol/openid-connect/logout";

  // requests
  static final String REQUEST_SEARCH_PRODUCTS = "/products/search/by_name";
  static final String REQUEST_ADD_USER = "/users";
  static final String REQUEST_GET_ACQUISTI="/acquisto/getAcquisti";
  static final String REQUEST_SEARCH_PRODUCTS_PAGED = "/prodotti/getAll/paged" ;


  // states
  static final String STATE_CLUB = "club";
  static const int PAGE_LIMIT=10;

  // responses
  static final String RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS = "ERROR_MAIL_USER_ALREADY_EXISTS";
  static final String RESPONSE_ERROR_USER_NOT_FOUND="ERROR_USER_NOT_FOUND";
  static final String RESPONSE_ERROR_QUANTITY_PRODUCT_UNAVAILABLE="ERROR_QUANTITY_PRODUCT_UNAVAILABLE";
  static final String RESPONSE_ERROR_PRODUCT_NOT_FOUND="ERROR_PRODUCT_NOT_FOUND";
  static final String RESPONSE_ERROR_CART_IS_EMPTY = "CartIsEmptyException";
  static String EMAIL="";

  // messages
  static final String MESSAGE_CONNECTION_ERROR = "connection_error";

  //color
static final textColor=Colors.black;
  static final textLightColor=Colors.white;



}