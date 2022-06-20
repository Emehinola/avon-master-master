import 'dart:convert';
import 'package:avon/models/enrollee.dart';
import 'package:avon/models/plan.dart';
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
import 'package:provider/provider.dart';

class RequestQuoteScreen extends StatefulWidget {
  Plan plan;
  String? planTypeName;

  RequestQuoteScreen({Key? key, required this.plan, this.planTypeName})
      : super(key: key);

  @override
  _RequestQuoteScreenState createState() => _RequestQuoteScreenState();
}

class _RequestQuoteScreenState extends State<RequestQuoteScreen> {
  bool isLoading = false;

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _roleController = new TextEditingController();
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _companyNameController = new TextEditingController();
  TextEditingController _PlanCategoryController = new TextEditingController();

  List<Map<String, dynamic>> categories = [];
  final _formKey = new GlobalKey<FormState>();
  String? category;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    MainProvider state = Provider.of<MainProvider>(context, listen: false);
    if (state.isLoggedIn) {
      Enrollee user = state.user;
      _firstNameController.text = user.firstName;
      _lastNameController.text = user.lastName;
      _emailController.text = user.email;
      _phoneNumberController.text = user.mobilePhone;
      _PlanCategoryController.text = widget.plan.planTypeName;
    } else {
      _PlanCategoryController.text = widget.planTypeName.toString();
    }

    _getSubPlans();
  }

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
      title: "Request A Quote",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Please complete the form below",
                style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w300, height: 1.2),
              ),

              SizedBox(
                height: 20,
              ),
              AVInputField(
                label: "Surname",
                labelText: "Ayomide ",
                controller: _lastNameController,
                validator: (String? v) =>
                    ValidationService.isValidString(v!, minLength: 2),
              ),
              SizedBox(
                height: 10,
              ),
              AVInputField(
                label: "First Name",
                labelText: "Ayomide ",
                controller: _firstNameController,
                validator: (String? v) =>
                    ValidationService.isValidString(v!, minLength: 2),
              ),
              SizedBox(height: 10),
              AVInputField(
                  label: "Phone Number",
                  labelText: "08034234****",
                  controller: _phoneNumberController,
                  validator: (String? v) =>
                      ValidationService.isValidPhoneNumber(v!)),
              SizedBox(height: 10),
              AVInputField(
                  label: "Email",
                  labelText: "Ayomide@gmail.com",
                  controller: _emailController,
                  validator: (String? v) => ValidationService.isValidEmail(v!)),
              SizedBox(height: 10),
              Visibility(
                child: AVInputField(
                    label: "Company Name",
                    labelText: "Company Name",
                    controller: _companyNameController,
                    validator: (String? v) =>
                        ValidationService.isValidInput(v!, minLength: 2)),
              ),
              SizedBox(height: 10),
              AVInputField(
                label: "Role in Company",
                labelText: "Enter Role",
                controller: _roleController,
                validator: (String? v) =>
                    ValidationService.isValidInput(v!, minLength: 2),
              ),
              SizedBox(height: 10),
              AVInputField(
                label: "Company Address",
                labelText: "NO 32, oladele street",
                controller: _addressController,
                validator: (String? v) =>
                    ValidationService.isValidInput(v!, minLength: 10),
              ),
              SizedBox(height: 10),
              AVInputField(
                label: "Plan Category",
                labelText: "Your Plan Category",
                controller: _PlanCategoryController,
                // validator: (String? v) => ValidationService.isValidInput(v!, minLength: 10),
              ),
              //AVDropdown(
              // options: categories.map((e) => e['name']).toList(),
              //  value: category,
              // label: "Plan Category",
              //  onChanged: (dynamic value){
              //    setState(() { category = value; });
              //  },
              //  ),
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
    if (isLoading) return;
    if (!_formKey.currentState!.validate()) return;

    // if(category == null){
    //   NotificationService.errorSheet(context, "Please select a category");
    //   return;
    // }
    //
    // Map cat = categories.singleWhere((element) => element['name'] == category);

    setState(() {
      isLoading = true;
    });

    Map payload = {
      "name": "${_firstNameController.text} ${_lastNameController.text}",
      "planName": "${widget.plan.planTypeName}",
      "emailAddress": _emailController.text,
      "mobileNumber": _phoneNumberController.text,
      "companyName": _companyNameController.text,
      "companyAddress": _addressController.text,
      "contactRole": _roleController.text,
      "CategoryCode": "",
      "noToEnrollee": 0,
      "companyAndLargeAssociation": true,
      "internationalHealthPlan": true
    };

    http.Response response =
        await HttpServices.post(context, 'explore/request-quote', payload);
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

  _getSubPlans() async {
    http.Response response =
        await HttpServices.get(context, "plan/categories", handleError: false);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      try {
        setState(() {
          categories = [...data['data']];
        });
      } catch (e) {
        print(e);
      }
    }
  }
}
