import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_purify/providers/child_profile.dart';
import 'package:project_purify/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'child_profile_screen.dart';


class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration(seconds: 3),
            () {
              if (context.read<ChildProfileProvider>().getCurrentProfile() != null){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              }
              else{
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChildProfileCreationScreen()));
              }
            }
    );
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 0, 117, 95),
              Color.fromARGB(255, 0, 68, 55),
            ],
          )
      ),
      child: Center(
        child: Image.asset("assets/images/sprout_text.png"),
      ),
    );
  }

}