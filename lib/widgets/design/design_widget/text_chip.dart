

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textChip({required String text, Color? bgcolor, Color? textColor, double? radius, Widget? leading,Widget? action,VoidCallback? onPress})=>Container(
  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
  margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 4),

  child:InkWell(
  onTap: onPress,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        leading ?? Container(),
        const SizedBox(width: 3,),
        Text(text,
            style: TextStyle(
                fontSize: 14,
                color: textColor ?? Color(0xff631293),
                fontWeight: FontWeight.w300)),
        const SizedBox(width: 3,),
        action ?? Container()
      ],
    ),
  ),
  decoration: BoxDecoration(
    color: bgcolor ?? Color(0xffF6EBFD),
    borderRadius: BorderRadius.circular(radius ?? 4)
  ),
);