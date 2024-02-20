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
  List<Planet> foundList = [];
  bool isList = false;
  bool isDark = preferences.getBool("dark") ?? false;

  void changeIndex(int index) {
    typeIndex = index;
    notifyListeners();
  }

  void theme() {
    isDark = !isDark;
    preferences.setBool("dark", isDark);
    notifyListeners();
  }

  void show() {
    isList = true;
    notifyListeners();
  }

  void runFiLLTer(String key) {
    List<Planet> result = [];
    if (key.isEmpty) {
      result = planetList;
    } else {
      result = planetList
          .where((element) => element.name.toString().contains(
                key.toString(),
              ))
          .toList();
    }
    foundList = result;
    notifyListeners();
  }

  void addFavList(Planet planet) {
    favList.add(planet);
    favStr = jsonEncode(favList.map((product) => product.toJson()).toList());
    preferences.setString("cart", favStr);
    notifyListeners();
  }

  void saveData() {
    print("SAVED LOCALLY");
    notifyListeners();
  }

  void getData() async {
    print("GET DATA FROM LOCAL");

    String? favListJson = preferences.getString('cart');
    if (favListJson != null) {
      List<dynamic> decodedList = jsonDecode(favListJson);
      favList = decodedList.map((json) => Planet.fromJson(json)).toList();
      print(favList.length);
    }
    notifyListeners();
  }

  void remove(int index) {
    favList.removeAt(index);
    notifyListeners();
  }

  // void getFavList() async {
  //   String? favStr = preferences.getString("favStr");
  //
  //   notifyListeners();
  // }

  void playIndex(int index) {
    planetIndex = index;
    notifyListeners();
  }

  void rotation(double turns, int duration) {
    turns = turns;
    Duration(seconds: 100);
    notifyListeners();
  }

  Future<void> getdata() async {
    var fileData = await rootBundle.loadString("lib/model/planet_detail.json");
    jsonDecode(fileData);
    planetList = planetFromJson(fileData);
    notifyListeners();
  }
}
