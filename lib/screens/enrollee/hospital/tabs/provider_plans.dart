import 'dart:convert';

import 'package:avon/utils/services/http-service.dart';
import 'package:avon/utils/services/load_more.dart';
import 'package:avon/widgets/empty_content.dart';
import 'package:avon/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:skeleton_loader/skeleton_loader.dart';

class ProviderPlans extends StatefulWidget {
  String code;
  ProviderPlans({Key? key, required this.code}) : super(key: key);

  @override
  _ProviderPlansState createState() => _ProviderPlansState();
}

class _ProviderPlansState extends State<ProviderPlans>
    with AutomaticKeepAliveClientMixin<ProviderPlans> {
  bool isLoading = false;
  List content = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getRequests();
  }

  @override
  Widget build(BuildContext context) {
    // print("code: ${widget.code}");
    if (isLoading) return _buildLoader();

    if (content.length == 0) return EmptyContent(text: "No plans");

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Plans this hospital covers",
          style: TextStyle(
              color: Color(0xff2E2E2E),
              fontSize: 17,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(
          height: 10,
        ),
        ...content
            .map((e) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Color(0xff631293), shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "${e["planName"]} (${e['providerClass']})",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ],
    );
  }

  _getRequests() async {
    setState(() {
      isLoading = true;
    });
    http.Response response = await HttpServices.get(
        context, "provider/plans/${widget.code}",
        handleError: false);
    if (response.statusCode == 200) {
      content = jsonDecode(response.body)['data'];
      print("cont: $content");
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget _buildLoader() {
    return AVLoader();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
