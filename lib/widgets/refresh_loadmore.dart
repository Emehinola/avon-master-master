import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AVRefresher extends StatefulWidget {
  Function()? loadmore;
  Function()? refresh;
  RefreshController refreshController;
  Widget child;
  bool isCompleted;
  AVRefresher({Key? key,
    required this.child,
    this.loadmore,
    this.refresh,
    this.isCompleted = false,
    required this.refreshController
  }) : super(key: key);

  @override
  _AVRefresherState createState() => _AVRefresherState();
}

class _AVRefresherState extends State<AVRefresher> {


  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        enablePullUp: !widget.isCompleted,
        enablePullDown: widget.refresh != null,
        controller: widget.refreshController,
        child: widget.child,
        onLoading: widget.loadmore,
        onRefresh: widget.refresh,
    );
  }
}
