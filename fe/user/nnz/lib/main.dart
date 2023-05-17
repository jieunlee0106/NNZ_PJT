import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nnz/src/bindings/init_bindings.dart';
import 'package:nnz/src/components/other_user_from/other_user_profile_twitter.dart';
import 'package:nnz/src/components/sharing_detail/test_infinite.dart';
import 'package:nnz/src/components/test_message/firebase_message.dart';
import 'package:nnz/src/pages/home/likes_page.dart';
import 'package:nnz/src/pages/search/propose_show.dart';
import 'package:nnz/src/pages/share/my_shared_detail.dart';
import 'package:nnz/src/pages/share/my_shared_info.dart';
import 'package:nnz/src/pages/share/my_shared_info_form.dart';
import 'package:nnz/src/pages/share/my_shared_qrleader.dart';
import 'package:nnz/src/pages/share/my_snappingtest.dart';
import 'package:nnz/src/pages/share/new_share_info_detail.dart';
import 'package:nnz/src/pages/share/share_detail.dart';
import 'package:nnz/src/pages/share/sharing_complete.dart';
import 'package:nnz/src/pages/share/sharing_perform.dart';
import 'package:nnz/src/pages/share/sharing_register.dart';
import 'package:nnz/src/pages/user/alarm.dart';
import 'package:nnz/src/pages/user/find_password.dart';
import 'package:nnz/src/pages/user/login.dart';
import 'package:nnz/src/pages/user/other_profile.dart';
import 'package:nnz/src/pages/user/profile_edit.dart';
import 'package:nnz/src/pages/user/register.dart';
import 'package:nnz/src/pages/user/register_form.dart';
import 'package:nnz/src/pages/user/mypage.dart';
import 'package:nnz/src/pages/home/home.dart';
import 'package:nnz/src/pages/share/my_shared_list.dart';
import 'package:nnz/src/pages/share/my_sharing_list.dart';

import 'package:nnz/src/pages/category/concert.dart';
import 'package:nnz/src/pages/category/musical.dart';

import 'src/app.dart';
import 'src/config/config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // 세로모드만 허용
    DeviceOrientation.portraitDown,
  ]);
  Get.config(
    enableLog: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Config.backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Config.blackColor,
          ),
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'EN'),
        Locale('ko', 'KR'),
      ],
      debugShowCheckedModeBanner: false,
      initialBinding: InitBindings(),
      initialRoute: "/home",
      getPages: [
        GetPage(
          name: "/",
          page: () => const App(),
        ),
        GetPage(
          name: "/test",
          page: () => FirebaseMessage(),
        ),
        GetPage(
          name: "/home",
          page: () => const Home(),
        ),
        GetPage(
          name: "/register",
          page: () => Register(),
        ),
        GetPage(
          name: "/registerForm",
          page: () => RegisterForm(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: "/login",
          page: () => Login(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: "/findPassword",
          page: () => FindPassword(),
          transition: Transition.native,
        ),
        GetPage(
          name: "/termsOfUse",
          page: () => FindPassword(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: "/sharingRegister",
          page: () => const SharingRegister(),
          transition: Transition.native,
        ),
        GetPage(
            name: "/sharingDetail",
            page: () => const ShareDatail(
                  nanumIds: 0,
                ),
            transition: Transition.rightToLeft),
        GetPage(
          name: "/myPage",
          page: () => const MyPage(),
        ),
        GetPage(
          name: "/mysharedList",
          page: () => const MySharedList(),
        ),
        GetPage(
          name: "/mysharingList",
          page: () => const MySharingList(),
        ),
        GetPage(
          name: "/profileEdit",
          page: () => const ProfileEdit(),
        ),
        GetPage(
          name: "/mySharedList",
          page: () => const MySharedList(),
        ),
        GetPage(
          name: "/mySharingList",
          page: () => const MySharingList(),
        ),
        GetPage(
          name: "/concertPage",
          page: () => const ConcertPage(),
        ),
        GetPage(
          name: "/musicalPage",
          page: () => const MusicalPage(),
        ),
        GetPage(
          name: "/stagePage",
          page: () => const ConcertPage(),
        ),
        GetPage(
          name: "/moviePage",
          page: () => const ConcertPage(),
        ),
        GetPage(
          name: "/sportsPage",
          page: () => const ConcertPage(),
        ),
        GetPage(
          name: "/esportsPage",
          page: () => const ConcertPage(),
        ),
        GetPage(
          name: "/myShareDetail",
          page: () => const MyShareDetail(
            nanumIds: 0,
          ),
        ),
        GetPage(
          name: "/proposeShow",
          page: () => ProposeShow(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: "/myShareInfo",
          page: () => const MySharedInfo(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: "/myShareInfoForm/:nanumIds",
          page: () => MySharedInfoForm(
            nanumIds: 0,
          ),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: "/sharingInfo",
          page: () => const SheetBelowTest(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: "/ShareQrLeader",
          page: () => const ShareQrLeader(
            nanumIds: 0,
          ),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: "/otherUserProfile/:userId",
          page: () => const OtherProfile(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: "/otherUserProfileTwitter",
          page: () => const OtherProfileTwitter(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: "/notification",
          page: () => NotificationPage(),
        ),
        GetPage(
          name: "/performDetail",
          page: () => const SharePerformDetail(
            showIds: 4399,
          ),
        ),
        GetPage(
          name: "/testing",
          page: () => const TestInfinite(
            showIds: 2,
          ),
        ),
        GetPage(
          name: "/shareComplete",
          page: () => const SharingComplete(),
        ),
        GetPage(
          name: "/otherShareInfo",
          page: () => const ShareInfoPage(),
        ),
        GetPage(
          name: "/likes",
          page: () => const LikesPage(),
        ),
      ],
    );
  }
}
