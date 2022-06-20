

import 'package:avon/widgets/dashboard/build_review_card.dart';
import 'package:avon/widgets/design/design_widget/user_id.dart';
import 'package:avon/widgets/enrollee_card.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'design_widget/active_status.dart';
import 'design_widget/app_bar.dart';
import 'design_widget/image_text_arrow_btn.dart';

class UserPersonalAndHospitalDetails extends StatefulWidget {
  const UserPersonalAndHospitalDetails({Key? key}) : super(key: key);

  @override
  State<UserPersonalAndHospitalDetails> createState() => _UserPersonalAndHospitalDetailsState();
}

class _UserPersonalAndHospitalDetailsState extends State<UserPersonalAndHospitalDetails> with SingleTickerProviderStateMixin {

 late TabController _controller;


 @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
          title: "Chioma Melone",
          tail: [ TextButton(onPressed: (){},
              child:Text("Edit",
                style: TextStyle(
                    color: Color(0xff631293),fontSize: 16,
                    fontWeight: FontWeight.w700
                ),
              ))
          ]
      ),      body:Column(
        children: [

          TabBar(
            controller: _controller,
              indicatorColor: Color(0xff631293),
              labelColor: Color(0xff631293),
              unselectedLabelColor: Colors.black,
              labelStyle: TextStyle(
                  fontSize: 16,
                  color: Color(0xff631293),
                  fontWeight: FontWeight.w400),
              indicatorWeight: 2,
              tabs: [
                SizedBox(height:30,child: Text("Personal details",)),
                SizedBox(height:30,child: Text("Hospital card",)),


          ]),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
              child: TabBarView(
                  controller: _controller,
                  children: [

                personDetail(),

                hospital()

              ]),
            ),
          )


        ],
      ) ,
    );
  }

  Widget hospital()=>Container(

    child: ListView(
      children: [

        userID(),
        SizedBox(height: 30,),

        Text(
          "Primary Provider",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        const SizedBox(height: 5,),

        imageTextArrowBtn(image: "assets/design_image/hospital.png", title: "Alajobi general Hospital",
            content: "Ojota, Lagos,Nigeria"),

      ],
    ),

  );


  Widget personDetail()=>Container(
    child: ListView(
      children: [

        EnrolleeCard(),
        const SizedBox(height: 20,),
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


        const SizedBox(height: 10,),
        Text(
          "Primary Provider",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        const SizedBox(height: 5,),

        imageTextArrowBtn(image: "assets/design_image/hospital.png", title: "Alajobi general Hospital",
            content: "Ojota, Lagos,Nigeria"),
        const SizedBox(height: 5,),
        Container(
            width: MediaQuery.of(context).size.width *0.8,
            margin: EdgeInsets.symmetric(vertical: 5,),
            child: AVTextButton(
              radius: 5,
              child: Text('Upgrade Plan', style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              )),
              verticalPadding: 17,
              callBack: () {
              },
            )),
        Container(
            width: MediaQuery.of(context).size.width *0.8,
            margin: EdgeInsets.symmetric(vertical: 5,),
            child: AVTextButton(
              radius: 5,
              color: Colors.white,
              borderColor: Color(0xff631293),
              child: Text('Downgrade Plan', style: TextStyle(
                  color: Color(0xff631293),
                  fontSize: 16
              )),
              verticalPadding: 17,
              callBack: () {
              },
            )),
        Container(
            width: MediaQuery.of(context).size.width *0.8,
            margin: EdgeInsets.symmetric(vertical: 5,),
            child: AVTextButton(
              radius: 5,
              color: Colors.white,
              borderColor: Color(0xffF85959),
              child: Text('Deactivate dependent', style: TextStyle(
                  color: Color(0xffF85959),
                  fontSize: 16
              )),
              verticalPadding: 17,
              callBack: () {
              },
            )),
        const SizedBox(height: 10,),
        Text(
          "Personal info",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w300, color: Colors.black),
        ),
        const SizedBox(height: 10,),

        GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2/0.9,
              mainAxisSpacing: 20,
              crossAxisSpacing: 18
          ),
          children: [
            buildReviewCard(
                title: "Age",
                value: "18",
                image: "assets/images/Vector (1).png",
                color: Color(0XFF631293)
            ),
            buildReviewCard(
                title: "Blood Type",
                value: "0 RH-",
                image: "assets/images/Vector (2).png",
                color: Color(0XFFF85959)
            ),
            buildReviewCard(
                title: "Weight",
                value: "18Kg",
                image: "assets/images/Group copy.png",
                color: Color(0XFF488948)
            ),
            buildReviewCard(
                title: "Tall",
                value: "18 Cm",
                image: "assets/images/Vector (3).png",
                color: Color(0XFFFDBC00)
            ),
          ],
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        ),

      ],
    ),
  );

}
