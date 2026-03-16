// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:udoo_erp/firebase_options.dart';
import 'package:udoo_erp/route/app_route.dart';

import 'route/app_pages.dart';
import 'route/app_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mobile Integration',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.login,
      getPages: AppPages.pages,
    );
  }
}
