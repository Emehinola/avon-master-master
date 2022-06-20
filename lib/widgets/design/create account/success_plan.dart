import 'package:flutter/material.dart';

class SuccessPlan extends StatelessWidget {
  const SuccessPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.08, left: 20),
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: (){},
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
          Align(
           alignment: Alignment.center,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Container(
                 padding: const EdgeInsets.all(40),
                 alignment: Alignment.center,
                 child: Text("🎉",
                   style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 40
                   ),),
                 decoration: BoxDecoration(
                   color: Color(0xff85369B).withOpacity(0.2),
                   shape: BoxShape.circle,


                 ),
               ),
               SizedBox(height: 20,),
               Text(
                   'Bravo Opeyemi!',
                   textAlign: TextAlign.start,
                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black)
               ),
               SizedBox(height: 10,),
               SizedBox(
                 width: 300,
                 child: Text(
                   "You have successfully completed your payment for the Individual Regular Plan, Kindly check your email for further instructions",
                   style: TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.w300,

                   ),
                   textAlign: TextAlign.center,
                 ),
               ),

             ],
           ),
         )
        ],
      ),
    );
  }
}
