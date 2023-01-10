import 'package:flutter/material.dart';
import 'package:horno/page/auth/widgets/form_login_widget.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/widgets/index.dart';

class LoginClientPage extends StatefulWidget {
  const LoginClientPage({Key? key}) : super(key: key);

  @override
  State<LoginClientPage> createState() => _LoginClientPageState();
}

class _LoginClientPageState extends State<LoginClientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsApp.colorLight,
        body: GestureDetector(
            onTap: () {
              final FocusScopeNode focus = FocusScope.of(context);
              if (!focus.hasPrimaryFocus && focus.hasFocus) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
            },
            child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Center(
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                      TitleWidget('Bienvenido',
                          fontSize: 36, color: ColorsApp.colorPrimary),
                      const DescriptionActionWidget(
                        description: '¿No tienes una cuenta?',
                        actionText: 'Registrate',
                        route: MyRoutes.rRegisterClient,
                      ),
                      FormLoginWidget(),
                      Divider(
                          height: 100,
                          thickness: 2,
                          color: ColorsApp.colorText),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            _ImageTextButtonWidget(
                                asset: 'google', text: 'Google'),
                            _ImageTextButtonWidget(
                                text: 'Facebook', asset: 'facebook2')
                          ])
                    ]))))));
  }
}

class _ImageTextButtonWidget extends StatelessWidget {
  final String text;
  final String asset;
  const _ImageTextButtonWidget({
    Key? key,
    required this.text,
    required this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 35,
          width: 35,
          child: IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {},
              icon: Image.asset('assets/images/$asset.png',
                  height: 30, width: 30, fit: BoxFit.cover)),
        ),
        TextWidget(text, fontSize: 17),
      ],
    );
  }
}
