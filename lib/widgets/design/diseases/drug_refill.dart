
import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/design/design_widget/circular_container.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:flutter/material.dart';

class DrugRefill extends StatelessWidget {
  const DrugRefill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "Drug refill"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Stack(
          children: [
            const SizedBox(height: 10,),
            
            const Text(
              "Get real solutions from real doctors",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,

              ),
            ),

              Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/empty-contact-list.png"),
            const SizedBox(height: 10,),
            Text(
                "No recent consultation history ",
                style:  TextStyle(
                    fontSize: 16,
                    color: Colors.black45,
                    fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 10,),
            Container(
                width:200,
                margin: EdgeInsets.only(top: 30),
                child: AVTextButton(
                    radius: 5,
                    child: Text("Request refill", style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                    )),
                    verticalPadding: 17,
                    // color: Colors.white,
                    // borderColor: Color(0xff631293),
                    callBack: (){}
                ),
            ),



          ],
        ),
              )

          ],
        ),
      ),
    );
  }
}
