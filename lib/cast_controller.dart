import 'package:flutter/widgets.dart';
import 'package:flutter_video_cast/flutter_video_cast.dart';

class CastControlller extends ChangeNotifier {
  ChromeCastController? _controller;
  setController(ChromeCastController castController) {
    this._controller = castController;
    notifyListeners();
  }

  loadVideo(String videoUrl) {
    _controller?.loadMedia(videoUrl);
  }

  stopCast() {
    _controller?.stop();
  }

  seekForward(double seconds) {
    _controller?.seek(interval: seconds, relative: true);
  }

  seekBackward(double seconds) {
    _controller?.seek(interval: -1 * seconds, relative: true);
  }

  setVolume() {
    // _controller?.addSessionListener();
  }
}
