import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:flutter/material.dart';

class CyclePlanner extends StatelessWidget {
  const CyclePlanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: ""),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: [


            const Text(
              "Step 1 of 2",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,

              ),
            ),
            const SizedBox(height: 7,),

            Text(
                "Set up cycle planner",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black)
            ),
            const SizedBox(height: 7,),
            const Text(
              "choose a reason for using cycle planner so we can notify you.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,

              ),
            ),
            const SizedBox(height: 7,),

            _plan(title: "I want to be alerted ONLY when my period is close", isSelected: true),
            _plan(title: "I am trying to get pregnant, alert me about when I'm most fertile and when my period is close", isSelected: false),
            _plan(title: "I'm trying to NOT get pregnant, alert me about when I'm most likely to get pregnant from sex and when my period is close", isSelected: false)

          ],
        ),
      ),
    );
  }

  Widget _plan({ required String title,required bool isSelected})=> Container(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
    margin: const EdgeInsets.symmetric(vertical: 9),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
              title,

              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)
          ),
        ),
        Icon(
          Icons.arrow_right,
          color: Color(0xff631293),
        )

      ],
    ),
    decoration: BoxDecoration(
        color: Color(0xffF9F7FB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color:  isSelected ? Color(0xff631293) : Color(0xffF9F7FB))

    ),
  );


}
