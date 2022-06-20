

import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/design/design_widget/check_box.dart';
import 'package:avon/widgets/design/design_widget/dropdown.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:flutter/material.dart';

class ViewPlan extends StatelessWidget {
  const ViewPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "Individual - Life Plus"),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 2),
        child: Column(
          children: [
            Text(
              "This is  our most basic plan and it covers a list of benefits which you can view below",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                  height: 1.2
              ),
            ),

            SizedBox(
              height: 20,
            ),
         DataTable(
           showBottomBorder: true,
             columns:[
           DataColumn(
               label: Text(
               'Benefits',
               textAlign: TextAlign.start,
               style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black)
           )),
           DataColumn(label: Text(
               'Life plus',
               style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black)
           )),

         ], rows: [

           DataRow(cells: [
             DataCell(Text('General Consultation',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300,
             ))),
             DataCell(Text('Yes',style: TextStyle(
               fontSize: 16,
               fontWeight: FontWeight.w300,
             ))),


           ]),
           DataRow(cells: [
             DataCell(Text('Lab Investigations',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300,
             ))),
             DataCell(Text('3 per annum',style: TextStyle(
               fontSize: 16,
               fontWeight: FontWeight.w300,
             ))),


           ]),
           DataRow(cells: [
             DataCell(Text('Travel Immunization',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300,
             ))),
             DataCell(Text('₦76,000',style: TextStyle(
               fontSize: 16,
               fontWeight: FontWeight.w300,
             ))),


           ]),

         ]),



          ],
        ),
      ),
      bottomNavigationBar:  Container(
          width: MediaQuery.of(context).size.width *0.8,
          margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: AVTextButton(
            radius: 5,
            child: Text('Proceed to buy', style: TextStyle(
                color: Colors.white,
                fontSize: 16
            )),
            verticalPadding: 17,
            callBack: () {
              showDialog(context: context, builder: (builder)=>AlertDialog(
                content: planAlert(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  )
              ));
            },
          )),
    );
  }



  Widget colText({required String head,required String content})=>Align(
    alignment: Alignment.topLeft,
    child:Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(head,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 14
        ),),
        const SizedBox(
          height: 3,
        ),
        Text(content,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Color(0xff2B7EA1)
        ),),


      ],
    ),
  );


  Widget planAlert()=>IntrinsicHeight(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Benefiaciary",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,

              ),
            ),
            IconButton(
              onPressed: (){},
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
            )
          ],
        ),


        checkBox(text: "Buying for someone (be a sponsor)", value: false,onPress: (value){}),
        dropDown(options: ["1"], defaultValue: "1", question: "Number of Beneficiary"),

        const SizedBox(
          height: 5,
        ),
        colText(head: "Price Per Individual", content: "₦322,000"),
        const SizedBox(
          height: 10,
        ),
        colText(head: "Total", content: "₦322,000"),
        const SizedBox(
          height: 10,
        ),
        Container(
            width: 250,
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
  );



}
