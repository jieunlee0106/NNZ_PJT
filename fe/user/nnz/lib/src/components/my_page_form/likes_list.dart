// import 'package:flutter/material.dart';
// import 'package:nnz/src/components/my_page_form/like_card.dart';

// class LikesList extends StatefulWidget {
//   final List<String> items;

//   const LikesList({
//     Key? key,
//     required this.items,
//   }) : super(key: key);

//   @override
//   _LikesListState createState() => _LikesListState();
// }

// class _LikesListState extends State<LikesList> {
//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       shrinkWrap: true,
//       crossAxisCount: 2,
//       mainAxisSpacing: 16,
//       crossAxisSpacing: 16,
//       childAspectRatio: 0.75,
//       children: widget.items
//           .map(
//             (item) => LikeCard(
//               image: item.!,
//               title: item['title']!,
//               subtitle: item['subtitle']!,
//               location: item['location']!,
//             ),
//           )
//           .toList(),
//     );
//   }
// }
