import 'package:first_project/courses/teacher_panel.dart';
import 'package:first_project/widgets/coursedetailwidgets/quiz_screen.dart';
import 'package:first_project/widgets/videoplayerwidgets/lecture_list.dart';
import 'package:flutter/material.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({super.key});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  int _selectedTabIndex = 0;
  final DateTime startDate = DateTime(2025, 3, 25);
  late final DateTime validTillDate;

  @override
  void initState() {
    super.initState();
    validTillDate =
        DateTime(startDate.year, startDate.month + 6, startDate.day);
  }

  String _formatDate(DateTime date) {
    final months = [
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
    return '${date.day}${_getDaySuffix(date.day)} ${months[date.month - 1]} ${date.year}';
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const ProfileAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CourseBanner(),
              const SizedBox(height: 16),
              const CourseTitle(),
              const SizedBox(height: 12),
              const CourseDesc(),
              const SizedBox(height: 16),
              const Text(
                'Course Created By',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              const CourseInstruction(),
              const SizedBox(height: 16),

              // Course duration section
              const Text(
                'Course Duration',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              const CourseDuration(),
              const SizedBox(height: 8),
              Text(
                'Started from ${_formatDate(startDate)}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Valid Till - ${_formatDate(validTillDate)}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 16),
              LectureTabs(
                selectedIndex: _selectedTabIndex,
                onTabSelected: (index) {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
              ),
              const SizedBox(height: 16),
              if (_selectedTabIndex == 0) const LectureList(),
              if (_selectedTabIndex == 1)
                const QuizListScreen(),
              if (_selectedTabIndex == 2)
                const Center(child: Text('Test content will appear here')),
              if (_selectedTabIndex == 3)
                const Center(
                    child: Text('Assignment content will appear here')),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const PaymentBottomBar(),
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
          "Course Details",
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

class CourseDuration extends StatefulWidget {
  const CourseDuration({super.key});

  @override
  State<CourseDuration> createState() => _CourseDurationState();
}

class _CourseDurationState extends State<CourseDuration> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.access_time,
          color: Colors.grey,
          size: 20,
        ),
        SizedBox(width: 8),
        Text(
          '6 Month',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class CourseInstruction extends StatefulWidget {
  const CourseInstruction({super.key});

  @override
  State<CourseInstruction> createState() => _CourseInstructionState();
}

class _CourseInstructionState extends State<CourseInstruction> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
          // child: Image.network(
          //   "https://assets.mypandit.com/wp-content/uploads/2025/01/Hrithik_Roshan.webp",
          //   fit: BoxFit.fill,
          // ),
        ),
        const SizedBox(width: 8),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const TeacherPanel(),
            );
          },
          child: const Text(
            "Mr John",
            style: TextStyle(color: Colors.black38),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '4.5',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              Icon(
                Icons.star,
                color: Colors.white,
                size: 12,
              ),
            ],
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            setState(() {
              isFavorite = !isFavorite;
            });
          },
          child: Row(
            children: [
              Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.black,
              ),
              const SizedBox(width: 4),
              const Text(
                'Like',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CourseDesc extends StatefulWidget {
  const CourseDesc({super.key});

  @override
  State<CourseDesc> createState() => _CourseDescState();
}

class _CourseDescState extends State<CourseDesc> {
  final String fullDescription =
      'Course Banner Image Course Banner Image Course Banner Image Course Banner Image Course Banner Image Course Banner Image. This is a longer description that should be truncated after a certain number of words.';

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final words = fullDescription.split(' ');
        final bool isLong = words.length > 15;
        final String shortDescription =
            words.take(15).join(' ') + (isLong ? '...' : '');

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _isExpanded || !isLong ? fullDescription : shortDescription,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            if (isLong)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    _isExpanded ? 'view less' : 'view more',
                    style: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class CourseTitle extends StatelessWidget {
  const CourseTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Course Title',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'description',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 4),
          child: const Row(
            children: [
              Text(
                '4.5 ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.star,
                color: Colors.black,
                size: 18,
              ),
              Text(
                ' | 105',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CourseBanner extends StatelessWidget {
  const CourseBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.network(
          "https://img.freepik.com/free-vector/hand-drawn-online-college-template-design_23-2150574159.jpg",
          fit: BoxFit.cover,
        ));
  }
}

class LectureTabs extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const LectureTabs({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  _LectureTabsState createState() => _LectureTabsState();
}

class _LectureTabsState extends State<LectureTabs> {
  late int selectedIndex;

  final List<String> buttonLabels = [
    "Lectures (74/82)",
    "Quiz (74/82)",
    "Test (74/82)",
    "Assignment (74/82)",
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 215, 210, 210),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(buttonLabels.length, (index) {
            final isSelected = selectedIndex == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: isSelected ? Colors.grey.shade400 : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: const Offset(0, 4),
                          blurRadius: 10,
                        ),
                      ]
                    : [],
                border: Border.all(
                  color: isSelected
                      ? const Color.fromARGB(255, 91, 89, 89)
                      : Colors.grey.shade300,
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  widget.onTabSelected(index);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    buttonLabels[index],
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class PaymentBottomBar extends StatelessWidget {
  const PaymentBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: const Color(0xFFE6E6E6),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          // Left side with offer and price
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Offer circle and text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Offer available',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      '18% OFF',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                // Price section
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Amount',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      '₹3,999/-',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Buy Now button
          Container(
            width: 140,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFF4A4A4A),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(
              child: Text(
                'Buy Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
