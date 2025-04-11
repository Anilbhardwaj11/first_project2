import 'package:first_project/widgets/browsecoursewidgets/browse_data.dart';
import 'package:first_project/widgets/browsecoursewidgets/browse_models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class BrowseCourses extends StatelessWidget {
  const BrowseCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Column(
              children: [
                const Searchbar(),
                const SizedBox(height: 10),
                CategoriesWidget(),
                const SizedBox(height: 10),
                BestSellingCourse(courses: dummyCourses),
                const SizedBox(height: 10),
                RecentUpdated(courses: dummyCourses),
                const SizedBox(height: 10),
                BestForYou(courses: dummyCourses),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoriesWidget extends StatelessWidget {
  final List<String> categories = [
    "Music", "Sports", "Movies", "Techii", "Gaming", "Fashion", "Foodyyy"
  ];

  CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text('Categories',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400)),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: categories.map((label) {
            return TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text(label, style: const TextStyle(color: Colors.black)),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class Searchbar extends StatelessWidget {
  const Searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[300],
          hintText: 'Search your courses',
          hintStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: const Icon(Icons.search, color: Colors.black54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
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
          "Browse Course",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 30, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class BestSellingCourse extends StatelessWidget {
  final List<CourseModel> courses;

  const BestSellingCourse({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return SectionList(title: "Best Selling Courses", courses: courses);
  }
}

class RecentUpdated extends StatelessWidget {
  final List<CourseModel> courses;

  const RecentUpdated({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return SectionList(title: "Recent Updated", courses: courses);
  }
}

class BestForYou extends StatelessWidget {
  final List<CourseModel> courses;

  const BestForYou({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return SectionList(title: "Best For You", courses: courses);
  }
}

class SectionList extends StatelessWidget {
  final String title;
  final List<CourseModel> courses;

  const SectionList({super.key, required this.title, required this.courses});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(title,
              style: const TextStyle(
                  color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400)),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return CourseCard(name: course.name, imageUrl: course.imageUrl);
            },
          ),
        ),
      ],
    );
  }
}

class CourseCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  const CourseCard({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/courseDetails');
      },
      child: Container(
        width: 180,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
