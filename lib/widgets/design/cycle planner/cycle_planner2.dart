


import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/design/design_widget/dropdown.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:flutter/material.dart';

class CyclePlanner2 extends StatelessWidget {
  const CyclePlanner2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title:""),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Stack(
          children: [
            ListView(
              children: [
                const SizedBox(height: 7,),
                const Text(
                  "Step 2 of 2",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,

                  ),
                ),
                const SizedBox(height: 7,),

                Text(
                    "Cycle info",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black)
                ),
                const SizedBox(height: 8,),
                const Text(
                  "Enter your monthly cycle details",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,

                  ),
                ),
                const SizedBox(height: 25,),


                InkWell(
                  onTap: ()async{
                    await showDatePicker(
                        context: context,
                        initialDate:DateTime(2015, 8),
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101));

                  },
                  child: AVInputField(
                    label: "When did your last period start?",
                    labelText: "5/27/15",
                    disabled: true,
                  ),
                ),
                AVInputField(
                  label: "How many days usually go between the start of one period and the start of the next one?",
                  labelText: "alma.lawson@example.com",
                ),
                AVInputField(
                  label: "How many days does your period usually last?",
                  labelText: "3-5day",
                ),
                AVInputField(
                  label: "How many days usually go between the start of one period and the start of the next one?",
                  labelText: "Opeyemi Olatogun",
                ),


              ],
            ),

            Positioned(
              bottom: 15,
              child:Container(
               width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 30),
                child: AVTextButton(
                    radius: 5,
                    child: Text("Save", style: TextStyle(
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
          ],
        )


      ),
    );
  }
}
