import 'package:flutter/material.dart';
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
        height: 180,
        width: double.infinity,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: const AssetImage('assets/images/loading_2.gif'),
                image: NetworkImage(image),
              ),
            ),
            Positioned(
                right: 10,
                top: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorsApp.colorSecondary.withOpacity(.5)),
                  child: IconAndTextWidget(
                    icon: Icons.star,
                    text: '0',
                    color: ColorsApp.colorLight,
                    colorText: ColorsApp.colorLight,
                  ),
                )),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                color: ColorsApp.colorBlack.withOpacity(.5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleWidget(name, color: ColorsApp.colorLight),
                      ],
                    ),
                    const SpaceHeight(5),
                    Row(
                      children: [
                        IconAndTextWidget(text: schedule, icon: Icons.schedule),
                        Container(
                            width: 4,
                            height: 4,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                color: ColorsApp.colorText,
                                shape: BoxShape.circle)),
                        TextWidget(state),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
