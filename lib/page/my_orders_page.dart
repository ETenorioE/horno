import 'package:flutter/material.dart';
import 'package:horno/models/index.dart';
import 'package:horno/services/my_orders_service.dart';
import 'package:horno/widgets/drawer_partner.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> with RenderPage {
  List<OrderModel> items = [];

  @override
  void initState() {
    super.initState();

    supabase.channel('my_channel').on(
        RealtimeListenTypes.postgresChanges,
        ChannelFilter(
          event: 'INSERT',
          schema: 'public',
          table: 'orders',
        ), (payload, [ref]) {
      initData();
    }).subscribe(
      (state, [p1]) async {
        print(state);
      },
    );

    initData();
  }

  void initData() {
    MyOrdersService.findByLocal(2).then((value) {
      setState(() {
        items = value;
      });
    });
  }

  @override
  void dispose() {
    supabase.removeAllChannels();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeCustomWidget(
      child: Scaffold(
        appBar: appBarRender(title: 'Mis pedidos'),
        drawer: const DrawerPartner(),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: ListView(children: [
            InputFilterWidget(onChanged: (p0) {}, hintText: 'Buscar pedido'),
            const SpaceHeight(20),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final order = items[index];
                    return _ItemWidget(
                      order: order,
                      onTap: (order) {},
                    );
                  },
                  separatorBuilder: (context, index) => const SpaceHeight(20),
                  itemCount: items.length),
            )
          ]),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final OrderModel order;
  final Function(OrderModel order) onTap;

  const _ItemWidget({
    super.key,
    required this.order,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(order),
      child: Container(
        height: 80,
        width: 372,
        padding: const EdgeInsets.only(left: 10, top: 10),
        decoration: BoxDecoration(
            border: Border(
                left: BorderSide(width: 2, color: ColorsApp.colorPrimary))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleWidget('Numero de pedido #${order.orderText}',
                    fontSize: 16),
                TitleWidget(order.state, fontSize: 16),
              ],
            ),
            const SpaceHeight(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(order.createdText),
                TextWidget(order.totalText, color: ColorsApp.colorSecondary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
