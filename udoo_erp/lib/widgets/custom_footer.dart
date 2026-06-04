import 'package:flutter/material.dart';

class CostomFooter extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CostomFooter({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.message_outlined),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notification_add_outlined),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.percent_outlined),
          label: 'Profile',
        ),
      ],
    );
  }
}
