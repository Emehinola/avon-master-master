import 'package:avon/screens/enrollee/dashboard/profile/faq.dart';
import 'package:avon/screens/explore/contact/contact_details.dart';
import 'package:avon/screens/webviews/static-html.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/widgets/design/design_widget/circular_container.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:avon/screens/explore/contact/chat_with_us.dart';
import 'package:avon/screens/explore/contact/email_us.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:avon/screens/explore/contact/feedback.dart';

class ContactUsScreen extends StatelessWidget {
  final bool canPop;
  ContactUsScreen({Key? key, this.canPop = true}) : super(key: key);

  final List numbers = ["0700-277-9800"];

  @override
  Widget build(BuildContext context) {
    MainProvider state = Provider.of<MainProvider>(context);
    return AVScaffold(
      title:"Contact us",
      showAppBar: true,
      showBack: canPop,
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width *0.05,vertical: 10),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [

            circularContainer(text: "Chat with us",onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> ChatWithUsScreen()));
            }),
            circularContainer(text: "Call us",onPressed: (){
              showNumbers(context);
            }),
            circularContainer(text: "Email us",onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> EmailUsScreen()));
            }),
            if(state.isLoggedIn)
            circularContainer(text: "Give feedback",onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> FeedbackScreen()));
            }),
            circularContainer(text: "View our contact details", onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:
              //     (BuildContext context)=> ContactDetailsScreen()));
                  (BuildContext context)=> StaticHtmlScreen(
                      path: "assets/web/htmls/avon_contact/avon.html",
                      title: "Contact Details"
                  )));
            }),
            circularContainer(text: "FAQs",onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                  StaticHtmlScreen(
                    path: "https://www.avonhealthcare.com/understanding-insurance/faqs/",
                    title: "Frequently Asked Questions",
                    isWeb: true,
                  ))
              );
            }),
          ],
        ),
      ),

    );
  }




  void showNumbers(BuildContext context){
    GeneralService().bottomSheet(
      Expanded(child: ListView.builder(
          itemCount: numbers.length,
          itemBuilder: (BuildContext context, int index){
            String number = numbers[index];
            return circularContainer(text: number,onPressed: (){
              call(number);
            });
          }
      )),
       context,
        title:"Call Us",
    );
  }

  void call(String number)async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}
