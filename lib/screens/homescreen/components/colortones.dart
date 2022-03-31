import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../../data.dart';
import '../../../models/photoresource.dart';
import '../../searchresults/searchresultscreen.dart';

class ColorTones extends StatelessWidget {
  const ColorTones({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Color Tones', style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)),
          const SizedBox(height: 10,),
          SizedBox(
            height: MediaQuery.of(context).size.width/8,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: Data.wallColors.length,
                scrollDirection: Axis.horizontal,
                itemBuilder:
                    (context, index) => ColorTile(color: Data.wallColors[index], colorName:Data.colorNames[index])),
          ),
        ],
      ),
    );
  }
}

class ColorTile extends StatelessWidget {
  final Color color;
  final String colorName;

   ColorTile({Key? key, required this.color, required this.colorName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: InkWell(
        onTap: () async {
          await getQueryPhotos();
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchResults(label: colorName,
                  photos: searchResults)
              ));
        },
        child: ClipOval(
          child: Container(
            color: color,
            width: MediaQuery.of(context).size.width/8,
          ),
        ),
      ),
    );
  }

  List<PhotoResource> searchResults = [];

  getQueryPhotos() async{
    searchResults = [];
    PhotoResource? photo;
    var response = await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$colorName&per_page=26"),
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
  }

}
