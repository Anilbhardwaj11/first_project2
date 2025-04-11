import 'package:first_project/widgets/videoplayerwidgets/comment_section.dart';
import 'package:first_project/widgets/videoplayerwidgets/lecture_list.dart';
import 'package:first_project/widgets/videoplayerwidgets/video_controls.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CourseVideoPage extends StatefulWidget {
  const CourseVideoPage({super.key});

  @override
  State<CourseVideoPage> createState() => _CourseVideoPageState();
}

class _CourseVideoPageState extends State<CourseVideoPage> {
  late VideoPlayerController _controller;
  final List<String> _comments = ["This course is very useful"];
  final TextEditingController _commentController = TextEditingController();
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    )..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _addComment() {
    final text = _commentController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _comments.insert(0, text);
        _commentController.clear();
      });
    }
  }

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    // Here you would typically also save this state to your backend or local storage
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isBookmarked ? 'Video bookmarked' : 'Bookmark removed'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _downloadVideo() {
    // Implement download logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Downloading video...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Played Video"),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: _controller.value.isInitialized
                  ? _controller.value.aspectRatio
                  : 16 / 9,
              child: _controller.value.isInitialized
                  ? VideoControls(
                      controller: _controller,
                      isBookmarked: _isBookmarked,
                      onToggleBookmark: _toggleBookmark,
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
            const SizedBox(height: 16),
            VideoHeader(onDownload: _downloadVideo),
            const SizedBox(height: 16),
            CommentSection(
              comments: _comments,
              commentController: _commentController,
              onAddComment: _addComment,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: LectureList(),
            ),
          ],
        ),
      ),
    );
  }
}
