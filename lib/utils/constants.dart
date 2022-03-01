import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xff484848);
const kYellowColor = Color(0xffFFDA44);
const kTeamBackColor = Color(0xff424242);
const kOddBackColor = Color(0xff5a5a5a);
const kUpBackColor = Color(0xff353535);
const kBottomBackColor = Color(0xff2A2A2A);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

String getTeamTitleName(String name) {
  print("Original name $name");
  bool _containesEsport = name.contains('Esports');

  if (_containesEsport) {
    String _newName = name.replaceAll(' Esports', '');
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>The new name is ${_newName}");
    return _newName;
  } else {
    return name;
  }
}
