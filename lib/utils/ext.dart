extension MusicPlayerExtensionOnInt on int {
  String toDuration() {
    final seconds = this;
    return '${(seconds / 60).ceil()}:${(seconds % 60)}';
  }
}
