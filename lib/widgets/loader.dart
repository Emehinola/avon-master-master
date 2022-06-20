import 'package:flutter/material.dart';

class AVLoader extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;

  AVLoader({Key? key, this.width = 20, this.height = 20, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(
              color??
              Colors.white
          ),
          strokeWidth: 2,
        ),
      ),
    );
  }
}