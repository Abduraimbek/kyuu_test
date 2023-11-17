import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Future<String?> callPhoneNumber(String phoneNumber) async {
  try {
    await launchUrl(Uri.parse('tel:$phoneNumber'));
    return null;
  } catch (err) {
    return err.toString();
  }
}

void shareApp() {
  Share.share('Hi! This message is from the KYUU Application');
}
