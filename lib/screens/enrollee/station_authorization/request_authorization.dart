import 'dart:convert';

import 'package:avon/models/country.dart';
import 'package:avon/models/enrollee.dart';
import 'package:avon/models/hospital.dart';
import 'package:avon/screens/auth/login.dart';
import 'package:avon/screens/enrollee/hospital/hospital_list.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/utils/services/notifications.dart';
import 'package:avon/utils/services/storage.dart';
import 'package:avon/utils/services/validation-service.dart';
import 'package:avon/widgets/forms/dropdown_input.dart';
import 'package:http/http.dart' as http;
import 'package:avon/widgets/auth/simple-header.dart';
import 'package:avon/widgets/forms/checkbox_input.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestAuthorizationScreen extends StatefulWidget {
  const RequestAuthorizationScreen({Key? key}) : super(key: key);

  @override
  _RequestAuthorizationScreenState createState() => _RequestAuthorizationScreenState();
}

class _RequestAuthorizationScreenState extends State<RequestAuthorizationScreen> {

  bool passwordVisibility = true;
  bool isLoading = false;
  Hospital? hospital;
  final _formKey = new GlobalKey<FormState>();
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _avonIdController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _hospitalController = new TextEditingController();
  // TextEditingController _paCodeController = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    MainProvider state = Provider.of<MainProvider>(context, listen: false);
    if(state.isLoggedIn){
      Enrollee user = state.user;
      _firstNameController.text = user.firstName;
      _lastNameController.text = user.lastName;
      _emailController.text = user.email;
      _phoneController.text = AvonData().avonData.get('phoneNumber') ?? "";
      // _phoneController.text = user.mobilePhone;
      if(state.plan != null){
        _avonIdController.text = state.plan?.avonOldEnrolleId ?? '';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
        showAppBar: true,
        title: 'Request Authorization',
        decoration: BoxDecoration(
            color: Colors.white
        ),
        child: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  (kToolbarHeight + MediaQuery.of(context).padding.top)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 0)),
                      Text("If you’re out of town or had to go to the hospital nearest to you due to an emergency, please fill the form below to request authorization for your care. ", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400
                      )),
                      _buildBody(),
                    ],
                  ),
                  _buildFooter()
                ]
            ),
          ),
        )
    );
  }

  Widget _buildBody(){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 25)),
          AVInputField(
            label: "First Name",
            labelText: "Opeyemi",
            controller: _firstNameController,
            validator: (String? v) => ValidationService.isValidString(v!, minLength: 2),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          AVInputField(
            label: "Last Name",
            labelText: "Opeyemi",
            controller: _lastNameController,
            validator: (String? v) => ValidationService.isValidString(v!, minLength: 2),
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
           AVInputField(
             label: "Avon ID Number",
             labelText: "0000000",
             controller: _avonIdController,
             validator: (String? v) => ValidationService.isValidInput(v!),
           ),
          // Padding(padding: EdgeInsets.only(top: 5)),
          // AVInputField(
          //    label: "PA Code",
          //    labelText: "0000000",
          //    controller: _paCodeController,
          //    validator: (String? v) => ValidationService.isValidInput(v!),
          //  ),
          Padding(padding: EdgeInsets.only(top: 5)),
          AVInputField(
            label: "Email Address",
            labelText: "OpeyemiOlatogun@testcompany.com",
            controller: _emailController,
            validator: (String? v) => ValidationService.isValidEmail(v!),
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          AVInputField(
            label: "Phone Number",
            labelText: "09024155251",
            controller: _phoneController,
            validator: (String? v) => ValidationService.isValidPhoneNumber(v!),
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          GestureDetector(
            child: AVInputField(
              label: "Hospital",
              hintText: "Select Hospital",
              disabled: true,
              controller: _hospitalController,
              validator: (String? v) => ValidationService.isValidInput(v!),
              icon: Icon(Icons.arrow_drop_down),
            ),
            onTap: selectHospital,
          ),
        ],
      ),
    );
  }

  void selectHospital(){
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context)=> HospitalListScreen(isDropSelect: true,))).then((value){
      if(value != null){
        setState(() {
          hospital = value;
          _hospitalController.text = hospital!.name!;

        });
      }
    });
  }
  Widget _buildHeader(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Create your account", style: TextStyle(
            color: Colors.black,
            fontSize: 19,
            fontWeight: FontWeight.w600
        ),),
        DropdownButton<String>(
          items: <Country>[
            Country.fromJson(name: "Nigeria", code: 'NG'),
            Country.fromJson(name: "Nigeria", code: 'us'),
            Country.fromJson(name: "Nigeria", code: 'de'),
          ].map<DropdownMenuItem<String>>(
                  (Country country) => DropdownMenuItem(
                child: country.getFlag(),
                value: country.code,
              )
          ).toList(),
          value: 'NG',
          onChanged: (String? value){},
        )
      ],
    );
  }

  Widget _buildFooter(){
    final style = TextStyle(color: AVColors.primary, fontSize: 14);
    final style2 = TextStyle(color: Colors.black, fontSize: 14);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(padding: EdgeInsets.only(top: 20)),
        Container(
          width: MediaQuery.of(context).size.width,
          child: AVTextButton(
            radius: 5,
            child: Text('Submit', style: TextStyle(color: Colors.white)),
            verticalPadding: 17,
            showLoader: isLoading,
            disabled: isLoading,
            callBack: submit,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 100)),
      ],
    );
  }

  void submit()async {
    if(isLoading) return;
    if(!_formKey.currentState!.validate()) return;

    setState(() { isLoading = true; });

    MainProvider state = Provider.of<MainProvider>(context, listen: false);

    Map payload = {
      "email":_emailController.text,
      "firstname":_firstNameController.text,
      "lastname":_lastNameController.text,
      "phoneNumber":_phoneController.text,
      "providerId": hospital?.code ?? '',
      "memberNo": state.user.memberNo,
      "paCode": '',//_paCodeController.text,
      "avonEnrolleId": state.user.enrolleeId
    };

    http.Response response = await HttpServices.post(context, 'enrollee/request/authourization', payload);
    print(response.body);

    if(response.statusCode == 200){
      Map data = jsonDecode(response.body);
      if(data['hasError'] == false){
        Navigator.pop(context);
        NotificationService.successSheet(context, data['message']);
      }
    }

    setState(() { isLoading = false; });
  }
}
