import 'package:avon/screens/enrollee/hospital/hospital_list.dart';
import 'package:avon/screens/enrollee/self_service/add_dependant.dart';
import 'package:avon/screens/enrollee/self_service/refer_earn/invite_friend.dart';
import 'package:avon/screens/enrollee/self_service/refer_earn/referrals.dart';
import 'package:avon/screens/enrollee/self_service/renew_buy_plan.dart';
import 'package:avon/screens/enrollee/self_service/request_refund.dart';
import 'package:avon/screens/webviews/static-html.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/widgets/design/design_widget/circular_container.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MySelfServiceScreen extends StatelessWidget {
  const MySelfServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AVScaffold(
      title: "Self Service",
      decoration: BoxDecoration(
        color: Colors.white
      ),
      showAppBar: true,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width *0.05,vertical: 10),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [

            circularContainer(text: "Change my primary provider",onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>HospitalListScreen()));
            },weight: FontWeight.w400),
            circularContainer(text: "Request to add a dependant",onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>AddDependantScreen()));
            },weight: FontWeight.w400),
            circularContainer(text: "Renew my health plan",onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>RenewBuyPlan()));
              //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>PlanListScreen()));
            },weight: FontWeight.w400),
            circularContainer(text: "Request a refund",onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:
                  (BuildContext context)=>StaticHtmlScreen(
                      path: "assets/web/htmls/refund.html",
                      isWeb: false,
                      title: "Request a Refund",
                      child: Positioned(
                        bottom: 0,
                        left: 10,
                        right: 10,
                        child: Container(
                          child: AVTextButton(
                            child: Text("Continue", style: TextStyle(
                                color: Colors.white
                            )),
                            verticalPadding: 16,
                            radius: 3,
                            callBack: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder:
                                  (BuildContext context)=> RequestRefundScreen()));
                            },
                          ),
                          color: Colors.white,
                          padding: EdgeInsets.only(bottom: 20),
                        )
                      ),
                  )));
            },weight: FontWeight.w400),
            circularContainer(text: "Refer and earn",onPressed: (){
              openReferral(context);
            },weight: FontWeight.w400)
          ],
        ),
      ),

    );
  }

  void openReferral(context){
    MainProvider state = Provider.of<MainProvider>(context, listen: false);

    if(state.user.getBoolPref('refer_earn')){
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ReferralsScreen()));
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>InviteFriendOnboarding()));
    }
  }
}
