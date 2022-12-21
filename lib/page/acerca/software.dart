import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class SoftwareScreen extends StatelessWidget {
  const SoftwareScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SoftwareScreen',
            style: TextStyle(
                color: ColorsApp.colorLight,
                fontWeight: FontWeight.bold,
                fontSize: 26)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorsApp.colorPrimary,
      ),
      body: Column(
        children: const [
          SizedBox(
            height: 10,
          ),
          Text(
            'SoftwareScreen',
          ),
        ],
      ),
    );
  }
}
