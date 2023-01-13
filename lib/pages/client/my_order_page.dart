import 'package:flutter/material.dart';
import 'package:horno/preferences/index.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:horno/models/index.dart';
import 'package:horno/services/index.dart';
import 'package:horno/widgets/index.dart';

enum StateOrder { wait, progress, complete }

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> with RenderPage {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  OrderModel? _order;

  Future initData() async {
    final res = await context
        .read<PaymentService>()
        .findById(Preferences.orderId == 0 ? null : Preferences.orderId);

    return res;
  }

  Future refreshData() async {
    final res = await context
        .read<PaymentService>()
        .findById(Preferences.orderId == 0 ? null : Preferences.orderId);
    setState(() {
      _order = res['order'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeCustomWidget(
      child: Scaffold(
        appBar: appBarRender(title: "Mi Pedido"),
        body: RefreshIndicatorCustom(
          keyIndicator: _refreshIndicatorKey,
          onRefresh: () async {
            await refreshData();
          },
          child: Stack(children: [
            backgroundImageRender(context),
            Padding(
              padding: _paddingPage(),
              child: Container(
                padding: _paddingCard(),
                decoration: _decorationCard(),
                child: FutureBuilder(
                  future: initData(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        return Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            color: ColorsApp.colorSecondary,
                          ),
                        );
                      case ConnectionState.done:
                        final data = snapshot.data;

                        if (data == null) {
                          return Center(
                            child: MessageLottie(
                                message:
                                    'No existe el pedido, intente mas tarde',
                                asset: 'empty_box'),
                          );
                        }
                        final order = data["order"];
                        if (order == null) {
                          return Center(
                            child: MessageLottie(
                                message:
                                    'No existe el pedido, intente mas tarde',
                                asset: 'empty_box'),
                          );
                        }

                        return SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              _header(order),
                              const SpaceHeight(23),
                              _notifyState(order!),
                              const SpaceHeight(22),
                              _messageStateOrder(order!),
                              const SpaceHeight(22),
                              _titleDetails(),
                              const SpaceHeight(15),
                              _listRender(order!)
                            ]));
                    }
                  },
                ),
              ),
            ),
          ]),
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
    return TitleWidget('# items ${data.details!.length}',
        color: ColorsApp.colorSecondary, fontSize: 16);
  }

  Row _notifyState(OrderModel order) {
    String stateIngredientAsset = 'ingredient_wait';
    String stateBakeAsset = 'bake_wait';
    String stateTaskAsset = 'task_progress';
    StateOrder stage1 = StateOrder.wait;
    StateOrder stage2 = StateOrder.wait;

    if (order.state == "Iniciando") {
      stateIngredientAsset = 'ingredient_received';
      stage1 = StateOrder.complete;
    } else if (order.state == 'Completado') {
      stateIngredientAsset = 'ingredient_received';
      stateBakeAsset = 'bake_complete';
      stateTaskAsset = 'task_complete';
      stage1 = StateOrder.complete;
      stage2 = StateOrder.complete;
    } else if (order.state == 'Horneando') {
      stateIngredientAsset = 'ingredient_received';
      stateBakeAsset = 'bake_progress';
    }
    return Row(
      children: [
        _ImageAssetWidget(image: stateIngredientAsset),
        _stageOrder(stage1),
        _ImageAssetWidget(image: stateBakeAsset),
        _stageOrder(stage2),
        _ImageAssetWidget(image: stateTaskAsset),
      ],
    );
  }

  SizedBox _listRender(OrderModel data) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
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

  Center _messageStateOrder(OrderModel order) {
    String message = 'Cliente debe entregar su insumo al local';

    if (order.state == "Iniciando") {
      message = 'Su pedido se encuentra en cola';
    } else if (order.state == 'Completado') {
      message = 'Su pedido se encuentra listo para recoger';
    } else if (order.state == 'Horneando') {
      int item = order.stages! - 1;
      int items = order.details!.length;
      message = 'Su pedido se encuentra horneandose $item/$items';
    }
    return Center(
      child: TextWidget(message, fontSize: 16, color: ColorsApp.colorTitle),
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

  Row _header(OrderModel? order) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleWidget('Pedido #${order!.orderText}', fontSize: 16),
        IconAndTextWidget(text: order.timeText, icon: Icons.av_timer)
      ],
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
