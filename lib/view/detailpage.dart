// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:animation/controller/animate_pro.dart';
import 'package:animation/model/planet_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final Planet? pm;
  final int? index;

  const DetailPage({super.key, this.pm, this.index});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
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
    animationController.repeat();
    super.initState();
  }
  @override
  void dispose() {
   animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Planet? pp = widget.pm;
    var style = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Color(0xff0B1418),
          child: Center(
            child: Hero(
              tag: "image",
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_arrow,
                  size: 30,
                  color: Colors.white, progress: animationController,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Hero(
                  tag: widget.index ?? 0,
                  child: Consumer<AnimatePro>(
                    builder: (BuildContext context, value, Widget? child) {
                      return AnimatedBuilder(
                          animation: animationController,
                          builder: (BuildContext context, Widget? child) {
                            return Transform.rotate(
                              angle: animationController.value,
                              child: child,
                            );
                          },
                          child: Image.asset(pp?.image ?? ""));
                    },
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              (pp?.name ?? "").toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              (pp?.spe ?? "").toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Encyclopedia",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 25),
                ),
                Center(
                  child: Consumer<AnimatePro>(
                    builder: (BuildContext context, value, Widget? child) {
                      return IconButton(
                          onPressed: () {
                            value.addFavList(pp!);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 2),
                              content: Center(
                                child: Text(
                                  "Like Planet Successfully",
                                  style: style,
                                ),
                              ),
                              backgroundColor: Colors.green,
                            ));
                          },
                          icon: Icon(
                            (value.favList == value.planetList)
                                ? Icons.favorite_border
                                : Icons.favorite,
                            size: 30,
                            color: (value.favList == value.planetList)
                                ? Colors.white
                                : Colors.red,
                          ));
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Position",
                  style: style,
                ),
                Text(
                  pp?.position ?? "",
                  style: style,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xff0B1418),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  (pp?.equatorialDiameter != null)
                      ? Text(
                    "Equatorial Diameter",
                    style: style,
                  )
                      : SizedBox.shrink(),
                  (pp?.equatorialDiameter != null)
                      ? Text(
                    pp?.equatorialDiameter ?? "unknown",
                    style: style,
                  )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                (pp?.mass != null)
                    ? Text(
                  "Mass",
                  style: style,
                )
                    : SizedBox.shrink(),
                (pp?.mass != null)
                    ? Text(
                  pp?.mass ?? "Not Available",
                  style: style,
                )
                    : SizedBox.shrink(),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xff0B1418),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  (pp?.galCenterDistance != null)
                      ? Text(
                    "Gal.Center Distance",
                    style: style,
                  )
                      : SizedBox.shrink(),
                  (pp?.galCenterDistance != null)
                      ? Text(
                    pp?.galCenterDistance ?? "unknown",
                    style: style,
                  )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                (pp?.rotationPeriod != null)
                    ? Text(
                  "Rotation period",
                  style: style,
                )
                    : SizedBox.shrink(),
                (pp?.rotationPeriod != null)
                    ? Text(
                  pp?.rotationPeriod ?? "unknown",
                  style: style,
                )
                    : SizedBox.shrink(),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xff0B1418),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  (pp?.galacticOrbitPeriod != null)
                      ? Text(
                    "Galactic Orbit Period",
                    style: style,
                  )
                      : SizedBox.shrink(),
                  (pp?.galacticOrbitPeriod != null)
                      ? Text(
                    pp?.galacticOrbitPeriod ?? "unknown",
                    style: style,
                  )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                (pp?.surfaceGravity != null)
                    ? Text(
                  "Surface Gravity",
                  style: style,
                )
                    : SizedBox.shrink(),
                (pp?.surfaceGravity != null)
                    ? Text(
                  pp?.surfaceGravity ?? "unknown",
                  style: style,
                )
                    : SizedBox.shrink(),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xff0B1418),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  (pp?.surfaceTemperature != null)
                      ? Text(
                    "Surface Temperature",
                    style: style,
                  )
                      : SizedBox.shrink(),
                  (pp?.surfaceTemperature != null)
                      ? Text(
                    pp?.surfaceTemperature ?? "unknown",
                    style: style,
                  )
                      : SizedBox.shrink()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (pp?.detail != null)
                  ? Text(
                pp?.detail ?? "Not Available",
                style: style,
              )
                  : SizedBox.shrink(),
            ),
            (pp?.composition != null)
                ? Text(
              "Composition",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (pp?.composition != null)
                  ? Text(
                pp?.composition ?? "Not Available",
                style: style,
              )
                  : SizedBox.shrink(),
            ),
            (pp?.distance != null)
                ? Text(
              "Distance",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (pp?.distance != null)
                  ? Text(
                pp?.distance ?? "Not Available",
                style: style,
              )
                  : SizedBox.shrink(),
            ),
            (pp?.galaxy != null)
                ? Text(
              "Galaxy",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (pp?.galaxy != null)
                  ? Text(
                pp?.galaxy ?? "Not Available",
                style: style,
              )
                  : SizedBox.shrink(),
            ),
            (pp?.atmosphere != null)
                ? Text(
              "Atmosphere",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (pp?.atmosphere != null)
                  ? Text(
                pp?.atmosphere ?? "Not Available",
                style: style,
              )
                  : SizedBox.shrink(),
            ),
            (pp?.surface != null)
                ? Text(
              "Surface",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (pp?.surface != null)
                  ? Text(
                pp?.surface ?? "Not Available",
                style: style,
              )
                  : SizedBox.shrink(),
            ),
            (pp?.axialTilt != null)
                ? Text(
              "Axial-Tilt",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (pp?.axialTilt != null)
                  ? Text(
                pp?.axialTilt ?? "Not Available",
                style: style,
              )
                  : SizedBox.shrink(),
            ),
            (pp?.magField != null)
                ? Text(
              "Mag.Field",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (pp?.magField != null)
                  ? Text(
                pp?.magField ?? "Not Available",
                style: style,
              )
                  : SizedBox.shrink(),
            ),
            (pp?.origin != null)
                ? Text(
              "Origin",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (pp?.origin != null)
                  ? Text(
                pp?.origin ?? "Not Available",
                style: style,
              )
                  : SizedBox.shrink(),
            ),
            (pp?.observation != null)
                ? Text(
              "Observation",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (pp?.observation != null)
                  ? Text(
                pp?.observation ?? "Not Available",
                style: style,
              )
                  : SizedBox.shrink(),
            ),
            (pp?.earthLike != null)
                ? Text(
              "Earth-Like",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (pp?.earthLike != null)
                  ? Text(
                pp?.earthLike ?? "Not Available",
                style: style,
              )
                  : SizedBox.shrink(),
            ),
            (pp?.water != null)
                ? Text(
              "Water",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (pp?.water != null)
                  ? Text(
                pp?.water ?? "Not Available",
                style: style,
              )
                  : SizedBox.shrink(),
            ),
            (pp?.moons != null)
                ? Text(
              "Moons",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (pp?.moons != null)
                  ? Text(
                pp?.moons ?? "Not Available",
                style: style,
              )
                  : SizedBox.shrink(),
            ),
            (pp?.missions != null)
                ? Text(
              "Missions",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (pp?.missions != null)
                  ? Text(
                pp?.missions ?? "Not Available",
                style: style,
              )
                  : SizedBox.shrink(),
            ),
            (pp?.starLike != null)
                ? Text(
              "Star-Like",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (pp?.starLike != null)
                  ? Text(
                pp?.starLike ?? "Not Available",
                style: style,
              )
                  : SizedBox.shrink(),
            ),
            (pp?.ring != null)
                ? Text(
              "Ring",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (pp?.ring != null)
                  ? Text(
                pp?.ring ?? "Not Available",
                style: style,
              )
                  : SizedBox.shrink(),
            ),
            (pp?.discovery != null)
                ? Text(
              "Discovery",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (pp?.discovery != null)
                  ? Text(
                pp?.discovery ?? "Not Available",
                style: style,
              )
                  : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}