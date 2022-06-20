

import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/design/design_widget/dropdown.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:flutter/material.dart';

class DrugRefillForm extends StatelessWidget {
  const DrugRefillForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "Drug refill"),
       body:Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10.0),
         child: ListView (
           children: [
             const Text(
               "Step 1 of 2",
               style: TextStyle(
                 fontSize: 16,
                 fontWeight: FontWeight.w300,

               ),
             ),
             const  SizedBox(height: 8,),
             const  Text(
                 'Start by confirming your personal info',
                 textAlign: TextAlign.start,
                 style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black)
             ),
             const  SizedBox(height: 10,),
             const Text(
               "Check your information to prepare your existing and future drug refills",
               style: TextStyle(
                 fontSize: 16,
                 fontWeight: FontWeight.w300,

               ),
             ),
             const  SizedBox(height: 15,),
             AVInputField(
               label: "First name",
               labelText: "Ayomide ",
             ),
             AVInputField(
               label: "Last name",
               labelText: "Ayomide ",
             ),
             AVInputField(
               label: "Email address",
               labelText: "Ayomide ",
             ),
             AVInputField(
               label: "Mobile phone number",
               labelText: "Ayomide ",
             ),
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
               label: "Delivery address",
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
       )
    );
  }
}
