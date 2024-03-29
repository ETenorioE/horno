import 'package:flutter/material.dart';
import 'package:horno/provider/provider_login.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/services/auth_service.dart';
import 'package:horno/services/notifications_service.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';

class RegisterClientScreen extends StatefulWidget {
  const RegisterClientScreen({Key? key}) : super(key: key);

  @override
  State<RegisterClientScreen> createState() => _RegisterClientScreenState();
}

class _RegisterClientScreenState extends State<RegisterClientScreen> {
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
                  Text(
                    'Registro',
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: ColorsApp.colorPrimary),
                  ),
                  ChangeNotifierProvider(
                    create: (context) => ProviderLogin(),
                    child: _LoginForm(),
                  ),
                  const SpaceHeight(10),
                  const DescriptionActionWidget(
                      description: 'Ya eres usuario?',
                      actionText: 'Inicie Sesion',
                      route: MyRoutes.rLOGIN),
                  Divider(
                    height: 100,
                    thickness: 4,
                    color: ColorsApp.colorText,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 35,
                            width: 35,
                            child: IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {},
                                icon: Image.asset(
                                  'assets/images/google.png',
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Text(
                            'Google',
                            style: TextStyle(
                                color: ColorsApp.colorText,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 35,
                            width: 35,
                            child: IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {},
                                icon: Image.asset(
                                  'assets/images/facebook2.png',
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Text(
                            'Facebook',
                            style: TextStyle(
                                color: ColorsApp.colorText,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ],
                      ),
                    ],
                  ),
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

class _LoginFormState extends State<_LoginForm> with RenderPage {
  bool _ispassword = true;

  void _viewpassword() {
    setState(() {
      _ispassword = !_ispassword; //Sera igual a la diferencia de _ispassword
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<ProviderLogin>(context);
    final authProvider = Provider.of<AuthService>(context, listen: false);
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
                      fontSize: MeasuresApp.mySizeFont),
                ),
              ],
            ),
            TextFormField(
              autofocus: true,
              cursorColor: ColorsApp.colorTitle,
              style: TextStyle(color: ColorsApp.colorBlack),
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: decorationTextFormField(
                hintText: 'your@email.com',
              ),
              //Enviar los datos al provider
              onChanged: (value) => loginProvider.email = value,
              //VALIDACIÓN
              validator: (value) {
                String caracteres =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(caracteres);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'No es un correo valido';
              },
              //VALIDACIÓN
              //Enviar los datos al provider
            ),
            const SpaceHeight(10),
            Row(
              children: [
                Text(
                  'Contraseña',
                  style: TextStyle(
                      color: ColorsApp.colorTitle,
                      fontWeight: FontWeight.bold,
                      fontSize: MeasuresApp.mySizeFont),
                ),
              ],
            ),
            TextFormField(
              cursorColor: ColorsApp.colorTitle,
              style: TextStyle(color: ColorsApp.colorBlack),
              autocorrect: false,
              obscureText: _ispassword,
              keyboardType: TextInputType.visiblePassword,
              decoration: decorationTextFormField(
                hintText: 'Ingrese su contraseña',
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
            const SpaceHeight(10),
            Row(
              children: [
                Text(
                  'Confirmar Contraseña',
                  style: TextStyle(
                      color: ColorsApp.colorTitle,
                      fontWeight: FontWeight.bold,
                      fontSize: MeasuresApp.mySizeFont),
                ),
              ],
            ),
            TextFormField(
              cursorColor: ColorsApp.colorTitle,
              style: TextStyle(color: ColorsApp.colorBlack),
              autocorrect: false,
              obscureText: _ispassword,
              keyboardType: TextInputType.visiblePassword,
              decoration: decorationTextFormField(
                hintText: 'Confirmar su contraseña',
                suffixIcon: InkWell(
                  onTap: _viewpassword,
                  child: Icon(
                      _ispassword ? Icons.visibility : Icons.visibility_off),
                ),
              ),
              //Enviar los datos al provider
              onChanged: (value) => loginProvider.confirmationPassword = value,
              //Enviar los datos al provider
              //VALIDACIÓN
              validator: (value) {
                return (value != null && value.length >= 8)
                    ? null
                    : 'La contraseña debe tener 8 caracteres';
              },
              //VALIDACIÓN
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 58,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(MeasuresApp.myBorderButton),
                ),
                disabledColor: ColorsApp.colorPrimary,
                elevation: 1,
                color: ColorsApp.colorSecondary,
                onPressed: loginProvider.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();

                        if (!loginProvider.isSamePassword()) {
                          NotificationsService.showSnackbar(
                              'La contraseñas no coinciden',
                              state: StateNotification.error);
                          return;
                        }

                        if (!loginProvider.isValidForm()) return;

                        loginProvider.isLoading = true;

                        final res = await authProvider.createUser(
                            loginProvider.email, loginProvider.password);

                        loginProvider.isLoading = false;

                        if (res == null) {
                          NotificationsService.showSnackbar(
                              'Registrado Correctamente');
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacementNamed(
                              context, MyRoutes.rLOCALS);
                        } else {
                          NotificationsService.showSnackbar(res,
                              state: StateNotification.error);
                        }

                        //
                      },
                child: (loginProvider.isLoading)
                    ? CircularProgressIndicator(
                        color: ColorsApp.colorSuccess,
                      )
                    : Text(
                        'Registrar',
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
