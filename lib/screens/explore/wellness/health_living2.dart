import 'dart:async';
import 'dart:convert';
import 'package:avon/screens/explore/wellness/view_post.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/utils/services/validation-service.dart';
import 'package:avon/widgets/forms/dropdown_input.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/refresh_loadmore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/widgets/skeleton-card.dart';
import 'package:http/http.dart' as http;
import 'package:avon/widgets/empty_content.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HealthLivingScreen extends StatefulWidget {
  String id;
  String? title;
  String? thumbNail;
  bool isVideo;

  HealthLivingScreen({Key? key,
    required this.id,
    required this.title,
    this.thumbNail,
    this.isVideo=false
  }) : super(key: key);

  @override
  _HealthLivingScreenState createState() => _HealthLivingScreenState();
}

class _HealthLivingScreenState extends State<HealthLivingScreen> {
  int _currentPage =1;
  TextEditingController _searchController = new TextEditingController();
  bool isLoading = false;
  BuildContext? dialogContext;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  Map? selectedPost;
  List contents = [];
  Timer? timer;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool isCompleted = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getPlans(
        endpoint: "posts/category/${widget.id}?PageNumber=${_currentPage}&PageSize=10"
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            Navigator.pop(context);
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.black,
          ),
        ) ,
        title: Text(
          "${widget.title}",
          style: TextStyle(fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - (
            kToolbarHeight + (MediaQuery.of(context).padding.top)
          )
        ),
        margin: const EdgeInsets.only(left: 17.0, right: 17.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    child: AVInputField(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      controller: _searchController,
                      hintText: "Try typing “something”",
                      onChange: (String? v){
                        handleOnChange();
                      },
                    )
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                child: _buildPost()
            )
          ],
        ),
      ),
    );
  }
  _buildPost(){
    if(isLoading) return _buildLoader();
    if(contents.length < 1) return EmptyContent(
      text: "No contents yet",
    );
    return AVRefresher(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index){
          Map post = contents[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            padding: const EdgeInsets.symmetric( vertical: 10),
            child: wellList(context, post),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: Colors.grey.withOpacity(0.3)
                    )
                )
            ),
          );
        },
        itemCount: contents.length,
      ),
      loadmore: _loadMore,
      refreshController: _refreshController,
    );
  }

  Widget healthModal()=>IntrinsicHeight(
    child: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState){
        return Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Enter details",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 1.2
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          print(dialogContext);
                          if(dialogContext != null){
                            Navigator.pop(dialogContext!);
                          }
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Align(
                    child: Text(
                      "Provide details to continue",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          height: 1.2
                      ),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(height: 10,),
                  AVInputField(
                    label: "Full Name",
                    height: 55,
                    labelText: "Ayomide ",
                    controller: _nameController,
                    validator: (String? v) => ValidationService.isValidInput(v!, minLength: 2),
                  ),
                  AVInputField(
                    label: "Email",
                    height: 55,
                    labelText: "Ayomide@gmail.com",
                    controller: _emailController,
                    validator: (String? v) => ValidationService.isValidEmail(v!)
                  ),
                  AVInputField(
                    height: 55,
                    label: "Phone Number",
                    labelText: "07023*****",
                    controller: _phoneNumberController,
                    validator: (String? v) => ValidationService.isValidPhoneNumber(v!),
                    inputType: TextInputType.number,
                  ),

                  Container(
                      width: 200,
                      height: 50,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: AVTextButton(
                        radius: 5,
                        child: Text('Continue', style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        )),
                        disabled: isLoading,
                        showLoader: isLoading,
                        verticalPadding: 17,
                        callBack: (){
                          submit();
                          setState((){});
                        },
                      )
                  )
                ],
              ),
            ),
          ),
        );
      },
    ),
  );

  Widget wellList(BuildContext ctx, Map data)=>Container(

    height: 90,
    margin: EdgeInsets.symmetric(vertical: 10),
    child: InkWell(
      onTap: (){
        selectedPost = data;
        _checkDialog(ctx);
      },
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("${data['featuredImage'] ?? widget.thumbNail}"),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
                color: Colors.black
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
                  "${data['postTitle']}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff631293),
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 3,),
                Text(
                    "${data['postExcerpt']}",
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 3)
              ],
            ),
          )

        ],

      ),
    ),

  );

  _checkDialog(BuildContext context)async {
    MainProvider state = Provider.of<MainProvider>(context, listen: false);
    bool? hasOpenedPost = await GeneralService().getBoolPref('has_opened_post');
    String? hasGuestData = await GeneralService().getStringPref('guest');

    if(!state.isLoggedIn && hasOpenedPost != null){
      if(hasOpenedPost && hasGuestData == null){
        _showRegModal();
        return;
      }
    }
    _openPost();
  }

  _showRegModal(){

    showDialog(context: context,
        builder: (builder){
          dialogContext = context;
        return AlertDialog(
              content: healthModal(),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))
              )
          );
      }
    );
  }

  Future submit()async {
    if (!_formKey.currentState!.validate()) return;

    Map data = {
      "email":  _emailController.text,
      "name":  _nameController.text,
      "phone":  _phoneNumberController.text,
    };

    GeneralService().setStringPref("guest", jsonEncode(data));
    Navigator.of(dialogContext!).pop;
    _openPost();
  }

  _openPost(){
    GeneralService().setBoolPref("has_opened_post", true);
    Navigator.push(context, MaterialPageRoute(builder:
    (BuildContext context)=> ViewPostScreen(post: selectedPost!, isVideo: widget.isVideo,)));
  }


  _loadMore() async {
    print("onLoadMore");

    if(isCompleted){
      _refreshController.loadNoData();
      return;
    }
    _currentPage +=1;
    _getPlans(endpoint: "posts/category/${widget.id}?searchTerm=${_searchController.text}&PageNumber=${_currentPage}&PageSize=10");
  }

  handleOnChange(){
    if(timer != null) timer?.cancel();
    timer = Timer(Duration(milliseconds: 800), search);
  }

  search()async {
    setState(() { contents = []; _currentPage = 1;});
    _getPlans(endpoint: "posts/category/${widget.id}?searchTerm=${_searchController.text}&PageNumber=${_currentPage}&PageSize=10");
  }

  _getPlans({required String endpoint})async {
    if(_currentPage == 1){
      setState(() { isLoading = true; });
    }

    print("loading mroe");
    isCompleted = false;
    http.Response response = await HttpServices.get(context, endpoint, handleError: false);

    print(response.statusCode);
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

  Widget _buildLoader(){
    return ListView.builder(itemBuilder: (
            (BuildContext context, int index)=> Padding(
          padding: const EdgeInsets.only(top: 15),
          child: SkeletonBlock(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                    ),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Flexible(child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.white,
                          height: 10,
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Container(
                          color: Colors.white,
                          height: 10,
                        ),
                      ],
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
