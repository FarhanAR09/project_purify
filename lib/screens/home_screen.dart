import 'package:flutter/material.dart';
import 'package:project_purify/providers/child_profile.dart';
import 'package:project_purify/screens/child_profile_screen.dart';
import 'package:project_purify/screens/milestone_screen.dart';
import 'package:project_purify/screens/tracker_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen>{

  //TODO: bikin milestone
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
                    "Create or Change Profile"
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
                    "Milestone"
                ),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MilestoneScreen()
                      )
                  );
                },
              ),
            ),
            SizedBox(
              child: ElevatedButton(
                child: Text(
                    "Tracker"
                ),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TrackerScreen()
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
    ChildProfile? profile = context.watch<ChildProfileProvider>().getCurrentProfile();
    if (profile != null){
      return Column(
        children: [
          Text(
            "Nama: ${profile.getName()}"
          ),
          Text(
            "Age: ${profile.getAge().toString()}"
          ),
          Text(
            "Weight: ${profile.getWeight().toString()}"
          ),
          Text(
            "Height: ${profile.getHeight().toString()}"
          ),
          Text(
            "Sex: ${profile.getSex().toString()}"
          )
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