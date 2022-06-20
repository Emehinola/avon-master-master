import 'package:avon/models/refill_request.dart';
import 'package:avon/screens/enrollee/personal_health/drug_refill/drug_refill_step_1.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/utils/services/load_more.dart';
import 'package:avon/widgets/design/diseases/drug_refill.dart';
import 'package:avon/widgets/empty_content.dart';
import 'package:avon/widgets/refresh_loadmore.dart';
import 'package:avon/widgets/skeleton-card.dart';
import 'package:http/http.dart' as http;
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrugRequestHistoryScreen extends StatefulWidget {
  const DrugRequestHistoryScreen({Key? key}) : super(key: key);

  @override
  State<DrugRequestHistoryScreen> createState() => _DrugRequestHistoryScreenState();
}

class _DrugRequestHistoryScreenState extends State<DrugRequestHistoryScreen>  with SingleTickerProviderStateMixin{

  late TabController _controller;


  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);

  }


  @override
  Widget build(BuildContext context) {
    return AVScaffold(
      title: "Drug Refill",
      showAppBar: true,
      decoration: BoxDecoration(color: Colors.white),
      child:Container(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height
                - MediaQuery.of(context).padding.top - kToolbarHeight
        ),
        height: double.negativeInfinity,
        child: Stack(
          children: [
            Visibility(
              visible: true,
              child: Column(
                children: [

                  SizedBox(height: 10,),
                  TabBar(
                      controller: _controller,
                      indicatorColor: Color(0xff631293),
                      labelColor: Color(0xff631293),
                      unselectedLabelColor: Colors.black,
                      labelStyle: TextStyle(
                          fontSize: 16,
                          color: Color(0xff631293),
                          fontWeight: FontWeight.w300),
                      indicatorWeight: 3,
                      tabs: [
                        SizedBox(height:30,child: Text("Open request")),
                        SizedBox(height:30,child: Text("Closed requests"))
                      ]),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
                      child: TabBarView(
                          controller: _controller,
                          children: [
                              DrugRequestHistory(
                                status: DrugRefillStatus.PENDING,
                              ),
                              DrugRequestHistory(
                                  status: DrugRefillStatus.REJECTED
                              ),
                          ]),
                    ),
                  )


                ],
              ),
              replacement: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/empty-contact-list.png"),
                  const SizedBox(height: 10,),
                  Text(
                    "No recent consultation history ",
                    style:  TextStyle(
                        fontSize: 16,
                        color: Colors.black45,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    width:200,
                    margin: EdgeInsets.only(top: 30),
                    child: AVTextButton(
                        radius: 5,
                        child: Text("Request refill", style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        )),
                        verticalPadding: 17,
                        // color: Colors.white,
                        // borderColor: Color(0xff631293),
                        callBack: _continue
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              right: 15,
              left: 15,
              child:   Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(bottom: 20),
                child: AVTextButton(
                    radius: 5,
                    child: Text("Request refill", style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                    )),
                    verticalPadding: 17,
                    // color: Colors.white,
                    // borderColor: Color(0xff631293),
                    callBack: _continue
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _continue(){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> DrugRefillScreen1()));
  }


}


class DrugRequestHistory extends StatefulWidget {
   DrugRefillStatus status;
   DrugRequestHistory({
     Key? key,
     required this.status
   }) : super(key: key);

  @override
  _DrugRequestHistoryState createState() => _DrugRequestHistoryState();
}

class _DrugRequestHistoryState extends State<DrugRequestHistory> {
  LoadMoreService _loadmore = LoadMoreService();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getRequests();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody(){
    if(_loadmore.isLoading) return _buildLoader();

    if(_loadmore.content.length == 0) return EmptyContent(text: "No request found");

    return AVRefresher(
        child: ListView.builder(
            itemCount: _loadmore.content.length,
            itemBuilder: (BuildContext context, int index){
              RefillRequest request = RefillRequest.fromJson(_loadmore.content[index]);
              return GestureDetector(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${request.firstName}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 8,),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w300),
                                    children: [
                                      TextSpan(
                                          text: "Status: "
                                      ),
                                      TextSpan(
                                          text: request.requestStatus.value,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: request.requestStatusColor,
                                              fontWeight: FontWeight.w300)
                                      ),

                                    ]
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      Center(
                        child: Icon(Icons.arrow_forward_ios,
                          size: 15, color: Colors.black54,),
                      )

                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.grey.withOpacity(0.2)
                          )
                      )
                  ),

                ),
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context)=> DrugRefillScreen1(request: request))
                  );
                },
              );
            }
        ),

        loadmore: loadmore,
        refreshController: _loadmore.refreshController
    );
  }

  loadmore()async {
    if(_loadmore.isCompleted) return;
    _loadmore.currentPage +=1;
    await _loadmore.getData(context,
        url: "enrollee/actions/drugrefill/loggedon-user/state/${widget.status.apiChar}?PageNumber=${_loadmore.currentPage}&PageSize=10");
    setState(() {

    });
  }

  _getRequests()async {
    _loadmore.initialise("enrollee/actions/drugrefill/loggedon-user/state/${widget.status.apiChar}?PageNumber=1&PageSize=10");
    await _loadmore.getData(context);
    setState(() {});
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
                    Flexible(child: Column(
                      children: [
                        Container(
                          color: Colors.white,
                          height: 10,
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 5)),
                        Container(
                          color: Colors.white,
                          height: 10,
                        )
                      ],
                    )),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      color: Colors.white,
                      height: 20,
                    )
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
