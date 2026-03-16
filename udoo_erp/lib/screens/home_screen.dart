import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udoo_erp/route/app_route.dart';
import 'package:udoo_erp/widgets/approval_card.dart';
import 'package:udoo_erp/widgets/kpi_card.dart';
import 'package:udoo_erp/widgets/leaves_card.dart';
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
    return Container(
      color: Colors.grey.shade200,
      child: Column(
        children: [
          _appBar,
          Expanded(
            child: Container(
              color: Colors.grey.shade50,
              child: ListView(
                children: [
                  _wel_msg,
                  SizedBox(height: 16),
                  _your_work,
                  SizedBox(height: 20),
                  _quickAccess,
                ],
              ),
            ),
          ),
        ],
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

  Widget get _quickAccess {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Access',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
            children: [
              _quickItem(
                Icons.checklist,
                'Project Task',
                Colors.orange,
                AppRoute.project_task,
              ),
              _quickItem(
                Icons.verified,
                'Approval Request',
                Colors.blue,
                AppRoute.project_task,
              ),
              _quickItem(
                Icons.calendar_today,
                'Leave',
                Colors.red,
                AppRoute.project_task,
              ),
              _quickItem(
                Icons.bar_chart,
                'KPT',
                Colors.green,
                AppRoute.project_task,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickItem(IconData icon, String title, Color color, String route) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(route);
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          SizedBox(height: 6),
          SizedBox(
            width: 70,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _menuTabs {
    return TabBar(
      controller: _tabController,
      isScrollable: false,
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
      height: 200,
      child: TabBarView(
        controller: _tabController,
        children: [_taskView, _pendingApproval, _leaveRequest, _kpiView],
      ),
    );
  }

  Widget get _taskView {
    return ListView(
      physics: BouncingScrollPhysics(),
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
      physics: BouncingScrollPhysics(),
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

  Widget get _leaveRequest {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        LeavesCard(
          title: 'Summer Vacation',
          status: 'Pending',
          type: 'Annual Leave',
          duration: '3 days',
          start: '13-02-2026',
          due: '14-02-2026',
        ),
      ],
    );
  }

  Widget get _kpiView {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        KpiCard(
          title: 'Sales Performance',
          type: 'Monthly target',
          average: 50,
        ),
        SizedBox(height: 10),
        KpiCard(
          title: 'Customer Satisfaction',
          type: 'Average rating score',
          average: 80,
        ),
      ],
    );
  }
}
