import 'package:flutter/material.dart';
import 'package:udoo_erp/widgets/task_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // String fullName = "guest";
  @override
  Widget build(BuildContext context) {
    print("Full Name: Nit");
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: _appBar,
      body: Container(
        color: Colors.grey.shade50,
        child: ListView(
          children: [
            _wel_msg,
            SizedBox(height: 16),
            _your_work,
            // _quick_access,
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget get _appBar {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 4.0,
      title: Row(
        children: [
          Image.asset('assets/images/Primary Logo.png', height: 40),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Odoo ERP',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 18,
            backgroundImage: const AssetImage('assets/images/profile.jpg'),
          ),
        ],
      ),
    );
  }

  Widget get _wel_msg {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 16, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back, John!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            'Here is what happening with your work, today',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget get _your_work {
    final tabs = ['Tasks', 'Approvals', 'Leave', 'KPI'];
    final selectedIndex = 0;

    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 0,
            blurRadius: 1,
            offset: Offset(0.2, 0.2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: List.generate(tabs.length, (index) {
              final selected = index == selectedIndex;
              return Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: selected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.orange : Colors.grey,
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 16),
          TaskCard(
            title: 'KEY-06Title',
            progress: 10,
            start: '29-08-2025',
            due: '10-09-2025',
          ),
        ],
      ),
    );
  }
}
