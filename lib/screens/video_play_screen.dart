import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayScreen extends StatefulWidget {
  static const routeName = '/video-play';

  final String videoUrl;

  VideoPlayScreen({required this.videoUrl});

  @override
  _VideoPlayScreenState createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  double _videoSliderValue = 0.0;
  Duration _videoDuration = Duration();
  Duration _currentPosition = Duration();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _videoDuration = _controller.value.duration!;
        });
        _controller.play();
        _isPlaying = true;
        _controller.addListener(() {
          setState(() {
            _currentPosition = _controller.value.position;
            _videoSliderValue = _currentPosition.inSeconds.toDouble();
          });
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  void _seekBackward() {
    final newPosition = _currentPosition - Duration(seconds: 10);
    _controller.seekTo(newPosition);
  }

  void _seekForward() {
    final newPosition = _currentPosition + Duration(seconds: 10);
    _controller.seekTo(newPosition);
  }

  void _onSliderValueChanged(double value) {
    setState(() {
      _videoSliderValue = value;
      final newPosition = Duration(seconds: value.toInt());
      _controller.seekTo(newPosition);
    });
  }

  void _onKey(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      switch (event.logicalKey.keyLabel) {
        case 'Arrow Left':
          _seekBackward();
          break;
        case 'Arrow Right':
          _seekForward();
          break;
        case 'Select':
        case 'Enter':
          _togglePlay();
          break;
        case 'Back':
        case 'Escape':
          Navigator.of(context).pop();
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: _onKey,
        autofocus: true,
        child: _controller.value.isInitialized
            ? Stack(
                children: [
                  Center(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Slider(
                          min: 0.0,
                          max: _videoDuration.inSeconds.toDouble(),
                          value: _videoSliderValue,
                          onChanged: _onSliderValueChanged,
                          activeColor: Colors.blue,
                          inactiveColor: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: _seekBackward,
                              icon: Icon(
                                Icons.fast_rewind,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: _togglePlay,
                              icon: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: _seekForward,
                              icon: Icon(
                                Icons.fast_forward,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
