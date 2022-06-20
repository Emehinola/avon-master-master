import 'dart:math';

import 'package:avon/models/buy_plan.dart';
import 'package:avon/models/plan.dart';
import 'package:avon/screens/plan/plan_list.dart';
import 'package:avon/screens/plan/request_quote.dart';
import 'package:avon/screens/plan/sub_plan.dart';
import 'package:avon/screens/plan/view_sub_plan.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/widgets/design/explore%20plan/compare_our_plan.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PlanCard extends StatelessWidget {
  Plan? plan;
  Plan? parentPlan;
  String? fromPage;

  PlanCard({Key? key, this.plan, this.parentPlan, this.fromPage})
      : super(key: key);

  var format = NumberFormat("#,###.##", "en_US");

  @override
  Widget build(BuildContext context) {
    MainProvider _state = Provider.of<MainProvider>(context);

    return Visibility(
      visible: plan != null,
      child: GestureDetector(
        onTap: () {
          // if (fromPage == "Renew Plan") {
          //   _state.order?.selectedSubPlan = plan;
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (BuildContext context) => ViewSubPlan(
          //                 plan: plan!,
          //                 parentPlan: parentPlan,
          //               )));
          // }
          if (plan!.requiredQuoteRequest) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => RequestQuoteScreen(
                        plan: plan!, planTypeName: plan?.planTypeName)));
            return;
          }
          print(">>>> ${plan?.icon} <<<<<<");
          if (plan?.planTypeId == null) {
            _state.order =
                BuyPlan(order_id: Random().nextInt(9999), selectedPlan: plan);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        SubPlanListScreen(plan: plan!),
                    settings: RouteSettings(name: "sub-plans")));
          } else {
            _state.order?.selectedSubPlan = plan;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ViewSubPlan(
                          plan: plan!,
                          parentPlan: parentPlan,
                        )));
          }
        },
        child: Container(
          height: 250,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    child: Image.network(plan?.icon ?? '', scale: 2.5),
                    radius: 25,
                    backgroundColor: plan?.color),
                SizedBox(height: 20),
                Flexible(
                  child: Text(
                    "${plan?.planTypeName}",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.044,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 10),
                Flexible(
                  child: Text("${plan?.description ?? ''}",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          fontWeight: FontWeight.w300,
                          color: Colors.black87)),
                ),
                const SizedBox(height: 20),
                if (plan?.requiredQuoteRequest ?? false)
                  GestureDetector(
                    child: Text(
                      "Request A Quote",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.039,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RequestQuoteScreen(
                                      plan: plan!,
                                      planTypeName: plan?.planTypeName)));
                    },
                  ),
                Visibility(
                  visible: plan?.premium != null,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "₦${format.format(plan?.premium ?? 0)}",
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      TextSpan(
                          text: " Per Annum",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 15)),
                    ]),
                  ),
                )
              ],
            ),
          ),
          decoration: BoxDecoration(
              color: plan?.color?.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image:
                      NetworkImage(parentPlan?.bgImage ?? plan?.bgImage ?? ''),
                  fit: BoxFit.cover)),
        ),
      ),
      replacement: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                    style: TextStyle(color: AVColors.primary, fontSize: 12)),
                color: Colors.transparent,
                borderColor: AVColors.primary,
                horizontalPadding: 10,
                verticalPadding: 11,
                radius: 2,
                callBack: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => PlanListScreen()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
