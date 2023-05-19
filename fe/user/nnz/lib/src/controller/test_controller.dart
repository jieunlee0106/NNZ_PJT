import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  static TestController get to => Get.find();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  @override
  void onInit() {
    _initNotification();
    _getToken();
    super.onInit();
  }

  Future<void> _getToken() async {
    try {
      final token = await firebaseMessaging.getToken();
      print("토큰 $token");
    } catch (e) {}
  }

  void _initNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // 앱이 foreground에서 실행 중일 때 푸시 알림 수신
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // 앱이 background에서 실행 중이거나 종료된 상태에서 푸시 알림 수신 후 앱을 열 때
      print('A new onMessageOpenedApp event was published!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }
}
