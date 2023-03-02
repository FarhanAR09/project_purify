import 'package:flutter/material.dart';

class ChildProfileCreationScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ChildProfileCreationScreenState();
  }
}

class ChildProfileCreationScreenState extends State<ChildProfileCreationScreen>{
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Ini screen untuk buat child profile",
          textAlign: TextAlign.center,
        ),
        //TODO: buat profile creation
        SizedBox(
          height: 32,
          child: ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text(
                "Back"
            ),
          ),
        ),
      ],
    );
  }

}