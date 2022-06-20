
import 'package:avon/screens/enrollee/self_service/refer_earn/referrals.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InviteFriendOnboarding extends StatefulWidget {
  const InviteFriendOnboarding({Key? key}) : super(key: key);

  @override
  _InviteFriendOnboardingState createState() => _InviteFriendOnboardingState();
}

class _InviteFriendOnboardingState extends State<InviteFriendOnboarding> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setConfig();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AVColors.primary,
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height
          ),
          height: double.negativeInfinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        child: Image.asset("assets/images/vippng 1.png"),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                        'Refer and earn',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width: 300,
                      child: Text(
                        "We support you through a healthier journey, we are here to plan with and there for you!",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.white
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 50,),
                    AVTextButton(
                        child: Text("Invite a friend", style: TextStyle(
                          color: Colors.white, fontSize: 16
                        ),),
                        borderColor: Colors.white,
                        horizontalPadding: 20,
                        verticalPadding: 15,
                        radius: 5,
                        callBack: (){
                          updatePref(context);
                        },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  updatePref(context)async{
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>ReferralsScreen()));
  }

  setConfig()async {
    MainProvider state = Provider.of<MainProvider>(context, listen: false);
    state.user = await state.user.setBoolPref('refer_earn', '1');
  }
}