import 'package:first_project/Utils/dynamic_size.dart';
import 'package:first_project/widgets/models.dart';
import 'package:flutter/material.dart';
import 'package:first_project/pages/account_screen.dart';
import 'package:first_project/pages/drawer_page.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new notifications')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountScreen()),
              );
            },
          ),
        ],
      ),
      drawer: MyDrawer(
        user: UserModel(
          name: 'Ananya',
          email: 'ananya@gmail.com',
          profileImageUrl:
              'https://newprofilepic.photo-cdn.net//assets/images/article/profile.jpg?90af0c8',
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            _GreetingSection(userName: "Ananya"),
            SizedBox(height: 20),
            _AddBanner(),
            _LastPurchasedSection(),
            SizedBox(height: 8),
            _UpcomingClasses(),
            _PromotionalItems(),
            _Transactions(),
            _SellingCourses(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });

          // Navigate using GoRouter
          switch (index) {
            case 0:
              context.push('/Dashboard');
              break;
            case 1:
              context.push('/BrowseCourses');
              break;
            case 2:
              context.push('/MyCourses');
              break;
            case 3:
              context.push('/drawerProfile');
              break;
          }
        },
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final List<_NavItem> items = [
      _NavItem(icon: Icons.dashboard, label: 'Dashboard'),
      _NavItem(icon: Icons.public, label: 'Browse courses'),
      _NavItem(icon: Icons.school, label: 'My Courses'),
      _NavItem(icon: Icons.person, label: 'Profile'),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isSelected = index == selectedIndex;
          final item = items[index];

          return GestureDetector(
            onTap: () => onItemTapped(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor:
                      isSelected ? Colors.black87 : Colors.grey.shade400,
                  child: Icon(
                    item.icon,
                    color: isSelected ? Colors.white : Colors.black54,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? Colors.black : Colors.grey,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  _NavItem({required this.icon, required this.label});
}

class _GreetingSection extends StatelessWidget {
  final String userName;
  const _GreetingSection({required this.userName});

  @override
  Widget build(BuildContext context) {
    final size = AppSizes(context);
    return Padding(
      padding: size.cardPadding(horizontal: 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi $userName!",
                style: TextStyle(
                  fontSize: size.fontSize(0.06),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "What do you want to learn today?",
                style: TextStyle(fontSize: size.fontSize(0.035)),
              ),
            ],
          ),
          CircleAvatar(
            radius: size.avatarRadius(0.08),
            backgroundImage: const AssetImage("assets/images/Ananya.jpg"),
          ),
        ],
      ),
    );
  }
}

class _AddBanner extends StatelessWidget {
  const _AddBanner();

  @override
  Widget build(BuildContext context) {
    final size = AppSizes(context);
    return Padding(
      padding: size.cardPadding(horizontal: 0.04),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: size.containerHeight(0.2),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              "https://media.licdn.com/dms/image/v2/D5612AQGdRZ94KiT1WQ/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1674491764471?e=2147483647&v=beta&t=S-r5AKObUXjUFcscLYVbMAXJdszCaKFASy0PWrpHMcg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: size.containerHeight(0.2),
            ),
          ),
        ),
      ),
    );
  }
}


class _LastPurchasedSection extends StatelessWidget {
  const _LastPurchasedSection();

  @override
  Widget build(BuildContext context) {
    final size = AppSizes(context);
    String courseName = "Flutter Basics";
    String purchaseDate = "11th Mar 2025";
    String progress = "89%";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: size.cardPadding(horizontal: 0.04, vertical: 0.012),
          child: Text(
            "Last Purchased",
            style: TextStyle(
              fontSize: size.fontSize(0.042),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: size.cardPadding(horizontal: 0.04),
          child: Container(
            padding: size.buttonPadding(),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 150, 146, 146),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courseName,
                      style: TextStyle(
                        fontSize: size.fontSize(0.04),
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: size.sizedBoxHeight(0.005)),
                    Text(
                      "Purchased on $purchaseDate",
                      style: TextStyle(
                        fontSize: size.fontSize(0.03),
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: size.containerWidth(0.1),
                  height: size.containerWidth(0.1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      progress,
                      style: TextStyle(
                        fontSize: size.fontSize(0.035),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


class _UpcomingClasses extends StatelessWidget {
  const _UpcomingClasses();

  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes(context);
    return Padding(
      padding: sizes.cardPadding(horizontal: 0.04, vertical: 0.012),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLargeCard(context, sizes),
          SizedBox(width: sizes.sizedBoxWidth(0.025)),
          _buildSmallCards(context, sizes),
        ],
      ),
    );
  }

  Widget _buildLargeCard(BuildContext context, AppSizes sizes) {
    return Expanded(
      flex: 6,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: sizes.containerHeight(0.2),
          padding: sizes.cardPadding(horizontal: 0.03, vertical: 0.015),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(sizes.containerWidth(0.025)),
            color: Colors.grey[300],
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upcoming & Live Classes",
                    style: TextStyle(
                      fontSize: sizes.fontSize(0.043),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: sizes.sizedBoxHeight(0.004)),
                  Text(
                    "Schedule Class title",
                    style: TextStyle(
                      fontSize: sizes.fontSize(0.035),
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: sizes.sizedBoxHeight(0.003)),
                  Text(
                    "Today at 5PM to 7PM",
                    style: TextStyle(
                      fontSize: sizes.fontSize(0.03),
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.network(
                  "https://www.globalcareercounsellor.com/blog/wp-content/uploads/2018/05/Online-Career-Counselling-course.jpg",
                  width: sizes.containerWidth(0.16),
                  height: sizes.containerWidth(0.16),
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmallCards(BuildContext context, AppSizes sizes) {
    return Expanded(
      flex: 4,
      child: Column(
        children: [
          _SmallCard(
            title: "Pending Quizzes",
            subtitle: "Quiz Name",
            bottomText: "Total No.of quizzes",
            sizes: sizes,
          ),
          SizedBox(height: sizes.sizedBoxHeight(0.012)),
          _SmallCard(
            title: "Test & Quiz",
            subtitle: "150 Total Questions | 2hrs",
            sizes: sizes,
          ),
        ],
      ),
    );
  }
}

class _SmallCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? bottomText;
  final AppSizes sizes;

  const _SmallCard({
    required this.title,
    required this.subtitle,
    required this.sizes,
    this.bottomText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: sizes.containerHeight(0.095),
        padding: sizes.cardPadding(horizontal: 0.03, vertical: 0.015),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(sizes.containerWidth(0.025)),
          color: Colors.grey[300],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: sizes.fontSize(0.035),
                        fontWeight: FontWeight.w600)),
                SizedBox(height: sizes.sizedBoxHeight(0.002)),
                Text(subtitle,
                    style: TextStyle(
                        fontSize: sizes.fontSize(0.025),
                        fontWeight: FontWeight.w600,
                        color: Colors.black54)),
                if (bottomText != null)
                  Text(bottomText!,
                      style: TextStyle(
                          fontSize: sizes.fontSize(0.022),
                          fontWeight: FontWeight.w600,
                          color: Colors.black45)),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Icon(Icons.bookmark_border,
                  size: sizes.iconSize(0.045), color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class _Transactions extends StatelessWidget {
  const _Transactions();

  @override
  Widget build(BuildContext context) {
    return const _UpcomingClasses().build(context);
  }
}

class _PromotionalItems extends StatelessWidget {
  const _PromotionalItems();

  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes(context);
    return _Card(
      title: "Promotional Items",
      icon: Icons.arrow_forward_ios,
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Promotional items tapped!",
              style: TextStyle(fontSize: sizes.fontSize(0.035)),
            ),
          ),
        );
      },
    );
  }
}


class _SellingCourses extends StatelessWidget {
  const _SellingCourses();

  @override
  Widget build(BuildContext context) {
    return _Card(
      title: "Selling Courses",
      subtitle: "Till Now",
      icon: Icons.arrow_forward_ios,
      onTap: () {
        context.push('/sellingcourses');
      },
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const _Card({
    required this.title,
    this.subtitle,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes(context);

    return Padding(
      padding: sizes.cardPadding(horizontal: 0.04, vertical: 0.012),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: sizes.cardHeight(0.09),
          padding: sizes.cardPadding(horizontal: 0.04, vertical: 0.015),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(sizes.containerWidth(0.025)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: sizes.fontSize(0.045),
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: sizes.fontSize(0.03),
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
              Icon(
                icon,
                color: Colors.white.withOpacity(0.5),
                size: sizes.iconSize(0.045),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
