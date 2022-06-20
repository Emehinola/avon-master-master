import 'package:avon/utils/services/general.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ViewPostScreen extends StatefulWidget {
  Map post;
  bool isVideo;
  ViewPostScreen({
    Key? key,
    required this.post,
    this.isVideo=false
  }) : super(key: key);

  @override
  _ViewPostScreenState createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen> {
  Map get post=>widget.post;
  YoutubePlayerController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isVideo){
      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(post['postContent']) ?? '',
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          loop: true,
        ),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(GeneralService().processDateTime(post['publishedDate']));
    return AVScaffold(
      showAppBar: true,
      title: post['postCategory'],
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Visibility(
              visible: !widget.isVideo,
              child: AspectRatio(
                aspectRatio: 2.1,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(post['featuredImage']),
                          fit: BoxFit.fill),
                      shape: BoxShape.rectangle),
                ),
              ),
              replacement: _controller != null ? YoutubePlayer(
                controller: _controller!,
                showVideoProgressIndicator: true,
                // videoProgressIndicatorColor: Colors.amber,
                progressColors: ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(isExpanded: true),
                  // FullScreenButton()
                ],
              ):Container(),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              post['postTitle'],
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              post['postCategory'],
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  height: 1
              ),
            ),
            SizedBox(
              height: 5,
            ),

            Text(
              GeneralService().processDateTime(post['publishedDate']),
              style: TextStyle(
                  color: Color(0xff718096),
                  fontWeight: FontWeight.w300,
                  fontSize: 16
              ),
            ),

            SizedBox(
              height: 20,
            ),
            Visibility(
              visible: !widget.isVideo,
                child: Text(
                  post["postContent"],
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Color(0xff718096),
                      height: 1.5
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }
}
