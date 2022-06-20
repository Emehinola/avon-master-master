import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/constants/image_assets.dart';
import 'package:flutter/material.dart';

class SimpleAuthHeader extends StatelessWidget {
  final String header;
  final String body;

  SimpleAuthHeader({Key? key, required this.header, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 50
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${header}", style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700
          )),
          Padding(padding: EdgeInsets.symmetric(vertical: 3)),
          Text("${body}", style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              color: AVColors.gray1
          ))
        ],
      )
    );
  }
}
