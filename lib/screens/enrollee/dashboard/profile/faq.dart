import 'package:avon/utils/constants/colors.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(
                    Icons.arrow_back,
                    size: 25,
                    color: Colors.black,
                  ),
                ) ,
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    "Hi, what can we help you with today?",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.07,
                      fontWeight: FontWeight.w800,
                      color: Colors.black
                    ),
                ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Color(0xffF1EAF5),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      "assets/images/bg2.png",
                    )
                )
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: AVInputField(
              label: "",
              labelText: "Search for topic",
              fillColor: AVColors.primary.withOpacity(0.01),
              labelStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
              prefixIcon: Icon(Icons.search, color: Colors.black),
              verticalPadding: 0,
              borderRadius:25,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Top question",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.2
              ),
            ),
          ),
          const  SizedBox(height: 5,),
          Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                children: [

                  faqList(head: "Change password", content: "Nulla Lorem mollit cupidatat irure. Laborum magna nulla duis cillum dolor."),
                  faqList(head: "Request a drug refill", content: "Tap here to turn on push notification"),
                  faqList(head: "Consult a doctor", content: "Tap here to turn on push notification"),
                  faqList(head: "Cycle planner", content: "Tap here to turn on push notification"),
                  faqList(head: "Request a drug refill", content: "Tap here to turn on push notification"),



                ],))


        ],
      ),
    );
  }


  Widget faqList({required String head,required String content,VoidCallback? callBack })=> Container(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: InkWell(
      onTap: callBack,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  head,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 7,),
                Text(
                    content,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300)),
              ],
            ),
          ),
          Icon(
              Icons.chevron_right,
            color: Colors.black.withOpacity(1),
            size: 20
          ),
        ],
      ),
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

}
