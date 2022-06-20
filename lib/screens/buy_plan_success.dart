import 'package:avon/screens/enrollee/dashboard.dart';
import 'package:avon/screens/welcome.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/utils/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuyPlanSuccess extends StatelessWidget {
  String? firstName;
  String? navigateTo;

  BuyPlanSuccess({Key? key, this.firstName, this.navigateTo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainProvider state = Provider.of<MainProvider>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.08, left: 20),
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                try {
                  state.pageController.jumpToPage(0);
                  state.cart.clear(); // state.cart = []
                  state.cartData.clear(); // state.cartData = []
                  GeneralService().removePref('cart');
                  if (!state.isLoggedIn) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => WelcomeScreen()));
                  }else{

                    Navigator.popUntil(context, ModalRoute.withName("dashboard"));
                  }
                } catch (e) {
                  if (!state.isLoggedIn) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => WelcomeScreen()));
                  }else{

                  }
                }

                // Navigator.popUntil(context, ModalRoute.withName("dashboard"));
              },
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
                  child: Text(
                    "🎉",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff85369B).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                    'Bravo ${state.isLoggedIn ? state.user.firstName : AvonData().avonData.get('paymentUser')}!',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  child: Text(
                    "Your purchase has been completed",
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
