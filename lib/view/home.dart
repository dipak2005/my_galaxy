// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animation/controller/animate_pro.dart';
import 'package:animation/view/all.dart';
import 'package:animation/view/messier.dart';
import 'package:animation/view/planet.dart';
import 'package:animation/view/star.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/planet_model.dart';

class Home extends StatefulWidget {
  final Planet? pm;

  const Home({super.key, this.pm});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> typeList = [
    "All",
    "Planets",
    "Stars",
    "Messier",
  ];

  @override
  void initState() {
    var planet = Provider.of<AnimatePro>(context, listen: false);
    planet.getValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Planet? pluRo;
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
                tag: "like",
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "LikePage");
                    },
                    icon: Icon(
                      Icons.favorite,
                      size: 30,
                      color: Colors.red,
                    )),
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
              child: TextFormField(
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
                      pluRo = value.planetList[index];
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
                    All(pm: value.planetList),
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
