// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:math';

import 'package:animation/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/planet_model.dart';

class AnimatePro extends ChangeNotifier {
  int typeIndex = 0;
  int planetIndex = 0;
  double turns = Random().nextInt(100).toDouble();
  List<Planet> planetList = [];
  List<Planet> favList = [];
  String favStr = "";
  Duration duration = Duration();

  void changeIndex(int index) {
    typeIndex = index;
    notifyListeners();
  }

  void addFavList(Planet planet) {
    favList.add(planet);
    favStr = jsonEncode(favList.map((e) => e.toJson()).toList());
    preferences.setString("favStr", favStr);
    notifyListeners();
  }
void remove(int index){
    favList.removeAt(index);
    notifyListeners();
}
  void getFavList() async {
    String? favStr = preferences.getString("favStr");
    if (favStr != null) {
      List<dynamic> decode = jsonDecode(favStr);
      decode.map((json) => json.fromJson(json)).toList();
    }
    notifyListeners();
  }

  void playIndex(int index) {
    planetIndex = index;
    notifyListeners();
  }

  void rotation(double turns, int duration) {
    turns = turns;
    Duration(seconds: 100);
    notifyListeners();
  }

  Future<void> getValue() async {
    var fileData = await rootBundle.loadString("lib/model/planet_detail.json");
    jsonDecode(fileData);
    planetList = planetFromJson(fileData);
    notifyListeners();
  }
}
