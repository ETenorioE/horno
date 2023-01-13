import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:horno/models/index.dart';
import 'package:horno/pages/partner/widgets/item_service_partner_widget.dart';
import 'package:horno/provider/index.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';

class MyServicesPage extends StatefulWidget {
  const MyServicesPage({super.key});

  @override
  State<MyServicesPage> createState() => _MyServicesPageState();
}

class _MyServicesPageState extends State<MyServicesPage> with RenderPage {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final services =
        context.select<PartnerServicesProvider, List<ServiceModel>>(
      (value) => value.services,
    );

    final isLoading = context.select<PartnerServicesProvider, bool>(
      (value) => value.isLoading,
    );

    return ThemeCustomWidget(
      child: Scaffold(
        appBar: appBarRender(title: 'Mis Servicios', actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, MyRoutes.rRegisterServices);
              },
              icon: const Icon(Icons.add))
        ]),
        drawer: const DrawerPartner(),
        body: RefreshIndicatorCustom(
          keyIndicator: _refreshIndicatorKey,
          onRefresh: () async {
            context
                .read<PartnerServicesProvider>()
                .findAllByLocalId(enableLoading: true);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: isLoading
                ? const CircularProgressCustomWidget()
                : isLoading == false && services.isEmpty
                    ? MessageLottie(
                        message: 'Servicios encontrados 0', asset: 'no_data')
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          final service = services[index];

                          return ItemServicePartnerWidget(
                            service: service,
                            onPressedEdit: () {
                              (context) {
                                Navigator.pushReplacementNamed(
                                    context, MyRoutes.rRegisterServices);
                              };
                            },
                            onPressedDelete: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text(
                                    '¿Eliminar servicio?',
                                    style:
                                        TextStyle(color: ColorsApp.colorTitle),
                                  ),
                                  content: Text(
                                    '¿Estás seguro de eliminar el servicio?',
                                    style:
                                        TextStyle(color: ColorsApp.colorTitle),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text(
                                        'No',
                                        style: TextStyle(color: Colors.black26),
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).pop('false'),
                                    ),
                                    TextButton(
                                      child: const Text(
                                        'Si',
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).pop('true'),
                                    ),
                                  ],
                                  elevation: 24.0,
                                ),
                              ).then((value) async {
                                if (value == 'true') {
                                  final providerAction =
                                      Provider.of<PartnerServicesProvider>(
                                          context,
                                          listen: false);
                                  final res = await providerAction
                                      .deleteById(service.id);

                                  if (res == null) {
                                    EasyLoading.instance.backgroundColor =
                                        ColorsApp.colorSuccess;

                                    EasyLoading.showSuccess(
                                        'Servicio eliminado');
                                  } else {
                                    EasyLoading.instance.backgroundColor =
                                        ColorsApp.colorError;

                                    EasyLoading.showError(res);
                                  }
                                }
                              });
                            },
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SpaceHeight(10),
                        itemCount: services.length),
          ),
        ),
      ),
    );
  }
}

class CircularProgressCustomWidget extends StatelessWidget {
  const CircularProgressCustomWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: ColorsApp.colorSecondary,
      ),
    );
  }
}
