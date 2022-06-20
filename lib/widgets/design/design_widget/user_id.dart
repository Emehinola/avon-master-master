import 'package:flutter/material.dart';
import 'head_body_text.dart';

Widget userID()=>Container(
  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 100,
              child: Text("Avon Healthcare Card", style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff631293)
              ),)),

          //
          Image.asset("assets/images/Image.png")
        ],),
      const SizedBox(height:5,),

      Divider(height:1,thickness: 1.2,color: Colors.white,),
      const SizedBox(height:5,),
      headBodyText(head: "Member no", body: "479448532140"),
      const SizedBox(height:8,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headBodyText(head: "First name", body: "Abdulazeez"),
          headBodyText(head: "Other names", body: "Adunoluwa Adeyemi"),
        ],
      ),
      const SizedBox(height:8,),
      headBodyText(head: "Sex", body: "Male"),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headBodyText(head: "Company", body: "United Bank for Africa"),
              const SizedBox(height:8,),
              headBodyText(head: "Plan Type", body: "UBA Senior Plan"),

            ],
          ),

          Container(
            height: 120,
            width: 120,
            padding: const EdgeInsets.all(5),
            child: Image.asset(
              "assets/images/Rectangle 2843.png",
              fit: BoxFit.fill,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    width: 1.5,
                    color: Color(0xff631293).withOpacity(0.2)
                )
            ),
          )

        ],
      )

    ],
  ),
  decoration: BoxDecoration(
      color: Color(0xffF6EBFD),
      borderRadius: BorderRadius.circular(3)
  ),
);
