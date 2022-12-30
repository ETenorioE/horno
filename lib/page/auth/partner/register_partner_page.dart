import 'package:flutter/material.dart';
import 'package:horno/page/index.dart';
import 'package:horno/provider/index.dart';
import 'package:horno/provider/provider_login.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/services/auth_service.dart';
import 'package:horno/services/notifications_service.dart';
import 'package:horno/theme/theme.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';

class RegisterPartnerPage extends StatefulWidget {
  const RegisterPartnerPage({Key? key}) : super(key: key);

  @override
  State<RegisterPartnerPage> createState() => _RegisterPartnerPageState();
}

class _RegisterPartnerPageState extends State<RegisterPartnerPage> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<ProviderLogin>(context);

    return Scaffold(
        backgroundColor: ColorsApp.colorLight,
        body: GestureDetector(
            onTap: () {
              final FocusScopeNode focus = FocusScope.of(context);
              if (!focus.hasPrimaryFocus && focus.hasFocus) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
            },
            child: Center(
                child: Padding(
                    padding: EdgeInsets.only(
                      left: Medidas.mypadding,
                      right: Medidas.mypadding,
                    ),
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          const TitleWidget('Registro de socio', fontSize: 36),
                          const SpaceHeight(10),
                          _PartnerUserForm(),
                        ]))))));
  }
}

class _PartnerUserForm extends StatefulWidget {
  @override
  State<_PartnerUserForm> createState() => _PartnerUserFormState();
}

class _PartnerUserFormState extends State<_PartnerUserForm> with RenderPage {
  bool _ispassword = true;
  double spaceHeight = 10;
  final _formKey = GlobalKey<FormState>();

  void _viewpassword() {
    setState(() {
      _ispassword = !_ispassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PartnerAuthProvider>(context);

    return SizedBox(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWidget('Email',
                color: ColorsApp.colorTitle, fontSize: Medidas.mysize),
            const SpaceHeight(5),
            TextFormField(
              autofocus: false,
              cursorColor: ColorsApp.colorTitle,
              style: TextStyle(color: ColorsApp.colorBlack),
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: decorationTextFormField(
                hinttext: 'your@business.com',
              ),
              onChanged: (value) => provider.email = value,
              validator: (value) {
                RegExp regExp = RegExp(RulesApp.emailRule);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'No es un correo valido';
              },
            ),
            SpaceHeight(spaceHeight),
            TitleWidget(
              'Contraseña',
              color: ColorsApp.colorTitle,
              fontSize: Medidas.mysize,
            ),
            const SpaceHeight(5),
            TextFormField(
              cursorColor: ColorsApp.colorTitle,
              style: TextStyle(color: ColorsApp.colorBlack),
              autocorrect: false,
              obscureText: _ispassword,
              keyboardType: TextInputType.visiblePassword,
              decoration: decorationTextFormField(
                hinttext: 'Ingrese su contraseña',
                suffixIcon: InkWell(
                  onTap: _viewpassword,
                  child: Icon(
                      _ispassword ? Icons.visibility : Icons.visibility_off),
                ),
              ),
              onChanged: (value) => provider.password = value,
              validator: (value) {
                return (value != null && value.length >= 8)
                    ? null
                    : 'La contraseña debe tener 8 caracteres';
              },
            ),
            SpaceHeight(spaceHeight),
            TitleWidget(
              'Confirmar contraseña',
              color: ColorsApp.colorTitle,
              fontSize: Medidas.mysize,
            ),
            const SpaceHeight(5),
            TextFormField(
              cursorColor: ColorsApp.colorTitle,
              style: TextStyle(color: ColorsApp.colorBlack),
              autocorrect: false,
              obscureText: _ispassword,
              keyboardType: TextInputType.visiblePassword,
              decoration: decorationTextFormField(
                hinttext: 'Confirmar su contraseña',
                suffixIcon: InkWell(
                  onTap: _viewpassword,
                  child: Icon(
                      _ispassword ? Icons.visibility : Icons.visibility_off),
                ),
              ),
              onChanged: (value) => provider.confirmationPassword = value,
              validator: (value) {
                return (value != null && value.length >= 8)
                    ? null
                    : 'La contraseña debe tener 8 caracteres';
              },
            ),
            SpaceHeight(spaceHeight),
            SizedBox(
              width: double.infinity,
              height: 58,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Medidas.myborderbutton),
                ),
                disabledColor: ColorsApp.colorPrimary,
                elevation: 1,
                color: ColorsApp.colorSecondary,
                onPressed: provider.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();

                        if (!provider.isSamePassword()) {
                          NotificationsService.showSnackbar(
                              'La contraseñas no coinciden',
                              state: StateNotification.error);
                          return;
                        }

                        if (!_formKey.currentState!.validate()) return;

                        provider.isLoading = true;

                        Future.delayed(const Duration(seconds: 1));

                        provider.isLoading = false;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterBusinessPage()),
                        );
                        //
                      },
                child: (provider.isLoading)
                    ? CircularProgressIndicator(
                        color: ColorsApp.colorSuccess,
                      )
                    : Text(
                        'Continuar',
                        style: TextStyle(
                            color: ColorsApp.colorLight,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
