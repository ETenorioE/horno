import 'package:flutter/material.dart';
import 'package:horno/database/index.dart';
import 'package:horno/models/index.dart';
import 'package:horno/preferences/index.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/services/index.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';

class LocalPage extends StatefulWidget {
  const LocalPage({super.key});

  @override
  State<LocalPage> createState() => _LocalPageState();
}

class _LocalPageState extends State<LocalPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalsService>(context);

    final detailsOrder = context
        .select<OrderService, List<DetailDbModel>>((value) => value.details);

    return Scaffold(
        backgroundColor: ColorsApp.colorSecondary,
        bottomNavigationBar:
            BottomNavigationWidget(currentIndex: -1, context: context),
        body: RefreshIndicatorCustom(
          keyIndicator: _refreshIndicatorKey,
          onRefresh: () async {
            provider.findLocalById();
          },
          child: Stack(children: [
            ListView(children: [
              _header(context, provider.local),
              _details(provider.local),
              _servicesHeader(),
              Visibility(
                visible: provider.isLoading,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    padding:
                        const EdgeInsets.only(top: 20, right: 10, left: 10),
                    color: ColorsApp.colorLight,
                    child: const CircularProgressCustom()),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
                  color: ColorsApp.colorLight,
                  child: ListView.separated(
                      itemCount: provider.local!.services.length,
                      separatorBuilder: (context, index) =>
                          const SpaceHeight(20),
                      itemBuilder: (context, index) {
                        final service = provider.local!.services[index];

                        return ItemServiceWidget(
                            service: service,
                            onTap: () {
                              context
                                  .read<OrderService>()
                                  .createOrder(service, Preferences.userId);
                              Navigator.pushReplacementNamed(
                                  context, MyRoutes.rOrderDetail);
                            });
                      }))
            ]),
            Visibility(
              visible: detailsOrder.isNotEmpty,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 20, left: 20, bottom: 10),
                  child: ButtonWidget(
                    prefix: Icon(
                      Icons.shopping_cart,
                      color: ColorsApp.colorLight,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, MyRoutes.rOrderDetail);
                    },
                    text: 'Ver mi pedido',
                  ),
                ),
              ),
            )
          ]),
        ));
  }

  Container _servicesHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: ColorsApp.colorLight,
          border: Border.symmetric(
              horizontal: BorderSide(width: 3, color: ColorsApp.colorText))),
      child: Row(
        children: [
          IconAndTextWidget(
              text: "Servicios",
              icon: Icons.room_service,
              color: ColorsApp.colorSecondary,
              colorText: ColorsApp.colorSecondary),
          const SpaceWidth(23),
          MaterialButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: ColorsApp.colorSecondary)),
              child: TextWidget("Hornear", color: ColorsApp.colorSecondary))
        ],
      ),
    );
  }

  Container _details(LocalModel? local) {
    return Container(
      color: ColorsApp.colorLight,
      padding: const EdgeInsets.only(right: 20, top: 17, left: 20, bottom: 27),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleWidget(local!.name, fontSize: 18),
              Visibility(
                visible: local.stateAttentionText != '',
                child: TitleWidget(local.stateAttentionText,
                    fontSize: 16,
                    color: local.stateAttentionText == 'Cerrado'
                        ? ColorsApp.colorError
                        : ColorsApp.colorSuccess),
              )
            ],
          ),
          const SpaceHeight(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconAndTextWidget(
                  icon: Icons.location_on_outlined, text: local.address),
              IconAndTextWidget(
                  text: local.officeHours, icon: Icons.access_time)
            ],
          ),
          const SpaceHeight(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconAndTextWidget(
                  text: local.rating.toString(),
                  icon: Icons.star,
                  color: ColorsApp.colorSecondary),
              Row(
                  children: local.contacts
                      .map(
                          (e) => _IconButtonImageWidget(contact: e.contactName))
                      .toList())
            ],
          ),
        ],
      ),
    );
  }

  Container _header(BuildContext context, LocalModel? local) {
    return Container(
        color: ColorsApp.colorLight,
        height: 160,
        child: Stack(clipBehavior: Clip.none, children: [
          Positioned(
              bottom: 25,
              top: 0,
              right: 0,
              left: 0,
              child: imageNetworkCustom(local!.banner)),
          Positioned(bottom: 0, left: 20, child: _LogoWidget(url: local.image)),
          Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButtonBgWidget(
                        icon: Icons.arrow_back,
                        color: ColorsApp.colorTitle,
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, MyRoutes.rLOCALS);
                        }),
                    IconButtonBgWidget(
                        icon: Icons.favorite_border,
                        color: ColorsApp.colorSecondary)
                  ]))
        ]));
  }
}

class _IconButtonImageWidget extends StatelessWidget {
  final String contact;

  const _IconButtonImageWidget({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30,
        width: 30,
        child: IconButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {},
            icon: Image.asset('assets/contact/$contact.png',
                height: 22, width: 22, fit: BoxFit.cover)));
  }
}

class _LogoWidget extends StatelessWidget {
  final String url;

  const _LogoWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 52,
        width: 60,
        decoration: BoxDecoration(
            color: ColorsApp.colorLight,
            borderRadius: BorderRadius.circular(9)),
        padding: const EdgeInsets.all(2),
        child: ImageNetworkRoundedWidget(radius: 9, url: url));
  }
}
