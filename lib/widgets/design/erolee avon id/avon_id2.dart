

import 'package:avon/widgets/design/design_widget/image_text_arrow_btn.dart';
import 'package:avon/widgets/design/design_widget/user_id.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:flutter/material.dart';

class AvonID2 extends StatelessWidget {
  const AvonID2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 30,
        title: Text(
          "Avon ID",
          style: TextStyle(fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),
        ),
        centerTitle: false,
        actions:[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              onPressed: (){},
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff631293)),
                  padding: MaterialStateProperty.all(EdgeInsets.all(0))
              ),
              child:Text('share', style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              )),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const SizedBox(height: 20,),
            userID(),
            const SizedBox(height: 15,),
            Text(
              "Assigned Hospital",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
            ),
            const SizedBox(height: 5,),
            
            imageTextArrowBtn(image: "assets/design_image/hospital.png", title: "Alajobi general Hospital",
                content: "Ojota, Lagos,Nigeria"),
            const SizedBox(height: 10,),
            imageTextArrowBtn(
                image: "assets/design_image/hospital.png",
                imageWidget: Container(
                  padding: EdgeInsets.all(10),
                  child: Image.asset("assets/images/security-user.png"),
                  decoration: BoxDecoration(
                    color: Color(0xff631293),
                    borderRadius: BorderRadius.circular(7)
                  ),
                ),
                title: "Pre-Authorization code", content: "Tap here to get a pre-authorization code",color: Color(0xffF5EFF7)
            ),
            const SizedBox(height: 10,),
            imageTextArrowBtn(
                image: "assets/design_image/hospital.png",
                imageWidget:  Container(
                  padding: EdgeInsets.all(10),
                  child: Image.asset("assets/images/calendar-2.png"),
                  decoration: BoxDecoration(
                      color: Color(0xff631293),
                      borderRadius: BorderRadius.circular(7)
                  ),
                ),
                title: "Appointments", content: "Schedule a wellness checkup",color: Color(0xffF5EFF7)
            ),


          ],
        ),
      ),
    );
  }





}
