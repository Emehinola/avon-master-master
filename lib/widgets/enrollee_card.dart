import 'package:avon/models/enrollee.dart';
import 'package:avon/models/enrollee_plan.dart';
import 'package:avon/screens/enrollee/dashboard/profile/e_card.dart';
import 'package:avon/screens/plan/plan_list.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/constants/image_assets.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnrolleeCard extends StatelessWidget {
  EnrolleePlan? enrolleePlan;
  bool isDependant;

  EnrolleeCard({Key? key, this.enrolleePlan, this.isDependant = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainProvider _state = Provider.of<MainProvider>(context, listen: false);

    return Container(
        height: 200,
        decoration: BoxDecoration(
            color: Color(0xFFe1eae1), borderRadius: BorderRadius.circular(5)),
        child: enrolleePlan == null
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("No Plan Selected Yet",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          )),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      AVTextButton(
                        child: Text("Buy Plan Now",
                            style: TextStyle(
                                color: AVColors.primary, fontSize: 12)),
                        color: Colors.transparent,
                        borderColor: AVColors.primary,
                        horizontalPadding: 10,
                        verticalPadding: 11,
                        radius: 2,
                        callBack: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PlanListScreen()));
                        },
                      )
                    ],
                  ),
                ),
              )
            : GestureDetector(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/Group 9845.png"),
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            AVImages.shield,
                            width: 50,
                          ),
                          Padding(padding: EdgeInsets.only(left: 20)),
                          Flexible(
                              child: Align(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${enrolleePlan?.firstName} ${enrolleePlan?.surName}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        fontWeight: FontWeight.w700),
                                    overflow: TextOverflow.fade,
                                    softWrap: false),
                                Padding(padding: EdgeInsets.only(top: 6)),
                                Text(
                                  "${enrolleePlan?.planType ?? ''}",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                                Padding(padding: EdgeInsets.only(top: 6)),
                                Text("Plan ID: ${enrolleePlan?.memberNo ?? ''}",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400)),
                                Padding(padding: EdgeInsets.only(top: 6)),
                                Text(
                                    "Expiry Date: ${GeneralService().processDate(enrolleePlan?.policyExpiry ?? '') ?? ''}",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                            alignment: Alignment.topLeft,
                          )),
                          Padding(padding: EdgeInsets.only(left: 20)),
                          CircleAvatar(
                            // backgroundImage:
                            //     NetworkImage("${_state.plan?.imageUrl}"),
                            backgroundImage:
                                NetworkImage("${enrolleePlan?.imageUrl}"),
                            radius: 25,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ViewPlanScreen(
                              enrollee: enrolleePlan,
                              isDependant: isDependant)));
                }));
  }
}
