

import 'package:avon/widgets/design/design_widget/dropdown.dart';
import 'package:avon/widgets/design/design_widget/header_progress.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddBeneficiary2 extends StatelessWidget {
  const AddBeneficiary2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            headerProgress(value: MediaQuery.of(context).size.width * 0.5),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 15,top: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {},
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(
                          Icons.arrow_back,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                      Text("One more step to go",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),)
                    ],
                  ),
                  const  SizedBox(
                    height: 10,
                  ),
                  const Text(
                      'Enter info',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black)
                  ),
                  const  SizedBox(height: 5,),
                  const Text(
                    "Enter details of plans beneficiary",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,

                    ),
                  ),
                  const  SizedBox(height: 5,),
                  const Divider(),
                  const  SizedBox(height: 5,),
                  const  Text(
                      'Contact details',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black)
                  ),
                ],
              ),
            ),

            const  SizedBox(
              height: 10,
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 15,top: 4),
                child: ListView(
                  children: [

                    const  SizedBox(height: 10,),
                    AVInputField(
                      label: "Email address",
                      labelText: "alma.lawson@example.com",
                    ),
                    const  SizedBox(height: 10,),
                    AVInputField(
                      label: "Mobile number",
                      labelText: "(217) 555-0113",
                    ),
                    AVInputField(
                      label: "Residential Address",
                      labelText: "4140 Parker Rd. Allentown, New Mexico 31134",
                    ),
                    dropDown(options: ["Anambra","Adamawa"], defaultValue: "Anambra", question: "State"),
                    dropDown(options: ["Amuwo-odofin",], defaultValue: "Amuwo-odofin", question: "Local government Area"),

                    CheckboxListTile(
                        value: false,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text("Use residential address as mailing address",style: TextStyle(fontWeight: FontWeight.w400),),  //
                        onChanged: (value){}),

                    AVInputField(
                      label: "Mailing address",
                      labelText: "Opeyemi Olatogun",
                    ),
                    Text(
                        "this is where your hospital identification card will be sent. Please include LGA",
                        style: TextStyle(fontWeight: FontWeight.w300,color: Color(0xff631293),fontSize: 14,)),


                    Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: AVTextButton(
                            radius: 5,
                            child: Text('Continue', style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                            )),
                            verticalPadding: 17,
                            callBack: () {
                            }
                        ))


                  ],
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}
