import 'package:avon/widgets/forms/text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HospitalInfo extends StatefulWidget {
  const HospitalInfo({Key? key}) : super(key: key);

  @override
  State<HospitalInfo> createState() => _HospitalInfoState();
}

class _HospitalInfoState extends State<HospitalInfo> with TickerProviderStateMixin {

  late TabController _controller;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 4,vsync: this);
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
          onPressed: () {},
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.black,
          ),
        ) ,
        title: Text(
          "Alajobi General Hospital",
          style: TextStyle(fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 2),
        child:Stack(
          children: [

            Column(
              children: [

                SizedBox(
                  height: 20,
                ),

                AspectRatio(
                  aspectRatio: 2.1,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/design_image/hos_info.png"),
                            fit: BoxFit.fill),
                        shape: BoxShape.rectangle),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                TabBar(
                    controller: _controller,
                    labelColor: Color(0xff155E33),
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w800
                    ),
                    unselectedLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w300
                    ),
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Color(0xff155E33),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(text: "Overview",),
                      Tab(text: "Reviews",),
                      Tab(text: "Photos",),
                      Tab(text: "Plans",)
                    ]),

                Expanded(
                  child: TabBarView(
                      controller: _controller,
                      children: [
                        Overview(),
                        reviews(),
                        photo(),
                        plan(),

                      ]),
                )


              ],
            ),

            Positioned(
              bottom:10 ,
              child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: AVTextButton(
                radius: 5,
                child: Text('Buy a plan', style: TextStyle(
                    color: Colors.white,
                  fontSize: 16
                )),
                verticalPadding: 17,
              ),
            ),)
            
          ],
        )
      ),
    );
  }



  Widget reviews()=>Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Container(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "Rate and Review",
            style: TextStyle(
                color: Color(0xff2E2E2E),
                fontSize: 16,
                fontWeight: FontWeight.w700
            ),
          ),

          const SizedBox(height: 10,),

          Text(
            "Share your experience to help others",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                height: 1.2
            ),
          ),
          const SizedBox(height: 15,),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: 30,
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
              RatingBarIndicator(
                itemCount: 5,
                itemSize: 30,
                rating: 3,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                unratedColor: Colors.black.withOpacity(0.5),
                itemBuilder:(context,index)=>Icon(
                  Icons.star_border_outlined,
                  color: Colors.amber,
                ),)
            ],
          ),
          const SizedBox(height: 15,),


          Text(
            "Reviews",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w300,
                height: 1.2
            ),
          ),

          const SizedBox(height: 15,),


          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 40,
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
                          "Janet Iweala",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 4,),
                        Text("Product Designer",
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300)),
                      ],
                    ),
                  )
                ],
              ),

              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RatingBarIndicator(
                    itemCount: 5,
                    itemSize: 20,
                    rating: 3,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                    unratedColor: Colors.black.withOpacity(0.5),
                    itemBuilder:(context,index)=>Icon(
                      Icons.star_border_outlined,
                      color: Colors.amber,
                    ),),
                  const SizedBox(height: 5,),
                  Text("3 Months ago")
                ],
              ),

              const SizedBox(height: 10,),
              Text(
                "You can find a list of various hospitals where Avon health is accepted",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    height: 1.3
                ),
              ),
              const SizedBox(height: 7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  InkWell(
                    onTap: (){},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.thumb_up_alt_outlined,size: 20,),
                        SizedBox(width:5,),
                        Text("4", style: TextStyle(
                          fontSize: 16
                        ),),
                      ],
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    child: Icon(
                        Icons.share_outlined,
                        size: 20,
                    ),
                  )

                ],
              )

            ],
          ),

        ],
      ),

      ),
  );


  Widget plan()=>Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "Plans this hospital covers",
          style: TextStyle(
              color: Color(0xff2E2E2E),
              fontSize: 17,
              fontWeight: FontWeight.w300
          ),
        ),


        SizedBox(height: 10,),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xff631293),
                  shape: BoxShape.circle
                ),
              ),

                  SizedBox(width: 10,),
              Expanded(
                child: Text(
                  "Premiun",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xff631293),
                  shape: BoxShape.circle
                ),
              ),

                  SizedBox(width: 10,),
              Expanded(
                child: Text(
                  "All Avon Plans",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),



      ],
    ),
  );




  Widget photo ()=>Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
    child: GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: [

      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/design_image/hos_info.png"),
                fit: BoxFit.fill),
            shape: BoxShape.rectangle),
      ),
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/design_image/hos_info.png"),
                fit: BoxFit.fill),
            shape: BoxShape.rectangle),
      ),
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/design_image/hos_info.png"),
                fit: BoxFit.fill),
            shape: BoxShape.rectangle),
      ),
    ],)
  );



  Widget Overview()=>Padding(
    padding: const EdgeInsets.all(6),
    child:Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          padding: EdgeInsets.only(bottom: 10),
            margin: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Color(0xff2B7EA1),
                size: 25,
              ),
              SizedBox(width: 10,),
              Text("Ojota, Lagos,Nigeria",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize:14
              ),)


            ],
          ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1.2, color: const Color(0xffCFCFCF))))
        ),

        Container(
          padding: EdgeInsets.only(bottom: 10),
            margin: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Icon(
                Icons.phone,
                color: Color(0xff2B7EA1),
                size: 30,
              ),
              SizedBox(width: 10,),
              Text("08130532134, 09038488321",
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize:14
                ),)


            ],
          ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1.2, color: const Color(0xffCFCFCF))))
        ),

        Container(
          padding: EdgeInsets.only(bottom: 10),
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Icon(
                Icons.vpn_lock_rounded,
                color: Color(0xff2B7EA1),
                size: 30,
              ),
              SizedBox(width: 10,),
              Text("www.Alajobigeneralhospital.com",style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize:15
              ),)


            ],
          ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1.2, color: const Color(0xffCFCFCF))))
        ),

        SizedBox(height: 12,),

        Text(
          "Location",
          style: TextStyle(
              color: Color(0xff2E2E2E),
              fontSize: 16,
              fontWeight: FontWeight.w700
          ),
        ),


      ],
    ),
  );



}
