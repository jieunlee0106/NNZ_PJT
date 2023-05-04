import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:twitter_login/twitter_login.dart';

class TwitterController extends GetxController {
  late final twitterLogin = TwitterLogin(
      apiKey: 'Py5cGhPQyRt1kzrvQzmGuu9Ox',
      apiSecretKey: 'MLraP08zkwSc2G3ToamG5E9qmKj1oksHPXnOqLxOlTIp5sDn0V',
      redirectURI: 'twittercallback://');
  String name = '';
  String email = '';
  String imageUrl = '';

  final logger = Logger();

  Future twitter() async {
    try {
      var response = await twitterLogin.login();
      if (response.status == TwitterLoginStatus.loggedIn) {
        final authToken = response.authToken!;
        final authTokenSecret = response.authTokenSecret!;
      }
      logger.i(response.user!.thumbnailImage);
      logger.i(response.user!.id);
      logger.i(response.user!.name);
      logger.i(response.user!.screenName);
      logger.i(response.status);
      logger.i(response.authToken);
      logger.i(response.authTokenSecret);
    } catch (e) {
      logger.e(e);
    }
  }
}
