
import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/design/design_widget/image_text_arrow_btn.dart';
import 'package:avon/widgets/design/design_widget/rate_encounter_container.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:flutter/material.dart';

class RateEncounter2 extends StatelessWidget {
  const RateEncounter2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "Recent encounter"),
      body: Stack(
        children:[
          Column(
            children: [
              rateEncounterContainer(title: "Waiting for doctor", content: "Not yet rated", imageText: "BP", when: "Today"),
              rateEncounterContainer(title: "Jacob Jones", content: "Rated: 4/5", imageText: "BP", when: "Today")
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
                  child: Text("Make a complaint", style: TextStyle(
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
