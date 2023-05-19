import 'package:flutter/material.dart';

import '../../core/constants.dart';
import 'main_card.dart';
import 'main_title.dart';

class MainTitleCard extends StatelessWidget {
  const MainTitleCard({super.key, required this.title,required this.posterList});
  final String title;
  final List<String> posterList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
          child: MainTitle(
            title: title,
          ),
        ),
        kheigth,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(posterList.length, (index) {
              return Maincard(imageUrl: posterList[index]);
            }),
          ),
        ),
        kwidth
      ],
    );
  }
}
