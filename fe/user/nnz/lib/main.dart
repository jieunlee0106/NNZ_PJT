import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/bindings/init_bindings.dart';
import 'package:nnz/src/pages/share/sharing_register.dart';
import 'package:nnz/src/pages/user/find_password.dart';
import 'package:nnz/src/pages/user/login.dart';
import 'package:nnz/src/pages/user/register.dart';
import 'package:nnz/src/pages/user/register_form.dart';

import 'src/app.dart';
import 'src/config/config.dart';

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
      debugShowCheckedModeBanner: false,
      initialBinding: InitBindings(),
      initialRoute: "/",
      getPages: [
        GetPage(
          name: "/",
          page: () => const App(),
        ),
        GetPage(
          name: "/register",
          page: () => const Register(),
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
          page: () => const FindPassword(),
          transition: Transition.native,
        ),
        GetPage(
          name: "/termsOfUse",
          page: () => const FindPassword(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: "/sharingRegister",
          page: () => SharingRegister(),
          transition: Transition.native,
        )
      ],
    );
  }
}