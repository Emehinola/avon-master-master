import 'package:avon/screens/auth/login.dart';
import 'package:avon/screens/enrollee/dashboard.dart';
import 'package:avon/screens/welcome.dart';
import 'package:avon/state/main-provider.dart';
import 'package:avon/utils/constants/colors.dart';
import 'package:avon/utils/services/load_more.dart';
import 'package:avon/widgets/design/create%20account/add_beneficary.dart';
import 'package:avon/widgets/design/create%20account/create_our_plan.dart';
import 'package:avon/widgets/design/create%20account/plan_summary.dart';
import 'package:avon/widgets/design/create%20account/select_plan.dart';
import 'package:avon/widgets/design/create%20account/view_plan.dart';
import 'package:avon/widgets/design/explore%20plan/compare_our_plan.dart';
import 'package:avon/widgets/design/explore%20plan/our_plan_home.dart';
import 'package:avon/widgets/design/explore%20plan/our_plans.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('avon');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: MainProvider()),
        ChangeNotifierProvider.value(value: LoadMoreService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
        theme: ThemeData(
            colorScheme: ColorScheme.light(primary: AVColors.primary)),
      )));
}
