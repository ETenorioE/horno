import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:horno/provider/index.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';

class RegisterServicesPage extends StatefulWidget {
  const RegisterServicesPage({super.key});

  @override
  State<RegisterServicesPage> createState() => _RegisterServicesPageState();
}

class _RegisterServicesPageState extends State<RegisterServicesPage>
    with RenderPage {
  double spaceHeight = 10;
  double spaceWidget = 15;
  final _formKey = GlobalKey<FormState>();
  bool isImageNull = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PartnerServicesProvider>(context);

    return ThemeCustomWidget(
      child: Scaffold(
        appBar: appBarRender(
            title: 'Crear servicio',
            leading: backLeadingRender(context, MyRoutes.rMyServices)),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleWidget('Nombre', fontSize: 16),
                          SpaceHeight(spaceHeight),
                          TextFormField(
                            onChanged: (value) => provider.name = value,
                            validator: (value) {
                              return (value != null && value.length >= 5)
                                  ? null
                                  : 'El nombre del servicio debe de tener más de 5 caracteres';
                            },
                            autofocus: false,
                            cursorColor: ColorsApp.colorTitle,
                            style: TextStyle(color: ColorsApp.colorBlack),
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            decoration: decorationTextFormField(
                              hintText: 'Hornear pavo',
                            ),
                          ),
                          SpaceHeight(spaceWidget),
                          const TitleWidget('Precio', fontSize: 16),
                          SpaceHeight(spaceHeight),
                          TextFormField(
                            onChanged: (value) =>
                                provider.price = double.tryParse(value) ?? 0,
                            validator: (value) {
                              if (value == "") {
                                return 'El precio no puede estar vacio';
                              }

                              final price = double.tryParse(value!) ?? 0;
                              return price > 0
                                  ? null
                                  : 'El precio no tiene el formato correcto';
                            },
                            autofocus: false,
                            cursorColor: ColorsApp.colorTitle,
                            style: TextStyle(color: ColorsApp.colorBlack),
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            decoration: decorationTextFormField(
                              hintText: '5.0',
                            ),
                          ),
                          SpaceHeight(spaceWidget),
                          const TitleWidget('Imagen', fontSize: 16),
                          SpaceHeight(spaceHeight),
                          Center(
                            child: Stack(clipBehavior: Clip.none, children: [
                              Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: ColorsApp.colorPrimary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: provider.file == null
                                    ? Icon(
                                        Icons.photo,
                                        size: 50,
                                        color: ColorsApp.colorLight,
                                      )
                                    : Image.file(
                                        provider.file!,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Positioned(
                                top: -10,
                                right: -10,
                                child: CircleAvatar(
                                    backgroundColor: ColorsApp.colorSecondary,
                                    child: IconButton(
                                        onPressed: () {
                                          provider.activeGalleryImage();
                                        },
                                        icon: Icon(Icons.add))),
                              )
                            ]),
                          ),
                          Visibility(
                            visible: isImageNull,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Center(
                                child: TextWidget(
                                    'Debes de seleccionar una imagen',
                                    fontSize: 12,
                                    isFontWeight: false,
                                    color: ColorsApp.colorError),
                              ),
                            ),
                          ),
                        ]),
                    ButtonLoadingWidget(
                      isLoading: provider.isLoading,
                      onPressed: provider.isLoading
                          ? null
                          : () async {
                              FocusScope.of(context).unfocus();
                              if (!_formKey.currentState!.validate()) return;
                              if (provider.file == null) {
                                setState(() {
                                  isImageNull = true;
                                });
                                return;
                              }
                              provider.isLoading = true;
                              final res = await provider.save(context);

                              provider.isLoading = false;
                              if (res == null) {
                                EasyLoading.instance.backgroundColor =
                                    ColorsApp.colorSuccess;

                                EasyLoading.showSuccess('Servicio Registrado');

                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacementNamed(
                                    context, MyRoutes.rMyServices);
                              } else {
                                EasyLoading.instance.backgroundColor =
                                    ColorsApp.colorError;

                                EasyLoading.showError(res);
                              }
                            },
                      text: 'Guardar',
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
