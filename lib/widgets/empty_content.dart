import 'package:avon/utils/constants/image_assets.dart';
import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  final String text;

  EmptyContent({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AVImages.emptyContactList),
        Padding(padding: EdgeInsets.only(top: 20)),
        Text(text, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400
        ))
      ],
    );
  }
}
