

import 'package:avon/widgets/design/design_widget/dropdown.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:flutter/material.dart';

class RequestQuote extends StatelessWidget {
  const RequestQuote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.all(0),
          onPressed: () {},
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.black,
          ),
        ) ,
        title: Text(
          "Request Quote",
          style: TextStyle(fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Text(
              "Complete the form below",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,

              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: ListView(
                children: [


                  AVInputField(
                    label: "Name",
                    labelText: "Ayomide ",
                  ),
                  AVInputField(
                    label: "Email Address",
                    labelText: "Ayomide ",
                  ),
                  AVInputField(
                    label: "Phone Number",
                    labelText: "Ayomide ",
                  ),
                  AVInputField(
                    label: "Role in Company",
                    labelText: "Ayomide ",
                  ),
                  AVInputField(
                    label: "Company Name",
                    labelText: "Ayomide ",
                  ),
                  AVInputField(
                    label: "Company Address",
                    labelText: "Ayomide ",
                  ),

                  dropDown(options: ['Select coverage'], defaultValue: "Select coverage", question:"Plan Category"),

                  Container(
                      width: MediaQuery.of(context).size.width *0.8,
                      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      child: AVTextButton(
                        radius: 5,
                        child: Text('Submit', style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        )),
                        verticalPadding: 17,
                        callBack: () {
                        },
                      )),
                ],
              ),
            )

          ],

        ),
      ),

    );
  }
}
