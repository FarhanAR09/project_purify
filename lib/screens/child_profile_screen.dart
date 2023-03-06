import 'package:flutter/material.dart';
import 'package:project_purify/providers/child_profile.dart';

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Ini screen untuk buat child profile",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: double.infinity,
            height: 32,
            child: TextFormField(
              keyboardType: TextInputType.text,
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
              keyboardType: TextInputType.number,
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
              keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: true),
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
                if (_nameController.value != null && _ageController.value != null && _weightController != null){
                  //ChildProfile.SetName(_nameController.value.toString());
                  //TODO: SetAge() dan SetWeight()
                }
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