import 'package:flutter/material.dart';
import 'package:netflix_app/core/constants.dart';

class Maincard extends StatelessWidget {
  final String imageUrl;
  const Maincard({
    super.key,
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
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
    );
  }
}
