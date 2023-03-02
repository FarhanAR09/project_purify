import 'package:flutter/material.dart';
import 'package:project_purify/screens/child_profile_screen.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ini home"
            ),
            SizedBox(
              child: ElevatedButton(
                child: Text(
                    "Create new profile"
                ),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChildProfileCreationScreen()
                      )
                  );
                },
              ),
            ),
            SizedBox(
              child: ElevatedButton(
                child: Text(
                    "back"
                ),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        )
      ),
    );
  }
}