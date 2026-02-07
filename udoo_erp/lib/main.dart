// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udoo_erp/screens/home_screen.dart';
import 'package:udoo_erp/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mobile Integration',
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
      ],
    );
  }
}
