import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_purify/providers/child_profile.dart';
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
      return Text("no food");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BuildNutritionContainer(),
          SizedBox(
            width: double.infinity,
            height: 32,
            child: TextFormField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Nama makanan',
              ),
            ),
          ),
          SizedBox(
            height: 32,
            child: ElevatedButton(
              onPressed: () async {
                final uri = Uri.parse(
                    'https://api.edamam.com/api/food-database/v2/parser?app_id=${EdamamFoodDatabase.APPID}&app_key=${EdamamFoodDatabase.APPKEY}&ingr=${_searchController.value.text}&nutrition-type=cooking'
                );
                final response = await http.get(uri);
                if (response.statusCode == 200) {
                  setState(() {
                    responseJson = response.body;
                    responseMap = jsonDecode(responseJson!);
                    if (responseMap!['parsed'].isNotEmpty){
                      food = Food.fromFoodMap(responseMap!['parsed'][0]['food']);
                    }
                  });
                }
                else {
                  //TODO: bad response handling (tergantung app)
                  //throw Exception("API error bruh");
                }
                _searchController.clear();
              },
              child: const Text(
                  "Search Food"
              ),
            ),
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
    );
  }
}