import 'dart:convert';
import 'package:avon/models/enrollee_plan.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/widgets/dashboard/enrollee_dashboard_header.dart';
import 'package:avon/widgets/empty_content.dart';
import 'package:avon/widgets/enrollee_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:developer';

class EnrolleeHomeScreen extends StatefulWidget {
  const EnrolleeHomeScreen({Key? key}) : super(key: key);

  @override
  _EnrolleeHomeScreenState createState() => _EnrolleeHomeScreenState();
}

class _EnrolleeHomeScreenState extends State<EnrolleeHomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  BehaviorSubject<List> dependantsController = BehaviorSubject.seeded([]);
  BehaviorSubject<List> sponsorController = BehaviorSubject.seeded([]);

  bool isLoading = false;
  bool isCompleted = false;
  bool isLoadingDependant = false;
  List cards = [];
  MainProvider? state;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    state = Provider.of<MainProvider>(context, listen: false);
    _getDependants();
    _getSponsors();
  }

  @override
  Widget build(BuildContext context) {
    log("Enrolle ID: ${state?.user.enrolleeId}");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 20)),
          EnrolleeDashboardHeader(
              showNotifation: true, greetings: "Your well-being matters to us"),
          Padding(padding: EdgeInsets.only(top: 30)),
          Visibility(
            visible: !(state?.plan == null),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Principal Enrollee",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16)),
                Padding(padding: EdgeInsets.only(top: 15)),
                EnrolleeCard(enrolleePlan: state?.plan),
                SizedBox(height: 20),
              ],
            ),
            replacement: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text('Your membership status is inactive.')),
                ),
                Center(child: Text(' Please subscribe to a health plan to')),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text('continue enjoying your Avon HMO benefits')),
                )
              ],
            ),
          ),
          _buildChildren(
              title: "Dependant Enrollee", data: dependantsController),
          _buildChildren(title: "Sponsored Enrollee", data: sponsorController),
        ],
      ),
    );
  }

  Widget _buildChildren(
      {required String title, required BehaviorSubject<List> data}) {
    return StreamBuilder<List>(
      stream: data.stream,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if ((snapshot.data ?? []).length == 0) return Text('');
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Text(title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16)),
            SizedBox(height: 15),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  EnrolleePlan plan =
                      EnrolleePlan.fromJson(snapshot.data![index]);
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child:
                          EnrolleeCard(enrolleePlan: plan, isDependant: true));
                })
          ],
        );
      },
    );
  }

  _getDependants() async {
    List dependants = [];
    setState(() {
      isLoadingDependant = true;
    });
    http.Response response = await HttpServices.get(
        // context, "enrollee/dependants/${state?.user.enrolleeId}");
        context,
        "get-dependant-by-memberNo/${state?.user.memberNo}");

    setState(() {
      isLoadingDependant = false;
    });
    print("Dependants >>>: ${jsonDecode(response.body)}");
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      dependants = body['data'];
    }
    dependantsController.add(dependants);
  }

  _getSponsors() async {
    List sponsors = [];
    setState(() {
      isLoadingDependant = true;
    });
    http.Response response = await HttpServices.get(
        // context, "enrollee/sponsors/${state?.user.enrolleeId}");
        context,
        "enrollee/sponsors-Memberno/${state?.user.memberNo}");

    setState(() {
      isLoadingDependant = false;
    });
    print("sponsor >>>: ${jsonDecode(response.body)}");
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      print(">>> Sponsors $body");
      sponsorController.add(body['data']);
    }
  }
}
