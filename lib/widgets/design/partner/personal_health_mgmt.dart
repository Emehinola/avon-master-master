import 'package:avon/state/main-provider.dart';
import 'package:flutter/material.dart';
import 'package:avon/widgets/design/design_widget/circular_container.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/cupertino.dart';

class PersonalHealthMgmt extends StatelessWidget {
  const PersonalHealthMgmt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AVScaffold(
      title: "Personal Health Mgmt",
      showAppBar: true,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width *0.05,vertical: 10),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [

            circularContainer(text: "View My Recent Medical Encounter(s)",onPressed: (){},weight: FontWeight.w400),
            circularContainer(text: "My Disease Management Status",onPressed: (){},weight: FontWeight.w400),
            circularContainer(text: "View Health Communities",onPressed: (){},weight: FontWeight.w400),
           circularContainer(text: "Track My Cycle",onPressed: (){},weight: FontWeight.w400),
            circularContainer(text: "Conduct Health Assessment Check",onPressed: (){},weight: FontWeight.w400)

          ],
        ),
      ),

    );
  }
}
