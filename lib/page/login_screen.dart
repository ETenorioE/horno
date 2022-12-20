import 'package:flutter/material.dart';
import 'package:horno/page/index.dart';
import 'package:horno/theme/theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.colorLight,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            left: Medidas.mypadding,
            right: Medidas.mypadding,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bienvenido',
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: ColorsApp.colorPrimary),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿No tienes una cuenta?',
                      style: TextStyle(
                        color: ColorsApp.colorText,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Registrate',
                        style: TextStyle(
                            color: ColorsApp.colorPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Form(
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
                        autofocus: true,
                        cursorColor: ColorsApp.colorTitle,
                        style: TextStyle(color: ColorsApp.colorBlack),
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: DecorationTextFormField(
                          hinttext: 'your@email.com',
                        ),
                      ),
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
                        keyboardType: TextInputType.text,
                        decoration: DecorationTextFormField(
                          hinttext: 'Ingrese su contraseña',
                        ),
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
                                BorderRadius.circular(Medidas.myborderbutton),
                          ),
                          // disabledColor: ColorsApp.colorPrimary,
                          disabledColor: Colors.red,
                          elevation: 1,
                          color: ColorsApp.colorPrimary,
                          child: Text(
                            'Iniciar Sesion',
                            style: TextStyle(
                                fontSize: 30, color: ColorsApp.colorLight),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LocalsPage()),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
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
                                'assets/contact/facebook.png',
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
                                'assets/contact/facebook.png',
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
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration DecorationTextFormField({
    final String? hinttext,
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
        hintStyle: TextStyle(color: ColorsApp.colorText));
  }
}
