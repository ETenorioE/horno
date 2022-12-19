import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

    return Scaffold(

      appBar: appBarRender(
          title: "Locales",
          actions: [_iconNotify(context)],
          leading: _iconDrawer()),
      drawer: const CustomDrawer(),
      // Drawer(
      //   child: ListView(
      //     children: const [
      //       DrawerHeader(
      //           child: Center(
      //         child: AvatarSmartWidget(text: 'JS', radius: 60),
      //       )),
      //       Center(
      //         child: AvatarSmartWidgetApp(
      //             image:
      //                 'https://cdn.pixabay.com/photo/2016/03/31/20/27/avatar-1295773_960_720.png',
      //             radius: 60),
      //       )
      //     ],
      //   ),
      // ),

      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: ColorsApp.colorLight,
        backgroundColor: ColorsApp.colorSecondary,
        strokeWidth: 4.0,
        onRefresh: () async {
          print('refresh');
          service.getAll();
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
          ),
          child: ListView(
            children: [
              _controls(service),
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
      bottomNavigationBar: BottomNavigationWidget(
        context: context,
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

  Row _controls(LocalsService service) {
    return Row(
      children: [
        SizedBox(
          width: 320,
          height: 42,
          child: TextFormField(
            style: inputStyle(ColorsApp.colorSecondary),
            decoration: inputDecoration(),
            onChanged: (value) {
              service.search(value);
            },
          ),
        ),
        const SizedBox(
          width: 3,
        ),
        IconButton(
            onPressed: (() {}),
            icon: Icon(
              Icons.filter_list,
              color: ColorsApp.colorSecondary,
            ))
      ],
    );
  }

  SizedBox renderList(LocalsService service, BuildContext contextLocal) {
    return SizedBox(
      height: 500,
      child: ListView.separated(
        itemCount: service.locals.length,
        separatorBuilder: ((context, index) => const SpaceHeight(20)),
        itemBuilder: (context, index) {
          final item = service.locals[index];
          return LocalItemWidget(
            name: item.name,
            schedule: item.officeHours,
            state: item.stateAttention,
            image: item.image,
            onTap: () {
              Navigator.pushReplacementNamed(context, MyRoutes.rLOCAL);

              // Navigator.pushNamedAndRemoveUntil(
              //     contextLocal, MyRoutes.rLOCAL, (route) => false);
            },
          );
        },
      ),
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
        contentPadding: const EdgeInsets.only(left: 18),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: ColorsApp.colorSecondary,
          ),
        ),
        enabledBorder: outline(ColorsApp.colorSecondary),
        focusedBorder: outline(ColorsApp.colorSecondary),
        border: outline(ColorsApp.colorSecondary),
        hintText: 'Buscar locales',
        hintStyle: inputStyle(ColorsApp.colorSecondary));
  }

  TextStyle inputStyle(Color colorSecondary) {
    return GoogleFonts.openSans(
        color: colorSecondary, fontSize: 16, fontWeight: FontWeight.bold);
  }

  OutlineInputBorder outline(Color colorSecondary) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(width: 1, color: colorSecondary));
  }
}
