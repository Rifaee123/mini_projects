import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:netflix_app/core/colors/colors.dart';

import '../../../core/constants.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({super.key, required this.index,required this.imageUrl});
  final int index;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 40,
              height: 200,
            ),
            Container(
              width: 130,
              height: 240,
              decoration: BoxDecoration(
                borderRadius: kRadius10,
                image:  DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      imageUrl,),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 10,
          bottom: -20,
          child: BorderedText(
            strokeWidth: 5.0,
            strokeColor: Colors.white54,
            child: Text(
              "${index + 1}",
              style: const TextStyle(
                  fontSize: 140,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  decorationColor: Colors.blue,
                  color: Colors.black),
            ),
          ),
        )
      ],
    );
  }
}
