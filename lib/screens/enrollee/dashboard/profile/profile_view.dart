import 'package:avon/models/plan.dart';
import 'package:avon/screens/enrollee/dashboard/profile/edit_personal_info.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/widgets/dashboard/build_review_card.dart';
import 'package:avon/widgets/enrollee_card.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePreview extends StatefulWidget {
  const ProfilePreview({Key? key}) : super(key: key);

  @override
  _ProfilePreviewState createState() => _ProfilePreviewState();
}

class _ProfilePreviewState extends State<ProfilePreview> {
  Plan? plan;

  @override
  Widget build(BuildContext context) {
    MainProvider _state = Provider.of<MainProvider>(context);

    return AVScaffold(
      showAppBar: true,
      title: "${_state.user.lastName} ${_state.user.firstName}",
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height
        ),
        height: double.negativeInfinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(top: 30)),
              Text("Plan Information", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)),
              Padding(padding: EdgeInsets.only(top: 15)),
              EnrolleeCard(
                  enrolleePlan: _state.plan
              ),
              Visibility(
                visible: plan != null,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 30),
                  child: AVTextButton(
                    verticalPadding: 18,
                    radius: 5,
                    borderWidth: 1.7,
                    child: Text("Edit Plan Information", style: TextStyle(
                      color: AVColors.primary, fontWeight: FontWeight.w700
                    ),),
                    borderColor: AVColors.primary,
                    color: Colors.transparent,

                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 30)),
              GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2/0.9,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 18
                ),
                children: [
                  buildReviewCard(
                      title: "Age",
                      value: "${_state.plan?.age ?? ''}",
                      image: "assets/images/Vector (1).png",
                      color: Color(0XFF631293)
                  ),
                  buildReviewCard(
                      title: "Blood Type",
                      value: "${_state.plan?.bloodType ?? ''}",
                      image: "assets/images/Vector (2).png",
                      color: Color(0XFFF85959)
                  ),
                  buildReviewCard(
                      title: "Weight",
                      value: "${_state.plan?.weight ?? ''}",
                      image: "assets/images/Group copy.png",
                      color: Color(0XFF488948)
                  ),
                  buildReviewCard(
                      title: "Tall",
                      value: "${_state.plan?.height ?? ''}",
                      image: "assets/images/Vector (3).png",
                      color: Color(0XFFFDBC00)
                  ),
                ],
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
              Padding(padding: EdgeInsets.only(top: 30)),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 20),
                child: AVTextButton(
                  verticalPadding: 18,
                  radius: 5,
                  borderWidth: 1.7,
                  child: Text("Edit Personal Information", style: TextStyle(
                    color: AVColors.primary, fontWeight: FontWeight.w700
                  ),),
                  borderColor: AVColors.primary,
                  color: Colors.transparent,
                  callBack: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> EditPersonalInfoScreen()))
                    .then((value) => setState((){}) );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



}
