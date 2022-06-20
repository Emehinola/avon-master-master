import 'package:avon/utils/constants/colors.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class AVInputField extends StatelessWidget {
  final Icon? icon;
  final Icon? prefixIcon;
  final Widget? imageIcon;
  final Widget? prefixImageIcon;
  final String? labelText;
  final String? hintText;
  final String? label;
  final double height;
  final int maxLines;
  final int minLines;
  final bool disabled;
  final Color? fillColor;
  final bool obscureText;
  final TextStyle? labelStyle;
  final double borderRadius;
  final double verticalPadding;
  final double horizontalPadding;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  TextEditingController? controller;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  dynamic Function()? suffixCallBack;
  final List<TextInputFormatter> inputFormatters;

  AVInputField({Key? key,
    this.onChange,
    this.disabled = false,
    this.fillColor,
    this.icon,
    this.prefixIcon,
    this.inputFormatters = const [],
    this.imageIcon,
    this.prefixImageIcon,
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.inputType,
    this.inputAction,
    this.validator,
    this.controller,
    this.suffixCallBack,
    this.label,
    this.obscureText = false,
    this.height = 50,
    this.borderRadius = 5,
    this.verticalPadding = 20,
    this.horizontalPadding = 10,
    this.maxLines = 1,
    this.minLines = 1
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    InputBorder errorBorder = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(borderRadius)
    );

    return Column(
      children: [
        Visibility(
          visible: label != null? true:false,
          child: Align(
            child: Text("${label}", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400)),
            alignment: Alignment.topLeft,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 5)),
        Container(
          constraints: BoxConstraints(
              minHeight: height
          ),
          child: Center(
            child: TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AVColors.gray1.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                disabledBorder:OutlineInputBorder(
                  borderSide: BorderSide(color: AVColors.gray1.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(borderRadius),
                ) ,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AVColors.primary.withOpacity(1)),
                    borderRadius: BorderRadius.circular(borderRadius)
                ),
                errorBorder: errorBorder,
                focusedErrorBorder: errorBorder,
                contentPadding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
                suffixIcon: _buildSuffix(),
                prefixIcon: _buildPrefix(),
                filled: fillColor != null ? true:disabled,
                fillColor: fillColor ?? null,
                labelText: labelText ?? '',
                labelStyle: labelStyle ?? TextStyle(
                  color: AVColors.gray1.withOpacity(0.5),
                  fontWeight: FontWeight.w200,
                  fontSize: 12,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: hintText ?? '',
                hintStyle: TextStyle(color: AVColors.gray1.withOpacity(0.4), fontWeight: FontWeight.w300, fontSize: 13),
                enabled: !disabled
              ),
              obscureText: obscureText,
              style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w300, letterSpacing: 1),
              controller: controller?? null,
              onChanged: onChange ?? null,
              keyboardType: inputType ?? TextInputType.text,
              maxLines: maxLines,
              minLines: minLines,
              textInputAction: inputAction ?? TextInputAction.next,
              validator: validator ?? null,
              inputFormatters: inputFormatters,
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 5)),
      ],
    );
  }

  Widget? _buildPrefix(){
    return prefixIcon != null ? Container(
      child: GestureDetector(
        child: prefixIcon,
        // onTap: suffixCallBack ?? null,
      ),
      transform: Matrix4.translationValues(0.0, 0.0, 0.0),
    ) : prefixImageIcon ?? null;
  }

  Widget? _buildSuffix(){
    return icon != null ?
    Container(
      child: GestureDetector(
        child: icon,
        onTap: suffixCallBack ?? null,
      ),
      transform: Matrix4.translationValues(0.0, 0.0, 0.0),
    ) : imageIcon ?? null;
  }
}