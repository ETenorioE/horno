import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Marte',
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: const [
          SizedBox(
            height: 10,
          ),
          TitleWidget('title'),
          TextWidget('texto'),
        ],
      ),
    );
  }
}
