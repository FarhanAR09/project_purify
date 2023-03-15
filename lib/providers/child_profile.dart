import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ChildProfilePreferences {
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

  ChildProfile? GetCurrentProfile(){
    if (_childProfiles != null && _currentIndex != null){
      SyncProviderPreferences();
      return _childProfiles![_currentIndex!];
    }
  }

  List<ChildProfile>? GetProfiles(){

      SyncProviderPreferences();
      return _childProfiles;




  }

  void SetPreferences(SharedPreferences pref){
    _preferences = pref;
  }

  //TODO: implement ChangeChildProfile
  void ChangeChildProfile({required int to}){
    if (_childProfiles != null){
      if (to < _childProfiles!.length){
        _currentIndex = to;
        SyncProviderPreferences();
        notifyListeners();
      }
    }
  }

  void CreateProfile(ChildProfile profile){
    if (_childProfiles != null) {
      _childProfiles!.add(profile);
      SyncProviderPreferences();
    }
    else{
      throw NullThrownError();
    }
  }

  ChildProfileProvider();

  factory ChildProfileProvider.init(){
    ChildProfileProvider provider = ChildProfileProvider();
    provider.SetPreferences(ChildProfilePreferences.GetPreferences());
    provider.DecodeFromPreferences();

    //If no profile yet
    if (provider._childProfiles == null){
      provider._childProfiles = <ChildProfile>[];
    }

    return provider;
  }

  void EncodeToPreferences(){
    //TODO: cek bener engga
    String json;
    if (_preferences != null){
      if (_currentIndex == null){
        _currentIndex = 0;
      }
      assert(_childProfiles != null);
      assert(_childProfiles!.length > 0);
      assert(_currentIndex != null);
      List<Map<String,dynamic>> profileMaps = <Map<String,dynamic>>[];
      for (int i = 0; i < _childProfiles!.length; i++){
        profileMaps.add(_childProfiles![i].toMap());
      }
      Map<String, dynamic> map = {
        'currentIndex' : _currentIndex!,
        'profiles' : profileMaps
      };
      json = jsonEncode(map);
      assert(json != null);
      _preferences!.setString('key', json);
    }
  }

  void DecodeFromPreferences(){
    //TODO: fix kalo belum punya profile, jangan throw error
    String json;
    final decodedJson;

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
          print(decodedJson['profiles']);
          List<dynamic> _profileMaps = decodedJson['profiles'];
          if (_profileMaps.isNotEmpty){
            _childProfiles ??= <ChildProfile>[];
            for (int i = 0; i < _profileMaps.length; i++){
              _childProfiles!.add(ChildProfile.fromMap(_profileMaps[i]));
            }
          }
        }
      }
    }
  }

  void SyncProviderPreferences(){
    if (_preferences != null){
      EncodeToPreferences();
      DecodeFromPreferences();
    }
  }
}

class ChildProfile {
  late String _name;
  late int _age;
  late double _weight;

  ChildProfile(String name, int age, double weight){
    _name = name;
    _age = age;
    _weight = weight;
  }

  factory ChildProfile.fromMap(Map<String,dynamic> map){
    assert(map['name'] != null);
    assert(map['age'] != null);
    assert(map['weight'] != null);
    return ChildProfile(map['name'], map['age'], map['weight']);
  }

  Map<String,dynamic> toMap(){
    return {
      'name' : _name,
      'age' : _age,
      'weight' : _weight
    };
  }

  String GetName() => _name;
  void SetName(String name) => _name = name;
  int GetAge() => _age;
  void SetAge(int age) => _age = age;
  double GetWeight() => _weight;
  void SetWeight(double weight) => _weight = weight;
}