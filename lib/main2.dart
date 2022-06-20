


import 'package:avon/widgets/design/partner/become_agent.dart';
import 'package:avon/widgets/design/partner/become_broker.dart';
import 'package:avon/widgets/design/partner/join_provider_network.dart';
import 'package:avon/widgets/design/video.dart';
//import 'package:avon/widgets/design/wellness/health_living.dart';
import 'package:avon/screens/explore/wellness/wellness_lifestyle.dart';
import 'package:flutter/material.dart';

import 'widgets/design/hospital_list.dart';
import 'screens/explore/wellness/view_post.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Video(),
      )
  );
}