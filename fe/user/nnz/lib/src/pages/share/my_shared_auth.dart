import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:nnz/src/components/sharing_detail/share_auth_card.dart';
import 'package:nnz/src/components/sharing_detail/sharing_button.dart';
import 'package:nnz/src/pages/share/my_shared_detail.dart';

class SharedAuthCheck extends StatefulWidget {
  const SharedAuthCheck({
    Key? key,
  }) : super(key: key);

  @override
  State<SharedAuthCheck> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<SharedAuthCheck> {
  final CardSwiperController controller = CardSwiperController();

  List<dynamic> result = [];

  int nanumId = 71;
  int dataLength = 0;

  var cards = [];

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
              "https://k8b207.p.ssafy.io/api/nanum-service/nanums/$nanumId/certification"),
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
                cardsCount: (dataLength + 1),
                onSwipe: _onSwipe,
                onUndo: _onUndo,
                numberOfCardsDisplayed: dataLength,
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
              onTap: () => Get.to(() => MySharedDetail()),
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
      var res = http.post(
          Uri.parse(
              "https://k8b207.p.ssafy.io/api/nanum-service/nanums/$nanumId/certification"),
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiaXNzIjoibm56IiwiaWF0IjoxNjg0MDY5NjYzLCJhdXRoUHJvdmlkZXIiOiJOTloiLCJyb2xlIjoiQURNSU4iLCJpZCI6MiwiZW1haWwiOiJzc2FmeTAwMUBzc2FmeS5jb20iLCJleHAiOjE2ODUzNjU2NjN9.tPkq_vcxjmyYlXg8ovvCD4JTBtkIA975OtBQcKmqZZrTHExCEvTsYL9V8iJ6dL64FDyHPde4C1U-cWh-l69ksA'
          },
          body: {
            "id": {result[previousIndex]["id"]},
            "certification": false,
          });
      debugPrint("$previousIndex 거절 다음 $currentIndex");
    }
    if (direction.name == 'right') {
      var res = http.post(
          Uri.parse(
              "https://k8b207.p.ssafy.io/api/nanum-service/nanums/${result[previousIndex]["id"]}/certification"),
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiaXNzIjoibm56IiwiaWF0IjoxNjg0MDY5NjYzLCJhdXRoUHJvdmlkZXIiOiJOTloiLCJyb2xlIjoiQURNSU4iLCJpZCI6MiwiZW1haWwiOiJzc2FmeTAwMUBzc2FmeS5jb20iLCJleHAiOjE2ODUzNjU2NjN9.tPkq_vcxjmyYlXg8ovvCD4JTBtkIA975OtBQcKmqZZrTHExCEvTsYL9V8iJ6dL64FDyHPde4C1U-cWh-l69ksA'
          },
          body: {
            "id": {result[previousIndex]["id"]},
            "certification": true,
          });
      debugPrint("$previousIndex 수락 다음 $currentIndex");
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
}
