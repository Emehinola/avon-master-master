import 'dart:io';

import 'package:flutter/material.dart';

class AVScaffold extends StatelessWidget {
  final child;
  final bool showAppBar;
  bool? showBack = false;
  bool centerTitle = false;
  bool addTopPadding;
  double horizontalPadding;
  String? title;
  List<Widget>? actions;
  Function()? leadingCallBack;
  BoxDecoration? decoration;
  Widget? bottomNavigationBar;
  double appBarElevation;

  AVScaffold({
    Key? key,
    required this.child,
    this.horizontalPadding = 0,
    this.appBarElevation = 0,
    this.showAppBar = false,
    this.showBack = true,
    this.centerTitle = true,
    this.addTopPadding = true,
    this.title,
    this.actions,
    this.leadingCallBack,
    this.decoration,
    this.bottomNavigationBar
  }) : super(key: key){
    if(appBarElevation == 0){
      if(Platform.isAndroid) appBarElevation = 2;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: showAppBar == true?
      AppBar(
        leading: showBack! ? InkWell(
          child: Icon(Icons.arrow_back, color: Colors.black, size: 25,),
          onTap: (){
            if(leadingCallBack!= null){
              leadingCallBack!();
              return ;
            }
            Navigator.pop(context);
          },
        ): null,
        actions: actions ??[],
        centerTitle: centerTitle,
        title: Text(title!, style: TextStyle(color: Colors.black, fontSize: 17),),
        elevation: appBarElevation,
        backgroundColor: Colors.white,
      ) : null,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        margin: EdgeInsets.only(top: Platform.isAndroid && addTopPadding ? 10:0),
        decoration: decoration ?? null,
        child: SingleChildScrollView(
          child: child,
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
