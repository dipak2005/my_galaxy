// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:math';

import 'package:animation/view/detailpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/animate_pro.dart';
import '../model/planet_model.dart';

class Planets extends StatefulWidget {
  final List<Planet>? pm;
  final Planet? planet;
  final int? index;

  const Planets({super.key, this.pm, this.planet, this.index});

  @override
  State<Planets> createState() => _PlanetsState();
}

class _PlanetsState extends State<Planets> with TickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 10),
    animationBehavior: AnimationBehavior.preserve,
    lowerBound: 0,
    upperBound: 2 * pi,
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
    return Consumer<AnimatePro>(
      builder: (BuildContext context, value, Widget? child) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.67,
          child: GridView.builder(
            itemCount: widget.pm?.length,
            itemBuilder: (context, index) {
              var pam = widget.pm?[index];
              return Stack(
                children: [
                  InkWell(
                    onTap: () {
                      value.playIndex(index);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(pm: pam, index: value.planetIndex),
                        ),
                      );
                    },
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.3,
                      width: MediaQuery.sizeOf(context).width / 1.6,
                      color: Colors.transparent,
                      margin: EdgeInsets.all(15),
                      child: SingleChildScrollView(
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
                                    height: MediaQuery.sizeOf(context).height *
                                        0.18,
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
                                            (pam?.name ?? "").toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 17),
                                          ),
                                          subtitle: Text(
                                            pam?.spe ?? "",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          // trailing: IconButton(
                                          //     onPressed: () {
                                          //       // value.planetIndex = index;
                                          //       value.playIndex(index);
                                          //       Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //           builder: (context) =>
                                          //               DetailPage(
                                          //                   pm: pam,
                                          //                   index: value
                                          //                       .planetIndex),
                                          //         ),
                                          //       );
                                          //     },
                                          //     icon: Icon(
                                          //       Icons.arrow_forward_ios,
                                          //       color: Colors.blue,
                                          //       size: 30,
                                          //     )),
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
                    ),
                  ),
                  Hero(
                    tag: index,
                    child: AnimatedBuilder(
                      child: Image.asset(
                        pam?.image ?? "",
                        height: 110,
                        width: 200,
                      ),
                      animation: animationController,
                      builder: (BuildContext context, Widget? child) {
                        return Transform.rotate(
                          angle: animationController.value,
                          child: child,
                        );
                      },
                    ),
                  ),
                  Text(
                    "data",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              );
            },
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          ),
        );
      },
    );
  }
}
