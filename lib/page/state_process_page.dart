import 'package:flutter/material.dart';
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
    final service = Provider.of<ProcessService>(context, listen: false);

    return ThemeCustomWidget(
      child: Scaffold(
        appBar: appBarRender(
            title: 'Estado del pedido',
            leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, MyRoutes.rMy_ORDERS);
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
                  return Stack(children: [
                    ListView(children: [
                      TitleWidget("Pedido #${order.orderText}"),
                      const SpaceHeight(10),
                      _ItemProcessWidget(
                        isFirst: true,
                        title: 'Insumo recibido?',
                        description: 'Confirme si se recibio el insumo.',
                        stage: 1,
                        isCompleted: order.state == 'Completado',
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                            itemCount: order.details?.length,
                            itemBuilder: (context, index) {
                              final detail = order.details![index];

                              return _ItemProcessWidget(
                                stage: index + 2,
                                isCompleted: order.state == 'Completado',
                                title:
                                    "1 pedido ${detail.serviceName.toLowerCase()}",
                                description:
                                    'Confirme si se esta horneando el pedido',
                              );
                            },
                          )),
                    ]),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ButtonWidget(
                          onPressed: () {
                            service.saveProcess(
                                message: TypeMessage.completed,
                                isConfirmed: true);
                          },
                          text: order.state == 'Completado'
                              ? 'Pedido Completado '
                              : 'Confirmar pedido completado',
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
      afterLineStyle: LineStyle(color: color),
      indicatorStyle: IndicatorStyle(color: color),
      endChild: Container(
        padding: const EdgeInsets.only(left: 10, bottom: 10),
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
                    onChanged: (value) {
                      if (widget.isCompleted!) return;

                      setState(() {
                        isSelect = value!;
                      });
                      service.stagesCompleted = widget.stage;

                      service.saveProcess(
                          isConfirmed: value!,
                          message: widget.stage == 1
                              ? TypeMessage.ingredient
                              : TypeMessage.bake);
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
