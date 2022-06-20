

import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/design/design_widget/image_text_arrow_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CyclePlannerCalender extends StatelessWidget {
  const CyclePlannerCalender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "Cycle planner", tail: [IconButton(onPressed: (){}, icon:Icon(Icons.settings_outlined))]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
        calendarFormat: CalendarFormat.month,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  leftChevronMargin:const EdgeInsets.all(0),
                  rightChevronMargin: const EdgeInsets.all(0)
                ),

      ),
              decoration: BoxDecoration(
                color: Color(0xffF9F7FB),
                borderRadius: BorderRadius.circular(10)
              ),
            ),

            Expanded(
              child: ListView(
                children: [
                  _event(title: "Pre period", content: "Mon, Jun 15 - Wed, Jun 17", circColor: Color(0xffF16063)),
                  _event(title: "Period day", content: "Thur, Jun 19 - Sat, Jun 22", circColor: Color(0xff631293)),
                  _event(title: "Post period", content: "Thur, Jun 19 - Sat, Jun 22", circColor: Color(0xff4C6FFF)),

                ],
              ),
            )

          ],
        ),
      )
    );
  }
  
  
  Widget _event({required String title,required String content,required Color circColor})=>
      Container(
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 7),
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
                ],
              ),
            ),



          ],
        ),
        decoration: BoxDecoration(
            color:Color(0xffF7FAFC),
          borderRadius: BorderRadius.circular(10)
        ),

      );





}
