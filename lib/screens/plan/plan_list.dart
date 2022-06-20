import 'dart:convert';
import 'package:avon/screens/enrollee/dashboard.dart';
import 'package:avon/utils/constants/image_assets.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/widgets/auth/simple-header.dart';
import 'package:avon/widgets/dashboard/plan_card.dart';
import 'package:avon/widgets/design/design_widget/card_container.dart';
import 'package:avon/widgets/empty_content.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:avon/widgets/skeleton-card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:avon/models/plan.dart';

class PlanListScreen extends StatefulWidget {
  bool showAppBar;
  String? header;

  PlanListScreen({Key? key, this.showAppBar = false, this.header})
      : super(key: key);

  @override
  _PlanListScreenState createState() => _PlanListScreenState();
}

class _PlanListScreenState extends State<PlanListScreen>
    with AutomaticKeepAliveClientMixin<PlanListScreen> {
  @override
  bool get wantKeepAlive => true;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AVScaffold(
        showAppBar: widget.showAppBar,
        title: '',
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            child: AVTextButton(
              child: Text(
                "skip",
                style: TextStyle(color: Colors.black),
              ),
              radius: 20,
              verticalPadding: 0,
              horizontalPadding: 30,
              borderColor: Colors.black,
              color: Colors.transparent,
              callBack: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            EnrolleeDashboardScreen()));
              },
            ),
          )
        ],
        decoration: BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).padding.top + kToolbarHeight)),
            height: double.negativeInfinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(top: widget.showAppBar ? 0 : 20)),
              SimpleAuthHeader(
                  header: widget.header ?? "Buy A Health Plan",
                  body: widget.showAppBar
                      ? "Click on skip to continue without a plan"
                      : ""),
              Padding(padding: EdgeInsets.only(bottom: 0)),
              Flexible(
                  child: FutureBuilder(
                future: _getPlans(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Plan>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return _buildLoader();
                  if (snapshot.hasError)
                    return EmptyContent(
                      text: "No plans yet",
                    );

                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        Plan plan = snapshot.data![index];

                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: PlanCard(
                            plan: plan,
                          ),
                        );
                      });
                },
              ))
            ]),
          ),
        ));
  }

  Future<List<Plan>> _getPlans() async {
    List<Plan> result = [];
    http.Response response =
        await HttpServices.get(context, "plans", handleError: false);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List plans = data['data'].map((e) => Plan.fromPlanJson(e)).toList();
      result.addAll(plans.map((e) => e));
    }

    return Future.value(result);
  }

  Widget _buildLoader() {
    return ListView.builder(
      itemBuilder: ((BuildContext context, int index) => Padding(
            padding: const EdgeInsets.only(top: 15),
            child: SkeletonBlock(
                height: 200,
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
