import 'package:flutter/material.dart';
import 'package:horno/page/index.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/widgets/index.dart';

class LocalPage extends StatelessWidget {
  const LocalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.colorSecondary,
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: -1,
        context: context,
      ),
      body: ListView(
        children: [
          _header(context),
          _details(),
          _services(),
          Container(
            height: 320,
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            color: ColorsApp.colorLight,
            child: ListView.separated(
              itemCount: 3,
              separatorBuilder: (context, index) => const SpaceHeight(20),
              itemBuilder: (context, index) {
                return const ItemServiceWidget();
              },
            ),
          )
        ],
      ),
    );
  }

  Container _services() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: ColorsApp.colorLight,
          border: Border.symmetric(
              horizontal: BorderSide(
            width: 3,
            color: ColorsApp.colorText,
          ))),
      child: Row(
        children: [
          _IconAndTextWidget(
            text: "Servicios",
            icon: Icons.room_service,
            color: ColorsApp.colorSecondary,
            colorText: ColorsApp.colorSecondary,
          ),
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

  Container _details() {
    return Container(
      color: ColorsApp.colorLight,
      padding: const EdgeInsets.only(right: 20, top: 17, left: 20, bottom: 27),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TitleWidget(
                'La Pastana - Los Olivos',
                fontSize: 18,
              ),
              TitleWidget(
                'Abierto',
                fontSize: 16,
                color: ColorsApp.colorSuccess,
              )
            ],
          ),
          const SpaceHeight(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _IconAndTextWidget(
                icon: Icons.location_on_outlined,
                text: "Av. Los rios",
              ),
              _IconAndTextWidget(text: "10:00 - 22:00", icon: Icons.access_time)
            ],
          ),
          const SpaceHeight(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _IconAndTextWidget(
                text: "4.8",
                icon: Icons.star,
                color: ColorsApp.colorSecondary,
              ),
              Row(
                children: const [
                  _IconButtonImageWidget(
                    contact: 'whatsapp',
                  ),
                  _IconButtonImageWidget(
                    contact: 'facebook',
                  ),
                  _IconButtonImageWidget(
                    contact: 'instagram',
                  ),
                  _IconButtonImageWidget(
                    contact: 'tiktok',
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Container _header(BuildContext context) {
    return Container(
      color: ColorsApp.colorLight,
      height: 160,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 25,
            top: 0,
            right: 0,
            left: 0,
            child: Image.network(
              'https://cdn.pixabay.com/photo/2016/11/29/10/09/bakery-1868925_960_720.jpg',
              fit: BoxFit.cover,
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 20,
            child: _LogoWidget(),
          ),
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _IconButtonBgWidget(
                  icon: Icons.arrow_back,
                  color: ColorsApp.colorTitle,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, MyRoutes.rLOCALS);
                  },
                ),
                _IconButtonBgWidget(
                  icon: Icons.favorite_border,
                  color: ColorsApp.colorSecondary,
                )
              ],
            ),
          )
        ],
      ),
    );
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
          icon: Image.asset(
            'assets/contact/$contact.png',
            height: 22,
            width: 22,
            fit: BoxFit.cover,
          )),
    );
  }
}

class _IconAndTextWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? color;
  final Color? colorText;

  const _IconAndTextWidget({
    Key? key,
    required this.text,
    required this.icon,
    this.color,
    this.colorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color colorIcon = color ?? ColorsApp.colorText;
    Color _colorText = colorText ?? ColorsApp.colorText;

    return Row(
      children: [
        Icon(
          icon,
          color: colorIcon,
          size: 17,
        ),
        const SpaceWidth(5),
        TextWidget(
          text,
          color: _colorText,
        )
      ],
    );
  }
}

class _IconButtonBgWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Function()? onPressed;

  const _IconButtonBgWidget({
    Key? key,
    required this.icon,
    required this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 16,
        backgroundColor: ColorsApp.colorLight,
        child: IconButton(
          onPressed: () => onPressed == null ? null : onPressed!(),
          icon: Icon(
            icon,
            size: 17,
            color: color,
          ),
        ));
  }
}

class _LogoWidget extends StatelessWidget {
  const _LogoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: 60,
      decoration: BoxDecoration(
          color: ColorsApp.colorLight, borderRadius: BorderRadius.circular(9)),
      padding: const EdgeInsets.all(2),
      child: const ImageNetworkRoundedWidget(
        radius: 9,
        url:
            'https://img.freepik.com/vector-premium/concepto-logo-panaderia-retro_23-2148469649.jpg',
      ),
    );
  }
}
