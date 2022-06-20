

import 'package:avon/widgets/design/design_widget/dropdown.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:flutter/material.dart';

class PlanSummary extends StatelessWidget {
  const PlanSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.all(0),
          onPressed: () {},
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.black,
          ),
        ) ,
        title: Text(
          "Summary",
          style: TextStyle(fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Review your purchase and accept the terms and condition",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,

              ),
            ),

            SizedBox(
              height: 30,
            ),
            Text(
                'Plan',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black)
            ),
            SizedBox(
              height:7,
            ),
            planDetail(isDelete: false),
            SizedBox(
              height: 20,
            ),
            Divider(),
            Text(
                'Order summary',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black)
            ),
            SizedBox(
              height: 10,
            ),
            _summary(item: "Life plus", price: "N271,000"),
            _summary(item: "Couples", price: "N401,000"),
            _summary(item: "NHIS 1%", price: "N2,000"),

            SizedBox(
              height: 20,
            ),
            CheckboxListTile(
                value: true,
                selectedTileColor: Color(0xff631293),
                controlAffinity: ListTileControlAffinity.leading,
                title:RichText(
                  text: TextSpan(
                    children: [

                      TextSpan(text:"I agree to Avon HMO ",style: TextStyle(fontWeight: FontWeight.w300,color: Colors.black,fontSize: 16)),
                      TextSpan(text:"Terms ",style: TextStyle(fontWeight: FontWeight.w300,color: Color(0xff631293),fontSize: 16)),
                      TextSpan(text:"and ",style: TextStyle(fontWeight: FontWeight.w300,color: Colors.black,fontSize: 16)),
                      TextSpan(text:"Privacy policy",style: TextStyle(fontWeight: FontWeight.w300,color: Color(0xff631293),fontSize: 16)),

                    ]
                  ),
                ),  //
                onChanged: (value){}),
            SizedBox(
              height: 20,
            ),
            Container(
                width: MediaQuery.of(context).size.width *0.8,
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: AVTextButton(
                  radius: 5,
                  child: Text('Continue to Payment', style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                  )),
                  verticalPadding: 17,
                  callBack: () {
                  },
                )),
            Container(
                width: MediaQuery.of(context).size.width *0.8,
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: AVTextButton(
                  radius: 5,
                  color: Colors.white,
                  borderColor: Color(0xff631293),
                  child: Text('Buy More', style: TextStyle(
                      color: Color(0xff631293),
                      fontSize: 16
                  )),
                  verticalPadding: 17,
                  callBack: () {
                  },
                )),

          ],
        ),
      ),

    );
  }


  Widget _summary({required String item,required String price})=>Padding(
    padding: const EdgeInsets.symmetric(vertical: 7.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(item,
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),),
        Text(price,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),),
      ],
    ),
  );


  Widget planDetail({required bool isDelete})=>Container(
    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Icon(
          Icons.person_outline,
            color: Colors.white,
            size: 30,
          ),
          decoration: BoxDecoration(
            color: Color(0xff488948),
            shape: BoxShape.circle,


          ),
        ),
        SizedBox(
          width: 10,
        ),

        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Individual Plan ",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 3,),
              Text("Life starter",
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
            ],
          ),
        ),


      isDelete ? IconButton(
          onPressed: (){},
          icon: Icon(Icons.delete_forever_outlined,
          color: Color(0xffF16063),
          size: 30,),
        ): Container(width:0,)


      ],
    ),
    decoration: BoxDecoration(
      color: Color(0xffF0F6F0),
      borderRadius: BorderRadius.circular(10)

    ),
  );





}
