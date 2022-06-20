import 'dart:convert';
import 'dart:ui';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/widgets/dashboard/plan_card.dart';
import 'package:avon/widgets/empty_content.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:avon/widgets/skeleton-card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:avon/models/plan.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class SubPlanListScreen extends StatefulWidget {
  Plan plan;
  String? fromPage;

  SubPlanListScreen({Key? key, required this.plan, this.fromPage})
      : super(key: key);

  @override
  _SubPlanListScreenState createState() => _SubPlanListScreenState();
}

class _SubPlanListScreenState extends State<SubPlanListScreen> {
  final click = Text(
    'Click Here',
    style: TextStyle(color: Colors.red),
  );

  Plan get parentPlan => widget.plan;

  final Map subtexts = {
    "Individual": """
            <div style='font-size: 16px'>
        <p>Whether you are just starting out, mid-career or can afford the finer things in life, you want an affordable health plan that has been created just for you.</p>
        <p>Our Individual health plans provide the flexibility and affordability you desire while offering increasing levels of benefits.</p>
        <p>Important: Waiting periods and exclusions apply. <a href="https://www.avonhealthcare.com/understanding-insurance/terms/waiting-periods-and-exclusions/">Click here</a> to learn more.</p>
    </div>""",
    "Couple": """
    <div style='font-size: 16px'>
        <p>Perfect for people in committed relationships and newlyweds, our <a href="https://static.avonhealthcare.com/resources/plans/Couples.pdf">Couples Plan</a> has been carefully designed and appropriately priced for two, thus preparing you for a fruitful union and a healthy family.</p>
        <p>Important: Waiting periods and exclusions apply to certain health plans. Please <a href="https://www.avonhealthcare.com/understanding-insurance/terms/waiting-periods-and-exclusions/">click here</a> to learn more.</p>
    </div>
    """,
    "Family": """
      <div style='font-size: 16px'>
        <p>When you are nurturing a household, your priority would be to keep everyone healthy. Here, we have a wide range of plans to cater to the various healthcare needs of a family unit of six – you, your partner and up to four children (under the age of 18).</p>
        <p>Important: Waiting periods and exclusions apply to certain health plans. Please <a href="https://www.avonhealthcare.com/understanding-insurance/terms/waiting-periods-and-exclusions/">click here</a> to learn more.</p>
        <b>Please note that prices are per family per year.</b>
    </div>
    """
  };

  TextStyle _style =
      TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
        showAppBar: true,
        title: widget.fromPage ?? "",
        decoration: BoxDecoration(color: Colors.white),
        child: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).padding.top + kToolbarHeight)),
          height: double.negativeInfinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            Row(
              children: [
                Text(
                  '${parentPlan.planTypeName}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            HtmlWidget(subtexts[widget.plan.planTypeName]),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            Flexible(
                child: FutureBuilder(
              future: _getSubPlans(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Plan>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return _buildLoader();
                if (snapshot.hasError)
                  return EmptyContent(
                    text: "No sub plans",
                  );
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Plan plan = snapshot.data![index];

                      return PlanCard(
                        plan: plan,
                        parentPlan: parentPlan,
                        fromPage: widget.fromPage ?? "",
                      );
                    });
              },
            ))
          ]),
        ));
  }

  Future<List<Plan>> _getSubPlans() async {
    List<Plan> result = [];
    http.Response response = await HttpServices.get(
        context, "plans/${parentPlan.id}",
        handleError: false);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      List plans = data['data']
          .map((e) => (widget.fromPage == "Renew Plan"
              ? Plan.fromCurrentSubPlanJson(e)
              : Plan.fromSubPlanJson(e)))
          .toList();
      result.addAll(plans.map((e) => e));
    }

    return Future.value(result);
  }

  Widget _buildLoader() {
    return ListView.builder(
      itemBuilder: ((BuildContext context, int index) => Padding(
            padding: const EdgeInsets.only(top: 15),
            child: SkeletonBlock(
                height: 230,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                      ),
                      Container(
                        color: Colors.red,
                        height: 20,
                      )
                    ],
                  ),
                ),
                width: MediaQuery.of(context).size.width),
          )),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
    );
  }
}
