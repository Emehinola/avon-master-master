import 'dart:convert';
import 'dart:io';
import 'package:avon/screens/enrollee/personal_health/drug_refill/request_histories.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/utils/services/notifications.dart';
import 'package:avon/widgets/alert_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';

class DrugRefillScreen2 extends StatefulWidget {
  Map payload;
  DrugRefillScreen2({Key? key, required this.payload}) : super(key: key);

  @override
  _DrugRefillScreen2State createState() => _DrugRefillScreen2State();
}

class _DrugRefillScreen2State extends State<DrugRefillScreen2> {
  bool isLoading = false;
  File? _image;

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
        title:"Drug refill",
        showAppBar: true,
        centerTitle: true,
        decoration: BoxDecoration(color: Colors.white),
        child: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height
                  - MediaQuery.of(context).padding.top - kToolbarHeight
          ),
          height: double.negativeInfinity,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child:Stack(
                children: [
                  ListView (
                    physics: BouncingScrollPhysics(),
                    children: [
                      const  SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Step 2 of 2",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                      const  SizedBox(height: 5,),
                      const Text(
                          'Attach prescription',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black)
                      ),
                      const  SizedBox(height: 15),
                      const Text(
                        "We’ll review the prescription, once it is valid we’ll accept and intiate a delivery.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const  SizedBox(height: 40),
                      const Text(
                        "Please upload drug prescription",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,

                        ),
                      ),
                      const  SizedBox(height: 10,),
                      Visibility(
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
                                  color: Color(0xff85369B).withOpacity(0.2)
                              ),
                              onPressed: pickFile,
                            ),
                          ),
                        ),
                        replacement:
                        GestureDetector(
                          child: Stack(
                            children: [
                              Image.file(
                                File("${_image?.path}"),
                                // height: MediaQuery.of(context).size.height * .2,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                              IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _image= null;
                                    });
                                  },
                                  icon: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    child: Icon(Icons.close, color: Colors.white),
                                  )
                              )
                            ],
                          ),
                          onTap: pickFile,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 10,
                    right: 15,
                    left: 15,
                    child:   Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 10),
                      child: AVTextButton(
                          radius: 5,
                          child: Text("Submit request", style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                          )),
                          disabled: isLoading,
                          showLoader: isLoading,
                          verticalPadding: 17,
                          callBack: submit
                      ),
                    ),
                  )
                ],
              )
          ),
        )
    );
  }

  pickFile()async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

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
          )
      );

      setState(() {
        _image = croppedFile;
      });
    } else {
      // User canceled the picker
    }
  }

  submit()async {
    if(isLoading) return;

    if(_image == null){
      NotificationService.errorSheet(context, "Please upload a prescription photo");
      return;
    }
    MainProvider state = Provider.of<MainProvider>(context, listen: false);
    setState(() { isLoading = true; });

     var body = await HttpServices.multipartRequest(
        url: "enrollee/actions/drugrefill-request",
        payload: widget.payload,
        image: _image!,
        context: context
     );

    setState(() { isLoading = false; });

    if(body['hasError']) return;

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder:
            (BuildContext context)=> DrugRequestHistoryScreen()));

    showAlertDialog(context: context,
        type: AlertType.SUCCESS,
        header: "Congratulations ${state.user.firstName}!",
        body: "${body['message']}",
        onContinue:(){}
    );
  }

  _handleResponse(Map body) async{
    String message = "";
    if(body["hasError"]){
      NotificationService.errorSheet(context, body['message']);
    }
  }
}
