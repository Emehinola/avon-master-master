import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Plan {
  String id;
  String planTypeName;
  String? description;
  String? planTypeId;
  String? code;
  String? icon;
  String? bgImage;
  Color? color;
  String? rawColor;
  String? planName;
  double? premium;
  double? planType;
  String? currentPlanType;
  bool requiredQuoteRequest;

  Plan(
      {required this.id,
      required this.planTypeName,
      this.planType,
      this.planTypeId,
      this.currentPlanType,
      this.description,
      this.code,
      this.icon,
      this.bgImage,
      this.color,
      this.rawColor,
      this.planName,
      this.premium,
      this.requiredQuoteRequest = false});

  factory Plan.fromSubPlanJson(Map data) {
    return Plan(
      id: data['id'] ?? '',
      planTypeName: data['planTypeName'] ?? data['planName'],
      planTypeId: data['planTypeId'],
      description: data['description'],
      code: data['code'].toString(),
      icon: data['icon'].toString(),
      bgImage: data['bgImage'].toString(),
      color: computeColor(data['color']),
      rawColor: data['color'],
      planName: data['planName'],
      requiredQuoteRequest: data['requiredQuoteRequest'] ?? false,
      premium: double.parse(data['premium'].toString()),
    );
  }

  // factory Plan.fromCurrentSubPlanJson(Map data) {
  //   return Plan(
  //     id: data['PlanTypeId'] ?? '',
  //     planTypeName: data['planTypeName'] ?? data['planName'],
  //     planTypeId: data['planId'],
  //     description: data['planDescription'],
  //     code: data['planCode'].toString(),
  //     icon: data['planIcon'].toString(),
  //     bgImage: data['planBgImage'].toString(),
  //     color: computeColor(data['planColor']),
  //     rawColor: data['planColor'],
  //     planName: data['planName'],
  //     requiredQuoteRequest: data['requiredQuoteRequest'] ?? false,
  //     // premium: double.parse((data['premium'] ?? 0).toString()),
  //   );
  // }

  factory Plan.fromCurrentSubPlanJson(Map data) {
    return Plan(
      id: data['planTypeId'] ?? '',
      planTypeName: data['planTypeName'] ?? data['planName'],
      planTypeId: data['planTypeId'] ?? data['planId'],
      description: data['planDescription'],
      code: data['planCode'].toString(),
      icon: data['icon'].toString(),
      bgImage: data['planBgImage'].toString(),
      color: computeColor(data['color']),
      rawColor: data['planColor'],
      planName: data['planName'],
      requiredQuoteRequest: data['requiredQuoteRequest'] ?? false,
      premium: double.parse((data['premium'] ?? 0).toString()),
    );
  }

  factory Plan.fromCurrentPlan(Map data) {
    return Plan(
      id: data['id'] ?? '',
      currentPlanType: data['planType'],
      planTypeName: '',
    );
  }

  factory Plan.fromPlanJson(Map data) {
    return Plan(
      id: data['id'],
      planTypeName: data['planTypeName'],
      description: data['description'],
      icon: data['icon'].toString(),
      bgImage: data['bgImage'].toString(),
      rawColor: data['color'] ?? '',
      requiredQuoteRequest: data['requiredQuoteRequest'] ?? false,
      color: computeColor(data['color'] ?? null),
    );
  }

  static Color computeColor(String? color) {
    if (color == null) return Color(0xFFf2f2f2);
    String _color = "0xFF" + color.toString().replaceAll('#', '');

    return Color(int.parse(_color));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "planTypeName": planTypeName,
        "planTypeId": planTypeId,
        "description": description,
        "code": code,
        "icon": icon,
        "color": rawColor,
        "planName": planName,
        "premium": premium,
        "requiredQuoteRequest": requiredQuoteRequest
      };
}
