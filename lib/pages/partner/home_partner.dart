import 'package:flutter/material.dart';
import 'package:horno/provider/index.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
import 'widgets/index.dart';

class HomePartner extends StatelessWidget with RenderPage {
  const HomePartner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();
    final isLoading =
        context.select<ReportProvider, bool>((value) => value.isLoading);

    return ThemeCustomWidget(
      child: Scaffold(
        appBar: appBarRender(title: 'Bienvenido'),
        drawer: const DrawerPartner(),
        body: RefreshIndicatorCustom(
          onRefresh: () async {
            context
                .read<ReportProvider>()
                .findReportByLocalId(activePrev: true);
          },
          keyIndicator: refreshIndicatorKey,
          child: Stack(children: [
            Container(color: ColorsApp.colorText.withOpacity(.3)),
            Padding(
              padding: const EdgeInsets.all(20),
              child: isLoading
                  ? ListView(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SkeletonParagraph(
                              style: SkeletonParagraphStyle(
                                  lines: 3,
                                  spacing: 10,
                                  lineStyle: SkeletonLineStyle(
                                    randomLength: true,
                                    height: 30,
                                    borderRadius: BorderRadius.circular(8),
                                    minLength:
                                        MediaQuery.of(context).size.width / 6,
                                    maxLength:
                                        MediaQuery.of(context).size.width / 3,
                                  )),
                            ),
                          ),
                          const SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                                height: 100,
                                width: 100,
                                shape: BoxShape.circle),
                          ),
                        ],
                      ),
                      const SpaceHeight(20),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 30,
                          width: 80,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SpaceHeight(20),
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.4),
                      ),
                      const SpaceHeight(20),
                      Row(
                        children: const [
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                              height: 120,
                              width: 160,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          SpaceWidth(20),
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                              height: 120,
                              width: 160,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                        ],
                      )
                    ])
                  : ListView(
                      children: const [
                        RevenueReportWidget(),
                        SpaceHeight(20),
                        DayOrdersReportWidget(),
                        SpaceHeight(10),
                        BarChatWidget(),
                        SpaceHeight(10),
                        CardsReportWidget()
                      ],
                    ),
            ),
          ]),
        ),
      ),
    );
  }
}
