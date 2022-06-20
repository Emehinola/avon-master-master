import 'dart:convert';
import 'package:avon/screens/explore/wellness/health_living2.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:http/http.dart' as http;
import 'package:avon/widgets/empty_content.dart';
import 'package:avon/widgets/refresh_loadmore.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class PressRoomScreen extends StatefulWidget {
  const PressRoomScreen({Key? key}) : super(key: key);

  @override
  State<PressRoomScreen> createState() => _WellnessLifeStyleState();
}

class _WellnessLifeStyleState extends State<PressRoomScreen> {
  late List<WellnessLifeStyleModel> model;
  bool isLoading = false;
  List contents = [];
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  int _currentPage = 1;
  bool isCompleted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getContents();
  }


  @override
  Widget build(BuildContext context) {
    return AVScaffold(
      title: "Press Room",
      showAppBar: true,
      decoration: BoxDecoration(
          color: Colors.white
      ),
      child: Container(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height
        ),
        height: double.negativeInfinity,
        margin: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),
            Expanded(child: AVRefresher(
              refreshController: _refreshController,
              child: _buildBody(),
              loadmore: _loadMore,
            ))
          ],
        ),

      ),
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
    http.Response response = await HttpServices.get(context, "categories?pageNumber=${_currentPage}&pageSize=10&postType=press", handleError: false);

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
      text: "No Lifestyle yet",
    );

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: 1.5,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children:List.generate(
          contents.length,
              (index){
            Map content = contents[index];
            return lifeStyle(
              head: content['name'],
              id: content['categoryId'],
              image: content['categoryThumb'],
            );
          }
      ),
    );
  }

  Widget _buildLoader(){
    return SkeletonLoader(
        builder: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 1.5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: List.generate(10, (index) => Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5)
              ),
              height: 50,
            ))
        )
    );
  }

  Widget lifeStyle({required String head, required String id, required String image})=>  InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> HealthLivingScreen(
          id: id,
          title: head,
      )));
    },
    child: Container(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Center(
              child: Text(
                head,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: Colors.white
                ),
              )
          )
        ],
      ),
      decoration: BoxDecoration( color: Colors.black12,
          image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle),
    ),
  );
}



class WellnessLifeStyleModel{

  final String image;
  final String head;


  WellnessLifeStyleModel({required this.image, required this.head});
}