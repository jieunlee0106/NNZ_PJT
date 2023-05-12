import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:nnz/src/components/register_form/share_popup.dart';
import 'package:nnz/src/model/share_model.dart';
import 'package:nnz/src/services/search_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/sharing_register.dart';
import 'package:oauth1/oauth1.dart' as oauth1;

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
  final _isLoading = false.obs;
  final String apiKey = 'Py5cGhPQyRt1kzrvQzmGuu9Ox';
  final String apiSecret = 'MLraP08zkwSc2G3ToamG5E9qmKj1oksHPXnOqLxOlTIp5sDn0V';
  final String callbackUrlScheme = 'twittercallback://';
  bool isAuthenticated = false;

  get isLoading => _isLoading.value;
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

  final clientCredentials = oauth1.ClientCredentials(
      "Py5cGhPQyRt1kzrvQzmGuu9Ox",
      "MLraP08zkwSc2G3ToamG5E9qmKj1oksHPXnOqLxOlTIp5sDn0V");
  final platform = oauth1.Platform(
    'https://api.twitter.com/oauth/request_token',
    'https://api.twitter.com/oauth/authorize',
    'https://api.twitter.com/oauth/access_token',
    oauth1.SignatureMethods.hmacSha1,
  );
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

  //트위터 트윗 등록
  Future<void> register() async {
    final oauth = oauth1.Authorization(clientCredentials, platform);
    final textController = TextEditingController();
    try {
      final res = await oauth.requestTemporaryCredentials('oob');
      final authorizationUrl =
          oauth.getResourceOwnerAuthorizationURI(res.credentials.token);
      if (await canLaunch(authorizationUrl)) {
        await launch(authorizationUrl);
      } else {
        throw 'Could not launch $authorizationUrl';
      }
      await showDialog(
        context: Get.context!,
        builder: (context) => AlertDialog(
          title: const Text('Enter PIN'),
          content: TextField(
            controller: textController,
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      final tokenCred = await oauth.requestTokenCredentials(
        res.credentials,
        textController.text,
      );
      final client = oauth1.Client(
        platform.signatureMethod,
        clientCredentials,
        tokenCred.credentials,
      );
      final fileInfo = imageController.images[0];
      logger.i(fileInfo.name);
      final formData = FormData({});
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://api.twitter.com/1.1/statuses/update_with_media.json'),
      );
      request.fields.addAll({'status': 'Hello World'}); // 트윗 메시지를 추가합니다.
      request.files.add(await http.MultipartFile.fromPath(
        'media',
        fileInfo.path,
      ));
      final response = await client.send(request);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Tweet posted successfully')),
        );
      } else {
        print('Failed to upload file. Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Failed to post tweet: $e')),
      );
    }
  }

  void onShareRegister() async {
    if (imageController.images.length == 0) {
      //popup창으로 바꿀 것
      showDialog(
          context: Get.context ?? Get.overlayContext!,
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

        final tagReqList = [];
        for (var element in tagList) {
          tagReqList.add(base64Encode(utf8.encode(element)));
        }
        shareModel = ShareModel.fromJson({
          "showId": showId.value,
          "writer": writer.value,
          "nanumDate": sharingDateController.text,
          "title": base64Encode(utf8.encode(titleController.text)),
          "openTime": openTime,
          "quantity": peopleCount.value,
          "isCertification": isAuthentication.value,
          "condition": isAuthentication.value == true
              ? base64Encode(utf8.encode(conList[0]))
              : "",
          "content": base64Encode(utf8.encode(detailController.text)),
          "tags": tagReqList,
        });

        var platform = oauth1.Platform(
          'https://api.twitter.com/oauth/request_token',
          'https://api.twitter.com/oauth/authorize',
          'https://api.twitter.com/oauth/access_token',
          oauth1.SignatureMethods.hmacSha1,
        );

        const String apiKey = 'Py5cGhPQyRt1kzrvQzmGuu9Ox';
        const String apiSecret =
            'MLraP08zkwSc2G3ToamG5E9qmKj1oksHPXnOqLxOlTIp5sDn0V';

        var clientCredentials = oauth1.ClientCredentials(apiKey, apiSecret);
        var auth = oauth1.Authorization(clientCredentials, platform);

        //트위터 계정인지 파악을 해서 트윗 등록할 수 있게 함....
        // register();
        try {
          final response = await SharingRegisterProvider().testShare(
              shareModel: shareModel, images: imageController.images);
          logger.i(response.statusCode);
          logger.i(response.statusText);
          if (response.statusCode == 201) {
            Get.snackbar("완료", "등록완료하였습니다.");
            Get.offNamed("/app");
          }
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
      final tagReqList = [];
      for (var element in tagList) {
        tagReqList.add(base64Encode(utf8.encode(element)));
      }
      logger.i("태그 $tagReqList");
      shareModel = ShareModel.fromJson({
        "showId": showId.value,
        "writer": writer.value,
        "nanumDate": sharingDateController.text,
        "title": base64Encode(utf8.encode(titleController.text)),
        "openTime": openTime,
        "quantity": peopleCount.value,
        "isCertification": isAuthentication.value,
        "condition": isAuthentication.value == true
            ? base64Encode(utf8.encode(conList[0]))
            : "",
        "content": base64Encode(utf8.encode(detailController.text)),
        "tags": tagReqList,
      });

      try {
        final response = await SharingRegisterProvider()
            .testShare(shareModel: shareModel, images: imageController.images);
        logger.i(response.statusCode);
        logger.i(response.statusText);
        if (response.statusCode == 201) {
          Get.snackbar("완료", "등록완료하였습니다.");
          Get.offNamed("/app");
        }
      } catch (e) {
        logger.i("$e");
      }
    }
  }
}
