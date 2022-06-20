import 'dart:convert';
import 'dart:io';
import 'package:avon/screens/auth/login.dart';
import 'package:avon/screens/explore/explore.dart';
import 'package:avon/screens/webviews/static-html.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/utils/services/notifications.dart';
import 'package:avon/utils/services/validation-service.dart';
import 'package:http/http.dart' as http;
import 'package:avon/widgets/auth/simple-header.dart';
import 'package:avon/widgets/forms/checkbox_input.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool passwordVisibility = true;
  bool isLoading = false;
  bool isLoadingGoogle = false;
  bool agreement = false;

  final _formKey = new GlobalKey<FormState>();

  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
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

    // _firstNameController.text = "Idowu";
    // _lastNameController.text = "Aladesiun";
    // _emailController.text = "ahighdee3@gmail.com";
    // _phoneController.text = "0706371691329";
    // _passwordController.text = "Aladesiun11@";
  }

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
        showAppBar: true,
        title: '',
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                (kToolbarHeight + MediaQuery.of(context).padding.top)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 0)),
                      SimpleAuthHeader(
                          header: "Create Account",
                          body: "Let's create a profile for you"
                      ),
                      _buildBody(),
                    ],
                  ),
                  _buildFooter()
                ]
            ),
          ),
        )
    );
  }

  Widget _buildBody(){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 40)),
          AVInputField(
            label: "First Name",
            labelText: "Opeyemi",
            controller: _firstNameController,
            validator: (String? v) => ValidationService.isValidString(v!, minLength: 2),
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          AVInputField(
            label: "Last Name",
            labelText: "Olatogun",
            controller: _lastNameController,
            validator: (String? v) => ValidationService.isValidString(v!, minLength: 2),
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          AVInputField(
            label: "Email Address",
            labelText: "OpeyemiOlatogun@testcompany.com",
            controller: _emailController,
            validator: (String? v) => ValidationService.isValidEmail(v!),
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          AVInputField(
            label: "Mobile Number",
            labelText: "09024155251",
            controller: _phoneController,
            validator: (String? v) => ValidationService.isValidPhoneNumber(v!),
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          _buildPassword()
        ],
      ),
    );
  }

  Widget _buildPassword(){
    return AVInputField(
      label: "Password",
      labelText: "**********",
      obscureText: passwordVisibility,
      controller: _passwordController,
      validator: (String? v) => ValidationService.isValidPassword(v!),
      icon: Icon(
        !passwordVisibility ? Icons.visibility: Icons.visibility_off,
        color:  !passwordVisibility ? AVColors.primary : AVColors.gray1,
      ),
      suffixCallBack: (){
        setState(() {
          passwordVisibility =!passwordVisibility;
        });
      },
    );
  }

  Widget _buildFooter(){
    final style = TextStyle(color: AVColors.primary, fontSize: 14);
    final style2 = TextStyle(color: Colors.black, fontSize: 14);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(padding: EdgeInsets.only(top: 50)),
        AVCheckBoxInput(
            value: agreement,
            onChanged:(bool? v){
              setState(() {
                agreement = v ?? false;
              });
            },
            label: Row(
                children: [
                  Text("I agree to", style: style2),
                  // Text("I agrees to Avon HMO", style: style2),
                  GestureDetector(
                      child: Text(" Terms ", style: style),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>  StaticHtmlScreen(
                            title: "Terms & Conditions",
                            path: "https://www.avonhealthcare.com/understanding-insurance/terms/",
                            isWeb:true
                        )));
                      },
                  ),
                  Text("and", style: style2),
                  GestureDetector(
                      child: Text(" Privacy policy ", style: style),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>  StaticHtmlScreen(
                            title: "Privacy & Policy",
                            path: "https://www.avonhealthcare.com/understanding-insurance/privacy-policy/",
                            isWeb:true
                        )));
                      },
                  ),
                ]
            )
        ),
        Padding(padding: EdgeInsets.only(top: 20)),
        Container(
          width: MediaQuery.of(context).size.width,
          child: AVTextButton(
            radius: 5,
            child: Text('Continue', style: TextStyle(color: Colors.white)),
            verticalPadding: 17,
            showLoader: isLoading,
            disabled: isLoading || !agreement,
            callBack: submit,
          ),
        ),
        if(Platform.isAndroid)
        Container(
          padding: EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: AVTextButton(
            radius: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/google-icon.png", width: 25),
                Padding(padding: EdgeInsets.only(right: 20)),
                Text('Signup with Google',
                    style: TextStyle(color: AVColors.primary))
              ],
            ),
            // verticalPadding: 12,
            showLoader: isLoadingGoogle,
            callBack: _handleSignIn,
            color: Colors.white,
            borderColor: AVColors.primary,
            loaderColor: AVColors.primary,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 30)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an Account? "),
            GestureDetector(
              child: Text("Login", style: TextStyle(
                  color: AVColors.primary
              )),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=> LoginScreen()));
              },
            )
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 30)),
        GestureDetector(
            child: Text("Explore the world of AVON HMO.",
                style: TextStyle(
                    color: AVColors.primary,
                    fontWeight: FontWeight.w600,
                    decorationThickness: 1,
                    decorationColor: AVColors.primary,
                    decoration: TextDecoration.underline
                )
            ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> ExploreScreen()));
          },
        ),
        Padding(padding: EdgeInsets.only(bottom: 30)),
      ],
    );
  }

  Future<void> _handleSignIn() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      signupWithGoogle(account);
    } catch (error) {
      print(error);
    }
  }

  void submit()async {
        if(isLoading) return;
        if(!_formKey.currentState!.validate()) return;
        setState(() { isLoading = true; });

        Map payload = {
          "email":_emailController.text,
          "firstname":_firstNameController.text,
          "lastname":_lastNameController.text,
          "mobilePhone":_phoneController.text,
          "password":_passwordController.text,
        };

        http.Response response = await HttpServices.post(context, 'accounts', payload);
        // print(response.body);

        if(response.statusCode == 200){
          Map data = jsonDecode(response.body);
          if(data['hasError'] == false){
            // GeneralS
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=> LoginScreen()));
            NotificationService.successSheet(context, data['message']);
          }
        }

        setState(() { isLoading = false; });
      }

  void signupWithGoogle(GoogleSignInAccount? account)async {
    if(isLoadingGoogle) return;

    setState(() { isLoadingGoogle = true; });

    Map payload = {
      "userName": account?.displayName,
      "firstName": account?.displayName?.split(' ')[0],
      "lastName": account?.displayName?.split(' ')[1],
      "email": account?.email,
      "mobilePhone": account?.id,
      "password": account?.id,
      "companyId": "",
      "client_preferences": [
        {
          "prefType": "",
          "prefValue": ""
        }
      ],
      "userType": ""
    };

    http.Response response = await HttpServices.post(context, 'accounts/google', payload);
    print(response.body);

    if(response.statusCode == 200){
      Map data = jsonDecode(response.body);
      if(data['hasError'] == false){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=> LoginScreen()));
        NotificationService.successSheet(context, data['message']);
      }
    }

    setState(() { isLoadingGoogle = false; });
  }
}
