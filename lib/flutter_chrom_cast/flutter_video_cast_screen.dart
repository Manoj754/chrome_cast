import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_video_cast/flutter_video_cast.dart';
import 'package:video_player/video_player.dart';

class FlutterCast extends StatefulWidget {
  // static final FlutterCast _instance = FlutterCast._private();
  // factory FlutterCast() => _instance;
  FlutterCast({Key? key}) : super(key: key);
  // FlutterCast._private();
  @override
  _FlutterCastState createState() => _FlutterCastState();
}

class _FlutterCastState extends State<FlutterCast> {
  ChromeCastController? _controller;
  double sliderVal = 0;
  int durationInsecond = 0;
  TextEditingController _urlController = TextEditingController();
  bool isPlay = false;
  // MediaInfo _info = MediaInfo();
  // final url =
  //     "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
  // final url =
  //     "https://vcz-uppkast-cloud-vodlix-com.b-cdn.net/files/videos/2021/12/21/164009701663962gzgolxvz7-720.m3u8?height=720&userid=&video_version=2.8&platform=&default_source=";
  // final url = "https://www.youtube.com/watch?v=smn3mDBOUy4";
  final url =
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/CastVideos/hls/DesigningForGoogleCast.m3u8";

  @override
  initState() {
    super.initState();
    // VideoPlayerController videoController = VideoPlayerController.network(url);
    // videoController.initialize().then((value) => {
    //       print(videoController.value.duration.inSeconds.toString()),
    //       durationInsecond = videoController.value.duration.inSeconds
    //     });
    // MediaInfo info = MediaInfo();
    // final res = info
    //     .getMediaInfo(
    //       url,
    //     )
    //     .then((value) => {
    //           log(value.toString()),
    //         });

    // MediaInfo mSelectedMedia = MediaInfo.Builder(
    //         "http://vevoplaylist-live.hls.adaptive.level3.net/vevo/ch3/appleman.m3u8")
    //     .setContentType("application/x-mpegURL")
    //     .setStreamType(MediaInfo.STREAM_TYPE_BUFFERED)
    //     .setMetadata(mediaMetadata)
    //     .build();

    // final data = _info.getMediaInfo(
    //   "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    // );
    // print(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cast Sample'),
        actions: [
          // AndroidView(viewType: "viewType"),
          ChromeCastButton(
            color: Colors.red,
            // onButtonCreated: CastControlller().setController,
            onButtonCreated: (controller) {
              setState(() => _controller = controller);
              _controller?.addSessionListener();
              log(_controller.hashCode.toString() + " Controller has Code");
            },
            onSessionStarted: () {
              _controller?.loadMedia(
                url,
              );
              // _controller?.play();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _urlController,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      _controller!.seek(interval: -10, relative: true);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.replay_10_outlined,
                        size: 35,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (await _controller?.isPlaying() ?? false) {
                        _controller?.pause();
                        isPlay = true;
                      } else {
                        _controller?.play();
                        isPlay = false;
                      }
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        isPlay ? Icons.pause : Icons.play_arrow,
                        size: 35,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      _controller!.seek(interval: 10, relative: true);
                      // sliderVal += 10 / durationInsecond;
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.forward_10_outlined,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
              Slider(
                value: sliderVal,
                onChanged: (val) {
                  sliderVal = val;
                  setState(() {});

                  print(val.toString());
                },
                onChangeEnd: (val) {
                  _controller?.seek(interval: val * durationInsecond);
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (await _controller?.isConnected() ?? false) {
                      if (_urlController.text.isNotEmpty) {
                        _controller?.loadMedia(_urlController.text);
                      } else {
                        _controller?.loadMedia(url);
                      }
                    }
                  },
                  child: Text("Load")),
            ],
          ),
        ),
      ),
    );
  }
}
