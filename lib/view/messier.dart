// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../model/util.dart';

class Messier extends StatefulWidget {
  const Messier({super.key});

  @override
  State<Messier> createState() => _MessierState();
}

String bgimage = "";

class _MessierState extends State<Messier> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 1.4,
      child: GridView.builder(
        itemCount: messierList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          var star = messierList[index];

          return InkWell(
            onTap: () {
              bgimage = star;
              setState(() {});
            },
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.2,
              width: MediaQuery.sizeOf(context).width / 2,
              child: Image.asset(star),
            ),
          );
        },
      ),
    );
  }
}
