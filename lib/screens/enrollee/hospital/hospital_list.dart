import 'dart:async';
import 'dart:convert';
import 'package:avon/screens/enrollee/hospital/view_hospital.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/utils/services/load_more.dart';
import 'package:avon/widgets/forms/dropdown_input.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/refresh_loadmore.dart';
import 'package:avon/screens/select_provider_success.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:loadmore/loadmore.dart';
import 'package:avon/models/hospital.dart';
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

class HospitalListScreen extends StatefulWidget {
  final bool isDropSelect;
  final bool canSkip;
  final bool fromBuyPlan;
  const HospitalListScreen({Key? key,
    this.isDropSelect = false,
    this.fromBuyPlan=false,
    this.canSkip=false
  }) : super(key: key);

  @override
  _HospitalListScreenState createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen> {
  int _currentPage =1;
  TextEditingController _searchController = new TextEditingController();
  List<Hospital> hospitals = [];
  List lStates = [];
  List serviceTypes = [
    "Advanced Investigation",
    "Ambulance",
    "Cardiology",
    "Dental Surgery",
    "Dentistry",
    "ECG",
    "Emergency",
    "ENT",
    "General Practice",
    "General Surgery",
    "Internal Medicine",
    "Investigations",
    "Laboratory",
    "Laboratory Investigations",
    "Neonatal",
    "Neonatology",
    "Nephrology",
    "Obstetrics and Gynaecology",
    "Oncologist",
    "Ophthalmology",
    "Orthopaedic Surgery",
    "Overseas Treatment",
    "Paediatrics",
    "Physiotherapy",
    "Psychiatry",
    "Radiography",
    "Radiology",
    "Registration",
    "Rheumatology",
    "ServiceType",
    "Theatre Services",
    "Theatre Use",
    "Ultrasound",
    "Urology"
  ];
  String? lState;
  String? serviceType;
  bool isLoading = false;
  Timer? timer;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool isCompleted = false;
  LoadMoreService _loadmore = new LoadMoreService();
  String endpoint = "provider/filter";
  MainProvider? state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    state = Provider.of<MainProvider>(context, listen: false);
    endpoint = "$endpoint?planClass=${state?.plan?.planTypeCategory ?? ''}";
    loadlStates();
    getHospitals();
  }

  getHospitals()async {
    _loadmore.initialise("${endpoint}&PageNumber=${_loadmore.currentPage}&PageSize=10");
    await _loadmore.getData(context);
    setState(() {});
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
          "Hospitals",
          style: TextStyle(fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),
        ),
        centerTitle: true,
        actions: [
          if(widget.canSkip)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
            child: AVTextButton(
              child: Text("skip", style: TextStyle(color: Colors.grey),),
              radius: 20,
              borderWidth: 0,
              verticalPadding: 0,
              borderColor: Colors.transparent,
              color: Colors.transparent,
              callBack: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=> SelectProviderSuccess()));
              },
            ),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 2),
        child: Column(
          children: [
            Text(
              "Here, you can choose a healthcare facility near you from our network of partner providers below.",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    child: Form(
                      child: AVInputField(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),

                        controller: _searchController,
                        onChange: (String v){
                          handleOnChange();
                        },
                        hintText: "search",
                        suffixCallBack: _buildFilter,
                        icon: Icon(Icons.filter_list_alt, color: AVColors.primary),

                      ),
                    )
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            _buildShowing(setState),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: _buildHospital()
            )
          ],
        ),
      ),
    );
  }

  Widget _buildShowing(StateSetter setState){
    return Visibility(
      visible: lState != null || serviceType != null,
      child: Container(
        height: 35,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Center(
              child: Text("Showing:", style: TextStyle(
                  color: Colors.black54))
            ),
            Visibility(
              visible: lState != null,
              child: _buildSearchItem(
                  lState??'',
                  onTap: (){
                    setState(() {
                      lState = null;
                    });
                    search();
                  }
              ),
            ),
            Visibility(
                visible: serviceType != null,
                child: _buildSearchItem(
                    serviceType??'',
                    onTap: (){
                      setState(() {
                        serviceType = null;
                      });
                      search();
                    }
                ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchItem(String text, {
    Function()? onTap
  }){
    return Container(
      decoration: BoxDecoration(
          color: AVColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5)
      ),
      constraints: BoxConstraints(
          minWidth: 80
      ),
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Text(text, style: TextStyle(
              color: AVColors.primary,
            ),),
          ),
          Padding(padding: EdgeInsets.only(left: 10)),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.close, size: 15,),
            ),
            onTap: (){ if(onTap != null) {onTap();} },
          )
        ],
      ),
    );
  }
  
  Future loadlStates() async{
    var temp = await rootBundle.loadString('assets/jsons/states.json');
    if(temp != null){
      setState(() {
        lStates = jsonDecode(temp);
      });
    }
  }

  _buildFilter(){
    GeneralService().bottomSheet(
        Column(
          children: [
            Padding(padding: EdgeInsets.only(bottom: 20)),
            hospitalFilterModal(),
          ],
        ),
        context,
        height: 400
    );
  }

  _buildHospital(){
    if(_loadmore.isLoading) return _buildLoader();
    if(_loadmore.content.length < 1) return EmptyContent(
      text: "No hospitals yet",
    );

    return AVRefresher(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index){
            Hospital provider = Hospital.fromJson(_loadmore.content[index]);
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              padding: const EdgeInsets.symmetric( vertical: 10),
              child: _buildProvider(
                  provider: provider
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: Colors.grey.withOpacity(0.3)
                      )
                  )
              ),
            );
          },
          itemCount: _loadmore.content.length,
        ),
        loadmore: _loadMore,
        refreshController: _loadmore.refreshController,
    );
  }

   _loadMore() async {
      print("onLoadMore");
      if(_loadmore.isCompleted) return;
       await _loadmore.loadMore(context, url: "${endpoint}&searchKey=${_searchController.text}&City=${lState ?? ''}&ServiceType=${serviceType ?? ''}&PageSize=10");
      setState(() {});
   }

  handleOnChange(){
    if(timer != null) timer?.cancel();
    timer = Timer(Duration(milliseconds: 800), search);
  }

  search()async {
    setState(() {
      _loadmore.flush();
    });

    await _loadmore.getData(context,
        url: "${endpoint}&searchKey=${_searchController.text}&City=${lState ?? ''}&ServiceType=${serviceType ?? ''}&PageSize=10");

    setState(() {});
  }

  Widget _buildProvider({required Hospital provider}){
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
            ViewHospitalScreen(hospital: provider, isDropSelect: widget.isDropSelect, fromBuyPlan: widget.fromBuyPlan,))
        ).then((value){
          if(value != null){
            Navigator.pop(context, value);
          }
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Image.asset('assets/images/Group 31175.png'),
            radius: 30,
            backgroundColor: Colors.white,
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
                  "${provider.name}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 5,),
                Text("${provider.address}",
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300)),
              ],
            ),
          )
        ],
      ),
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
      itemCount: 15,
    );
  }

  Widget hospitalFilterModal()=> StatefulBuilder(
    builder: (BuildContext context, StateSetter setState){
      return IntrinsicHeight(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Filter by",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            _buildShowing(setState),
            SizedBox(height: 10,),
            AVDropdown(
              options: [...lStates.map((e) => e['state']).toList()],
              value: lState,
              label: "Location",
              onChanged: (dynamic value){
                setState(() {
                  lState = value!;
                });
              },
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            AVDropdown(
              options:serviceTypes,
              value: serviceType,
              label: "Specialty",
              onChanged: (dynamic value){
                setState(() {
                  serviceType = value!;
                });
              },
            ),

            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 15, bottom: 10),
                child: AVTextButton(
                  radius: 5,
                  child: Text('Continue', style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                  )),
                  verticalPadding: 17,
                  callBack: (){
                    search();
                    Navigator.pop(context);
                  },
                )
            )
          ],
        ),
      );
    },
  );
}
