// ignore_for_file: prefer_const_constructors

import 'package:animation/model/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/animate_pro.dart';

class Star extends StatefulWidget {
  const Star({super.key});

  @override
  State<Star> createState() => _StarState();
}

class _StarState extends State<Star> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 1.4,
      child: GridView.builder(
        itemCount: starList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          var star = starList[index];
          return Container(
            height: MediaQuery.sizeOf(context).height * 0.2,
            width: MediaQuery.sizeOf(context).width / 2,
            child: Image.asset(star),
          );
        },
      ),
    );
  }
}
