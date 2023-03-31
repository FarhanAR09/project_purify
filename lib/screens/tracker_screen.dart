import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_purify/providers/child_profile.dart';
import 'package:project_purify/screens/home_screen.dart';
import 'package:project_purify/screens/milestone_screen.dart';
import 'package:provider/provider.dart';
import 'package:project_purify/keys.dart';
import 'package:http/http.dart' as http;

//TODO: edamam attribution (see edamam's food database api website)

class Food{
  late String name;
  late double calorie;
  late double protein;
  late double fat;
  late double carb;
  late double fiber;

  Food({
    required this.name,
    required this.calorie,
    required this.protein,
    required this.fat,
    required this.carb,
    required this.fiber
  });

    factory Food.fromFoodMap(Map<String, dynamic> map){
    return Food(
      name: map['label'],
      calorie: map['nutrients']['ENERC_KCAL'],
      protein: map['nutrients']['PROCNT'],
      fat: map['nutrients']['FAT'],
      carb: map['nutrients']['CHOCDF'],
      fiber: map['nutrients']['FIBTG'],
    );
  }
}

class ChildNutrition{
  late double calorie;
  late double protein;
  late double fat;
  late double carb;

  ChildNutrition({
    this.calorie = 0,
    this.protein = 0,
    this.fat = 0,
    this.carb = 0,
  });

  factory ChildNutrition.fromMap(Map<String, dynamic> map){
    return ChildNutrition(
        calorie: map['calorie'],
        protein: map['protein'],
        fat: map['fat'],
        carb: map['carb'],
    );
  }

  factory ChildNutrition.fromFoodMap(Map<String, dynamic> map, double mass){
    return ChildNutrition(
      calorie: map['nutrients']['ENERC_KCAL'] * mass / 100 ?? 0,
      protein: map['nutrients']['PROCNT'] * mass / 100 ?? 0,
      fat: map['nutrients']['FAT'] * mass / 100 ?? 0,
      carb: map['nutrients']['CHOCDF'] * mass / 100 ?? 0,
    );
  }

  String toJson(){
    return jsonEncode(toMap());
  }

  Map<String, dynamic> toMap(){
    return {
      'calorie' : calorie,
      'protein' : protein,
      'fat' : fat,
      'carb' : carb,
    };
  }

  String toString(){
    return "Calorie: $calorie, Protein: $protein, Fat: $fat, Carb: $carb";
  }
}

class TrackerScreen extends StatefulWidget{
  const TrackerScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return TrackerScreenState();
  }
}

class TrackerScreenState extends State<TrackerScreen>{
  final _searchController = TextEditingController();
  String? responseJson;
  Map<String, dynamic>? responseMap;
  Food? food;
  ChildNutrition childNutrition = ChildNutrition();

  List<bool> isOpenPanel = [false, false, false, false];

  late double caloriesNeeded;
  late double proteinNeeded;
  late double fatNeeded;
  late double carbNeeded;

  List<String> breakfasts = [];
  List<String> lunches = [];
  List<String> dinners = [];
  List<String> snacks = [];
  List<double> breakfastMasses = [];
  List<double> lunchMasses = [];
  List<double> dinnerMasses = [];
  List<double> snackMasses = [];

  Widget BuildNutritionContainer(){
    if (food != null){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Food: 100 gr of ${food!.name}"
          ),
          Text(
            "Carb: ${food!.carb.toString()} kcal"
          ),
          Text(
            "Protein: ${food!.protein.toString()} g"
          ),
          Text(
            "Fat: ${food!.fat.toString()} g"
          ),
          Text(
            "Fiber: ${food!.fiber.toString()} g"
          ),
        ],
      );
    }
    else {
      return const Text("no food");
    }
  }

  Widget buildChildNutritionInfo(BuildContext context){
    if (Provider.of<ChildProfileProvider>(context, listen: false).getCurrentProfile() != null){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Total Nutrition"
          ),
          Text(
              "Calorie: ${context.watch<ChildProfileProvider>().getCurrentProfile()!.getNutrition().calorie.toStringAsFixed(2)}"
          ),
          Text(
              "Protein: ${context.watch<ChildProfileProvider>().getCurrentProfile()!.getNutrition().protein.toStringAsFixed(2)}"
          ),
          Text(
              "Fat: ${context.watch<ChildProfileProvider>().getCurrentProfile()!.getNutrition().fat.toStringAsFixed(2)}"
          ),
          Text(
              "Carb: ${context.watch<ChildProfileProvider>().getCurrentProfile()!.getNutrition().carb.toStringAsFixed(2)}"
          ),
        ],
      );
    }
    return const Text('no profile!');
  }

  Widget buildInfo(){
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 23, 184, 151),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Caloric Intake",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${context.watch<ChildProfileProvider>().getCurrentProfile()!.getNutrition().calorie.toStringAsFixed(0)}/${caloriesNeeded.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ), //dari provider
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  color: Colors.lightGreen,
                  value: context.watch<ChildProfileProvider>().getCurrentProfile()!.getNutrition().calorie / caloriesNeeded,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      "Carbs",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.white,
                        color: Colors.lightGreen,
                        value: context.watch<ChildProfileProvider>().getCurrentProfile()!.getNutrition().carb / carbNeeded,
                      ),
                    ),
                    Text(
                      "${context.watch<ChildProfileProvider>().getCurrentProfile()!.getNutrition().carb.toStringAsFixed(0)}/${carbNeeded.toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      "Protein",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.white,
                        color: Colors.lightGreen,
                        value: context.watch<ChildProfileProvider>().getCurrentProfile()!.getNutrition().protein / proteinNeeded,
                      ),
                    ),
                    Text(
                      "${context.watch<ChildProfileProvider>().getCurrentProfile()!.getNutrition().protein.toStringAsFixed(0)}/${proteinNeeded.toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      "Fat",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.white,
                        color: Colors.lightGreen,
                        value: context.watch<ChildProfileProvider>().getCurrentProfile()!.getNutrition().fat / fatNeeded,
                      ),
                    ),
                    Text(
                      "${context.watch<ChildProfileProvider>().getCurrentProfile()!.getNutrition().fat.toStringAsFixed(0)}/${fatNeeded.toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  int _selectedNavBarIndex = 1;

  @override
  Widget build(BuildContext context) {
    List<Function> actions = [
          (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return HomeScreen();
        }));
      },
          (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return TrackerScreen();
        }));
      },
          (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return MilestoneScreen();
        }));
      },
    ];

    double inputMass = 100;
    void getFromAPI() async {
      if(!isOpenPanel.contains(true)){
        return;
      }
      final uri = Uri.parse(
          'https://api.edamam.com/api/food-database/v2/parser?app_id=${EdamamFoodDatabase.APPID}&app_key=${EdamamFoodDatabase.APPKEY}&ingr=${_searchController.value.text}&nutrition-type=cooking'
      );
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        setState(() {
          responseJson = response.body;
          responseMap = jsonDecode(responseJson!);
          if (responseMap!['parsed'].isNotEmpty){
            //2 decimal precision and default if null
            double? iCalorie = responseMap!['parsed'][0]['food']['ENERC_KCAL'];
            double? iProtein = responseMap!['parsed'][0]['food']['PROCNT'];
            double? iFat = responseMap!['parsed'][0]['food']['FAT'];
            double? iCarb = responseMap!['parsed'][0]['food']['CHOCDF'];
            iCalorie ??= 0;
            iProtein ??= 0;
            iFat ??= 0;
            iCarb ??= 0;
            responseMap!['parsed'][0]['food']['ENERC_KCAL'] = double.parse(iCalorie.toStringAsFixed(2));
            responseMap!['parsed'][0]['food']['PROCNT'] = double.parse(iProtein.toStringAsFixed(2));
            responseMap!['parsed'][0]['food']['FAT'] = double.parse(iFat.toStringAsFixed(2));
            responseMap!['parsed'][0]['food']['CHOCDF'] = double.parse(iCarb.toStringAsFixed(2));
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Weight of the Food"),
                content: TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: true),
                  onChanged: (String input){
                    inputMass = double.parse(input);
                  },
                ),
                actions: [
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                      return;
                    },
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);


                      //Continue to provider and preferences
                      food = Food.fromFoodMap(responseMap!['parsed'][0]['food']);
                      switch(isOpenPanel.indexOf(true)){
                        case 0:{
                          breakfasts.add(food!.name);
                          breakfastMasses.add(inputMass);
                          break;
                        }
                        case 1:{
                          lunches.add(food!.name);
                          lunchMasses.add(inputMass);
                          break;
                        }
                        case 2:{
                          dinners.add(food!.name);
                          dinnerMasses.add(inputMass);
                          break;
                        }
                        case 3:{
                          snacks.add(food!.name);
                          snackMasses.add(inputMass);
                          break;
                        }
                      }
                      //TODO: rice null exception????
                      childNutrition = ChildNutrition.fromFoodMap(responseMap!['parsed'][0]['food'], inputMass);
                      if (context.read<ChildProfileProvider>().getCurrentProfile() != null){
                        context.read<ChildProfileProvider>().getCurrentProfile()!.addNutrition(childNutrition);
                        context.read<ChildProfileProvider>().syncProviderPreferences();
                      }
                      setState((){});


                    },
                    child: Text("Submit"),
                  ),
                ],
              ),
              barrierDismissible: false,
            );

          }
        });
      }
      else {
        //TODO: bad response (400) handling (tergantung app)
        //throw Exception("API error bruh");
      }
      _searchController.clear();
    }
    Widget buildFoodItem(String name, double mass){
      return Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(name),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text("${mass.toStringAsFixed(2)} gr"),
            ),
          )
        ],
      );
    }
    List<Widget> buildFoodList(int when){
      List<Widget> items = [];
      switch(when){
        case 0:{
          for (int i = 0; i < breakfasts.length; i++) {
            items.add(buildFoodItem(breakfasts[i], breakfastMasses[i]));
          }
          break;
        }
        case 1:{
          for (int i = 0; i < lunches.length; i++) {
            items.add(buildFoodItem(lunches[i], lunchMasses[i]));
          }
          break;
        }
        case 2:{
          for (int i = 0; i < dinners.length; i++) {
            items.add(buildFoodItem(dinners[i], dinnerMasses[i]));
          }
          break;
        }
        case 3:{
          for (int i = 0; i < snacks.length; i++) {
            items.add(buildFoodItem(snacks[i], snackMasses[i]));
          }
          break;
        }
      }
      return items;
    }
    Widget buildPanelBody(){
      return Container(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Column(
              children: buildFoodList(isOpenPanel.indexOf(true)),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                onPressed: getFromAPI,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromARGB(255, 20, 163, 134),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                      "Add Food"
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    int currentAge = context.read<ChildProfileProvider>().getCurrentProfile()!.getAge();
    if (currentAge <= 6){
      caloriesNeeded = 600;
      proteinNeeded = 9.1;
      fatNeeded = 30;
      carbNeeded = 60;
    }
    else if (currentAge >= 7 && currentAge <= 12){
      caloriesNeeded = 800;
      proteinNeeded = 11;
      fatNeeded = 31;
      carbNeeded = 90;
    }
    else if (currentAge >= 13 && currentAge <= 24){
      caloriesNeeded = 1100;
      proteinNeeded = 13;
      fatNeeded = 40;
      carbNeeded = 130;
    }
    else if (currentAge >= 25){
      caloriesNeeded = 1100;
      proteinNeeded = 13;
      fatNeeded = 50;
      carbNeeded = 130;
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
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
                    const Text(
                      "Nutrition Diary",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: -8,
                        blurRadius: 16,
                        offset: Offset(0,4),
                      ),
                    ],
                  ),
                  height: 32,
                  child: TextFormField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search Food',
                      icon: Icon(Icons.search, color: Colors.grey, size: 24,),
                    ),
                  ),
                ),
                const SizedBox(height: 24,),
                buildInfo(),
                const SizedBox(height: 32,),
                ExpansionPanelList(
                  dividerColor: Colors.transparent,
                  elevation: 0,
                  children: [
                    ExpansionPanel(
                      backgroundColor: const Color.fromARGB(255, 242, 244, 245),
                      isExpanded: isOpenPanel[0],
                      headerBuilder: (context, open){
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "Breakfast",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                      body: buildPanelBody(),
                    ),
                    ExpansionPanel(
                      backgroundColor: const Color.fromARGB(255, 242, 244, 245),
                      isExpanded: isOpenPanel[1],
                      headerBuilder: (context, open){
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "Lunch",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                      body: buildPanelBody(),
                    ),
                    ExpansionPanel(
                      backgroundColor: const Color.fromARGB(255, 242, 244, 245),
                      isExpanded: isOpenPanel[2],
                      headerBuilder: (context, open){
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Dinner",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                      body: buildPanelBody(),
                    ),
                    ExpansionPanel(
                      backgroundColor: const Color.fromARGB(255, 242, 244, 245),
                      isExpanded: isOpenPanel[3],
                      headerBuilder: (context, open){
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Snack",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                      body: buildPanelBody(),
                    ),
                  ],
                  expansionCallback: (i, isOpen){
                    setState(() {
                      isOpenPanel[i] = !isOpen;
                      for (int j = 0; j < isOpenPanel.length; j++){
                        if (i != j){
                          isOpenPanel[j] = false;
                        }
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 36,),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.soup_kitchen, size: 36,),
            label: "Tracker",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded, size: 36,),
            label: "Milestone",
          ),
        ],
        currentIndex: _selectedNavBarIndex,
        selectedItemColor: const Color.fromARGB(255, 0, 83, 98),
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (int index){
          setState(() {
            _selectedNavBarIndex = index;
            actions[index]();
          });
        },
      ),
    );
  }
}