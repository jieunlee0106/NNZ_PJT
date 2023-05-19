// import 'package:nnz/src/controller/notification_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nnz/src/components/icon_data.dart';
// import 'package:nnz/src/controller/find_password_controller.dart';

// class NotificationPage extends StatelessWidget {
//   final NotificationController controller = Get.put(NotificationController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color: Colors.black),
//         title: Center(child: Image.asset(ImagePath.logo, width: 80)),
//         actions: [Icon(Icons.more_vert)],
//       ),
//       body: Obx(() => ListView.builder(
//             itemCount: controller.notifications.length,
//             itemBuilder: (context, index) {
//               final notification = controller.notifications[index];
//               return ListTile(
//                 title: Text(notification.title),
//                 subtitle: Text(notification.message),
//                 trailing: notification.read
//                     ? Icon(Icons.check_circle, color: Colors.green)
//                     : null,
//                 onTap: () {
//                   controller.markAsRead(notification);
//                 },
//               );
//             },
//           )),
//     );
//   }
// }
