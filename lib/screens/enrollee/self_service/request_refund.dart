import 'dart:convert';
import 'dart:io';
import 'package:avon/models/hospital.dart';
import 'package:avon/screens/enrollee/hospital/hospital_list.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/utils/services/storage.dart';
import 'package:avon/utils/services/validation-service.dart';
import 'package:avon/widgets/alert_dialog.dart';
import 'package:avon/widgets/forms/dropdown_input.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RequestRefundScreen extends StatefulWidget {
  const RequestRefundScreen({Key? key}) : super(key: key);

  @override
  _RequestRefundScreenState createState() => _RequestRefundScreenState();
}

class _RequestRefundScreenState extends State<RequestRefundScreen> {
  String? reason;
  String? _relError;
  Map<String, File?> _files = {
    "medicalReportDoc": null,
    "receiptsDoc": null,
    "invoiceDoc": null,
  };

  Map<String, String> _fieldName = {
    "medicalReportDoc": "Medical Report Doc.",
    "receiptsDoc": "Receipt Doc.",
    "invoiceDoc": "Invoice Doc.",
  };

  List options = [
    'Proximity',
    'Emergency',
    'Dissatisfaction with primary provider',
    'Out-of-network',
    'Hospital on suspension',
    'Payment for drugs',
    'Others'
  ];

  Hospital? hospital;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _avonIdController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _dobController = new TextEditingController();
  TextEditingController _othersController = new TextEditingController();
  TextEditingController _hospitalController = new TextEditingController();
  TextEditingController _amountController = new TextEditingController();
  TextEditingController _paCodeController = new TextEditingController();
  TextEditingController _beneficiaryNameController =
      new TextEditingController();
  TextEditingController _companyNameController = new TextEditingController();
  TextEditingController _bankNameController = new TextEditingController();
  TextEditingController _accountNumberController = new TextEditingController();
  TextEditingController _dateController = new TextEditingController();

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MainProvider state = Provider.of<MainProvider>(context, listen: false);
    if (state.isLoggedIn) {
      _nameController.text = "${state.user.lastName} ${state.user.firstName}";
      _phoneController.text = AvonData().avonData.get('phoneNumber');
      // _phoneController.text = "${state.user.mobilePhone}";
      _avonIdController.text = "${state.plan?.avonOldEnrolleId ?? ''}";
      _emailController.text = "${state.user.email}";
      if (state.plan?.dob != null) {
        _dobController.text = DateFormat("dd/MM/yyyy")
            .format(DateTime.parse(state.plan?.dob ?? ''));
      }
    }

    // _othersController.text = "test jkgf";
    // _amountController.text = "200";
    // _paCodeController.text = "test jkgf";
    // _beneficiaryNameController.text = "test jkgf";
    // _companyNameController.text = "test jkgf";
    // _bankNameController.text = "test jkgf";
    // _accountNumberController.text = "4000";
    // _dateController.text = "03/09/2022";
  }

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
        title: "Request A Refund",
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
                    SizedBox(height: 10),
                    AVInputField(
                      label: "Enrollee Name",
                      labelText: "Enrollee name",
                      controller: _nameController,
                      validator: (String? v) =>
                          ValidationService.isValidString(v!),
                    ),
                    SizedBox(height: 10),
                    AVInputField(
                        label: "Avon ID",
                        labelText: "Enter Avon ID",
                        controller: _avonIdController,
                        validator: (String? v) => null),
                    SizedBox(height: 10),
                    AVInputField(
                      label: "Phone Number",
                      labelText: "Enter Phone Number",
                      controller: _phoneController,
                      validator: (String? v) =>
                          ValidationService.isValidInput(v!),
                    ),
                    SizedBox(height: 10),
                    AVInputField(
                      label: "Email Address",
                      labelText: "Enter Email Address",
                      controller: _emailController,
                      validator: (String? v) =>
                          ValidationService.isValidInput(v!),
                    ),
                    SizedBox(height: 10),
                    AVInputField(
                      label: "Date Of Birth",
                      labelText: "Enter Date Of Birth",
                      controller: _dobController,
                      validator: (String? v) =>
                          ValidationService.isValidInput(v!),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      child: AVInputField(
                        label: "Encountered Date",
                        labelText: "23/04/2033",
                        controller: _dateController,
                        disabled: true,
                        validator: (String? v) =>
                            ValidationService.isValidInput(v!),
                      ),
                      onTap: toggleDatePicker,
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      child: AVInputField(
                        label: "Hospital",
                        hintText: "Select Hospital",
                        disabled: true,
                        controller: _hospitalController,
                        validator: (String? v) =>
                            ValidationService.isValidInput(v!),
                        icon: Icon(Icons.arrow_drop_down),
                      ),
                      onTap: selectHospital,
                    ),
                    // if(hospital != null)
                    //   Align(
                    //     alignment: Alignment.topLeft,
                    //     child: Text("${hospital?.address}", style: TextStyle(
                    //         color: Colors.black45
                    //     )),
                    //   ),
                    SizedBox(height: 10),
                    AVDropdown(
                      options: options,
                      value: reason,
                      label: "Select Reason For Refund",
                      errorText: _relError,
                      onChanged: (dynamic value) {
                        print(value);
                        setState(() {
                          reason = value;
                        });
                      },
                    ),
                    if (reason == 'Others')
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: AVInputField(
                          label: "If others (state here)",
                          labelText: "Type here....",
                          controller: _othersController,
                          validator: (String? v) => reason == 'Others'
                              ? ValidationService.isValidInput(v!, minLength: 5)
                              : null,
                          height: 150,
                          minLines: 6,
                          maxLines: 10,
                          inputType: TextInputType.multiline,
                          inputAction: TextInputAction.newline,
                        ),
                      ),
                    SizedBox(height: 10),
                    AVInputField(
                      label: "PA code",
                      labelText: "Enter PA code",
                      controller: _paCodeController,
                      validator: (String? v) =>
                          ValidationService.isValidInput(v!),
                    ),
                    SizedBox(height: 10),
                    AVInputField(
                        label: "Company Name",
                        labelText: "",
                        controller: _companyNameController,
                        validator: (String? v) => null),
                    SizedBox(height: 10),
                    AVInputField(
                      label: "Amount",
                      labelText: "Enter Amount",
                      controller: _amountController,
                      validator: (String? v) =>
                          ValidationService.isValidAmount(v!),
                      inputType: TextInputType.number,
                      inputFormatters: [
                        CurrencyTextInputFormatter(name: "₦", decimalDigits: 0)
                      ],
                    ),
                    SizedBox(height: 10),
                    AVInputField(
                      label: "Beneficiary Name",
                      labelText: "",
                      controller: _beneficiaryNameController,
                      validator: (String? v) =>
                          ValidationService.isValidInput(v!),
                    ),
                    SizedBox(height: 10),
                    AVInputField(
                      label: "Bank Name",
                      labelText: "",
                      controller: _bankNameController,
                      validator: (String? v) =>
                          ValidationService.isValidInput(v!),
                    ),
                    SizedBox(height: 10),
                    AVInputField(
                      label: "Account Number",
                      labelText: "",
                      controller: _accountNumberController,
                      validator: (String? v) =>
                          ValidationService.isValidNumber(v!),
                    ),
                    SizedBox(height: 10),
                    filePickerWidget("medicalReportDoc"),
                    SizedBox(height: 10),
                    filePickerWidget("receiptsDoc"),
                    SizedBox(height: 10),
                    filePickerWidget("invoiceDoc"),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: AVTextButton(
                          radius: 5,
                          child: Text("Continue",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          disabled: isLoading,
                          showLoader: isLoading,
                          verticalPadding: 17,
                          callBack: _continue),
                    ),
                    SizedBox(height: 50)
                  ],
                ),
              ),
            ),
          ]),
        ));
  }

  _continue() {
    if (!_formKey.currentState!.validate()) return;

    if (_othersController.text.isEmpty && reason == null) {
      setState(() {
        _relError = "Please make a selection or use the field below.";
      });
      return;
    }

    GeneralService().bottomSheet(
        Expanded(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "I certify that all of the above information is accurate to the best of my knowledge; \n\nI agree to reimburse Avon HMO if a claim refund made to me is later found to be more than I was entitled to receive or that I am not entitled to a refund. (If this claim form is signed by the member’s parent or legal guardian, these statements are agreed to by the signer on behalf of the enrollee.",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                        bottom: 15, left: 10, right: 10, top: 10),
                    child: AVTextButton(
                      child: Text("I Agree",
                          style: TextStyle(color: Colors.white)),
                      radius: 5,
                      verticalPadding: 17,
                      callBack: () {
                        Navigator.pop(context);
                        _submit();
                      },
                    ),
                  ))
            ],
          ),
        ),
        context,
        title: "Terms & Conditions",
        isDismissible: true,
        height: MediaQuery.of(context).size.height * 0.4);
  }

  toggleDatePicker() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 8),
        lastDate: DateTime.now());
    if (date?.day != null)
      setState(() {
        _dateController.text = "${date?.day}/${date?.month}/${date?.year}";
      });
    print(_dateController.text);
  }

  void selectHospital() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                HospitalListScreen(isDropSelect: true))).then((value) {
      if (value != null) {
        setState(() {
          hospital = value;
          _hospitalController.text = hospital!.name!;
        });
      }
    });
  }

  _submit() async {
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });

    try {
      Map payload = {
        "reason": reason != 'others' ? reason : _othersController.text,
        "otherReasons": _othersController.text,
        "amount": ValidationService.convertAmount(_amountController.text),
        "hospitalName": hospital?.name,
        "hospitalLocation": hospital?.address,
        "pACode": _paCodeController.text,
        "encounteredDate": _dateController.text,
        "companyName": _companyNameController.text,
        "beneficiaryName": _beneficiaryNameController.text,
        "bankName": _bankNameController.text,
        "accountNumber": _accountNumberController.text,
      };

      Map response = await HttpServices.multipartRequest(
          url: 'enrollee/actions/request-refund',
          payload: payload,
          image: null,
          images: _files,
          context: context);
      // print(response);

      if (response['statusCode'] == 200) {
        if (response['hasError'] == false) {
          Navigator.pop(context);

          showAlertDialog(
              context: context,
              type: AlertType.SUCCESS,
              header: "Request Submitted!",
              body: "${response['message']}",
              onContinue: () {});
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  Widget filePickerWidget(String item) {
    File? _file = _files[item];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upload ${_fieldName[item]}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          child: DottedBorder(
            dashPattern: [8, 4],
            strokeWidth: 2,
            color: _file == null
                ? Color(0xff85369B).withOpacity(0.2)
                : Colors.green.withOpacity(0.2),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              color: _file == null
                  ? Color(0xffE7D7EB)
                  : Colors.green.withOpacity(0.2),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      _file != null
                          ? _file.path.split('/').last
                          : "Select File",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color:
                              _file == null ? Color(0xff631293) : Colors.black),
                    ),
                  ),
                  if (_file != null)
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _file = null;
                          });
                        },
                        child: Icon(Icons.close))
                ],
              ),
            ),
          ),
          onTap: () {
            pickFile(item);
          },
        ),
      ],
    );
  }

  pickFile(String item) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'pdf', 'doc']);
    // FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;

    setState(() {
      _files[item] = File(result.files.single.path!);
    });
  }
}
