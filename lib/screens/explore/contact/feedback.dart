import 'dart:convert';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/utils/services/notifications.dart';
import 'package:avon/utils/services/validation-service.dart';
import 'package:http/http.dart' as http;
import 'package:avon/widgets/forms/dropdown_input.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FeedbackScreen extends StatefulWidget {
  String? title;
  FeedbackScreen({
    Key? key,
    this.title
  }) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
 

  bool isLoading = false;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _subjectController = new TextEditingController();
  TextEditingController _messageController = new TextEditingController();

  final _formKey = new GlobalKey<FormState>();
  MainProvider? state;

  @override
  void initState() {
    super.initState();

    state = Provider.of<MainProvider>(context, listen: false);
    if(state!.isLoggedIn){
      _emailController.text = state!.user.email;
      _nameController.text = "${state!.user.firstName} ${state!.user.lastName}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
      title: widget.title ?? "Feedback",
      showAppBar: true,
      decoration: BoxDecoration(color: Colors.white),
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 10),
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).padding.top + kToolbarHeight)),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 5,
              ),
              AVInputField(
                label: "Subject",
                labelText: "Subject",
                controller: _subjectController,
                validator: (String? v) =>
                    ValidationService.isValidInput(v!, minLength: 4),
              ),
              SizedBox(
                height: 5,
              ),
              AVInputField(
                label: "Name",
                labelText: "Ayomide Oladele",
                controller: _nameController,
                validator: (String? v) =>
                    ValidationService.isValidString(v!, minLength: 2),
              ),
              SizedBox(
                height: 5,
              ),
              AVInputField(
                label: "Email",
                labelText: "Ayomide@gmail.com",
                controller: _emailController,
                validator: (String? v) => ValidationService.isValidEmail(v!),
              ),
              SizedBox(
                height: 5,
              ),
              AVInputField(
                label: "Message",
                labelText: "",
                controller: _messageController,
                validator: (String? v) =>
                    ValidationService.isValidInput(v!, minLength: 10),
                maxLines: 10,
                minLines: 5,
                height: 150,
                inputType: TextInputType.multiline,
                inputAction: TextInputAction.newline,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: AVTextButton(
                      radius: 5,
                      child: Text('Submit',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      verticalPadding: 17,
                      disabled: isLoading,
                      showLoader: isLoading,
                      callBack: submit))
            ],
          ),
        ),
      ),
    );
  }

  void submit() async {
    FocusScope.of(context).unfocus();

    if (isLoading) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    MainProvider state = Provider.of<MainProvider>(context, listen: false);

    Map payload = {};
    String endpoint = "";

    endpoint = "feedback";
    payload = {
      "subject": _subjectController.text,
      "email": _emailController.text,
      "name": _nameController.text,
      "message": _messageController.text
    };

    http.Response response =
        await HttpServices.post(context, endpoint, payload);
    // print(response.body);

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      if (data['hasError'] == false) {
        Navigator.pop(context);
        NotificationService.successSheet(context, data['message']);
      }
    }

    setState(() {
      isLoading = false;
    });
  }
}
