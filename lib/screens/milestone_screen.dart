import 'package:flutter/material.dart';
import 'package:project_purify/providers/child_profile.dart';
import 'package:provider/provider.dart';

class MilestoneScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MilestoneScreenState();
  }
}

class MilestoneScreenState extends State<MilestoneScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //TODO: month selection, body, placeholder
          Row(
            children: [
              const Flexible(
                flex: 1,
                child: SizedBox(),
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
          ),
          ListView(

          ),
        ],
      ),
    );
  }
}