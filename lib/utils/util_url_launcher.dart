import 'package:url_launcher/url_launcher.dart';

import '../app.dart';
import 'dialogs.dart';

class UtilURLLauncher {
  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      await launchUrl(launchUri);
    } catch (e) {
      errorDialog(getItContext!, e.toString());
    }
  }
}
