import 'dart:convert';

import 'package:avon/utils/services/http-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LoadMoreService extends ChangeNotifier{
  int currentPage = 1;
  String endpoint = "";
  bool _isLoading = false;
  bool isCompleted = false;
  List _content = [];
  var _refreshController = new RefreshController();
  StateSetter? setState;

  RefreshController get refreshController => _refreshController;

  bool get isLoading => _isLoading;
  set isLoading(bool v){
    _isLoading = v;
    // notifyListeners();
  }

  List get content=> _content;
  set content(List data){
    _content = data;
    print("drug refill: $_content");
    // notifyListeners();
  }

  void initialise(String url){
    content = [];
    currentPage = 1;
    endpoint = url;
  }

  void flush(){
    content = [];
    currentPage = 1;
  }

  Future loadMore(BuildContext context, {
    String? url
  })async {
    currentPage = currentPage + 1;
    endpoint = "$url&PageNumber=$currentPage&PageSize=10";

    print(">>>$endpoint");
    return getData(context, url: endpoint);
  }

  Future<void> getData(BuildContext context, {String? url})async {

    if(url != null){
      endpoint = url;
    }

    if(currentPage == 1){
      isLoading = true;
    }

    isCompleted = false;
    http.Response response = await HttpServices.get(context, endpoint, handleError: false);

    if(response.statusCode == 200){
      List data = jsonDecode(response.body)['data'];
      print(data.length);
      content = [...content, ...data];


      if(data.length < 5){
        isCompleted = true;
        _refreshController.loadNoData();
      }

      _refreshController.loadComplete();
    }else{
      _refreshController.loadFailed();
    }

    isLoading = false;

  }

}