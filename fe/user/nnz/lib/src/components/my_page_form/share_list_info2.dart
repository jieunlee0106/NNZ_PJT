import 'package:flutter/material.dart';
import 'package:nnz/src/components/nullPage.dart';
import 'package:nnz/src/config/config.dart';
import 'package:get/get.dart';
import 'package:nnz/src/pages/share/my_shared_detail.dart';
import 'package:nnz/src/model/receive_type_list_model.dart';

class ShareList2 extends StatefulWidget {
  // final List<Content> items;

  const ShareList2({
    Key? key,
  }) : super(key: key);

  @override
  _ShareListState createState() => _ShareListState();
}

class _ShareListState extends State<ShareList2> {
  @override
  Widget build(BuildContext context) {
    // if (widget.items.length == 0) {
    //   return Center(child: NullPage(message: '나눔 목록이 존재하지 않습니다'));
    // }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
          // children: widget.items
          //         .map(
          //           (item) => Container(
          //             width: 345,
          //             height: 150,
          //             margin: const EdgeInsets.only(top: 6),
          //             decoration: const BoxDecoration(),
          //             child: Column(
          //               children: [
          //                 const SizedBox(
          //                   height: 10,
          //                 ),
          //                 Row(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Container(
          //                       width: 120,
          //                       height: 120,
          //                       decoration: BoxDecoration(
          //                         color: const Color.fromARGB(255, 255, 253, 253),
          //                         image: DecorationImage(
          //                           image: NetworkImage(item.thumbnail!),
          //                           fit: BoxFit.cover,
          //                         ),
          //                       ),
          //                     ),
          //                     Padding(
          //                       padding: const EdgeInsets.only(top: 5, left: 20),
          //                       child: Column(
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         children: [
          //                           Row(
          //                             children: [
          //                               Container(
          //                                 width: 60,
          //                                 height: 22,
          //                                 decoration: BoxDecoration(
          //                                   color: Config.yellowColor,
          //                                   borderRadius:
          //                                       BorderRadius.circular(20),
          //                                 ),
          //                                 child: Center(
          //                                   child: Text(
          //                                     item.status == 0
          //                                         ? '나눔 전'
          //                                         : item.status == 2
          //                                             ? '나눔 중'
          //                                             : '나눔 종료',
          //                                     style: TextStyle(
          //                                       color: Config.blackColor,
          //                                       fontSize: 12,
          //                                       fontWeight: FontWeight.w500,
          //                                     ),
          //                                   ),
          //                                 ),
          //                               ),
          //                               const SizedBox(
          //                                 width: 12,
          //                               ),
          //                               Visibility(
          //                                 visible: item.isCertification == true,
          //                                 child: Container(
          //                                   width: 100,
          //                                   height: 22,
          //                                   decoration: BoxDecoration(
          //                                     color: Config.yellowColor,
          //                                     borderRadius:
          //                                         BorderRadius.circular(20),
          //                                   ),
          //                                   child: Center(
          //                                     child: Text(
          //                                       '인증 확인서 필요',
          //                                       style: TextStyle(
          //                                         color: Config.blackColor,
          //                                         fontSize: 12,
          //                                         fontWeight: FontWeight.w500,
          //                                       ),
          //                                     ),
          //                                   ),
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                           const SizedBox(
          //                             height: 10,
          //                           ),
          //                           Center(
          //                             child: GestureDetector(
          //                               onTap: () =>
          //                                   Get.to(() => MySharedDetail()),
          //                               child: Text(
          //                                 item.title!,
          //                                 style: TextStyle(
          //                                   color: Config.blackColor,
          //                                   fontSize: 14,
          //                                   fontWeight: FontWeight.w700,
          //                                   overflow: TextOverflow.ellipsis,
          //                                 ),
          //                               ),
          //                             ),
          //                           ),
          //                           const SizedBox(height: 7),
          //                           Text(
          //                             item.date!,
          //                             style: TextStyle(
          //                               fontSize: 14,
          //                               color: Config.grayFontColor,
          //                               fontWeight: FontWeight.w900,
          //                               overflow: TextOverflow.ellipsis,
          //                             ),
          //                             overflow: TextOverflow.ellipsis,
          //                           ),
          //                           const SizedBox(height: 7),
          //                           Text(
          //                             item.location!,
          //                             style: TextStyle(
          //                               fontSize: 13,
          //                               color: Config.grayFontColor,
          //                               fontWeight: FontWeight.w400,
          //                               overflow: TextOverflow.ellipsis,
          //                             ),
          //                             overflow: TextOverflow.ellipsis,
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //                 const SizedBox(
          //                   height: 15,
          //                 ),
          //                 Container(
          //                   height: 2,
          //                   width: 350,
          //                   decoration: BoxDecoration(
          //                     color: Config.greyColor,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         )
          //         .toList() ??
          //     [],
          ),
    );
  }
}
