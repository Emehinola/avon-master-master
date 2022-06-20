import 'dart:convert';

import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/utils/services/notifications.dart';
import 'package:avon/utils/services/validation-service.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String memberNo;
  const ResetPasswordScreen({Key? key, required this.memberNo}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  bool newPasswordVisibility = false;
  bool confirmPasswordVisibility = false;
  bool isLoading = false;
  MainProvider? _state;

  final _formkey = GlobalKey<FormState>();
  TextEditingController _tokenController = new TextEditingController();
  TextEditingController _newPasswordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _tokenController.text = "aladesiun11";
    // _newPasswordController.text = "aladesiun11";
    // _confirmPasswordController.text = "aladesiun11";
  }


  @override
  Widget build(BuildContext context) {
    _state = Provider.of<MainProvider>(context);

    return AVScaffold(
        showAppBar: true,
        title: "Reset password",
        decoration: BoxDecoration(
            color: Colors.white
        ),
        horizontalPadding: 20,
        child: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - (kToolbarHeight + MediaQuery.of(context).padding.top)
          ),
          height: double.negativeInfinity,
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top:20)),
                    AVInputField(
                      label: "Reset Token",
                      labelText: "",
                      controller: _tokenController,
                      validator: (String? v) => ValidationService.isValidNumber(v!),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    _buildPassword(
                      title: "New Password",
                      controller: _newPasswordController,
                      visible: newPasswordVisibility,
                      onTap: (){
                        setState(() {
                          newPasswordVisibility = !newPasswordVisibility;
                        });
                      }
                    ),
                    Padding(padding: EdgeInsets.only(top: 15)),
                    _buildPassword(
                      title: "Confirm Password",
                      controller: _confirmPasswordController,
                      visible: confirmPasswordVisibility,
                        onTap: (){
                          setState(() {
                            confirmPasswordVisibility = !confirmPasswordVisibility;
                          });
                        }
                    )
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: AVTextButton(
                    radius: 5,
                    child: Text('Reset Password', style: TextStyle(color: Colors.white)),
                    verticalPadding: 17,
                    showLoader: isLoading,
                    disabled: isLoading ,
                    callBack: submit,
                  ),
                  padding: EdgeInsets.only(bottom: 40),
                ),
              ],
            ),
          ),
        )
    );
  }

  Widget _buildPassword({
    String? title,
    bool visible = false,
    TextEditingController? controller,
    Function ? onTap
  }){
    return AVInputField(
      label: "${title}",
      labelText: "**********",
      obscureText: !visible,
      controller: controller,
      validator: (String? v) => ValidationService.isValidPassword(v!),
      icon: Icon(
        visible ? Icons.visibility: Icons.visibility_off,
        color: visible? AVColors.primary : AVColors.gray1,
      ),
      suffixCallBack: (){
        if(onTap != null) {
          onTap();
        }
      },
    );
  }

  void submit()async {
    if(isLoading) return;

    if(!_formkey.currentState!.validate()) return;
    if(_newPasswordController.text != _confirmPasswordController.text){
      NotificationService.errorSheet(context, "Password Doesn't match");
      return;
    }
    setState(() { isLoading = true; });


    Map payload = {
      "memberNo": widget.memberNo,
      "token": _tokenController.text,
      "password": _newPasswordController.text,
    };

    http.Response response = await HttpServices.post(context, 'accounts/password/reset', payload);


    if(response.statusCode == 200){
      Map data = jsonDecode(response.body);
      print("object: $data");
      if(data['hasError'] == false){
        Navigator.pop(context);
        NotificationService.successSheet(context, data['message']);
      }
    }

    setState(() { isLoading = false; });
  }
}
