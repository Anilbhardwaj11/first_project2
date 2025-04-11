import 'package:first_project/courses/browse_courses.dart';
import 'package:first_project/courses/course_dashboard.dart';
import 'package:first_project/courses/course_detail.dart';
import 'package:first_project/courses/course_name.dart';
import 'package:first_project/courses/my_courses.dart';
import 'package:first_project/courses/video_player.dart';
import 'package:first_project/pages/dashboard_screen.dart';
import 'package:first_project/pages/login_screen.dart';
import 'package:first_project/pages/otp_screen.dart';
import 'package:first_project/pages/profile.dart';
import 'package:first_project/widgets/videoplayerwidgets/lecture_screen.dart';
import 'package:first_project/widgets/videoplayerwidgets/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: LoginScreen(),
          );
        },
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: OtpScreen(),
          );
        },
      ),
      GoRoute(
        path: '/verify',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: DashboardScreen(),
          );
        },
      ),
      GoRoute(
        path: '/sellingcourses',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: CourseDashboard(),
          );
        },
      ),
      GoRoute(
        path: '/drawerDashboard',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: CourseDashboard(),
          );
        },
      ),
      GoRoute(
        path: '/drawerProfile',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: ProfilePage(),
          );
        },
      ),
      // bottom Naviagtion Bar
      GoRoute(
        path: '/Dashboard',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: CourseDashboard(),
          );
        },
      ),
      GoRoute(
        path: '/BrowseCourses',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: BrowseCourses(),
          );
        },
      ),
      GoRoute(
        path: '/MyCourses',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: MyCourses(),
          );
        },
      ),
      GoRoute(
        path: '/CourseName',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: CourseName(),
          );
        },
      ),
      GoRoute(
        path: '/seeall',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: AllLecturesScreen(lectures: lectures),
          );
        },
      ),
      GoRoute(
        path: '/playedvideo',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child:CourseVideoPage(),
          );
        },
      ),
      GoRoute(
        path: '/courseDetails',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child:CourseDetailsScreen(),
          );
        },
      ),
    ],
  );
}
