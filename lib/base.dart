import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://miguelcardoso.pythonanywhere.com/';
const api = '/post';
const get1 = '/get';

class BaseClient {
  var client = http.Client();

  Future<dynamic> post(dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);

    var response = await client.post(url, body: _payload);
    //debugPrint(response.body);
    return response.body;
  }

  Future<dynamic> get() async {
    var url = Uri.parse(baseUrl + get1);
    var response = await client.get(url);
    var teste = json.decode(response.body);
    return teste;
  }
}
