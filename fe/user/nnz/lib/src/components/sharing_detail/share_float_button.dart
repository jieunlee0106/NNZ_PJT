import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/sharing_detail/sharing_timer.dart';
import 'package:nnz/src/config/config.dart';
import "../../controller/shareingdetail_controller.dart";
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class PurchaseButton extends StatelessWidget {
  final bool condition;
  bool isOpen;
  final int leftday;
  final int lefthour;
  final int leftmin;
  final int leftsec;

  PurchaseButton({
    super.key,
    required this.condition,
    required this.isOpen,
    required this.leftday,
    required this.lefthour,
    required this.leftmin,
    required this.leftsec,
  });
  // 0이면 조건 없음 1이면 조건 있음

  final controller = Get.put(ShareDetailController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Config.yellowColor),
        onPressed: () {
          print(leftday);
          if (isOpen) {
            showModalBottomSheet(
              context: context,
              isDismissible: true,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Visibility(
                        visible: condition,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/sharing_sample/sharingstop.png")),
                                ),
                                Text(
                                  "잠깐!",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              "인증이 필요한 나눔입니다",
                              style: TextStyle(
                                  fontSize: 11, color: Color(0xFF838282)),
                            ),
                            SizedBox(
                              width: 370,
                              height: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white),
                                onPressed: () {},
                                child: Container(
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: MultiImagePickerView(
                                      controller:
                                          controller.authImageController,
                                      addButtonTitle: ""),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                          visible: !condition,
                          child: const Text("나눔을 받으시겠습니까?")),
                      SizedBox(
                        width: 370,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Config.yellowColor),
                          onPressed: () {
                            Get.find<ShareDetailController>().sendAuthImage();
                          },
                          child: Container(
                            decoration:
                                BoxDecoration(color: Config.yellowColor),
                            child: Text(
                              '나눔 받기',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Config.blackColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
        child: Container(
            decoration: BoxDecoration(color: Config.yellowColor),
            child: SharingDateTimer(
              onTimerFinished: () => {isOpen = true},
            )),
      ),
    );
  }
}
