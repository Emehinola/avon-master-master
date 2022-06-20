


import 'package:flutter/material.dart';

Widget imageTextArrowBtn({
  required String image,
  required String title,required String content,Color? color,
  Widget? imageWidget,List<Widget>? actions})=> Container(
  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 7),
  child: Row(
    children: [
     imageWidget ?? Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    image),
                fit: BoxFit.fill),
            shape: BoxShape.circle),
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
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
            SizedBox(height: 3,),
            Text(content,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300)),
          ],
        ),
      ),

      IconButton(
        onPressed: (){},
        icon: Icon( Icons.arrow_right_outlined,
          color: Color(0xff631293),
          size: 30,),
      )

    ],
  ),
  decoration: BoxDecoration(
    color: color ?? Colors.white
  ),

);