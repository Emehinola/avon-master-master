import 'dart:convert';
import 'package:avon/models/buy_plan.dart';
import 'package:avon/models/enrollee.dart';
import 'package:avon/models/enrollee_plan.dart';
import 'package:avon/screens/beneficiary/principal_details.dart';
import 'package:avon/screens/buy_plan_success.dart';
import 'package:avon/screens/select_provider_success.dart';
import 'package:avon/utils/services/general.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MainProvider extends ChangeNotifier {
  double nhisAmount = 0;
  EnrolleePlan? _plan;
  EnrolleePlan? get plan => _plan ?? null;
  set plan(value) {
    _plan = value;
    notifyListeners();
  }

  Enrollee? _user;
  Enrollee get user => _user!;
  bool get isLoggedIn => _user != null ? true : false;
  set user(value) {
    _user = value;
    notifyListeners();
  }

  bool _hideNavBar = false;
  bool get hideNavBar => _hideNavBar;
  set hideNavBar(value) {
    _hideNavBar = value;
    notifyListeners();
  }

  BuyPlan? _order;
  BuyPlan? get order => _order;
  set order(value) {
    _order = value;
    notifyListeners();
  }

  List<BuyPlan> _cart = [];
  List<BuyPlan> get cart => _cart;
  set cart(value) {
    _cart = value;
    notifyListeners();
  }

  List<Map> cartData = [];

  List<Map> get allCartPlans {
    List<Map<String, dynamic>> plans = [];
    _cart.forEach((element) {
      for (var c = 0; c < element.noOfIdividuals; c++) {
        plans.add({
          "plan": element.selectedSubPlan,
          "details": null,
          "isSponsor": (element.isSponsor &&
              !(plans.contains((e) => e['isSponsor'] == true)))
        });
      }
    });
    int sponsoredIndex = plans.indexWhere((e) => !e['isSponsor']);

    if (sponsoredIndex >= 0) {
      Map<String, dynamic> pl = plans.removeAt(sponsoredIndex);
      plans.insert(0, pl);
    }
    return plans;
  }

  int? currentPlanIndex;
  bool get isLastPlan => currentPlanIndex == null
      ? false
      : currentPlanIndex! == (allCartPlans.length - 1);
  Map? get currentPlanData =>
      currentPlanIndex == null ? null : allCartPlans[currentPlanIndex!];
  Map? get currentEnrolleData =>
      currentPlanIndex == null ? null : cartData[currentPlanIndex!];
  setCartData() {
    cartData = allCartPlans;
    notifyListeners();
  }

  Map? _cyclePlannerInfo;
  Map? get cyclePlannerInfo => _cyclePlannerInfo;
  set cyclePlannerInfo(value) {
    _cyclePlannerInfo = value;
    notifyListeners();
  }

  PageController pageController =
      PageController(initialPage: 0, keepPage: true);

  saveCart(cart) {
    List data = cart.map((e) => e.toJson()).toList();
    GeneralService().setStringPref("cart", jsonEncode(data));
  }

  retrieveEnrollee() async {
    Enrollee? temp = await GeneralService().getEnrollee();
    user = temp ?? _user;
  }

  double getCartTotal() {
    double total = 0;
    cart.forEach((element) {
      total += (element.selectedSubPlan?.premium ?? 0) * element.noOfIdividuals;
    });
    return total;
  }

  reset() {
    _plan = null;
    _user = null;
    _cyclePlannerInfo = null;
    _order = null;
    nhisAmount = 0;
    cart.clear();
  }
}
