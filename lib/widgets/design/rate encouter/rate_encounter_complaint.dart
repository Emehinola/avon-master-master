
import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/design/design_widget/image_text_arrow_btn.dart';
import 'package:avon/widgets/design/design_widget/rate_encounter_container.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:flutter/material.dart';

class RateEncounterComplaint extends StatefulWidget {
  const RateEncounterComplaint({Key? key}) : super(key: key);

  @override
  State<RateEncounterComplaint> createState() => _RateEncounterComplaintState();
}

class _RateEncounterComplaintState extends State<RateEncounterComplaint>  with SingleTickerProviderStateMixin{


  late TabController _controller;


  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "Complaints"),
      body:Stack(
        children: [

          Column(
            children: [

              SizedBox(height: 10,),
              TabBar(
                  controller: _controller,
                  indicatorColor: Color(0xff631293),
                  labelColor: Color(0xff631293),
                  unselectedLabelColor: Colors.black,
                  labelStyle: TextStyle(
                      fontSize: 16,
                      color: Color(0xff631293),
                      fontWeight: FontWeight.w500),
                  indicatorWeight: 3,
                  tabs: [
                    SizedBox(height:30,child: Text("Open complaints",)),
                    SizedBox(height:30,child: Text("Closed complaints",)),


                  ]),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
                  child: TabBarView(
                      controller: _controller,
                      children: [

                        openComplaint(),
                        //closedComplaint()
                        noComplain()


                      ]),
                ),
              )


            ],
          ),
          Positioned(
            bottom: 10,
            right: 15,
            left: 15,
            child:   Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 30),
              child: AVTextButton(
                  radius: 5,
                  child: Text("Make a complaint", style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                  )),
                  verticalPadding: 17,
                  // color: Colors.white,
                  // borderColor: Color(0xff631293),
                  callBack: (){}
              ),
            ),
          )

        ],
      ),
    );
  }

  Widget openComplaint()=>Column(
    children: [
      rateEncounterContainer(title: "Jacob Jones", content: "Hey opeyemi, regarding your stooling d...", imageText: "BP", when: "Today",count: "1"),
      rateEncounterContainer(title: "Waiting for doctor", content: "You:Hi doctor! I have a complaint about...", imageText: "BP", when: "Today",count: "1"),
    ],
  );

  Widget closedComplaint()=>Column(
    children: [
      rateEncounterContainer(title: "Jacob Jones", content: "Hey opeyemi, regarding your stooling d...", imageText: "BP", when: "Today",count: "1"),
      rateEncounterContainer(title: "Waiting for doctor", content: "You:Hi doctor! I have a complaint about...", imageText: "BP", when: "Today",count: "1"),
    ],
  );


  Widget noComplain()=>Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [

      Image.asset("assets/images/empty-contact-list.png"),
     const SizedBox(height: 10,),
      Text(
        "No recent consultation history ",
        style:  TextStyle(
            fontSize: 16,
            color: Colors.black45,
            fontWeight: FontWeight.w300),
      ),
      const SizedBox(height: 10,),
      Container(
        width:200,
        margin: EdgeInsets.only(top: 30),
        child: AVTextButton(
            radius: 5,
            child: Text("I have a complaint", style: TextStyle(
                color: Colors.white,
                fontSize: 16
            )),
            verticalPadding: 17,
            // color: Colors.white,
            // borderColor: Color(0xff631293),
            callBack: (){}
        ),
      ),



    ],
  );


}
