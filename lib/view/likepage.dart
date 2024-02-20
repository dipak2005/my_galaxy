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
    animationController.repeat();
    pro.getData();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var dark= Provider.of<AnimatePro>(context,listen: false).isDark;
    var style = TextStyle(
        color: dark?Colors.black:Colors.white, fontWeight: FontWeight.w700, fontSize: 17);
    return Scaffold(
      backgroundColor:  dark?Colors.white: Colors.black,
      appBar: AppBar(
        backgroundColor: dark?Colors.white:Colors.black,
        leading: Hero(
          tag: "mylike",
          child: CircleAvatar(
            radius: 30,
            backgroundColor:dark? Colors.black12:Color(0xff0B1418),
            child: Center(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_arrow,
                  size: 30,
                  color: Colors.white,
                  progress: animationController,
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
                          color:dark? Colors.black12:Color(0xff0B1418),
                          borderRadius: BorderRadius.circular(20)),
                      child: SingleChildScrollView(
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                AnimatedBuilder(
                                  animation: animationController,
                                  child: Hero(
                                    tag: index,
                                    child: Image.asset(
                                      fav.image ?? "",
                                      height: 150,
                                      width: 180,
                                    ),
                                  ),
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Transform.rotate(
                                      angle: animationController.value,
                                      child: child,
                                    );
                                  },
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
                                    IconButton(
                                        onPressed: () {
                                          value.remove(index);
                                        },
                                        icon: Icon(
                                          Icons.cancel_presentation,
                                          color: Colors.white,
                                          size: 40,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              fav.detail ?? "",
                              style: style,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : SingleChildScrollView(
                child: Column(
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
                      ElevatedButton(
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
                      )
                    ],
                  ),
              );
        },
      ),
    );
  }
}
