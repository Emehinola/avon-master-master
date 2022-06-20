import 'package:avon/utils/services/load_more.dart';
import 'package:avon/widgets/empty_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class Photos extends StatefulWidget {
  String code;
  Photos({Key? key, required this.code}) : super(key: key);

  @override
  _PhotosState createState() => _PhotosState();
}

class _PhotosState extends State<Photos> with AutomaticKeepAliveClientMixin<Photos> {

  @override
  bool get wantKeepAlive => true;

  LoadMoreService? _loadmore;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadmore = Provider.of<LoadMoreService>(context, listen: false);

    _getRequests();
  }

  @override
  Widget build(BuildContext context) {
    if(_loadmore!.isLoading) return _buildLoader();

    if(_loadmore?.content.length == 0) return EmptyContent(text: "No Photos");

    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10
        ),
        itemCount: _loadmore?.content.length ?? 0,
        itemBuilder: (BuildContext context, int index){
          Map data = _loadmore?.content[index];
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(data['image'] ?? ''),
                    fit: BoxFit.cover
                ),
                shape: BoxShape.rectangle),
          );
        }
    );
  }

  loadmore()async {
    if(_loadmore!.isCompleted) return;
    _loadmore?.currentPage +=1;
    await _loadmore?.getData(context,
        url: "explore/hospital/image/${widget.code}?PageNumber=${_loadmore?.currentPage}&PageSize=10");
    setState(() {});
  }

  _getRequests()async {
    // _loadmore?.flush();
    _loadmore?.initialise("explore/hospital/image/${widget.code}?PageNumber=${_loadmore?.currentPage}&PageSize=10");
    await _loadmore?.getData(context);
    setState(() {});
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
            children: List.generate(5, (index) => Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5)
              ),
              height: 50,
            ))
        )
    );
  }

}