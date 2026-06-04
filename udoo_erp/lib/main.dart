// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udoo_erp/provider/auth_provider.dart';
import 'package:udoo_erp/provider/notifications_provider.dart';
import 'package:udoo_erp/provider/project_provider.dart';
import 'package:udoo_erp/provider/task_provider.dart';
import 'package:udoo_erp/provider/team_provider.dart';
import 'package:udoo_erp/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProjectProvider()),
        ChangeNotifierProvider(create: (_) => TeamProvider()),
        ChangeNotifierProvider(create: (_) => NotificationsProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],

      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Integration',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
