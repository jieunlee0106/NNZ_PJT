import 'package:flutter/material.dart';

class TagShow extends StatelessWidget {
  final String tagName;
  TagShow({
    Key? key,
    required this.tagName,
  }) : super(key: key);

  final List<Map<String, String>> items = [
    {
      'image':
          'http://ticketimage.interpark.com/rz/image/play/goods/poster/23/23003443_p_s.jpg',
    },
    {
      'image':
          'http://ticketimage.interpark.com/rz/image/play/goods/poster/23/23005708_p_s.jpg',
    },
    {
      'image':
          'http://ticketimage.interpark.com/rz/image/play/goods/poster/23/23003272_p_s.jpg',
    },
    {
      'image':
          'https://blog.jandi.com/ko/wp-content/uploads/sites/4/2022/01/%EC%9E%94%EB%94%94%EA%B5%BF%EC%A6%88_%EC%A2%85%ED%95%A9%EB%AA%A9%EC%97%85-1.jpg',
    },
    {
      'image':
          'http://ticketimage.interpark.com/Play/image/large/23/23003197_p.gif',
    },
    {
      'image': 'https://via.placeholder.com/150',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .map(
              (item) => Container(
                width: 110,
                height: 160,
                margin: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 110,
                      height: 160,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 253, 253),
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image: NetworkImage(item['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
