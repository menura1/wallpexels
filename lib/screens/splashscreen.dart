import 'package:flutter/material.dart';
import 'package:wallpexels/screens/homescreen/homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  

  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(text: const TextSpan(
                children: [
                  TextSpan(text: 'Wall', style: TextStyle(
                      color: Colors.white,
                      fontSize: 50)),
                  TextSpan(text: 'Pexels', style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 50,
                      fontWeight: FontWeight.bold))
                ]
            )),
          SizedBox(height: 20,),
          const CircularProgressIndicator(color: Colors.white70,)
          ],
        ),
      ),
    );
  }
}
