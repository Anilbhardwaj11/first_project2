import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'models.dart';

class LectureItem extends StatelessWidget {
  final Lecture lecture;

  const LectureItem({super.key, required this.lecture});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.push('/playedvideo');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _buildThumbnail(),
            const SizedBox(width: 10),
            _buildLectureInfo(),
            _buildTimeInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.play_circle_fill, color: Colors.white),
    );
  }

  Widget _buildLectureInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lecture.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            lecture.chapter,
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          lecture.duration,
          style: const TextStyle(fontSize: 12),
        ),
        Text(
          "${lecture.date.day} ${DateFormatter.monthName(lecture.date.month)}",
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

// utils/date_formatter.dart
class DateFormatter {
  static String monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}