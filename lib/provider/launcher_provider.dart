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
  //
}
