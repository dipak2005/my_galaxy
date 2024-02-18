// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:animation/controller/animate_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/planet_model.dart';
import 'detailpage.dart';

class All extends StatefulWidget {
  final List<Planet>? pm;
  final int? index;

  const All({super.key, this.index, this.pm});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> with TickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    value: 2,
    lowerBound: 0,
    reverseDuration: Duration(seconds: 2),
    upperBound: 2 * pi,
    duration: Duration(seconds: 10),
  );
  late final curvedAnimation = CurvedAnimation(
      parent: animationController, curve: FlippedCurve(Curves.linear));

  @override
 void initState() {
    animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w700, fontSize: 17);
    return Column(
      children: [
        Consumer<AnimatePro>(
          builder: (BuildContext context, value, Widget? child) {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height / 2.9,
              width: MediaQuery.sizeOf(context).width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.pm?.length,
                itemBuilder: (context, index) {
                  var pam = widget.pm?[index];
                  return Stack(
                    children: [
                      Container(
                        height: MediaQuery.sizeOf(context).height / 3,
                        width: MediaQuery.sizeOf(context).width / 1.6,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    value.playIndex(index);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                            pm: pam, index: value.planetIndex),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height:
                                        MediaQuery.sizeOf(context).height / 3.7,
                                    width:
                                        MediaQuery.sizeOf(context).width / 1.6,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                      color: Color(0xff0B1418),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ListTile(
                                          title: Text(
                                            pam?.name ?? "",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 25),
                                          ),
                                          subtitle: Text(
                                            pam?.spe ?? "",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          trailing: IconButton(
                                              onPressed: () {
                                                animationController.reverse(
                                                    from: 0);
                                                value.playIndex(index);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailPage(
                                                            pm: pam,
                                                            index: value
                                                                .planetIndex),
                                                  ),
                                                );
                                              },
                                              icon: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.blue,
                                                size: 30,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      AnimatedBuilder(
                        animation: animationController,
                        builder: (BuildContext context, Widget? child) {
                          return Transform.rotate(
                            angle: animationController.value,
                            child: child,
                          );
                        },
                        child: Image.asset(
                          pam?.image ?? "",
                          height: 170,
                          width: 210,
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "You May Like Also",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  "Explore",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ))
          ],
        ),
        Consumer<AnimatePro>(
          builder: (BuildContext context, value, Widget? child) {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height*0.3,
              child: ListView.builder(
                itemCount: value.favList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Planet fav = value.favList[index];
                  return Container(
                      height: MediaQuery.sizeOf(context).height / 2.7,
                      width: MediaQuery.sizeOf(context).width,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xff0B1418),
                        borderRadius: BorderRadius.circular(20),
                      ),
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
                      )
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}
