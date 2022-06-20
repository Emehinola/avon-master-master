import 'package:avon/models/enrollee.dart';
import 'package:avon/screens/enrollee/dashboard/avon_notification.dart';
import 'package:avon/screens/enrollee/dashboard/orders.dart';
import 'package:avon/screens/enrollee/dashboard/profile.dart';
import 'package:avon/screens/plan/plan_summary.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/constants/image_assets.dart';
import 'package:avon/widgets/auth/simple-header.dart';
import 'package:avon/widgets/design/create%20account/plan_summary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:avon/widgets/design/home/avon_notification.dart';

class EnrolleeDashboardHeader extends StatelessWidget {
  bool showAvatar;
  bool showNotifation;
  String greetings;

   EnrolleeDashboardHeader({Key? key,
    required this.greetings,
     this.showAvatar = false,
     this.showNotifation = false
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainProvider _state = Provider.of<MainProvider>(context);
    Enrollee enrollee= _state.user;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(child: SimpleAuthHeader(header: "Hi, ${enrollee.firstName}", body: greetings)),
        Row(
          children: [
            if(showAvatar)
              GestureDetector(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_state.plan?.imageUrl ?? ''),
                  radius: 16,
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> EnrolleeProfileScreen()));
                },
              ),
            if(showNotifation)
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> NotificationScreen()));
                },
                  child: CircleAvatar(
                    child: Icon(Icons.notifications, color: AVColors.primary),
                    radius: 18,
                    backgroundColor: AVColors.primary.withOpacity(0.15),
                  )
              ),
            Padding(padding: EdgeInsets.only(left: 15)),
            GestureDetector(
              child: Image.asset(AVImages.cartIcon),
              // child: Icons.cart,
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder:
                        (BuildContext context)=> SubPlanSummary(), settings: RouteSettings(name: "cart-summary")));
                        // (BuildContext context)=> OrderScreen(), settings: RouteSettings(name: "order-summary")));
              },
            ),
          ],
        )
      ],
    );
  }
}
