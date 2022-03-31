import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpexels/screens/searchresults/searchresultscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../data.dart';
import '../../../models/photoresource.dart';
import '../../viewphotoscreen/photoscreen.dart';

class TrendingPhotos extends StatefulWidget {
  const TrendingPhotos({Key? key}) : super(key: key);

  @override
  State<TrendingPhotos> createState() => _TrendingPhotosState();
}

class _TrendingPhotosState extends State<TrendingPhotos> {

  @override
  void initState() {
    getTrendingPhotos();
  }

  List<PhotoResource> trendingPhotos = [];

  getTrendingPhotos() async{
    PhotoResource? photo;
    var response = await http.get(Uri.parse("https://api.pexels.com/v1/search?query=wallpaper&per_page=26"),
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

      trendingPhotos.add(photo!);
    });
    setState(() {
    });

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(children :  [ const Text("Trending",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),),
              const Spacer(),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  SearchResults(photos: trendingPhotos, label: 'Trending')),
                  );;},
                  child: const Text("See more",
                    style: TextStyle(
                      color: Colors.blueAccent, fontWeight: FontWeight.w500, fontSize: 15),))
            ]),
          ),
          SizedBox(
            height: 250.0,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: trendingPhotos.length,
                itemBuilder: (BuildContext context,int photo){
                  return InkWell(
                    onTap: (){

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PhotoScreen(photo: {'url': trendingPhotos[photo].portrait,
                          'photographer': trendingPhotos[photo].photographer,
                          'size': "${trendingPhotos[photo].width} x ${trendingPhotos[photo].height} Pixels",
                          'title' : trendingPhotos[photo].title, 'avgColor' : trendingPhotos[photo].avgColor,
                          'id' : trendingPhotos[photo].id}),),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          key: UniqueKey(),
                          imageUrl: trendingPhotos[photo].portrait.toString(),
                          placeholder: (context,url)=> Container(color: Colors.grey,) ,
                        ),
                      ),
                    ),
                  )
                  ;
                }),
          ),
        ],
      ),
    );
  }
}
