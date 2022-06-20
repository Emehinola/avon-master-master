import 'package:avon/models/refill_request.dart';
import 'package:avon/screens/enrollee/personal_health/drug_refill/drug_refill_step_2.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/storage.dart';
import 'package:avon/utils/services/validation-service.dart';
import 'package:avon/widgets/forms/dropdown_input.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrugRefillScreen1 extends StatefulWidget {
  RefillRequest? request;
  DrugRefillScreen1({Key? key, this.request}) : super(key: key);

  @override
  _DrugRefillScreen1State createState() => _DrugRefillScreen1State();
}

class _DrugRefillScreen1State extends State<DrugRefillScreen1> {
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _resAddressController = new TextEditingController();
  TextEditingController _dobController = new TextEditingController();

  String? _dobError;

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  RefillRequest? get request => widget.request;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    MainProvider state = Provider.of<MainProvider>(context, listen: false);
    if (widget.request != null) {
      _emailController.text = request!.email;
      _lastNameController.text = request!.surname;
      _firstNameController.text = request!.firstName;
      _phoneNumberController.text = request!.phoneNumber;
      _dobController.text = request!.dateOfBirth;
      _resAddressController.text = request!.deliverAddress;
    } else if (state.isLoggedIn) {
      _emailController.text = state.user.email;
      _lastNameController.text = state.user.lastName;
      _firstNameController.text = state.user.firstName;
      _phoneNumberController.text = AvonData().avonData.get('phoneNumber');
      // _phoneNumberController.text = state.user.mobilePhone;

      if (state.plan != null) {
        _resAddressController.text = state.plan!.address ?? '';

        if (state.plan!.dob != null) {
          DateTime parseDate = DateTime.parse(state.plan!.dob ?? '');
          _dobController.text =
              "${parseDate.day}/${parseDate.month}/${parseDate.year}";
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
        centerTitle: true,
        title: "Drug Refill",
        showAppBar: true,
        decoration: BoxDecoration(color: Colors.white),
        child: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  kToolbarHeight),
          height: double.negativeInfinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: request == null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Step 1 of 2",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text('Start by confirming your personal info',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                      const SizedBox(height: 15),
                      const Text(
                        "Check your information to prepare your existing and future drug refills",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  replacement: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('View Drug Refill Request',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87)),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      AVInputField(
                        label: "First Name",
                        labelText: "Ayomide",
                        controller: _firstNameController,
                        disabled: request != null,
                        validator: (String? v) =>
                            ValidationService.isValidString(v!, minLength: 2),
                      ),
                      SizedBox(height: 10),
                      AVInputField(
                        label: "Last Name",
                        labelText: "Oladele",
                        controller: _lastNameController,
                        disabled: request != null,
                        validator: (String? v) =>
                            ValidationService.isValidString(v!, minLength: 2),
                      ),
                      SizedBox(height: 10),
                      AVInputField(
                        label: "Email address",
                        labelText: "alma.lawson@example.com",
                        controller: _emailController,
                        disabled: request != null,
                        validator: (String? v) =>
                            ValidationService.isValidEmail(v!),
                      ),
                      SizedBox(height: 10),
                      AVInputField(
                        label: "Mobile Number",
                        labelText: _phoneNumberController.text.toString(),
                        controller: _phoneNumberController,
                        disabled: request != null,
                        validator: (String? v) =>
                            ValidationService.isValidPhoneNumber(v!),
                        inputType: TextInputType.number,
                      ),
                      SizedBox(height: 10),
                      AVInputField(
                        label: "Residential Address",
                        labelText:
                            "4140 Parker Rd. Allentown, New Mexico 31134",
                        controller: _resAddressController,
                        disabled: request != null,
                        validator: (String? v) =>
                            ValidationService.isValidInput(v!, minLength: 10),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: toggleDatePicker,
                        child: AVInputField(
                          label: "Date of birth",
                          labelText: "5/27/15",
                          disabled: true,
                          controller: _dobController,
                          validator: (String? v) =>
                              ValidationService.isValidInput(v!, minLength: 5),
                        ),
                      )
                    ],
                  ),
                ),
                if (request == null)
                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: AVTextButton(
                          radius: 5,
                          child: Text('Continue',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          showLoader: isLoading,
                          disabled: isLoading,
                          verticalPadding: 17,
                          callBack: submit)),
                if (request != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Prescription",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400)),
                      Padding(padding: EdgeInsets.only(bottom: 10)),
                      Image(image: NetworkImage(request!.prescriptionPath))
                    ],
                  )
              ],
            ),
          ),
        ));
  }

  toggleDatePicker() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 8),
        lastDate: DateTime.now());
    if (date?.day != null)
      setState(() {
        _dobController.text = "${date?.day}/${date?.month}/${date?.year}";
      });
    print(_dobController.text);
  }

  submit() {
    if (isLoading) return;
    if (!_formKey.currentState!.validate()) return;

    if (_dobController.text.isEmpty) {
      setState(() {
        _dobError = "Date is empty";
      });
      return;
    }

    MainProvider state = Provider.of<MainProvider>(context, listen: false);
    Map payload = {
      'email': _emailController.text,
      'firstName': _firstNameController.text,
      'surname': _lastNameController.text,
      'phoneNumber': _phoneNumberController.text,
      'deliverAddress': _resAddressController.text,
      'dateOfBirth': _dobController.text
    };

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                DrugRefillScreen2(payload: payload)));
  }
}
