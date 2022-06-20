
import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/design/design_widget/image_text_arrow_btn.dart';
import 'package:avon/widgets/design/design_widget/rate_encounter_container.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:flutter/material.dart';

class DrugFillOpenClosedRequest extends StatefulWidget {
  const DrugFillOpenClosedRequest({Key? key}) : super(key: key);

  @override
  State<DrugFillOpenClosedRequest> createState() => _DrugFillOpenClosedRequestState();
}

class _DrugFillOpenClosedRequestState extends State<DrugFillOpenClosedRequest>  with SingleTickerProviderStateMixin{


  late TabController _controller;


  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "Drug refill"),
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
                      fontWeight: FontWeight.w300),
                  indicatorWeight: 3,
                  tabs: [
                    SizedBox(height:30,child: Text("Open request",)),
                    SizedBox(height:30,child: Text("Closed requests",)),


                  ]),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
                  child: TabBarView(
                      controller: _controller,
                      children: [

                       requests(),
                       requests(),

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
                  child: Text("Request refill", style: TextStyle(
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

  Widget requests()=>Column(
    children: [
      request(title: "Request #01", content: "Accepted",),
      request(title: "Request #01", content: "Rejected",),
      request(title: "Request #01", content: "Pending",)
       ],
  );
  
  
  Widget request({required String title,required String content,Color? color})=> Container(
    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
    margin: const EdgeInsets.symmetric(vertical: 3),

    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 6,),
                RichText(
                   text: TextSpan(
                     style: TextStyle(
                         fontSize: 14,
                         color: Colors.black,
                         fontWeight: FontWeight.w300),
                     children: [
                       TextSpan(
                         text: "Status: "
                       ),
                       TextSpan(
                         text: content,
                         style: TextStyle(
                             fontSize: 14,
                             color: color ?? Colors.green,
                             fontWeight: FontWeight.w300)
                       ),

                     ]
                   ),
                )

              ],
            ),
          ),
        ),

       Center(
         child: Icon(Icons.arrow_forward_ios,
         size: 15,),
       )

      ],
    ),
    decoration: BoxDecoration(
        color: Colors.white,
      border: Border(
        bottom: BorderSide(
          color: Colors.black12
        )
      )
    ),

  );


}
