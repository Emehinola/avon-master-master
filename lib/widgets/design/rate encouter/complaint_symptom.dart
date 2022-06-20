
import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:flutter/material.dart';

class ComplaintSymptom extends StatelessWidget {
  const ComplaintSymptom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "Symptoms"),
      body: Stack(
        children: [

          ListView(
          children: [

            symList(title: "High Temprature", check: true, changed: (val){}),
            symList(title: "Headache", check: false, changed: (val){}),
            symList(title: "Hearthburn", check: false, changed: (val){}),
            symList(title: "Cough/Catarh/Cold", check: false, changed: (val){}),

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
                  child: Text("Continue", style: TextStyle(
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
      
    );
  }
  
  Widget symList({required String title,required bool check, required ValueChanged<bool?>? changed})=>Padding(
    padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 15),
   child: Row(
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
     children: [
       Text(
         title,
         style:  TextStyle(
             fontSize: 15,
             color: Colors.black,
             fontWeight: FontWeight.w300),
       ),
       
       Checkbox(
           value: check,
           activeColor: Color(0xff631293),
           onChanged:changed)
     ],
   ),
  );
  
}
