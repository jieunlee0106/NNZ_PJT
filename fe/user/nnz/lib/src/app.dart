import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/pages/home/home.dart';
import 'package:nnz/src/pages/home/likes_page.dart';
import 'package:nnz/src/pages/search/search.dart';
import 'package:nnz/src/pages/user/mypage.dart';

import 'components/icon_data.dart';
import 'controller/bottom_nav_controller.dart';

class App extends GetView<BottomNavController> {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: controller.willPopAction,
        child: Obx(() {
          return Scaffold(
            body: IndexedStack(
              index: controller.navIndex.value,
              children: [
                //home
                const Home(),
                //search
                Search(),
                //upload
                Center(
                  child: Container(
                    child: const Text("Upload Page"),
                  ),
                ),
                //likeShareList
                LikesPage(),
                //mypage
                Navigator(
                  key: controller.mypageKey,
                  onGenerateRoute: (routeSetting) {
                    return MaterialPageRoute(
                        builder: (context) => const MyPage());
                  },
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.navIndex.value,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 0,
              onTap: controller.changeBottomNav,
              items: [
                BottomNavigationBarItem(
                  icon: iconData(
                    icon: ImagePath.homeOff,
                    size: 80,
                  ),
                  activeIcon: iconData(
                    icon: ImagePath.homeOn,
                    size: 80,
                  ),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                    icon: iconData(
                      icon: ImagePath.searchOff,
                      size: 80,
                    ),
                    activeIcon: iconData(
                      icon: ImagePath.searchOn,
                      size: 80,
                    ),
                    label: 'search'),
                BottomNavigationBarItem(
                    icon: iconData(
                      icon: ImagePath.upload,
                      size: 120,
                    ),
                    label: 'upload'),
                BottomNavigationBarItem(
                    icon: iconData(
                      icon: ImagePath.favoriteOff,
                      size: 88,
                    ),
                    activeIcon: iconData(
                      icon: ImagePath.favoriteOn,
                      size: 88,
                    ),
                    label: 'activity'),
                BottomNavigationBarItem(
                    icon: iconData(
                      icon: ImagePath.mypageOff,
                      size: 88,
                    ),
                    activeIcon: iconData(
                      icon: ImagePath.mypageOn,
                      size: 88,
                    ),
                    label: 'my page'),
              ],
            ),
          );
        }));
  }
}
