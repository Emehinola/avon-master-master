
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget dropDown(
    {required List<String> options, required String defaultValue, required String question,double? width, FontWeight? weight}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: weight ?? FontWeight.w400),
          ),
          SizedBox(height: 3,),
          Container(
            width: width,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                  color:Color(0xffCFCFCF), style: BorderStyle.solid, width: 1.0),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                iconEnabledColor: Colors.black12,
                items: options
                    .map((value) => DropdownMenuItem(
                  child: Text(value,style: TextStyle(color:  Colors.black54, fontWeight: FontWeight.w300),),
                  value: value,
                ))
                    .toList(),
                onChanged: (value) {},
                isExpanded: true,
                value: options.first,
              ),
            ),
          ),
        ],
      ),
    );