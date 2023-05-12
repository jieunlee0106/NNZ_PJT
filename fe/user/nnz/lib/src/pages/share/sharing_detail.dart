// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:nnz/src/components/sharing_detail/divide_line.dart';
// import 'package:nnz/src/components/sharing_detail/share_float_button.dart';
// import 'package:nnz/src/components/sharing_detail/sharing_button.dart';
// import 'package:nnz/src/components/sharing_detail/sharing_card.dart';
// import 'package:nnz/src/components/sharing_detail/sharing_tag.dart';
// import 'package:nnz/src/controller/shareingdetail_controller.dart';

// class SharingDetail extends StatelessWidget {
//   final List<String> sharetag = ["해시태그1", "해시태그2", "해시태그3"];
//   SharingDetail({super.key});
//   final ShareDetailController sharedetailController =
//       Get.put(ShareDetailController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         iconTheme: const IconThemeData(color: Colors.black),
//         leading: const Icon(Icons.account_circle),
//         actions: const [Icon(Icons.notifications)],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(
//           vertical: 5,
//         ),
//         child: Column(
//           children: [
//             Center(
//               child: Image.asset(
//                 "assets/images/sharing_sample/sharingsource.jpg",
//                 height: 230,
//                 width: double.maxFinite,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Text(
//                     "$sharedetailController",
//                     style: const TextStyle(
//                         fontSize: 20, fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const DevideLine(
//               bgColor: Color(0xFFF3C906),
//               pad: 10,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               child: SharingDetailCard(),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: Container(
//                     width: 50,
//                     height: 50,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage(
//                             "assets/images/sharing_sample/profileimage.jpg"),
//                         fit: BoxFit.cover,
//                       ),
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//                 const Text("정국조아"),
//                 const SizedBox(
//                   width: 15,
//                 ),
//                 const SharingButton(
//                   btntext: "Follow",
//                   btnheight: 8,
//                   btnwidth: 40,
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15),
//               child: SizedBox(
//                 width: double.maxFinite,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "상세 정보중",
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text("제가 직접 만든 정국 포카 나눔입니다. 선착순 나눔이므로 이후 추가 물량은 없습니다"),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15),
//               child: HashTagBadge(
//                 tags: {
//                   '#페스티벌': Color(0xFFF3C906),
//                   '#전정국': Color(0xFFF3C906),
//                   '#BTS': Color(0xFFF3C906),
//                   '#Peak': Color(0xFFF3C906),
//                   '#포카나눔': Color(0xFFF3C906),
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomSheet: Container(
//         decoration: const BoxDecoration(
//           border: Border(
//             top: BorderSide(width: 0.3, color: Colors.black),
//             left: BorderSide(width: 0.3, color: Colors.black),
//             right: BorderSide(width: 0.3, color: Colors.black),
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Image(
//                 image: AssetImage("assets/images/sharing_sample/heart.png"),
//                 width: 32,
//                 height: 32,
//               ),
//               const SizedBox(
//                 width: 20,
//               ),
//               PurchaseButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
