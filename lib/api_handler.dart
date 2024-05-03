import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterwebapi/model.dart';
import "package:http/http.dart" as http;

class ApiHandler {
  final String baseUri = "https://localhost:7122/api/users";

  Future<List<User>> getUserData() async {
    List<User> data = [];
    final uri = Uri.parse(baseUri);
    try {
      final response = await http.get(uri, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        data = jsonData.map((json) => User.fromJson(json)).toList();
      }
    } catch (e) {
      return data;
    }
    return data;
  }

  Future<http.Response> updateUser(
      {required int Id, required User user}) async {
    final uri = Uri.parse("$baseUri/$Id");
    late http.Response response;
    try {
      response = await http.put(
        uri,
        headers: <String, String>{
          'Content-type': "application/json; charset=UTF-8",
        },
        body: json.encode(user),
      );
    } catch (e) {
      debugPrint('Error during HTTP request: $e');
      response = http.Response('Error occurred during request', 500);
    }
    return response;
  }

  Future<http.Response> addUser({required User user}) async {
    final uri = Uri.parse(baseUri);
    late http.Response response;
    try {
      response = await http.post(
        uri,
        headers: <String, String>{
          'Content-type': "application/json; charset=UTF-8",
        },
        body: json.encode(user),
      );
    } catch (e) {
      debugPrint('Error during HTTP request: $e');
      response = http.Response('Error occurred during request : $e', 500);
    }
    return response;
  }

  Future<http.Response> deleteUser({required int Id}) async {
    final uri = Uri.parse("$baseUri/Id");
    late http.Response response;
    try {
      response = await http.delete(
        uri,
        headers: <String, String>{
          'Content-type': "application/json; charset=UTF-8",
        },
      );
      return response;
    } catch (e) {
      return response;
    }
  }
}
