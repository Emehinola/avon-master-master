import 'package:flutter/cupertino.dart';

Widget headerProgress({required double value})=>Stack(
  children: [
    Container(color: Color(0xffE7D7EB),padding: const EdgeInsets.all(3),),
    Container(color: Color(0xff631293),padding: const EdgeInsets.all(3), width: value,),
  ],
);