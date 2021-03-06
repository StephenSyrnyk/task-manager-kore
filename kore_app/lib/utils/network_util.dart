import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String url, String token) {
    return http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Bearer " + token.trim()
    }).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 401){
        return response;
      }

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception(
            "Error while fetching data " + statusCode.toString());
      }
      
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url, bool isSigin,
      {Map headers, body, encoding, returnResponse}) {
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception(
            "Error while fetching data " + statusCode.toString());
      }
      if (returnResponse != null && returnResponse) {
        return response;
      }
      if (!isSigin)
        return _decoder.convert(res);
      else
        return res;
    });
  }

  Future<dynamic> put(String url, bool isSigin, {Map headers, body, encoding}) {
    return http
        .put(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception(
            "Error while fetching data " + statusCode.toString());
      }
      if (!isSigin)
        return _decoder.convert(res);
      else
        return res;
    });
  }

  Future<dynamic> delete(String url, String token) {
    return http.delete(url, headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.trim()
    }).then((http.Response response) {
      final int statusCode = response.statusCode;
      final String res = response.body;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception(
            "Error while deleting data " + statusCode.toString());
      }
      return res;
    });
  }

  Future<dynamic> deleteWithBody(String url, String token, {body}) {
    http.Request rq = http.Request('DELETE', Uri.parse(url))
      ..headers.addAll({
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + token.trim()
      });
    rq.bodyFields = body;

    http.Client().send(rq).then((http.StreamedResponse response) {
      final int statusCode = response.statusCode;
      final http.ByteStream res = response.stream;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception(
            "Error while deleting data " + statusCode.toString());
      }
      return res;
    });
  }
}
