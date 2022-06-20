import 'dart:convert';
import 'package:avon/utils/services/validation-service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/utils/services/notifications.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:avon/widgets/loader.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class InviteFriendScreen extends StatefulWidget {
  const InviteFriendScreen({Key? key}) : super(key: key);

  @override
  _InviteFriendScreenState createState() => _InviteFriendScreenState();
}

class _InviteFriendScreenState extends State<InviteFriendScreen> {
  bool isLoading = false;
  bool isSaving = false;
  String link = '';
  String? _phoneError;
  String? code;
  String? url;
  TextEditingController _phoneController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLink();
  }

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
      title: "Invite A Friend",
      showAppBar: true,
      decoration: BoxDecoration(color: Colors.white),
      child: Container(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).padding.top + kToolbarHeight)),
        child: Visibility(
          visible: !isLoading,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AVInputField(
                        label: "Phone number",
                        labelText: "(219) 555-0114",
                        controller: _phoneController,
                        inputType: TextInputType.phone,
                        validator: (String? v) =>
                            ValidationService.isValidInput(v!),
                      ),
                      Container(
                        width: 180,
                        margin: EdgeInsets.only(top: 30),
                        child: AVTextButton(
                            radius: 30,
                            child: Text("Share invite link", // others
                                style: TextStyle(
                                    color: Color(0xff631293), fontSize: 16)),
                            verticalPadding: 17,
                            color: Colors.white,
                            borderColor: Color(0xff631293),
                            callBack: shareLink),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 15,
                  left: 15,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 10),
                    child: AVTextButton(
                        radius: 5,
                        child: Text("Send invite", // phone
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        verticalPadding: 17,
                        disabled: isSaving,
                        showLoader: isSaving,
                        callBack: _submit),
                  ),
                )
              ],
            ),
          ),
          replacement: AVLoader(
            color: AVColors.primary,
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (isSaving) return;

    setState(() {
      isSaving = true;
    });

    MainProvider state = Provider.of<MainProvider>(context, listen: false);

    Map payload = {
      "enrolleeId": "${state.user.enrolleeId}",
      "referralCode": code,
      "friendPhone": _phoneController.text,
      "referralLink": link
    };

    http.Response response =
        await HttpServices.post(context, 'referral', payload);
    print(response.body);

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      if (data['hasError'] == false) {
        Navigator.pop(context, true);
        NotificationService.successSheet(context, data['message']);
      }
    }

    setState(() {
      isSaving = false;
    });
  }

  void getLink() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });

    MainProvider state = Provider.of<MainProvider>(context, listen: false);
    http.Response response = await HttpServices.get(
        context, "referral/${state.user.enrolleeId}/code");
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body)['data'];

      setState(() {
        code = data['referralCode'];
        link = data['referralLink'];
        link = "${data['referralLink']}${data['referralCode']}";
      });
      print("referral: ${data['referralLink']}");
      if (data['hasError'] == true) {
        Navigator.pop(context);
        NotificationService.errorSheet(
            context, "Unable to get a shareable link");
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  void shareLink() {
    Share.share('${link}', subject: 'Hi friend, checkout avon app');
  }
}
