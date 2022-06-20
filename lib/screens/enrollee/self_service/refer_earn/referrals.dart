import 'dart:convert';

import 'package:avon/screens/enrollee/self_service/refer_earn/share.dart';
import 'package:avon/screens/explore/wellness/health_living2.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/widgets/empty_content.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/refresh_loadmore.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:avon/widgets/skeleton-card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;

class ReferralsScreen extends StatefulWidget {
  const ReferralsScreen({Key? key}) : super(key: key);

  @override
  _ReferralsScreenState createState() => _ReferralsScreenState();
}

class _ReferralsScreenState extends State<ReferralsScreen> {
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
        title: "Referrals",
        decoration: BoxDecoration(
            color: Colors.white
        ),
        child: Container(
          height: MediaQuery.of(context).size.height - (
              MediaQuery.of(context).padding.top
          ),
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: _buildBody(),
              ),
              Positioned(
                bottom: 0,
                right: 15,
                left: 15,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  padding: EdgeInsets.only(bottom: kToolbarHeight + 30),
                  child: AVTextButton(
                      radius: 5,
                      child: Text("Invite friends", style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                      )),
                      verticalPadding: 17,
                      callBack: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>InviteFriendScreen()))
                        .then((value){
                          if(value != null){
                            contents = [];
                            _currentPage = 1;
                            _getContents();
                          }
                        });
                      }
                  ),
                ),
              )
            ]
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

    MainProvider state = Provider.of<MainProvider>(context, listen: false);
    isCompleted = false;
    http.Response response = await HttpServices.get(context, "referrals/${state.user.enrolleeId}", handleError: false);

    if(response.statusCode == 200){
      List data = jsonDecode(response.body)['data'];
      print(data);
      setState(() { contents = [...contents, ...data]; });

      // if(data.length < 10){
      //   isCompleted = true;
        // _refreshController.loadNoData();
      // }

      // _refreshController.loadComplete();
    }else{
      // _refreshController.loadFailed();
    }


    setState(() {
      isLoading = false;
    });
  }

  Widget _buildBody(){
    if(isLoading) return _buildLoader();
    if(contents.length < 1) return Container(
      child: EmptyContent(
        text: "No referrals yet",
      ),
      width: MediaQuery.of(context).size.width,
    );
    return Column(
      children: [
        Expanded(
            child: AVRefresher(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index){
                  Map referral = contents[index];
                  return _buildVideo(referral);
                },
                itemCount: contents.length,
              ),
              isCompleted: isCompleted,
              refresh: (){
                contents = [];
                _getContents();
              },
              refreshController: _refreshController,
            )
        )
      ],
    );
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

  Widget _buildVideo(Map referral){
    String date = GeneralService().processDateTime(referral['refer_date']);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            alignment: Alignment.center,
            height: 55,
            width: 55,
            child: Text('R', style: TextStyle(
                color: Colors.white
            )),
            decoration: BoxDecoration(
              color: AVColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
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
                  "${referral['friendPhone']}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 5),
                Text(
                  "$date",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300),
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}
