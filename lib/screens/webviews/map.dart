import 'dart:convert';
import 'package:avon/models/hospital.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class MapView extends StatefulWidget {
  final Hospital? hospital;
  final String? address;

  MapView({Key? key, this.hospital, this.address}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  InAppWebViewController? webViewController;
  final GlobalKey webViewKey = GlobalKey();
  double progress = 0;
  InAppLocalhostServer localhostServer = new InAppLocalhostServer(port: 8081);
  bool server_started = false;
  MainProvider? state;

  void initState() {
    startServer();
  }

  @override
  Widget build(BuildContext context) {
    state = Provider.of<MainProvider>(context, listen: false);
    String address = widget.hospital?.name ?? widget.address ?? '';
    return Scaffold(
        appBar: AppBar(
          title: Text(address),
        ),
        body: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: Image.asset(AVImages.avonHmoPurpleLogo, width: 100),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Text('PAYMENTS'),
                Visibility(
                  visible: server_started,
                  child: InAppWebView(
                    key: webViewKey,
                    initialUrlRequest:
                    URLRequest(url: Uri.parse("http://localhost:8081/assets/web/htmls/map.html")),
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                    },
                    onLoadStart: (controller, url) {

                    },
                    onLoadStop: (controller, url) async {
                      String addr = address;
                      int indexOf = addr.lastIndexOf(".");

                      if(indexOf >= 0){
                        addr = addr.substring(0, indexOf);
                      }

                      // if(address.split(',').length > 4){
                      //   address = address.split(',').sublist(0,4).join(',');
                      // }

                      addr = addr.replaceAll("'", "");
                      print(addr);
                      webViewController?.evaluateJavascript(source: 'showLocation('+jsonEncode(addr)+')');
                    },
                    onLoadError: (controller, url, code, message) {
                      //pullToRefreshController.endRefreshing();
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      print(consoleMessage);
                    },
                    onProgressChanged: (controller, progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },

                  ),
                ),
                progress < 1.0
                    ? LinearProgressIndicator(
                  value: progress,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  backgroundColor: Colors.grey,
                )
                    : Container(),
              ],
            )
        )
    );
  }

  void startServer() async{
    await localhostServer.start();
    setState(() {
      server_started=true;
    });
    print('server started');
  }

  @override
  void dispose() {
    super.dispose();
    localhostServer.close();

  }
}
