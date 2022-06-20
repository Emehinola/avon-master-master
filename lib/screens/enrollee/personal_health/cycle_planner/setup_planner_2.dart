import 'dart:convert';
import 'package:avon/screens/enrollee/personal_health/cycle_planner/calendar.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/services/http-service.dart';
import 'package:avon/utils/services/notifications.dart';
import 'package:avon/widgets/forms/dropdown_input.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SetupPlanner2 extends StatefulWidget {
  final bool edit;
  final String? categoryId;
  final String? header;

  SetupPlanner2({
    Key? key,
    this.edit = true,
    required this.categoryId,
    this.header
  }) : super(key: key);

  @override
  _SetupPlanner2State createState() => _SetupPlanner2State();
}

class _SetupPlanner2State extends State<SetupPlanner2> {

  TextEditingController _dobController = new TextEditingController();
  TextEditingController _daysController = new TextEditingController();
  bool isLoading = false;
  String? periodDuration;
  List periodDurations = [
    '1','2','3','4','5','6','7','8','9','10'
  ];
  DateTime? preSelectedTime;
  String? get categoryId => widget.categoryId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MainProvider state = Provider.of<MainProvider>(context, listen: false);

    if(state.cyclePlannerInfo != null){
      Map cycle = state.cyclePlannerInfo!;
      DateTime date = DateTime.parse(cycle['periodStartDate']);
      preSelectedTime = date;
      _dobController.text = "${date.day}/${date.month}/${date.year}";
      _daysController.text = cycle['periodCycle'].toString();
      periodDuration = cycle['periodDuration'].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
        showAppBar: true,
        title: "${widget.header ?? ''}",
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).padding.top+kToolbarHeight)
          ),
          height: double.negativeInfinity,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Text(
                          "Cycle info",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black)
                      ),
                      const SizedBox(height: 8,),
                      const Text(
                        "Enter your monthly cycle details",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,

                        ),
                      ),
                      const SizedBox(height: 25,),


                      InkWell(
                        onTap: toggleDatePicker,
                        child: AVInputField(
                          label: "When did your last period start?",
                          labelText: "5/27/15",
                          controller: _dobController,
                          disabled: true,

                        ),
                      ),
                      AVDropdown(
                        options: periodDurations,
                        value: periodDuration,
                        label: "How many days does your period usually last?",
                        onChanged: (v){ setState(() {
                          periodDuration = v;
                        });},
                      ),
                      AVInputField(
                        label: "How many days usually go between the start of one period and the start of the next one?",
                        labelText: "28",
                        inputType: TextInputType.number,
                        controller: _daysController,
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 30),
                    child: AVTextButton(
                        radius: 5,
                        child: Text("Save", style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        )),
                        verticalPadding: 17,
                        disabled: isLoading,
                        showLoader: isLoading,
                        callBack: submit
                    ),
                  ),
                ],
              )


          ),
        )
    );
  }

  void submit()async {
    if(isLoading) return;


    if(_daysController.text.isEmpty ||
      _dobController.text.isEmpty ||
      periodDuration!.isEmpty
    ){
      NotificationService.errorSheet(context, "Please fill all required filled");
      return;
    }

    setState(() { isLoading = true; });

    MainProvider state = Provider.of<MainProvider>(context, listen: false);

    Map payload = {
      // "enrolleeId": "${state.user.enrolleeId}",
      "cyclePlannerCategoryId": categoryId,
      "periodStartDate": "${_dobController.text}",
      "periodDuration": "${periodDuration}",
      "periodCycle":  "${_daysController.text}"
    };

    http.Response response = await HttpServices.post(context, "enrollee/cycle-planner/cycleinfo", payload);

    if(response.statusCode == 200){
        Map data = jsonDecode(response.body);
        if(!data['hasError']){
          await getCycleInfo(data['message']);
        }
    }

    setState(() { isLoading = false; });
  }

  toggleDatePicker()async {

    DateTime? date = await showDatePicker(
        context: context,
        initialDate: preSelectedTime ?? DateTime.now().add(Duration(days: -30)),
        firstDate: DateTime.now().add(Duration(days: -365)),
        lastDate: DateTime.now()
    );
    setState(() {
      _dobController.text = "${date?.day}/${date?.month}/${date?.year}";
    });
    print(_dobController.text);
  }

  Future getCycleInfo(String message)async {
    setState((){ isLoading = true;});

    MainProvider state = Provider.of<MainProvider>(context, listen: false);
    http.Response response = await HttpServices.get(context, "enrollee/cycle-planner/cycleinfo");
    if(response.statusCode == 200){
      var body = jsonDecode(response.body);

      if(body['data'].length > 0){
        List data = body['data'];
        state.cyclePlannerInfo = data.first;
        
        if(widget.header != null){
          Navigator.pop(context);
        }else{
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context)=> CyclePlannerCalendarScreen()));
        }
        NotificationService.successSheet(context, message);
      }
    }
    setState((){ isLoading = false;});
  }
}
