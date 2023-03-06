import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ChildProfilePreferences {
  static SharedPreferences? _preferences;
  static const key = 'key';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static GetPreferences() => _preferences;

  static Future SetName(String name) async {
    await _preferences?.setString('name', name);
  }
  static Future SetAge(int age) async {
    await _preferences?.setInt('age', age);
  }
  static Future SetWeight(double weight) async {
    await _preferences?.setDouble('weight', weight);
  }

  static String? GetName() => _preferences?.getString('name');
  static int? GetAge() => _preferences?.getInt('age');
  static double? GetWeight() => _preferences?.getDouble('weight');
}

class ChildProfileProvider with ChangeNotifier {
  SharedPreferences? _preferences;
  ChildProfile? _currentProfile;
  List<ChildProfile>? _childProfiles;

  ChildProfile? GetChildProfile() => _currentProfile;

  void SetPreferences(SharedPreferences pref){
    _preferences = pref;
  }

  void ChangeChildProfile({required int to}){
    if (_childProfiles != null){
      if (to < _childProfiles!.length){
        _currentProfile = _childProfiles![to];
        notifyListeners();
      }
    }
  }

  ChildProfileProvider();

  factory ChildProfileProvider.init(){
    ChildProfileProvider provider = ChildProfileProvider();
    provider.SetPreferences(ChildProfilePreferences.GetPreferences());
    return provider;
  }

  void EncodeToPreferences(String json){
    if (_preferences != null){
      _preferences!.setString('key', json);
    }
  }

  void DecodeFromPreferences(){
    String json;
    final decodedJson;
    if (_preferences != null){
      json = _preferences!.getString('key').toString();
      decodedJson = jsonDecode(json);
    }
  }
}

class ChildProfile {
  late String _name;
  late int _age;
  late double _weight;

  String toJson(){
    return jsonEncode({'name':_name, 'age':_age, 'weight':_weight});
  }
}