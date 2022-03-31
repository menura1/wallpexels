import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallpexels/screens/homescreen/components/categories.dart';
import '../data.dart';

class Category{
  String? name;
  String? imgUrl;
  String? results;

  Category({this.name, this.imgUrl});

}