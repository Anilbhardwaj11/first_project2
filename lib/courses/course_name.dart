import 'package:first_project/widgets/videoplayerwidgets/lecture_list.dart';
import 'package:flutter/material.dart';

class CourseName extends StatelessWidget {
  const CourseName({super.key});

  @override
  Widget build(BuildContext context) {
    final Course testCourse = Course(
      title: "Flutter Mastery",
      description:
          "Learn Flutter from basics to advanced, including real-world projects and best practices.",
      liveClasses: 12,
      quizzes: 5,
      assignments: 3,
      pdfs: 10,
      chapters: 8,
      lectures: 40,
      progress: 0.65,
      purchaseDate: DateTime(2025, 3, 15),
      validTill: DateTime(2025, 3, 15).add(const Duration(days: 90)),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ProfileAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
            child: Column(
              children: [
                CourseNameCard(course: testCourse),
                const SizedBox(height: 10),
                const Lecutures(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Lecutures extends StatefulWidget {
  const Lecutures({super.key});

  @override
  State<Lecutures> createState() => _LecuturesState();
}

class _LecuturesState extends State<Lecutures> {
  int _selectedTabIndex = 0;

  Widget _buildTab(String title, int index) {
    final isSelected = _selectedTabIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.grey.shade600 : Colors.transparent,
            borderRadius: index == 0
                ? const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  )
                : index == 3
                    ? const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      )
                    : null,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTab("Lectures(74/82)", 0),
              _buildTab("Quiz (74/82)", 1),
              _buildTab("Test (74/82)", 2),
              _buildTab("Assignment (74/82)", 3),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (_selectedTabIndex == 0) const LectureList(),
      ],
    );
  }
}

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Course Name",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 30, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class Course {
  final String title;
  final String description;
  final int liveClasses;
  final int quizzes;
  final int assignments;
  final int pdfs;
  final int chapters;
  final int lectures;
  final double progress;
  DateTime validTill;
  DateTime purchaseDate;
  bool isFavourite;

  Course({
    required this.title,
    required this.description,
    required this.liveClasses,
    required this.quizzes,
    required this.assignments,
    required this.pdfs,
    required this.chapters,
    required this.lectures,
    required this.progress,
    required this.validTill,
    required this.purchaseDate,
    this.isFavourite = false,
  });

  int get completionPercent => (progress * 100).toInt();

  String get durationLeft {
    final daysLeft = validTill.difference(DateTime.now()).inDays;
    if (daysLeft < 1) return "Ended";
    if (daysLeft < 30) return "Ends in $daysLeft days";
    final months = (daysLeft / 30).round();
    return "Ends in $months month${months > 1 ? 's' : ''}";
  }
}

class CourseNameCard extends StatefulWidget {
  final Course course;
  const CourseNameCard({super.key, required this.course});

  @override
  _CourseNameCardState createState() => _CourseNameCardState();
}

class _CourseNameCardState extends State<CourseNameCard> {
  late bool isFavourite;

  @override
  void initState() {
    super.initState();
    isFavourite = widget.course.isFavourite;
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 150, 147, 147),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Wrap(
                      spacing: 8,
                      children: [
                        _buildTag('${course.liveClasses} Live Classes',
                            Colors.black, Colors.white),
                        _buildTag('${course.quizzes} Quiz',
                            Colors.grey.shade300, Colors.black),
                        _buildTag('${course.assignments} Ass',
                            Colors.grey.shade300, Colors.black),
                        _buildTag('${course.pdfs} Pdf', Colors.grey.shade300,
                            Colors.black),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavourite ? Icons.favorite : Icons.favorite_border,
                      color: isFavourite
                          ? const Color.fromARGB(255, 205, 78, 69)
                          : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavourite = !isFavourite;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '${course.chapters} chapters/${course.lectures} lectures',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: course.progress,
                        backgroundColor: Colors.grey.shade300,
                        color: Colors.grey.shade700,
                        minHeight: 8,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${(course.progress * 100).toInt()}%',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.arrow_right_alt, size: 24),
                      const Text('Valid till ',
                          style: TextStyle(color: Colors.black54)),
                      Text(
                        _formatDate(course.validTill),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Purchased On',
                          style: TextStyle(color: Colors.black54)),
                      Text(
                        _formatDate(course.purchaseDate),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        CourseDesc(
          description: course.description,
          completionPercent: course.completionPercent,
          durationLeft: course.durationLeft,
        ),
      ],
    );
  }

  Widget _buildTag(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 10, color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day} ${_monthName(date.month)} ${date.year}";
  }

  String _monthName(int month) {
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

class CourseDesc extends StatelessWidget {
  final String description;
  final int completionPercent;
  final String durationLeft;

  const CourseDesc({
    super.key,
    required this.description,
    required this.completionPercent,
    required this.durationLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          "Course Description",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Completed $completionPercent%",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text(
              durationLeft,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        )
      ],
    );
  }
}
