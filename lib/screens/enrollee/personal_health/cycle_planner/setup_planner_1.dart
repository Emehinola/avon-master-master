import 'dart:convert';

import 'package:avon/screens/enrollee/personal_health/cycle_planner/setup_planner_2.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:avon/widgets/skeleton-card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SetupPlanner1 extends StatefulWidget {
  final bool edit;
  final String? categoryId;
  final String? header;
  const SetupPlanner1({
    Key? key,
    this.edit = true,
    this.categoryId,
    this.header}) : super(key: key);

  @override
  _SetupPlanner1State createState() => _SetupPlanner1State();
}

class _SetupPlanner1State extends State<SetupPlanner1> {
  bool isLoading = false;
  List content = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        showAppBar: true,
        title: '',
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height
          ),
          height: double.negativeInfinity,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Step 1 of 2",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 7,),

                  Text(
                      "Set up cycle planner",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black)
                  ),
                  const SizedBox(height: 7,),
                  const Text(
                    "choose a reason for using cycle planner so we can notify you.",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,

                    ),
                  ),
                  const SizedBox(height: 7,),
                  Flexible(
                      child: buildBody()
                  )
                ],
              )
          )
        )
    );
  }

  Widget buildBody(){
    if(isLoading) return _buildLoader();

    // if(content.length == 0) return Empt

    return Column(
        children: content.map((d){
          return _plan(
              title: d['description'],
              isSelected: true,
              id: d['cyclePlannerCategoryId']
          );
        }).toList()
    );
  }

  Widget _plan({
    required String title,
    required bool isSelected,
    required String id
  })=> GestureDetector(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      margin: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
                title,

                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)
            ),
          ),
          Icon(
            Icons.arrow_right,
            color: Color(0xff631293),
          )

        ],
      ),
      decoration: BoxDecoration(
          color: Color(0xffF9F7FB),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color:  isSelected ? Color(0xff631293) : Color(0xffF9F7FB))

      ),
    ),
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>SetupPlanner2(
        categoryId: id,
      )));
    },
  );

  Widget _buildLoader(){
    return ListView.builder(itemBuilder: (
            (BuildContext context, int index)=> Padding(
          padding: const EdgeInsets.only(top: 15),
          child: SkeletonBlock(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      color: Colors.white,
                      height: 15,
                    ),
                    Container(color: Colors.white,height: 5),
                    Container(color: Colors.white,height: 5),
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

  void getCategories()async {
    setState(() { isLoading = true;});

    http.Response response = await HttpServices.get(context, "enrollee/cycle-planner/category");

    if(response.statusCode == 200){
      List data = jsonDecode(response.body)['data'];
      setState((){
        content = data;
      });
    }
    setState(() { isLoading = false;});
  }
}
