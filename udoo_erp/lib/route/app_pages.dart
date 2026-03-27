import 'package:get/get.dart';
import 'package:udoo_erp/main.dart';
import 'package:udoo_erp/screens/login_screen.dart';
import 'package:udoo_erp/screens/main_screen.dart';
import 'package:udoo_erp/screens/project_task/project_form_screen.dart';
import 'package:udoo_erp/screens/project_task/project_task_screen.dart';
import 'app_route.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoute.login, page: () => const LoginScreen()),
    GetPage(name: AppRoute.main, page: () => const MainScreen()),
    GetPage(name: AppRoute.project_task, page: () => const ProjectTaskScreen()),
    GetPage(
      name: AppRoute.create_project,
      page: () => const ProjectFormScreen(),
    ),
  ];
}
