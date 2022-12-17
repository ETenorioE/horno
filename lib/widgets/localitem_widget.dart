import 'package:flutter/material.dart';
import 'package:horno/page/index.dart';
import 'package:horno/widgets/index.dart';

class LocalItemWidget extends StatelessWidget {
  final String name;
  final String schedule;
  final String state;
  final String image;
  final Function()? onTap;

  const LocalItemWidget({
    Key? key,
    required this.name,
    required this.schedule,
    required this.state,
    required this.image,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap == null ? null : onTap!(),
      child: SizedBox(
        width: 372,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(image,
                      width: 118, height: 119, fit: BoxFit.cover),
                ),
                const SizedBox(
                  width: 14,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleWidget(name),
                      const SizedBox(
                        height: 10,
                      ),
                      TextWidget(
                        state,
                        color: state == 'Abierto'
                            ? ColorsApp.colorSuccess
                            : ColorsApp.colorError,
                      ),
                      const SpaceHeight(11),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: ColorsApp.colorText,
                          ),
                          TextWidget(
                            schedule,
                            color: ColorsApp.colorText,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 96,
                height: 40,
                decoration: BoxDecoration(
                    color: ColorsApp.colorPrimary,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Center(
                  child: TextWidget(
                    'Ingresar',
                    color: ColorsApp.colorLight,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
