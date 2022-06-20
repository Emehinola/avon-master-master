import 'dart:convert';

import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/widgets/empty_content.dart';
import 'package:avon/widgets/loader.dart';
import 'package:http/http.dart' as http;
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationScreen> {

  bool isLoading = false;
  List data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
        title: "Notifications",
        showAppBar: true,
        decoration: BoxDecoration(
            color: Colors.white
        ),
        horizontalPadding: 0,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(isLoading)
                AVLoader(),
              if(!isLoading && data.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: EmptyContent(text: "No notification found"),
                  ),
                ),
              if(!isLoading)
                Expanded(
                    child: Container(
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, int index){
                          Map dt = data[index];
                          return _reportView(dt);
                        },
                      ),
                    )
                ),
            ],
          ),
        )
    );
  }

  Widget _reportView(Map dt){
    DateTime parseDate = DateTime.parse(dt['sentDate']);
    String date = "${parseDate.day}/${parseDate.month}/${parseDate.year}";

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dt['subject'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5,),
                  Text(dt['body'],
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w400)),
                  SizedBox(height: 5,),
                  Text(date,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            // Icon(
            //   Icons.chevron_right,
            //   color: Colors.grey,
            // )
          ],
        ),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Colors.black12,
                    width: 1
                )
            )
        )
    );
  }

  Widget _date({required String date})=>  Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 30, bottom: 10, left: 20, right: 20),
      color: Colors.grey.withOpacity(0.3),
      child: Text(date,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500)
      )
  );

  _getNotifications() async{
    if(isLoading) return ;

    setState(() {isLoading = true; });

    MainProvider state = Provider.of<MainProvider>(context, listen: false);
    http.Response response = await HttpServices.get(
        context, "notifications/84648");
        // "${state.user.memberNo}");

    if(response.statusCode == 200){
      var body = jsonDecode(response.body);
      setState(() {
        // data = body['data'];
      });
    }
    setState(() {isLoading = false; });
  }

}
