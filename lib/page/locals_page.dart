import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horno/services/index.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';
import 'package:avatar_circle_bapp/avatar_circle_bapp.dart';

class LocalsPage extends StatefulWidget {
  const LocalsPage({super.key});

  @override
  State<LocalsPage> createState() => _LocalsPageState();
}

class _LocalsPageState extends State<LocalsPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  void handleNavigation(int value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<LocalsService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const TitleWidget(
          'Locales',
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: ColorsApp.colorSecondary,
        leading: Builder(
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
        ),
        actions: [
          IconButton(
              onPressed: () {},
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
              ]))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(
                child: Center(
              child: AvatarSmartWidget(text: 'JS', radius: 60),
            )),
            Center(
              child: AvatarSmartWidgetApp(
                  image:
                      'https://cdn.pixabay.com/photo/2016/03/31/20/27/avatar-1295773_960_720.png',
                  radius: 60),
            )
          ],
        ),
      ),
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
          child: Column(
            children: [
              Row(
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
              ),
              service.isLoading
                  ? const Padding(
                      padding: EdgeInsets.only(top: 26),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : const SpaceHeight(26),
              service.locals.isEmpty && service.isLoading == false
                  ? const Center(
                      child: TextWidget('Locales encontrados 0.'),
                    )
                  : renderList(service)
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        onTap: (p0) => handleNavigation(p0),
      ),
    );
  }

  Expanded renderList(LocalsService service) {
    return Expanded(
      child: ListView.separated(
        itemCount: service.locals.length,
        separatorBuilder: ((context, index) => const SpaceHeight(20)),
        itemBuilder: (context, index) {
          final item = service.locals[index];
          return LocalItemWidget(
              name: item.name,
              schedule: item.officeHours,
              state: item.stateAttention,
              image: item.image);
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

class BottomNavigationWidget extends StatelessWidget {
  final void Function(int)? onTap;
  final int? currentIndex;

  const BottomNavigationWidget({
    Key? key,
    this.onTap,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: ColorsApp.colorText, width: 1))),
      child: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.sell), label: 'MiPedido'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'Historial'),
        ],
        currentIndex: 0,
        selectedItemColor: ColorsApp.colorSecondary,
        onTap: ((value) => onTap == null ? null : onTap!(value)),
      ),
    );
  }
}

class SpaceHeight extends StatelessWidget {
  final double height;
  const SpaceHeight(
    this.height, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class SpaceWidth extends StatelessWidget {
  final double width;
  const SpaceWidth(
    this.width, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
