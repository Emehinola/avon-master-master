import 'dart:convert';
import 'package:avon/models/enrollee.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:avon/utils/services/storage.dart';

class GeneralService {
  SharedPreferences? _preference;
  List<String> months = [
    '',
    "Jan",
    "Feb",
    "Mar",
    "April",
    "May",
    "June",
    "July",
    "Aug",
    "Sept",
    "Oct",
    "Nov",
    "Dec"
  ];
  List<String> days = ['', "Mon", "Tues", "Wed", "Thur", "Fri", "Sat", "Sun"];

  GeneralService() {
    _initPref();
  }

  Future<SharedPreferences> _initPref() async {
    return await SharedPreferences.getInstance();
  }

  void setStringPref(String key, String value) async {
    _preference = await _initPref();
    // _preference?.clear();
    _preference?.setString(key, value);
  }

  void setBoolPref(String key, bool value) async {
    _preference = await _initPref();
    _preference?.setBool(key, value);
  }

  Future<String?> getStringPref(String key) async {
    _preference = await _initPref();
    return _preference?.getString(key);
  }

  Future<String?> getPaymentUserFirstName(String key) async {
    _preference = await _initPref();
    return _preference?.getString(key);
  }

  Future<bool?> getBoolPref(String key) async {
    _preference = await _initPref();
    return _preference?.getBool(key);
  }

  void removePref(String key) async {
    _preference = await _initPref();
    _preference?.remove(key);
  }

  void removeAllPref({List<String>? except}) async {
    _preference = await _initPref();
    _preference?.getKeys().forEach((element) {
      if (!(except?.contains(element) ?? false)) _preference?.remove(element);
    });
  }

  void setUser(Map value) async {
    _preference = await _initPref();
    _preference?.setString('user', jsonEncode(value));
  }

  Future<Enrollee?> getEnrollee() async {
    _preference = await _initPref();
    String? _user = _preference?.getString('user');
    if (_user != null) {
      return Enrollee.fromJson(jsonDecode(_user));
    }
    return null;
  }

  bottomSheet(Widget child, BuildContext context,
      {double? height, String? title, bool isDismissible = true}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: isDismissible,
      barrierColor: AVColors.primary.withOpacity(0.3),
      builder: (context) {
        return Container(
            width: MediaQuery.of(context).size.width,
            height: (height ?? 300) + MediaQuery.of(context).viewInsets.bottom,
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                )),
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                    visible: title != null,
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            InkWell(
                              child: Icon(Icons.close),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Divider(height: 1),
                        Padding(padding: EdgeInsets.only(top: 15))
                      ],
                    )),
                child,
              ],
            ));
      },
    );
  }

  showDialogue(BuildContext context, String message, [bool showIcon = true]) {
    // displaying pop-up

    showCupertinoDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              // TextButton(
              //   onPressed: () => Navigator.pop(context),
              //   child: const Text("Ok"),
              // )
            ],
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            content: Container(
              height: 200,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          CupertinoIcons.xmark,
                          size: 18,
                        )),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        showIcon
                            ? Image.asset(
                                'assets/images/medicine 1.png',
                                height: 30,
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  processDateTime(String date) {
    DateTime parseDate = DateTime.parse(date);

    return "${days[parseDate.weekday]},"
        " ${months[parseDate.month]} "
        "${parseDate.year} "
        "${DateFormat("H:m a").format(parseDate)}";
  }

  processDate(String date) {
    try {
      DateTime parseDate = DateTime.parse(date);

      return "${days[parseDate.weekday]}, "
          "${parseDate.day}"
          " ${months[parseDate.month]} "
          "${parseDate.year}";
    } catch (e) {
      return '';
    }
  }

  // using hive store
  void savePrincipalDetails(Map<String, dynamic> data){
    AvonData().avonData.putAll(data);
  }
}
