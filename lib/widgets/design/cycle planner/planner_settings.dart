import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:flutter/material.dart';

class PlannerSettings extends StatelessWidget {
  const PlannerSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title:""),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child:  ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      "Cycle info",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)
                  ),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(
                      Icons.edit
                    ),
                  )
                ],
              ),

              const SizedBox(height: 4,),
              const Text(
                "When did your last period start?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,

                ),
              ),
              const SizedBox(height: 5,),
              Text(
                  "9/23/16",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)
              ),

               const SizedBox(height: 15,),
              const Text(
                "How many days does your period usually last?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,

                ),
              ),
              const SizedBox(height: 8,),
              Text(
                  "3 - 5 days",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)
              ),

               const SizedBox(height: 15,),
              const Text(
                "How many days usually go between the start of one period and the start of the next one?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,

                ),
              ),
              const SizedBox(height: 7,),
              Text(
                  "3 - 5 days",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)
              ),


              const SizedBox(height: 15,),
              Divider(thickness: 1.1,),
              const SizedBox(height: 15,),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      "Notification",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)
                  ),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(
                        Icons.edit
                    ),
                  )
                ],
              ),
              const SizedBox(height: 4,),
              const Text(
                "I'm trying to NOT get pregnant, alert me about when I'm most likely to get pregnant from sex and when my period is close",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,

                ),
              ),
            ],
          )


      ),
    );
  }
}
