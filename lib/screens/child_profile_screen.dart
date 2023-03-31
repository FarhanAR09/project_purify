import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_purify/providers/child_profile.dart';
import 'package:project_purify/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:project_purify/screens/tracker_screen.dart';

class ChildProfileCreationScreen extends StatefulWidget{
  const ChildProfileCreationScreen({super.key});

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
  int _age = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.black,),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  child: Text(
                    "Enter your child's profile",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  child: const Text(
                    "Child's Name",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container (
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.black54
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 16, right: 16,),
                  width: double.infinity,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Name",
                    ),
                  ),
                ),
                const SizedBox(height: 8,),
                Container(
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  child: const Text(
                    "Date of Birth",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container (
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.transparent,
                    border: Border.all(
                        color: Colors.black54
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 16, right: 16,),
                  width: double.infinity,
                  child: TextFormField(
                    keyboardType: TextInputType.none,
                    controller: _ageController,
                    decoration: const InputDecoration(
                      hintText: "Choose Date",
                      icon: Icon(Icons.calendar_month, color: Colors.grey,),
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
                const SizedBox(height: 8,),
                Container(
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  child: const Text(
                    "Weight",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container (
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.transparent,
                    border: Border.all(
                        color: Colors.black54
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 16, right: 16,),
                  width: double.infinity,
                  child: TextFormField(
                    keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: true),
                    controller: _weightController,
                    decoration: const InputDecoration(
                      hintText: "Weight",
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9,;.]+$')),
                    ],
                  ),
                ),
                const SizedBox(height: 8,),
                Container(
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  child: const Text(
                    "Height",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container (
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.transparent,
                    border: Border.all(
                        color: Colors.black54
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 16, right: 16,),
                  width: double.infinity,
                  child: TextFormField(
                    keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: true),
                    controller: _heightController,
                    decoration: const InputDecoration(
                      hintText: "Height",
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9,;.]+$')),
                    ],
                  ),
                ),
                const SizedBox(height: 8,),
                Container(
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  child: const Text(
                    "Sex at Birth",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ToggleButtons(
                  splashColor: Colors.transparent,
                  renderBorder: false,
                  selectedBorderColor: Colors.transparent,
                  selectedColor: Colors.greenAccent,
                  fillColor: Colors.transparent,
                  borderColor: Colors.transparent,
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 40)/2,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 8, right: 8,),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: Colors.transparent,
                          border: Border.all(
                              color: Colors.black
                          ),
                        ),
                        child: const Text(
                          "Boy",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 40)/2,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 8, right: 8,),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: Colors.transparent,
                          border: Border.all(
                              color: Colors.black
                          ),
                        ),
                        child: const Text(
                          "Girl",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
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

                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: const Color.fromARGB(255, 25, 204, 168),
                    ),
                    padding: const EdgeInsets.only(left: 8, right: 8,),
                    child: const Text(
                      "Create Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}