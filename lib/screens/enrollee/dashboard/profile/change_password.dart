import 'dart:convert';

import 'package:avon/screens/enrollee/dashboard.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/utils/services/notifications.dart';
import 'package:avon/utils/services/validation-service.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String? oldPassword;
  final bool fromAuth;
  const ChangePasswordScreen({Key? key, this.oldPassword, this.fromAuth = false}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool oldPasswordVisibility = false;
  bool newPasswordVisibility = false;
  bool confirmPasswordVisibility = false;
  bool isLoading = false;
  MainProvider? _state;

  final _formkey = GlobalKey<FormState>();
  TextEditingController _oldPasswordController = new TextEditingController();
  TextEditingController _newPasswordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _oldPasswordController.text = widget.oldPassword ?? '';
    // _newPasswordController.text = "aladesiun11";
    // _confirmPasswordController.text = "aladesiun11";
  }


  @override
  Widget build(BuildContext context) {
    _state = Provider.of<MainProvider>(context);

    return AVScaffold(
        showAppBar: true,
        title: "Change password",
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
                    Padding(padding: EdgeInsets.only(top: 5)),
                    _buildPassword(
                      title: "Old Password",
                      controller: _oldPasswordController,
                      visible: oldPasswordVisibility,
                      shouldValidate: false,
                      onTap: (){
                        setState(() {
                          oldPasswordVisibility = !oldPasswordVisibility;
                        });
                      }
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
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
                    Padding(padding: EdgeInsets.only(top: 5)),
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
                    child: Text('Change Password', style: TextStyle(color: Colors.white)),
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
    bool shouldValidate = true,
    TextEditingController? controller,
    Function ? onTap
  }){
    return AVInputField(
      label: "${title}",
      labelText: "**********",
      obscureText: !visible,
      controller: controller,
      validator: (String? v) => shouldValidate?  ValidationService.isValidPassword(v!):null,
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
    setState(() { isLoading = true; });

    print("changing passwor");
    Map payload = {
      "userId": "${_state?.user.userId}",
      "oldPassword": _oldPasswordController.text,
      "newPassword": _newPasswordController.text,
      "confirmPassword": _confirmPasswordController.text
    };

    http.Response response = await HttpServices.post(context, 'profile/password/change', payload);


    if(response.statusCode == 200){
      Map data = jsonDecode(response.body);
      if(data['hasError'] == false){
        if(widget.fromAuth){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      EnrolleeDashboardScreen(),
                  settings: RouteSettings(name: "dashboard"))
          );
        }else{
          Navigator.pop(context);
        }
        NotificationService.successSheet(context, data['message']);
      }
    }

    setState(() { isLoading = false; });
  }
}
