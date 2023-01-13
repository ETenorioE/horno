import 'package:flutter/material.dart';
import 'package:horno/models/index.dart';
import 'package:horno/preferences/index.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/services/index.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart' as SProvider;
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> with RenderPage {
  List<OrderModel> items = [];
  bool isLoading = false;
  bool isRealtime = false;
  String typeFilter = 'all';

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final channel = supabase.channel('my_channel');

  @override
  void initState() {
    super.initState();

    channel.on(
        RealtimeListenTypes.postgresChanges,
        ChannelFilter(
          event: 'INSERT',
          schema: 'public',
          table: 'orders',
        ), (payload, [ref]) {
      final data = payload["new"];
      final order = OrderModel.fromMapSave(data);
      print(data['local_id']);
      if (order.localId == Preferences.localId) {
        initData();
      }
    }).subscribe(
      (state, [p1]) async {
        setState(() {
          isRealtime = state == 'SUBSCRIBED';
        });
      },
    );

    initData();
  }

  void initData() {
    setState(() {
      isLoading = true;
      typeFilter = 'all';
    });

    MyOrdersService.findByLocal(Preferences.localId).then((value) {
      setState(() {
        items = value;
      });
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  void filterData({required String type, required String filter}) {
    setState(() {
      isLoading = true;
      typeFilter = type;
    });

    MyOrdersService.filterByType(local: Preferences.localId, type: filter)
        .then((value) {
      setState(() {
        items = value;
      });
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    supabase.removeChannel(channel);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeCustomWidget(
      child: Scaffold(
        appBar: appBarRender(title: 'Mis pedidos', actions: [
          Visibility(
              visible: isRealtime,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.campaign),
              ))
        ]),
        drawer: const DrawerPartner(),
        body: RefreshIndicatorCustom(
          keyIndicator: _refreshIndicatorKey,
          onRefresh: () async {
            initData();
          },
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            child: ListView(children: [
              InputFilterWidget(onChanged: (p0) {}, hintText: 'Buscar pedido'),
              const SpaceHeight(5),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonRoundedWidget(
                      'Todos',
                      isActive: typeFilter == 'all',
                      onPressed: () {
                        initData();
                      },
                    ),
                    ButtonRoundedWidget(
                      'Pendientes',
                      isActive: typeFilter == 'pending',
                      onPressed: () {
                        filterData(filter: 'Pendiente', type: 'pending');
                      },
                    ),
                    ButtonRoundedWidget(
                      'Completado',
                      isActive: typeFilter == 'completed',
                      onPressed: () {
                        filterData(filter: 'Completado', type: 'completed');
                      },
                    ),
                    ButtonRoundedWidget(
                      'Horneando',
                      isActive: typeFilter == 'baking',
                      onPressed: () {
                        filterData(filter: 'Horneando', type: 'backing');
                      },
                    ),
                  ],
                ),
              ),
              const SpaceHeight(5),
              Visibility(
                  visible: isLoading == false && items.isEmpty,
                  child: MessageLottie(
                      asset: 'no_data', message: 'Pedidos encontrados 0')),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: ColorsApp.colorSecondary,
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height - 102,
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final order = items[index];
                            return _ItemWidget(
                              order: order,
                              onTap: (order) {
                                final service =
                                    SProvider.Provider.of<ProcessService>(
                                        context,
                                        listen: false);

                                service.orderId = order.id!;

                                Navigator.pushReplacementNamed(
                                    context, MyRoutes.rStateProcess);
                              },
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SpaceHeight(20),
                          itemCount: items.length),
                    ),
            ]),
          ),
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
                TextWidget(order.timeText),
                TextWidget(order.totalText, color: ColorsApp.colorSecondary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
