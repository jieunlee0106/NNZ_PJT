import 'package:get/get.dart';
import 'package:nnz/src/services/share_info_provider.dart';

class ShareInfoController extends GetxController {
  static ShareInfoController get to => Get.find();
  final ShareInfoProvider _shareInfoProvider = Get.put(ShareInfoProvider());

  final Rx<Map<String, dynamic>> shareInfoData = Rx<Map<String, dynamic>>({});

  Future<void> getShareInfoData() async {
    final res = await _shareInfoProvider.getShareInfo();
    if (res.statusCode == 200) {
      shareInfoData.value = res.body;
      print(shareInfoData.value);
    } else {
      print("나눔인포에러");
    }
  }
}
