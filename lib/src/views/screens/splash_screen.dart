import 'package:dailyfivematches/src/views/screens/home_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
        },
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/splash_img.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: const Center(
            child: Text(
              "DAILY FIVE MATCHES",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xffefe35d),
                fontSize: 60.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
