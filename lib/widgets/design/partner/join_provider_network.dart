
import 'package:avon/widgets/design/design_widget/circular_container.dart';
import 'package:avon/widgets/design/design_widget/dropdown.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JoinProviderNetwork extends StatelessWidget {
  const JoinProviderNetwork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
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
        ),
        title: Text(
          "Provider Network",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 10),
        child: ListView(
          children: [

            Text(
              "Fill the form below to join our provider network",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                  height: 1.2
              ),
            ),

            SizedBox(
              height: 20,
            ),
            dropDown(question: "Title", options: ["Mr"], defaultValue: "Mr"),

            AVInputField(
              label: "Surname",
              labelText: "Ayomide ",
            ),
            AVInputField(
              label: "First name",
              labelText: "Ayomide ",
            ),
            AVInputField(
              label: "Phone number",
              labelText: "Ayomide@gmail.com",
            ),
            AVInputField(
              label: "Email",
              labelText: "Ayomide@gmail.com",
            ),
            AVInputField(
              label: "Mobile",
              labelText: "Ayomide@gmail.com",
            ),
            AVInputField(
              label: "Hospital Address",
              labelText: "Ayomide@gmail.com",
            ),

            dropDown(question: "LGA", options: ["Select coverage"], defaultValue: "Select coverage"),
            AVInputField(
              label: "City",
              labelText: "Ayomide@gmail.com",
            ),
            AVInputField(
              label: "Region",
              labelText: "Ayomide@gmail.com",
            ),

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
                  callBack: () {},
                ))
          ],
        ),
      ),
    );
  }
}
