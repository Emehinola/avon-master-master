import 'dart:convert';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class ZendeskChatScreen extends StatefulWidget {

  ZendeskChatScreen({Key? key}) : super(key: key);

  @override
  _ZendeskChatScreenState createState() => _ZendeskChatScreenState();
}

class _ZendeskChatScreenState extends State<ZendeskChatScreen> {
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text("Chat With Us", style: TextStyle(
            color: Colors.black
          )),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: Image.asset(AVImages.avonHmoPurpleLogo, width: 100),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Text('Chat With Us'),
                Visibility(
                  visible: server_started,
                  child: InAppWebView(
                    key: webViewKey,
                    initialUrlRequest:
                    URLRequest(url: Uri.parse("http://localhost:8081/assets/web/htmls/chat.html")),
                    initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                            // set this to true if you are using window.open to open a new window with JavaScript
                            javaScriptCanOpenWindowsAutomatically: true,
                            javaScriptEnabled: true,
                          cacheEnabled: true
                        ),
                        android: AndroidInAppWebViewOptions(
                          // on Android you need to set supportMultipleWindows to true,
                          // otherwise the onCreateWindow event won't be called
                            supportMultipleWindows: true,

                        )
                    ),
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                      webViewController?.addJavaScriptHandler(handlerName: 'exit', callback: (args){
                        Navigator.pop(context);
                      });
                    },
                    onLoadStart: (controller, url) {

                    },
                    onLoadStop: (controller, url) async {
                      String data = jsonEncode({
                        "email":state?.user.email,
                        "fullname":"${state?.user.firstName} ${state?.user.lastName}",
                      });
                      // Future.delayed(Duration(seconds: 5), (){
                      webViewController?.evaluateJavascript(source: 'initialiseChat('+data+')');
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
