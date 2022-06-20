
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

class JoinProviderScreen extends StatefulWidget {
  String title;
  String path;
  String type;

  JoinProviderScreen({
    Key? key,
    required this.title,
    required this.path,
    required this.type,
  }) : super(key: key);

  @override
  _JoinProviderScreenState createState() => _JoinProviderScreenState();
}

class _JoinProviderScreenState extends State<JoinProviderScreen> {

  bool isLoading = false;
  String? lState;
  String? lga;
  String? title;
  List lStates = [];
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _providerNameController = new TextEditingController();
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _companyNameController = new TextEditingController();
  TextEditingController _messageController = new TextEditingController();


  final _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadlStates();
  }

  @override
  Widget build(BuildContext context) {

    return AVScaffold(
      title: "${widget.title}",
      showAppBar: true,
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 10),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - (
              MediaQuery.of(context).padding.top + kToolbarHeight
          )
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Please fill the form below to become an Avon HMO ${widget.type}",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    height: 1.2
                ),
              ),

              SizedBox(
                height: 20,
              ),
              AVDropdown(
                options: ["Mr", "Mrs", "Miss", "Dr", "Chief", "Sir", "Lady"],
                value: title ?? "Mr",
                label: "Title",
                onChanged: (value){
                  setState(() {
                    title = value;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              AVInputField(
                label: "Surname",
                labelText: "Ayomide ",
                controller: _lastNameController,
                validator: (String? v) => ValidationService.isValidString(v!, minLength: 2),
              ),
              SizedBox(
                height: 10,
              ),
              AVInputField(
                label: "First Name",
                labelText: "Ayomide ",
                controller: _firstNameController,
                validator: (String? v) => ValidationService.isValidString(v!, minLength: 2),
              ),
              SizedBox(
                height: 10,
              ),
              AVInputField(
                label: "Phone Number",
                labelText: "08034234****",
                controller: _phoneNumberController,
                validator: (String? v) => ValidationService.isValidPhoneNumber(v!)
              ),
              SizedBox(
                height: 10,
              ),
              AVInputField(
                label: "Email",
                labelText: "Ayomide@gmail.com",
                controller: _emailController,
                validator: (String? v) => ValidationService.isValidEmail(v!)
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                  child: AVInputField(
                    label: "Company Name",
                    labelText: "Company Name",
                    controller: _companyNameController,
                    validator: (String? v){
                      if(widget.path != 'partner-provider') return ValidationService.isValidInput(v!, minLength: 2);
                      return null;
                    }
                  ),
                  visible: widget.path != 'partner-provider',
              ),
              SizedBox(
                height: 10,
              ),
              if(widget.path == 'partner-provider')
                AVInputField(
                  label: "Provider Name",
                  labelText: "My Provider Name",
                  controller: _providerNameController,
                  validator: (String? v) => ValidationService.isValidInput(v!, minLength: 2),
                ),
              SizedBox(
                height: 10,
              ),
              AVInputField(
                label: "Address",
                labelText: "NO 32, oladele street",
                controller: _addressController,
                validator: (String? v) => ValidationService.isValidInput(v!, minLength: 10),
              ),
              SizedBox(
                height: 10,
              ),
              AVDropdown(
                options: lStates.map((e) => e['state']).toList(),
                value: lState,
                label: "State",
                onChanged: (dynamic value){
                  setState(() {
                    lState = value!;
                  });
                },
              ),
              Padding(padding: EdgeInsets.only(top: 15)),
              AVDropdown(
                options: _getLga(),
                value: lga ,
                label: "Local Government Area",
                onChanged: (dynamic value){
                  setState(() {
                    lga = value!;
                  });
                },
              ),
              Padding(padding: EdgeInsets.only(top: 15)),
              Visibility(
                visible: widget.path != 'partner-provider',
                child: AVInputField(
                  label: "Message",
                  labelText: "Message",
                  controller: _messageController,
                  validator: (String? v){
                    if(widget.path != 'partner-provider') return ValidationService.isValidInput(v!, minLength: 10);
                    return null;
                  },
                  minLines: 7,
                  maxLines: 10,
                  height: 150,
                  verticalPadding: 5,
                  inputType: TextInputType.multiline,
                  inputAction: TextInputAction.newline,
                ),
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
      ),
    );
  }

  void submit()async {
    if (isLoading) return;
    if (!_formKey.currentState!.validate()) return;
    if(lga?.isEmpty == true || lga?.isEmpty == true || lState?.isEmpty == true){
      NotificationService.errorSheet(context, "Please fill all fields");
      return;
    }

    setState(() {isLoading = true;});

    Map payload = {
      "partnerProviderId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "surname": _lastNameController.text,
      "firstName": _firstNameController.text,
      "title": title,
      "phoneNumber": _phoneNumberController.text,
      "email": _emailController.text,
      "address": _addressController.text,
      "country": "Nigeria",
      "state": lState,
      "city": lState,
      "localGovtArea": lga,
      "companyName": _companyNameController.text,
      "providerName": _providerNameController.text,
      "message": _messageController.text
    };

    http.Response response = await HttpServices.post(context, 'explore/${widget.path}', payload);
    // print(response.body);

    if(response.statusCode == 200){
      Map data = jsonDecode(response.body);
      if(data['hasError'] == false){

        Navigator.pop(context);
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=> HospitalListScreen()));
        NotificationService.successSheet(context, data['message']);
      }
    }

    setState(() {isLoading = false;});
  }

  List _getLga(){
    List result = [''];
    if(lState?.isNotEmpty ?? false){
      Map? data = lStates.singleWhere((element) => element['state'] == lState, orElse: null);
      if(data != null){
        result = data['lgas'];
      }
    }
    return result;
  }

  Future loadlStates() async{
    var temp = await rootBundle.loadString('assets/jsons/states.json');
    if(temp != null){
      setState(() {
        lStates = jsonDecode(temp);
      });
    }
  }
}
