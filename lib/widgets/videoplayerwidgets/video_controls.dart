import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoControls extends StatefulWidget {
  final VideoPlayerController controller;
  final bool isBookmarked;
  final VoidCallback onToggleBookmark;

  const VideoControls({
    super.key,
    required this.controller,
    required this.isBookmarked,
    required this.onToggleBookmark,
  });

  @override
  State<VideoControls> createState() => _VideoControlsState();
}

class _VideoControlsState extends State<VideoControls> {
  bool _showControls = true;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    // Add listener to hide controls after playback starts
    widget.controller.addListener(_updateControlsVisibility);

    // Auto-hide controls after a few seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && widget.controller.value.isPlaying) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateControlsVisibility);
    super.dispose();
  }

  void _updateControlsVisibility() {
    setState(() {}); // Update UI when controller state changes
  }

  void _togglePlayPause() {
    setState(() {
      if (widget.controller.value.isPlaying) {
        widget.controller.pause();
      } else {
        widget.controller.play();
        // Auto-hide controls after playing starts
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted && widget.controller.value.isPlaying) {
            setState(() {
              _showControls = false;
            });
          }
        });
      }
    });
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });

    if (_isFullScreen) {
      // Enter full screen mode
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      // Exit full screen mode
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
      );
    }
  }

  void _rewind10Seconds() {
    final newPosition =
        widget.controller.value.position - const Duration(seconds: 10);
    widget.controller
        .seekTo(newPosition < Duration.zero ? Duration.zero : newPosition);
  }

  void _forward10Seconds() {
    final Duration videoLength = widget.controller.value.duration;
    final Duration newPosition =
        widget.controller.value.position + const Duration(seconds: 10);
    widget.controller
        .seekTo(newPosition > videoLength ? videoLength : newPosition);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showControls = !_showControls;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          VideoPlayer(widget.controller),
          if (_showControls) _buildProgressIndicator(),
          if (_showControls) _buildPlayControls(),
          if (_showControls) _buildBookmarkButton(),
          if (_showControls) _buildFullscreenButton(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: VideoProgressIndicator(
        widget.controller,
        allowScrubbing: true,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        colors: const VideoProgressColors(
          playedColor: Colors.red,
          bufferedColor: Colors.grey,
          backgroundColor: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildPlayControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.replay_10, color: Colors.white, size: 36),
          onPressed: _rewind10Seconds,
        ),
        IconButton(
          icon: Icon(
            widget.controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
            size: 50,
          ),
          onPressed: _togglePlayPause,
        ),
        IconButton(
          icon: const Icon(Icons.forward_10, color: Colors.white, size: 36),
          onPressed: _forward10Seconds,
        ),
      ],
    );
  }

  Widget _buildBookmarkButton() {
    return Positioned(
      top: 10,
      right: 10,
      child: IconButton(
        icon: Icon(
          widget.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
          color: Colors.white,
        ),
        onPressed: widget.onToggleBookmark,
      ),
    );
  }

  Widget _buildFullscreenButton() {
    return Positioned(
      bottom: 25,
      right: 10,
      child: IconButton(
        icon: Icon(
          _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
          color: Colors.white,
        ),
        onPressed: _toggleFullScreen,
      ),
    );
  }
}
class VideoHeader extends StatelessWidget {
  final VoidCallback onDownload;

  const VideoHeader({super.key, required this.onDownload});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chapter1: Introduction to Computers",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "Chapter Subtitle",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onDownload,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
            child: const Text("Download"),
          ),
        ],
      ),
    );
  }
}
