import 'package:flutter/material.dart';
import 'package:udoo_erp/widgets/approval_card.dart';
import 'package:udoo_erp/widgets/task_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _menuTabs,
          SizedBox(height: 16),
          _tabHeader,
          SizedBox(height: 16),
          _menuContent,
        ],
      ),
    );
  }

  Widget get _menuTabs {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      labelColor: Colors.orange,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.orange,
      indicatorWeight: 2,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      tabs: [
        Tab(text: 'Task'),
        Tab(text: 'Approvals'),
        Tab(text: 'Leave'),
        Tab(text: 'KPI'),
      ],
    );
  }

  Widget get _tabHeader {
    return AnimatedBuilder(
      animation: _tabController,
      builder: (context, _) {
        switch (_tabController.index) {
          case 0:
            return Row(
              children: [
                Text(
                  'Your Task',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Spacer(),
                Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: Colors.grey,
                ),
              ],
            );
          case 1:
            return Row(
              children: [
                Text(
                  'Pending Approvals',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View All',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ],
            );
          case 2:
            return Row(
              children: [
                Text(
                  'Pending Leaves',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                TextButton(onPressed: () {}, child: Text('View All')),
              ],
            );
          case 3:
            return Row(
              children: [
                Text(
                  'KPI Overview',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                TextButton(onPressed: () {}, child: Text('View ALl')),
              ],
            );
          default:
            return SizedBox.shrink();
        }
      },
    );
  }

  Widget get _menuContent {
    return SizedBox(
      height: 400,
      child: TabBarView(
        controller: _tabController,
        children: [
          _taskView,
          _pendingApproval,
          Center(child: Text('Leave')),
          Center(child: Text('KPI')),
        ],
      ),
    );
  }

  Widget get _taskView {
    return ListView(
      children: [
        TaskCard(
          progress: 10,
          title: 'Test',
          start: '2/10/2026',
          due: '2/31/2026',
        ),
        SizedBox(height: 10),
        TaskCard(
          progress: 30,
          title: 'Test Two',
          start: '2/10/2026',
          due: '2/31/2026',
        ),
      ],
    );
  }

  Widget get _pendingApproval {
    return ListView(
      children: [
        ApprovalCard(
          title: 'Office Equipment Purchase',
          type: 'Purchase Request (PR)',
          amount: 2500,
          date: '01-01-2026',
          status: 'Pending',
        ),
      ],
    );
  }
}
