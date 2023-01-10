import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

class DescriptionActionWidget extends StatelessWidget {
  final String description;
  final String actionText;
  final String route;
  const DescriptionActionWidget({
    Key? key,
    required this.description,
    required this.actionText,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TitleWidget(description, color: ColorsApp.colorText, fontSize: 16),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, route);
          },
          child: TitleWidget(actionText,
              color: ColorsApp.colorPrimary, fontSize: 16),
        ),
      ],
    );
  }
}
