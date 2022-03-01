import 'package:dailyfivematches/src/controllers/live_game_controller.dart';
import 'package:dailyfivematches/src/models/api/api_response.dart';
import 'package:dailyfivematches/src/models/live_game_model.dart';
import 'package:dailyfivematches/src/views/widgets/favorite_body.dart';
import 'package:dailyfivematches/src/views/widgets/home_body.dart';
import 'package:dailyfivematches/utils/constants.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  int _currentTeamIndex = 0;
  int _teamCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Add Your Code here.
      _getTeamsCount();
    });
  }

  _getTeamsCount() async {
    final _response = await Provider.of<LiveGameModel>(context, listen: false)
        .getFiveLiveGames();
    Response _responseCount =
        Provider.of<LiveGameModel>(context, listen: false).liveGameResponse;
    if (_responseCount.status == Status.completed) {
      List<LiveGame> _liveGame = _responseCount.data;
      setState(() {
        _teamCount = _liveGame.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("The team count is $_teamCount");
    final size = MediaQuery.of(context).size;
    final _homeBody = [
      HomeBody(
        index: _currentTeamIndex,
      ),
      FavoriteBody()
    ];
    return Scaffold(
      backgroundColor: kUpBackColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _currentIndex == 0 ? getDate() : "Favorites",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ),
      body: _homeBody[_currentIndex],
      bottomNavigationBar: Container(
        height: 72,
        width: size.width,
        color: const Color(0xff292929),
        child: Column(
          children: [
            SizedBox(
                height: 56.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentIndex = 0;
                          });
                        },
                        child: Container(
                          color: _currentIndex == 0
                              ? const Color(0xff333333)
                              : const Color(0xff292929),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.home_outlined,
                                color: Colors.white,
                              ),
                              Text(
                                "Matches",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentIndex = 1;
                          });
                        },
                        child: Container(
                          color: _currentIndex == 1
                              ? const Color(0xff333333)
                              : const Color(0xff292929),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.star,
                                color: Colors.white,
                              ),
                              Text(
                                "Favorites",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Container(
              height: 16.0,
              color: const Color(0xff292929),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _currentIndex == 0
          ? SizedBox(
              width: 150,
              height: 45,
              child: FloatingActionButton(
                backgroundColor: kYellowColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                ),
                onPressed: () {
                  if (_currentTeamIndex == _teamCount - 1) {
                    setState(() {
                      _currentTeamIndex = 0;
                    });
                  } else {
                    setState(() {
                      _currentTeamIndex++;
                    });
                  }
                },
                child: const Text(
                  "Next Match",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            )
          : Container(),
    );
  }
}
