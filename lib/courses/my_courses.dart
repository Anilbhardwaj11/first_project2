import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyCourses extends StatelessWidget {
  const MyCourses({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = [
      Course(
        name: 'Flutter Basics',
        purchaseDate: '27 Mar 2025',
        liveClasses: 40,
        quizzes: 20,
        assignments: 15,
        pdfs: 10,
        progress: 0.71,
        chapterInfo: '12 chapters / 36 lectures',
        validity: '90Days',
      ),
      Course(
        name: 'Advanced Dart',
        purchaseDate: '20 Feb 2025',
        liveClasses: 30,
        quizzes: 18,
        assignments: 12,
        pdfs: 8,
        progress: 0.45,
        chapterInfo: '10 chapters / 25 lectures',
        validity: '60Days',
      ),
      Course(
        name: 'UI Design',
        purchaseDate: '10 Jan 2025',
        liveClasses: 25,
        quizzes: 10,
        assignments: 5,
        pdfs: 4,
        progress: 0.88,
        chapterInfo: '8 chapters / 20 lectures',
        validity: '120Days',
      ),
      Course(
        name: 'Firebase Crash Course',
        purchaseDate: '05 Mar 2025',
        liveClasses: 35,
        quizzes: 22,
        assignments: 10,
        pdfs: 6,
        progress: 0.62,
        chapterInfo: '14 chapters / 30 lectures',
        validity: '75Days',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ProfileAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              children:
                  courses.map((course) => CourseCard(course: course)).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

// Course Model
class Course {
  final String name;
  final String purchaseDate;
  final int liveClasses;
  final int quizzes;
  final int assignments;
  final int pdfs;
  final double progress;
  final String chapterInfo;
  final String validity;

  Course({
    required this.name,
    required this.purchaseDate,
    required this.liveClasses,
    required this.quizzes,
    required this.assignments,
    required this.pdfs,
    required this.progress,
    required this.chapterInfo,
    required this.validity,
  });
}

// CourseCard Widget
class CourseCard extends StatefulWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(22),
        border:
            Border.all(width: 1, color: const Color.fromARGB(255, 99, 97, 97)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  course.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Purchased On',
                          style: TextStyle(fontSize: 12)),
                      Text(
                        course.purchaseDate,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isFavorite 
                                ? 'Added ${course.name} to favorites' 
                                : 'Removed ${course.name} from favorites',
                          ),
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.black,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Tags Row
          Row(
            children: [
              tag('${course.liveClasses}', 'Live Classes', Colors.black),
              const SizedBox(width: 6),
              tag('${course.quizzes}', 'Quiz', Colors.grey),
              const SizedBox(width: 6),
              tag('${course.assignments}', 'Ass', Colors.grey),
              const SizedBox(width: 6),
              tag('${course.pdfs}', 'Pdf', Colors.grey),
            ],
          ),
          const SizedBox(height: 16),

          // Progress Row
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: course.progress,
                  backgroundColor: Colors.grey[300],
                  color: Colors.grey[700],
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Text('${(course.progress * 100).round()}%'),
            ],
          ),
          const SizedBox(height: 8),

          Text(
            course.chapterInfo,
            style: const TextStyle(
              color: Color.fromARGB(255, 112, 110, 110),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),

          // Bottom Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('Validity'),
                  const SizedBox(width: 8),
                  Text(
                    course.validity,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  context.push('/courseDetails');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700],
                ),
                child: const Text(
                  'View',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Course Detail Page
class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.name),
        backgroundColor: Colors.grey[700],
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
            // Course progress
            Text(
              'Course Progress: ${(course.progress * 100).round()}%',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: course.progress,
              backgroundColor: Colors.grey[300],
              color: Colors.grey[700],
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
            ),
            const SizedBox(height: 30),
            
            // Course details
            detailRow('Chapters & Lectures:', course.chapterInfo),
            detailRow('Live Classes:', '${course.liveClasses}'),
            detailRow('Quizzes:', '${course.quizzes}'),
            detailRow('Assignments:', '${course.assignments}'),
            detailRow('PDF Materials:', '${course.pdfs}'),
            detailRow('Purchase Date:', course.purchaseDate),
            detailRow('Validity:', course.validity),
            
            const Spacer(),
            
            // Resume button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Show a dialog when resume button is pressed
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Course Content'),
                        content: Text('Opening ${course.name} content...'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('RESUME COURSE', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Helper method for detail rows
  Widget detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// Tag Helper Widget
Widget tag(String number, String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
    ),
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: number,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const TextSpan(text: ' '),
          TextSpan(
            text: label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    ),
  );
}

// Custom AppBar
class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "My Courses",
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