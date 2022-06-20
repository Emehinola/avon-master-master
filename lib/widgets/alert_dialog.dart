import 'package:avon/screens/welcome.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AlertType { ERROR, SUCCESS }

showAlertDialog(
    {required BuildContext context,
    required AlertType type,
    required String header,
    required String body,
    Widget? replacement,
    bool visible = true,
    Function()? onContinue}) {
  MainProvider state = Provider.of<MainProvider>(context, listen: false);
  BuildContext dialogContext;
  bool isSuccess = type == AlertType.SUCCESS;
  showDialog(
      context: context,
      builder: (BuildContext context) {
        dialogContext = context;
        return AlertDialog(
            content: IntrinsicHeight(
              child: Visibility(
                visible: visible,
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          child: Icon(
                            Icons.close,
                            size: 19,
                            color: Colors.black,
                          ),
                          onTap: () {

                              Navigator.of(dialogContext).pop();

                          },
                        )),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        isSuccess ? Icons.check : Icons.warning,
                        color: Colors.white,
                        size: 35,
                      ),
                      decoration: BoxDecoration(
                        color: isSuccess ? Color(0xff379657) : Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("${header}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "${body}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Visibility(
                      visible: onContinue != null,
                      child: Container(
                          width: 200,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: AVTextButton(
                              radius: 5,
                              child: Text('Continue',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              verticalPadding: 15,
                              callBack: () {
                                Navigator.of(dialogContext).pop();
                                if (onContinue != null) onContinue();
                              })),
                    )
                  ],
                ),
                replacement: replacement ?? Container(),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))));
      });
}
