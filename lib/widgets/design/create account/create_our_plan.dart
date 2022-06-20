
import 'package:avon/widgets/design/design_widget/card_container.dart';
import 'package:flutter/material.dart';

class CreateOurPlan extends StatelessWidget {
  const CreateOurPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 35,
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
        actions: [

          Container(
            margin: EdgeInsets.only(right: 10,),
            padding: const EdgeInsets.symmetric(horizontal: 25,),
            height: 20,
            alignment: Alignment.center,
            child: InkWell(
              onTap: (){},
              child: Text("Skip",style: TextStyle(
                color: Colors.black
              ),),
            ),
            decoration: BoxDecoration(
              border: Border.all(color:Color(0xffE5E5E5),width: 2),
              borderRadius: BorderRadius.circular(20)
            ),
          )

        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Our plans",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
            ),
            SizedBox(
              height: 4,
            ),

            Text(
              "Click on any of the plan to compare",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  height: 1.2
              ),
            ),

            SizedBox(
              height: 20,
            ),


           Expanded(
             child: ListView(
               children: [
                 cardContainer(
                     head: "Individual plans",
                     content:"You can easily find any information about the individual plans we offer here",
                     icon: Icons.person_outline,
                     bgColor: Color(0xffD2E3EA),
                     iconBgColor: Color(0xff11698E)
                 ),

                 cardContainer(
                     head: "Couples",
                     content:"You can easily find any information about the Family plans we offer here",
                     icon: Icons.supervised_user_circle_outlined,
                     bgColor: Color(0xffFE8D9EC),
                     iconBgColor: Color(0xff85369B)
                 ),

                 cardContainer(
                     head: "Family plan",
                     content:"You can easily find any information about the Family plans we offer here",
                     icon: Icons.account_balance_outlined,
                     bgColor: Color(0xffFCE3DF),
                     iconBgColor: Color(0xffEF6C57)
                 )
                 
               ],
             ),
           )

          ],
        ),
      ),
    );
  }


}
