import 'package:avon/screens/plan/plan_list.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/design/design_widget/circular_container.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RenewBuyPlan extends StatelessWidget {
  const RenewBuyPlan({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    MainProvider _state = Provider.of<MainProvider>(context, listen: false);

    return AVScaffold(
      title: "Renew or Buy plans",
      showAppBar: true,
      decoration: BoxDecoration(
          color: Colors.white
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width *0.05,vertical: 10),
        child: Column(
          children: [
            circularContainer(text: "Renew Plan",onPressed: (){
              // print(_state.plan?.id);
              // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>PlanListScreen()));
            }),
            circularContainer(text: "Buy Plan",onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>PlanListScreen()));
            }),
          ],
        ),
      ),
    );
  }


}
