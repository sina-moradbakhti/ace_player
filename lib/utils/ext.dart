extension MusicPlayerExtensionOnInt on int {
  String toDuration() {
    final seconds = this;
    final m = (seconds / 60).ceil();
    final s = (seconds % 60);
    return '${m > 10 ? m : '0$m'}:${s > 10 ? s : '0$s'}';
  }
}
