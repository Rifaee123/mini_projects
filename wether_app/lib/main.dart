import 'package:flutter/material.dart';
import 'package:wether_app/home_screen.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SafeArea(child: HomeScreen()),
  ));
}
