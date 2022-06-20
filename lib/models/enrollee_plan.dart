import 'package:intl/intl.dart';

class EnrolleePlan{
  int? policyNo;
  String? clientName;
  String? policyInception;
  String? policyExpiry;
  String? planType;
  int? planCode;
  String? planName;
  String? planTypeCategory;
  String? memberHeadNo;
  String? memberType;
  int? memberNo;
  String? avonOldEnrolleId;
  String? premiumType;
  String? name;
  String? surName;
  String? firstName;
  String? middleName;
  String? gender;
  String? relation;
  String? maritalStatus;
  String? dob;
  String? country;
  String? state;
  String? city;
  String? address;
  String? sbu;
  String? enrollmentDate;
  int? primaryProviderNo;
  String? primaryProviderName;
  String? memberExpirydate;
  String? staffID;
  String? dependantId;
  String? sponsoredId;
  String? email;
  String? mobileNo;
  String? capitatedMember;
  String? capitationRate;
  int? age;
  String? bloodType;
  String? weight;
  String? height;
  String? imageUrl;

  EnrolleePlan.fromJson(Map d){

    policyNo = d["policyNo"];
    clientName = d["clientName"];
    policyInception = d["policyInception"];
    policyExpiry = d["policyExpiry"];
    planType = d["planType"];
    planCode = d["planCode"];
    planName = d["planName"];
    planTypeCategory = d["planTypeCategory"];
    memberHeadNo = d["memberHeadNo"];
    memberType = d["memberType"];
    memberNo = d["memberNo"];
    avonOldEnrolleId = d["avonOldEnrolleId"];
    premiumType = d["premiumType"];
    name = d["name"];
    age = d["age"];
    surName = d["surName"];
    firstName = d["firstName"];
    middleName = d["middleName"];
    gender = d["gender"];
    relation = d["relation"];
    maritalStatus = d["maritalStatus"];
    dob = d["dob"];
    country = d["country"];
    state = d["state"];
    city = d["city"];
    address = d["address"];
    sbu = d["sbu"];
    enrollmentDate = d["enrollmentDate"];
    primaryProviderNo = d["primaryProviderNo"];
    primaryProviderName = d["primaryProviderName"];
    memberExpirydate = d["memberExpirydate"] != null ? DateFormat("dd, MM yyyy").format(DateTime.parse(d["memberExpirydate"])) : '';
    staffID = d["staffID"];
    sponsoredId = d["sponsoredId"];
    dependantId = d["dependantId"];
    email = d["email"];
    mobileNo = d["mobileNo"];
    capitatedMember = d["capitatedMember"];
    capitationRate = d["capitationRate"].toString();
    bloodType = d["bloodType"];
    weight = d["weight"];
    height = d["height"];
    imageUrl = d["imageUrl"];
  }
}