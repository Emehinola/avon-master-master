import 'package:url_launcher/url_launcher.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';

const String reason1 =
    "If Life happens whether we like it or not so it’s important to have a plan. Here’s why protects your finances"
    "Medical emergencies, especially surgeries are very expensive and can run into hundreds of thousands of Naira. With a health plan, the financial burden does not fall on you, the HMO steps in.";
const String reason2 = "Access to quality care whenever needed"
    "Self-medication is a dangerous risk most people take when they don’t have a health plan. When you have one, you have access to quality healthcare whenever you need it.";
const String reason3 = "Preventive care and early intervention"
    "It’s easier to deal with a health issue if it is noticed on time."
    "Most serious illnesses are spotted early due to regular health checks which are easier with a healthcare plan.";

class ReadManualScreen extends StatelessWidget {
  ReadManualScreen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      fontSize: 16,
    );

    return AVScaffold(
      title: "Why you should get an Avon Plan...",
      centerTitle: true,
      showAppBar: true,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Container(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).padding.top - kToolbarHeight)),
        width: MediaQuery.of(context).size.width,
        height: double.negativeInfinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(padding: EdgeInsets.only(top: 30)),
              Text(reason1, style: style),
              Padding(padding: EdgeInsets.only(top: 20)),
              Text(reason2, style: style),
              Padding(padding: EdgeInsets.only(top: 20)),
              Text(reason3, style: style),
              Padding(padding: EdgeInsets.only(top: 20)),
              Text(
                "So, rather than leave your health to chance, wouldn’t it be better to have a plan? With Avon HMO, you can!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              GestureDetector(
                child: Text("Visit https://www.youtube.com/watch?v=7_CNPjTY93I",
                    style: TextStyle(
                        fontSize: 13, decoration: TextDecoration.underline)),
                onTap: () async {
                  await launch("https://www.youtube.com/watch?v=7_CNPjTY93I");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
