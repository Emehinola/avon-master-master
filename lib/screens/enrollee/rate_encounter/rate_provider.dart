import 'dart:convert';

import 'package:avon/models/hospital.dart';
import 'package:avon/screens/enrollee/hospital/hospital_list.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/utils/services/notifications.dart';
import 'package:avon/utils/services/validation-service.dart';
import 'package:avon/widgets/alert_dialog.dart';
import 'package:avon/widgets/forms/dropdown_input.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class RateProviderScreen extends StatefulWidget {
  const RateProviderScreen({Key? key}) : super(key: key);

  @override
  _RateProviderScreenState createState() => _RateProviderScreenState();
}

class _RateProviderScreenState extends State<RateProviderScreen> {
  TextEditingController _controller = new TextEditingController();
  TextEditingController _hospitalController = new TextEditingController();

  String? _hospitalError;
  String? _errorText;
  bool isLoading = false;
  double rating = 0;
  Hospital? hospital;
  final _formKey = GlobalKey<FormState>();

  Map<String, int> performances = {
    "Very Good": 1,
    "Good": 2,
    "Fair": 3,
    "Poor": 4,
    "Very Poor": 5,
  };

  Map<String, int> accessDifficulties = {
    "Very dissatisfied": 1,
    "Somewhat dissatisfied": 2,
    "Indifferent": 3,
    "Somewhat satisfied": 4,
    "Very Satisfied": 5,
  };

  String? performance;
  String? accessDifficulty;

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
        title: "Rate Your Provider",
        showAppBar: true,
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(children: [
          Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).padding.top + kToolbarHeight)),
            height: double.negativeInfinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Text(
                      "Did you access medical care recently? How would you rate the service received from your healthcare provider?",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    )),
                    // const SizedBox(height: 30),
                    // Visibility(
                    //   visible: _hospitalController.text.isNotEmpty,
                    //   child: AVDropdown(
                    //     label: "How easy was it for you accessing care?",
                    //     options: performances.keys.toList(),
                    //     value: performance,
                    //     onChanged: (dynamic v) {
                    //       setState(() {
                    //         performance = v;
                    //       });
                    //     },
                    //   ),
                    // ),
                    const SizedBox(height: 30),
                    Visibility(
                      visible: _hospitalController.text.isNotEmpty,
                      child: AVDropdown(
                        label:
                            "How satisfied are you with your service experience at ${_hospitalController.text}",
                        options: accessDifficulties.keys.toList(),
                        value: accessDifficulty,
                        onChanged: (dynamic v) {
                          setState(() {
                            accessDifficulty = v;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      child: AVInputField(
                        label: "Select a provider",
                        labelText: "Select",
                        disabled: true,
                        icon: Icon(Icons.arrow_drop_down),
                        validator: (String? v) =>
                            ValidationService.isValidInput(v!, minLength: 5),
                        controller: _hospitalController,
                      ),
                      onTap: selectHospital,
                    ),
                    const SizedBox(height: 15),
                    RatingBar.builder(
                      itemCount: 10,
                      itemSize: 22,
                      onRatingUpdate: (double v) {
                        setState(() {
                          rating = v;
                        });
                      },
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                      unratedColor: Color(0xffEDF2F7),
                      itemBuilder: (context, index) => Icon(
                        Icons.star_border_outlined,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: SizedBox(
                        width: 350,
                        child: Text(
                          "Select a rating from 1-10",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    AVInputField(
                      label: "Additional comments (optional)",
                      labelText: "Type here",
                      height: 160,
                      minLines: 5,
                      maxLines: 6,
                      validator: (String? v) => null,
                      controller: _controller,
                      inputType: TextInputType.multiline,
                      inputAction: TextInputAction.newline,
                    )
                  ],
                ),
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
                  child: Text("Submit Rating",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  disabled: isLoading,
                  showLoader: isLoading,
                  verticalPadding: 17,
                  callBack: _submit),
            ),
          )
        ]));
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
          _hospitalController.text = hospital!.name!;
          _hospitalError = null;
        });
      }
    });
  }

  _submit() async {
    setState(() {
      _hospitalError = null;
    });

    if (!_formKey.currentState!.validate()) return; // not validate

    if (rating < 1) {
      NotificationService.errorSheet(
          context, "Please Rate your health care provider");
      return;
    }
    setState(() {
      isLoading = true;
    });

    try {
      Map payload = {
        "providerId": hospital?.code.toString(),
        "rating": rating,
        "review": _controller.text,
        // "performace": accessDifficulties[accessDifficulty]
      };
      http.Response response = await HttpServices.post(
          context, 'enrollee/actions/provider-rating', payload);

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        if (data['hasError'] == false) {
          Navigator.pop(context);

          showAlertDialog(
              context: context,
              type: AlertType.SUCCESS,
              header: "Thank You!",
              body: "${data['message']}",
              onContinue: () {});
        }
      }
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }
}
