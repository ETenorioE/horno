import 'package:flutter/material.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/widgets/index.dart';

class RegisterServicesPage extends StatefulWidget {
  const RegisterServicesPage({super.key});

  @override
  State<RegisterServicesPage> createState() => _RegisterServicesPageState();
}

class _RegisterServicesPageState extends State<RegisterServicesPage>
    with RenderPage {
  double spaceHeight = 10;
  double spaceWidget = 15;

  @override
  Widget build(BuildContext context) {
    return ThemeCustomWidget(
      child: Scaffold(
        appBar: appBarRender(
            title: 'Crear servicio',
            leading: backLeadingRender(context, MyRoutes.rMY_SERVICES)),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                TitleWidget('Nombre', fontSize: 16),
                SpaceHeight(spaceHeight),
                TextFormField(
                  autofocus: false,
                  cursorColor: ColorsApp.colorTitle,
                  style: TextStyle(color: ColorsApp.colorBlack),
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: decorationTextFormField(
                    hinttext: '',
                  ),
                ),
                SpaceHeight(spaceWidget),
                TitleWidget('Precio', fontSize: 16),
                SpaceHeight(spaceHeight),
                TextFormField(
                  autofocus: false,
                  cursorColor: ColorsApp.colorTitle,
                  style: TextStyle(color: ColorsApp.colorBlack),
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: decorationTextFormField(
                    hinttext: '',
                  ),
                ),
                SpaceHeight(spaceWidget),
                TitleWidget('Imagen', fontSize: 16),
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
                      child: Icon(Icons.photo),
                    ),
                    Positioned(
                      top: -10,
                      right: -10,
                      child: CircleAvatar(
                          backgroundColor: ColorsApp.colorSecondary,
                          child: IconButton(
                              onPressed: () {}, icon: Icon(Icons.add))),
                    )
                  ]),
                ),
              ]),
              ButtonWidget(
                onPressed: () {},
                text: 'Guardar',
              )
            ],
          ),
        ),
      ),
    );
  }
}
