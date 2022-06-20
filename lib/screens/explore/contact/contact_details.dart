import 'dart:convert';
import 'dart:ui';

import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/constants/zen_desk.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/utils/services/validation-service.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zendesk_plugin/zendesk_plugin.dart';

class ContactDetailsScreen extends StatefulWidget {
  const ContactDetailsScreen({Key? key}) : super(key: key);

  @override
  _ContactDetailsScreenState createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextStyle header = TextStyle(fontSize: 19, fontWeight: FontWeight.w700);
  TextStyle normalTextStyle =
      TextStyle(fontSize: 16, color: Colors.black, height: 1.5, fontWeight:FontWeight.w700);
  TextStyle urlTextStyle =
      TextStyle(fontSize: 16, color: Colors.blue, height: 1.5);

  @override
  Widget build(BuildContext context) {
    var avonnos = Text('0700-277-9800', style: TextStyle(color: Colors.blue));
    Widget avno(String text) {
      return GestureDetector(
          child: Text(text, style: TextStyle(color: Colors.blue)));
    }

    TableRow _tableSpace = TableRow(children: [
      TableCell(child: SizedBox(height: 15)),
      TableCell(child: Container()),
      TableCell(child: Container())
    ]);

    return AVScaffold(
        showAppBar: true,
        title: "Contact Details",
        decoration: BoxDecoration(color: Colors.white),
        child: Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).padding.top + kToolbarHeight)),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text("Office Address", style: header),
                  SizedBox(height: 5),

                  Text(
                      "Lagos (Head Office): 2nd Floor, Afriland Towers, 97/101 Broad Street, Lagos Island, Lagos.",
                      style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Abuja: Hajjar's Place, Plot 1349, Ahmadu Bello way, Garki II, FCT, Abuja.",
                      style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Port Harcourt: UBA Building, 94 Trans Amadi Road, Trans-Amadi Industrial Layout, Portharcourt.",
                      style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Enugu: UBA Building, 53 Okpara Avenue, Enugu, Enugu State.",
                      style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: 30),
                  Text("Call", style: header),
                  SizedBox(height: 5),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Want to speak to us? ",
                          style: normalTextStyle, ),
                      TextSpan(
                          text:
                              " Kindly call our 24/7 Contact Centre today on ${avonnos.data} and one of our representatives will be on hand to assist you.",
                          style: normalTextStyle),
                    ]),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Text("General Enquiries: ",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                      GestureDetector(
                        onTap: () {
                          _launchURL('mailto:info@avonhealthcare.com');
                        },
                        child: Text("info@avonhealthcare.com",
                            style: TextStyle(fontSize: 15, color: Colors.blue)),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Member request: ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                      Expanded(child: GestureDetector(
                          onTap: () {
                            _launchURL(
                                'https://www.callcentre@avonhealthcare.com');
                          },
                          child: Text("callcentre@avonhealthcare.com",
                              style: TextStyle(fontSize: 15, color: Colors.blue))
                      )),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text("Social", style: header),
                  SizedBox(height: 15),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Row(children: [
                            Image.asset("assets/images/linkedin.png",
                                width: 20, height: 20),
                            Padding(padding: EdgeInsets.only(right: 20)),
                            Text("Linkedin",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700)),
                          ]),
                          onTap: () {
                            _launchURL(
                                "https://www.linkedin.com/company/avonhmo/");
                          },
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          child: Row(children: [
                            Image.asset(
                              "assets/images/twitter.png",
                            ),
                            Padding(padding: EdgeInsets.only(right: 10)),
                            Text("Twitter",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700)),
                          ]),
                          onTap: () {
                            _launchURL("http://twitter.com/avonhmo");
                          },
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          child: Row(children: [
                            Image.asset(
                              "assets/images/facebook.png",
                            ),
                            Padding(padding: EdgeInsets.only(right: 10)),
                            Text("Facebook",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700)),
                          ]),
                          onTap: () {
                            _launchURL("http://facebook.com/avonhmo");
                          },
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          child: Row(children: [
                            Image.asset(
                              "assets/images/instagram.png",
                            ),
                            Padding(padding: EdgeInsets.only(right: 15)),
                            Text("Instagram",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700)),
                          ]),
                          onTap: () {
                            _launchURL("http://instagram.com/avonhmo");
                          },
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          child: Row(children: [
                            Image.asset(
                              "assets/images/youutube.png",
                              height: 30,
                              width: 30,
                            ),
                            Padding(padding: EdgeInsets.only(right: 15)),
                            Text("Youtube",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700)),
                          ]),
                          onTap: () {
                            _launchURL("http://youtube.com/avonhmo");
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            )));
  }

  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
