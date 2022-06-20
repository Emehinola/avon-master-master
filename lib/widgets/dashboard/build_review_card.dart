


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildReviewCard({
  required String title,
  required String value,
  required String image,
  required Color color,
}){
  return GestureDetector(
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Color(0XFFCBD5E0).withOpacity(0.6)
          ),
          borderRadius: BorderRadius.circular(13)
      ),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 25,
            child: Image.asset("${image}"),
          ),
          Padding(padding: EdgeInsets.only(right: 10)),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${value}", style: TextStyle(
                    fontWeight: FontWeight.w700
                )),
                Padding(padding: EdgeInsets.only(top: 2)),
                Text("${title}", style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14, color: Colors.grey
                ))
              ],
            ),
          )
        ],
      ),
    ),
  );
}