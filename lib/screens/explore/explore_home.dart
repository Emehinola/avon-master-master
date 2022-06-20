import 'package:avon/screens/enrollee/hospital/hospital_list.dart';
import 'package:avon/screens/enrollee/learn%20scheme/manual.dart';
import 'package:avon/screens/explore/contact/contact_us.dart';
import 'package:avon/screens/explore/health_risk/health_risk.dart';
import 'package:avon/screens/explore/partner/partner_with_us.dart';
import 'package:avon/screens/explore/press_room/press_room.dart';
import 'package:avon/screens/explore/press_room/videos.dart';
import 'package:avon/screens/plan/plan_list.dart';
import 'package:avon/screens/explore/wellness/wellness_lifestyle.dart';
import 'package:avon/screens/webviews/static-html.dart';
import 'package:avon/widgets/menu_item.dart';
import 'package:flutter/material.dart';

class ExploreHomeScreen extends StatefulWidget {
  const ExploreHomeScreen({Key? key}) : super(key: key);

  @override
  _ExploreHomeScreenState createState() => _ExploreHomeScreenState();
}

class _ExploreHomeScreenState extends State<ExploreHomeScreen> {
  @override
  Widget build(BuildContext context) {
    List menuItems = [
      {
        "icon": "assets/images/image 871.png",
        "icon_color": 0XFFC4A0CE,
        "prefix": "Check out",
        "label": "Our Health Plans",
        "width": 45,
        "top": 20,
        "bottom": 0,
        "left": 0,
        "right": 0,
        "image": null, //"assets/images/Group.png",
        "color": 0xff7030A0,
        "screen": PlanListScreen(),
      },
      {
        "icon": "assets/images/Group 31175.png",
        "icon_color": 0XFF155E33,
        "prefix": "Find a",
        "label": "Hospital",
        "width": 60,
        // "top":0,
        "bottom": 0,
        "left": 0,
        "right": 0,
        "image": null,
        "color": 0xff488948,
        "screen": HospitalListScreen()
      },
      {
        "icon": "assets/images/image 874.png",
        "icon_color": 0XFF2D792D,
        "prefix": "Read",
        "width": 55,
        "top": 10,
        "bottom": 0,
        "left": 0,
        "right": 0,
        "label": "Health Articles",
        "image": "assets/images/Group420.png",
        "color": 0xffA8D18D,
        "screen": WellnessLifeStyle()
      },
      {
        "icon": "assets/images/Mask Group.png",
        "icon_color": 0XFF472E90,
        "prefix": "",
        "width": 63,
        // "top":0,
        "bottom": 0,
        "left": 0,
        "right": 0,
        "label": "Know Your Health Status",
        "image": "assets/images/Group 417.png",
        "color": 0xff8766E9,
        "screen": HealthRiskScreen()
      },
      {
        "icon": "assets/images/image 873.png",
        "icon_color": 0XFFC4A0CE,
        "prefix": "Visit Our",
        "width": 78,
        // "top":20,
        "bottom": 0,
        "left": 0,
        "right": 0,
        "label": "Press room",
        "image": null,
        "color": 0xff7030A0,
        // "screen":  PressRoomScreen()
        "screen": null,
        "url": "https://www.avonhealthcare.com/about/press-room/"
      },
      {
        "icon": "assets/images/image 872.png",
        "icon_color": 0XFF8BCD8B,
        "prefix": "Watch Our",
        "width": 70,
        // "top":0,
        "bottom": 10,
        "left": 2,
        "right": 2,
        "label": "Videos",
        "image": "assets/images/Group 33542.png",
        "color": 0xff488948,
        "screen": WatchVideosScreen()
      },
      {
        "icon": "assets/images/chat.png",
        "icon_color": 0XFF155E33,
        "prefix": "Chat/Email/Call",
        "width": 55,
        // "top":0,
        "bottom": 15,
        "left": 0,
        "right": 0,
        "label": "Contact Us",
        "image": "assets/images/Group 31141.png",
        "color": 0xffA8D18D,
        "screen": ContactUsScreen()
      },
      {
        "icon": "assets/images/Group 419.png",
        "icon_color": 0XFF631293,
        "prefix": "Consult",
        "width": 38,
        // "top":0,
        "bottom": 0,
        "left": 0,
        "right": 0,
        "label": "a Doctor",
        "image": "assets/images/Group420.png",
        "color": 0xff8766E5,
        "active": false
      },
      {
        "icon": "assets/images/agreement 1.png",
        "icon_color": 0XFFC4A0CE,
        "prefix": "Partner",
        "width": 70,
        "top": 20,
        "bottom": 0,
        "left": 0,
        "right": 0,
        "label": "With Us",
        "image": null, //"assets/images/Group 31175.png",
        "color": 0xff7030A0,
        "screen": PartnerWithUsScreen()
      },
      // {
      //   "icon": "assets/images/Group 31175.png",
      //   "icon_color": 0xff488948,
      //   "prefix": "Find a",
      //   "label": "Healthcare Provider",
      //   "image": null, //"assets/images/Group 417.png",
      //   "color": 0xffA8D18D,
      //   "screen": HospitalListScreen()
      // },
    ];

    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi Guest,",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Welcome to our world. ",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.black)),
                    WidgetSpan(child: Text("🙂"))
                  ]),
                )
              ],
            ),
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/Profile-Picture.png")),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: Image(
                  image: AssetImage("assets/images/Rectangle 4176.png"),
                ),
              ),
              Positioned(
                right: 60,
                bottom: 0,
                child: Image(
                  image: AssetImage("assets/images/Rectangle 4177.png"),
                ),
              ),
              InkWell(
                child: Container(
                  height: 70,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Why you should get an Avon health Plan;\n                     See how it works",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => StaticHtmlScreen(
                              path: "assets/web/htmls/avonwhy.html",
                              title: "See How It Works")));
                },
              )
            ],
          ),
          decoration: BoxDecoration(
              color: Color(0xffF5EEF7),
              borderRadius: BorderRadius.circular(10)),
        ),
        SizedBox(height: 20),
        GridView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 1),
            itemCount: menuItems.length,
            itemBuilder: (BuildContext context, int index) {
              Map item = menuItems[index];
              return MenuItemCard(
                item: item,
                width: item['width'],
                top: item['top'],
                bottom: item['bottom'],
                left: item['left'],
                right: item['right'],
              );
            })
      ],
    );
  }
}
