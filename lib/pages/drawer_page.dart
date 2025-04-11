import 'package:first_project/Utils/dynamic_size.dart';
import 'package:first_project/pages/profile.dart';
import 'package:first_project/widgets/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyDrawer extends StatelessWidget {
  final UserModel user;

  const MyDrawer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes(context);

    return Drawer(
      child: Container(
        color: const Color(0xFF666666),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: sizes.containerWidth(0.04),
                  vertical: sizes.containerHeight(0.025),
                ),
                color: const Color(0xFF666666),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: sizes.iconSize(0.06),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: sizes.sizedBoxHeight(0.012)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: sizes.avatarRadius(0.11),
                          backgroundImage: NetworkImage(user.profileImageUrl),
                        ),
                        SizedBox(width: sizes.sizedBoxWidth(0.04)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: sizes.fontSize(0.045),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: sizes.sizedBoxHeight(0.005)),
                            Text(
                              user.email,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: sizes.fontSize(0.035),
                              ),
                            ),
                            SizedBox(height: sizes.sizedBoxHeight(0.01)),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfilePage()),
                                );
                              },
                              child: Container(
                                width: sizes.containerWidth(0.3),
                                padding: EdgeInsets.symmetric(
                                  vertical: sizes.containerHeight(0.012),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    'Edit Profile',
                                    style: TextStyle(
                                      fontSize: sizes.fontSize(0.035),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: sizes.sizedBoxHeight(0.02)),
                    _buildDrawerItem(context, sizes, Icons.person, 'My Profile',
                        () {
                      context.push('/drawerProfile');
                    }),
                    _buildDrawerItem(context, sizes, Icons.book, 'My Learnings',
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ProfilePage()));
                    }),
                    _buildDrawerItem(
                        context, sizes, Icons.dashboard, 'Course Dashboard',
                        () {
                      context.push('/drawerDashboard');
                    }),
                    _buildDrawerItem(context, sizes, Icons.quiz, 'Test & Quiz',
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ProfilePage()));
                    }),
                    _buildDrawerItem(
                        context, sizes, Icons.language, 'Language', () {}),
                    _buildDrawerItem(
                        context, sizes, Icons.payment, 'Transactions', () {}),
                    _buildDrawerItem(
                        context, sizes, Icons.notifications, 'Notice', () {}),
                    _buildDrawerItem(
                        context, sizes, Icons.star_rate, 'Rate this app', () {
                      // Add rating logic
                    }),
                    _buildDrawerItem(
                        context, sizes, Icons.share, 'Share this app', () {
                      // Add share logic
                    }),
                    _buildDrawerItem(context, sizes, Icons.settings, 'Settings',
                        () {
                      Navigator.pushNamed(context, '/settings');
                    }),
                    _buildDrawerItem(context, sizes, Icons.logout, 'Logout',
                        () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Logout'),
                          content:
                              const Text('Are you sure you want to logout?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushReplacementNamed(
                                    context, '/login');
                              },
                              child: const Text('Logout'),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, AppSizes sizes, IconData icon,
      String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon,
          color: Colors.white, size: sizes.iconSize(0.06)), // ~24 on width 400
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: sizes.fontSize(0.04), // ~16 on width 400
        ),
      ),
      onTap: onTap,
    );
  }
}
