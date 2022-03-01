// To parse this JSON data, do
//     final liveGame = liveGameFromJson(jsonString);

class LiveGame {
  LiveGame({
    required this.gameId,
    required this.time,
    required this.timeStatus,
    required this.league,
    required this.home,
    required this.away,
    required this.timer,
    required this.score,
    required this.bet365Id,
  });

  String gameId;
  String time;
  String timeStatus;
  League league;
  Team home;
  Team away;
  String timer;
  String score;
  String bet365Id;

  factory LiveGame.fromJson(Map<String, dynamic> json) => LiveGame(
        gameId: json["game_id"],
        time: json["time"],
        timeStatus: json["time_status"],
        league: League.fromJson(json["league"]),
        home: Team.fromJson(json["home"]),
        away: Team.fromJson(json["away"]),
        timer: json["timer"],
        score: json["score"],
        bet365Id: json["bet365_id"],
      );

  Map<String, dynamic> toJson() => {
        "game_id": gameId,
        "time": time,
        "time_status": timeStatus,
        "league": league.toJson(),
        "home": home.toJson(),
        "away": away.toJson(),
        "timer": timer,
        "score": score,
        "bet365_id": bet365Id,
      };
}

class Team {
  Team({
    required this.name,
    required this.id,
    required this.imageId,
    required this.cc,
  });

  String name;
  String id;
  String imageId;
  String cc;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        name: json["name"],
        id: json["id"],
        imageId: json["image_id"],
        cc: json["cc"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "image_id": imageId,
        "cc": cc,
      };
}

class League {
  League({
    required this.name,
    required this.cc,
    required this.id,
  });

  String name;
  String cc;
  String id;

  factory League.fromJson(Map<String, dynamic> json) => League(
        name: json["name"],
        cc: json["cc"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "cc": cc,
        "id": id,
      };
}

class GameOdd {
  GameOdd({
    required this.homeOd,
    required this.drawOd,
    required this.awayOd,
  });

  String homeOd;
  String drawOd;
  String awayOd;

  factory GameOdd.fromJson(Map<String, dynamic> json) => GameOdd(
        homeOd: json["home_od"],
        drawOd: json["draw_od"],
        awayOd: json["away_od"],
      );

  Map<String, dynamic> toJson() => {
        "home_od": homeOd,
        "draw_od": drawOd,
        "away_od": awayOd,
      };
}

class Player {
  Player({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class FavTeamsDetail {
  Team home;
  Team away;
  bool isLive;
  String score;

  FavTeamsDetail({
    required this.home,
    required this.away,
    required this.isLive,
    required this.score,
  });

  factory FavTeamsDetail.fromJson(Map<String, dynamic> json) {
    return FavTeamsDetail(
      home: Team.fromJson(json["home"]),
      away: Team.fromJson(json["away"]),
      score: json['ss'],
      isLive: getIsLive(json),
    );
  }
}

bool getIsLive(Map<String, dynamic> json) {
  if (json['timer'] == null || json['extra'] == null) {
    return false;
  } else {
    return true;
  }
}
