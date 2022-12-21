import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';
import 'package:horno/widgets/line_dashed_widget.dart';

class MyOrderPage extends StatelessWidget with RenderPage {
  const MyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          primaryIconTheme: IconThemeData(color: ColorsApp.colorLight)),
      child: Scaffold(
        appBar: appBarRender(title: "Mi Pedido"),
        body: Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 17),
              decoration: BoxDecoration(
                  color: ColorsApp.colorLight,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        TitleWidget(
                          'Número de orden #453',
                          fontSize: 16,
                        ),
                        IconAndTextWidget(text: '2:12:23', icon: Icons.av_timer)
                      ],
                    ),
                    const SpaceHeight(23),
                    Row(
                      children: [
                        const _ImageAssetWidget(image: 'ingredient_received'),
                        Expanded(
                          child: LineDashedWidget(
                            color: ColorsApp.colorSuccess,
                            height: 2,
                          ),
                        ),
                        const _ImageAssetWidget(image: 'bake_progress'),
                        Expanded(
                          child: LineDashedWidget(
                            height: 2,
                            color: ColorsApp.colorText,
                          ),
                        ),
                        const _ImageAssetWidget(image: 'task_progress'),
                      ],
                    ),
                    const SpaceHeight(22),
                    Center(
                      child: TextWidget('1/2 pedidos horneandose',
                          fontSize: 16, color: ColorsApp.colorTitle),
                    ),
                    const SpaceHeight(22),
                    const TitleWidget('Detalle', fontSize: 16),
                    const SpaceHeight(15),
                    SizedBox(
                      height: 320,
                      child: ListView.separated(
                        itemCount: 2,
                        separatorBuilder: (context, index) =>
                            const SpaceHeight(13),
                        itemBuilder: (context, index) {
                          return const ItemDetailWidget();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 20,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 11),
              color: ColorsApp.colorLight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleWidget(
                    'Total (2 pedidos)',
                    color: ColorsApp.colorSecondary,
                    fontSize: 16,
                  ),
                  TitleWidget(
                    'S/. 73.0',
                    color: ColorsApp.colorSecondary,
                    fontSize: 16,
                  ),
                ],
              ),
            ),
          )
        ]),
        drawer: const CustomDrawer(),
        bottomNavigationBar:
            BottomNavigationWidget(currentIndex: 1, context: context),
      ),
    );
  }
}

class _ImageAssetWidget extends StatelessWidget {
  final String image;

  const _ImageAssetWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/order/$image.png',
      height: 40,
      width: 40,
    );
  }
}
