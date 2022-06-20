import 'package:avon/utils/services/load_more.dart';
import 'package:avon/widgets/empty_content.dart';
import 'package:avon/widgets/skeleton-card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class Rates extends StatefulWidget {
  String code;
  Rates({Key? key, required this.code}) : super(key: key);

  @override
  _RatesState createState() => _RatesState();
}

class _RatesState extends State<Rates> {
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

    if(_loadmore?.content.length == 0) return EmptyContent(text: "No Rates");

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Rate and Review",
          style: TextStyle(
              color: Color(0xff2E2E2E),
              fontSize: 16,
              fontWeight: FontWeight.w700
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Share your experience to help others",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              height: 1.2
          ),
        ),
        const SizedBox(height: 20),
        Flexible(
            child: ListView.builder(
                itemCount: _loadmore?.content.length ?? 0,
                itemBuilder: (BuildContext context, int index){
                  Map data = _loadmore?.content[index];
                  return Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/design_image/hospital.png"),
                                        fit: BoxFit.fill),
                                    shape: BoxShape.circle),
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
                                      "Janet Iweala",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(height: 4,),
                                    Text("Product Designer",
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300)),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RatingBarIndicator(
                                itemCount: 5,
                                itemSize: 20,
                                rating: 3,
                                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                                unratedColor: Colors.black.withOpacity(0.5),
                                itemBuilder:(context,index)=>Icon(
                                  Icons.star_border_outlined,
                                  color: Colors.amber,
                                ),),
                              const SizedBox(height: 5,),
                              Text("3 Months ago")
                            ],
                          ),

                          const SizedBox(height: 10,),
                          Text(
                            "You can find a list of various hospitals where Avon health is accepted",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                height: 1.3
                            ),
                          ),
                          const SizedBox(height: 7,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              InkWell(
                                onTap: (){},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.thumb_up_alt_outlined,size: 20,),
                                    SizedBox(width:5,),
                                    Text("4", style: TextStyle(
                                        fontSize: 16
                                    ),),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),
                              InkWell(
                                child: Icon(
                                  Icons.share_outlined,
                                  size: 20,
                                ),
                              )

                            ],
                          )

                        ],
                      ),
                  );
                }
            )
        ),
        const SizedBox(height: 20),
      ],
    );
  }


  loadmore()async {
    if(_loadmore!.isCompleted) return;
    _loadmore?.currentPage +=1;
    await _loadmore?.getData(context,
        url: "explore/hospital/image/${widget.code}?PageNumber=${_loadmore?.currentPage}&PageSize=10");
    setState(() {

    });
  }

  _getRequests()async {
    _loadmore?.flush();
    _loadmore?.initialise("explore/hospital-review/image/${widget.code}?PageNumber=${_loadmore?.currentPage}&PageSize=10");
    await _loadmore?.getData(context);
    setState(() {});
  }

  Widget _buildLoader(){
    return ListView.builder(itemBuilder: (
            (BuildContext context, int index)=> Padding(
          padding: const EdgeInsets.only(top: 15),
          child: SkeletonBlock(
              height: 120,
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
}