import 'package:flutter/material.dart';
import 'package:horno/provider/index.dart';
import 'package:horno/provider/provider_login.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/services/auth_service.dart';
import 'package:horno/services/notifications_service.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';

class RegisterBusinessPage extends StatefulWidget {
  const RegisterBusinessPage({Key? key}) : super(key: key);

  @override
  State<RegisterBusinessPage> createState() => _RegisterBusinessPageState();
}

class _RegisterBusinessPageState extends State<RegisterBusinessPage> {
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
            padding: EdgeInsets.only(
              left: Medidas.mypadding,
              right: Medidas.mypadding,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TitleWidget('Registro de negocio', fontSize: 36),
                  const SpaceHeight(10),
                  _BusinessForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BusinessForm extends StatefulWidget {
  @override
  State<_BusinessForm> createState() => _BusinessFormState();
}

class _BusinessFormState extends State<_BusinessForm> with RenderPage {
  double spaceHeight = 10;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PartnerAuthProvider>(context);

    return SizedBox(
      child: Form(
        key: provider.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWidget('Negocio', color: ColorsApp.colorTitle, fontSize: 16),
            const SpaceHeight(5),
            TextFormField(
              autofocus: false,
              cursorColor: ColorsApp.colorTitle,
              style: TextStyle(color: ColorsApp.colorBlack),
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: decorationTextFormField(
                hinttext: 'Panederia Flores',
              ),
              onChanged: (value) => provider.email = value,
              validator: (value) {
                return (value != null && value.length >= 8)
                    ? null
                    : 'El nombre debe tener 8 caracteres';
              },
              //VALIDACIÓN
              //Enviar los datos al provider
            ),
            SpaceHeight(spaceHeight),
            TitleWidget('Direccion', color: ColorsApp.colorTitle, fontSize: 16),
            const SpaceHeight(5),
            TextFormField(
              cursorColor: ColorsApp.colorTitle,
              style: TextStyle(color: ColorsApp.colorBlack),
              autocorrect: false,
              decoration: decorationTextFormField(
                  hinttext: 'Av Principal, Huamanga, Ayacucho'),
              keyboardType: TextInputType.visiblePassword,
              onChanged: (value) => provider.password = value,
              validator: (value) {
                return (value != null && value.length >= 20)
                    ? null
                    : 'La direccion debe tener 20 caracteres';
              },
            ),
            SpaceHeight(spaceHeight),
            TitleWidget('Horario de atencion',
                color: ColorsApp.colorTitle, fontSize: 16),
            const SpaceHeight(5),
            TextFormField(
              cursorColor: ColorsApp.colorTitle,
              style: TextStyle(color: ColorsApp.colorBlack),
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              onChanged: (value) => provider.confirmationPassword = value,
              decoration: decorationTextFormField(hinttext: '8:00 a 16:00'),
              validator: (value) {
                return (value != null && value.length >= 12)
                    ? null
                    : 'La horario debe tener 12 caracteres';
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
                onPressed: provider.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();

                        if (!provider.isValidForm()) return;

                        provider.isLoading = true;
                        Navigator.pushReplacementNamed(
                            context, MyRoutes.rHOME_PARTNER);
                        provider.isLoading = false;
                      },
                child: (provider.isLoading)
                    ? CircularProgressIndicator(
                        color: ColorsApp.colorSuccess,
                      )
                    : Text(
                        'Terminar',
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
