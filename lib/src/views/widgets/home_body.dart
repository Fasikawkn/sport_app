import 'package:cached_network_image/cached_network_image.dart';
import 'package:dailyfivematches/src/controllers/is_favorite.dart';
import 'package:dailyfivematches/src/controllers/live_game_controller.dart';
import 'package:dailyfivematches/src/models/api/api_response.dart';
import 'package:dailyfivematches/src/models/live_game_model.dart';
import 'package:dailyfivematches/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({required this.index, Key? key}) : super(key: key);
  final int index;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Consumer<LiveGameModel>(builder: (context, model, child) {
        if (model.liveGameResponse.status == Status.loading) {
          return const Center(
            child: CircularProgressIndicator(
              color: kYellowColor,
            ),
          );
        } else if (model.liveGameResponse.status == Status.completed) {
          debugPrint("The completed data is ${model.liveGameResponse.data}");
          List<LiveGame> _liveGames = model.liveGameResponse.data;

          return _liveGames.isEmpty
              ? const Center(
                  child: Text(
                    "No Match",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              : Column(
                  children: [
                    Container(
                      color: kUpBackColor,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20.0, top: 20.0, bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  _liveGames[widget.index].league.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.0,
                                  ),
                                ),
                                const SizedBox(
                                  width: 40.0,
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await Provider.of<FavoriteContorller>(
                                            context,
                                            listen: false)
                                        .insertTeam(
                                            _liveGames[widget.index].gameId);
                                    setState(() {});
                                  },
                                  icon: FutureBuilder<bool>(
                                    future: Provider.of<FavoriteContorller>(
                                            context,
                                            listen: false)
                                        .isFavorite(
                                            _liveGames[widget.index].gameId),
                                    builder: (context, snapshots) {
                                      debugPrint(
                                          "data is data ${snapshots.data}");
                                      if (snapshots.hasData) {
                                        debugPrint(
                                            "data is data ${snapshots.data}");
                                        bool data = snapshots.data!;
                                        return Icon(
                                          Icons.star_purple500_sharp,
                                          color: data
                                              ? const Color(0xffFFDF1B)
                                              : const Color(0xff616161),
                                          size: 30,
                                        );
                                      } else {
                                        return const Icon(
                                          Icons.star_purple500_sharp,
                                          color: Color(0xff616161),
                                          size: 30,
                                        );
                                      }
                                      // return snapshots.hasData? const Icon(
                                      //   Icons.star_purple500_sharp,
                                      //   color: Color(0xff616161),
                                      //   size: 30,
                                      // ):const Icon(
                                      //   Icons.star_purple500_sharp,
                                      //   color: Color(0xff616161),
                                      //   size: 30,
                                      // );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  height: 56,
                                  width: 78,
                                  decoration: BoxDecoration(
                                    color: kTeamBackColor,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Center(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://spoyer.ru/api/team_img/football/${_liveGames[widget.index].home.id}.png',
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          const SpinKitThreeBounce(
                                        color: kYellowColor,
                                        size: 20.0,
                                      ),
                                      errorWidget: (context, url, err) =>
                                          Image.asset(
                                        'assets/images/team_image.png',
                                        width: 100.0,
                                      ),
                                    ),
                                  )),
                              const Text(
                                "VS",
                                style: TextStyle(
                                  color: kYellowColor,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                height: 56,
                                width: 78,
                                // color: kTeamBackColor,
                                decoration: BoxDecoration(
                                  color: kTeamBackColor,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Center(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://spoyer.ru/api/team_img/football/${_liveGames[widget.index].home.id}.png',
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: imageProvider),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        const SpinKitThreeBounce(
                                      color: kYellowColor,
                                      size: 20.0,
                                    ),
                                    errorWidget: (context, url, err) =>
                                        Image.asset(
                                      'assets/images/team_image.png',
                                      width: 100.0,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Flexible(
                                  child: Text(
                                    getTeamTitleName(
                                        _liveGames[widget.index].home.name),
                                    style: const TextStyle(
                                      color: Color(0xffB2B2B2),
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ),
                                const Flexible(
                                  child: SizedBox(
                                    height: 10.0,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    getTeamTitleName(
                                        _liveGames[widget.index].away.name),
                                    style: const TextStyle(
                                      color: Color(0xffB2B2B2),
                                      fontSize: 13.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          FutureBuilder<GameOdd>(
                            future:
                                model.getOdd(_liveGames[widget.index].gameId),
                            builder: (context, snapshot) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          )
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Stack(
                        children: [
                          Container(
                            height: size.height * 0.5,
                            // width: size.width,
                            padding: const EdgeInsets.all(20.0),
                            color: const Color(0xff414141),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: SizedBox(
                                      width: size.width * 0.5,
                                      child: FutureBuilder<List<Player>>(
                                          future: model.liveGameRepository
                                              .getPlayers(
                                                  _liveGames[widget.index]
                                                      .home
                                                      .id),
                                          builder: (context, snapshots) {
                                            return snapshots.hasData
                                                ? snapshots.data!.isEmpty
                                                    ? const Center(
                                                        child: Text(
                                                          "No Player",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )
                                                    : Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: getPlayers(
                                                                snapshots.data!)
                                                            .map((player) =>
                                                                _buildPlayerName(
                                                                    player
                                                                        .name))
                                                            .toList(),
                                                      )
                                                : const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: kYellowColor,
                                                    ),
                                                  );
                                          }),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    thickness: 3.0,
                                    color: Color(0xff333333),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: SizedBox(
                                      width: size.width * 0.5,
                                      child: FutureBuilder<List<Player>>(
                                          future: model.liveGameRepository
                                              .getPlayers(
                                                  _liveGames[widget.index]
                                                      .away
                                                      .id),
                                          builder: (context, snapshots) {
                                            return snapshots.hasData
                                                ? snapshots.data!.isEmpty
                                                    ? const Center(
                                                        child: Text(
                                                          "No Player",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )
                                                    : Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: getPlayers(
                                                                snapshots.data!)
                                                            .map((player) =>
                                                                _buildPlayerName(
                                                                    player
                                                                        .name))
                                                            .toList(),
                                                      )
                                                : const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: kYellowColor,
                                                    ),
                                                  );
                                          }),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
        } else {
          debugPrint('The error occured is ${model.liveGameResponse.message}');
          return Center(
            child: Text(
              model.liveGameResponse.message!,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          );
        }
      }),
    );
  }

  Padding _buildPlayerName(String name) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15.0,
      ),
      child: Text(
        name,
        style: const TextStyle(color: Color(0xffA3A3A3)),
      ),
    );
  }

  Container _buildOdd(Widget odd) {
    return Container(
      height: 36,
      width: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: kOddBackColor,
      ),
      child: Center(child: odd),
    );
  }
}

List<Player> getPlayers(List<Player> player) {
  if (player.length > 8) {
    return player.sublist(0, 8);
  } else {
    return player;
  }
}
