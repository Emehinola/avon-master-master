


import 'package:avon/widgets/design/design_widget/check_box.dart';
import 'package:avon/widgets/design/design_widget/dropdown.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmeGroup extends StatelessWidget {
  const SmeGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.all(0),
          onPressed: () {},
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.black,
          ),
        ) ,
        title: Text(
          "SME & Group",
          style: TextStyle(fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Stack(
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                dropDown(options: ["Select Beneficiary"], defaultValue: "Select Beneficiary",
                    question: "Select Engagement type",weight: FontWeight.w300),

                Text(
                  "Would you prefer a sales consultant",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,

                  ),
                ),

                checkBox(text: "Chat With Us", value: true,onPress: (value){}),
                checkBox(text: "Call Us", value:false,onPress: (value){}),
                checkBox(text: "Email", value: false,onPress: (value){}),


              ],

            ),

            Positioned(
              bottom: 10,
              child:    Container(
                width: MediaQuery.of(context).size.width ,
                // margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: AVTextButton(
                  radius: 5,
                  child: Text('Submit', style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                  )),
                  verticalPadding: 18,
                  callBack: () {
                  },
                )),)

          ],
        ),
      )

    );
  }
}
