import 'package:flutter/cupertino.dart';

import 'models/category.dart';

class Data{

  static const String _apiKey = '563492ad6f917000010000013bcec1350f3d445d85c3e37f52100262';

  static List<Category> categories = [
    Category(name: 'Street Art', imgUrl: 'https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500'),
    Category(name: 'Wild Life', imgUrl: 'https://images.pexels.com/photos/704320/pexels-photo-704320.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500'),
    Category(name: 'Nature', imgUrl: 'https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500'),
    Category(name: 'City', imgUrl: 'https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500'),
    Category(name: 'Motivation', imgUrl: 'https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260'),
    Category(name: 'Cars', imgUrl: 'https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500'),
    Category(name: 'Bikes', imgUrl: 'https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500')
  ];

  static List<int> favourites =[];

  static List<String> colorNames = [
    'blue', 'teal', 'green', 'yellow', 'orange', 'red', 'pink', 'black'
  ];

  static List<Color> wallColors = [
    const Color(0xff548CFF),
    const Color(0xff69DADB),
    const Color(0xff9EDE73),
    const Color(0xffFBF46D),
    const Color(0xffFF9A76),
    const Color(0xffF05454),
    const Color(0xffF94892),
    const Color(0xff0F0E0E),

  ];

  String get apiKey => _apiKey;
}