import 'dart:io';


import 'package:dailyfivematches/src/models/api/api_exception.dart';
import 'package:dailyfivematches/src/models/api/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class LiveGameDataProvider {
  final http.Client httpClient;

  LiveGameDataProvider({
    required this.httpClient,
  });

  // Get five live games
  Future<dynamic> getFiveLiveGames() async {
    late dynamic _apiResponse;
    try {
      final _jsonResponse = await httpClient.get(
        Uri.parse(
            'https://spoyer.ru/api/en/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=livedata&sport=soccer'),
      );
      debugPrint("resonse ${_jsonResponse.body}");
      _apiResponse = returnResponse(_jsonResponse);
    } catch (e) {
      throw FetchDataException('No Internet connection');
    }
    return _apiResponse;
  }

  Future<dynamic> getGameOdd(String gameId) async {
    late dynamic _apiResponse;
    try {
      final _response = await httpClient.get(
        Uri.parse(
          "https://spoyer.ru/api/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=odds&game_id=" +
              gameId,
        ),
      );
      _apiResponse = returnResponse(_response);
    } on SocketException catch (e, stack) {
      // debugPrint(stack.toString());

      throw FetchDataException('No Internet connection');
    }
    return _apiResponse;
  }

  Future<dynamic> getPlayers(String teamId) async {
    late dynamic _apiResponse;
    try {
      final _response = await httpClient.get(
        Uri.parse(
          "https://spoyer.ru/api/en/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=squaddata&team=" +
              teamId,
        ),
      );
      print(_response.body);
      _apiResponse = returnResponse(_response);
    } on SocketException catch (e, stack) {
      // debugPrint(stack.toString());

      throw FetchDataException('No Internet connection');
    }
    return _apiResponse;
  }

   Future<dynamic> getFavGameDetails(String gameId) async {
    late dynamic _apiResponse;
    try {
      final _response = await httpClient.get(
        Uri.parse(
          "https://spoyer.ru/api/en/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=eventdata&game_id=" +
              gameId,
        ),
      );
      // print(_response.body);
      _apiResponse = returnResponse(_response);
    } on SocketException catch (e, stack) {
      // debugPrint(stack.toString());

      throw FetchDataException('No Internet connection');
    }
    return _apiResponse;
  }

}
