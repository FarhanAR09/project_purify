import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_purify/providers/child_profile.dart';
import 'package:provider/provider.dart';

class MilestoneScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MilestoneScreenState();
  }
}

class MilestoneScreenState extends State<MilestoneScreen>{
  List<int> ages = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60];
  //Kalau gak gini, error, whyyyy :v
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
  List<Function> bodyBuilders = [
    (){ //Movement
      return Container(
        alignment: Alignment.center,
        child: const Text('Movement'),
      );
    },
    (){ //Cognitive
      return Container(
        alignment: Alignment.center,
        child: const Text('Cognitive'),
      );
    },
    (){ //Communication
      return Container(
        alignment: Alignment.center,
        child: const Text('Communication'),
      );
    },
    (){ //Emotional
      return Container(
        alignment: Alignment.center,
        child: const Text('Emotional'),
      );
    },
    (){ //Activities
      return Container(
        alignment: Alignment.topCenter,
        child: const Text('Activities'),
      );
    },
  ];

  @override
  Widget build(BuildContext context) {
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