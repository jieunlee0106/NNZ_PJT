import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/bindings/init_bindings.dart';
import 'package:nnz/src/pages/share/my_shared_detail.dart';
import 'package:nnz/src/pages/share/my_shared_info.dart';
import 'package:nnz/src/pages/share/sharing_register.dart';
import 'package:nnz/src/pages/user/find_password.dart';
import 'package:nnz/src/pages/user/login.dart';
import 'package:nnz/src/pages/user/profile_edit.dart';
import 'package:nnz/src/pages/user/register.dart';
import 'package:nnz/src/pages/user/register_form.dart';
import 'package:nnz/src/pages/user/mypage.dart';
import 'package:nnz/src/pages/home/home.dart';
import 'package:nnz/src/pages/share/sharing_detail.dart';
import 'package:nnz/src/pages/share/my_shared_list.dart';
import 'package:nnz/src/pages/share/my_sharing_list.dart';

import 'package:nnz/src/pages/category/concert.dart';
import 'package:nnz/src/pages/category/musical.dart';

import 'src/app.dart';
import 'src/config/config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
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
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
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
      initialRoute: "/myShareInfo",
      getPages: [
        GetPage(
          name: "/",
          page: () => const App(),
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
            page: () => SharingDetail(),
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
          page: () => MySharedDetail(),
        ),
        GetPage(
          name: "/myShareInfo",
          page: () => const MySharedInfo(),
        )
      ],
    );
  }
}
