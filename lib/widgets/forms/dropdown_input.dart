import 'package:avon/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AVDropdown extends StatelessWidget {
  List<dynamic>? options;
  String? label;
  String? value;
  String? errorText;
  Function(dynamic value)? onChanged;

  AVDropdown({Key? key,
    this.options,
    this.label,
    this.value,
    this.onChanged,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: label != null,
            child: Text(
              label ?? '',
              style: TextStyle(
                  color: Colors.black,fontSize: 15, fontWeight: FontWeight.w400),
            )
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AVColors.gray1.withOpacity(0.4)
            ),
            borderRadius: BorderRadius.circular(5)
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              iconEnabledColor: Colors.black12,
              items: options?.map((value) => DropdownMenuItem(
                child: Text(value, style: TextStyle(
                    color:  Colors.black54,
                    fontWeight: FontWeight.w400
                )),
                value: value,
              )).toList(),
              onChanged: onChanged,

              isExpanded: true,
              value: value ,

            ),
          ),
        ),
        Align(
          child: Text(errorText ?? '',style: TextStyle(color: Colors.red, fontSize: 11)),
          alignment: Alignment.topLeft,
        )
      ],
    );
  }
}
