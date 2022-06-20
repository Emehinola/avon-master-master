import 'dart:convert';
import 'package:avon/screens/auth/reset-password.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/utils/services/notifications.dart';
import 'package:avon/utils/services/validation-service.dart';
import 'package:avon/widgets/auth/header.dart';
import 'package:http/http.dart' as http;
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool passwordVisibility = true;
  bool isLoading = false;
  final _formKey = new GlobalKey<FormState>();

  MainProvider? _state;
  TextEditingController _memberNoController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    GeneralService().removePref('user');

    _state = Provider.of<MainProvider>(context, listen: false);
    // _emailController.text = "highdee.ai@gmail.com";
  }


  @override
  Widget build(BuildContext context) {
    return AVScaffold(
        decoration: BoxDecoration(
            color: Colors.white
        ),
        child: Container(
          constraints: BoxConstraints(
              minHeight:  MediaQuery.of(context).size.height
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: kToolbarHeight + 30)),
                    AuthHeader(
                      header: "Forgot Password",
                      body: "we can help you reset your password",
                    ),
                    _buildBody(),
                  ],
                ),
                _buildFooter(),
              ]
          ),
        )
    );
  }


  void submit()async {
    FocusScope.of(context).unfocus();

    if(isLoading) return;
    if(!_formKey.currentState!.validate()) return;
    setState(() { isLoading = true; });

    Map payload = {
      "memberNo":_memberNoController.text,
    };

    http.Response response = await HttpServices.post(context, 'accounts/password/forgot', payload, useBase2: true);

    if(response.statusCode == 200){
      Map data = jsonDecode(response.body);

      if(data['hasError'] == false){

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=> ResetPasswordScreen(
          memberNo: _memberNoController.text,
        )));
        NotificationService.successSheet(context, data['message']);
      }
    }

    setState(() { isLoading = false; });
  }


  Widget _buildFooter(){
    final style = TextStyle(color: AVColors.primary);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(padding: EdgeInsets.only(top: 50)),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: AVTextButton(
            radius: 5,
            child: Text('SUBMIT', style: TextStyle(color: Colors.white)),
            verticalPadding: 17,
            callBack: submit,
            showLoader: isLoading,
            disabled: isLoading,
          ),
        ),
        Padding(padding: EdgeInsets.only(top:10)),
        Padding(padding: EdgeInsets.only(bottom: 20)),
      ],
    );
  }

  Widget _buildBody(){
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 20)),
              AVInputField(
                label: "Member Number",
                labelText: "123456",
                controller: _memberNoController,
                validator: (String? v) => ValidationService.isValidNumber(v!, minLength: 3),
              ),
              Padding(padding: EdgeInsets.only(top: 5)),
            ],
          ),
        )
    );
  }

}
