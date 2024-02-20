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

int? hIndex;

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
    var dark= Provider.of<AnimatePro>(context,listen: false).isDark;
    var style = TextStyle(
        color: dark?Colors.black:Colors.white, fontWeight: FontWeight.w700, fontSize: 17);
    return Consumer<AnimatePro>(
      builder: (BuildContext context, value, Widget? child) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.67,
          child: GridView.builder(
            itemCount: (value.isList == true)
                ? value.foundList.length
                : widget.pm?.length,
            itemBuilder: (context, index) {
              var pam = (value.isList == true)
                  ? value.foundList[index]
                  : widget.pm?[index];

              return Stack(
                children: [
                  InkWell(
                    onTap: () {
                      value.playIndex(index);
                      Navigator.pushNamed(context, "DetailPage",
                          arguments: pam);
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
                                    Navigator.pushNamed(context, "DetailPage",
                                        arguments: pam);
                                  },
                                  child: Container(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.18,
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
                                                fontSize: 17),
                                          ),
                                          subtitle: Text(
                                            pam?.spe ?? "",
                                            style:
                                                TextStyle( color: dark?Colors.black:Colors.white,),
                                          ),
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
                  AnimatedBuilder(
                    child: InkWell(
                      onTap: () {
                        value.playIndex(index);
                        Navigator.pushNamed(context, "DetailPage",
                            arguments: pam);
                        hIndex = index;
                      },
                      child: Hero(
                        tag: index,
                        child: Image.asset(
                          pam?.image ?? "",
                          height: 110,
                          width: 200,
                        ),
                      ),
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
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          ),
        );
      },
    );
  }
}
