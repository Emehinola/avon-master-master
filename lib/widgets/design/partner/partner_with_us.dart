
import 'package:avon/widgets/design/design_widget/circular_container.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PartnerWithUs extends StatelessWidget {
  const PartnerWithUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AVScaffold(
      title: "Partner with us",
      showAppBar: true,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width *0.05,vertical: 10),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [

            circularContainer(text: "Join Our Provider Network",onPressed: (){},weight: FontWeight.w300),
            circularContainer(text: "Become a broker",onPressed: (){},weight: FontWeight.w300),
            circularContainer(text: "Become an Agent",onPressed: (){},weight: FontWeight.w300),

          ],
        ),
      ),

    );
  }
}
