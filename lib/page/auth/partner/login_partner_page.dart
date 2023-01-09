import 'package:flutter/material.dart';
import 'package:horno/page/auth/partner/register_partner_page.dart';
import 'package:horno/provider/index.dart';
import 'package:horno/provider/provider_login.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/services/index.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';

class LoginPartnerPage extends StatefulWidget {
  const LoginPartnerPage({Key? key}) : super(key: key);

  @override
  State<LoginPartnerPage> createState() => _LoginPartnerPageState();
}

class _LoginPartnerPageState extends State<LoginPartnerPage> {
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TitleWidget(
                    'Bienvenido',
                    fontSize: 36,
                    color: ColorsApp.colorPrimary,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextWidget('¿No eres socio?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegisterPartnerPage()),
                          );
                        },
                        child: TextWidget('Registrate',
                            color: ColorsApp.colorPrimary),
                      ),
                    ],
                  ),
                  _LoginForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  bool _ispassword = true;
  double spaceHeight = 30;
  void _viewpassword() {
    setState(() {
      _ispassword = !_ispassword; //Sera igual a la diferencia de _ispassword
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<ProviderLogin>(context);

    return SizedBox(
      child: Form(
        key: loginProvider.formKey,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Tu email',
                  style: TextStyle(
                      color: ColorsApp.colorTitle,
                      fontWeight: FontWeight.bold,
                      fontSize: Medidas.mysize),
                ),
              ],
            ),
            TextFormField(
              autofocus: false,
              cursorColor: ColorsApp.colorTitle,
              style: TextStyle(color: ColorsApp.colorBlack),
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: DecorationTextFormField2(
                hinttext: 'your@business.com',
              ),
              //Enviar los datos al provider
              onChanged: (value) => loginProvider.email = value,
              //VALIDACIÓN
              validator: (value) {
                RegExp regExp = RegExp(RulesApp.emailRule);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'No es un correo valido';
              },
              //VALIDACIÓN
              //Enviar los datos al provider
            ),
            SpaceHeight(spaceHeight),
            Row(
              children: [
                Text(
                  'Contraseña',
                  style: TextStyle(
                      color: ColorsApp.colorTitle,
                      fontWeight: FontWeight.bold,
                      fontSize: Medidas.mysize),
                ),
              ],
            ),
            TextFormField(
              cursorColor: ColorsApp.colorTitle,
              style: TextStyle(color: ColorsApp.colorBlack),
              autocorrect: false,
              obscureText: _ispassword,
              keyboardType: TextInputType.visiblePassword,
              decoration: DecorationTextFormField2(
                hinttext: 'Ingrese su contraseña',
                suffixIcon: InkWell(
                  onTap: _viewpassword,
                  child: Icon(
                      _ispassword ? Icons.visibility : Icons.visibility_off),
                ),
              ),
              //Enviar los datos al provider
              onChanged: (value) => loginProvider.password = value,
              //Enviar los datos al provider
              //VALIDACIÓN
              validator: (value) {
                return (value != null && value.length >= 8)
                    ? null
                    : 'La contraseña debe tener 8 caracteres';
              },
              //VALIDACIÓN
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
                onPressed: loginProvider.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();

                        if (!loginProvider.isValidForm()) return;

                        loginProvider.isLoading = true;
                        final service =
                            Provider.of<PartnerService>(context, listen: false);
                        final res = await service.login(
                            loginProvider.email, loginProvider.password);
                        loginProvider.isLoading = false;
                        if (res != null) {
                          NotificationsService.showSnackbar(res,
                              state: StateNotification.error);
                        } else {
                          NotificationsService.showSnackbar('Bienvenido');
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacementNamed(
                              context, MyRoutes.rHOME_PARTNER);
                        }
                      },
                child: (loginProvider.isLoading)
                    ? CircularProgressIndicator(
                        color: ColorsApp.colorSuccess,
                      )
                    : Text(
                        'Iniciar Sesión',
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

InputDecoration DecorationTextFormField2({
  final String? hinttext,
  final Widget? suffixIcon,
}) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: ColorsApp.colorPrimary),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.5, color: ColorsApp.colorPrimary),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: ColorsApp.colorError),
      borderRadius: BorderRadius.circular(10),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: ColorsApp.colorError),
      borderRadius: BorderRadius.circular(10),
    ),
    filled: true,
    fillColor: Colors.white,
    hintText: hinttext,
    suffixIcon: suffixIcon,
    hintStyle: TextStyle(color: ColorsApp.colorText),
  );
}
