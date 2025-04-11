import 'package:first_project/Utils/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

final AppRouter _appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.router,
    );
  }
}
