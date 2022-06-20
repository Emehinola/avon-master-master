import 'package:avon/models/plan.dart';
import 'package:avon/screens/plan/plan_list.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/constants/image_assets.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:flutter/material.dart';

class ProfilePlanCard extends StatelessWidget {
  Plan? plan;
  ProfilePlanCard({Key? key, this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      decoration: BoxDecoration(
          color: plan != null ? Color(0xFFe1eae1): Colors.grey.shade200,
          borderRadius: BorderRadius.circular(5)
      ),
      child: Visibility(
        visible: plan != null,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/Group 9845.png"),
                      fit: BoxFit.cover
                  ),
                  color: AVColors.primary
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AVImages.shield,
                    width: 50,
                  ),
                  Padding(padding: EdgeInsets.only(left: 20)),
                  Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Chioma Melone", style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700
                          ), overflow: TextOverflow.fade, softWrap: false,),
                          Padding(padding: EdgeInsets.only(top: 6)),
                          Text("Couples Life", style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400
                          ),),
                          Padding(padding: EdgeInsets.only(top: 6)),
                          Text("Plan ID: 23244354445", style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400)),
                          Padding(padding: EdgeInsets.only(top: 6)),
                          Text("Expiry Date: 22-04-2021", style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400
                          ))
                        ],
                      )
                  ),
                  Padding(padding: EdgeInsets.only(left: 20)),
                  CircleAvatar(
                    backgroundImage: AssetImage(AVImages.profilePicture),
                    radius: 30,
                  )
                ],
              ),
            )
          ],
        ),
        replacement: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("No Plan Selected Yet", style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 15,
                )),
                Padding(padding: EdgeInsets.only(top: 10)),
                AVTextButton(
                  child: Text("Buy Plan Now", style: TextStyle(
                      color: AVColors.primary,
                      fontSize: 12
                  )),
                  color: Colors.transparent,
                  borderColor: AVColors.primary,
                  horizontalPadding: 10,
                  verticalPadding: 11,
                  radius: 2,
                  callBack: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> PlanListScreen()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
