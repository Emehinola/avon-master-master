import 'package:url_launcher/url_launcher.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';

class thescheme extends StatelessWidget {
  const thescheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
        title: "How the Avon HMO Scheme Works",
        showAppBar: true,
        decoration: BoxDecoration(
            color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30,),
                Center(child: Text('Welcome', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('If you are reading this, then you must have signed up for an Avon HMO health plan and would like to know how it works.By the time you finish reading, you’ll have all the information you need.'),
                ),
//y
                Text('Accessing Care At The Hospital',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                SizedBox(height: 10,),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('If you need medical care and you have an Avon HMO health plan, all you need to do is to visit your primary careprovider, this is the hospital you select from our network when signing up. Usually, your primary care providershould be one close to your neighbourhood. When you get there, just present your Avon HMO ID card and we’ll handlethe rest'),
                  ),
                ),

                SizedBox(height: 10,),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('If you do not have your ID card or number with you, the hospital will call us to verify your identity.Should they decline to attend to you, please do not leave without a resolution, simply contact our Call Centre on '),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    children: [
                      SizedBox(width: 8,),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text('07002779800',style: TextStyle(fontWeight: FontWeight.w600),),
                      ),
                      SizedBox(width: 8,),
                      Text('for immediate assistance.'),
                    ],
                  ),
                ),


                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('If you have a medical emergency, you may not be able to go to your primary care provider depending on yourlocation. In this case, please go to the nearest hospital in our network'),
                  ),
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('In emergency cases, it’s important to inform us immediately or within 24 to 48 hours. This is important because itenables us to ensure you’re well cared for, or also process any refund that may be payable to you.'),
                  ),
                ),

                Text('	Accessing care when out of town',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(' You may also need medical care when you’re out of your state of residence. We call these ‘out of station’ cases.If this happens, kindly contact our call centre for recommendations on the nearest Avon HMO provider you can go to.We would authorize the hospital to attend to you, so you won’t have to pay for treatments you’re entitled to. Remember, you can always reach our call Centre via:'),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    children: [
                      SizedBox(width: 8,),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text('Telephone:',style: TextStyle(fontWeight: FontWeight.w600),),
                      ),
                      SizedBox(width: 8,),
                      Text('07002779800'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    children: [
                      SizedBox(width: 8,),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text('Email:',style: TextStyle(fontWeight: FontWeight.w600),),
                      ),
                      SizedBox(width: 8,),
                      Text('callcentre@avonhealthcare.com'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    children: [
                      SizedBox(width: 8,),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text('WhatsApp:',style: TextStyle(fontWeight: FontWeight.w600),),
                      ),
                      SizedBox(width: 8,),
                      Text('08175133802'),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    children: [
                      SizedBox(width: 8,),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text('SMS:',style: TextStyle(fontWeight: FontWeight.w600),),
                      ),
                      SizedBox(width: 8,),
                      Text('08175133802'),
                    ],
                  ),
                ),
                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('How To Access Dental And Optical Services',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Should you need dental or optical care, please call our call centre for a recommendation and to also check ifyou’re eligible for that service. Either way, the dental or optical centre will need to contact Avon HMO forpre-authorization. This only takes a few minutes.'),
                  ),
                ),

                Text('Getting Pre-Authorization',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('This is basically a go-ahead, given by your health insurer that a health care service, treatment plan, prescriptiondrug, etc. Is medically necessary. Providers may need to obtain pre-authorization for services like optical care,dental care, maternity services, drugs for chronic ailments, specialist consultations, out-of-station cases etc.'),
                  ),
                ),











              ],
            ),
          ),
        )
    );
  }
}
