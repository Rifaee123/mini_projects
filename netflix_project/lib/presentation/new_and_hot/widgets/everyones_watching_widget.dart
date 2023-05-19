import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constants.dart';
import 'package:netflix_app/presentation/Home/widget/custom_button_wiget.dart';
import 'package:netflix_app/presentation/Widgets/video_widget.dart';

class EveryonsesWatchingWidget extends StatelessWidget {
  final String posterPath;
  final String movieName;
  final String description;

  const EveryonsesWatchingWidget({
    super.key,
    required this.posterPath,
    required this.movieName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kheigth,
        Text(
          movieName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        kheigth,
        Text(
          description,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: kgreyColor),
        ),
        kheigth50,
        VideoWidget(
          url: posterPath,
        ),
        kheigth,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            CustomButtonWidget(
              icon: Icons.share,
              title: "Share",
              iconSize: 25,
              textSize: 16,
            ),
            kwidth,
            CustomButtonWidget(
              icon: Icons.add,
              title: "My List",
              iconSize: 28,
              textSize: 16,
            ),
            kwidth,
            CustomButtonWidget(
              icon: Icons.play_arrow,
              title: "Play",
              iconSize: 28,
              textSize: 16,
            ),
            kwidth,
          ],
        )
      ],
    );
  }
}
