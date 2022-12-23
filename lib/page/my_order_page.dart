import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:horno/models/index.dart';
import 'package:horno/services/index.dart';
import 'package:horno/widgets/index.dart';

enum StateOrder { wait, progress, complete }

class MyOrderPage extends StatelessWidget with RenderPage {
  const MyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PaymentService>(context);

    return ThemeCustomWidget(
      child: Scaffold(
        appBar: appBarRender(title: "Mi Pedido"),
        body: FutureBuilder(
          future: provider.findById(provider.orderId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;

              if (data == null) {
                return const Center(
                  child: TextWidget("No existe una orden pendiente"),
                );
              }

              return Stack(children: [
                backgroundImageRender(context),
                Padding(
                    padding: _paddingPage(),
                    child: Container(
                        padding: _paddingCard(),
                        decoration: _decorationCard(),
                        child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              _header(data),
                              const SpaceHeight(23),
                              _notifyState(),
                              const SpaceHeight(22),
                              _messageStateOrder(),
                              const SpaceHeight(22),
                              _titleDetails(),
                              const SpaceHeight(15),
                              _listRender(data)
                            ])))),
                _footer(data)
              ]);
            } else if (snapshot.hasError) {
              return Center(
                child: TextWidget(
                  'No se pudo recuperar la orden, intente mas tarde',
                  color: ColorsApp.colorError,
                ),
              );
            } else {
              return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: ColorsApp.colorSecondary,
                ),
              );
            }
          },
        ),
        drawer: const CustomDrawer(),
        bottomNavigationBar:
            BottomNavigationWidget(currentIndex: 1, context: context),
      ),
    );
  }

  Positioned _footer(OrderModel data) {
    return Positioned(
        bottom: 0,
        right: 20,
        left: 20,
        child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 17,
              vertical: 11,
            ),
            color: ColorsApp.colorLight,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _nroItem(data),
                  _total(data),
                ])));
  }

  TitleWidget _total(OrderModel data) {
    return TitleWidget(data.totalText,
        color: ColorsApp.colorSecondary, fontSize: 16);
  }

  TitleWidget _nroItem(OrderModel data) {
    return TitleWidget('# pedidos ${data.details!.length}',
        color: ColorsApp.colorSecondary, fontSize: 16);
  }

  Row _notifyState() {
    return Row(
      children: [
        const _ImageAssetWidget(image: 'ingredient_wait'),
        _stageOrder(StateOrder.wait),
        const _ImageAssetWidget(image: 'bake_wait'),
        _stageOrder(StateOrder.wait),
        const _ImageAssetWidget(image: 'task_progress'),
      ],
    );
  }

  SizedBox _listRender(OrderModel data) {
    return SizedBox(
        height: 320,
        child: ListView.separated(
            itemCount: data.details!.length,
            separatorBuilder: (context, index) => const SpaceHeight(13),
            itemBuilder: (context, index) {
              final detail = data.details?[index];
              return ItemDetailWidget(
                detail: detail,
              );
            }));
  }

  TitleWidget _titleDetails() => const TitleWidget('Detalle', fontSize: 16);

  Center _messageStateOrder() {
    return Center(
      child: TextWidget('Cliente debe entregar el  pedido al local',
          fontSize: 16, color: ColorsApp.colorTitle),
    );
  }

  Expanded _stageOrder(StateOrder state) {
    return Expanded(
      child: LineDashedWidget(
        height: 2,
        color: state == StateOrder.complete
            ? ColorsApp.colorSuccess
            : ColorsApp.colorText,
      ),
    );
  }

  Row _header(OrderModel? data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_textOrder(data), _textTime()],
    );
  }

  IconAndTextWidget _textTime() {
    return const IconAndTextWidget(text: '0:00:01', icon: Icons.av_timer);
  }

  TitleWidget _textOrder(OrderModel? data) {
    return TitleWidget(
      'Número de orden #${data?.orderText}',
      fontSize: 16,
    );
  }

  EdgeInsets _paddingCard() =>
      const EdgeInsets.symmetric(vertical: 11, horizontal: 17);

  EdgeInsets _paddingPage() =>
      const EdgeInsets.only(top: 20, right: 20, left: 20);

  BoxDecoration _decorationCard() {
    return BoxDecoration(
        color: ColorsApp.colorLight, borderRadius: borderRadiusTopRender());
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
