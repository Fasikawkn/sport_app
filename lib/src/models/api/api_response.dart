import 'dart:convert';

import 'package:dailyfivematches/src/models/api/api_exception.dart';
import 'package:http/http.dart' as http;
class Response<T> {
  Status status;
  T? data;
  String? message;

  Response.initial(this.message) : status = Status.initial;

  Response.loading(this.message) : status = Status.loading;

  Response.completed(this.data) : status = Status.completed;

  Response.error(this.message) : status = Status.error;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { initial, loading, completed, error }


dynamic returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      dynamic responseJson = jsonDecode(response.body);
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException('Error occured while communication with server' +
          ' with status code : ${response.statusCode}');
  }
}