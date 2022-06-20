import 'package:avon/widgets/design/design_widget/dropdown.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';

class HealthRisk extends StatelessWidget {
  const HealthRisk({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AVScaffold(
      title: "Health Risk Assessment",
      showAppBar: true,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 10),
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              "Answer the question below",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                  height: 1.2
              ),
            ),

            SizedBox(
              height: 20,
            ),

            AVInputField(
              label: "Your age",
              labelText: "Ayomide ",
              inputType: TextInputType.number,
            ),
            AVInputField(
              label: "Do you smoke?",
              labelText: "Ayomide ",
            ),
            AVInputField(
              label: "Email Address",
              labelText: "Ayomide@gmail.com",
            ),
            dropDown(question: "Sex", options: ["Select coverage"], defaultValue: "Select coverage"),
            dropDown(question: "Drinking frequency", options: ["Select coverage"], defaultValue: "Select coverage"),
            dropDown(question: "Do you smoke?", options: ["Select coverage"], defaultValue: "Select coverage"),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 20),
              child: AVTextButton(
                radius: 5,
                child: Text('Submit', style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                )),
                verticalPadding: 17,
                callBack: ()=>showDialog(
                   context: context,
                    barrierDismissible: true,
                    builder: (BuildContext _ctx)=>AlertDialog(
                      content: onSubmitModal(),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                        ))

                ),
            ))
          ],
        ),
      ),
    );
  }


  Widget onSubmitModal()=>IntrinsicHeight(
    child: Column(
      children: [
        SizedBox(height: 20,),
      CircularProgressIndicator.adaptive(),
        SizedBox(height: 20,),
        Text("Please wait",
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18
        ),),
        SizedBox(height: 10,),

        SizedBox(
            width: 300,
            child: Text(
                "We are currently calculating your health accessment...",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    height: 1.3
                )
            )),

      ],
    ),
  );

}



