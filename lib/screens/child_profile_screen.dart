import 'package:flutter/material.dart';
import 'package:project_purify/providers/child_profile.dart';
import 'package:provider/provider.dart';

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

  String ConvertCommaToDot(String str){
    for (int i = 0; i < str.length; i++){
      if (str[i] == ','){
        str.replaceRange(i, i, '.');
      }
    }
    return str;
  }

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
                if (_nameController.value != null && _ageController.value != null && _weightController.value != null){
                  String age = ConvertCommaToDot(_ageController.value.toString());
                  String weight = ConvertCommaToDot(_weightController.value.toString());
                  ChildProfile childProfile = ChildProfile(
                      _nameController.value.toString(),
                      int.parse(age),
                      double.parse(weight)
                  );
                  context.read<ChildProfileProvider>().CreateProfile(childProfile);
                  //TODO: cek bener gak
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