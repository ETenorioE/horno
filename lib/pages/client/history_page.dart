import 'package:flutter/material.dart';
import 'package:horno/models/index.dart';
import 'package:horno/services/index.dart';
import 'package:horno/widgets/index.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with RenderPage {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PaymentService>(context);

    return ThemeCustomWidget(
      child: Scaffold(
        appBar: appBarRender(title: 'Historial de pedidos'),
        drawer: const CustomDrawer(),
        body: Stack(
          children: [
            backgroundImageRender(context),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: FutureBuilder(
                future: provider.findAll(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final list = snapshot.data;

                    if (list == null || list.isEmpty) {
                      return MessageLottie(
                          message: 'No tienes un historial de pedidos',
                          colorText: ColorsApp.colorLight,
                          asset: 'empty_box');
                    }

                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final order = list[index];
                        return _ItemHistoryWidget(
                          order: order,
                        );
                      },
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
            )
          ],
        ),
        bottomNavigationBar:
            BottomNavigationWidget(currentIndex: 2, context: context),
      ),
    );
  }
}

class _ItemHistoryWidget extends StatelessWidget {
  final OrderModel? order;
  const _ItemHistoryWidget({
    Key? key,
    this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stateImg = order!.state.toLowerCase();

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: ColorsApp.colorLight,
      child: SizedBox(
        height: 116,
        width: 372,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //NUMERO DE PEDIDO
            Padding(
              padding: const EdgeInsets.only(left: 17, top: 11, bottom: 17),
              child: TitleWidget('Numero de pedido #${order!.orderText}',
                  fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //ICONO
                Padding(
                  padding: const EdgeInsets.only(left: 17),
                  child: Container(
                    width: 52,
                    height: 49,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/order/$stateImg.png'),
                      ),
                      color: ColorsApp.colorPrimary.withOpacity(.5),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //ESTADO
                      TextWidget(order!.state,
                          fontSize: 16, color: ColorsApp.colorSecondary),
                      const SizedBox(height: 0),
                      //FECHA
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: TextWidget(order!.createdText, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                //PRECIO
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 16, left: 40, right: 17),
                  child: TextWidget(order!.totalText, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
