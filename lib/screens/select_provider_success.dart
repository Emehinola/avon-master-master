import 'package:avon/screens/beneficiary/principal_details.dart';
import 'package:avon/screens/enrollee/dashboard.dart';
import 'package:avon/screens/enrollee/dashboard/orders.dart';
import 'package:avon/state/main-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectProviderSuccess extends StatelessWidget {
  final bool fromBuyPlan;
 SelectProviderSuccess({Key? key, this.fromBuyPlan = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainProvider state = Provider.of<MainProvider>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.08, left: 20),
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: (){
                if(state.isLastPlan){
                  try{
                    state.pageController.jumpToPage(0);
                  }catch(e){}

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context)=> EnrolleeDashboardScreen()
                      )
                  );
                }else{
                  if(fromBuyPlan){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context)=> OrderScreen(), settings: RouteSettings(name: "order-summary")
                        )
                    );
                  }else{
                    Navigator.popUntil(context, ModalRoute.withName('dashboard'));
                  }
                }
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
                  child: Text("🎉",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40
                    ),),
                  decoration: BoxDecoration(
                    color: Color(0xff85369B).withOpacity(0.2),
                    shape: BoxShape.circle,


                  ),
                ),
                SizedBox(height: 20,),
                Text(
                    'Bravo ${state.user.firstName}!',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black)
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  child: Text(
                    "You have successfully selected a provider, Kindly check your email for further instructions",
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