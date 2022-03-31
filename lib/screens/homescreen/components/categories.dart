import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wallpexels/models/category.dart';
import 'package:flutter/material.dart';
import 'package:wallpexels/screens/searchresults/searchresultscreen.dart';
import '../../../data.dart';
import 'package:http/http.dart' as http;

import '../../../models/photoresource.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  List<Category> categoryList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children :[
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: const Text('Categories', style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              color: const Color(0xff090910),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 1.0,
                physics: const BouncingScrollPhysics(),
                children: Data.categories.map((e){
                  return CategoryTile(imageUrl: e.imgUrl!, name: e.name!);
                }).toList(),
              )),
        ]);
  }
}

class CategoryTile extends StatefulWidget {
  final String imageUrl;
  final String name;
  const CategoryTile({Key? key ,required  this.imageUrl, required this.name}) : super(key: key);

  @override
  State<CategoryTile> createState() => _CategoryTileState();


}

class _CategoryTileState extends State<CategoryTile> {


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await getQueryPhotos(widget.name);
        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResults(photos: searchResults, label: widget.name)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xff191919),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(2, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: CachedNetworkImage(
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                      key: UniqueKey(),
                      imageUrl: widget.imageUrl,
                      placeholder: (context,url)=> Container(color: Colors.grey,) ,
                    ),),
            ),),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500,color: Colors.white70),),
                  const Icon(Icons.color_lens, size: 15, color: Colors.grey,)
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  List<PhotoResource> searchResults = [];

  getQueryPhotos(String name) async{
    searchResults = [];
    String query = name;
    PhotoResource? photo;
    var response = await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=26"),
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