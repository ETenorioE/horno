import 'package:flutter/material.dart';
import 'package:horno/provider/index.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/services/index.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';

class FormLoginWidget extends StatefulWidget {
  @override
  State<FormLoginWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<FormLoginWidget> with RenderPage {
  bool _isPassword = true;

  void _viewPassword() {
    setState(() {
      _isPassword = !_isPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<ProviderLogin>(context);
    return Form(
      key: loginProvider.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget('Tu email', color: ColorsApp.colorTitle),
          const SpaceHeight(10),
          TextFormField(
            cursorColor: ColorsApp.colorTitle,
            style: TextStyle(color: ColorsApp.colorBlack),
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: decorationTextFormField(
              hintText: 'your@email.com',
            ),
            onChanged: (value) => loginProvider.email = value,
            validator: (value) {
              RegExp regExp = RegExp(RulesApp.emailRule);
              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'No es un correo valido';
            },
          ),
          const SpaceHeight(20),
          TextWidget('Contraseña', color: ColorsApp.colorTitle),
          const SpaceHeight(10),
          TextFormField(
            cursorColor: ColorsApp.colorTitle,
            style: TextStyle(color: ColorsApp.colorBlack),
            autocorrect: false,
            obscureText: _isPassword,
            keyboardType: TextInputType.visiblePassword,
            decoration: decorationTextFormField(
              hintText: 'Ingrese su contraseña',
              suffixIcon: InkWell(
                onTap: _viewPassword,
                child:
                    Icon(_isPassword ? Icons.visibility : Icons.visibility_off),
              ),
            ),
            onChanged: (value) => loginProvider.password = value,
            validator: (value) {
              return (value != null && value.length >= 8)
                  ? null
                  : 'La contraseña debe tener 8 caracteres';
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ButtonLoadingWidget(
              text: 'Iniciar Sesion',
              isLoading: loginProvider.isLoading,
              onPressed: loginProvider.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      if (!loginProvider.isValidForm()) return;

                      loginProvider.isLoading = true;

                      final res = await loginProvider.login(
                          loginProvider.email, loginProvider.password);

                      loginProvider.isLoading = false;

                      if (res == null) {
                        NotificationsService.showSnackbar('Bienvenido');
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(
                            context, MyRoutes.rLOCALS);
                      } else {
                        NotificationsService.showSnackbar(res,
                            state: StateNotification.error);
                      }
                    })
        ],
      ),
    );
  }
}
