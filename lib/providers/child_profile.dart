import 'package:flutter/material.dart';

class ChildProfileProvider with ChangeNotifier {
  ChildProfile? _currentProfile;
  List<ChildProfile>? _childProfiles;

  ChildProfile? GetChildProfile() => _currentProfile;

  void ChangeChildProfile({required int to}){
    if (_childProfiles != null){
      if (to < _childProfiles!.length){
        _currentProfile = _childProfiles![to];
        notifyListeners();
      }
    }
  }
}

class ChildProfile {
  late String _name;
  late int _ageMonth;
  late double _weight;

  ChildProfile({required String name, required int ageMonth, required double weight}){
    _name = name;
    _ageMonth = ageMonth;
    _weight = weight;
  }
}