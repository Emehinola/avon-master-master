


import 'package:avon/widgets/forms/text_button.dart';
import 'package:flutter/material.dart';

import 'dropdown.dart';

Widget hospitalFilterModal()=>IntrinsicHeight(
  child: Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Filter by",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,

            ),
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
          )
        ],
      ),
      SizedBox(height: 10,),

      dropDown(options: ["Lagos"], defaultValue: "Lagos", question: "Location"),
      dropDown(options: ["Dental Clinic"], defaultValue: "Dental Clinic", question: "Specialty"),

      Container(
          width: 200,
          height: 50,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: AVTextButton(
            radius: 5,
            child: Text('Continue', style: TextStyle(
                color: Colors.white,
                fontSize: 16
            )),
            verticalPadding: 17,
            callBack: () {},
          ))


    ],
  ),
);