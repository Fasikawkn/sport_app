
import 'package:dailyfivematches/src/db/db_helper.dart';
import 'package:dailyfivematches/src/models/api/api_response.dart';
import 'package:flutter/material.dart';

class FavoriteContorller extends ChangeNotifier {
  final DBHelper? dbHelper;
  List<String> _favGames = [];

  FavoriteContorller(this.dbHelper, this._favGames) {
    if (dbHelper != null) {
      getAllFavoriteGamess();
    }
  }

  List<String> get items => [..._favGames];

  Response _favGameResponse = Response.initial('initializing Game');
  Response get favGameResponse {
    return _favGameResponse;
  }

  set favGameResponse(Response response) {
    _favGameResponse = response;
    notifyListeners();
  }

  // get All Categories
  Future getAllFavoriteGamess() async {
    favGameResponse = Response.loading("getting fav games");
    print("Getting all the favorite teams");
    if (dbHelper!.db != null) {
      print("inside fethcing favorites");
      try {
        final _response = await dbHelper!.getFavoriteGames();

        if (_response is List) {
          print("get ing");
          print(_response);

          favGameResponse = Response.completed(_response);
        }
      } catch (e) {
        print("THe error is ${e.toString()}");
        favGameResponse = Response.error(e.toString());
      }
    }
  }

  Future insertTeam(String gameId) async {
    if (dbHelper!.db != null) {
      Map<String, dynamic> _teamId = {"game_id": gameId};
      await dbHelper!.insertGame(_teamId);
      await getAllFavoriteGamess();
    }
  }

  Future deleteTeam(String gameId) async {
    if (dbHelper!.db != null) {
      await dbHelper!.deleteGame(gameId);
      await getAllFavoriteGamess();
    }
  }

  Future<bool> isFavorite(String teamId) async {
    if (dbHelper!.db != null) {
      return await dbHelper!.isFavorite(teamId);
    } else {
      return false;
    }
  }
}