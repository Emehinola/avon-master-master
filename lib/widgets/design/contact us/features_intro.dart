

import 'package:avon/widgets/forms/text_button.dart';
import 'package:flutter/material.dart';

class FeaturesIntro extends StatelessWidget {

  final String image;
  final String buttonText;
  final String title;
  final String content;
  final VoidCallback onButtonClick;

   FeaturesIntro({Key? key,required this.image,required this.buttonText,required this.title, required this.content,required this.onButtonClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff631293),
      body: Stack(

        children: [

          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.08, left: 20),
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: (){},
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(image),
                ),
                SizedBox(height: 20,),
                Text(
                    title,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: 300,
                  child: Text(
                    content,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                Container(
                    width: 200,
                    margin: EdgeInsets.only(top: 30),
                    child: AVTextButton(
                        radius: 5,
                        child: Text(buttonText, style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        )),
                        verticalPadding: 17,
                        borderColor: Colors.white,
                        callBack: onButtonClick
                    ))

              ],
            ),
          ),

          Positioned(
            bottom: 0,
              right: 0,
              child: Image.asset("assets/images/stet.png"))
        ],
      ),
    );
  }
}
