import 'package:url_launcher/url_launcher.dart' as ul;

extension MusicPlayerExtensionOnInt on int {
  String toDuration() {
    final seconds = this;
    final m = (seconds / 60).ceil();
    final s = (seconds % 60);
    return '${m >= 10 ? m : '0$m'}:${s >= 10 ? s : '0$s'}';
  }
}

extension ImagesTypes on String {
  String get getPngPath => 'assets/images/png/${this}.png';
  String get getJpgPath => 'assets/images/jpg/${this}.jpg';
  String get getSvgPath => 'assets/images/svg/${this}.svg';
}

extension UrlLauncher on Uri {
  Future<void> launchUrl() async {
    if (await ul.canLaunchUrl(this)) {
      await ul.launchUrl(this);
    } else {
      throw 'Could not launch $this';
    }
  }
}
