import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/register_form/register_field.dart';

import '../../config/config.dart';
import '../../controller/register_controller.dart';

class Email extends GetView<RegisterController> {
  const Email({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text("이메일",
              style: TextStyle(
                fontSize: 12,
                color: Config.blackColor,
                fontWeight: FontWeight.bold,
              )),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: RegisterField(
            controller: controller.emailController,
            type: TextInputType.emailAddress,
            formType: 'email',
            hintText: "예 : naneozoo@email.com",
          ),
        )
      ],
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nnz_app/src/config/config.dart';
// import 'package:nnz_app/src/controller/register_controller.dart';

// class Email extends StatelessWidget {
//   final controller = Get.put(RegisterController());
//   Email({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 4.0),
//           child: Text(
//             "이메일",
//             style: TextStyle(
//               fontSize: 12,
//               color: Config.blackColor,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: Container(
//             child: TextFormField(
//               controller: controller.emailController,
//               keyboardType: TextInputType.emailAddress,
//               decoration: InputDecoration(
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                 ),
//                 hintText: "예 : naneozoo@email.com",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   color: Config.hintTextColor,
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               validator: (value) {
//                 return "12312";
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
