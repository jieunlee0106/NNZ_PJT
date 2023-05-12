// import "dart:io";

// import "package:get/get_connect/connect.dart";

// class SharingDetailImageProvider extends GetConnect {
//   Future<String> uploadImage(List<String> list) async {
//     try {
//       final form = FormData({});

//       for (String path in list) {
//         form.files.add(MapEntry(
//             "file[]",
//             MultipartFile(File(path),
//                 filename:
//                     "${DateTime.now().millisecondsSinceEpoch}.${path.split(".").last}")));
//       }
//       final response = await post("https://", form);
//       if (response.status.hasError) {
//         return Future.error(response.body);
//       } else {
//         return response.body("result");
//       }
//     } catch (err) {
//       return Future.error(err.toString());
//     }
//   }
// }
