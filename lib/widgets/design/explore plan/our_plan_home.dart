import 'package:avon/screens/enrollee/dashboard/actions.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../menu_item.dart';

class OurPlanHome extends StatefulWidget {


   OurPlanHome({Key? key}) : super(key: key);

  @override
  State<OurPlanHome> createState() => _OurPlanHomeState();
}

class _OurPlanHomeState extends State<OurPlanHome> {
  late List menuItems;

  int activeIndex =0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuItems= [
      {
        "icon": "assets/images/image 871.png",
        "icon_color": 0XFFC5329C,
        "prefix": "Check out",
        "label":  "Our plans",
        "image":  "assets/images/Group.png",
        "color": 0xffD13CEA,
      },
      {
        "icon": "assets/images/Group 31175.png",
        "icon_color": 0XFFC5329C,
        "prefix": "List of",
        "label":  "Hospitals",
        "image":  "assets/images/Group 33542.png",
        "color":  0xffF6917A,
      },
      {
        "icon": "assets/images/image 874.png",
        "icon_color": 0XFFC5329C,
        "prefix": "Wellness &",
        "label":  "Hospitals",
        "image":  "assets/images/Group420.png",
        "color":  0xff767D93,
      },
      {
        "icon": "assets/images/Mask Group.png",
        "icon_color": 0XFF0066FF,
        "prefix": "Health risk",
        "label":  "Hospitals",
        "image":  "assets/images/Group420.png",
        "color":  0xff61C1FB,
      },
      {
        "icon": "assets/images/image 873.png",
        "icon_color": 0XFFD2E3EA,
        "prefix": "Our",
        "label":  "Press room",
        "image":  "assets/images/Group 33542.png",
        "color":  0xffE8D9EC,
      },
      {
        "icon": "assets/images/image 872.png",
        "icon_color": 0XFFD2E3EA,
        "prefix": "Watch Our",
        "label":  "Videos",
        "image":  "assets/images/Group 33542.png",
        "color":  0xff956714,
      },
      {
        "icon": "assets/images/calendar 1.png",
        "icon_color": 0XFFD2E3EA,
        "prefix": "Chat/Email/Call",
        "label":  "Contact Us",
        "image":  "assets/images/Group 31141.png",
        "color":  0xff9092fc,
      },
      {
        "icon": "assets/images/image 872.png",
        "icon_color": 0XFFD2E3EA,
        "prefix": "Consult",
        "label":  "a doctor",
        "image":  "assets/images/Group420.png",
        "color":  0xff65a965,
      },
      {
        "icon": "assets/images/Group 31175 (1).png",
        "icon_color": 0XFFD2E3EA,
        "prefix": "Partner",
        "label":  "With US",
        "image":  "assets/images/Group 33542.png",
        "color":  0xff956714,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,),
        child: Column(
          children: [

            SizedBox(height: MediaQuery.of(context).size.height *0.06,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [

               Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   Text(
                       "Hi Guest",
                     style: TextStyle(
                       fontSize: 17,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                   RichText(
                     text: TextSpan(
                         children: [

                           TextSpan(
                               text: "Welcome to our world ",
                             style: TextStyle(
                               fontSize: 15,
                               fontWeight: FontWeight.w300,
                               color: Colors.black
                             ),
                           ),

                           WidgetSpan(
                               child: Text("🙂")
                           )

                         ]
                     ),
                   )
                 ],
               ),

               Container(
                 height: 50,
                 width: 50,
                 decoration: BoxDecoration(
                   image: DecorationImage(
                     image: AssetImage(
                       "assets/images/Profile-Picture.png"
                     )
                   ),
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

                  Container(
                    height: 70,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Why you need an Avon Plan and how it works?",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15

                    ),),
                  ),



                ],
              ),
              decoration: BoxDecoration(
                color: Color(0xffF5EEF7),
                borderRadius: BorderRadius.circular(10)
              ),
            ),

            SizedBox(height: 20,),

            Expanded(
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 1
                  ),
                  itemCount: menuItems.length,
                  itemBuilder: (BuildContext context, int index){
                    Map item = menuItems[index];
                    return MenuItemCard(item: item);
                  }
              ),
            )


          ],
        ),
      ),

      bottomNavigationBar:BottomNavigationBar(
        unselectedItemColor: Color(0xffA1A1A1),
      selectedItemColor: Color(0xff631293),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items:const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home"
        ),
        BottomNavigationBarItem(
          icon:Image(
            image: AssetImage("assets/images/h.png"),
          ),
          label: "Sign up"
        ),
        BottomNavigationBarItem(
            icon:Image(
              image: AssetImage("assets/images/h.png"),
            ),
          label: "Login"
        ),
      ],
      ),


    );
  }
}
