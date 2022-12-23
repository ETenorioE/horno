import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LauncherProvider extends ChangeNotifier {
  bool isVisible = false;

  //Mapas
  void goMapLauncher() async {
    String url = 'https://goo.gl/maps/RmLnyaudnJ9D7pMs5';
    String urlEncode = Uri.encodeFull(url);
    if (await canLaunchUrlString(urlEncode)) {
      await launchUrlString(
        urlEncode,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  //Email
  void goEmailLauncher() async {
    String email = 'tenor.eduardo7@gmail.com';
    String subjet = 'URL launcher Horno';
    String msg = 'Testeando la funcionalidad del url launcher';

    String urlEncode =
        Uri.encodeFull('mailto:$email?subject?$subjet&body=$msg');
    //
    if (await canLaunchUrlString(urlEncode)) {
      await launchUrlString(
        urlEncode,
        mode: LaunchMode.externalApplication,
      );
    }
    //
  }

  //Browser
  void goBrowserLauncher() async {
    String url = 'https://gist.github.com/ETenorioE';
    String urlEncode = Uri.encodeFull(url);
    //
    if (await canLaunchUrlString(urlEncode)) {
      await launchUrlString(
        urlEncode,
        mode: LaunchMode.externalApplication,
      );
    }
    //
  }

  //Phone
  void goPhoneLauncher() async {
    String phone = '+51902870396';
    String url = 'tel:$phone';
    //
    if (await canLaunchUrlString(url)) {
      await launchUrlString(
        url,
      );
    }
    //
  }

  //Whatsapp
  void goWhatsappLauncher() async {
    String phone = '+51902870396';
    String msg = 'Mensaje desde el horno';
    String urlEncode = Uri.encodeFull('https://wa.me/$phone?text=$msg');
    //
    if (await canLaunchUrlString(urlEncode)) {
      await launchUrlString(
        urlEncode,
        mode: LaunchMode.externalApplication,
      );
    }
    //
  }

//Instagram
  void goInstagram() async {
    String nativeUrl = "instagram://user?username=eduardo_tenorio7";
    String webUrl = "https://www.instagram.com/eduardo_tenorio7";
    try {
      await launchUrlString(nativeUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      await launchUrlString(webUrl, mode: LaunchMode.platformDefault);
    }
  }

  //Facebook
  void goFacebook() async {
    String WebUrl = "https://www.facebook.com/eduardo.tenorio.357/";
    String nativeUrl =
        "fb://profile/408834569303957"; //Funciona la idea es saber el ID
    // String nativeUrl = "fb://facewebmodal/f?href";
    try {
      await launchUrlString(nativeUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      await launchUrlString(WebUrl, mode: LaunchMode.platformDefault);
    }
  }
}
