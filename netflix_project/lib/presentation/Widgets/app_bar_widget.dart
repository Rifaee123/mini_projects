import 'package:flutter/material.dart';
import 'package:netflix_app/core/constants.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),
        ),
        const Spacer(),
        const Icon(
          Icons.cast,
          size: 30,
          color: Colors.white,
        ),
        kwidth,
        Container(
          width: 30,
          height: 30,
          // color: Colors.blue,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://mir-s3-cdn-cf.behance.net/project_modules/disp/1bdc9a33850498.56ba69ac2ba5b.png"))),
        ),
        kwidth,
      ],
    );
  }
}
