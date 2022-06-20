
import 'package:avon/screens/explore/partner/join_provider.dart';
import 'package:avon/widgets/design/design_widget/circular_container.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PartnerWithUsScreen extends StatelessWidget {
  const PartnerWithUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AVScaffold(
      title: "Partner with Us",
      showAppBar: true,
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width *0.05,vertical: 10),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            circularContainer(text: "Join Our Provider Network",
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> JoinProviderScreen(
                    path: "partner-provider",
                    title: "Provider Network",
                    type: "provider",
                  )));
                },
                weight: FontWeight.w300
            ),
            circularContainer(text: "Become a Broker",
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> JoinProviderScreen(
                    path: "partner-broker",
                    title: "Become a Broker",
                    type: "broker",
                  )));
                },
                weight: FontWeight.w300
            ),
            circularContainer(text: "Become an Agent",
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> JoinProviderScreen(
                    path: "partner-agent",
                    title: "Become an Agent",
                    type: "agent",
                  )));
                },
                weight: FontWeight.w300
            ),
          ],
        ),
      ),

    );
  }
}
