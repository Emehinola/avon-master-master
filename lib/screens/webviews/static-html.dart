import 'dart:convert';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/image_assets.dart';
import 'package:avon/widgets/loader.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';


class StaticHtmlScreen extends StatefulWidget {
  String path;
  String title;
  bool isWeb;
  Widget? child;
  StaticHtmlScreen({Key? key, required this.path, this.child, required this.title, this.isWeb = false}) : super(key: key);

  @override
  _StaticHtmlScreenState createState() => _StaticHtmlScreenState();
}

class _StaticHtmlScreenState extends State<StaticHtmlScreen> {
  InAppWebViewController? webViewController;
  InAppLocalhostServer localhostServer = new InAppLocalhostServer(port: 8081);
  bool server_started = false;
  bool isLoading = false;
  bool pageLoaded = false;
  final GlobalKey webViewKey = GlobalKey();

  void initState() {
    if(!widget.isWeb){
      startServer();
    }
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {

    return AVScaffold(
        title: '${widget.title}',
        appBarElevation:2,
        showAppBar: true,
        child: Container(
          child: Stack(
            children: [
              InAppWebView(
                key: webViewKey,
                initialUrlRequest: widget.isWeb ? URLRequest(url: Uri.parse("${widget.path}")):
                URLRequest(url: Uri.parse("http://localhost:8081/${widget.path}")),
                gestureRecognizers: Set()..add(Factory<VerticalDragGestureRecognizer>(
                    ()=> VerticalDragGestureRecognizer()
                )),
                onLoadStop: (controller, url){
                  setState(() {
                    isLoading = false;
                  });
                },
                onConsoleMessage: (c, message){
                  print("message=>> ${message}");
                },
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      useShouldOverrideUrlLoading: true,
                      mediaPlaybackRequiresUserGesture: false,
                      javaScriptEnabled: true,
                      javaScriptCanOpenWindowsAutomatically: true,
                      useOnDownloadStart: true,
                    ),
                    android: AndroidInAppWebViewOptions(
                      useHybridComposition: true,
                    ),
                    ios: IOSInAppWebViewOptions(
                      allowsInlineMediaPlayback: true,
                    )
                ),
                shouldOverrideUrlLoading: (controller, shouldOverrideUrlLoadingRequest) async {
                  var url = shouldOverrideUrlLoadingRequest.request.url;
                  if(url.toString().contains('mailto') || url.toString().contains("tel")){
                    launch(url.toString());
                    return NavigationActionPolicy.CANCEL;
                  }
                  return NavigationActionPolicy.ALLOW;
                },
              ),
              if(isLoading)
                Center(
                  child: AVLoader(),
                ),

              if(widget.child != null)
                widget.child!
            ],
          ),
          height: MediaQuery.of(context).size.height - (kToolbarHeight + MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom),
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

