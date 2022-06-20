import 'package:avon/screens/enrollee/rate_encounter/give_recommendation.dart';
import 'package:avon/screens/enrollee/rate_encounter/rate_provider.dart';
import 'package:avon/screens/explore/contact/chat_with_us.dart';
import 'package:avon/screens/explore/contact/feedback.dart';
import 'package:avon/widgets/design/design_widget/circular_container.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
class RateRecentEncounterScreen extends StatefulWidget {
  const RateRecentEncounterScreen({Key? key}) : super(key: key);

  @override
  _RateRecentEncounterScreenState createState() => _RateRecentEncounterScreenState();
}

class _RateRecentEncounterScreenState extends State<RateRecentEncounterScreen> {
  @override
  Widget build(BuildContext context) {
    return AVScaffold(
        title: "Rate Recent Encounter",
        showAppBar: true,
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              circularContainer(text: "Make a complaint",onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (BuildContext context)=> FeedbackScreen(
                          title: "Make a Complaint",
                        ))
                );
              }),
              circularContainer(text: "Rate a provider",onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> RateProviderScreen()));
              }),
              circularContainer(text: "Give a recommendation",onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> GiveRecommendationScreen()));
              }),
            ],
          ),
        ),
    );
  }
}
