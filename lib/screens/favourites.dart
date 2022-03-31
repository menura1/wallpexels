import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpexels/data.dart';
import 'package:wallpexels/screens/viewphotoscreen/photoscreen.dart';

import '../models/photoresource.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();

}

class _FavouritesState extends State<Favourites> {

  List<PhotoResource> favs = [];
  getFavourites() async{
    Data.favourites.forEach((e) async {
      PhotoResource photo;
      var response = await http.get(Uri.parse("https://api.pexels.com/v1/photos/$e"),
          headers: {"Authorization" : Data().apiKey});

      Map<String, dynamic> responseData = jsonDecode(response.body);

        photo = PhotoResource(imgUrl: responseData["url"], id: responseData["id"],
            photographer: responseData["photographer"],
            original: responseData["src"]['large2x'],
            portrait: responseData["src"]["portrait"],
            width: responseData['width'],
            height: responseData['height'],
            avgColor: responseData['avg_color'],
            title: responseData["alt"]);

        favs.add(photo);
        setState(() {
          
        });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090910),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  Container(
                    child: const Text('Favourites',style: TextStyle(color: Colors.white, fontSize: 25)),
                  ),
                  GridView.count(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    childAspectRatio: 0.67,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    crossAxisCount: 2,
                    children: favs.map((e) {
                      return InkWell(
                        onTap: (){

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  PhotoScreen(photo: {'url': e.portrait,
                              'photographer': e.photographer,
                              'size': "${e.width} x ${e.height} Pixels",
                              'title' : e.title, 'avgColor' : e.avgColor,
                              'id' : e.id},)),
                          );
                        },
                        child: GridTile(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              placeholder: (context,url)=>Container(color: Colors.grey,),
                              imageUrl: e.portrait.toString(),
                            ),
                          ),
                        ),
                      );
                    }).toList()),
              ])
          ),
        ));
  }

  @override
  void initState() {
    getFavourites();

  }
}
