import 'dart:convert';

import 'package:avon/screens/webviews/zendesk_chat.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/constants/zen_desk.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/utils/services/storage.dart';
import 'package:avon/utils/services/validation-service.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zendesk_plugin/zendesk_plugin.dart';

class ChatWithUsScreen extends StatefulWidget {
  const ChatWithUsScreen({Key? key}) : super(key: key);

  @override
  _ChatWithUsScreenState createState() => _ChatWithUsScreenState();
}

class _ChatWithUsScreenState extends State<ChatWithUsScreen> {

  bool isLoading= false;

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initialiseChat();
  }

  initialiseChat()async {
    await Zendesk.initialize(ZenDeskAccountKey, ZenDeskAppID);
    MainProvider state = Provider.of<MainProvider>(context, listen: false);
    String? data = await GeneralService().getStringPref("guest");

    if(data != null){
      Map guest = jsonDecode(data);
      _emailController.text = guest['email'];
      _nameController.text = guest['name'];
      _phoneNumberController.text = guest['phone'];
    }else if(state.isLoggedIn){
       _emailController.text = state.user.email;
       _nameController.text = state.user.firstName;
       _phoneNumberController.text = AvonData().avonData.get('phoneNumber');
       // _phoneNumberController.text = state.user.mobilePhone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
        showAppBar: true,
        title: "Chat with us",
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - (
              MediaQuery.of(context).padding.top + kToolbarHeight
            )
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AVInputField(
                    label: "First Name",
                    labelText: "Ayomide ",
                    controller: _nameController,
                    validator: (String? v) => ValidationService.isValidInput(v!, minLength: 2),
                  ),
                  AVInputField(
                    label: "Phone Number",
                    labelText: "08043*******",
                    controller: _phoneNumberController,
                    validator: (String? v) => ValidationService.isValidPhoneNumber(v!),
                    inputType: TextInputType.number,
                  ),
                  AVInputField(
                    label: "Email",
                    labelText: "Ayomide@gmail.com",
                    controller: _emailController,
                    validator: (String? v) => ValidationService.isValidEmail(v!),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: AVTextButton(
                          radius: 5,
                          child: Text('Submit', style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                          )),
                          verticalPadding: 17,
                          disabled: isLoading,
                          showLoader: isLoading,
                          callBack: submit
                      )
                  )
                ],
              ),
            ),
          )
        )
    );
  }


  void submit()async {
    if (!_formKey.currentState!.validate()) return;

    // MainProvider state = Provider.of<MainProvider>(context, listen: false);

    //  await Zendesk.setVisitorInfo(
    //   name: _nameController.text,
    //   email: _emailController.text,
    //   phoneNumber: _phoneNumberController.text,
    //   department: 'Support',
    // );



    // Navigator.pop(context);
    // await Zendesk.startChat(primaryColor: AVColors.primary);

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context)=> ZendeskChatScreen()));
    // setState(() {isLoading = false;});
  }
}
