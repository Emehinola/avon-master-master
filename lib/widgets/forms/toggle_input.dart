import 'package:avon/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AVToggleInput extends StatelessWidget{
  bool value;
  Color? color;
  Function(bool? v)? onChanged;

  AVToggleInput({
    Key? Key,
    required this.value,
    this.onChanged,
    this.color,
  });


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Switch.adaptive(
        value: value,
        activeColor: color ?? AVColors.primary,
        onChanged: onChanged
    );
  }
}