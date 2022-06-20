import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DrugRefillForm2 extends StatelessWidget {
  const DrugRefillForm2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(title: "Drug refill"),
        body:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child:Stack(
            children: [
              ListView (
                physics: BouncingScrollPhysics(),
                children: [
                  const Text(
                    "Step 2 of 2",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,

                    ),
                  ),
                  const  SizedBox(height: 8,),
                  const  Text(
                      'Attach description',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black)
                  ),
                  const  SizedBox(height: 10,),
                  const Text(
                    "We’ll review the prescription, once it valid we’ll accept and intiate a delivery.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,

                    ),
                  ),
                  const  SizedBox(height: 25,),
                  const Text(
                    "Upload prescription",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,

                    ),
                  ),
                  const  SizedBox(height: 10,),

                  DottedBorder(
                    dashPattern: [8, 4],
                    strokeWidth: 2,
                    color: Color(0xff85369B).withOpacity(0.2),
                    child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xffE7D7EB),
                      child: IconButton(
                        icon: Icon(Icons.add,
                            size: 50,
                            color: Color(0xff85369B).withOpacity(0.2)
                        ),
                        onPressed: (){},
                      ),
                    ),
                  ),
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
                      child: Text("Submit request", style: TextStyle(
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
          )
        )
    );
  }
}
