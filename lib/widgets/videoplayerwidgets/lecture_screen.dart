import 'package:first_project/widgets/videoplayerwidgets/lecture_item.dart';
import 'package:first_project/widgets/videoplayerwidgets/models.dart';
import 'package:flutter/material.dart';

class AllLecturesScreen extends StatelessWidget {
  final List<Lecture> lectures;

  const AllLecturesScreen({super.key, required this.lectures});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Lectures"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: lectures.length,
          itemBuilder: (context, index) {
            return LectureItem(lecture: lectures[index]);
          },
        ),
      ),
    );
  }
}