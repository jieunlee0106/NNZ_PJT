import 'package:get/get.dart';
import 'package:nnz/src/services/share_detail_provider.dart';

class ShareDetailController extends GetxController {
  static ShareDetailController get to => Get.find();
  final ShareDetailProvider _shareDetailProvider =
      Get.put(ShareDetailProvider());

  final Rx<Map<String, dynamic>> shareDetailData = Rx<Map<String, dynamic>>({});

  @override
  void onReady() {
    super.onReady();
    getShareDetailData();
  }

  Future<void> getShareDetailData() async {
    final res = await _shareDetailProvider.getShareDetail();
    if (res.statusCode == 200) {
      shareDetailData.value = res.body;

      print('들어는오니?');
    } else {
      print("나눔정보 에러");
    }
  }
}
