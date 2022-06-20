
import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/design/design_widget/dropdown.dart';
import 'package:avon/widgets/design/design_widget/text_chip.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:flutter/material.dart';

class CreateComplain extends StatelessWidget {
  const CreateComplain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "New Complaint"),
      body: Stack(
          children:[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView(

                children: [

                 dropDown(
                     options: [
                   "Select Beneficiary","Amuwo-odofin","Agege (Dopemu)"
                 ], defaultValue: "Select Beneficiary", question: "Who is this for"),

                  const SizedBox(height: 10,),

                  Text(
                    "Symptoms",
                    style:  TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5,),
                  Wrap(
                    children: [
                      textChip(
                          leading: Icon(
                              Icons.add
                          ),
                          radius: 20,
                          text: "Add or Edit symptom"
                      ),
                    ],
                  ),

                  const SizedBox(height: 20,),

                  AVInputField(
                    label: "Additional comments (optional)",
                    labelText: "",
                    height: 100,
                    maxLines: 6,
                  ),



                ],
              ),
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
                    child: Text("Submit", style: TextStyle(
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
