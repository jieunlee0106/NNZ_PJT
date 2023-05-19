import 'package:flutter/material.dart';
import 'package:get/get.dart';

class iconData extends StatelessWidget {
  final String icon;
  final double? size;

  const iconData({
    super.key,
    required this.icon,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      icon,
      width: size! / Get.mediaQuery.devicePixelRatio,
    );
  }
}

class ImagePath {
  static String get twitter => 'assets/images/login/twitter.png';
  static String get id => 'assets/images/login/id.png';
  static String get homeOn => 'assets/images/bottom_navigator/home_on.png';
  static String get homeOff => 'assets/images/bottom_navigator/home_off.png';
  static String get searchOn => 'assets/images/bottom_navigator/search_on.jpg';
  static String get searchOff =>
      'assets/images/bottom_navigator/search_off.jpg';
  static String get upload => 'assets/images/bottom_navigator/upload.jpg';
  static String get favoriteOn =>
      'assets/images/bottom_navigator/favorite_on.jpg';
  static String get favoriteOff =>
      'assets/images/bottom_navigator/favorite_off.jpg';
  static String get mypageOn => 'assets/images/bottom_navigator/mypage_on.jpg';
  static String get mypageOff =>
      'assets/images/bottom_navigator/mypage_off.jpg';
  static String get addImage => 'assets/images/sharing_register/add_image.png';
  static String get choice => 'assets/images/sharing_register/choice.png';
  static String get calendar => 'assets/images/sharing_register/calendar.png';
  static String get certification =>
      'assets/images/sharing_register/certification.png';
  static String get detailInfo =>
      'assets/images/sharing_register/detail_info.png';
  static String get peopleCount =>
      'assets/images/sharing_register/people_count.png';
  static String get title => 'assets/images/sharing_register/title.png';
  static String get hashTag => 'assets/images/sharing_register/hash_tag.png';
  static String get condition => 'assets/images/sharing_register/condition.png';

  static String get musical => 'assets/images/home/musical.png';
  static String get concert => 'assets/images/home/concert.png';
  static String get sports => 'assets/images/home/sports.png';
  static String get esports => 'assets/images/home/esports.png';
  static String get movie => 'assets/images/home/movie.png';
  static String get stage => 'assets/images/home/stage.png';
  static String get banner1 => 'assets/images/home/banner1.JPG';
  static String get banner2 => 'assets/images/home/banner2.JPG';
  static String get banner3 => 'assets/images/home/banner3.JPG';
  static String get fire => 'assets/images/home/fire.png';
  static String get pin => 'assets/images/home/pin.png';
  static String get logo => 'assets/images/home/logo.png';
  static String get heart => 'assets/images/home/heart.png';
  static String get gift => 'assets/images/home/gift.png';
  static String get bsbB => 'assets/images/sports/bsb.jpg';
  static String get bkbB => 'assets/images/sports/bkb.jpg';
  static String get socB => 'assets/images/sports/soc.jpg';
  static String get socC => 'assets/images/sports/socc.jpg';
  static String get bsbC => 'assets/images/sports/bsbc.jpg';
  static String get bkbC => 'assets/images/sports/bkbc.jpg';
  static String get socIcon => 'assets/images/sports/football.png';
  static String get bkbIcon => 'assets/images/sports/basketball.png';
  static String get bsbIcon => 'assets/images/sports/baseball.png';
  static String get kar => 'assets/images/sports/kar.JPG';
  static String get karB => 'assets/images/sports/karB.JPG';
  static String get lol => 'assets/images/sports/lol.JPG';
  static String get lolB => 'assets/images/sports/lolB.JPG';
  static String get ove => 'assets/images/sports/ove.JPG';
  static String get oveB => 'assets/images/sports/oveB.JPG';
  static String get sta => 'assets/images/sports/sta.JPG';
  static String get staB => 'assets/images/sports/staB.JPG';
  static String get cal => 'assets/images/sports/cal.png';
  static String get game => 'assets/images/home/game.png';
  static String get sad => 'assets/images/search/sad.png';
  static String get giftDate => 'assets/images/sharing_register/gift.png';
  static String get declare => 'assets/images/declare.png';
  static String get twitterProfile => 'assets/images/twitter_profile.png';
  static String get profile => 'assets/images/login/profile.jpg';
  static String get event => 'assets/images/event.JPG';
}
