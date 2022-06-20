import 'package:avon/models/plan.dart';

class BuyPlan {
  int? order_id;
  Plan? selectedPlan;
  Plan? selectedSubPlan;
  bool isSponsor = false;
  bool paid = false;
  int noOfIdividuals = 1;

  BuyPlan({
    required this.order_id,
    this.selectedPlan
  });

   BuyPlan.fromJson(Map json) :
         order_id= json['order_id'],
         selectedPlan= Plan.fromPlanJson(json['plan']),
         selectedSubPlan= Plan.fromSubPlanJson(json['sub_plan']),
         noOfIdividuals= json['noOfIdividuals'],
         isSponsor= json['isSponsor'],
         paid= json['paid'];

  Map toJson(){
    return {
      "plan":selectedPlan?.toJson(),
      "sub_plan":selectedSubPlan?.toJson(),
      "isSponsor":isSponsor,
      "paid":paid,
      "order_id":order_id ?? '',
      "noOfIdividuals":noOfIdividuals,
    };
  }


}