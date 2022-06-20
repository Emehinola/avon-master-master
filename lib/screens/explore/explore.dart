import 'package:avon/screens/auth/create_account.dart';
import 'package:avon/screens/auth/login.dart';
import 'package:avon/screens/explore/explore_home.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int activeIndex =0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
      child: SafeArea(
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height
          ),
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: ExploreHomeScreen(),
        ),
      ),
      bottomNavigationBar:BottomNavigationBar(
        unselectedItemColor: Color(0xffA1A1A1),
        selectedItemColor: Color(0xff631293),
        // showSelectedLabels: true,
        // showUnselectedLabels: true,
        onTap: (int index){
          switch(index){
            case 1:{
              Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateAccountScreen() ));
            }
            break;
            case 2:{
              Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen() ));
            }
            break;
          }
        },
        items:const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon:Image(
                image: AssetImage("assets/images/h.png"),
              ),
              label: "Sign up",
          ),
          BottomNavigationBarItem(
              icon:Image(
                image: AssetImage("assets/images/h.png"),
              ),
              label: "Login"
          ),
        ],
      ),
    );
  }
}
