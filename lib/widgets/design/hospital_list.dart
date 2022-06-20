import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/design/design_widget/dropdown.dart';
import 'package:avon/widgets/forms/text_button.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'design_widget/hospital_filter_modal.dart';

class HospitalList extends StatelessWidget {
  const HospitalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:appBar(title: "Hospitals"),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 2),
        child: Column(
          children: [

            Text(
              "You can find a list of various hospitals where Avon health is accepted",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                height: 1.2
              ),
            ),

            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                /// I tried to  used the function you created but it is not working for it
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: AVInputField(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    hintText: "Try typing “Optician”",
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {

                    showDialog(context: context, builder: (builder)=>AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      content:hospitalFilterModal() ,

                    ));

                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(
                      Icons.add_road_outlined,
                    size: 25,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(0),
                children: List.generate(
                    15,
                    (index) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          padding: const EdgeInsets.symmetric( vertical: 10),
                          child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: (){},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
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
                                        "Alajobi general Hospital ",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(height: 5,),
                                      Text("Ojota, Lagos,Nigeria ",
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.3, color: const Color(0xffCFCFCF)))),
                        )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
