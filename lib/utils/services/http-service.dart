import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:avon/models/enrollee.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/utils/services/notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HttpServices {
  // static String baseUrl = "https://api-avonhmo.azurewebsites.net/api/v1/";
  // static String baseUrl2 = "https://api-avonhmo.azurewebsites.net/api/v1.0/";
  static String baseUrl =
      "https://production-api-hmo.azurewebsites.net/api/v1/";
  static String baseUrl2 =
      "https://production-api-hmo.azurewebsites.net/api/v1.0/";
  static String avonAccount = "YWRtaW46UEAkJHcwcmQxMjMkI0A=";
  static List successCodes = [200, 201, 202, 203, 210];

  static Future post(BuildContext? context, String endpoint, Map body,
      {bool useBase2 = false,
      Map? header,
      bool handleError = true,
      Function()? callBack,
      bool auth = true}) async {
    Uri url = Uri.parse((!useBase2 ? baseUrl : baseUrl2) + endpoint);
    String token = "";

    String? data = await GeneralService().getStringPref('user');
    if (data != null) {
      Enrollee user = Enrollee.fromJson(jsonDecode(data));
      token = user.accessToken;
    }

    try {
      print("Calling >>> ${url.path}");
      print(jsonEncode(body));
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: {
        'Authorization': 'Bearer ${token}',
        'content-type': 'application/json',
        'v': '1',
        'x-avon-account': '${avonAccount}'
      }).timeout(Duration(minutes: 2));

      print(response.body);
      print(response.statusCode);

      if (handleError && context != null) {
        await _handleResponse(response, context, callBack: callBack);
      }
      return response;
    } on TimeoutException catch (e) {
      if (handleError && context != null) {
        NotificationService.errorSheet(context, "Connection Timeout");
        return http.Response(jsonEncode({"hasError": true}), 500);
      }
    } catch (e) {
      return http.Response(jsonEncode({"hasError": true}), 500);
    }
  }

  static Future get(context, String endpoint,
      {bool useBase2 = false,
      Map? header,
      bool handleError = false,
      Function()? callBack,
      bool auth = true}) async {
    Uri url = Uri.parse((!useBase2 ? baseUrl : baseUrl2) + endpoint);

    String token = "";
    String? data = await GeneralService().getStringPref('user');

    if (data != null) {
      print(data);
      Enrollee user = Enrollee.fromJson(jsonDecode(data));
      token = user.accessToken;
    }

    try {
      print("Calling >>> ${url.path}");
      print("Calling >>> ${url.queryParametersAll}");
      http.Response response = await http.get(url, headers: {
        'Authorization': 'Bearer ${token}',
        'v': '1',
        'x-avon-account': '${avonAccount}'
      }).timeout(Duration(minutes: 2));

      print(response.body);
      print(response.statusCode);
      if (handleError) {
        await _handleResponse(response, context, callBack: callBack);
      }
      return response;
    } on TimeoutException catch (e) {
      NotificationService.errorSheet(context, "Connection Timeout");
      return http.Response(jsonEncode({"hasError": true}), 500);
    } catch (e) {
      return http.Response(jsonEncode({"hasError": true}), 500);
    }
  }

  static Future multipartRequest({
    required String url,
    required Map payload,
    required File? image,
    required BuildContext context,
    Map<String, File?>? images,
  }) async {
    String? data = await GeneralService().getStringPref('user');
    String token = "";
    if (data != null) {
      Enrollee user = Enrollee.fromJson(jsonDecode(data));
      token = user.accessToken;
    }

    var request = new http.MultipartRequest(
        "POST", Uri.parse("${HttpServices.baseUrl}${url}"));

    payload.forEach((key, value) {
      request.fields[key] = value.toString();
    });
    print(url);
    print(payload);

    if (image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', "${image.path}"));
    }

    if (images != null) {
      images.forEach((label, image) async {
        if (image != null) {
          request.files
              .add(await http.MultipartFile.fromPath(label, "${image.path}"));
        }
      });
    }

    request.headers.addAll({
      "Authorization": 'Bearer ${token}',
      'v': '1',
      'x-avon-account': HttpServices.avonAccount
    });

    var response = await request.send();
    String resp = await response.stream.bytesToString();
    print(">>> ${resp}");
    var body = jsonDecode(resp);

    print(body);
    if (response.statusCode == 200) {
      if (body['hasError'] == true) {
        NotificationService.errorSheet(context, body['message']);
        return Future.value({"hasError": true, "message": body['message']});
      }
      return Future.value(body);
    }

    return Future.value({"hasError": true, "message": "Connection Error"});
  }

  static Future _handleResponse(http.Response response, context,
      {Function()? callBack}) async {
    String message = '';
    if (response.statusCode != 200 && response.statusCode != 400) {
      message = "Unknown error occured";
    } else {
      try {
        Map body = jsonDecode(response.body);
        if (body.containsKey('hasError')) {
          if (body["hasError"]) {
            if (body.containsKey('title')) {
              message = body['title'];
            } else {
              message = body['message'];
            }
          } else if (body.containsKey('title')) {
            message = body['title'];
          }
        }
      } catch (e) {}
    }

    if (message.isNotEmpty) {
      NotificationService.errorSheet(context, message);
    }
  }

  static bool isSuccessFull(int status) {
    if (successCodes.singleWhere((element) => element == status,
            orElse: () => false) ==
        status) return true;

    return false;
  }
}
