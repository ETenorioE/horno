import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horno/models/index.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/widgets/index.dart';

class ItemServicePartnerWidget extends StatelessWidget {
  final ServiceModel service;
  final Function() onPressedDelete;
  final Function() onPressedEdit;
  const ItemServicePartnerWidget(
      {super.key,
      required this.service,
      required this.onPressedDelete,
      required this.onPressedEdit});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(service.id),
      endActionPane: ActionPane(
          dragDismissible: false,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              backgroundColor: ColorsApp.colorError,
              onPressed: (context) => onPressedDelete(),
              icon: Icons.delete,
              label: 'Eliminar',
            ),
          ]),
      child: ItemServiceWidget(service: service),
    );
  }
}
