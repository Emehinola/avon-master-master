import 'dart:convert';
import 'package:avon/models/buy_plan.dart';
import 'package:avon/models/plan.dart';
import 'package:avon/screens/beneficiary/principal_details.dart';
import 'package:avon/screens/buy_plan_success.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/utils/services/notifications.dart';
import 'package:avon/widgets/design/create%20account/success_plan.dart';
import 'package:avon/widgets/empty_content.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  final bool fromPlans;
  OrderScreen({Key? key, this.fromPlans = false}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  MainProvider? _state;
  List<BuyPlan> cart = [];
  bool agree = false;
  bool isGettingNhis = false;
  double nhisAmount = 0;
  var format = NumberFormat("#,###.##", "en_US");

  initState(){
    super.initState();
    _state = Provider.of<MainProvider>(context, listen: false);

  }


  // _getCart()async {
  //   String? data = await GeneralService().getStringPref('cart');
  //   if(data == null) return;
  //   List plans = jsonDecode(data);
  //   setState(() {
  //     cart = plans.map((e) => BuyPlan.fromJson(e)).toList();
  //     _state?.cart = plans.map((e) => BuyPlan.fromJson(e)).toList();
  //   });
  //   _state?.setCartData();
  // }


  Widget build(BuildContext context) {
    return WillPopScope(
      child: AVScaffold(
        showAppBar: true,
        leadingCallBack: (){
          if(widget.fromPlans){
            if(_state?.cart.isNotEmpty ?? false){
              setState((){ _state?.cart.removeLast(); });
            }
          }
          Navigator.pop(context);
        },
        decoration: BoxDecoration(
            color: Colors.white
        ),
        title: "Orders",
        child: Container(
          height: MediaQuery.of(context).size.height - (
              MediaQuery.of(context).padding.top + kToolbarHeight
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Review your purchase and view pending orders and payment from here",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,

                              ),
                            ),
                            SizedBox(height: 35),
                            Text(
                                'Plan',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black)
                            ),
                            SizedBox(
                              height:10,
                            ),
                            Visibility(
                              visible: _state?.cartData.length == 0 ,
                              child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 50),
                                    child: EmptyContent(text: "No Plan has been added"),
                                  )
                              ),
                              replacement: ListView.builder(
                                itemBuilder: (BuildContext context, int index){
                                  Plan order = _state?.cartData[index]['plan'];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: planDetailItem(
                                        order: order,
                                        index: index
                                    ),
                                  );
                                },
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _state?.cartData.length,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 200,
                        )
                      ]
                  ),
                ),
              ),
              if((_state?.cartData.length ?? 0) > 0)
              Positioned(
                  bottom: 0,
                  left: 20,
                  right: 20,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, offset: Offset(0, -1))
                        ]
                    ),
                    padding: EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                            child: AVTextButton(
                              radius: 5,
                              child: Text('Complete', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16
                              )),
                              verticalPadding: 17,
                              callBack: _verifyDetails
                            )
                        ),
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      ),
      onWillPop: ()async {
        return true;
      },
    );
  }

  Widget planDetailItem({
    required Plan order,
    required int index
  }){
    Map? enrolleeData = _state?.cartData[index];
    bool filled = enrolleeData!['details'] != null ? true : false;

    return Column(
      children: [
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        child: Image.network(order.icon ?? '', scale: 2.5),
                        radius: 25,
                        backgroundColor: order.color
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${order.planTypeName} ",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 5),
                          Text("${order.planName }",
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300)),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                                color: filled ? Colors.green.withOpacity(0.3):Colors.red.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(3)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: Text(filled ? "Completed":"Pending",
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: filled ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.w500)),
                          ),
                          SizedBox(height: 15),
                          Text("Enrolleee: "
                              "${
                                  filled ? enrolleeData['details']['surname'] : "Nill"
                              }",
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                              ),
                              overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                        filled ? Icons.check : Icons.arrow_forward,
                        color: filled ? Colors.green:Colors.black,
                    )
                  ],
                ),
                if(enrolleeData['isSponsor'])
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Align(
                    child: Text("Sponsored", style: TextStyle(
                        color: Colors.blueGrey
                    )),
                    alignment: Alignment.bottomRight,
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
                color: order.color?.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)
            ),
          ),
          onTap: (){
            _state?.currentPlanIndex = index;
            Navigator.push(context,
                MaterialPageRoute(builder:
                    (BuildContext context)=> 
                        PrincipalDetailsScreen(index: index)))
            .then((value) => setState((){}));
          },
        ),
        SizedBox(height: 15),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }

  _verifyDetails(){
    try{
      _state?.cartData.forEach((element) {
        if(element['details'] == null) throw("");
      });
    }catch(e){
      NotificationService.errorSheet(context, "Please ensure you have filled all details before proceeding.");
      return;
    }

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context)=>
        BuyPlanSuccess()));
  }
}
