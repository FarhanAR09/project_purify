import 'package:flutter/material.dart';
import 'package:project_purify/providers/child_profile.dart';
import 'package:project_purify/screens/video_screen.dart';
import 'package:provider/provider.dart';

class MilestoneScreen extends StatefulWidget{
  const MilestoneScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return MilestoneScreenState();
  }
}

class MilestoneScreenState extends State<MilestoneScreen>{

  Widget videoTileBuilder(VideoInfo videoInfo){
    videoInfo.title ??= '';
    videoInfo.duration ??= 0;
    return Container(
      width: 64,
      height: 128,
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Thumbnail,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                videoInfo.title!
              ),
              Text(
                videoInfo.duration!.toString()
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<int> ages = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60];
  //for jadi error, whyyyy :v
  int? selectedAge;
  List<Widget> tabButtons = const
     [
      SizedBox(
          width: 128,
          height: 64,
          child: Text("Movement")
      ),
      SizedBox(
          width: 128,
          height: 64,
          child: Text("Cognitive")
      ),
      SizedBox(
          width: 128,
          height: 64,
          child: Text("Communication")
      ),
      SizedBox(
          width: 128,
          height: 64,
          child: Text("Emotional")
      ),
      SizedBox(
          width: 128,
          height: 64,
          child: Text("Activities")
      ),
    ];
  List<bool> selectedTabs = [false, false, false, false, false];
  int? selectedTabIndex;
  Widget buildBody(){
    if (selectedTabIndex != null){
      return bodyBuilders[selectedTabIndex!]();
    }
    else{
      return Container(
        alignment: Alignment.center,
        child: const Text("Select Any Tab"),
      );
    }
  }
  List<Function> bodyBuilders = [];
  
  @override
  Widget build(BuildContext context) {
    bodyBuilders = [
          (){ //----------MOVEMENT----------//
        return Container(
          alignment: Alignment.center,
          child: const Text('Movement'),
        );
      },
          (){ //----------COGNITIVE----------//
        return Container(
          alignment: Alignment.center,
          child: const Text('Cognitive'),
        );
      },
          (){ //----------COMMUNICATION----------//
        return Container(
          alignment: Alignment.center,
          child: const Text('Communication'),
        );
      },
          (){ //----------EMOTIONAL----------//
        return Container(
          alignment: Alignment.center,
          child: const Text('Emotional'),
        );
      },
          (){ //----------ACTIVITIES----------//
        return Container(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Activities'),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const VideoScreen()));
                },
                child: const Text('Screen Video'),
              )
            ],
          ),
        );
      },
    ];
    selectedAge ??= Provider.of<ChildProfileProvider>(context, listen: false).getCurrentProfile()?.getAge();
    selectedAge ??= 1; //default value if profile is still null
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButton(
              value: selectedAge,
              items: ages.map<DropdownMenuItem<int>>(
                      (int value){
                    return DropdownMenuItem(
                      value: value,
                      child: Text('Bulan ${value.toString()}'),
                    );
                  }
              ).toList(),
              onChanged: (int? value) {
                if (value != null){
                  setState(() {
                    selectedAge = value;
                  });
                }
              },
            ),
            SizedBox(
              height: 64,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ToggleButtons(
                    onPressed: (index){
                      setState(() {
                        for (int i = 0; i < selectedTabs.length; i++) {
                          selectedTabs[i] = i == index;
                          selectedTabIndex = index;
                        }
                      });
                    },
                    isSelected: selectedTabs,
                    children: tabButtons,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: buildBody(),
            ),
            SizedBox(
              child: ElevatedButton(
                child: const Text(
                    "back"
                ),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoInfo{
  //Picture thumbnail;
  String? title;
  int? duration;
  String id;
  String? description;
  List<Map<int,String>>? timestamps;

  //TODO: add picture field
  VideoInfo({this.title, this.duration, required this.id, this.description, this.timestamps});
}