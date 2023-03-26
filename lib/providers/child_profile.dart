import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:project_purify/screens/tracker_screen.dart';

class ChildProfilePreferences {
  static SharedPreferences? _preferences;
  static const key = 'key';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static getPreferences() => _preferences;
}

class ChildProfileProvider with ChangeNotifier {
  SharedPreferences? _preferences;
  int? _currentIndex;
  List<ChildProfile>? _childProfiles;

  ChildProfile? getCurrentProfile(){
    if (_childProfiles != null && _currentIndex != null){
      syncProviderPreferences();
      return _childProfiles![_currentIndex!];
    }
    return null;
  }

  int? getIndex() => _currentIndex;

  List<ChildProfile>? getProfiles(){
      syncProviderPreferences();
      return _childProfiles;
  }

  void setPreferences(SharedPreferences pref){
    _preferences = pref;
  }

  void changeChildProfile({required int to}){
    if (_childProfiles != null){
      if (to < _childProfiles!.length){
        _currentIndex = to;
        syncProviderPreferences();
        notifyListeners();
      }
    }
  }

  void createProfile(ChildProfile profile){
    if (_childProfiles != null) {
      _childProfiles!.add(profile);
      syncProviderPreferences();
    }
    else{
      throw NullThrownError();
    }
  }

  ChildProfileProvider();

  factory ChildProfileProvider.init(){
    ChildProfileProvider provider = ChildProfileProvider();
    provider.setPreferences(ChildProfilePreferences.getPreferences());
    provider.decodeFromPreferences();

    //Prevents null
    provider._childProfiles ??= <ChildProfile>[];

    return provider;
  }

  void encodeToPreferences(){
    String json;
    if (_preferences != null){
      _currentIndex ??= 0;
      List<Map<String,dynamic>> profileMaps = <Map<String,dynamic>>[];
      for (int i = 0; i < _childProfiles!.length; i++){
        profileMaps.add(_childProfiles![i].toMap());
      }
      Map<String, dynamic> map = {
        'currentIndex' : _currentIndex!,
        'profiles' : profileMaps
      };
      json = jsonEncode(map);
      _preferences!.setString('key', json);
    }
  }

  void decodeFromPreferences(){
    String json;
    dynamic decodedJson;

    //Reset Provider
    if (_childProfiles != null){
      _childProfiles = <ChildProfile>[];
    }
    _currentIndex = null;

    //Get from Preferences and Set to Provider's Variables
    if (_preferences != null){
      json = _preferences!.getString('key').toString();
      decodedJson = jsonDecode(json);
      if (decodedJson != null){
        if (decodedJson['currentIndex'] != null && decodedJson['profiles'] != null){
          _currentIndex = decodedJson['currentIndex'];
          List<dynamic> profileMaps = decodedJson['profiles'];
          if (profileMaps.isNotEmpty){
            _childProfiles ??= <ChildProfile>[];
            for (int i = 0; i < profileMaps.length; i++){
              _childProfiles!.add(ChildProfile.fromMap(profileMaps[i]));
            }
          }
        }
      }
    }
  }

  void syncProviderPreferences(){
    //TODO: error kalo nambah field pas udah punya profile, bikin null safety atau default value
    if (_preferences != null){
      encodeToPreferences();
      decodeFromPreferences();
    }
  }
}

class ChildProfile {
  late String _name = '';
  late int _age = 0;
  late double _weight = 0.0;
  late double _height = 0.0;
  late bool _sex = true;
  late ChildNutrition _childNutrition = ChildNutrition();

  ChildProfile(String name, int age, double weight, double height, bool sex, ChildNutrition childNutrition){
    _name = name;
    _age = age;
    _weight = weight;
    _height = height;
    _sex = sex;
    _childNutrition = childNutrition;
  }

  factory ChildProfile.fromMap(Map<String,dynamic> map){
    //assert(map['name'] != null);
    //assert(map['age'] != null);
    //assert(map['weight'] != null);
    return ChildProfile(
      map['name'],
      map['age'],
      map['weight'],
      map['height'],
      map['sex'],
      ChildNutrition.fromMap(map['childNutrition']),
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'name' : _name,
      'age' : _age,
      'weight' : _weight,
      'height' : _height,
      'sex' : _sex,
      'childNutrition' : _childNutrition.toMap(),
    };
  }

  String getName() => _name;
  void setName(String name) => _name = name;
  int getAge() => _age;
  void setAge(int age) => _age = age;
  double getWeight() => _weight;
  void setWeight(double weight) => _weight = weight;
  double getHeight() => _height;
  void setHeight(bool sex) => _sex = sex;
  bool getSex() => _sex;
  void setSex(bool sex) => _sex = sex;
  ChildNutrition getNutrition() => _childNutrition;
  void setNutrition({
    double? calorie,
    double? protein,
    double? fat,
    double? carb,
  }){
    if (calorie != null){
      _childNutrition.calorie = calorie;
    }
    if (protein != null){
      _childNutrition.protein = protein;
    }
    if (fat != null){
      _childNutrition.fat = fat;
    }
    if (carb != null){
      _childNutrition.carb = carb;
    }
  }
  void resetNutrition(){
    _childNutrition.calorie = 0;
    _childNutrition.protein = 0;
    _childNutrition.fat = 0;
    _childNutrition.carb = 0;
  }
  void addNutrition(ChildNutrition nutrition){
    _childNutrition.calorie += nutrition.calorie;
    _childNutrition.protein += nutrition.protein;
    _childNutrition.fat += nutrition.fat;
    _childNutrition.carb += nutrition.carb;
  }
}