import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:nnz/src/components/register_form/share_popup.dart';

enum Condition { INIT, YES, NO }

class SharingRegisterController extends GetxController {
  late final imageController;
  late final titleController;
  late final detailController;
  late final sharingController;
  late final sportsController;
  late final musicalController;
  late final concertController;
  late final esportsController;
  late final theaterController;
  late final movieController;
  late final conditionController;
  late final hashTagController;
  late final sharingDateController;
  late final openDateController;
  late final openTimeController;
  List<ImageFile> imageList = [];
  RxList<String> conList = RxList<String>();
  RxList<String> tagList = RxList<String>();
  RxString testText = "".obs;

  RxBool isAuthentication = false.obs;

  RxInt peopleCount = 0.obs;
  final logger = Logger();
  final storage = const FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    imageController = MultiImagePickerController(
        maxImages: 4,
        withReadStream: true,
        allowedImageTypes: ['png', 'jpg', 'jpeg']);
    titleController = TextEditingController();
    detailController = TextEditingController();
    sharingController = TextEditingController();
    sportsController = TextEditingController();
    musicalController = TextEditingController();
    esportsController = TextEditingController();
    concertController = TextEditingController();
    theaterController = TextEditingController();
    movieController = TextEditingController();
    conditionController = TextEditingController();
    hashTagController = TextEditingController();
    sharingDateController = TextEditingController();
    openDateController = TextEditingController();
    openTimeController = TextEditingController();
  }

  Future<String> getToken() async {
    final accessToken = await storage.read(key: 'accessToken');
    return accessToken!;
  }

  void onChange(String text) {
    sharingController.text = text;
    logger.i(sharingController.text);
  }

  void addCondition(String condition) {
    if (conList.isNotEmpty) {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return AlertDialog(
              content: const Text("조건은 하나만 추가할 수 있습니다."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    FocusScope.of(context).unfocus();
                  },
                  child: const Text("확인"),
                ),
              ],
            );
          });
    } else {
      if (conditionController.text == "") {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return AlertDialog(
                content: const Text("조건을 입력해주세요"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      FocusScope.of(context).unfocus();
                    },
                    child: const Text("확인"),
                  ),
                ],
              );
            });
      } else {
        conList.add(condition);

        conditionController.text = "";
        logger.i(conList);
      }
    }
  }

  void removeCondition(String condition) {
    conList.remove(condition);
  }

  void onIncrease() {
    peopleCount(peopleCount.value + 1);
    logger.i(peopleCount.value);
  }

  void onDecrease() {
    peopleCount(peopleCount.value - 1);
    logger.i(peopleCount.value);
  }

  void onAddTag(String element) {
    tagList.add(element);
    logger.i(tagList);
  }

  void onRemoveTag(int index) {
    tagList.remove(tagList[index]);
  }
  //카테고리 조회

  //공연 카테고리 별 검색
  void onSearchShow(
      {required TextEditingController textController,
      required String category}) {}

  void onShareRegister() {
    if (imageController.images.length == 0) {
      //popup창으로 바꿀 것
      showDialog(
          context: Get.context!,
          builder: (context) {
            return AlertDialog(
              content: const Text("이미지를 선택해주세요"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    FocusScope.of(context).unfocus();
                  },
                  child: const Text("확인"),
                ),
              ],
            );
          });
    } else if (sharingController.text.length <= 0) {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return AlertDialog(
              content: const Text("공연을 선택해주세요"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    FocusScope.of(context).unfocus();
                  },
                  child: const Text("확인"),
                ),
              ],
            );
          });
    } else if (sharingDateController.text.length <= 0) {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return const sharePopup(popupMessage: "나눔일시 입력해주세요");
          });
    } else if (titleController.text.length <= 0) {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return const sharePopup(popupMessage: "제목을 입력해주세요");
          });
    } else if (isAuthentication.value == true) {
      if (conList.isEmpty) {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return const sharePopup(popupMessage: "조건을 입력해주세요");
            });
      }
    } else if (peopleCount <= 0) {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return const sharePopup(popupMessage: "인원수는 최소 1명 이상입니다.");
          });
    } else if (detailController.text.length <= 0) {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return const sharePopup(popupMessage: "상세 정보를 입력해주세요");
          });
    } else {
      imageList.clear();
      for (var image in imageController.images) {
        imageList.add(image);
        logger.i("$image");
      }
    }
  }
}
