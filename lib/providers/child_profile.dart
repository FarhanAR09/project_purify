import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ChildProfilePreferences {
  //TODO: table check
  static SharedPreferences? _preferences;
  static const key = 'key';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static GetPreferences() => _preferences;
}

class ChildProfileProvider with ChangeNotifier {
  SharedPreferences? _preferences;
  int? _currentIndex;
  List<ChildProfile>? _childProfiles;

  ChildProfile? GetChildProfile(){
    if (_childProfiles != null && _currentIndex != null){
      SyncProviderPreferences();
      return _childProfiles![_currentIndex!];
    }
    else {
      throw NullThrownError();
    }
  }

  void SetPreferences(SharedPreferences pref){
    _preferences = pref;
  }

  void ChangeChildProfile({required int to}){
    if (_childProfiles != null){
      if (to < _childProfiles!.length){
        _currentIndex = to;
        SyncProviderPreferences();
        notifyListeners();
      }
    }
    else {
      throw NullThrownError();
    }
  }

  void CreateProfile(ChildProfile profile){
    if (_childProfiles != null) {
      _childProfiles!.add(profile);
      SyncProviderPreferences();
    }
    else {
      throw NullThrownError();
    }
  }

  ChildProfileProvider();

  factory ChildProfileProvider.init(){
    ChildProfileProvider provider = ChildProfileProvider();
    provider.SetPreferences(ChildProfilePreferences.GetPreferences());
    provider.DecodeFromPreferences();
    return provider;
  }

  void EncodeToPreferences(){
    //TODO: cek bener engga
    String json;
    if (_preferences != null){
      json = jsonEncode(
          {
            'currentIndex' : _currentIndex,
            'profiles' : _childProfiles
          }
      );
      _preferences!.setString('key', json);
    }
  }

  void DecodeFromPreferences(){
    //TODO: cek bener engga
    String json;
    final decodedJson;
    if (_preferences != null){
      json = _preferences!.getString('key').toString();
      decodedJson = jsonDecode(json);
      if (decodedJson != null){
        if (decodedJson['currentIndex'] != null && decodedJson['profiles'] != null){
          _currentIndex = decodedJson['currentIndex'];
          _childProfiles = decodedJson['profiles'];
        }
        else {
          throw NullThrownError();
        }
      }
      else {
        throw NullThrownError();
      }
    }
    else {
      throw NullThrownError();
    }
  }

  void SyncProviderPreferences(){
    if (_preferences != null){
      EncodeToPreferences();
      DecodeFromPreferences();
    }
    else {
      throw NullThrownError();
    }
  }
}

class ChildProfile {
  late String _name;
  late int _age;
  late double _weight;

  String GetName() => _name;
  void SetName(String name) => _name = name;
  int GetAge() => _age;
  void SetAge(int age) => _age = age;
  double GetWeight() => _weight;
  void SetWeight(double weight) => _weight = weight;
}