class Hospital {
  int? code;
  String? name;
  String? shortName;
  String? address;
  String? lga;
  String? state;
  String? city;
  String? phoneno;
  String? email;
  String? providerClass;
  String? hSpecial;
  String? swiftCode;
  String? providerManager;
  String? providerCategory;
  String? providerType;
  String? providerPaymentType;
  String? bankname;
  String? actNo;
  String? bankBranch;
  String? sortCode;
  String? mdName;
  String? mdPhoneNo;
  String? mdEmail;
  String? hmoOfficerName;
  String? hmoDeskPhoneNo;
  String? hmoOfficerEmail;
  String? providerServiceType;
  String? capitation;
  String? accountantEmail;
  String? accountantName;
  String? accountantPhoneNo;
  String? notes;

  Hospital({
    this.code,
    this.name,
    this.shortName,
    this.address,
    this.lga,
    this.state,
    this.city,
    this.phoneno,
    this.email,
    this.providerClass,
    this.hSpecial,
    this.swiftCode,
    this.providerManager,
    this.providerCategory,
    this.providerType,
    this.providerPaymentType,
    this.bankname,
    this.actNo,
    this.bankBranch,
    this.sortCode,
    this.mdName,
    this.mdPhoneNo,
    this.mdEmail,
    this.hmoOfficerName,
    this.hmoDeskPhoneNo,
    this.hmoOfficerEmail,
    this.providerServiceType,
    this.capitation,
    this.accountantEmail,
    this.accountantName,
    this.accountantPhoneNo,
    this.notes,
  });

  factory Hospital.fromJson(Map json){
    return Hospital(
      code: json['code'],
      name: json['name'],
      shortName: json['shortName'],
      address: json['address'],
      lga: json['lga'],
      state: json['state'],
      city: json['city'],
      phoneno: json['phoneno'],
      email: json['email'],
      providerClass: json['providerClass'],
      hSpecial: json['hSpecial'],
      swiftCode: json['swiftCode'],
      providerManager: json['providerManager'],
      providerCategory: json['providerCategory'],
      providerType: json['providerType'],
      providerPaymentType: json['providerPaymentType'],
      bankname: json['bankname'],
      actNo: json['actNo'],
      bankBranch: json['bankBranch'],
      sortCode: json['sortCode'],
      mdName: json['mdName'],
      mdPhoneNo: json['mdPhoneNo'],
      mdEmail: json['mdEmail'],
      hmoOfficerName: json['hmoOfficerName'],
      hmoDeskPhoneNo: json['hmoDeskPhoneNo'],
      hmoOfficerEmail: json['hmoOfficerEmail'],
      providerServiceType: json['providerServiceType'],
      capitation: json['capitation'],
      accountantEmail: json['accountantEmail'],
      accountantName: json['accountantName'],
      accountantPhoneNo: json['accountantPhoneNo'],
      notes: json['notes'],
    );
  }
}