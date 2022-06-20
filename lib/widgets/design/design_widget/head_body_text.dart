


import 'package:flutter/cupertino.dart';

Widget headBodyText({required String head,required String body,})=>Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      head,
      overflow: TextOverflow.clip,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,

      ),
    ),
    SizedBox(height: 3,),
    SizedBox(
      width: 140,
      child: Text(
        body,
        maxLines: 2,
        overflow: TextOverflow.clip,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ],
);
