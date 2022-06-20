import 'package:avon/models/plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget cardContainer({
  required Color bgColor,
  required Color iconBgColor,
  Plan? plan,
  String? head,
  String? content,
  required IconData icon,
  String? amount,
  String? amountTail
})=>Container(
  height: 230,
  margin: const EdgeInsets.symmetric(vertical: 10),
  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar(
        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
        radius: 25,
      ),
      const SizedBox(height: 20,),
      Text(
        "${plan?.planTypeName}",
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
      ),
      const SizedBox(height: 10,),
      Text(
        "No description",
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
        )
      ),
      const SizedBox(height: 10,),
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: amount,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18
              )
            ),
            TextSpan(
              text: amountTail,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 15
              )
            ),
          ]
        ),
      )
    ],
  ),
  decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(10)
  ),
);