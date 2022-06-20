
import 'package:avon/widgets/design/design_widget/app_bar.dart';
import 'package:avon/widgets/design/design_widget/text_chip.dart';
import 'package:avon/widgets/forms/text_input.dart';
import 'package:flutter/material.dart';

class ViewDoctorReport extends StatelessWidget {
  const ViewDoctorReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "View doctor report"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5,),
            Text(
              "Lanre Moses",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 5,),
            Text("View detail as profiled my Reddington hospital",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300)),
            const SizedBox(height: 10,),
            AVInputField(
              label: "Name",
              labelText: "",
            ),
            AVInputField(
              label: "ID",
              labelText: "",
            ),
            AVInputField(
              label: "Plan",
              labelText: "",
            ),
            AVInputField(
              label: "Sex",
              labelText: "",
            ),
            Text("Diagnosis",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300)),
            Wrap(
              children:List.generate(8, (index) => textChip(text: "Malaria")),
            ),
            const SizedBox(height: 10,),
            Text("Service",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300)),
            Wrap(
              children:List.generate(8, (index) => textChip(text: "Consultation")),
            ),
            const SizedBox(height: 10,),
            AVInputField(
              label: "Notes",
              maxLines: 4,
              height: 80,
              labelText: "Patient lacked good nutritional foods and was given supliments",
            ),




          ],
        ),
      ),
      
    );
  }
}
