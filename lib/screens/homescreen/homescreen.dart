import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpexels/models/photoresource.dart';
import 'package:wallpexels/screens/favourites.dart';
import 'components/searchwidget.dart';
import 'components/colortones.dart';
import 'components/categories.dart';
import 'components/trendingphotos.dart';
import 'package:wallpexels/screens/splashscreen.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static bool isLoading = false;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  bool isLoading = true;

  goToHome(){
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    goToHome();
    // TODO: implement initState
    super.initState();
  }

  List<PhotoResource> trendingPhotos = [];

  //Main widget
  @override
  Widget build(BuildContext context) {
    return isLoading? SplashScreen() : const HomeBuilder();
  }
}

class HomeBuilder extends StatelessWidget {
  const HomeBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus){
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xff090910),
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Favourites()
                    ));
              }, icon: Icon(Icons.favorite))
            ],
            centerTitle: true,
            backgroundColor: const Color(0xff090910),
            elevation: 0.0,
            title: RichText(text: const TextSpan(
                children: [
                  TextSpan(text: 'Wall', style: TextStyle(
                      color: Colors.white,
                      fontSize: 22)),
                  TextSpan(text: 'Pexels', style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 22,
                      fontWeight: FontWeight.bold))
                ]
            ),),),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: const [
                SearchWidget(),
                SizedBox(height: 20,),
                TrendingPhotos(),
                SizedBox(height: 20.0,),
                ColorTones(),
                SizedBox(height: 20.0,),
                Categories(),
                SizedBox(height: 20.0,),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
