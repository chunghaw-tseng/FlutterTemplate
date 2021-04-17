import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_template/.env.dart';

class ApiProviderService {
  final String _baseUrl = environment["data_url"];

  Future<dynamic> get(String url) async {
    var jsonResponse;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url), headers: {
        "Accept": "application/json",
        'Access-Control-Allow-Origin': '*'
      });
      jsonResponse = _response(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    }
    return jsonResponse;
  }

  Future<dynamic> post(String url, Map<String, dynamic> data) async {
    var jsonResponse;
    try {
      final response = await http.post(Uri.parse(_baseUrl + url),
          headers: {
            "Accept": "application/json; charset=UTF-8",
            "Content-Type": "application/json",
            'Access-Control-Allow-Origin': '*'
          },
          body: jsonEncode(data));
      jsonResponse = _response(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    }
    return jsonResponse;
  }

  Future<dynamic> postWithNoData(String url) async {
    var jsonResponse;
    try {
      final response = await http.post(Uri.parse(_baseUrl + url), headers: {
        "Accept": "application/json; charset=UTF-8",
        "Content-Type": "application/json",
        'Access-Control-Allow-Origin': '*'
      });
      jsonResponse = _response(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    }
    return jsonResponse;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw InternalServerException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

// Exception classes
class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}

class InternalServerException extends CustomException {
  InternalServerException([String message])
      : super(message, "Internal Server Error: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}

// Response class
class Response<T> {
  Status status;
  T data;
  String message;

  Response.loading(this.message) : status = Status.LOADING;
  Response.completed(this.data) : status = Status.COMPLETED;
  Response.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
