import 'dart:convert';
import 'dart:io';
import 'package:avon/models/refill_request.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/widgets/alert_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/notifications.dart';
import 'package:avon/utils/services/validation-service.dart';
import 'package:avon/widgets/forms/dropdown_input.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';

class AddDependantScreen extends StatefulWidget {
  RefillRequest? request;
  AddDependantScreen({Key? key, this.request}) : super(key: key);

  @override
  _AddDependantScreenState createState() => _AddDependantScreenState();
}

class _AddDependantScreenState extends State<AddDependantScreen> {
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _dobController = new TextEditingController();

  String? _firstNameError;
  String? _lastNameError;
  String? _dobError;
  String? _planError;
  String? _relError;

  String? whoToAdd;
  String? gender;
  String? relationShip;

  bool isLoading = false;
  File? _image;
  final _formKey = GlobalKey<FormState>();

  RefillRequest? get request => widget.request;

  List<String> relationShips = [
    "Spouse",
    "Children",
    "Others",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MainProvider state = Provider.of<MainProvider>(context, listen: false);
    // if(state.isLoggedIn){
    // _lastNameController.text = state.user.lastName;
    // _firstNameController.text = state.user.firstName;
    // _dobController.text = state.user.mobilePhone;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
        centerTitle: true,
        title: "Add New Beneficiary",
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
                const SizedBox(height: 15),
                const Text(
                  "Enter the details of the plan beneficiary",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40),
                      // AVDropdown(
                      //   options: ['YES', 'NO'],
                      //   value: isPlanForYou,
                      //   label: "Is the plan for you",
                      //   errorText: _planError,
                      //   onChanged: (dynamic value){
                      //     setState(() {
                      //       isPlanForYou = value!;
                      //     });
                      //   },
                      // ),
                      // if(isPlanForYou == 'NO')
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: AVDropdown(
                          options: relationShips,
                          value: relationShip,
                          label: "Relationship with dependant",
                          errorText: _relError,
                          onChanged: (dynamic value) {
                            setState(() {
                              relationShip = value!;
                            });
                          },
                        ),
                      ),
                      AVDropdown(
                        options: ['Male', 'Female'],
                        value: gender,
                        label: "Gender",
                        onChanged: (dynamic value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Upload passport photo",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Visibility(
                          visible: _image == null,
                          child: DottedBorder(
                            dashPattern: [8, 8],
                            strokeWidth: 2,
                            color: Color(0xff85369B).withOpacity(0.2),
                            child: Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              color: Color(0xffE7D7EB).withOpacity(0.4),
                              child: IconButton(
                                icon: Icon(Icons.add,
                                    size: 40,
                                    color: Color(0xff85369B).withOpacity(0.2)),
                                onPressed: pickFile,
                              ),
                            ),
                          ),
                          replacement: GestureDetector(
                            child: Stack(
                              children: [
                                Image.file(
                                  File("${_image?.path}"),
                                  // height: MediaQuery.of(context).size.height * .2,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _image = null;
                                      });
                                    },
                                    icon: CircleAvatar(
                                      backgroundColor: Colors.black,
                                      child: Icon(Icons.close,
                                          color: Colors.white),
                                    ))
                              ],
                            ),
                            onTap: pickFile,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      AVInputField(
                        label: "First Name",
                        labelText: "Ayomide",
                        controller: _firstNameController,
                        disabled: request != null,
                        validator: (String? v) =>
                            ValidationService.isValidString(v!, minLength: 2),
                      ),
                      AVInputField(
                        label: "Last Name",
                        labelText: "Oladele",
                        controller: _lastNameController,
                        disabled: request != null,
                        validator: (String? v) =>
                            ValidationService.isValidString(v!, minLength: 2),
                      ),
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

  pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      File file = File(result.files.single.path!);
      File? croppedFile = await ImageCropper().cropImage(
          sourcePath: file.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
              // minimumAspectRatio: 1.0,
              ));

      setState(() {
        _image = croppedFile;
      });
    } else {
      // User canceled the picker
    }
  }

  toggleDatePicker() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 8),
      lastDate: DateTime.now(),
    );
    if (date?.day != null)
      setState(() {
        _dobController.text = "${date?.day}/${date?.month}/${date?.year}";
      });
    print(_dobController.text);
  }

  submit() async {
    try {
      if (isLoading) return;
      // if (!_formKey.currentState!.validate()) return;

      if (_dobController.text.isEmpty  ||
          gender == null) {
        NotificationService.errorSheet(context, "All fields are required");
        return;
      }

      if (_image == null) {
        NotificationService.errorSheet(context, "Please upload a passport");
        return;
      }

      setState(() {
        isLoading = true;
      });

      MainProvider state = Provider.of<MainProvider>(context, listen: false);
      Map payload = {
        'firstName': _firstNameController.text,
        'surname': _lastNameController.text,
        'dateOfBirth': _dobController.text,
        "gender": gender == 'Male' ? 'm' : 'f',
        "relationshipId": relationShip.toString(),
        // "yourPlan": isPlanForYou == "YES" ? 1:0,
      };

      var body = await HttpServices.multipartRequest(
          url: "enrollee/actions/dependant-request",
          payload: payload,
          image: _image!,
          context: context);

      setState(() {
        isLoading = false;
      });

      if (body['hasError']) return;

      Navigator.pop(context);

      showAlertDialog(
          context: context,
          type: AlertType.SUCCESS,
          header: "Congratulations ${state.user.firstName}!",
          body: "${body['message']}",
          onContinue: () {});
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }
}
