import 'package:avon/utils/constants/colors.dart';
import 'package:avon/widgets/loader.dart';
import 'package:flutter/material.dart';

class AVTextButton extends StatelessWidget {
  final Widget? child;
  final bool? showLoader;
  final bool disabled;
  final Color? color;
  final Color? loaderColor;
  final Color borderColor;
  final double borderWidth;
  final double? radius;
  final double? verticalPadding;
  final double? horizontalPadding;
  final Function()? callBack;

  AVTextButton({Key? key,
    required this.child,
    this.color,
    this.loaderColor,
    this.borderColor = Colors.transparent,
    this.borderWidth = 1,
    this.radius,
    this.verticalPadding,
    this.horizontalPadding,
    this.callBack,
    this.showLoader = false,
    this.disabled = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // showLoader = false;
    return Container(
      // constraints: BoxConstraints(
      //     minHeight: 45
      // ),
      child: TextButton(
        onPressed: disabled ? null : callBack ?? null,
        child: AnimatedCrossFade(
          firstChild: AVLoader(color: loaderColor),
          secondChild: child!,
          crossFadeState: showLoader! ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: Duration(milliseconds: 300),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(disabled ? Colors.grey.withOpacity(0.5) : color ?? AVColors.primary),
            shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius?? 0)),
                side: BorderSide(color: disabled ? Colors.transparent: borderColor, width: borderWidth)
            )),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: verticalPadding?? 0, horizontal: horizontalPadding?? 0))
        ),
      ),
    );
  }
}