import 'dart:convert';
import 'dart:math';

import 'package:avon/screens/auth/login.dart';
import 'package:avon/screens/enrollee/dashboard/profile/change_password.dart';
import 'package:avon/screens/enrollee/dashboard/profile/e_card.dart';
import 'package:avon/screens/enrollee/dashboard/profile/faq.dart';
import 'package:avon/screens/enrollee/dashboard/profile/profile_view.dart';
import 'package:avon/screens/enrollee/self_service/refer_earn/invite_friend.dart';
import 'package:avon/screens/enrollee/self_service/refer_earn/referrals.dart';
import 'package:avon/screens/explore/contact/contact_us.dart';
import 'package:avon/screens/webviews/static-html.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/utils/services/notifications.dart';
import 'package:avon/utils/services/storage.dart';
import 'package:avon/widgets/enrollee_card.dart';
import 'package:http/http.dart' as http;
import 'package:avon/utils/services/general.dart';
import 'package:avon/widgets/forms/checkbox_input.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/toggle_input.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:avon/screens/enrollee/dashboard/orders.dart';
import 'package:seerbit_flutter/seerbit_flutter.dart';

enum SuffixType { TOGGLE, ARROW }

class EnrolleeProfileScreen extends StatefulWidget {
  const EnrolleeProfileScreen({Key? key}) : super(key: key);

  @override
  _EnrolleeProfileScreenState createState() => _EnrolleeProfileScreenState();
}

class _EnrolleeProfileScreenState extends State<EnrolleeProfileScreen> {
  MainProvider? _state;
  bool cyclePlannerToggle = false;
  bool notificationToggle = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _state = Provider.of<MainProvider>(context, listen: false);

    cyclePlannerToggle = _state!.user.getBoolPref('cycleplanner');
    notificationToggle = _state!.user.getBoolPref('notification');
    print(cyclePlannerToggle);
  }

  @override
  Widget build(BuildContext context) {
    _state = Provider.of<MainProvider>(context);

    return AVScaffold(
        showAppBar: true,
        centerTitle: false,
        title: 'My Profile',
        leadingCallBack: () {
          _state?.pageController.jumpToPage(0);
        },
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: AVTextButton(
              child: Text(
                "Logout",
                style: TextStyle(
                    color: Color(0xFFEE5959),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              color: Colors.transparent,
              callBack: () {
                AvonData().avonData.clear();
                GeneralService()
                    .removeAllPref(except: ['memberNo', 'password']);

                _state?.reset();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen()));
              },
            ),
          )
        ],
        decoration: BoxDecoration(color: Colors.white),
        horizontalPadding: 15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: 20)),
            _buildProfileCard(),
            Padding(padding: EdgeInsets.only(top: 40)),
            Column(
              children: [_buildMoreList(), _buildSupportList()],
            )
          ],
        ));
  }

  Widget _buildMoreList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            SeerbitMethod.startPayment(context,
                payload: payload, onSuccess: paysuccess(), onCancel: payfail());
            if (paysuccess == true) {
              print('payment made');
            } else {
              print('payment failed');
            }
          },
          child: Text("More",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
        ),
        Padding(padding: EdgeInsets.only(top: 20)),
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _buildProfileListItem(
                title: "Notifications",
                description: "Tap here to enable push notifications",
                type: SuffixType.TOGGLE,
                callBack: _toggleNotification,
                toggle: notificationToggle),
            if (_state?.plan?.gender.toString().toLowerCase() == 'f')
              _buildProfileListItem(
                  title: "Cycle planner",
                  description: "Tap here to turn on cycle planner",
                  type: SuffixType.TOGGLE,
                  toggle: cyclePlannerToggle,
                  callBack: _togglePlanner),
            _buildProfileListItem(
                title: "View your e-card",
                description: "Tap here to see your Avon ID card details",
                type: SuffixType.ARROW,
                callBack: () {
                  if (_state?.plan == null) {
                    NotificationService.errorSheet(
                        context, "No Plan Has Been Purchased");
                    return;
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>  ViewPlanScreen(
                              enrollee: _state?.plan,
                              isDependant: false))); // ViewPlanScreen()));
                }),
            _buildProfileListItem(
                title: "Change password",
                description: "Tap here to change your password",
                type: SuffixType.ARROW,
                callBack: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ChangePasswordScreen(fromAuth: false,)))
                      .then((value) => setState(() {
                            _state?.hideNavBar = false;
                          }));
                }),
            _buildProfileListItem(
                title: "Referrals",
                description: "Tap here to join our Refer and Earn promo.",
                type: SuffixType.ARROW,
                callBack: openReferral),
          ],
        )
      ],
    );
  }

  void openReferral() {
    MainProvider state = Provider.of<MainProvider>(context, listen: false);

    if (state.user.getBoolPref('refer_earn')) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ReferralsScreen()));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => InviteFriendOnboarding()));
    }
  }

  _toggleNotification(bool? v) async {
    setState(() {
      notificationToggle = v ?? false;
    });

    _state?.user =
        await _state?.user.setBoolPref('notification', v! ? "1" : "0");
  }

  _togglePlanner(bool? v) async {
    _state?.user =
        await _state?.user.setBoolPref('cycleplanner', v! ? "1" : "0");

    // print(_state?.user.pref);
    setState(() {
      cyclePlannerToggle = v ?? false;
    });
  }

  Widget _buildSupportList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(top: 40)),
        Text("Support",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
        Padding(padding: EdgeInsets.only(top: 10)),
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _buildProfileListItem(
                title: "FAQs",
                description: "Got a question? Tap here for answers.",
                type: SuffixType.ARROW,
                callBack: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => StaticHtmlScreen(
                                path:
                                    "https://www.avonhealthcare.com/understanding-insurance/faqs/",
                                title: "Frequently Asked Questions",
                                isWeb: true,
                              )));
                }),
            _buildProfileListItem(
                title: "Contact us",
                description: "Chat, Email, Call",
                type: SuffixType.ARROW,
                callBack: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ContactUsScreen()));
                })
          ],
        )
      ],
    );
  }

  Widget _buildProfileListItem(
      {String? title,
      String? description,
      SuffixType? type,
      Function? callBack,
      bool? toggle}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom:
                BorderSide(width: 2, color: AVColors.gray1.withOpacity(0.1))),
      ),
      padding: EdgeInsets.only(bottom: 15, top: 15),
      child: InkWell(
        onTap: () {
          if (type == SuffixType.ARROW && callBack != null) {
            callBack();
          }
        },
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${title}",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              Padding(padding: EdgeInsets.only(top: 5)),
              Text("${description}",
                  style: TextStyle(fontSize: 14, color: Colors.black54))
            ],
          ),
          Visibility(
            visible: type == SuffixType.TOGGLE,
            child: AVToggleInput(
              value: toggle ?? false,
              onChanged: (bool? v) {
                if (callBack != null) {
                  callBack(v);
                }
              },
            ),
            replacement: Icon(Icons.chevron_right),
          )
        ]),
      ),
    );
  }

  Widget _buildProfileCard() {
    Widget icon = CircleAvatar(
      backgroundImage: NetworkImage("${_state?.plan?.imageUrl}"),
      radius: 30,
    );

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: InkWell(
              child: Row(
                children: [
                  icon,
                  Padding(padding: EdgeInsets.only(right: 15)),
                  Flexible(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${_state?.user.firstName} ${_state?.user.lastName}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),

                      if(AvonData().avonData.get('phoneNumber') != null)SizedBox(
                        height: 18,
                        child: Text(
                          // "${_state?.user.mobilePhone}",
                          AvonData().avonData.get('phoneNumber'),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
if(AvonData().avonData.get('phoneNumber') == null)SizedBox(height: 3,),
                      Text("ID: ${_state?.plan?.memberNo}",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400))
                    ],
                  ))
                ],
              ),
              onTap: () {
                if (_state?.plan == null) {
                  NotificationService.errorSheet(
                      context, "No Plan Has Been Purchased");
                  return;
                }

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ProfilePreview()));
              },
            ),
          ),
          Padding(padding: EdgeInsets.only(right: 10)),
          Icon(
            Icons.arrow_right,
            color: AVColors.primary,
          )
        ],
      ),
    );
  }
}

paywithseerbit() {}

PayloadModel payload = PayloadModel(
    currency: 'NGN',
    email: "hello@gmail.com",
    description: "Health Plans",
    fullName: "General Zod",
    country: "NG",
    amount: "50000",
    transRef: Random().nextInt(5000200).toString(),
    callbackUrl: "callbackUrl",
    publicKey: "SBTESTPUBK_N0y7tPQ3UzN8mJq47KchHINyQBjTwJBi",
    pocketRef: "",
    vendorId: "Avon",
    closeOnSuccess: false,
    closePrompt: false,
    setAmountByCustomer: false,
    customization: CustomizationModel(
      borderColor: "#000000",
      backgroundColor: "#004C64",
      buttonColor: "#0084A0",
      paymentMethod: [PayChannel.account, PayChannel.transfer],
      confetti: false,
      logo: "logo_url || base64",
    ));

paysuccess() {
  print("success");
}

payfail() {
  print("fail");
}
