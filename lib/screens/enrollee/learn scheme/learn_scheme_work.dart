
import 'package:avon/screens/enrollee/learn%20scheme/manual.dart';
import 'package:avon/screens/enrollee/learn%20scheme/thescheme.dart';
import 'package:avon/screens/explore/press_room/videos.dart';
import 'package:avon/screens/webviews/static-html.dart';
import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/design/design_widget/circular_container.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LearnSchemeWorkScreen extends StatelessWidget {
  const LearnSchemeWorkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
      title: "Learn How The Scheme Works",
      showAppBar: true,
      decoration: BoxDecoration(
          color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 10,),
            circularContainer(text: "Watch videos",onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                  StaticHtmlScreen(
                      path: "https://www.youtube.com/playlist?list=PL1K_fbg0wGoq3uyEGqpdJ8MLyKGPLPz6I",
                      title: "Learn How The Scheme Works",
                      isWeb: true,
                  ))
              );
            },color: Color(0xffF7F7FC)),
            circularContainer(text: "Read manual",onPressed: (){
              // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> thescheme() ));
             Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                  StaticHtmlScreen(path: "assets/web/htmls/scheme-work.html", title: "Learn How The Scheme Works"))
             );
            },color: Color(0xffF7F7FC)),
          ],
        ),
      ),
    );
  }
}
