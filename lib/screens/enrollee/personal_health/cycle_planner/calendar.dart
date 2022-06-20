import 'dart:collection';
import 'dart:convert';
import 'package:avon/screens/enrollee/personal_health/cycle_planner/setup_planner_1.dart';
import 'package:avon/screens/enrollee/personal_health/cycle_planner/setup_planner_2.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/general.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/widgets/empty_content.dart';
import 'package:avon/widgets/loader.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

class CyclePlannerCalendarScreen extends StatefulWidget {
  const CyclePlannerCalendarScreen({Key? key}) : super(key: key);

  @override
  _CyclePlannerCalendarScreenState createState() => _CyclePlannerCalendarScreenState();
}

class _CyclePlannerCalendarScreenState extends State<CyclePlannerCalendarScreen> {

  bool isLoading = false;
  bool hasError = false;
  List events = [];
  List<int> colors = [
    0xffF16063,
    0xff631293,
    0xff4C6FFF,
    0xff68DBF2
  ];
  Map? _data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEvents();
  }

  @override
  Widget build(BuildContext context) {
    MainProvider state = Provider.of<MainProvider>(context, listen: false);

    return AVScaffold(
        showAppBar: true,
        title: "Cycle Planner",
        decoration: BoxDecoration(
          color: Colors.white
        ),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder:
                      (BuildContext context)=>SetupPlanner2(
                        categoryId: state.cyclePlannerInfo!['cyclePlannerCategoryId'],
                        header: "Planner Settings",
                      )));
              },
              icon: Icon(
                  Icons.settings,
                  color: Colors.black
              )
          )
        ],
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                (kToolbarHeight + MediaQuery.of(context).padding.top)
          ),
          height: double.negativeInfinity,
          child:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildBody(),
          ),
        )
    );
  }

  Widget _buildBody(){
    if(isLoading) return Center(
        child: AVLoader(
          color: Colors.red,
        ),
      );

    if(hasError || events.length == 0)
      return Expanded(
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.only(top: 30)),
            EmptyContent(text: "No events yet")
          ],
        ),
      );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: TableCalendar(
            firstDay: DateTime.now().add(Duration(days: -90)),
            lastDay: DateTime.now().add(Duration(days: 365)),
            focusedDay: DateTime.parse(_data!['nextPeriodStartDate']),
            calendarFormat: CalendarFormat.month,
            headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                leftChevronMargin:const EdgeInsets.all(0),
                rightChevronMargin: const EdgeInsets.all(0)
            ),
            eventLoader: _getEvents,
            calendarBuilders: CalendarBuilders(
              singleMarkerBuilder: (context, date, event) {
                return Container(
                  height: 10,
                  width: 10,
                  margin: const EdgeInsets.all(0.5),
                  decoration: BoxDecoration(
                    // provide your own condition here
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
          ),
          decoration: BoxDecoration(
              color: Color(0xffF9F7FB),
              borderRadius: BorderRadius.circular(10)
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 20)),
        _buildEvents()
      ],
    );
  }

  List _getEvents(DateTime day){
    // print(day);
    return [];
    // final kEvents = [Event("plannere")];
    //
    // return kEvents;
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  Widget _buildEvents(){
    return Expanded(
      child: ListView.builder(
        itemCount: events.length,
          itemBuilder: (BuildContext context, int index){
            Map event = events[index];
            return _event(
                title: event['label'],
                content: event['value'],
                circColor: Color(event["color"])
            );
          }
      ),
    );
  }

  Widget _event({
    required String title,
    required String content,
    required Color circColor
  })=>  Container(
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
        margin: const EdgeInsets.symmetric(vertical: 10,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: circColor,
                  shape: BoxShape.circle
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 7,),
                  Text(content,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300)),
                ]
              )
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10)
        ),

      );

  void getEvents()async {
    setState(() {isLoading = true; });

    http.Response response = await HttpServices.get(context, "enrollee/cycle-planner/next-period");

    if(response.statusCode == 200){
      Map body = jsonDecode(response.body)['data'];
      setState(() {
        _data = body;
        events = [
          {
            "label": "Last Period",
            "value": GeneralService().processDate(body['lastPeriodStartDate']),
            "color": colors[0],
            "date": DateTime.parse(body['lastPeriodStartDate'])
          },
          {
            "label": "Next Period",
            "value": GeneralService().processDate(body['nextPeriodStartDate']),
            "color": colors[1],
            "date": DateTime.parse(body['nextPeriodStartDate'])
          },
          {
            "label": "Next Ovulation",
            "value": GeneralService().processDate(body['nextOvulationDate']),
            "color": colors[2],
            "date": DateTime.parse(body['nextOvulationDate'])
          },
          {
            "label": "Period End",
            "value": GeneralService().processDate(body['periodEndDate']),
            "color": colors[3],
            "date": DateTime.parse(body['periodEndDate'])
          }
        ];
      });
    }else{
      setState(() {hasError = true; });
    }

    setState(() {isLoading = false; });
  }
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}
