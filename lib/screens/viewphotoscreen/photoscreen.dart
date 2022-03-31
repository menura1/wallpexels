import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
import 'package:wallpexels/models/user.dart';

import '../../data.dart';

class PhotoScreen extends StatefulWidget {

  const PhotoScreen({Key? key, required this.photo}) : super(key: key);

  static const routeName = 'photoscreen';
  final Map<dynamic, dynamic>  photo;


  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {

  String url ='';
  bool isLoading = false;

  Future<void> setWallpaperHome() async {
    setState(() {
      isLoading = true;
    });
    var cachedimage = await DefaultCacheManager().getSingleFile(url);  //image file

    int location = WallpaperManagerFlutter.HOME_SCREEN;  //Choose screen type

    WallpaperManagerFlutter().setwallpaperfromFile(cachedimage, location);

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.amber,
        content: Text('Wallpaper updated', style: TextStyle(color: Colors.black),),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    var liked = false;
    Icon likeIcon;

    if(Data.favourites.contains(widget.photo['id'])){
      liked = true;
      likeIcon = const Icon(Icons.favorite,color: Colors.pink,);
    }
    else{
      likeIcon = const Icon(Icons.favorite_border);
    }

    url = widget.photo["url"];
    print(widget.photo['size']);
    String avgColor = widget.photo['avgColor'].toString();
    print(avgColor+"dd");
    // final Color color = HexColor.fromHex(avgColor);
    const Color color = Colors.white;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children :[ Container(
            color: Colors.black,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
            bottomLeft: Radius.circular(15)
                  ),
                  child: SizedBox(
                  height: MediaQuery.of(context).size.height-
                      MediaQuery.of(context).padding.top-MediaQuery.of(context).padding.bottom,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(widget.photo["url"],
                  fit: BoxFit.cover,),
              ),),])),
                // Container(
                //     child: Column(
                //         children: [
                //           Text(arguments['title'], style: const TextStyle(fontSize: 20,
                //           color: Colors.white)),
                //           Text("By ${arguments['photographer']}",
                //           style: TextStyle(fontSize: 15, color: Colors.white),),
                //         ])),

            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topRight: Radius.circular(15),
                topLeft: Radius.circular(15)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.15),
                      Colors.transparent,
                    ],
                  )
              ),
              height: 65,
            ),
                Column(
                  children:[
                    Row(
                      children: [
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.arrow_back),color: Colors.white,),
                        const Spacer(),
                        IconButton(onPressed: (){}, icon: const Icon(Icons.share),
                            color: Colors.white)
                      ],
                    ),
                    const Spacer(),
                    Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    width: MediaQuery.of(context).size.width*0.85,
                    height: 75,
                    decoration: BoxDecoration(
                        color: const Color(0xff000000),
                        borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: (){
                          setState(() {
                            if(!liked){
                              Data.favourites.add(widget.photo['id']);
                            }
                            else{
                              Data.favourites.remove(widget.photo['id']);
                            }
                            liked = !liked;
                          });
                        }, icon: likeIcon,color: color),
                        IconButton(onPressed: (){
                          setWallpaperHome();
                        }, icon: const Icon(Icons.download_outlined),color: color),
                        IconButton(onPressed: (){
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25)
                                ),
                              ),
                              context: context,
                              builder: (context){
                            return Info(title: widget.photo['title'], photographer: widget.photo['photographer'],
                            size: widget.photo['size'],);
                              });
                        }, icon: const Icon(Icons.info_outline),color: color)
                      ],
                    ),
                  ),
                    const SizedBox(height: 30,)
                ]),

            if (isLoading)const Center(child: CircularProgressIndicator(color: Colors.white,)),]
            ),

      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({Key? key, required this.title, required this.photographer, required this.size}) : super(key: key);

  final String title;
  final String photographer;
  final String size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: const Color(0xff2C3333),
          borderRadius:
      BorderRadius.circular(15)),
      height: MediaQuery.of(context).size.height*0.28,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25,),
          Center(child: Text(title, textAlign: TextAlign.center,style: const TextStyle(
              color: Colors.amberAccent, fontSize: 18, fontWeight: FontWeight.bold),)),
          const SizedBox(height: 25,),
          Text("Photographer : $photographer", style: const TextStyle(color: Colors.white70, fontSize: 15),),
          const SizedBox(height: 10),
          Text("Size : $size", style: const TextStyle(color: Colors.white70, fontSize: 15),),
          const SizedBox(height: 20,),
          const Text("PEXELS.COM", style: TextStyle(color: Colors.blue, fontSize: 15),),
        ],
      ),
    );
  }
}



extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}