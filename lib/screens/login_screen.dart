import 'package:flutter/material.dart';
import 'package:project_purify/screens/child_profile_screen.dart';
import 'package:project_purify/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:project_purify/providers/child_profile.dart';

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
                if (Provider.of<ChildProfileProvider>(context, listen: false).getCurrentProfile() != null){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                }
                else{
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChildProfileCreationScreen()));
                }

              },
            ),
        )
      ),
    );
  }

}