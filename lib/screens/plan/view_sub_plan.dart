import 'dart:convert';
import 'package:avon/models/plan.dart';
import 'package:avon/screens/plan/plan_summary.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/widgets/forms/checkbox_input.dart';
import 'package:avon/widgets/forms/dropdown_input.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class ViewSubPlan extends StatefulWidget {
  Plan? parentPlan;
  Plan plan;
  ViewSubPlan({Key? key, required this.plan, required this.parentPlan})
      : super(key: key);

  @override
  _ViewSubPlanState createState() => _ViewSubPlanState();
}

class _ViewSubPlanState extends State<ViewSubPlan>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  var format = NumberFormat("#,###.##", "en_US");
  int noOfIndividual = 1;
  bool isSponsor = false;
  Plan get plan => widget.plan;
  Plan? get parentPlan => widget.parentPlan;
  double get total => ((widget.plan.premium ?? 1) * noOfIndividual);
  MainProvider? state;
  Map? benefits = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    state = Provider.of(context, listen: false);

    loadBenefits();
  }

  @override
  Widget build(BuildContext context) {
    print("sub plan name: ${plan.planName}");
    return AVScaffold(
      showAppBar: true,
      title: "${plan.planName}",
      decoration: BoxDecoration(color: Colors.white),
      child: Column(children: [
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        //   child: Text(
        //     "This is our most basic plan and it covers a list of benefits which you can view below",
        //     style: TextStyle(
        //         fontSize: 17,
        //         fontWeight: FontWeight.w300,
        //         height: 1.2
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 20,
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text('Benefits',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black))),
                      Expanded(
                          child: Text("Coverage",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis)))
                    ],
                  ),
                  padding: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300))),
                ),
                SizedBox(height: 0),
                ...?benefits?.entries.map((e) {
                  return Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(e.key,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035,
                                      fontWeight: FontWeight.w400))),
                          Padding(padding: EdgeInsets.only(right: 10)),
                          Expanded(
                              child: Text(e.value,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035,
                                      fontWeight: FontWeight.w400)))
                        ]),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300))),
                  );
                })
              ],
            ))
      ]),
      bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          margin: EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: MediaQuery.of(context).size.width * 0.07),
          child: AVTextButton(
            radius: 5,
            child: Text('Proceed to buy',
                style: TextStyle(color: Colors.white, fontSize: 16)),
            verticalPadding: 17,
            callBack: () {
              _buildSheet(context);
            },
          )),
    );
  }

  Widget colText({required String head, required String content}) => Align(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              head,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(content,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xff2B7EA1),
                    fontSize: 16))
          ],
        ),
      );

  _buildSheet(BuildContext context) {
    GeneralService().bottomSheet(Flexible(
      child: SingleChildScrollView(child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Beneficiary",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            AVCheckBoxInput(
                value: state?.order?.isSponsor ?? false,
                label: Text(
                  "Buy for someone (be a sponsor)",
                  style: TextStyle(fontSize: 16),
                ),
                onChanged: (bool? value) {
                  setState(() {
                    state?.order?.isSponsor = value!;
                    if (!(value ?? false)) {
                      state?.order?.noOfIdividuals = 1;
                      noOfIndividual = 1;
                    }
                  });
                }),
            AnimatedCrossFade(
                firstChild: Container(),
                secondChild: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: AVDropdown(
                        options: ["1", "2", "3", "4", "5"],
                        label: "Number of Beneficiary",
                        value: noOfIndividual.toString(),
                        onChanged: (dynamic value) {
                          setState(() {
                            noOfIndividual = int.parse(value);
                          });
                          state?.order?.noOfIdividuals = int.parse(value);
                        })),
                crossFadeState: !(state?.order?.isSponsor ?? false)
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(milliseconds: 100)),
            Padding(padding: EdgeInsets.only(top: 20)),
            colText(
                head: "Price Per Individual",
                content: "₦${format.format(plan.premium)}"),
            SizedBox(height: 15),
            colText(head: "Total", content: "₦${format.format(total)}"),
            SizedBox(height: 30),
            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.width * 0.06),
                child: AVTextButton(
                  radius: 5,
                  child: Text('Add to cart',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  verticalPadding: 17,
                  callBack: _continue,
                ))
          ],
        );
      })),
    ), context, height: 450);
  }

  _continue() {
    var state = Provider.of<MainProvider>(context, listen: false);
    state.cart.add(state.order!);
    state.saveCart(state.cart);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => SubPlanSummary(fromPlans: true),
            settings: RouteSettings(name: "cart-summary")));
  }

  Future loadBenefits() async {
    var temp = await rootBundle.loadString('assets/jsons/plans_benefit.json');
    if (temp != null) {
      Map plans_benefit = jsonDecode(temp);

      if (plans_benefit.containsKey(parentPlan?.planTypeName)) {
        Map dt = plans_benefit[parentPlan?.planTypeName];
        if (dt.containsKey(plan.planName)) {
          setState(() {
            benefits = dt[plan.planName];
          });
        }
      }
    }
  }
}
