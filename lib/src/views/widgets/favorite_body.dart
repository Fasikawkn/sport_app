import 'package:dailyfivematches/src/controllers/is_favorite.dart';
import 'package:dailyfivematches/src/controllers/live_game_controller.dart';
import 'package:dailyfivematches/src/models/api/api_response.dart';
import 'package:dailyfivematches/src/models/live_game_model.dart';
import 'package:dailyfivematches/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class FavoriteBody extends StatefulWidget {
  const FavoriteBody({Key? key}) : super(key: key);

  @override
  State<FavoriteBody> createState() => _FavoriteBodyState();
}

class _FavoriteBodyState extends State<FavoriteBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Add Your Code here.
      _getFavMatches();
    });
  }

  _getFavMatches() async {
    await Provider.of<FavoriteContorller>(context, listen: false)
        .getAllFavoriteGamess();
  }

  Widget _buildOdd(Widget odd) {
    return Container(
      height: 36,
      width: 64,
      color: kOddBackColor,
      child: Center(child: odd),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteContorller>(builder: (context, model, child) {
      if (model.favGameResponse.status == Status.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (model.favGameResponse.status == Status.completed) {
        debugPrint("Favorite Game is ${model.favGameResponse.data}");
        List<Map<String, dynamic>> _favGame = model.favGameResponse.data;
        return SingleChildScrollView(
          child: Column(
              children: _favGame
                  .map(
                    (match) => _buildLiveTeamStatus(match['game_id'], context),
                  )
                  .toList()),
        );
      } else {
        return const Center(
          child: Text("Something went wrong"),
        );
      }
    });
  }

  Widget _buildLiveTeamStatus(String gameId, BuildContext context) {
    return FutureBuilder<FavTeamsDetail>(
        future: Provider.of<LiveGameModel>(context, listen: false)
            .getFavGameDetail(gameId),
        builder: (context, snapshots) {
          return Container(
            padding: const EdgeInsets.only(right: 20.0, top: 20.0),
            decoration: const BoxDecoration(
              color: kUpBackColor,
              border: Border(
                bottom: BorderSide(width: 0.2, color: Colors.grey),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            await Provider.of<FavoriteContorller>(context,
                                    listen: false)
                                .deleteTeam(gameId);
                          },
                          icon: const Icon(
                            Icons.star_rate_rounded,
                            color: Color(0xffFFDF1B),
                            size: 30.0,
                          ),
                        ),
                        snapshots.hasData
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getTeamTitleName(snapshots.data!.home.name),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    getTeamTitleName(snapshots.data!.away.name),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  )
                                ],
                              )
                            : const Center(
                                child: SpinKitThreeBounce(
                                  color: kYellowColor,
                                  size: 20,
                                ),
                              ),
                      ],
                    ),
                    snapshots.hasData
                        ? snapshots.data!.isLive
                            ? Container(
                                height: 29,
                                width: 40,
                                color: Colors.red,
                                child: const Center(
                                  child: Text(
                                    "LIVE",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        snapshots.data!.score.split('-')[0],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        snapshots.data!.score.split('-')[0],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Container(
                                    height: 29,
                                    width: 40,
                                    color: const Color(0xff444444),
                                    child: const Center(
                                      child: Text(
                                        "END",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color(0xff717171),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                        : const Center(
                            child: SpinKitCircle(
                              color: kYellowColor,
                            ),
                          )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                if (snapshots.hasData)
                  if (snapshots.data!.isLive)
                    FutureBuilder<GameOdd>(
                        future:
                            Provider.of<LiveGameModel>(context, listen: false)
                                .getOdd(gameId),
                        builder: (context, snapshot) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildOdd(
                                snapshot.hasData
                                    ? Text(
                                        snapshot.data!.homeOd,
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const SpinKitThreeBounce(
                                        color: kYellowColor,
                                        size: 12.0,
                                      ),
                              ),
                              Column(
                                children: [
                                  _buildOdd(
                                    snapshot.hasData
                                        ? Text(
                                            snapshot.data!.awayOd,
                                            style: const TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.white,
                                            ),
                                          )
                                        : const SpinKitThreeBounce(
                                            color: kYellowColor,
                                            size: 12.0,
                                          ),
                                  ),
                                ],
                              ),
                              _buildOdd(
                                snapshot.hasData
                                    ? Text(
                                        snapshot.data!.awayOd,
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const SpinKitThreeBounce(
                                        color: kYellowColor,
                                        size: 12.0,
                                      ),
                              ),
                            ],
                          );
                        }),
                const SizedBox(
                  height: 20.0,
                )
              ],
            ),
          );
        });
  }
}
