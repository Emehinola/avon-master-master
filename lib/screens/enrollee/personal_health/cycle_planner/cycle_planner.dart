import 'dart:convert';

import 'package:avon/screens/enrollee/dashboard.dart';
import 'package:avon/screens/enrollee/personal_health/cycle_planner/calendar.dart';
import 'package:avon/screens/enrollee/personal_health/cycle_planner/setup_planner_1.dart';
import 'package:avon/screens/enrollee/self_service/refer_earn/share.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/loader.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CyclePlanningOnBoarding extends StatefulWidget {
  const CyclePlanningOnBoarding({Key? key}) : super(key: key);

  @override
  _CyclePlanningOnBoardingState createState() => _CyclePlanningOnBoardingState();
}

class _CyclePlanningOnBoardingState extends State<CyclePlanningOnBoarding> {
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCycleInfo();
  }

  @override
  Widget build(BuildContext context) {
    MainProvider state = Provider.of<MainProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AVColors.primary,
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height
          ),
          height: double.negativeInfinity,
          // width: MediaQuery.of(context).size.width,
          child: Column(
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
                      radius: 50,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        child: Image.asset("assets/images/image 870.png", width: 50,),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                        'Cycle Planner',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width: 300,
                      child: Text(
                        "Keeping tabs on your periods just got easier! Use our cycle planner to track your periods, fertility and more!",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.white
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 50,),
                    if(isLoading)
                      AVLoader()
                      else
                    AVTextButton(
                      child:  Text("Get Started", style: TextStyle(
                          color: Colors.white, fontSize: 16
                      ),),
                      borderColor: Colors.white,
                      horizontalPadding: 20,
                      verticalPadding: 15,
                      radius: 5,
                      callBack: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>SetupPlanner1()));
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

  void getCycleInfo()async {
    setState((){ isLoading = true;});

    MainProvider state = Provider.of<MainProvider>(context, listen: false);
    http.Response response = await HttpServices.get(context, "enrollee/cycle-planner/cycleinfo");
    if(response.statusCode == 200){
      var body = jsonDecode(response.body);

      if(body['data'].length > 0){
        List data = body['data'];
        state.cyclePlannerInfo = data.first;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (BuildContext context)=> CyclePlannerCalendarScreen()));
      }
    }
    setState((){ isLoading = false;});
  }
}
