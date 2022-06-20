

import 'package:avon/widgets/design/design_widget/user_id.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:flutter/material.dart';

class AvonID1 extends StatelessWidget {
  const AvonID1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 30,
        title: Text(
         "Avon ID",
          style: TextStyle(fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),
        ),
        centerTitle: false,
        actions:[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              onPressed: (){},
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff631293)),
                  padding: MaterialStateProperty.all(EdgeInsets.all(0))
              ),
              child:Text('share', style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              )),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const SizedBox(height: 20,),
            userID(),
            const SizedBox(height: 15,),
            Text(
              "Dependent",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
            ),
            const SizedBox(height: 15,),
            userID(),


          ],
        ),
      ),
    );
  }
}
