import 'dart:convert';
import 'package:avon/models/enrollee_plan.dart';
import 'package:avon/models/hospital.dart';
import 'package:avon/screens/auth/create_account.dart';
import 'package:avon/screens/enrollee/hospital/tabs/photos.dart';
import 'package:avon/screens/enrollee/hospital/tabs/provider_plans.dart';
import 'package:avon/screens/enrollee/hospital/tabs/tabs.dart';
import 'package:avon/screens/webviews/map.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/enrollee-services.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/utils/services/notifications.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/screens/select_provider_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ViewHospitalScreen extends StatefulWidget {
  Hospital hospital;
  final bool isDropSelect;
  final bool fromBuyPlan;
  ViewHospitalScreen(
      {Key? key,
      required this.hospital,
      this.isDropSelect = false,
      this.fromBuyPlan = false})
      : super(key: key);

  @override
  State<ViewHospitalScreen> createState() => _ViewHospitalScreenState();
}

class _ViewHospitalScreenState extends State<ViewHospitalScreen>
    with TickerProviderStateMixin {
  bool isLoading = false;
  late TabController _controller;
  Hospital get hospital => widget.hospital;
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            Navigator.pop(context);
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.black,
          ),
        ),
        title: Text(
          "${hospital.name}",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 2),
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  AspectRatio(
                    aspectRatio: 2.1,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/design_image/hos_info.png"),
                              fit: BoxFit.fill),
                          shape: BoxShape.rectangle),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TabBar(
                    controller: _controller,
                    labelColor: Color(0xff155E33),
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w800),
                    unselectedLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Color(0xff155E33),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(
                        text: "Overview",
                      ),
                      // Tab(text: "Reviews",),
                      // Tab(text: "Photos",),
                      Tab(
                        text: "Plans",
                      )
                    ],
                    onTap: (int index) {
                      pageController.jumpToPage(index);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: PageView(
                        controller: pageController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Overview(),
                          // Rates(code: hospital.code.toString()),
                          // reviews(),
                          // Photos(code: hospital.code.toString()),
                          ProviderPlans(code: hospital.code.toString())
                        ]),
                  )
                ],
              ),
              Positioned(
                bottom: 20,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: AVTextButton(
                      radius: 5,
                      child: Text('Choose Hospital',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      callBack: _choose,
                      verticalPadding: 17,
                      showLoader: isLoading,
                      disabled: isLoading),
                ),
              )
            ],
          )),
    );
  }

  void _choose() async {
    MainProvider state = Provider.of<MainProvider>(context, listen: false);

    if (widget.isDropSelect) {
      Navigator.pop(context, hospital);
      return;
    }

    if (!state.isLoggedIn) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CreateAccountScreen()));
      return;
    }
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });

    Map payload = {
      "enrolleeId": "${state.user.enrolleeId}",
      "providerCode": hospital.code
    };
    String endpoint = "";
    http.Response? response;

    if (widget.fromBuyPlan) {
      endpoint = 'plans/suscribe/enrollee/provider-detail';
      response = await HttpServices.post(context, endpoint, payload);
    } else {
      endpoint = 'provider/member/change';
      payload = {
        "memberno": "${state.user.memberNo}",
        "pProvderno": hospital.code.toString(),
        "changeDate": null
      };
      response = await HttpServices.post(context, endpoint, payload);
    }

    if (response!.statusCode == 200) {
      print("response.body: ${response.body}");
      Map data = jsonDecode(response.body);
      if (data['hasError'] == false) {
        try {
          EnrolleePlan? _plan = await EnrolleeServices.getPlanDetails(
              context, "${state.user.memberNo}");
          if (_plan != null) {
            setState(() {
              state.plan = _plan;
            });
          }
        } catch (e) {}

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SelectProviderSuccess(fromBuyPlan: widget.fromBuyPlan)));
        // NotificationService.successSheet(context, data['message']);
      } else {
        // NotificationService.errorSheet(context, data['message']);
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  Widget reviews() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rate and Review",
                style: TextStyle(
                    color: Color(0xff2E2E2E),
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Text(
                "Share your experience to help others",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w300, height: 1.2),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/design_image/hospital.png"),
                            fit: BoxFit.fill),
                        shape: BoxShape.circle),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  RatingBarIndicator(
                    itemCount: 5,
                    itemSize: 30,
                    rating: 3,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                    unratedColor: Colors.black.withOpacity(0.5),
                    itemBuilder: (context, index) => Icon(
                      Icons.star_border_outlined,
                      color: Colors.amber,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Reviews",
                style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w300, height: 1.2),
              ),
              const SizedBox(height: 15),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/design_image/hospital.png"),
                                fit: BoxFit.fill),
                            shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Janet Iweala",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text("Product Designer",
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w300)),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RatingBarIndicator(
                        itemCount: 5,
                        itemSize: 20,
                        rating: 3,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                        unratedColor: Colors.black.withOpacity(0.5),
                        itemBuilder: (context, index) => Icon(
                          Icons.star_border_outlined,
                          color: Colors.amber,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("3 Months ago")
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "You can find a list of various hospitals where Avon health is accepted",
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w300, height: 1.3),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.thumb_up_alt_outlined,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "4",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: Icon(
                          Icons.share_outlined,
                          size: 20,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      );

  Widget Overview() => Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Container(
                  padding: EdgeInsets.only(bottom: 10),
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Color(0xff2B7EA1),
                        size: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          child: Text("${hospital.address}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 14)))
                    ],
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1.2, color: const Color(0xffCFCFCF))))),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            MapView(hospital: hospital)));
              },
            ),
            Container(
                padding: EdgeInsets.only(bottom: 10),
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: Color(0xff2B7EA1),
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                        child: Text("${hospital.hmoDeskPhoneNo}",
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 14)))
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1.2, color: const Color(0xffCFCFCF))))),
            Container(
                padding: EdgeInsets.only(bottom: 10),
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.mail,
                      color: Color(0xff2B7EA1),
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${hospital.hmoOfficerEmail}",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1.2, color: const Color(0xffCFCFCF))))),
            SizedBox(
              height: 12,
            ),
            Text(
              "Location",
              style: TextStyle(
                  color: Color(0xff2E2E2E),
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      );
}
