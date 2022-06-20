


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget circularContainer({required String text, VoidCallback? onPressed, FontWeight? weight, Color? color})=>
    Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: ElevatedButton(
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          text,
          style: TextStyle(
              fontWeight: weight ?? FontWeight.w500,
              fontSize: 16,
              color: Colors.black
          ),
        ),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color ?? Colors.transparent),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(20)),
          elevation: MaterialStateProperty.all<double>(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>( RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.grey.withOpacity(0.3),
              width: 0.6,
            ),
          ),

          )
      ),
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(20),
      //     border: Border.all(
      //         color: Colors.grey.withOpacity(0.3),
      //         width: 1
      //     )
      // ),
      onPressed: onPressed,
    ),
  );

