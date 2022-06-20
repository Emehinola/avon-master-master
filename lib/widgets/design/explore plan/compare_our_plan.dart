

import 'package:avon/widgets/design/design_widget/dropdown.dart';
import 'package:avon/widgets/forms/dropdown_input.dart';
import 'package:avon/widgets/forms/dropdown_input.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';

class CompareOurPlan extends StatelessWidget {
   CompareOurPlan({Key? key}) : super(key: key);


  final List<String> _dropdownValues = [
    "One",
    "Two",
    "Three",
    "Four",
    "Five"
  ];


  @override
  Widget build(BuildContext context) {
    return  AVScaffold(
        showAppBar: true,
        title: '',

        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.02,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Compare Our Plans",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  "Click on any of the plan to compare",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      height: 1
                  ),
                ),
              ),
              SizedBox(
                height: 90,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(child: AVDropdown(options: ["Individual Plus"], value: "Individual Plus", label: "")),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: Text("vs",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                height: 1
                            ),),
                        ),
                      ),
                      Flexible(child: AVDropdown(options: ["Individual Plus"], value: "Individual Plus", label: "")),
                    ],
                  ),
                ),
              ),
              DataTable(
                  showBottomBorder: true,
                  columns:[
                    DataColumn(
                        label: Text(
                            'Benefits',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black)
                        )
                    ),
                    DataColumn(label: Text(
                        '',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black)
                    ),),
                    DataColumn(label: Text('',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black)
                      )
                    ),
                  ], rows: [

                DataRow(cells: [
                  DataCell(Text('General Consultation',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff631293)
                  ),)),
                  DataCell(Text('Yes',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ))),
                  DataCell(Text('Yes',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ))),

                ]),
                DataRow(cells: [
                  DataCell(Text('Specialist consultation',style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff631293)
                  ),)),
                  DataCell(Text('3 per annum',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ))),
                  DataCell(Text('3 per annum',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ))),

                ]),
                DataRow(cells: [
                  DataCell(Text('Lab Investigation',style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff631293)
                  ),)),
                  DataCell(Text('Yes',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ))),
                  DataCell(Text('Yes',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ))),

                ]),

              ]),
            ],
          ),
        )
    );
  }




}
