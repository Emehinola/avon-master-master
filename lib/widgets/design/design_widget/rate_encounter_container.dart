

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget rateEncounterContainer({required String title,required String content,required String imageText,required String when, String? count})=> Container(
  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
  margin: const EdgeInsets.symmetric(vertical: 3),

  child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 50,
        width: 50,
        alignment: Alignment.center,
        child: Text(imageText,  style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w700)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xff631293)
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 6,),
              Text(content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
            ],
          ),
        ),
      ),

      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(when,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black45,
                  fontWeight: FontWeight.w300)),
          SizedBox(
            height: 10,
          ),
          count ==null? Container() :Container(
            height: 20,
            width: 20,
            alignment: Alignment.center,

            child: Text(count,  style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w400)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffE8D9EC)
            ),
          ),
        ],
      )

    ],
  ),
  decoration: BoxDecoration(
      color: Colors.white
  ),

);