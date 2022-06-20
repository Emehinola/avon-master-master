import 'package:avon/models/enrollee.dart';
import 'package:avon/screens/enrollee/dashboard/actions.dart';
import 'package:avon/screens/enrollee/dashboard/home.dart';
import 'package:avon/screens/enrollee/dashboard/profile.dart';
import 'package:avon/screens/explore/contact/contact_us.dart';
import 'package:avon/screens/plan/plan_list.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';


class EnrolleeDashboardScreen extends StatefulWidget {
  const EnrolleeDashboardScreen({Key? key}) : super(key: key);

  @override
  _EnrolleeDashboardScreenState createState() => _EnrolleeDashboardScreenState();
}

class _EnrolleeDashboardScreenState extends State<EnrolleeDashboardScreen> {

  MainProvider? _state;
  Enrollee? get enrollee => _state?.user;
  BehaviorSubject<int> _currentIndexController = BehaviorSubject.seeded(0);
  PageController? get _controller => _state?.pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _state = Provider.of<MainProvider>(context, listen: false);

    _controller?.addListener(() {
      _currentIndexController.add(_controller?.page?.toInt() ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: null,
          body: SafeArea(
            child: PageView(
              children: [
                MainScreen(
                    child: EnrolleeHomeScreen()),
                MainScreen(
                  child: EnrolleeActionsScreen(),
                ),
                PlanListScreen(),
                EnrolleeProfileScreen(),
                ContactUsScreen(canPop: false,)
              ],
              controller: _controller,
            )
          ),
          bottomNavigationBar: _buildNavs(),
      ),
      onWillPop: ()async {
        _controller?.jumpToPage(0);
        return false;
      },
    );
  }

  Widget MainScreen({Widget? child}){
    return SingleChildScrollView(
      child: child,
    );
  }

 Widget _buildNavs(){
    return StreamBuilder<int>(
      stream: _currentIndexController.stream,
      builder: (context, AsyncSnapshot<int> snapshot) {
        return BottomNavigationBar(
            unselectedItemColor: Color(0xffA1A1A1),
            selectedItemColor: AVColors.primary,
            showUnselectedLabels: true,
            elevation: 10,
            currentIndex: snapshot.data ?? 0,
            onTap: (int index){
              _controller?.jumpToPage(index);

            },
            items:const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: "Action",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: "Buy Plan",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: "Profile",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: "Contact",
              ),
            ]
        );
      }
    );
  }

  List<PersistentBottomNavBarItem> _buildItems(){

    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: AVColors.primary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.menu),
        title: ("Action"),
        activeColorPrimary: AVColors.primary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_cart),
        title: ("Buy Plan"),
        activeColorPrimary: AVColors.primary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.account_circle_outlined),
        title: ("Profile"),
        activeColorPrimary: AVColors.primary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.message),
        title: ("Contact"),
        activeColorPrimary: AVColors.primary,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

}
