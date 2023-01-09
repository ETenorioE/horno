import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PaymentService>(context);

    return ThemeCustomWidget(
      child: Scaffold(
        appBar: appBarRender(title: "Mi Pedido"),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          color: ColorsApp.colorLight,
          backgroundColor: ColorsApp.colorSecondary,
          strokeWidth: 4.0,
          onRefresh: () async {
            setState(() {});
          },
          child: FutureBuilder(
            future: provider.findById(provider.orderId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data;

                if (data == null) {
                  return MessageLottie(
                      message: 'No existe el pedido pendiente',
                      asset: 'empty_box');
                }

                final order = data['order'];

                if (order == null) {
                  return MessageLottie(
                      message: 'No existe el pedido pendiente',
                      asset: 'empty_box');
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
                                _header(order),
                                const SpaceHeight(23),
                                _notifyState(order),
                                const SpaceHeight(22),
                                _messageStateOrder(order),
                                const SpaceHeight(22),
                                _titleDetails(),
                                const SpaceHeight(15),
                                _listRender(order)
                              ])))),
                  _footer(order)
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
      'Número de pedido #${data?.orderText}',
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
