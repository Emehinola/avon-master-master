import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:avon/screens/explore/contact/chat_with_us.dart';
import 'package:avon/screens/explore/contact/email_us.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'design_widget/circular_container.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
      title:"Contact us",
      showAppBar: true,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width *0.05,vertical: 10),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [

            circularContainer(text: "Chat with us",onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> ChatWithUsScreen()));
            }),
            circularContainer(text: "Call us",onPressed: ()async {
              const number = '08592119XXXX'; //set the number here
              await FlutterPhoneDirectCaller.callNumber(number);
            }),
            circularContainer(text: "Email us",onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> EmailUsScreen()));
            })
          ],
        ),
      ),

    );
  }


}
