import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:nnz/src/components/sharing_detail/share_auth_card.dart';
import 'package:nnz/src/components/sharing_detail/sharing_button.dart';
import 'package:nnz/src/config/token.dart';
import 'package:nnz/src/pages/share/my_shared_detail.dart';

class SharedAuthCheck extends StatefulWidget {
  final int nanumIds;
  const SharedAuthCheck({super.key, required this.nanumIds});

  @override
  State<SharedAuthCheck> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<SharedAuthCheck> {
  final CardSwiperController controller = CardSwiperController();

  List<dynamic> result = [];

  int dataLength = 0;

  var cards = [];
  String? token;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void fetchData() async {
    try {
      var res = await http.get(
          Uri.parse(
              "https://k8b207.p.ssafy.io/api/nanum-service/nanums/${widget.nanumIds}/certification"),
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiaXNzIjoibm56IiwiaWF0IjoxNjg0MDYzNDM3LCJhdXRoUHJvdmlkZXIiOiJOTloiLCJyb2xlIjoiQURNSU4iLCJpZCI6MiwiZW1haWwiOiJzc2FmeTAwMUBzc2FmeS5jb20iLCJleHAiOjE2ODUzNTk0Mzd9.XXv5ZRiwYhD1u5SEcr0tgnO9bqhcxHjgC3jxaMr9L4z1rGJwPm6AyrRuc0Dzo4zWie0SlWKflljBeHu7XblTLg',
            "Accept-Charset": "utf-8",
          });
      result = json.decode(res.body);
      dataLength = result.length;
      cards = result.map((el) => StackAuthCard(candidate: el)).toList();
      print(result);
      print(dataLength);
      setState(() {
        result;
        cards;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Flexible(
              child: CardSwiper(
                controller: controller,
                cardsCount: (dataLength),
                onSwipe: _onSwipe,
                onUndo: _onUndo,
                numberOfCardsDisplayed: (dataLength),
                backCardOffset: const Offset(40, 40),
                padding: const EdgeInsets.all(55.0),
                cardBuilder: (context, index) => cards[index],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: controller.undo,
                    heroTag: "swipe_left_button",
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.rotate_left,
                      color: Colors.black,
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: controller.swipeLeft,
                    heroTag: "left_button",
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.close),
                  ),
                  FloatingActionButton(
                    onPressed: controller.swipeRight,
                    heroTag: "right_button",
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.check),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => Get.to(() => MyShareDetail(
                    nanumIds: widget.nanumIds,
                  )),
              child: const SharingButton(
                  btnheight: 12, btnwidth: 130, btntext: "완료"),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    if (direction.name == 'left') {
      rejectAuth(result[previousIndex]["id"]);
      // debugPrint("$previousIndex 거절 다음 $currentIndex");
    }
    if (direction.name == 'right') {
      allowAuth(result[previousIndex]["id"]);
      // debugPrint("$previousIndex 수락 다음 $currentIndex");
    }
    if (currentIndex == dataLength) {
      const SnackBar(content: Text("인증이 완료되었습니다"));
    }
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }

  void rejectAuth(int id) async {
    print("거절");
    token = await Token.getAccessToken();
    print("$id 거절 시작");
    var res = await http.post(
        Uri.parse(
            "https://k8b207.p.ssafy.io/api/nanum-service/nanums/${widget.nanumIds}/certification"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: {
          "id": id.toString(),
          "certification": "false",
        });
    if (res.statusCode == 204) {
      print("거절 완료");
    } else {
      print(res.statusCode);
    }
  }

  void allowAuth(int id) async {
    print("수락");
    token = await Token.getAccessToken();
    print(id.runtimeType);
    var res = await http.post(
        Uri.parse(
            "https://k8b207.p.ssafy.io/api/nanum-service/nanums/${widget.nanumIds}/certification"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          "id": id,
          "certification": true,
        }));
    print(res.statusCode);
  }
}
