import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constants.dart';
import 'package:netflix_app/presentation/Home/widget/custom_button_wiget.dart';

class BackgroundCard extends StatelessWidget {
  const BackgroundCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 600,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: 2.0,
                  image: NetworkImage(
                    kmainImge,
                  ),
                  fit: BoxFit.cover)),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CustomButtonWidget(icon: Icons.add, title: 'My List'),
                _playButton(),
                const CustomButtonWidget(
                    icon: Icons.info_outline_rounded, title: "Info")
              ],
            ),
          ),
        )
      ],
    );
  }

  TextButton _playButton() {
    return TextButton.icon(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(kWhiteColor)),
      onPressed: () {},
      icon: const Icon(
        Icons.play_arrow,
        size: 30,
        color: kBlackColor,
      ),
      label: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.0),
        child: Text(
          'Play',
          style: TextStyle(
              fontSize: 20, color: kBlackColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
