import 'dart:convert';
import 'dart:developer';
import 'package:avon/models/enrollee_plan.dart';
import 'package:avon/screens/webviews/map.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/constants/image_assets.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/widgets/design/design_widget/image_text_arrow_btn.dart';
import 'package:avon/widgets/empty_content.dart';
import 'package:avon/widgets/loader.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ViewPlanScreen extends StatefulWidget {
  EnrolleePlan? enrollee;
  bool isDependant;

  ViewPlanScreen({Key? key, this.enrollee, this.isDependant = false})
      : super(key: key);

  @override
  _ViePlanStateScreen createState() => _ViePlanStateScreen();
}

class _ViePlanStateScreen extends State<ViewPlanScreen> {
  bool isLoading = true;
  MainProvider? _state;
  Map? profile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _state = Provider.of<MainProvider>(context, listen: false);

    print(widget.enrollee);
    _initialise();
  }

  Map genderMap = {"f": "Female", "m": "Male"};

  @override
  Widget build(BuildContext context) {
    log("Enrolle ID: ${_state?.user.enrolleeId}");
    return AVScaffold(
      title: profile == null
          ? "Avon Healthcare Card"
          : "${profile!['personalDetail']['surname']}",
      showAppBar: true,
      decoration: BoxDecoration(color: Colors.white),
      child: Container(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                (kToolbarHeight + MediaQuery.of(context).padding.top)),
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: isLoading
              ? Center(
                  child: AVLoader(
                  color: AVColors.primary,
                ))
              : profile == null
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      child: EmptyContent(text: "Unable to load your e-card"))
                  : ListView(
                      children: [
                        Text("Avon ID",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                        SizedBox(height: 15),
                        _buildCard(), // build card
                        SizedBox(height: 40),
                        Text(
                          "Primary Provider",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        imageTextArrowBtn(
                            image: "assets/images/Group 31176.png",
                            title:
                                "${profile!['providerInfo']['providerName'] ?? ''}",
                            content:
                                "${profile!['providerInfo']['providerAddress'] ?? ''}"),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Status",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            if (profile!['isActive'])
                              Row(
                                children: [
                                  Text("Active",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black)),
                                  Icon(Icons.check_circle_outline,
                                      color: Colors.green, size: 20)
                                ],
                              )
                            else
                              Row(
                                children: [
                                  Text("Not Active ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)),
                                  Icon(Icons.error, color: Colors.red, size: 20)
                                ],
                              )
                          ],
                        ),
                        const SizedBox(height: 10),
                        activeStatus(
                            head: "Plan Type",
                            value:
                                "${profile!['planDetail']['planName'] ?? ''}"),
                        // activeStatus(head: "Phone number", value: "${_state?.user.mobilePhone}"),
                        activeStatus(
                            head: "Email address ",
                            value:
                                "${profile!['contactDetail']['email'] ?? ''}"),
                        activeStatus(
                            head: "Gender",
                            value:
                                "${(genderMap[profile!['personalDetail']['gender']]) ?? ''}"),
                        const SizedBox(height: 100),
                      ],
                    ),
        ),
      ),
    );
  }

  _initialise() async {
    try {
      // String endpoint = "enrollee/info/${_state?.user.memberNo}";
      String endpoint = "get-new-card-memberno/${widget.enrollee?.memberNo}";
      print("Enrolle ID: ${_state?.user.enrolleeId}");
      if (widget.isDependant) {
        endpoint =
            // "dependant/details?dependantId=${widget.enrollee?.dependantId}&memberNo=${widget.enrollee?.memberNo}";
            // "dependant/details?memberNo=${widget.enrollee?.memberNo}";
        "get-new-card-memberno/${widget.enrollee?.memberNo}";
      }
      print(endpoint);
      http.Response response = await HttpServices.get(context, endpoint);
      if (response.statusCode != 200) throw ("Request not successful");
      var body = jsonDecode(response.body);
      print("The new card: $body");
      if (body['hasError']) throw ("Request not successful");
      profile = body['data'];
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  Widget imageTextArrowBtn(
          {required String image,
          required String title,
          required String content,
          Color? color,
          Widget? imageWidget,
          List<Widget>? actions}) =>
      GestureDetector(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
          child: Row(
            children: [
              imageWidget ??
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(image), fit: BoxFit.fill),
                        shape: BoxShape.circle),
                  ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 3),
                    Text(content,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300)),
                  ],
                ),
              ),
              // IconButton(
              //   onPressed: (){},
              //   icon: Icon( Icons.arrow_right_outlined,
              //     color: Color(0xff631293),
              //     size: 30,),
              // )
            ],
          ),
          decoration: BoxDecoration(color: color ?? Colors.white),
        ),
        onTap: () {
          if (content.isEmpty) return;

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MapView(address: content)));
        },
      );

  Widget _buildCard() {
    print("profile: ${profile!['personalDetail']}");
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 100,
                    child: Text("Avon Healthcare Card".toUpperCase(),
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff631293)))),
                Image.asset(
                  AVImages.avonHmoPurpleLogo,
                  width: MediaQuery.of(context).size.width * 0.2,
                )
              ]),
          SizedBox(height: 10),
          Divider(
            height: 1,
            thickness: 1.5,
            color: Colors.white,
          ),
          SizedBox(height: 10),
          headBodyText(head: "Member No", body: "${profile!['memberNumber']}"),
          SizedBox(height: 15),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  child: headBodyText(
                      head: "First Name",
                      body:
                          "${profile!['personalDetail']['firstName'] ?? ''}")),
              Padding(padding: EdgeInsets.only(right: 0)),
              Flexible(
                  child: headBodyText(
                      head: "Last Name",
                      body: "${profile!['personalDetail']['surname'] ?? ''}")),
            ],
          ),
          SizedBox(height: 20),
          headBodyText(
              head: "Sex",
              body:
                  "${(genderMap[profile!['personalDetail']['gender']]) ?? ''}"),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headBodyText(
                      head: "Company", body: "${profile!['clientName']}"),
                  const SizedBox(height: 15),
                  headBodyText(
                      head: "Plan Type",
                      body: "${profile!['planDetail']['planName'] ?? ''}"),
                ],
              )),
              Container(
                height: 120,
                width: 120,
                padding: const EdgeInsets.all(5),
                child: Image.network(
                  "${profile!['personalDetail']['imageUrl']}",
                  // "${_state?.plan?.imageUrl}",
                  fit: BoxFit.fill,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        width: 1.5, color: AVColors.primary.withOpacity(0.1))),
              )
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
          color: Color(0xffF6EBFD), borderRadius: BorderRadius.circular(3)),
    );
  }

  Widget headBodyText({
    required String head,
    required String body,
  }) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            head,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Flexible(
                child: Text(
                  body,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
        ],
      );

  Widget activeStatus({required String head, required String value}) =>
      Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              head,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 20)),
            Expanded(
                child: Text(
              value,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.right,
              softWrap: true,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ))
          ],
        ),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.black26, width: 1))),
      );
}
