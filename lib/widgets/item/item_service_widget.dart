import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horno/models/index.dart';
import 'package:horno/widgets/index.dart';

class ItemServiceWidget extends StatelessWidget {
  final Function()? onTap;
  final ServiceModel service;

  const ItemServiceWidget({
    Key? key,
    this.onTap,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTap == null ? null : onTap!(),
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(width: 3, color: ColorsApp.colorPrimary),
              ),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 70,
                      height: 70,
                      child: ImageNetworkRoundedWidget(
                          radius: 5, url: service.image)),
                  const SpaceWidth(10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(service.name,
                              minFontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  color: ColorsApp.colorTitle,
                                  fontWeight: FontWeight.bold)),
                          const SpaceHeight(5),
                          Row(children: [
                            const TextWidget("Precio por kilo"),
                            const SpaceWidth(29),
                            TitleWidget(
                                "S/. ${service.price.toStringAsFixed(2)}",
                                fontSize: 19),
                          ])
                        ]),
                  ),
                  Icon(Icons.arrow_forward, color: ColorsApp.colorPrimary)
                ])));
  }
}
