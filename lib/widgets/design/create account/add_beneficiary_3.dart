

import 'package:avon/widgets/design/design_widget/dropdown.dart';
import 'package:avon/widgets/design/design_widget/header_progress.dart';
import 'package:avon/widgets/design/design_widget/hospital_filter_modal.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddBeneficiary3 extends StatelessWidget {
  const AddBeneficiary3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            headerProgress(value: MediaQuery.of(context).size.width),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 15,top: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {},
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(
                          Icons.arrow_back,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                      Text("Final step",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),)
                    ],
                  ),
                  const  SizedBox(
                    height: 10,
                  ),
                  const Text(
                      'Enter info',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black)
                  ),
                  const  SizedBox(height: 5,),
                  const Text(
                    "Enter details of plans beneficiary",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,

                    ),
                  ),
                  const  SizedBox(height: 5,),
                  const Divider(),
                  const  SizedBox(height: 5,),
                  const  Text(
                      'Contact details',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black)
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      /// I tried to  used the function you created but it is not working for it
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: AVInputField(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          hintText: "Try typing “Optician”",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {

                          showDialog(context: context, builder: (builder)=>AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            content:hospitalFilterModal() ,

                          ));

                        },
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(
                          Icons.add_road_outlined,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  const  SizedBox(height: 5,),
                ],
              ),
            ),

            const  SizedBox(
              height: 10,
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.all(0),
                children: List.generate(
                    15,
                        (index) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      padding: const EdgeInsets.symmetric( vertical: 10),
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: (){},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/design_image/hospital.png"),
                                      fit: BoxFit.fill),
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Alajobi general Hospital ",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(height: 5,),
                                  Text("Ojota, Lagos,Nigeria ",
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1.3, color: const Color(0xffCFCFCF)))),
                    )),
              ),
            ),

            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: AVTextButton(
                  radius: 5,
                  child: Text('Continue', style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                  )),
                  verticalPadding: 17,
                  callBack: () {},
                ))


          ],
        ),
      ),
    );
  }
}
