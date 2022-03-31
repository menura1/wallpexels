import 'dart:core';
import 'package:flutter/material.dart';
import 'package:wallpexels/models/photoresource.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wallpexels/screens/homescreen/homescreen.dart';
import '../viewphotoscreen/photoscreen.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({Key? key, required this.photos, required this.label}) : super(key: key);

  final List<PhotoResource> photos;
  final String label;

  static const String routeName = "searchResultsScreen";
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff090910),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Text(widget.label.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 25),),
                const SizedBox(height: 15,),
                GridView.count(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  childAspectRatio: 0.67,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  crossAxisCount: 2,
                  children: widget.photos.map((photo) {
                    return InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  PhotoScreen(photo: {'url': photo.portrait,
                              'photographer': photo.photographer,
                              'size': "${photo.width} x ${photo.height} Pixels",
                              'title' : photo.title, 'avgColor' : photo.avgColor,
                              'id' : photo.id},)),
                          );
                          },
                      child: GridTile(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                key: UniqueKey(),
                                imageUrl: photo.portrait.toString(),
                                placeholder: (context,url)=>Container(
                                  color: Colors.grey,
                                ),
                              ))),
                    );
                  }).toList(),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
