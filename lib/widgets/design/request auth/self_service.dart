


import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/design/design_widget/circular_container.dart';
import 'package:flutter/material.dart';


class SelfService extends StatelessWidget {
  const SelfService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:appBar(title: "My Self Service"),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width *0.05,vertical: 10),
        child: ListView(

          children: [

            circularContainer(text: "Change my primary provider",onPressed: (){}),
            circularContainer(text: "Request to add dependent",onPressed: (){}),
            circularContainer(text: "Request refund",onPressed: (){}),
            circularContainer(text: "Refer and Earn",onPressed: (){}),
            circularContainer(text: "What’s new for you",onPressed: (){}),

          ],
        ),
      ),

    );
  }


}
