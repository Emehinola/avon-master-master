import 'dart:convert';
import 'dart:developer';
import 'package:avon/models/plan.dart';
import 'package:avon/screens/plan/plan_list.dart';
import 'package:avon/screens/plan/sub_plan.dart';
import 'package:avon/screens/plan/view_sub_plan.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/widgets/dashboard/plan_card.dart';
import 'package:http/http.dart' as http;
import 'package:avon/widgets/design/design_widget/circular_container.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RenewBuyPlan extends StatefulWidget {
  const RenewBuyPlan({Key? key}) : super(key: key);

  @override
  State<RenewBuyPlan> createState() => _RenewBuyPlanState();
}

class _RenewBuyPlanState extends State<RenewBuyPlan> {
  BuildContext? dialogContext;
  MainProvider? _state;

  @override
  void initState() {
    // TODO: implement initState
    _state = Provider.of(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MainProvider _state = Provider.of<MainProvider>(context, listen: false);

    return AVScaffold(
      title: "Renew or Buy plans",
      showAppBar: true,
      decoration: BoxDecoration(color: Colors.white),
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 10),
        child: Column(
          children: [
            circularContainer(
                text: "Renew Plan",
                onPressed: () {
                  _getCurrentPlan();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) => SubPlanListScreen(
                  //               plan: _state.plan,
                  //             )));
                }),
            circularContainer(
                text: "Buy Plan",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => PlanListScreen()));
                }),
          ],
        ),
      ),
    );
  }

  _getCurrentPlan() async {
    _showModal();

    http.Response response = await HttpServices.get(
        context, "get-current-plan-detail-new/${_state?.user.memberNo}");

    if (response.statusCode == 200) {
      try {
        var body = jsonDecode(response.body);
        Plan plan = Plan.fromCurrentSubPlanJson(body);
        Navigator.pop(dialogContext!);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    SubPlanListScreen(plan: plan, fromPage: "Renew Plan")));
      } catch (e) {
        print("eeeeee: $e");
      }
    } else {}

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) =>
    //             PlanListScreen(header: "Renew Plan")));
  }

  _showModal() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext _ctx) {
          dialogContext = _ctx;
          return AlertDialog(
              content: Container(
                child: Center(
                  child: onSubmitModal(),
                ),
                height: 200,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))));
        });
  }

  Widget onSubmitModal() => IntrinsicHeight(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircularProgressIndicator.adaptive(),
            SizedBox(height: 20),
            Text("Please wait",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
            SizedBox(height: 10),
            SizedBox(
                width: 300,
                child: Text("We are currently retrieving your current plan",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                        height: 1.3))),
          ],
        ),
      );
}
