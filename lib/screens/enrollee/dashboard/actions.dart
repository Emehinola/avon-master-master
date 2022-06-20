import 'package:avon/screens/enrollee/hospital/hospital_list.dart';
import 'package:avon/screens/enrollee/learn%20scheme/learn_scheme_work.dart';
import 'package:avon/screens/enrollee/personal_health/personal_health.dart';
import 'package:avon/screens/enrollee/rate_encounter/rate_recent_encounter.dart';
import 'package:avon/screens/enrollee/self_service/self_service.dart';
import 'package:avon/screens/enrollee/station_authorization/request_authorization.dart';
import 'package:avon/screens/plan/health_benefits.dart';
import 'package:avon/widgets/dashboard/enrollee_dashboard_header.dart';
import 'package:avon/widgets/menu_item.dart';
import 'package:flutter/material.dart';

class EnrolleeActionsScreen extends StatelessWidget {
  EnrolleeActionsScreen({Key? key}) : super(key: key);

  final List menuItems = [
    {
      "icon": "assets/images/authorization.png",
      "icon_color": 0XFFC4A0CE,
      "prefix": "Request",
      "label": "Authorization for out of station/emergency encounter",
      "image": "assets/images/lock-shield.png",
      "color": 0xff7030A0,
      "screen": RequestAuthorizationScreen()
    },
    {
      "icon": "assets/images/image 877.png",
      "icon_color": 0XFF155E33,
      "prefix": "",
      "label": "Self-Service",
      "image": "assets/images/Group420.png",
      "color": 0xff488948,
      "screen": MySelfServiceScreen()
    },
    {
      "icon": "assets/images/healthbenefit.png",
      "icon_color": 0XFF2D792D,
      "prefix": "View my",
      "label": "Health Benefits",
      "image": "assets/images/Group 31141.png",
      "color": 0xffA8D18D,
      "opacity": 0.4,
      "screen": HealthBenefitScreen()
    },
    {
      "icon": "assets/images/Mask Group.png",
      "icon_color": 0XFF472E90,
      "prefix": "Personal",
      "label": "Health Management",
      "image": "assets/images/notebook-big.png",
      "color": 0xff8766E9,
      "opacity": 0.2,
      "screen": PersonalHealthMgmtScreen()
    },
    {
      "icon": "assets/images/favourite.png",
      "icon_color": 0XFFC4A0CE,
      "prefix": "Rate your",
      "label": "Recent Encounter",
      "image": null, //"assets/images/Group.png",
      "color": 0xff7030A0,
      "screen": RateRecentEncounterScreen()
    },
    {
      "icon": "assets/images/medicine 1.png",
      "icon_color": 0XFF8BCD8B,
      "prefix": "",
      "label": "Avon TeleDoc",
      "image": "assets/images/medication.png",
      "color": 0xff488948,
      "active": false
    },
    {
      "icon": "assets/images/Group 31175.png",
      "icon_color": 0xff488948,
      "prefix": "Find a",
      "label": "Healthcare Provider",
      "image": null, //"assets/images/Group 417.png",
      "color": 0xffA8D18D,
      "screen": HospitalListScreen()
    },
    {
      "icon": "assets/images/notebook.png",
      "icon_color": 0XFF631293,
      "prefix": "Learn how the",
      "label": "Avon HMO Scheme Works",
      "image": null, //"assets/images/Group 417.png",
      "color": 0xff8766E9,
      "screen": LearnSchemeWorkScreen()
    },
  ];

  @override
  Widget build(BuildContext context) {
    return _buildGrid();
  }

  Widget _buildGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 20)),
          EnrolleeDashboardHeader(
              showAvatar: true, greetings: "What would you like to do today?"),
          Padding(padding: EdgeInsets.only(top: 20)),
          Text("Quick Actions",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15)),
          Padding(padding: EdgeInsets.only(top: 10)),
          GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 2 / 2.2),
              itemCount: menuItems.length,
              itemBuilder: (BuildContext context, int index) {
                Map item = menuItems[index];
                return MenuItemCard(item: item);
              })
        ],
      ),
    );
  }
}
