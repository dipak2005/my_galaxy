// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:animation/controller/animate_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> with TickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    upperBound: 2 * pi,
    lowerBound: 0,
    animationBehavior: AnimationBehavior.preserve,
    duration: Duration(seconds: 10),
  );
  late final curvedAnimation = CurvedAnimation(
      parent: animationController, curve: FlippedCurve(Curves.linear));

  @override
  void initState() {
    var pro = Provider.of<AnimatePro>(context, listen: false);
    pro.getValue();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    animationController.repeat();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w700, fontSize: 17);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Color(0xff0B1418),
          child: Center(
            child: Hero(
              tag: "like",
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: AnimatedIcon(
                  icon:AnimatedIcons.menu_arrow ,
                  size: 30,
                  color: Colors.white, progress: animationController,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Consumer<AnimatePro>(
        builder: (BuildContext context, AnimatePro value, Widget? child) {
          return (value.favList.isNotEmpty)
              ? ListView.builder(
                  itemCount: value.favList.length,
                  itemBuilder: (context, index) {
                    var fav = value.favList[index];
                    return Container(
                      height: MediaQuery.sizeOf(context).height / 3,
                      width: MediaQuery.sizeOf(context).width / 2,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xff0B1418),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Hero(
                                tag: index,
                                child: AnimatedBuilder(
                                  animation: animationController,
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Transform.rotate(
                                      angle: animationController.value,
                                      child: child,
                                    );
                                  },
                                  child: Image.asset(
                                    fav.image ?? "",
                                    height: 150,
                                    width: 200,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    fav.name ?? "",
                                    style: style,
                                  ),
                                  Text(
                                    fav.spe ?? "",
                                    style: style,
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    value.remove(index);
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                    size: 40,
                                  ))
                            ],
                          ),
                          Text(
                            fav.detail ?? "",
                            style: style,
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 370,
                    ),
                    Center(
                        child: Text(
                      "Not Like Planets Yet!!!",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Hero(
                      tag: "like",
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.red)),
                        onPressed: () {
                          Navigator.pushNamed(context, "Home");
                        },
                        child: Text(
                          "Like the Planet",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}