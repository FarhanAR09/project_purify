import 'package:flutter/material.dart';
import 'package:project_purify/screens/home_screen.dart';

class LoginScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            child: ElevatedButton(
              child: const Text(
                  "Login"
              ),
              onPressed: (){
                //TODO: bikin sistem profil buat if di sini. kalo belum punya profil bayi (null), gas ke bikin profil
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
        )
      ),
    );
  }

}