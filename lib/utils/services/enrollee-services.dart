import 'dart:convert';

import 'package:avon/models/enrollee_plan.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/utils/services/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class EnrolleeServices {
  static Future<EnrolleePlan?> getPlanDetails(
      BuildContext context, String memberNo) async {
    // http.Response response = await HttpServices.get(context, 'enrollee/email?email=$email');
    http.Response response =
        await HttpServices.get(context, 'get-principal-enrollee-new/$memberNo');
    if (response.statusCode != 200) return null;

    Map data = jsonDecode(response.body);
    if (data['hasError']) return null;

    if (data['data'] != null) {
      EnrolleePlan plan = new EnrolleePlan.fromJson(data['data']);
      GeneralService().setStringPref('plan', jsonEncode(data['data']));
      print('Principal Details: ${data['data']}');

      // add the phone number to shared hivestore
     try{
       AvonData().avonData.put('phoneNumber', data['data']['mobileNo']);
     }catch(e){
       //
     }
      return plan;
    }

    return null;
  }
}
