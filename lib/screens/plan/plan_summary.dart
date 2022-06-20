import 'dart:convert';
import 'package:avon/models/buy_plan.dart';
import 'package:avon/screens/auth/login.dart';
import 'package:avon/screens/beneficiary/principal_details.dart';
import 'package:avon/screens/payment/payment_option.dart';
import 'package:avon/screens/plan/plan_list.dart';
import 'package:avon/screens/webviews/static-html.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/widgets/empty_content.dart';
import 'package:avon/widgets/forms/checkbox_input.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/loader.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SubPlanSummary extends StatefulWidget {
  final bool fromPlans;
  SubPlanSummary({Key? key, this.fromPlans = false}) : super(key: key);

  @override
  _SubPlanSummaryState createState() => _SubPlanSummaryState();
}

class _SubPlanSummaryState extends State<SubPlanSummary> {
  MainProvider? _state;
  List<BuyPlan> cart = [];
  bool agree = false;
  bool isGettingNhis = false;
  double nhisAmount = 0;
  var format = NumberFormat("#,###.##", "en_US");

  initState() {
    super.initState();
    _state = Provider.of<MainProvider>(context, listen: false);

    // GeneralService().removePref('cart');
    _getCart();
  }

  _getCart() async {
    String? data = await GeneralService().getStringPref('cart');
    if (data == null) return;
    List plans = jsonDecode(data);
    setState(() {
      cart = plans.map((e) => BuyPlan.fromJson(e)).toList();
      _state?.cart = plans.map((e) => BuyPlan.fromJson(e)).toList();
    });
    getNHIS();

    _state?.setCartData();
  }

  Widget build(BuildContext context) {
    print("plan summary");
    return WillPopScope(
      child: AVScaffold(
        showAppBar: true,
        leadingCallBack: () {
          if (widget.fromPlans) {
            if (_state?.cart.isNotEmpty ?? false) {
              setState(() {
                _state?.cart.removeLast();
              });
            }
          }
          Navigator.pop(context);
        },
        decoration: BoxDecoration(color: Colors.white),
        title: "Summary",
        child: Container(
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).padding.top + kToolbarHeight),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Please review your purchase and accept the terms and conditions to proceed.",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(height: 35),
                            Text('Plan',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: cart.length < 1,
                              child: Center(
                                  child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 50),
                                child: EmptyContent(
                                    text: "No Plan has been added"),
                              )),
                              replacement: ListView.builder(
                                itemBuilder: (BuildContext context, int index) {
                                  BuyPlan? order = cart[index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: planDetailItem(
                                        order: order, canDelete: true),
                                  );
                                },
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: cart.length,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Divider(),
                            Text('Order summary',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                            SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                BuyPlan? order = cart[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: _summary(
                                      item:
                                          "${order.selectedSubPlan?.planName ?? ''}",
                                      price:
                                          "₦${format.format(_buildPlanPrice(order))}"),
                                );
                              },
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: cart.length,
                              padding: EdgeInsets.all(0),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("NHIS (1%)",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400)),
                                isGettingNhis
                                    ? AVLoader()
                                    : Text(
                                        "₦${format.format(nhisAmount)}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      )
                              ],
                            ),
                            SizedBox(height: 10),
                            _summary(
                                item: "Total",
                                price:
                                    "₦${format.format((_state?.getCartTotal() ?? 0) + nhisAmount)}"),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 0),
                                child: AVTextButton(
                                  radius: 5,
                                  color: Colors.white,
                                  borderColor: Color(0xff631293),
                                  child: Text(
                                      cart.length < 1 ? 'Buy Plan' : 'Buy More',
                                      style: TextStyle(
                                          color: Color(0xff631293),
                                          fontSize: 16)),
                                  verticalPadding: 15,
                                  callBack: () {
                                    if (widget.fromPlans) {
                                      Navigator.popUntil(context,
                                          ModalRoute.withName("sub-plans"));
                                    }
                                    _state?.pageController.jumpToPage(2);
                                    Navigator.popUntil(context,
                                        ModalRoute.withName("dashboard"));
                                  },
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 200,
                        )
                      ]),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 20,
                  right: 20,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.black12, offset: Offset(0, -1))
                    ]),
                    padding: EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: AVCheckBoxInput(
                              value: agree,
                              label: Wrap(
                                children: [
                                  Text("I have read and agreed to Avon HMO’s ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black,
                                          fontSize: 13)),
                                  InkWell(
                                    child: Text(
                                      "Terms ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Color(0xff631293),
                                          fontSize: 13),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StaticHtmlScreen(
                                                      title:
                                                          "Terms & Conditions",
                                                      path:
                                                          "https://www.avonhealthcare.com/understanding-insurance/terms/",
                                                      isWeb: true)));
                                    },
                                  ),
                                  Text("and ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black,
                                          fontSize: 13)),
                                  InkWell(
                                    child: Text("Privacy policy",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: Color(0xff631293),
                                            fontSize: 13)),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StaticHtmlScreen(
                                                      title: "Privacy & Policy",
                                                      path:
                                                          "https://www.avonhealthcare.com/understanding-insurance/privacy-policy/",
                                                      isWeb: true)));
                                    },
                                  ),
                                ],
                              ), //
                              onChanged: (bool? value) {
                                setState(() {
                                  agree = value!;
                                });
                              }),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
                            child: AVTextButton(
                              radius: 5,
                              disabled:
                                  cart.length < 1 || isGettingNhis || !agree,
                              showLoader: isGettingNhis,
                              child: Text('Continue to payment',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              verticalPadding: 17,
                              callBack: () {
                                if (cart.length < 1) return;
                                // if (!(_state?.isLoggedIn ?? false)) {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (BuildContext context) =>
                                //               LoginScreen()));
                                //   return;
                                // }
                                _state?.currentPlanIndex = 0;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            PrincipalDetailsScreen()));
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (BuildContext context)=>
                                //         PaymentOption(data: {
                                //           "orderReference":"ref453",
                                //           "amount": 5000,
                                //         }))
                                // );
                              },
                            )),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return true;
      },
    );
  }

  getNHIS() async {
    setState(() {
      isGettingNhis = true;
    });

    try {
      double amount = _state?.getCartTotal() ?? 0;
      http.Response response = await HttpServices.get(
          context, "utils/nhis/$amount",
          handleError: false);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        setState(() {
          nhisAmount = double.parse(body['data'].toString());
          _state?.nhisAmount = double.parse(body['data'].toString());
        });
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isGettingNhis = false;
    });
  }

  double _buildPlanPrice(BuyPlan order) {
    return ((order.selectedSubPlan?.premium ?? 0) * (order.noOfIdividuals));
  }

  Widget _summary({required String item, required String price}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
            ),
            Text(
              price,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ],
        ),
      );

  Widget planDetailItem({required BuyPlan order, bool canDelete = false}) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          children: [
            CircleAvatar(
                child: Image.network(order.selectedSubPlan?.icon ?? '',
                    scale: 2.5),
                radius: 25,
                backgroundColor: order.selectedSubPlan?.color),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${order.selectedPlan?.planTypeName ?? ''} ",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 5),
                  Text("${order.selectedSubPlan?.planName ?? ''}",
                      maxLines: 1,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
                ],
              ),
            ),
            Visibility(
                visible: canDelete,
                child: IconButton(
                  onPressed: () async {
                    setState(() {
                      cart.removeWhere(
                          (element) => element.order_id == order.order_id);
                      _state?.cart = cart;
                      _state?.saveCart(cart);
                      _getCart();
                    });
                  },
                  icon: Icon(Icons.delete_forever_outlined,
                      color: Color(0xffF16063), size: 30),
                ))
          ],
        ),
        decoration: BoxDecoration(
            color: order.selectedSubPlan?.color?.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10)),
      );
}
