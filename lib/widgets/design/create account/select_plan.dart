
import 'package:avon/widgets/design/design_widget/card_container.dart';
import 'package:flutter/material.dart';

class SelectPlan extends StatelessWidget {
  const SelectPlan({Key? key}) : super(key: key);

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
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Individual plans",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
            ),
            SizedBox(
              height: 4,
            ),

            Text(
              "Click on sub plan to continue",
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
                      iconBgColor: Color(0xff11698E),
                      amount: "₦ 25,000 ",
                      amountTail: "Per Annum"

                  ),

                  cardContainer(
                      head: "Couples",
                      content:"You can easily find any information about the Family plans we offer here",
                      icon: Icons.supervised_user_circle_outlined,
                      bgColor: Color(0xffD2E3EA),
                      iconBgColor: Color(0xff85369B),
                      amount: "₦ 25,000 ",
                      amountTail: "Per Annum"

                  ),

                  cardContainer(
                      head: "Family plan",
                      content:"You can easily find any information about the Family plans we offer here",
                      icon: Icons.account_balance_outlined,
                      bgColor: Color(0xffD2E3EA),
                      iconBgColor: Color(0xffEF6C57),
                      amount: "₦ 25,000 ",
                      amountTail: "Per Annum"
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
