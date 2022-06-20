import 'dart:convert';

import 'package:avon/models/buy_plan.dart';
import 'package:avon/screens/enrollee/hospital/hospital_list.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/utils/services/notifications.dart';
import 'package:avon/utils/services/validation-service.dart';
import 'package:avon/widgets/design/design_widget/header_progress.dart';
import 'package:avon/widgets/forms/checkbox_input.dart';
import 'package:avon/widgets/forms/dropdown_input.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactDetailsScreen extends StatefulWidget {
  Map data;
  ContactDetailsScreen({Key? key, required this.data}) : super(key: key);


  @override
  _ContactDetailsScreenState createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  String? lState;
  String? lga;
  bool useResAddress = false;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _resAddressController = new TextEditingController();
  TextEditingController _mailAddressController = new TextEditingController();

  List lStates = [];
  MainProvider? state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     state = Provider.of<MainProvider>(context, listen: false);

    _emailController.text = "${state?.user.email}";
    _phoneNumberController.text = "${state?.user.mobilePhone}";
    _resAddressController.text = "";
    _mailAddressController.text = "";


    loadlStates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height *0.05),
          headerProgress(value: MediaQuery.of(context).size.width * 0.5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.arrow_back,
                        size: 25,
                        color: Colors.black,
                      ),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                    Text("One more step to go",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                      ),)
                  ],
                ),
                const  SizedBox(
                  height: 10,
                ),
                const Text(
                    'Enter info',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black)
                ),
                const  SizedBox(height: 5,),
                const Text(
                  "Enter the details of the plan beneficiary.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,

                  ),
                ),
                const  SizedBox(height: 5,),
                const Divider(),
              ],
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                          'Contact details',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black)
                      ),
                      SizedBox(height: 10),
                      AVInputField(
                        label: "Email address",
                        labelText: "alma.lawson@example.com",
                        controller: _emailController,
                        validator: (String? v) => ValidationService.isValidEmail(v!),
                      ),
                      const  SizedBox(height: 10,),
                      AVInputField(
                        label: "Mobile number",
                        labelText: "(217) 555-0113",
                        controller: _phoneNumberController,
                        validator: (String? v) => ValidationService.isValidPhoneNumber(v!),
                        inputType: TextInputType.number,
                      ),
                      const  SizedBox(height: 10,),
                      AVInputField(
                        label: "Residential Address",
                        labelText: "4140 Parker Rd. Allentown, New Mexico 31134",
                        controller: _resAddressController,
                        validator: (String? v) => ValidationService.isValidInput(v!, minLength: 10),
                      ),
                      const  SizedBox(height: 10,),
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
                      Padding(padding: EdgeInsets.only(top: 10)),
                      AVDropdown(
                          options: _getLga(),
                          value: lga ,
                          label: "Local government Area",
                          onChanged: (dynamic value){
                            setState(() {
                              lga = value!;
                            });
                          },
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: AVCheckBoxInput(
                              value: useResAddress,
                              label: Text("Use residential address as mailing address",style: TextStyle(fontWeight: FontWeight.w400),),  //
                              onChanged: (bool? value){
                                setState(() { useResAddress = value!; });
                                if(value!){
                                  _mailAddressController.text = _resAddressController.text+', '+ (lState ?? '');
                                }else{
                                  _mailAddressController.text = "";
                                }
                              }
                          ),
                      ),
                      AVInputField(
                        label: "Mailing address",
                        labelText: "Opeyemi Olatogun",
                        controller: _mailAddressController,
                        validator: (String? v) => useResAddress ? null : ValidationService.isValidInput(v!, minLength: 5),
                      ),
                      Text(
                          "This is where your hospital identification card will be sent. Please include LGA",
                          style: TextStyle(fontWeight: FontWeight.w300,color: Color(0xff631293),fontSize: 14,)),


                      Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: AVTextButton(
                              radius: 5,
                              child: Text('Continue', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16
                              )),
                              showLoader: isLoading,
                              disabled: isLoading,
                              verticalPadding: 17,
                              callBack: submit
                          )
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
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


  void submit()async {
    if (isLoading) return;
    if (!_formKey.currentState!.validate()) return;

    if(lga?.isEmpty == true || lState?.isEmpty == true){
      NotificationService.errorSheet(context, "Please fill all fields");
      return;
    }


    setState(() {isLoading = true;});

    MainProvider state = Provider.of<MainProvider>(context, listen: false);
    List<BuyPlan> plans = state.cart;
    BuyPlan plan = plans.first;

    Map payload = {
      "enrolleeId": "${state.user.enrolleeId}",
      "email": _emailController.text,
      "phoneNumber": _phoneNumberController.text,
      "residentAddress": _resAddressController.text,
      "state": lState,
      "lga": lga,
      "mailingAddress": _mailAddressController.text
    };

    http.Response response = await HttpServices.post(context, 'plans/suscribe/enrollee/contact-detail', payload);
    // print(response.body);

    if(response.statusCode == 200){
      Map data = jsonDecode(response.body);
      if(data['hasError'] == false){
        // state.cart = <BuyPlan>[];
        // GeneralService().removePref('cart');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=> HospitalListScreen(fromBuyPlan: true)));
        NotificationService.successSheet(context, data['message']);
      }
    }

    setState(() {isLoading = false;});
  }
}
