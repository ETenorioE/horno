import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horno/models/index.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/widgets/index.dart';

class ItemServicePartnerWidget extends StatelessWidget {
  final ServiceModel service;
  const ItemServicePartnerWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(service.id),
      endActionPane: ActionPane(
          dragDismissible: false,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              backgroundColor: ColorsApp.colorSecondary,
              onPressed: (context) {
                Navigator.pushReplacementNamed(
                    context, MyRoutes.rREGISTER_SERVICES);
              },
              icon: Icons.edit,
              label: 'Editar',
            ),
            SlidableAction(
              backgroundColor: ColorsApp.colorError,
              onPressed: (context) {},
              icon: Icons.delete,
              label: 'Eliminar',
            ),
          ]),
      child: ItemServiceWidget(service: service),
    );
  }
}
