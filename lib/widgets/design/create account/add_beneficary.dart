import 'package:avon/widgets/design/design_widget/dropdown.dart';
import 'package:avon/widgets/design/design_widget/header_progress.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddBeneficiary extends StatelessWidget {
  const AddBeneficiary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         // SizedBox(height: MediaQuery.of(context).size.height *0.01,),
          headerProgress(value: MediaQuery.of(context).size.width * 0.2),
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
                     Text("Step 1 of 3",
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
               ],
             ),
           ),

          const  SizedBox(
              height: 10,
            ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 15,top: 4),
            child: ListView(
              children: [

                const  Text(
                    'Principal details',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black)
                ),
                const  SizedBox(height: 5,),
                const Text(
                  "Upload passport photo",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,

                  ),
                ),
                const  SizedBox(height: 10,),

                Row(
                  children: [
                    DottedBorder(
                      dashPattern: [8, 4],
                      strokeWidth: 2,
                      color: Color(0xff85369B).withOpacity(0.2),
                      child: Container(
                        height: 100,
                        width: 100,
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

                const  SizedBox(height: 10,),
                dropDown(options: ["Mr"], defaultValue: "Mr", question: "Title"),

                AVInputField(
                  label: "Surname",
                  labelText: "Ayomide ",
                ),
                AVInputField(
                  label: "Firstname",
                  labelText: "Ayomide ",
                ),
                AVInputField(
                  label: "Firstname",
                  labelText: "Ayomide ",
                ),
                dropDown(options: ["Male"], defaultValue: "Male", question: "Gender"),
                InkWell(
                  onTap: ()async{
                    await showDatePicker(
                        context: context,
                        initialDate:DateTime(2015, 8),
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101));

                  },
                  child: AVInputField(
                    label: "Date of birth",
                    labelText: "5/27/15",
                    disabled: true,
                  ),
                ),
                AVInputField(
                  label: "Marital status",
                  labelText: "Ayomide ",
                ),

                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: AVTextButton(
                        radius: 5,
                        child: Text('Continue', style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        )),
                        verticalPadding: 17,
                        callBack: () {
                        }
                    ))


              ],
            ),
          ),
        )


          ],
        ),
      ),
    );
  }
}
