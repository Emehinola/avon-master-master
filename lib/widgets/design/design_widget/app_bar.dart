



import 'package:flutter/material.dart';

AppBar appBar({required String title, List<Widget>? tail})=>AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  leading: IconButton(
    padding: EdgeInsets.all(0),
    onPressed: () {},
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    icon: Icon(
      Icons.arrow_back,
      size: 25,
      color: Colors.black,
    ),
  ) ,
  title: Text(
    title,
    style: TextStyle(fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black
    ),
  ),
  centerTitle: true,
  actions: tail,
);