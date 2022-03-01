

import 'package:dailyfivematches/src/models/api/api_response.dart';
import 'package:dailyfivematches/src/models/live_game_model.dart';
import 'package:dailyfivematches/src/models/services/repository/repository.dart';
import 'package:flutter/material.dart';

class LiveGameModel extends ChangeNotifier {
  final LiveGameRepository liveGameRepository;

  LiveGameModel({
    required this.liveGameRepository,
  });

  Response _liveGameResponse = Response.initial('initializing Game');
  Response get liveGameResponse {
    return _liveGameResponse;
  }

  set liveGameResponse(Response response) {
    _liveGameResponse = response;
    notifyListeners();
  }

  Future getFiveLiveGames() async {
    liveGameResponse = Response.loading('fetching match');
    try {
      final _fiveLiveGames = await liveGameRepository.getFiveLiveGames();

      liveGameResponse = Response.completed(_fiveLiveGames);
    } catch (e) {
      debugPrint("The error is ${e.toString()}");

      liveGameResponse = Response.error(e.toString());
    }
  }

  Future<GameOdd> getOdd(String gameId) async {
    late GameOdd _matchOdd;
    try {
      GameOdd _gameOdd = await liveGameRepository.getGameOdd(gameId);
      _matchOdd = _gameOdd;
    } catch (e) {
      throw Exception(e.toString());
    }
    return _matchOdd;
  }

  Future<List<Player>> getPlayers(String teamId) async {
    late List<Player> _teamPlayers;
    try {
      final _teamRes = await liveGameRepository.getPlayers(teamId);
      _teamPlayers = _teamRes as List<Player>;
    } catch (e) {
      throw Exception(e.toString());
    }
    return _teamPlayers;
  }

  Future<FavTeamsDetail> getFavGameDetail(String gameId) async {
    late FavTeamsDetail _gameDetail;
    try {
      final _teamRes = await liveGameRepository.getFavTeamDetails(gameId);
      _gameDetail = _teamRes;
    } catch (e) {
      throw Exception(e.toString());
    }
    return _gameDetail;
  }
}
