import 'package:get/get.dart';
import 'package:mvvm_architecture_template/core/helpers/snack_bar_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchUrl {
  static launch({required String url, LaunchMode? mode}) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: mode ?? LaunchMode.externalApplication,
      );
    } else {
      SnackBarHelper.showError('${'couldNotLaunch'.tr} $url');
    }
  }
}
