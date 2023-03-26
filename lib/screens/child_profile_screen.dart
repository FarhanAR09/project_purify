import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_purify/providers/child_profile.dart';
import 'package:provider/provider.dart';
import 'package:project_purify/screens/tracker_screen.dart';

class ChildProfileCreationScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ChildProfileCreationScreenState();
  }
}

class ChildProfileCreationScreenState extends State<ChildProfileCreationScreen>{
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  bool _selectedSex = true;
  List<bool> _selectedSexes = <bool>[true, false];
  final _changeController = TextEditingController();
  int _age = 0;

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
              keyboardType: TextInputType.none,
              controller: _ageController,
              decoration: const InputDecoration(
                hintText: "Usia",
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              onTap: () async {
                DateTime now = DateTime.now();
                DateTime? born = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: DateTime(2018),
                    lastDate: DateTime.now()
                );
                if (born != null){
                  _age = (now.year - born.year) * 12 + (now.month - born.month);
                  _ageController.text = _age.toString();
                }
              },
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
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^[0-9,;.]+$')),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 32,
            child: TextFormField(
              keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: true),
              controller: _heightController,
              decoration: const InputDecoration(
                hintText: "Tinggi Badan",
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^[0-9,;.]+$')),
              ],
            ),
          ),
          SizedBox(
            child: ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index){
                setState(() {
                  if (index == 1){
                    _selectedSex = false;
                    _selectedSexes = [false, true];
                  }
                  else{
                    _selectedSex = true;
                    _selectedSexes = [true, false];
                  }
                });
              },
              isSelected: _selectedSexes,
              children: const [
                Icon(Icons.male),
                Icon(Icons.female),
              ],
            ),
          ),
          SizedBox(
            height: 32,
            child: ElevatedButton(
              onPressed: (){
                if (_nameController.value.text != '' && _ageController.value.text != '' && _weightController.value.text != ''){
                  String weight = _weightController.value.text.replaceAll(',', '.');
                  String height = _heightController.value.text.replaceAll(',', '.');

                  ChildProfile childProfile = ChildProfile(
                    _nameController.text,
                    _age,
                    double.parse(weight),
                    double.parse(height),
                    _selectedSex,
                    ChildNutrition(),
                  );
                  context.read<ChildProfileProvider>().createProfile(childProfile);

                  //Reset TextFormField
                  _nameController.clear();
                  _ageController.clear();
                  _weightController.clear();
                  _heightController.clear();
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
                //TODO: jangan ke login lagi kalo dah bikin
                Navigator.pop(context);
              },
              child: Text(
                  "Back"
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            width: double.infinity,
            height: 32,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _changeController,
              decoration: const InputDecoration(
                hintText: 'Ganti ke',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
            ),
          ),
          SizedBox(
            //TODO: pake DropDownButton (cari lain aja deng)
            height: 32,
            child: ElevatedButton(
              onPressed: (){
                context.read<ChildProfileProvider>().changeChildProfile(to: int.parse(_changeController.value.text) - 1);
                _changeController.clear();
              },
              child: const Text(
                  "Change Profile"
              ),
            ),
          ),
        ],
      ),
    );
  }

}