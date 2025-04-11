import 'package:first_project/widgets/videoplayerwidgets/lecture_item.dart';
import 'package:first_project/widgets/videoplayerwidgets/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LectureList extends StatelessWidget {
  const LectureList({super.key});

  @override
  Widget build(BuildContext context) {
    // List<Lecture> lectures = List.generate(
    //   10,
    //   (index) => Lecture(
    //     title: "Lecture Title $index",
    //     chapter: "Chapter $index",
    //     duration: "2hr 10min",
    //     date: DateTime(2025, 3, 25),
    //   ),
    // );

    return Column(
      children: [
        _buildHeader(context, lectures),
        const SizedBox(height: 10),
        _buildLectureItems(lectures),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, List<Lecture> lectures) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Lectures",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            context.push('/seeall');
          },
          child: const Text(
            "See all",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildLectureItems(List<Lecture> lectures) {
    return Column(
      children: lectures
          .take(3) // Show only 3 initially
          .map((lecture) => LectureItem(lecture: lecture))
          .toList(),
    );
  }
}