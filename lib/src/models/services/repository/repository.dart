
import 'package:dailyfivematches/src/models/live_game_model.dart';
import 'package:dailyfivematches/src/models/services/data/data_provider.dart';
import 'package:flutter/material.dart';

class LiveGameRepository {
  final LiveGameDataProvider liveGameDataProvider;

  LiveGameRepository({
    required this.liveGameDataProvider,
  });

  Future<List<LiveGame>> getFiveLiveGames() async {
    debugPrint("Geting games...");
    final _jsonResponse = await liveGameDataProvider.getFiveLiveGames();
    final _jsonList = _jsonResponse['games_live'] as List;
    return games(_jsonList);
  }

  Future<GameOdd> getGameOdd(String gameId) async {
    final _jsonResponse = await liveGameDataProvider.getGameOdd(gameId);
    final _oddss = _jsonResponse['odds'];
    if (_oddss.isEmpty) {
      return GameOdd(homeOd: 'N/A', drawOd: "N/A", awayOd: "N/A");
    }
    final _odds = _jsonResponse['odds'] as Map<String, dynamic>;
    final _bet365 = _odds['Bet365'];
    if (_bet365 == null) {
      return GameOdd(homeOd: 'N/A', drawOd: "N/A", awayOd: "N/A");
    }
    final _prematch = _bet365['live'] as List;
    return GameOdd.fromJson(_prematch[0]);
  }

  Future<List<Player>> getPlayers(String teamId) async {
    final _jsonResponse = await liveGameDataProvider.getPlayers(teamId);
    final _teamPlayers = _jsonResponse['results'] as List;
    return _teamPlayers.map((player) => Player.fromJson(player)).toList();
  }

  Future<FavTeamsDetail> getFavTeamDetails(String gameId) async {
    final _jsonResponse = await liveGameDataProvider.getFavGameDetails(gameId);
    final _teamDetail = _jsonResponse['results'] as List;
    return FavTeamsDetail.fromJson(_teamDetail[0]);
  }
}

List<LiveGame> games(List<dynamic> playerJson) {
  if (playerJson.length > 5) {
    return playerJson
        .sublist(0, 5)
        .map((game) => LiveGame.fromJson(game))
        .toList();
  } else {
    return playerJson.map((game) => LiveGame.fromJson(game)).toList();
  }
}
