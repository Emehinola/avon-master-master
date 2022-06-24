import 'dart:convert';
import 'dart:ui';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/widgets/dashboard/plan_card.dart';
import 'package:avon/widgets/empty_content.dart';
import 'package:avon/widgets/loader.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:avon/widgets/skeleton-card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:avon/models/plan.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HealthBenefitScreen extends StatefulWidget {
  HealthBenefitScreen({Key? key}) : super(key: key);

  @override
  _HealthBenefitScreenState createState() => _HealthBenefitScreenState();
}

class _HealthBenefitScreenState extends State<HealthBenefitScreen> {
  TextStyle _style =
      TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 16);

  bool isLoading = false;
  List<dynamic> benefits = [];
  List<String> header = [
    'Benefit\nname',
    'Waiting\nperiod\n(month)',
    'Value\nlimit',
    'Frequency\nlimit',
    'Age'
  ];
  List<String> body = [
    'benefitName',
    'waitingPeriod',
    'valueLimit',
    'frequencyLimit',
    'age'
  ];

  // number formatter
  var format = NumberFormat("#,###.##", "en_US");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBenefits();
  }

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
        showAppBar: true,
        title: 'Health Benefits',
        decoration: BoxDecoration(color: Colors.white),
        child: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).padding.top + kToolbarHeight)),
          height: double.negativeInfinity,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: ListView(
            children: [
              if (!isLoading)
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: header.map((e) => headerCell(e)).toList(),
                    ),
                    ...benefits
                        .map((e) => TableRow(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade400))),
                                children: [
                                  bodyCell(e['benefitName'],
                                      isFirstColumn: true),
                                  bodyCell(e['waitingPeriod'].toString() == '0'
                                      ? "✓"
                                      : e['waitingPeriod']),
                                  bodyCell(format
                                              .format(
                                                  double.parse(e['valueLimit']))
                                              .toString() ==
                                          '0'
                                      ? "✓"
                                      : format.format(
                                          double.parse(e['valueLimit']))),
                                  bodyCell(e['frequencyLimit'].toString() == '0'
                                      ? "✓"
                                      : e['frequencyLimit']),
                                  bodyCell(
                                      e['age'].toString() == '0'
                                          ? "✓"
                                          : e['age'],
                                      isLastColumn: true),
                                ]))
                        .toList(),
                  ],
                )
              else
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: AVLoader(
                    color: AVColors.primary,
                  ),
                )
            ],
          ),
        ));
  }

  Widget bodyCell(String text,
      {bool isFirstColumn = false, bool isLastColumn = false}) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(text,
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.034),
            textAlign: isFirstColumn
                ? TextAlign.left
                : isLastColumn
                    ? TextAlign.right
                    : TextAlign.center));
  }

  Widget headerCell(String text) {
    return Text(text,
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.034,
            fontWeight: FontWeight.w500),
        textAlign: text == "Age" ? TextAlign.right : TextAlign.left);
  }

  getBenefits() async {
    setState(() {
      isLoading = true;
    });

    MainProvider state = Provider.of<MainProvider>(context, listen: false);
    http.Response response =
        await HttpServices.get(context, "plan/benefits/${state.user.memberNo}");

    if (response.statusCode == 200) {
      Map body = jsonDecode(response.body);
      if (!body['hasError']) {
        setState(() {
          benefits = body['data'];
        });
        print(benefits.length);
      }
    }

    setState(() {
      isLoading = false;
    });
  }
}
