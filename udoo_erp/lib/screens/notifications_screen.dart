// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:udoo_erp/provider/notifications_provider.dart';
//
// class NotificationsScreen extends StatefulWidget {
//   const NotificationsScreen({super.key});
//   @override
//   State<NotificationsScreen> createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationsScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       Provider.of<NotificationsProvider>(
//         context,
//         listen: false,
//       ).fetchNotification();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print("NotificationsScreen BUILD");
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       body: Consumer<NotificationsProvider>(
//         builder: (context, provider, child) {
//           if (provider.isLoading) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (provider.notifications.isEmpty) {
//             return Center(child: Text("Notifications"));
//           }
//           return ListView.builder(
//             padding: EdgeInsets.all(16),
//             itemCount: provider.notifications.length,
//             itemBuilder: (context, index) {
//               final n = provider.notifications[index];
//
//               return GestureDetector(
//                 onTap: () {
//                   provider.markAsRead(n.id);
//                 },
//                 child: Container(
//                   margin: EdgeInsets.only(bottom: 12),
//                   padding: EdgeInsets.all(14),
//                   decoration: BoxDecoration(
//                     color: n.isRead ? Colors.white : Colors.orange.shade50,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(Icons.notifications, color: Colors.orange),
//                       SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               n.title,
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             Text(n.body),
//                             Text(
//                               "${n.createdAt.hour}:${n.createdAt.minute}",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       if (!n.isRead)
//                         Container(
//                           width: 8,
//                           height: 8,
//                           decoration: BoxDecoration(
//                             color: Colors.red,
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udoo_erp/provider/auth_provider.dart';
import 'package:udoo_erp/provider/notifications_provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final token = Provider.of<AuthProvider>(context, listen: false).token;
      if (token != null) {
        Provider.of<NotificationsProvider>(
          context,
          listen: false,
        ).fetchNotification(token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Consumer<NotificationsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.notifications.isEmpty) {
            return const Center(child: Text("No Notifications Yet"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.notifications.length,
            itemBuilder: (context, index) {
              final notiIn = provider.notifications[index];
              final authProvider = Provider.of<AuthProvider>(
                context,
                listen: false,
              );

              return GestureDetector(
                onTap: () {
                  if (authProvider.token != null) {
                    provider.markAsRead(authProvider.token!, notiIn.id);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: notiIn.isRead ? Colors.white : Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: notiIn.isRead
                        ? null
                        : Border.all(color: Colors.orange.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.notifications, color: Colors.orange),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notiIn.data['title'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              notiIn.data['message'] ??
                                  'View details in your dashboard',
                            ),
                            Text(
                              "${notiIn.createdAt.hour.toString().padLeft(2, '0')}:${notiIn.createdAt.minute}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!notiIn.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
