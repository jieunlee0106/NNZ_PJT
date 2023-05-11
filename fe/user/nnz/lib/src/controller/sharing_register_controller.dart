import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:nnz/src/components/register_form/share_popup.dart';
import 'package:nnz/src/model/share_model.dart';
import 'package:nnz/src/services/search_provider.dart';

import '../services/sharing_register.dart';

enum Condition { INIT, YES, NO }

class SharingRegisterController extends GetxController {
  ShareModel shareModel = ShareModel();
  late final imageController;
  late final titleController;
  late final detailController;
  late final sharingController;

  late final showSearchController;
  //나눔등록에서 공연 검색 api 통신이 완료되면
  //sportsController ~ movieController는 싹다 삭제하기

  late final conditionController;
  late final hashTagController;
  late final sharingDateController;
  late final openDateController;
  late final openTimeController;
  late final empSearchController;
  late final nempSearchController;
  final RxList<String> pCategories = RxList<String>();
  final RxList<String> pCode = RxList<String>();
  final RxList<String> cCategories = RxList<String>();
  List<ImageFile> imageList = [];

  RxList<String> conList = RxList<String>();
  RxList<String> tagList = RxList<String>();
  RxString testText = "".obs;
  RxInt showId = RxInt(0);
  RxInt writer = 0.obs;
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
    showSearchController = TextEditingController();

    conditionController = TextEditingController();
    hashTagController = TextEditingController();
    sharingDateController = TextEditingController();
    openDateController = TextEditingController();
    openTimeController = TextEditingController();
    nempSearchController = TextEditingController();
    empSearchController = TextEditingController();
  }

  Future<String> getToken() async {
    final accessToken = await storage.read(key: 'accessToken');
    return accessToken!;
  }

  Future<String> getUserId() async {
    final userId = await storage.read(key: 'userId');
    return userId!;
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

  //부모 카테고리 조회
  Future<List<String>> getParentCategory() async {
    try {
      final response = await SearchProvider().getParentCategory();
      if (response.statusCode == 200) {
        logger.i(response.body);
        pCategories.clear();
        pCode.clear();
        for (var category in response.body) {
          pCategories.add(category["name"]);
          pCode.add(category["code"]);
        }
        logger.i(pCategories);
        return pCategories;
      } else {
        final errorMessage = "(${response.statusCode}): ${response.body}";
        logger.e(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e) {
      final errorMessage = "$e";
      logger.e(errorMessage);
      throw Exception(errorMessage);
    }
  }

  //자식 카테고리 검색
  Future<List<String>> getChildCategory({required int index}) async {
    logger.i("받아왔어 ${pCode[index]}");
    try {
      final response =
          await SearchProvider().getChildCategory(parent: pCode[index]);
      if (response.statusCode == 200) {
        logger.i(response.body);
        if (response.body != null) {
          cCategories.clear();
          for (var category in response.body) {
            cCategories.add(category["name"]);
          }

          return cCategories;
        } else {
          cCategories.clear();
          return [];
        }
      } else {
        final errorMessage = "(${response.statusCode}): ${response.body}";
        logger.e(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e) {
      final errorMessage = "$e";
      logger.e(errorMessage);
      throw Exception(errorMessage);
    }
  }

  //공연 카테고리 별 검색
  //통신이 완료된 후 위젯을 만들겠습니다. 아니면 지금할까?
  Future<List> onSearchShow({
    required String category,
    required String title,
  }) async {
    logger.i("category : $category, title : $title");
    try {
      final response =
          await SearchProvider().getShowList(category: category, title: title);
      if (response.statusCode == 200) {
        if (response.body["isEmpty"] == false) {
          final content = response.body["content"];
          logger.i("리스트 받아와 $content");
          return content;
        } else {
          return [];
        }
      } else {
        final errorMessage = "(${response.statusCode}): ${response.body}";
        logger.e(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e) {
      final errorMessage = "$e";
      logger.e(errorMessage);
      throw Exception(errorMessage);
    }
  }

  void onShareRegister() async {
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
        final openTime =
            "${openDateController.text}T${openTimeController.text}";

        final titleText = titleController.text;
        logger.i("값들어와라 $titleText");
        shareModel = ShareModel.fromJson({
          "showId": showId.value,
          "writer": writer.value,
          "nanumDate": sharingDateController.text,
          "title": titleController.text,
          "openTime": openTime,
          "quantity": peopleCount.value,
          "isCertification": isAuthentication.value,
          "condition": isAuthentication.value == true ? conList[0] : null,
          "content": detailController.text,
          "tags": tagList,
        });

        logger.i("shareModel $shareModel");
        logger.i("images ${imageController.images[1].path}");
        try {
          final response = await SharingRegisterProvider().testShare(
              shareModel: shareModel, images: imageController.images);
          logger.i(response.statusCode);
          logger.i(response.statusText);
        } catch (e) {
          logger.i("$e");
        }
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
      final openTime = "${openDateController.text}T${openTimeController.text}";

      shareModel = ShareModel(
        showId: showId.value,
        writer: writer.value,
        nanumDate: sharingDateController.text,
        title: titleController.text,
        openTime: openTime,
        quantity: peopleCount.value,
        isCertification: isAuthentication.value,
        condition: isAuthentication.value == true
            ? conList.indexOf(0).toString()
            : null,
        content: detailController.text,
        tags: tagList,
      );
      SharingRegisterProvider()
          .testShare(shareModel: shareModel, images: imageController.images);
    }
  }
}
