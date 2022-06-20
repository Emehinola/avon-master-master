

import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/design/design_widget/circular_container.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:flutter/material.dart';

class RequestRefund
    extends StatelessWidget {
  RequestRefund
      ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Request refund"),
      backgroundColor: Colors.white,
      body: Stack(
          children:[

            Column(
              children: [

              ],
            ),

            Positioned(
              bottom: 10,
              right: 15,
              left: 15,
              child:   Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 30),
                child: AVTextButton(
                    radius: 5,
                    child: Text("Submit", style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                    )),
                    verticalPadding: 17,
                    // color: Colors.white,
                    // borderColor: Color(0xff631293),
                    callBack: (){}
                ),
              ),
            )

          ]
      ),

    );
  }
}
