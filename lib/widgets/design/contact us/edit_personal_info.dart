
import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/design/design_widget/dropdown.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class EditPersonalInfo extends StatelessWidget {
  const EditPersonalInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
          title: "Edit personal info",
        tail: [ TextButton(onPressed: (){},
            child:Text("Save",
              style: TextStyle(
                color: Color(0xff631293),
                fontWeight: FontWeight.w700
              ),
        ))
        ]
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Enter details of plan benefciary",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,

                  ),
                ),
                SizedBox(height: 20,),

                Text(
                  "Date of Birth",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,

                  ),
                ),
                SizedBox(height:5,),
                DottedBorder(
                  dashPattern: [8, 4],
                  strokeWidth: 2,
                  color: Color(0xff85369B).withOpacity(0.2),
                  child: Container(
                    color: Color(0xffE7D7EB),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Text(
                      "Upload Birth certificate",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Color(0xff631293)

                      ),
                    ),
                  ),
                ),
                dropDown(options: ["Mother"], defaultValue: "Mother", question: "Blood Type"),
                AVInputField(
                  label: "Weight (Kg)",
                  labelText: "Ayomide ",
                ),
                AVInputField(
                  label: "Height (~centimeter)",
                  labelText: "Ayomide ",
                ),

              ],
            ),

            Positioned(
              bottom: 10,
              right: 15,
              left: 15,
              child:   Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: AVTextButton(
                      radius: 5,
                      child: Text('Update Personal Information', style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                      )),
                      verticalPadding: 17,
                      callBack: () {
                      }
                  ))
            )


          ],
        ),
      ),
    );
  }
}
