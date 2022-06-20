


import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MedicalReport extends StatelessWidget {
  const MedicalReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F4F7),
      appBar: appBar(title: "Medical Record"),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _date(date: "Febuary 2019"),
          Expanded(child: Container(
            color: Colors.white,
            child: ListView(
              children: List.generate(6, (index) => _reporView()),
            ),
          )),

 _date(date: "April 2019"),

          Expanded(child: Container(
            color: Colors.white,
            child: ListView(
              children: List.generate(6, (index) => _reporView()),
            ),
          )),




        ],
      ) ,

    );
  }



  Widget  _reporView()=>Container(
    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bi-Annual Check up",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 5,),
              Text("Alajobi Medical Clinic ",
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
              SizedBox(height: 5,),
              Text("Apr 2nd, 2019",
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
            ],
          ),
        ),
       Icon(
         Icons.arrow_right_outlined
       )
      ],
    ),
    decoration: BoxDecoration(

        border: Border(
            bottom: BorderSide(
                color: Colors.black12,
                width: 1
            )
        )
    ),

  );


  Widget _date({required String date})=>  Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      child: Text(date,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600),));


}
