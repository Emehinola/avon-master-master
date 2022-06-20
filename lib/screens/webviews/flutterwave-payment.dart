import 'dart:convert';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class FlutterWavePayment extends StatefulWidget {
  Map? data;

  FlutterWavePayment({Key? key, required this.data}) : super(key: key);

  @override
  _FlutterWavePaymentState createState() => _FlutterWavePaymentState();
}

class _FlutterWavePaymentState extends State<FlutterWavePayment> {
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

    return Scaffold(
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
                    URLRequest(url: Uri.parse("http://localhost:8081/assets/web/htmls/flutterwave.html")),
                    onWebViewCreated: (controller) {
                      webViewController = controller;

                      webViewController?.addJavaScriptHandler(handlerName: 'payment_response', callback: (args){
                        Map response = jsonDecode(args[0]);
                        Navigator.pop(context, response);
                        print(response);
                      });

                      webViewController?.addJavaScriptHandler(handlerName: 'exit', callback: (args){
                        Navigator.pop(context);
                      });
                    },
                    onLoadStart: (controller, url) {

                    },
                    onLoadStop: (controller, url) async {
                      String data = jsonEncode(widget.data);
                      // Future.delayed(Duration(seconds: 5), (){
                        webViewController?.evaluateJavascript(source: 'initialiseFlutterWave('+data+')');
                      // });
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
