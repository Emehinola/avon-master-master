import 'package:avon/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AVCheckBoxInput extends StatelessWidget{
  bool value;
  Widget? label;
  Function(bool? v)? onChanged;

  AVCheckBoxInput({
    Key? Key,
    required this.value,
    this.label,
    this.onChanged
  });


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CheckboxListTile(
        value: value,
        activeColor: AVColors.primary,
        controlAffinity: ListTileControlAffinity.leading,
        title:Visibility(
            visible: label != null,
            child: label ?? Container()
        ),  //
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        onChanged: onChanged ?? null
    );
  }
}