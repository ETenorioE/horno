import 'package:flutter/material.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/services/index.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';
// import 'package:avatar_circle_bapp/avatar_circle_bapp.dart';

class LocalsPage extends StatefulWidget {
  const LocalsPage({super.key});

  @override
  State<LocalsPage> createState() => _LocalsPageState();
}

class _LocalsPageState extends State<LocalsPage> with RenderPage {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<LocalsService>(context);

    return ThemeCustomWidget(
      child: Scaffold(
        appBar: appBarRender(title: "Locales", actions: [_iconNotify(context)]),
        drawer: const CustomDrawer(),
        body: GestureDetector(
          onTap: () {
            final FocusScopeNode focus = FocusScope.of(context);
            if (!focus.hasPrimaryFocus && focus.hasFocus) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          },
          child: RefreshIndicatorCustom(
            keyIndicator: _refreshIndicatorKey,
            onRefresh: () async {
              service.getAll();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: [
                  const SpaceHeight(20),
                  InputFilterWidget(
                      onChanged: (value) {
                        service.search(value);
                      },
                      hintText: 'Buscar local'),
                  service.isLoading
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Center(
                            child: CircularProgressIndicator(
                                color: ColorsApp.colorSecondary),
                          ),
                        )
                      : const SpaceHeight(10),
                  service.locals.isEmpty && service.isLoading == false
                      ? MessageLottie(
                          message: 'Locales encontrados 0',
                          asset: 'empty_search')
                      : renderList(service, context)
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationWidget(context: context),
      ),
    );
  }

  IconButton _iconNotify(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, MyRoutes.rNOTIFY);
        },
        icon: Stack(children: [
          Icon(
            Icons.notifications,
            color: ColorsApp.colorLight,
          ),
          Positioned(
            right: 3,
            top: 0,
            child: Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: ColorsApp.colorError),
            ),
          )
        ]));
  }

  ListView renderList(LocalsService service, BuildContext contextLocal) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: service.locals.length,
        separatorBuilder: ((context, index) => const SpaceHeight(5)),
        itemBuilder: (context, index) {
          final item = service.locals[index];
          return LocalItemWidget(
              name: item.name,
              schedule: item.officeHours,
              state: item.stateAttentionText,
              image: item.banner,
              onTap: () {
                service.setLocal(item);
                Navigator.pushReplacementNamed(context, MyRoutes.rLOCAL);
              });
        });
  }
}
