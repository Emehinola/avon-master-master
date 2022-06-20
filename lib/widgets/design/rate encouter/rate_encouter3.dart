
import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/design/design_widget/image_text_arrow_btn.dart';
import 'package:avon/widgets/design/design_widget/rate_encounter_container.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateEncounter3 extends StatelessWidget {
  const RateEncounter3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "Rate Provider"),
      body: Stack(
          children:[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  Center(
                    child: SizedBox(
                      width: 350,
                      child: Text(
                        "How was your experience with your health care provider",
                        textAlign: TextAlign.center,
                        style:  TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  RatingBarIndicator(
                    itemCount: 5,
                    itemSize: 40,
                    rating: 0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                    unratedColor: Color(0xffEDF2F7),
                    itemBuilder:(context,index)=>Icon(
                      Icons.star_border_outlined,
                      color: Colors.amber,
                    ),),
                  const SizedBox(height: 20,),
                  Center(
                    child: SizedBox(
                      width: 350,
                      child: Text(
                        "Select a rating from 1-5",
                        textAlign: TextAlign.center,
                        style:  TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40,),

                  AVInputField(
                    label: "Additional comments (optional)",
                    labelText: "",
                    height: 120,
                    maxLines: 6,
                  ),



                ],
              ),
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
                    child: Text("Submit Rating", style: TextStyle(
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

          ]
      ),
    );
  }
}
