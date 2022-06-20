
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';

class Video extends StatelessWidget {
  const Video({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
        showAppBar: true,
        title: "Videos",
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView(
              shrinkWrap: true,
              children:List.generate(6, (index) => video())
          ),
        )
    );
  }


  Widget video()=>Padding(
    padding: const EdgeInsets.symmetric(vertical:6.0,),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          alignment: Alignment.center,
          height: 100,
          width: 120,
          child: Container(
            child: IconButton(
              onPressed: (){},
              icon: Icon(
                Icons.play_arrow,
                size: 30,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black38
            ),
          ),
          decoration: BoxDecoration( color: Colors.black12,
              image: DecorationImage(
                  image: AssetImage("assets/design_image/well.png"),
                  fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle),
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
                "Living your best, one step at a time",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 3,),
              Text("Avon HMo",
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff718096),
                      fontWeight: FontWeight.w300)),
              SizedBox(height: 3,),
              Text("200 views - 2 days ago",
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff718096),
                      fontWeight: FontWeight.w300)),
            ],
          ),
        )

      ],
    ),
  );


}
