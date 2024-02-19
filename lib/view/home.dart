// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:math';

import 'package:animation/controller/animate_pro.dart';
import 'package:animation/view/all.dart';
import 'package:animation/view/messier.dart';
import 'package:animation/view/planet.dart';
import 'package:animation/view/star.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/planet_model.dart';
import 'detailpage.dart';

class Home extends StatefulWidget {
  final Planet? pm;

  const Home({super.key, this.pm});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  List<String> typeList = [
    "All",
    "Planets",
    "Stars",
    "Messier",
  ];

  late final animationController = AnimationController(
    vsync: this,
    upperBound: 2 * pi,
    lowerBound: 0,
    animationBehavior: AnimationBehavior.preserve,
    duration: Duration(seconds: 10),
  );
  late final curvedAnimation = CurvedAnimation(
      parent: animationController, curve: FlippedCurve(Curves.linear));

  void initState() {
    animationController.repeat();
    var planet = Provider.of<AnimatePro>(context, listen: false);
    planet.getValue();
    planet.foundList = planet.planetList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "My  Galaxy ",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.transparent,
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.asset(
            "assets/logo.png",
          ),
        ),
        actions: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Color(0xff0B1418),
            child: Center(
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.home_filled,
                    size: 30,
                    color: Colors.white,
                  )),
            ),
          ),
          CircleAvatar(
            radius: 40,
            backgroundColor: Color(0xff0B1418),
            child: Center(
              child: Hero(
                tag: "mylike",
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "LikePage");
                  },
                  icon: Icon(
                    Icons.favorite,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Align(
              alignment: Alignment(-0.7, 0),
              child: Text(
                "Let's Explore!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.w900),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Consumer<AnimatePro>(
                builder: (BuildContext context, AnimatePro value1,
                    Widget? child) {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.1,
                    child: TextFormField(
                      onChanged: (value) {
                        value1.show();
                        value1.runFiLLTer(value);
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          CupertinoIcons.search,
                          size: 30,
                        ),
                        hintText: "Search For More Planets",
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        fillColor: Color(0xff0B1418),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Consumer<AnimatePro>(
              builder: (context, value, child) {
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.08,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: typeList.length,
                    itemBuilder: (context, index) {
                      String type = typeList[index];
                      return InkWell(
                        onTap: () {
                          value.changeIndex(index);
                        },
                        child: Container(
                            margin: EdgeInsets.all(20),
                            child: Text(
                              type,
                              style: TextStyle(
                                  color: (index == value.typeIndex)
                                      ? Colors.blue
                                      : Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            )),
                      );
                    },
                  ),
                );
              },
            ),
            Consumer<AnimatePro>(
              builder: (context, value, child) {
                return IndexedStack(
                  index: value.typeIndex,
                  children: [
                    All(
                      pm: value.planetList,
                    ),
                    Planets(pm: value.planetList),
                    Star(),
                    Messier(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
