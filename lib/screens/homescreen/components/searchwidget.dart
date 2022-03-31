import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wallpexels/screens/homescreen/homescreen.dart';
import 'package:wallpexels/screens/searchresults/searchresultscreen.dart';
import '../../../data.dart';
import '../../../models/photoresource.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {

  List<PhotoResource> searchResults = [];

  getQueryPhotos() async{
    searchResults = [];
    PhotoResource? photo;
    var response = await http.get(Uri.parse("https://api.pexels.com/v1/search?query=${searchController.text}&per_page=26"),
        headers: {"Authorization" : Data().apiKey});

    Map<String, dynamic> responseData = jsonDecode(response.body);
    responseData["photos"].forEach((element){

      photo = PhotoResource(imgUrl: element["url"], id: element["id"],
          photographer: element["photographer"],
          original: element["src"]['large2x'],
          portrait: element["src"]["portrait"],
          width: element['width'],
          height: element['height'],
          avgColor: element['avg_color'],
          title: element["alt"]);

      searchResults.add(photo!);
    });
    setState(() {
    });

  }


  TextEditingController searchController = TextEditingController();

  onPress() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus){
      currentFocus.unfocus();}


    await getQueryPhotos();
    print(searchResults.toString());
    String query = searchController.text;

    searchController.clear();

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchResults(label: query,
            photos: searchResults)
        ));
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
        color: Colors.grey.withOpacity(0.2), ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                onPress();
              },
              controller: searchController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(hintText: 'Search wallpapers',
                  border: InputBorder.none,  hintStyle: TextStyle(color: Colors.white70)),
            ),
          ),
          IconButton(onPressed: () async {
            onPress();
          },
            icon: const Icon(Icons.search, color: Colors.white,),
            splashRadius: 20,
            padding: const EdgeInsets.symmetric(horizontal: 0),)
        ],
      ),
    );
  }
}
