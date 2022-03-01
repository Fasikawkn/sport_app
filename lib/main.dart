import 'package:dailyfivematches/src/controllers/is_favorite.dart';
import 'package:dailyfivematches/src/controllers/live_game_controller.dart';
import 'package:dailyfivematches/src/db/db_helper.dart';
import 'package:dailyfivematches/src/models/services/data/data_provider.dart';
import 'package:dailyfivematches/src/models/services/repository/repository.dart';
import 'package:dailyfivematches/src/views/screens/splash_screen.dart';
import 'package:dailyfivematches/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const DialyFiveMathesApp());
}

class DialyFiveMathesApp extends StatelessWidget {
  const DialyFiveMathesApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LiveGameModel(
            liveGameRepository: LiveGameRepository(
              liveGameDataProvider: LiveGameDataProvider(
                httpClient: http.Client(),
              )
            )
            )..getFiveLiveGames()
          ),

           ChangeNotifierProvider<DBHelper>(
          create: (context) => DBHelper(),
        ),
        ChangeNotifierProxyProvider<DBHelper, FavoriteContorller>(
          create: (context) => FavoriteContorller( null, []),
          update: (context, db, previous) => FavoriteContorller(
             db,
             previous!.items,
          ),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: createMaterialColor(kPrimaryColor),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: kPrimaryColor,
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}