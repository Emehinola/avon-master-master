

import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/design/design_widget/circular_container.dart';
import 'package:flutter/material.dart';

class RateEncouter extends StatelessWidget {
  const RateEncouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "Rate Recent Encounter"
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [

            const SizedBox(height: 10,),
            circularContainer(text: "Make a compaint",onPressed: (){}),
            circularContainer(text: "Rate a provdier",onPressed: (){}),
            circularContainer(text: "Give a recommendation",onPressed: (){}),
            

          ],
        ),
      ),

    );
  }
}
