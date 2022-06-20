
import 'package:flutter/material.dart';
Widget activeStatus({required String head, required String value})=> Container(

  margin: const EdgeInsets.symmetric(vertical: 3),
  padding: const EdgeInsets.symmetric(vertical: 10),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        head,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      SizedBox(
        width: 170,
        child: Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,

          ),
        ),
      ),


    ],
  ),
  decoration: BoxDecoration(
      border: Border(
          bottom: BorderSide(
              color: Colors.black26,
              width: 1
          )
      )
  ),
);
