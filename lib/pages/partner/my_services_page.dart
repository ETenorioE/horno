import 'package:flutter/material.dart';
import 'package:horno/models/index.dart';
import 'package:horno/pages/partner/widgets/item_service_partner_widget.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/widgets/index.dart';

class MyServicesPage extends StatelessWidget with RenderPage {
  const MyServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeCustomWidget(
      child: Scaffold(
        appBar: appBarRender(title: 'Mis Servicios', actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, MyRoutes.rREGISTER_SERVICES);
              },
              icon: const Icon(Icons.add))
        ]),
        drawer: const DrawerPartner(),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return ItemServicePartnerWidget(
                    service: ServiceModel(
                        id: 1,
                        image:
                            'https://cdn.pixabay.com/photo/2016/12/26/17/28/spaghetti-1932466_960_720.jpg',
                        name: 'Cocinca',
                        price: 16,
                        createdAt: DateTime.now(),
                        localId: 1,
                        serviceId: 1));
              },
              separatorBuilder: (context, index) => SpaceHeight(10),
              itemCount: 2),
        ),
      ),
    );
  }
}
