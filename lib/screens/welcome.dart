import 'dart:convert';
import 'package:avon/models/enrollee.dart';
import 'package:avon/models/enrollee_plan.dart';
import 'package:avon/screens/enrollee/dashboard.dart';
import 'package:avon/screens/plan/plan_list.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/services/enrollee-services.dart';
import 'package:avon/widgets/loader.dart';
import 'package:http/http.dart' as http;
import 'package:avon/screens/auth/create_account.dart';
import 'package:avon/screens/auth/login.dart';
import 'package:avon/screens/explore/explore.dart';
import 'package:avon/utils/constants/image_assets.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool willRefreshToken = true;
  MainProvider? _state;

  @override
  void initState() {
    print("hello");
    // TODO: implement initState
    super.initState();
    // GeneralService().removePref('user');
    _state = Provider.of<MainProvider>(context, listen: false);
    _refreshToken();
  }

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AVImages.welcomeBanner), fit: BoxFit.cover),
          color: Colors.black),
      addTopPadding: false,
      child: AnimatedCrossFade(
        firstChild: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Center(
                child: AVLoader(
                  color: AVColors.primary,
                ),
              )),
              Container(
                child: Image.asset(AVImages.avonHmoPurpleLogo,
                    scale: MediaQuery.of(context).size.width * 0.05),
                margin: EdgeInsets.only(bottom: kToolbarHeight),
              )
            ],
          ),
        ),
        secondChild: Stack(
          children: [
            if (willRefreshToken)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                ),
                width: MediaQuery.of(context).size.width,
                child: AVLoader(),
              ),
            Container(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              height: double.negativeInfinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Image.asset(AVImages.avonHmoWhiteLogo,
                          scale: MediaQuery.of(context).size.width * 0.04),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AVTextButton(
                            radius: 5,
                            child: Text('Sign Up',
                                style: TextStyle(color: Colors.white)),
                            verticalPadding: 17,
                            callBack: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          CreateAccountScreen()));
                            },
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          AVTextButton(
                              radius: 5,
                              color: Colors.transparent,
                              borderColor: Colors.white,
                              child: Text('Explore AVON',
                                  style: TextStyle(color: Colors.white)),
                              verticalPadding: 17,
                              callBack: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ExploreScreen()));
                              }),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          AVTextButton(
                            radius: 5,
                            color: Colors.transparent,
                            borderColor: Colors.white,
                            child: Text('Buy Plan',
                                style: TextStyle(color: Colors.white)),
                            verticalPadding: 17,
                            callBack: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PlanListScreen()));
                            },
                          ),
                          Padding(padding: EdgeInsets.only(top: 30)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an Account? ",
                                  style: TextStyle(color: Colors.white)),
                              GestureDetector(
                                child: Text("Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline)),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              LoginScreen()));
                                },
                              )
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top: 30)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        crossFadeState: willRefreshToken
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: Duration(milliseconds: 300),
      ),
    );
  }

  void _refreshToken() async {
    try {
      //Get rememberMe data
      bool rememberMe =
          await GeneralService().getBoolPref('remember_me') ?? false;

      //if null display login screen
      if (!rememberMe) {
        setState(() {
          willRefreshToken = false;
        });
        return;
      }

      //Get sharedpreference data
      String? data = await GeneralService().getStringPref('user');

      //if null display login screen
      if (data == null) {
        print("will not refresh token");
        setState(() {
          willRefreshToken = false;
        });
        return;
      }

      //else refresh the token
      Map _user = jsonDecode(data);
      // print(_user);
      http.Response response = await HttpServices.post(
          context,
          "auth/token/refresh",
          {
            "accessToken": _user['access_token'],
            "refreshToken": _user['refresh_token']
          },
          handleError: false);
      if (response.statusCode != 200) {
        setState(() {
          willRefreshToken = false;
        });
        return;
      }

      Map body = jsonDecode(response.body);

      if (body['hasError']) {
        setState(() {
          willRefreshToken = false;
        });
        return;
      }

      //Reset token into shared preference
      _user['access_token'] = body['data']['access_token']['result'];
      _user['refresh_token'] = body['data']['refreshToken'];
      Enrollee enrollee = new Enrollee.fromJson(_user);
      _state?.user = enrollee;
      GeneralService().setUser(_user);

      //Get enrollee plans
      EnrolleePlan? _plan = await EnrolleeServices.getPlanDetails(
          context, "${_user['memberNo']}"); // memberNo instead of email

      // print(_plan);
      if (_plan != null) {
        _state?.plan = _plan;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => EnrolleeDashboardScreen(),
                settings: RouteSettings(name: "dashboard")));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => EnrolleeDashboardScreen(),
                settings: RouteSettings(name: "dashboard")));
      }
    } catch (e) {
      setState(() {
        willRefreshToken = false;
      });
    }
  }
}
