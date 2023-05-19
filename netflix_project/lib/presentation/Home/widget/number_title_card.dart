import 'package:flutter/material.dart';
import 'package:netflix_app/core/constants.dart';
import 'package:netflix_app/presentation/Home/widget/number_card.dart';
import 'package:netflix_app/presentation/Widgets/main_title.dart';

class NumberTitleCard extends StatelessWidget {
  const NumberTitleCard({
    super.key,
    required this.postersList,
  });

  final List<String> postersList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
          child: MainTitle(
            title: "Top 10 TV shows in India Today",
          ),
        ),
        kheigth,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(postersList.length, (index) {
              return NumberCard(index: index,imageUrl: postersList[index],);
            }),
          ),
        ),
        kwidth
      ],
    );
  }
}
