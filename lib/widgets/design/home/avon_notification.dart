import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:avon/utils/services/http-service.dart';
import 'package:provider/provider.dart';
import 'package:avon/screens/auth/login.dart';
import 'package:avon/state/main-provider.dart';

class AvonNotification extends StatefulWidget {
  AvonNotification({Key? key}) : super(key: key);

  @override
  State<AvonNotification> createState() => _AvonNotificationState();
}

class _AvonNotificationState extends State<AvonNotification> {
  int notiCount = 2;
  dynamic datas;
  dynamic msgbody;
  dynamic altdata;

  Future Testnofification() async {
    http.Response response = await HttpServices.get(
      context,
      'notifications/${state!.user.enrolleeId}',
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      // setState(() {
      //   datas = data;
      //   altdata = data['data'][1]['body'];
      // });
      print('data below');
      print(altdata);
    } else {
      print('Errors');
    }
  }

  MainProvider? state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    state = Provider.of<MainProvider>(context, listen: false);
    Testnofification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              //Testnofification();

              Navigator.pop(context);
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: Icon(
              Icons.arrow_back,
              size: 25,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Notifications",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height-600,
                width: MediaQuery.of(context).size.width-30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),

                  color: Colors.white,

                ),

                child: Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  Text(
                    altdata ?? 'Loading', style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    ) ,
                )
                ),
              ),
            
          ],
        )
        );
  }
}
