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

  void handleNavigation(int value) {
    print(value);
  }

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
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            color: ColorsApp.colorLight,
            backgroundColor: ColorsApp.colorSecondary,
            strokeWidth: 4.0,
            onRefresh: () async {
              service.getAll();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: ListView(
                children: [
                  InputFilterWidget(
                      onChanged: (value) {
                        service.search(value);
                      },
                      hintText: 'Buscar local'),
                  service.isLoading
                      ? Padding(
                          padding: const EdgeInsets.only(top: 26),
                          child: Center(
                            child: CircularProgressIndicator(
                                color: ColorsApp.colorSecondary),
                          ),
                        )
                      : const SpaceHeight(26),
                  service.locals.isEmpty && service.isLoading == false
                      ? const Center(
                          child: TextWidget('Locales encontrados 0.'),
                        )
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

  Builder _iconDrawer() {
    return Builder(
      builder: (context) {
        return IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: ColorsApp.colorLight,
          ),
        );
      },
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

  SizedBox renderList(LocalsService service, BuildContext contextLocal) {
    return SizedBox(
        height: MediaQuery.of(context).size.height - 20,
        child: ListView.separated(
            itemCount: service.locals.length,
            separatorBuilder: ((context, index) => const SpaceHeight(20)),
            itemBuilder: (context, index) {
              final item = service.locals[index];
              return LocalItemWidget(
                  name: item.name,
                  schedule: item.officeHours,
                  state: item.stateAttention,
                  image: item.banner,
                  onTap: () {
                    service.setLocal(item);
                    Navigator.pushReplacementNamed(context, MyRoutes.rLOCAL);
                  });
            }));
  }
}
