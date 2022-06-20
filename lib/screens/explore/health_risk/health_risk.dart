import 'dart:convert';

import 'package:avon/models/enrollee.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/utils/services/notifications.dart';
import 'package:avon/utils/services/validation-service.dart';
import 'package:avon/widgets/alert_dialog.dart';
import 'package:avon/widgets/forms/dropdown_input.dart';
import 'package:http/http.dart' as http;
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HealthRiskScreen extends StatefulWidget {
  const HealthRiskScreen({Key? key}) : super(key: key);

  @override
  _HealthRiskScreenState createState() => _HealthRiskScreenState();
}

class _HealthRiskScreenState extends State<HealthRiskScreen> {
  bool isLoading = false;
  bool isLoaded = false;

  String? sex;
  String? frequency;
  String? doYouSmoke;

  TextEditingController _addressController = new TextEditingController();
  TextEditingController _ageController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();

  List<String> drinkingOptions = [
    "Daily",
    "Few times in a week",
    "Often",
    "Occasionally",
    "Not at all",
  ];

  final _formKey = GlobalKey<FormState>();
  List questions = [];
  Map answers = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _addressController.text = "No 4 , franklin oshoe";
    // _ageController.text = "20";
    // _nameController.text = "Idowu Aladesiun";

    //Populate the form
    MainProvider state = Provider.of<MainProvider>(context, listen: false);
    if (state.isLoggedIn) {
      Enrollee user = state.user;
      _nameController.text = user.fullName;
      _addressController.text = user.email;
      if (state.plan != null) {
        print("gender:>>> ${state.plan?.gender}");
        _ageController.text = state.plan?.age.toString() ?? '';
        sex = (state.plan?.gender ?? '') == 'MALE' ? "Male" : "Female";
      }
    }

    _getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
      title: "Health Risk Assessment",
      showAppBar: true,
      decoration: BoxDecoration(color: Colors.white),
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 10),
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).padding.top + kToolbarHeight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Answer the question below",
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w300, height: 1.2),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AVInputField(
                    label: "Full Name",
                    labelText: "Ayomide Oladele",
                    controller: _nameController,
                    validator: (String? v) =>
                        ValidationService.isValidString(v!, minLength: 2),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  AVInputField(
                    label: "Email Address",
                    labelText: "Ayomide@gmail.com",
                    controller: _addressController,
                    validator: (String? v) =>
                        ValidationService.isValidEmail(v!),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  AVInputField(
                    label: "Your age",
                    labelText: "23",
                    controller: _ageController,
                    validator: (String? v) =>
                        ValidationService.isValidNumber(v!),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  AVDropdown(
                    label: "Sex",
                    options: ["Male", "Female"],
                    value: sex,
                    onChanged: (dynamic v) {
                      setState(() {
                        sex = v;
                      });
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  AVDropdown(
                    label: "Drinking frequency",
                    options: drinkingOptions,
                    value: frequency,
                    onChanged: (dynamic v) {
                      setState(() {
                        frequency = v;
                      });
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  AVDropdown(
                    label: "Do you smoke?",
                    options: ["Yes", "No"],
                    value: doYouSmoke,
                    onChanged: (dynamic v) {
                      setState(() {
                        doYouSmoke = v;
                      });
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  ...questions
                      .map((e) => AVDropdown(
                            label: "${e['questionText']}",
                            options: ["Never", "Occasionally", "Always"],
                            value: answers[e['healthRiskAssessmentQuestionId']],
                            onChanged: (dynamic v) {
                              setState(() {
                                answers[e['healthRiskAssessmentQuestionId']] =
                                    v;
                              });
                            },
                          ))
                      .toList()
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 40),
                child: AVTextButton(
                  radius: 5,
                  child: Text('Submit',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  verticalPadding: 17,
                  callBack: submit,
                )),
          ],
        ),
      ),
    );
  }

  _getQuestions() async {
    setState(() {
      isLoading = true;
    });

    http.Response response =
        await HttpServices.get(context, "risk-assessment/questions");
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      questions = body['data'];
    }

    setState(() {
      isLoading = false;
    });
  }

  submit() async {
    if (isLoading) return;
    if (!_formKey.currentState!.validate()) return;
    if (sex == null ||
        frequency == null ||
        doYouSmoke == null ||
        answers.length < questions.length) {
      NotificationService.errorSheet(context, "Please fill all fields");
      return;
    }

    Map answersId = {"Never": "1", "Occasionally": "2", "Always": "3"};

    BuildContext? dialogContext;
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext _ctx) {
          dialogContext = _ctx;
          return AlertDialog(
              content: Container(
                child: Center(
                  child: onSubmitModal(),
                ),
                height: 200,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))));
        });

    setState(() {
      isLoading = true;
    });

    MainProvider state = Provider.of<MainProvider>(context, listen: false);

    try {
      Map payload = {
        "riskAssessmentRequestId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "age": _ageController.text,
        "sex": sex,
        "drinkingFrequency": frequency,
        "isSmoker": doYouSmoke == 'yes',
        "name": _nameController.text,
        "address": _addressController.text,
        "assessmentResult": [
          ...answers.entries
              .map((e) => {
                    "healthRiskAssessmentQuestionId": e.key,
                    //
                    "answerText":
                        e.value == 'Occasionally' ? "Ocassionally" : e.value
                  })
              .toList()
        ]
      };

      http.Response response =
          await HttpServices.post(context, 'explore/risk-assessment', payload);
      // print(response.body);

      Navigator.pop(dialogContext!);

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        if (data['hasError'] == false) {
          Navigator.pop(context);
          showAlertDialog(
              context: context,
              type: AlertType.SUCCESS,
              header: "Assessment ready",
              body: data['message'],
              onContinue: () {});
        }
      } else {
        throw ("error");
      }
    } catch (e) {
      Navigator.pop(context);
    }

    setState(() {
      isLoading = false;
    });
  }

  Widget onSubmitModal() => IntrinsicHeight(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator.adaptive(),
            SizedBox(
              height: 20,
            ),
            Text(
              "Please wait",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: 300,
                child: Text(
                    "We are currently calculating your health accessment...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                        height: 1.3))),
          ],
        ),
      );
}
