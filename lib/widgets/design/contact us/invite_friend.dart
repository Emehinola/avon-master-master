import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:flutter/material.dart';

class InviteFriend extends StatelessWidget {
  const InviteFriend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "Invite a friend"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(
          children:[

            Column(
            children: [

              AVInputField(
                label: "Phone number(s)",
                labelText: "(219) 555-0114",
              ),
              Text("More than one number should be separated with commas",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.black26
              ),),
              Text("or",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.black
              ),),
              Container(
                  width: 180,
                  margin: EdgeInsets.only(top: 30),
                  child: AVTextButton(
                      radius: 30,
                      child: Text("Share invite link", style: TextStyle(
                          color: Color(0xff631293),
                          fontSize: 16
                      )),
                      verticalPadding: 17,
                      color: Colors.white,
                      borderColor: Color(0xff631293),
                      callBack: (){}
                  ),
              ),




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
                    child: Text("Send invite", style: TextStyle(
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
        ),
      ),

    );
  }
}
