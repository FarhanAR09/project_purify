import 'package:flutter/material.dart';
import 'package:project_purify/providers/child_profile.dart';
import 'package:project_purify/screens/child_profile_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen>{

  //TODO: null while building home
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
            BuildProfileContainer(),
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

  Widget BuildProfileContainer(){
    ChildProfile? profile = context.watch<ChildProfileProvider>().GetCurrentProfile();
    if (profile != null){
      return Column(
        children: [
          Text(
              profile.GetName()
          ),
          Text(
              profile.GetAge().toString()
          ),
          Text(
              profile.GetWeight().toString()
          ),
        ],
      );
    }
    else{
      return Container(
        child: Text('No profile'),
      );
    }
  }
}