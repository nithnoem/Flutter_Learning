// import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
//import 'package:udoo_erp/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:udoo_erp/provider/project_provider.dart';
import 'package:udoo_erp/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://bwfcqhgiiihfetlrpfwv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ3ZmNxaGdpaWloZmV0bHJwZnd2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQ0MDYwNjMsImV4cCI6MjA4OTk4MjA2M30.Fix8afRUxaRTy7OCmvGoD1WHCcii3E4EGjZ1zRttb_o',
  );
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProjectProvider())],
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
