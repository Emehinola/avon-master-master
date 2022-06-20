
import 'package:avon/screens/enrollee/personal_health/drug_refill/request_histories.dart';
import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/design/design_widget/circular_container.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';

class DiseaseStatusControlScreen extends StatelessWidget {
  const DiseaseStatusControlScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
      title: "Disease Control Status",
      showAppBar: true,
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [

            const SizedBox(height: 10,),
            circularContainer(text: "Request Drug Refill",onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> DrugRequestHistoryScreen()));
            },color: Color(0xffF7F7FC)),
            // circularContainer(text: "Other Disease Management Initiative",onPressed: (){},color: Color(0xffF7F7FC)),

          ],
        ),
      ),
    );
  }
}
