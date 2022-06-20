import 'package:avon/screens/webviews/static-html.dart';
import 'package:avon/utils/services/general.dart';
import 'package:flutter/material.dart';

class MenuItemCard extends StatelessWidget {
  final Map item;
  final int? width;
  final int? top;
  final int? bottom;
  final int? left;
  final int? right;
  MenuItemCard({
    Key? key,
    required this.item,
    this.width,
    this.top,
    this.bottom,
    this.left,
    this.right,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color icon_color = Color(item['icon_color']);
    Color _color = item['active'] == false
        ? Color.fromRGBO(186, 179, 178, 0.8)
        : Color(item['color']);
    // Color _color = Color(item['color']);

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: _color, borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                            child: CircleAvatar(
                              radius: 31,
                              backgroundColor: item['active'] ?? true
                                  ? icon_color
                                  : Color.fromRGBO(186, 179, 178, 1),
                            ),
                            bottom: 0),
                        item['active'] ?? true
                            ? Positioned(
                                child: Center(
                                  child: item['icon'] != null
                                      ? Image.asset(
                                          item['icon'],
                                          width: width?.toDouble(),
                                        )
                                      : null,
                                ),
                                top: top?.toDouble() ?? null,
                                bottom: bottom?.toDouble() ?? 0,
                                left: left?.toDouble() ?? 0,
                                right: right?.toDouble() ?? 0)
                            : Positioned(
                                child: Center(
                                  child: item['icon'] != null
                                      ? Image.asset(
                                          item['icon'],
                                          width: width?.toDouble(),
                                        )
                                      : null,
                                ),
                                top: top?.toDouble() ?? null,
                                bottom: bottom?.toDouble() ?? 0,
                                left: left?.toDouble() ?? 0,
                                right: right?.toDouble() ?? 0),
                        item['active'] ?? true
                            ? SizedBox.shrink()
                            : Positioned(
                                child: CircleAvatar(
                                  radius: 32,
                                  backgroundColor:
                                      Color.fromRGBO(186, 179, 178, 0.8),
                                ),
                                bottom: 0)
                      ],
                    ),
                    width: 70,
                    height: 80,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 0)),
                        Text(
                          "${item['prefix']}",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Flexible(
                            child: Text(
                          "${item['label']}",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.038),
                          overflow: TextOverflow.clip,
                        )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              child: item['image'] != null
                  ? Opacity(
                      opacity: item['opacity'] != null ? item['opacity'] : 1,
                      child: Image.asset(item['image']),
                    )
                  : Container(),
              bottom: 0,
              right: 0,
            ),
          ],
        ),
      ),
      onTap: () {
        if (item['screen'] != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => item['screen']!));
        } else if (item['url'] != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => StaticHtmlScreen(
                        path: item['url'],
                        title: item['label'],
                        isWeb: true,
                      )));
        } else if (!item['active']) {
          // for disabled card
          GeneralService().showDialogue(
              context,
              item['label'] == "Avon TeleDoc"
                  ? "Oops! Still a work in progress, please check back later. Thanks!"
                  : "Oops! You need to have an Avon HMO health plan to use this feature",
              item['label'] == "Avon TeleDoc");
        }
      },
    );
  }
}
