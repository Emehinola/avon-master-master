

import 'package:avon/widgets/design/design_widget/active_status.dart';
import 'package:avon/widgets/design/design_widget/image_text_arrow_btn.dart';
import 'package:avon/widgets/design/design_widget/user_id.dart';
import 'package:flutter/material.dart';

class ViewHomePagePlan extends StatelessWidget {
  const ViewHomePagePlan({Key? key}) : super(key: key);

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
          "Abdulazeez",
          style: TextStyle(fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical:5),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Avon ID",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
            ),
            const SizedBox(height: 10,),
           userID(),
            const SizedBox(height: 10,),
            Text(
              "Primary Provider",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
            ),
            const SizedBox(height: 5,),

            imageTextArrowBtn(image: "assets/design_image/hospital.png", title: "Alajobi general Hospital",
                content: "Ojota, Lagos,Nigeria"),

            const SizedBox(height: 15,),

        Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(
              "Status",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,

              ),
            ),
           SizedBox(
             width: 170,
             child: RichText(
               text: TextSpan(
                 children: [
                   TextSpan(
                     text:   "Active ",
                     style: TextStyle(
                       fontSize: 16,
                       fontWeight: FontWeight.w300,
                       color: Colors.black

                     ),),
                   WidgetSpan(
                     child: Image.asset("assets/images/check-circle 1.png")
                   )

                 ]
               ),
             ),
           )

          ],
        ),
            const SizedBox(height: 10,),
         activeStatus(head: "Plan Type", value: "Family plan"),
         activeStatus(head: "Phone number", value: "(671) 555-0110"),
         activeStatus(head: "Email address", value: "alma.lawson@erkejrhebrjenrxadslkreer"),
         activeStatus(head: "Gender", value: "Male"),



          ],
        ),
      ),
      
    );
  }


}
