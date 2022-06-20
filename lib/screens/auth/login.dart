import 'dart:convert';
import 'dart:io';
import 'package:avon/models/enrollee.dart';
import 'package:avon/models/enrollee_plan.dart';
import 'package:avon/screens/auth/create_account.dart';
import 'package:avon/screens/auth/forgot-password.dart';
import 'package:avon/screens/enrollee/dashboard.dart';
import 'package:avon/screens/enrollee/dashboard/profile/change_password.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/constants/image_assets.dart';
import 'package:avon/utils/services/enrollee-services.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/utils/services/notifications.dart';
import 'package:avon/utils/services/validation-service.dart';
import 'package:avon/widgets/auth/header.dart';
import 'package:avon/widgets/forms/checkbox_input.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisibility = true;
  bool isLoading = false;
  bool isLoadingGoogle = false;
  bool rememberMe = false;
  final _formKey = new GlobalKey<FormState>();

  MainProvider? _state;
  TextEditingController _userIdController =
      new TextEditingController(); // userId: memberNo
  TextEditingController _passwordController = new TextEditingController();

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // GeneralService().removePref('user');
    _state = Provider.of<MainProvider>(context, listen: false);

    // _emailController.text = "highdee.ai@gmail.com";
    // _passwordController.text = "Aladesiun11@";
    _prePopulate();
  }

  _prePopulate() async {
    // String? email = await GeneralService().getStringPref('email_address');
    String? userId = await GeneralService().getStringPref('userId');
    String? password = await GeneralService().getStringPref('password');
    if (userId != null) _userIdController.text = userId;
    if (password != null) _passwordController.text = password;
  }

  @override
  Widget build(BuildContext context) {
    MainProvider state = Provider.of<MainProvider>(context, listen: false);

    return AVScaffold(
        decoration: BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - kToolbarHeight),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 30, left: 20),
                        child: Align(
                          child: Image.asset(AVImages.avonHmoPurpleLogo,
                              scale: MediaQuery.of(context).size.width * 0.07),
                          alignment: Alignment.center,
                        ),
                      ),
                      SizedBox(height: 20),
                      AuthHeader(
                        header: "Welcome back",
                        body: "Let's get you back in",
                      ),
                      _buildBody(),
                    ],
                  ),
                  _buildFooter(),
                ]),
          ),
        ));
  }

  void submit() async {
    FocusScope.of(context).unfocus();

    if (isLoading) return;
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    });

    Map payload = {
      "userName": _userIdController.text,
      "password": _passwordController.text,
    };

    try {
      http.Response response = await HttpServices.post(
          context, 'auth/login', payload,
          useBase2: true);

      if (response.statusCode == 200) {
        _state?.reset(); // clears cart added anonymously
        GeneralService().setStringPref('userId', _userIdController.text);
        GeneralService().setStringPref('password', _passwordController.text);

        Map data = jsonDecode(response.body);
        print("user: ${response.body}");
        if (!data['hasError']) {
          await _completeLogin(data);
          _navigateToDashboard();
        }
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  _navigateToDashboard() {
    if (_state?.user.requiredPasswordChange ?? false) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  ChangePasswordScreen(fromAuth: true)));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => EnrolleeDashboardScreen(),
              settings: RouteSettings(name: "dashboard")));
    }
  }

  Future _completeLogin(Map data) async {
    Enrollee enrollee = new Enrollee.fromJson(data['data']);
    GeneralService().setUser(data['data']);
    _state?.user = enrollee;

    if (rememberMe) {
      GeneralService().setBoolPref('remember_me', true);
    }

    EnrolleePlan? _plan = await EnrolleeServices.getPlanDetails(
        context, "${_state?.user.memberNo}");
    if (_plan != null) {
      _state?.plan = _plan;
    }
  }

  Future<void> _handleSignIn() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      signupWithGoogle(account);
    } catch (error) {
      print(error);
      isLoading = false;
      setState(() {
        isLoadingGoogle = false;
      });
    }
  }

  void signupWithGoogle(GoogleSignInAccount? account) async {
    if (isLoadingGoogle) return;

    setState(() {
      isLoadingGoogle = true;
    });

    Map payload = {
      "email": account?.email,
      "id": account?.id,
    };

    http.Response response =
        await HttpServices.post(context, 'auth/google/login', payload);
    print(response.body);

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      if (data['hasError'] == false) {
        await _completeLogin(data);
        _navigateToDashboard();
      }
      setState(() {
        isLoadingGoogle = false;
      });
    } else {
      setState(() {
        isLoadingGoogle = false;
      });
    }
  }

  Widget _buildFooter() {
    final style = TextStyle(color: AVColors.primary);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(padding: EdgeInsets.only(top: 50)),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: AVTextButton(
            radius: 5,
            child: Text('Login', style: TextStyle(color: Colors.white)),
            // verticalPadding: 17,
            callBack: submit,
            showLoader: isLoading,
            disabled: isLoading,
          ),
        ),
        if (Platform.isAndroid)
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            height: 50,
            child: AVTextButton(
              radius: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/google-icon.png", width: 25),
                  Padding(padding: EdgeInsets.only(right: 20)),
                  Text('SignIn with Google',
                      style: TextStyle(color: AVColors.primary))
                ],
              ),
              // verticalPadding: 12,
              color: Colors.white,
              borderColor: AVColors.primary,
              showLoader: isLoadingGoogle,
              loaderColor: AVColors.primary,
              callBack: _handleSignIn,
            ),
          ),
        Padding(padding: EdgeInsets.only(top: 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an Account? ", style: TextStyle(fontSize: 15)),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(" Sign up ",
                    style: TextStyle(
                        color: AVColors.primary, fontWeight: FontWeight.w500)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            CreateAccountScreen()));
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 20)),
              AVInputField(
                label: "User ID",
                labelText: "123456",
                controller: _userIdController,
                inputType: TextInputType.number,
                validator: (String? v) =>
                    ValidationService.isValidNumber(v!, minLength: 1),
              ),
              Padding(padding: EdgeInsets.only(top: 5)),
              _buildPassword(),
              Padding(padding: EdgeInsets.only(top: 5)),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Text("Forgot password?",
                        style: TextStyle(
                            color: AVColors.primary,
                            fontWeight: FontWeight.w500)),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ForgotPasswordScreen()));
                  },
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  child: AVCheckBoxInput(
                    value: rememberMe,
                    label: Text("Remember me"),
                    onChanged: (bool? v) {
                      setState(() {
                        rememberMe = v!;
                      });
                    },
                  ),
                  width: 180,
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildPassword() {
    return AVInputField(
      label: "Password",
      labelText: "**********",
      obscureText: passwordVisibility,
      controller: _passwordController,
      icon: Icon(
        !passwordVisibility ? Icons.visibility : Icons.visibility_off,
        color: !passwordVisibility ? AVColors.primary : AVColors.gray1,
      ),
      suffixCallBack: () {
        setState(() {
          passwordVisibility = !passwordVisibility;
        });
      },
      validator: (String? v) => ValidationService.isValidInput(v!),
    );
  }
}
