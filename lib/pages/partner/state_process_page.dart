import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:horno/models/index.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/services/index.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class StateProcessPage extends StatelessWidget with RenderPage {
  const StateProcessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ProcessService>(context);

    return ThemeCustomWidget(
      child: Scaffold(
        appBar: appBarRender(
            title: 'Estado del pedido',
            leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, MyRoutes.rMyOrders);
                },
                icon: const Icon(Icons.arrow_back))),
        body: Padding(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: FutureBuilder(
              future: service.findById(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final order = snapshot.data;

                  if (order == null) {
                    return const Center(
                      child: TextWidget("No existe una orden pendiente"),
                    );
                  }
                  final stages = order.details!.length + 1;

                  return Stack(children: [
                    ListView(children: [
                      TitleWidget("Pedido #${order.orderText}"),
                      const SpaceHeight(10),
                      _ItemProcessWidget(
                        isFirst: true,
                        title: 'Insumo recibido?',
                        description: 'Confirme si se recibio el insumo.',
                        stage: 1,
                        isCompleted: (order.stages! > 1),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                            itemCount: order.details?.length,
                            itemBuilder: (context, index) {
                              final detail = order.details![index];
                              final stageItem = index + 2;
                              bool isLast =
                                  index == (order.details!.length - 1);

                              return _ItemProcessWidget(
                                stage: stageItem,
                                isLast: isLast,
                                isCompleted: (order.stages! >= stageItem),
                                title:
                                    "1 pedido ${detail.serviceName.toLowerCase()}",
                                description:
                                    'Confirme si se está horneando el pedido',
                              );
                            },
                          )),
                    ]),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ButtonWidget(
                          onPressed: () async {
                            if (order.stages! < stages) {
                              NotificationsService.showSnackbar(
                                  'Completa los pasos previos',
                                  state: StateNotification.error);
                              return;
                            }
                            service.stagesCompleted = order.details!.length + 1;

                            final res = await service.saveProcess(
                                type: TypeMessage.completed,
                                isConfirmed: order.state == 'Completado');
                            if (res == null) {
                              NotificationsService.showSnackbar(
                                  'Ya se envio la notificación',
                                  state: StateNotification.error);
                            } else {
                              EasyLoading.showSuccess(res);
                            }
                          },
                          text: (service.state == 'Completado') ||
                                  (order.state == 'Completado')
                              ? 'Pedido Completado '
                              : 'Terminar pedido',
                        ),
                      ),
                    )
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
            )),
      ),
    );
  }
}

class _ItemProcessWidget extends StatefulWidget {
  final bool? isFirst;
  final bool? isLast;
  final bool? isCompleted;
  final String title;
  final String description;
  final int stage;

  const _ItemProcessWidget({
    Key? key,
    this.isFirst = false,
    required this.title,
    required this.description,
    required this.stage,
    this.isCompleted = false,
    this.isLast = false,
  }) : super(key: key);

  @override
  State<_ItemProcessWidget> createState() => _ItemProcessWidgetState();
}

class _ItemProcessWidgetState extends State<_ItemProcessWidget> {
  bool isSelect = false;

  @override
  void initState() {
    isSelect = widget.isCompleted!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color color = isSelect ? ColorsApp.colorSecondary : ColorsApp.colorText;
    final service = Provider.of<ProcessService>(context);

    return TimelineTile(
      beforeLineStyle:
          LineStyle(color: widget.isFirst! ? ColorsApp.colorLight : color),
      afterLineStyle:
          LineStyle(color: widget.isLast! ? ColorsApp.colorLight : color),
      indicatorStyle: IndicatorStyle(color: color),
      endChild: Container(
        padding: const EdgeInsets.only(left: 10, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleWidget(widget.title, fontSize: 16),
                Checkbox(
                    activeColor: ColorsApp.colorSecondary,
                    value: isSelect,
                    onChanged: (value) async {
                      if (widget.isCompleted!) return;

                      setState(() {
                        isSelect = value!;
                      });
                      service.stagesCompleted = widget.stage;

                      final res = await service.saveProcess(
                          isConfirmed: value!,
                          type: widget.stage == 1
                              ? TypeMessage.ingredient
                              : TypeMessage.bake);

                      if (res == null) {
                        NotificationsService.showSnackbar(
                            'Ya se envio la notificación',
                            state: StateNotification.error);
                      } else {
                        EasyLoading.showSuccess(res);
                      }
                    }),
              ],
            ),
            TextWidget(widget.description)
          ],
        ),
      ),
    );
  }
}
