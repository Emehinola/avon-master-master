import 'dart:convert';

import 'package:avon/models/hospital.dart';
import 'package:avon/screens/enrollee/hospital/hospital_list.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/utils/services/validation-service.dart';
import 'package:avon/widgets/alert_dialog.dart';
import 'package:avon/widgets/forms/dropdown_input.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class GiveRecommendationScreen extends StatefulWidget {
  const GiveRecommendationScreen({Key? key}) : super(key: key);

  @override
  _GiveRecommendationScreenState createState() =>
      _GiveRecommendationScreenState();
}

class _GiveRecommendationScreenState extends State<GiveRecommendationScreen> {
  String? beneficiary;
  Hospital? hospital;
  TextEditingController _hospitalController = new TextEditingController();
  TextEditingController _otherNameController = new TextEditingController();

  List options = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController _recController = new TextEditingController();

  bool isLoading = false;

  Map<String, String> recommendationList = {
    "Call Center": "Call Center",
    "Client Manager": "Client Manager",
    "Hospital": "Hospital"
  };

  String? selectedRecommendation;
  bool isHospital = false;

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
        title: "Give A Recommendation",
        showAppBar: true,
        decoration: BoxDecoration(color: Colors.white),
        child: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  kToolbarHeight),
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    AVDropdown(
                      label: "Who are you recommending?",
                      options: recommendationList.keys.toList(),
                      value: selectedRecommendation,
                      onChanged: (dynamic v) {
                        setState(() {
                          selectedRecommendation = v;
                          isHospital = v == 'Hospital';
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    Visibility(
                      visible: isHospital,
                      child: GestureDetector(
                        child: AVInputField(
                          controller: _hospitalController,
                          label: "Hospital's Name",
                          disabled: true,
                        ),
                        onTap: selectHospital,
                      ),
                      replacement: AVInputField(
                        controller: _otherNameController,
                        label: recommendationList[selectedRecommendation] ==
                                "Call Center"
                            ? "Agent's Name"
                            : "Manager's Name",
                        disabled: false,
                      ),
                    ),
                    SizedBox(height: 15),
                    AVInputField(
                      label: "Enter Recommendation",
                      labelText: "Type here....",
                      controller: _recController,
                      validator: (String? v) =>
                          ValidationService.isValidInput(v!, minLength: 5),
                      height: 150,
                      minLines: 6,
                      maxLines: 10,
                      inputType: TextInputType.multiline,
                      inputAction: TextInputAction.newline,
                    )
                  ],
                ),
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
                    child: Text("Submit",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    disabled: isLoading,
                    showLoader: isLoading,
                    verticalPadding: 17,
                    callBack: _submit),
              ),
            )
          ]),
        ));
  }

  void selectHospital() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => HospitalListScreen(
                  isDropSelect: true,
                ))).then((value) {
      if (value != null) {
        setState(() {
          hospital = value;
          _hospitalController.text = hospital?.name ?? '';
        });
      }
    });
  }

  _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    MainProvider state = Provider.of<MainProvider>(context, listen: false);
    Map payload = {
      "beneficairyId": "",
      "recommendation": _recController.text,
      "recommendationCategory": _recController.text.toString(),
      "beneficairyName": _hospitalController.text.toString(),
      "memberNo": state.user.memberNo
    };
    Map secondPayload = {
      "beneficairyId": hospital?.code.toString(),
      "recommendation": _recController.text,
      "RecommendationCategory": _recController.text.toString(),
      "beneficairyName": _otherNameController.text.toString(),
      "memberNo": state.user.memberNo
    };

    http.Response response = await HttpServices.post(
        context,
        'enrollee-post-recommendation-new',
        _otherNameController.text.isEmpty ? payload : secondPayload);
    // print(response.body);

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      if (data['hasError'] == false) {
        Navigator.pop(context);

        showAlertDialog(
            context: context,
            type: AlertType.SUCCESS,
            header: "Recommendation Submitted!",
            body: "${data['message']}",
            onContinue: () {});
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  getBeneficiary() {}
}
