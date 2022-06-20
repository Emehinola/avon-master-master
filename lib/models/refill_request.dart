import 'package:avon/utils/services/general.dart';
import 'package:flutter/material.dart';

enum DrugRefillStatus {
  ACCEPTED, REJECTED, PENDING
}

extension RefillStatus on DrugRefillStatus {
  String get value{
    switch (this){
      case DrugRefillStatus.ACCEPTED:
        return "Accepted";
      case DrugRefillStatus.PENDING:
        return "Pending";
      default:
        return "Rejected";
    }
  }

  String get apiChar{
    switch (this){
      case DrugRefillStatus.ACCEPTED:
        return "1";
      case DrugRefillStatus.PENDING:
        return "0";
      default:
        return "1";
    }
  }
}


class RefillRequest {

  String drugRefillRequestId;
  String enrolleeId;
  String userId;
  String memberNo;
  String firstName;
  String surname;
  String email;
  String phoneNumber;
  String dateOfBirth;
  String deliverAddress;
  String prescriptionPath;
  DrugRefillStatus requestStatus;
  Color? requestStatusColor;
  String requestDate;

  RefillRequest({
    required this.drugRefillRequestId,
    required this.enrolleeId,
    required this.userId,
    required this.memberNo,
    required this.firstName,
    required this.surname,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.deliverAddress,
    required this.prescriptionPath,
    required this.requestStatus,
    required this.requestDate,
    this.requestStatusColor
  });

  factory RefillRequest.fromJson(Map data){
    return RefillRequest(
        drugRefillRequestId: data['drugRefillRequestId'],
        enrolleeId: data['enrolleeId'],
        userId: data['userId'],
        memberNo: data['memberNo'] ?? '',
        firstName: data['firstName'],
        surname: data['surname'],
        email: data['email'],
        phoneNumber: data['phoneNumber'],
        dateOfBirth: GeneralService().processDate(data['dateOfBirth']),
        deliverAddress: data['deliverAddress'] ?? '',
        prescriptionPath: data['prescriptionPath'],
        requestStatus: getStatus(data['requestStatus']),
        requestStatusColor: getStatusColor(data['requestStatus']),
        requestDate: data['requestDate']
    );
  }

  static DrugRefillStatus getStatus(String st){
    return st == 'A' ? DrugRefillStatus.ACCEPTED : st == 'P' ? DrugRefillStatus.PENDING : DrugRefillStatus.REJECTED;
  }

  static Color getStatusColor(String st){
    return st == 'A' ? Colors.green : st == 'P' ? Colors.orange : Colors.red;
  }
}