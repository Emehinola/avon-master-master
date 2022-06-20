import 'dart:convert';
import 'dart:io';
import 'package:avon/models/enrollee_plan.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/utils/services/notifications.dart';
import 'package:avon/utils/services/storage.dart';
import 'package:avon/utils/services/validation-service.dart';
import 'package:http/http.dart' as http;
import 'package:avon/widgets/forms/dropdown_input.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPersonalInfoScreen extends StatefulWidget {
  const EditPersonalInfoScreen({Key? key}) : super(key: key);

  @override
  _EditPersonalInfoScreenState createState() => _EditPersonalInfoScreenState();
}

class _EditPersonalInfoScreenState extends State<EditPersonalInfoScreen> {
  File? _file;
  String? bloodGroup;
  bool isLoading = false;
  TextEditingController _weightController = new TextEditingController();
  TextEditingController _heightController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  final formkey = new GlobalKey<FormState>();
  MainProvider? state;
  String? fdata;
  EnrolleePlan? enrolleePlan;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    state = Provider.of<MainProvider>(context, listen: false);

    if (state?.plan != null) {
      _weightController.text = state?.plan?.weight ?? '';
      _heightController.text = state?.plan?.height ?? '';
      bloodGroup = state?.plan?.bloodType;
      _phoneController.text = AvonData().avonData.get('phoneNumber') ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
        showAppBar: true,
        title: "Edit personal info",
        child: Container(
          height: MediaQuery.of(context).size.height -
              (kToolbarHeight + MediaQuery.of(context).padding.top),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter the details of the plan beneficiary",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Profile Photo",
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      _file != null
                                          ? _file?.path.split('/').last ?? ''
                                          : "Upload Image",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: _file == null
                                              ? Color(0xff631293)
                                              : Colors.black),
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
                          onTap: pickFile,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Max. file size is 1MB",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 15),
                        AVDropdown(
                          options: ["A", "AB", "B", "O", "NA"],
                          label: "Blood Group",
                          value: bloodGroup,
                          onChanged: (dynamic v) {
                            print(v);
                            setState(() {
                              bloodGroup = v;
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        AVInputField(
                          label: "Weight (Kg)",
                          labelText: "50",
                          controller: _weightController,
                          inputType: TextInputType.number,
                          validator: (String? v) =>
                              ValidationService.isValidNumber(v!),
                        ),
                        SizedBox(height: 10),
                        AVInputField(
                          label: "Height (~centimeter)",
                          labelText: "25",
                          controller: _heightController,
                          inputType: TextInputType.number,
                          validator: (String? v) =>
                              ValidationService.isValidNumber(v!),
                        ),
                        SizedBox(height: 10),
                        AVInputField(
                          label: "Mobile Phone",
                          labelText: "+234",
                          controller: _phoneController,
                          inputType: TextInputType.number,
                          validator: (String? v) =>
                              ValidationService.isValidNumber(v!),
                        ),
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
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: AVTextButton(
                            radius: 5,
                            child: Text('Update Personal Information',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            disabled: isLoading,
                            showLoader: isLoading,
                            verticalPadding: 17,
                            callBack: submit)))
              ],
            ),
          ),
        ));
  }

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'pdf', 'doc']);
    // FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;

    setState(() {
      _file = File(result.files.single.path!);
    });
  }

  void submit() async {
    if (isLoading) return;
    if (!formkey.currentState!.validate()) return;

    if (bloodGroup?.isEmpty == true) {
      NotificationService.errorSheet(context, "Please fill all fields");
      return;
    }

    setState(() {
      isLoading = true;
    });
    try {
      print(state?.user.enrolleeId);

      Map payload = {
        "enrolleeId": "${state?.user.enrolleeId}",
        "bloodType": bloodGroup,
        "weight": _weightController.text,
        "height": _heightController.text,
        "phonenumber": _phoneController.text.toString(),
        // "mobilePhone": _phoneController,
        "memberNumber": "${state?.user.memberNo}"
      };

      var data = await HttpServices.multipartRequest(
          // url: 'enrollee/personal-detail/birth-cert',
          url: 'edit-member-profile',
          payload: payload,
          image: _file,
          context: context);

      if (!data['hasError']) {
        print("data: $data");
        setState(() {
          AvonData().avonData.put('phoneNumber', _phoneController.text.toString());
          state?.plan?.weight = _weightController.text;
          state?.plan?.height = _heightController.text;
          state?.plan?.bloodType = bloodGroup;
          state?.user.mobilePhone = _phoneController.text;
          // state?.plan?.imageUrl = data['data']['picturePath'];
          // enrolleePlan?.imageUrl = data['data']['picturePath'];
        });
        // print("result: ${data['data']['picturePath']}");
        Navigator.pop(context);
        NotificationService.successSheet(context, data['message']);
      }
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }
}
