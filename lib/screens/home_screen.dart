import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "ini home"
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
    );
  }

}