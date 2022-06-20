import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/constants/image_assets.dart';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String header;
  final String body;

  AuthHeader({Key? key, required this.header, required this.body}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${header}", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                  )),
                  Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                  Text("${body}", style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: AVColors.gray1
                  ))
                ],
              ),
          ),
          Positioned(
              top: 20,
              child: Image(
                  image: AssetImage(AVImages.authHeaderBanner)
              ),
          )
        ],
      ),
    );
  }
}
