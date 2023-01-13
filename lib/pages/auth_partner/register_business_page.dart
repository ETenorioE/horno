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
              left: MeasuresApp.myPadding,
              right: MeasuresApp.myPadding,
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
                hintText: 'Panederia Flores',
              ),
              onChanged: (value) => provider.businessName = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'El nombre debe tener 6 caracteres';
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
                  hintText: 'Av Principal, Huamanga, Ayacucho'),
              onChanged: (value) => provider.businessAddress = value,
              validator: (value) {
                return value == null ? 'La dirección es requerida' : null;
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

              onChanged: (value) => provider.businessOfficeHours = value,
              decoration: decorationTextFormField(hintText: '8:00 a 16:00'),
              validator: (value) {
                return value == null
                    ? 'El horario de atención es requerida'
                    : null;
                ;
              },
              //VALIDACIÓN
            ),
            SpaceHeight(spaceHeight),
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
                onPressed: provider.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();

                        if (!provider.isValidForm()) return;

                        provider.isLoading = true;
                        final res = await provider.createLocal(
                          name: provider.businessName,
                          address: provider.businessAddress,
                          officeHours: provider.businessOfficeHours,
                        );
                        provider.isLoading = false;
                        if (res == null) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacementNamed(
                              context, MyRoutes.rHomePartner);
                          NotificationsService.showSnackbar('Bienvenido');
                        } else {
                          NotificationsService.showSnackbar(res,
                              state: StateNotification.error);
                        }
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
