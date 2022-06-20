import 'dart:convert';

import 'package:avon/screens/explore/wellness/health_living2.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/widgets/empty_content.dart';
import 'package:avon/widgets/refresh_loadmore.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:avon/widgets/skeleton-card.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;

class WatchVideosScreen extends StatefulWidget {
  const WatchVideosScreen({Key? key}) : super(key: key);

  @override
  _WatchVideosScreenState createState() => _WatchVideosScreenState();
}

class _WatchVideosScreenState extends State<WatchVideosScreen> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  int _currentPage = 1;
  bool isCompleted = false;
  bool isLoading = false;
  List contents = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getContents();
  }

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
        showAppBar: true,
        title: "Videos",
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - (
              MediaQuery.of(context).padding.top + kToolbarHeight
            )
          ),
          height: double.negativeInfinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: _buildBody(),
          ),
        )
    );
  }

  _loadMore()async {
    _currentPage +=1;
    _getContents();
  }

  _getContents()async {
    if(_currentPage == 1){
      setState(() { isLoading = true; });
    }

    isCompleted = false;
    http.Response response = await HttpServices.get(context, "categories?pageNumber=${_currentPage}&pageSize=10&postType=video", handleError: false);

    if(response.statusCode == 200){
      List data = jsonDecode(response.body)['data'];
      setState(() { contents = [...contents, ...data]; });

      if(data.length < 10){
        isCompleted = true;
        _refreshController.loadNoData();
      }

      _refreshController.loadComplete();
    }else{
      _refreshController.loadFailed();
    }


    setState(() {
      isLoading = false;
    });
  }

  Widget _buildBody(){
    if(isLoading) return _buildLoader();
    if(contents.length < 1) return EmptyContent(
      text: "No Videos yet",
    );

    return AVRefresher(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index){
          Map video = contents[index];
          return _buildVideo(video);
        },
        itemCount: contents.length,
      ),
      isCompleted: isCompleted,
      loadmore: _loadMore,
      refreshController: _refreshController,
    );;
  }

  Widget _buildLoader(){
    return ListView.builder(itemBuilder: (
            (BuildContext context, int index)=> Padding(
          padding: const EdgeInsets.only(top: 15),
          child: SkeletonBlock(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                    ),
                    Flexible(child: Container(
                      color: Colors.white,
                      height: 20,
                    ))
                  ],
                ),
              ),
              width: MediaQuery.of(context).size.width
          ),
        )
    ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
    );
  }

  Widget _buildVideo(Map video)=>InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder:
          (BuildContext context)=> HealthLivingScreen(
            id: video['categoryId'],
            title: video['name'],
            thumbNail: video['categoryThumb'],
            isVideo: true,
          )));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical:10.0,),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            alignment: Alignment.center,
            height: 100,
            width: 120,
            child: Container(
              child: IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.play_arrow,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black38
              ),
            ),
            decoration: BoxDecoration( color: Colors.black12,
                image: DecorationImage(
                    image: NetworkImage(video['categoryThumb']),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${video['name']}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 3,),
                Text("Avon HMo",
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff718096),
                        fontWeight: FontWeight.w300)),
                SizedBox(height: 3,),
                // Text("200 views - 2 days ago",
                //     maxLines: 2,
                //     style: TextStyle(
                //         fontSize: 15,
                //         color: Color(0xff718096),
                //         fontWeight: FontWeight.w300)),
              ],
            ),
          )

        ],
      ),
    ),
  );
}
