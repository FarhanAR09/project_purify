import 'package:flutter/material.dart';

class ChildProfileCreationScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ChildProfileCreationScreenState();
  }
}

class ChildProfileCreationScreenState extends State<ChildProfileCreationScreen>{
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Ini screen untuk buat child profile",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: double.infinity,
            height: 32,
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: "Nama",
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 32,
            child: TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(
                hintText: "Usia",
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 32,
            child: TextFormField(
              controller: _weightController,
              decoration: const InputDecoration(
                hintText: "Berat Badan",
              ),
            ),
          ),
          SizedBox(
            height: 32,
            child: ElevatedButton(
              onPressed: (){
                //TODO: submit form
              },
              child: Text(
                  "Create Profile"
              ),
            ),
          ),
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
      ),
    );
  }

}