
import 'package:avon/widgets/design/design_widget/circular_container.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySelfService extends StatelessWidget {
  const MySelfService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AVScaffold(
      title: "My Self Service",
      showAppBar: true,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width *0.05,vertical: 10),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [

            circularContainer(text: "Change my primary provider",onPressed: (){},weight: FontWeight.w400),
            circularContainer(text: "Request to add dependent",onPressed: (){},weight: FontWeight.w400),
            circularContainer(text: "Renew my health plan",onPressed: (){},weight: FontWeight.w400),
            circularContainer(text: "Request refund",onPressed: (){},weight: FontWeight.w400),
            circularContainer(text: "Refer and Earn",onPressed: (){},weight: FontWeight.w400),
            circularContainer(text: "What's new for you",onPressed: (){},weight: FontWeight.w400),

          ],
        ),
      ),

    );
  }
}
