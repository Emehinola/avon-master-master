import 'dart:convert';
import 'package:avon/utils/constants/image_assets.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Enrollee {
  String userId;
  String enrolleeId;
  String firstName;
  String lastName;
  String email;
  String memberNo;
  String mobilePhone;
  String accessToken;
  String refreshToken;
  bool requiredPasswordChange;
  List<dynamic> pref;

  String get fullName => lastName+' '+firstName;

  Enrollee({
    required this.userId,
    required this.enrolleeId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.memberNo,
    required this.mobilePhone,
    required this.accessToken,
    required this.refreshToken,
    required this.requiredPasswordChange,
    required this.pref,
  });

  get id => null;

  Widget getImage({double radius = 25}){
    return CircleAvatar(
      backgroundImage: AssetImage(
          AVImages.user_icon
      ),
      radius: radius,
    );
  }

  factory Enrollee.fromJson(Map data){
    return Enrollee(
        userId: data["userId"],
        enrolleeId: data["enrolleeId"] ?? '',
        firstName: data["firstName"],
        lastName: data["lastName"],
        email: data["email"],
        memberNo: data["memberNo"] ?? '',
        mobilePhone: data["mobileNo"] ?? '',
        accessToken: data["access_token"] ?? '',
        refreshToken: data["refresh_token"] ?? '',
        pref: data["preferences"] ?? [],
        requiredPasswordChange: data["requiredPasswordChange"] ?? false,
    );
  }


   Map toJson(){
    return {
      "userId": userId,
      "enrolleeId": enrolleeId,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "mobilePhone": mobilePhone,
      "access_token": accessToken,
      "refresh_token": refreshToken,
      "preferences": pref,
      "requiredPasswordChange": requiredPasswordChange,
    };
  }

  bool getBoolPref(String key){
    Map? data = pref.lastWhere((element) => element!['prefType'] == key , orElse: ()=> null);

    if(data == null) return false;

    String value = data['prefValue'];
    return value == "1" ? true:false;
  }

  setBoolPref(String key, String value)async {
    try{
      dynamic user = await GeneralService().getStringPref('user');
      if(user == null) return this;

      user = jsonDecode(user);
      List prefs = user['preferences'];
      int index = prefs.lastIndexWhere((element) => element['prefType'] == key);

      if(index < 0){
        index = prefs.length;
       prefs.add({
         'prefType':key,
         'prefValue':'',
       });
       user['preferences'] = [...prefs];
      }

      user["preferences"][index]['prefValue'] = value;
      GeneralService().setUser(user);

      //save to server
      HttpServices
          .post(null, "user/pref", {
        "prefType": key,
        "prefValue": value,
        "enrollee_id": this.userId
      }, handleError: false);

      return Enrollee.fromJson(user);
    }catch(e){
      // print(e);
      return this;
    }
  }


}