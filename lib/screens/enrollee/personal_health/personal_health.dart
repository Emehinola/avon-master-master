import 'package:avon/screens/enrollee/personal_health/cycle_planner/cycle_planner.dart';
import 'package:avon/screens/enrollee/personal_health/disease_control/disease_control_status.dart';
import 'package:avon/screens/enrollee/personal_health/medical_record.dart';
import 'package:avon/screens/webviews/static-html.dart';
import 'package:avon/state/main-provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:avon/screens/explore/health_risk/health_risk.dart';
import 'package:flutter/material.dart';
import 'package:avon/widgets/design/design_widget/circular_container.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/cupertino.dart';

class PersonalHealthMgmtScreen extends StatelessWidget {
  const PersonalHealthMgmtScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainProvider _state = Provider.of<MainProvider>(context);

    return  AVScaffold(
      title: "Personal Health Management",
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

            circularContainer(
              text: "View my recent medical encounter(s)",
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> MedicalReportScreen()));
              },
              weight: FontWeight.w400
            ),
            circularContainer(text: "My disease management status",
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> DiseaseStatusControlScreen()));
                },
                weight: FontWeight.w400
            ),
            circularContainer(text: "Join a health community",onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>  StaticHtmlScreen(
                  title: "Health Communities",
                  path: "https://www.avonhealthcare.com/community/",
                  isWeb:true
              )));
            },weight: FontWeight.w400),
            if(_state.plan?.gender.toString().toLowerCase() == 'f' && _state.user.getBoolPref('cycleplanner'))
            circularContainer(text: "Track My Cycle",onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> CyclePlanningOnBoarding()));
            },weight: FontWeight.w400),
            circularContainer(text: "Conduct a health assessment check",onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> HealthRiskScreen()));
            },weight: FontWeight.w400)

          ],
        ),
      ),

    );
  }

  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
