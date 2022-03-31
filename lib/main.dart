import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallpexels/screens/searchresults/searchresultscreen.dart';
import 'package:wallpexels/screens/viewphotoscreen/photoscreen.dart';
import 'screens/screens.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp( const MaterialApp(
    home: HomeScreen(),
  ));
}

