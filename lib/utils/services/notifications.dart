import 'package:avon/utils/constants/colors.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static void successSheet(BuildContext context, String message,
      {Function()? callBack, String? btnText}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 30,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(50)),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                AVParagraphText(
                  text: message,
                  size: 13,
                  align: TextAlign.center,
                  overflow: TextOverflow.visible,
                  color: Colors.black,
                  softwrap: true,
                ),
                Padding(padding: EdgeInsets.only(top: 30)),
                Container(
                  width: 120,
                  child: AVTextButton(
                    child: Text(btnText ?? 'OK',
                        style: TextStyle(color: Colors.white)),
                    color: AVColors.primary,
                    radius: 5,
                    callBack: callBack ??
                        () {
                          Navigator.pop(context);
                        },
                    verticalPadding: 12,
                  ),
                )
              ],
            ),
          );
        });
  }

  static void errorSheet(BuildContext context, String message,
      {Function()? callBack, String? btnText}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  child: Icon(
                    Icons.error,
                    color: Colors.white,
                    size: 40,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(50)),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                AVParagraphText(
                  text: message,
                  size: 13,
                  align: TextAlign.center,
                  overflow: TextOverflow.visible,
                  color: Colors.black,
                ),
                Padding(padding: EdgeInsets.only(top: 30)),
                Container(
                  width: 120,
                  child: AVTextButton(
                    child: Text(btnText ?? 'OK',
                        style: TextStyle(color: Colors.white)),
                    color: AVColors.primary,
                    radius: 5,
                    callBack: callBack ??
                        () {
                          Navigator.pop(context);
                        },
                    verticalPadding: 12,
                  ),
                )
              ],
            ),
          );
        });
  }

  static void infoSheet(BuildContext context, String message,
      {Function()? callBack, String? btnText}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  child: Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 40,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50)),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                AVParagraphText(
                  text: message,
                  size: 13,
                  align: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black,
                ),
                Padding(padding: EdgeInsets.only(top: 30)),
                Container(
                  width: 120,
                  child: AVTextButton(
                    child: Text(btnText ?? 'OK',
                        style: TextStyle(color: Colors.white)),
                    color: AVColors.primary,
                    radius: 5,
                    callBack: callBack ??
                        () {
                          Navigator.pop(context);
                        },
                    verticalPadding: 12,
                  ),
                )
              ],
            ),
          );
        });
  }
}

class AVParagraphText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? size;
  final TextAlign? align;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final bool softwrap;

  AVParagraphText(
      {Key? key,
      required this.text,
      this.weight,
      this.size,
      this.color,
      this.align,
      this.softwrap = true,
      this.overflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          color: color ?? Colors.black,
          fontSize: size ?? 15,
          fontWeight: weight ?? FontWeight.normal),
      textAlign: align ?? TextAlign.left,
      softWrap: softwrap,
      overflow: overflow ?? TextOverflow.visible,
    );
  }
}
