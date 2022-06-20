


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget checkBox({required String text, ValueChanged<bool?>? onPress,required bool value})=>CheckboxListTile(
    value: value,
    activeColor: Color(0xff631293),
    controlAffinity: ListTileControlAffinity.leading,
    title: Text(text,style: TextStyle(fontWeight: FontWeight.w400),),  //
    onChanged:onPress);