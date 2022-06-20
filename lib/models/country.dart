import 'package:country_icons/country_icons.dart';
import 'package:flutter/cupertino.dart';

class Country {
  String name;
  String code;

  Country.fromJson({
    required this.name,
    required this.code
  });

  Widget getFlag({double width = 25}){
    return Image.asset(
        'icons/flags/png/${this.code.toLowerCase()}.png',
        package: 'country_icons',
        width: 25,
    );
  }
}