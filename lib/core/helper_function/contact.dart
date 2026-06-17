import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactHelper{
  static void launchLink(String link) async {
    await launchUrl(Uri.parse(link));
  }

  static void openWhatsApp(String phone,String phoneCode) {
    if (phone.startsWith('+')) {
      phone = phone.substring(1);
    }
    if (phone.startsWith('0')) {
      phone = phone.substring(1);
    }
    launchLink('https://wa.me/+$phoneCode$phone');
  }

  static void openTelegram(String phone) {
    launchLink('https://telegram.me/$phone');
  }

  static void callPhone(String phone,String phoneCode) {
    if (phone.startsWith('0')) {
      phone = phone.substring(1);
    }

    launchLink('tel:+$phoneCode$phone');
  }

  void sendEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(
        emailLaunchUri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      debugPrint('Could not launch email client');
    }

  }
}
