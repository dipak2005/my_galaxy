// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

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
    var dark= Provider.of<AnimatePro>(context,listen: false).isDark;
    var style = TextStyle(
        color: dark?Colors.black:Colors.white, fontWeight: FontWeight.w700, fontSize: 17);
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
                                    Navigator.pushNamed(context, "DetailPage",
                                        arguments: pam);
                                  },
                                  child: Container(
                                    height:
                                        MediaQuery.sizeOf(context).height / 3.7,
                                    width:
                                        MediaQuery.sizeOf(context).width / 1.6,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                      color:dark? Colors.black12:Color(0xff0B1418),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ListTile(
                                          title: Text(
                                            (pam?.name ?? "").toUpperCase(),
                                            style: TextStyle(
                                                color: dark?Colors.black:Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 25),
                                          ),
                                          subtitle: Text(
                                            pam?.spe ?? "",
                                            style:
                                                TextStyle( color: dark?Colors.black:Colors.white,),
                                          ),
                                          trailing: IconButton(
                                              onPressed: () {
                                                animationController.reverse(
                                                    from: 0);
                                                value.playIndex(index);
                                                Navigator.pushNamed(
                                                    context, "DetailPage",
                                                    arguments: pam);
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
                        child: Image.asset(
                          pam?.image ?? "",
                          height: 170,
                          width: 210,
                        ),
                        animation: animationController,
                        builder: (BuildContext context, Widget? child) {
                          return Transform.rotate(
                            angle: animationController.value,
                            child: child,
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
        Align(alignment: Alignment(-0.8, 0),
          child: Text(
            "You May Like Also",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              color: dark?Colors.black:Colors.white,),
          ),
        ),
        Consumer<AnimatePro>(
          builder: (BuildContext context, value, Widget? child) {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.3,
              child: (value.favList.isNotEmpty)
                  ? ListView.builder(
                      itemCount: value.favList.length,
                      itemBuilder: (context, index) {
                        Planet fav = value.favList[index];
                        return InkWell(
                          onTap: () {
                            value.playIndex(index);
                            Navigator.pushNamed(context, "DetailPage",
                                arguments: fav);
                          },
                          child: Container(
                              height: MediaQuery.sizeOf(context).height / 2.7,
                              width: MediaQuery.sizeOf(context).width,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color:dark? Colors.black12:Color(0xff0B1418),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      AnimatedBuilder(
                                        animation: animationController,
                                        builder: (BuildContext context,
                                            Widget? child) {
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
                                    ],
                                  ),
                                  Text(
                                    fav.detail ?? "",
                                    style: style,
                                  ),
                                ],
                              )),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "NoT Exploring Planet Yet!!!",
                        style: TextStyle(
                            color: dark?Colors.black:Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 26),
                      ),
                    ),
            );
          },
        )
      ],
    );
  }
}
