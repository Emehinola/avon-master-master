
import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/design/design_widget/circular_container.dart';
import 'package:flutter/material.dart';

class DiseaseStatusControl extends StatelessWidget {
  const DiseaseStatusControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "Disease Control Status"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [

            const SizedBox(height: 10,),
            circularContainer(text: "Request Drug Refill",onPressed: (){},color: Color(0xffF7F7FC)),
            circularContainer(text: "Other Disease Management Initiative",onPressed: (){},color: Color(0xffF7F7FC)),

          ],
        ),
      ),
    );
  }
}
